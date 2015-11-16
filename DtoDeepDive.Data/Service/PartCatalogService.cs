﻿using System;
using System.Collections.Generic;
using System.Linq;
using DtoDeepDive.Data.DAL;
using DtoDeepDive.Data.DTO;
using DtoDeepDive.Data.Repository;

namespace DtoDeepDive.Data.Service {
    public class PartCatalogService : IPartCatalogService {
        private readonly IRepository<Part> _partRepository;
        private readonly PartAssembler _partAssembler;
        public PartCatalogService(IRepository<Part> partRepository, PartAssembler partAssembler) {
            _partRepository = partRepository;
            _partAssembler = partAssembler;
        }
        public PartDTO GetPart(string partNumber) {
            var part = _partRepository.Get(x => x.PartNumber == partNumber);
            return _partAssembler.WritePartDto(part);
        }
        public IEnumerable<PartDTO> GetAllParts() {
            var parts = _partRepository.GetAll(x => true).ToList();
            var partDtos = new List<PartDTO>();
            foreach (var part in parts) {
                partDtos.Add(_partAssembler.WritePartDto(part));
            }
            return partDtos;
        }
        public QuoteDTO GetQuote(Dictionary<string, double> selectedItems) {
            var partDtos = new List<PartDTO>();
            foreach (var selectedItem in selectedItems) {
                var part = _partRepository.Get(p => p.PartNumber == selectedItem.Key);
                var partDto = _partAssembler.WritePartDto(part);
                partDto.CalculateTotalCost(selectedItem.Value);
                partDtos.Add(partDto);
            }
            var quoteDto = _partAssembler.WriteQuoteDTO(partDtos);
            quoteDto.CalculateTotalCosts();
            return quoteDto;
        }
    }
    public class PartAssembler {
        public PartDTO WritePartDto(Part part) {
            var partDto = new PartDTO();
            partDto.PartNumber = part.PartNumber;
            partDto.UnitOfMeasure = part.UnitOfMeasure;
            partDto.ExtendedDescription = part.ExtendedDescription;
            partDto.PartDescription = part.PartDescription;
            partDto.SalesCode = part.SalesCode;
            var componentsList = part.Components
                .Select(component => new ComponentDTO() {
                     Number = component.ComponentNumber,
                     Description = component.ComponentDescription,
                     Material = component.Material,
                     UnitOfMeasure = component.UnitOfMeasure,
                     QuantityPerAssembly = component.QuantityPerAssembly,
                     CostPerUnit = component.CostPerUnit
                }).ToList();
            var laborSequenceList = part.LaborSequences
                .Select(labor => new LaborSequenceDTO() {
                    SequenceNumber = labor.LaborSequenceNumber,
                    SequenceDescription = labor.LaborSequenceDesc,
                    RunTime = labor.RunTime,
                    LaborRate = labor.LaborRate,
                    Burden = labor.Burden
                }).ToList();
            partDto.Components = componentsList;
            partDto.Labor = laborSequenceList;

            return partDto;
        }
        public QuoteDTO WriteQuoteDTO(IEnumerable<PartDTO> partDtos) {
            var quoteDto = new QuoteDTO();
            foreach (var part in partDtos) {
                quoteDto.Parts.Add(part);
            }
            return quoteDto;
        }
    }
}