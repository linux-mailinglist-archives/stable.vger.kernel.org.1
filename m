Return-Path: <stable+bounces-99970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16539E76C7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E9C282895
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FCF1F3D49;
	Fri,  6 Dec 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6b8IWBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9C206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505105; cv=none; b=eQoUe7Zti2KomnFuDYDDgVerCDqM/tCWBQdDmLp8ARegFdYHT6thK2UKaq0lkkEy7fYrgrRnWqx337sk1CdCic6LiI2+0CyuCwJvRVLWOusOuhL8bzNpXUnGhjo9o4LyRVG7civ7sDsVWDuHK4hezWA/qOLPvchmjwcs96pyjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505105; c=relaxed/simple;
	bh=IQKBe+hKHynb11dZWtOc3QU5Kr3QF5+eMTKQF/rJEqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDk0uH8z1/3dfd33+mnGvB4fSgWGLAbodB5FvWZgfSQc8ITdum8Hjml6kvNc+GUuFSf5d2U8Cs2sTqnlMDpW8MNZNnyu3c/JqyOj/u+fVwi9gyIvDZsGz0BXlRNZlAbnCM4QkROdkEt6HOpZuBFUBlFN7OvtcU29JZH2S3szwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6b8IWBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AADEC4CEDF;
	Fri,  6 Dec 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505104;
	bh=IQKBe+hKHynb11dZWtOc3QU5Kr3QF5+eMTKQF/rJEqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6b8IWBu/tVbsIcOpI31DMBlD6erNCT+ailDobz6Z9xDvBG17GYKet5QIiLIptNhw
	 /89QWlJWfQFYh3WUcIHex/C4i74t+lWaAFZrEW1E/Zq88msM3p7+occr5DTxj15N+O
	 8F+QfIxvK77hNciNJK+UD7m70erqN+km4cmAYoSrLRgSwcNQhf2v6GvOEvbpB5O05E
	 nAoB7746bH+PFDm/cyi4J0We2jIJk1HGwVkny9ypgQjv+tB2YnfC1+MSfZBPssxSA4
	 et9HjPYRmIOp8AnF3s5V0v+hxzbaPyYLurXwf3ngm70yod/cKeUfiteWPGsrxKwC7E
	 qmn/kCOh4aExg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 12:11:43 -0500
Message-ID: <20241206104607-197c3a79c93b8054@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206041414.4013356-1-keerthana.kalyanasundaram@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Commit author: Alex Hung <alex.hung@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e50bec62acae)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8b0ddf19cca2a ! 1:  3a1c77af30b1b drm/amd/display: Check BIOS images before it is used
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Check BIOS images before it is used
     
    +    [ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]
    +
         BIOS images may fail to load and null checks are added before they are
         used.
     
    @@ Commit message
         Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
     
      ## drivers/gpu/drm/amd/display/dc/bios/bios_parser.c ##
     @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static enum bp_result get_ss_info_v3_1(
    - 	ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
    - 				DATA_TABLES(ASIC_InternalSS_Info),
    - 				struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
    + 
    + 	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
    + 		DATA_TABLES(ASIC_InternalSS_Info));
     +	if (!ss_table_header_include)
     +		return BP_RESULT_UNSUPPORTED;
     +
    @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static enum bp_result get_ss_
      		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
      				- sizeof(ATOM_COMMON_TABLE_HEADER))
     @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
    - 				&bp->base,
    - 				DATA_TABLES(ASIC_InternalSS_Info),
    - 				struct_size(header, asSpreadSpectrum, 1)));
    + 
    + 	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
    + 		DATA_TABLES(ASIC_InternalSS_Info));
     +	if (!header)
     +		return result;
      
    @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static uint32_t get_ss_entry_
      	if (1 != revision.major || 2 > revision.minor)
      		return number;
     @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
    - 				&bp->base,
    - 				DATA_TABLES(ASIC_InternalSS_Info),
    - 				struct_size(header_include, asSpreadSpectrum, 1)));
    + 
    + 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
    + 			DATA_TABLES(ASIC_InternalSS_Info));
     +	if (!header_include)
     +		return 0;
      
      	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
      			- sizeof(ATOM_COMMON_TABLE_HEADER))
     @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
    - 	header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
    - 				DATA_TABLES(ASIC_InternalSS_Info),
    - 				struct_size(header_include, asSpreadSpectrum, 1)));
    + 
    + 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
    + 			DATA_TABLES(ASIC_InternalSS_Info));
     +	if (!header_include)
     +		return number;
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

