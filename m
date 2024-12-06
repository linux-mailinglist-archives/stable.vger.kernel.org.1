Return-Path: <stable+bounces-99957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441F9E76BA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83BE1624F1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1F1F3D49;
	Fri,  6 Dec 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnr1/1S2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F3206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505078; cv=none; b=ZOcNKVRVjMdDabFG+4O5cicXMhbEWdEW7zPEaQP4SMkPmiDQ5zYt/ET5+O3Hz3hV9ithP9Jy8pSciz/985EH7uYxLWqhmxmg2hHTCpJhwo8bTie16JlJR8+HAlOzOhUEFhxSAaI2Pxk5mBgrj8mTe06MTiwyofV6X2b871hS7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505078; c=relaxed/simple;
	bh=sPeiZToHpi9fWwpFZnvKpqvGbBadJw1qRz1KDxSEjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgCI1UMSTLMd0tTpRZH+jw6PdReA/LSjNBLSPUg2DBP7tn9Tvbs8Lo/dCrTS8qAT+OJRnVTvT5xP+68B2YOZejBjsy74FgUXePw5PnKINGiy//ckgiH8+Qo0nVYa443oxTh062egulRGhyeykN9w+2AupxIoOCTnNU9iukpWYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnr1/1S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6B5C4CED1;
	Fri,  6 Dec 2024 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505078;
	bh=sPeiZToHpi9fWwpFZnvKpqvGbBadJw1qRz1KDxSEjfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnr1/1S2fr5vBIzs1AmABiZ6xJmQtAKz1oI+785QqjpRoS8omzFFVuJD7GzcQkXxB
	 4EUcPvQRnAElH/D4xVLH6Yv3NvqBStmm5orZg2O6IT+0/W+rgUNDyOHVxL7DGhW1hQ
	 dOKz2nijBW/jQzlRYBZn7Y7e4Vb7qPh4hDl/UUxl7rGVghj6j38XAhLxqUcKJmPg7m
	 JAlLVavkRa2vRgq7qOZXumygtbGvqLmsSuEYnIYL7CkxcKhzF+K/Xl/fFZdIwkjOhQ
	 y9xqA8wJolUM8pLeDsGmBaT1akxeARJ0GtIIMNxFct7F9YPO1yjKN/B/ikI+ropayV
	 9YfbbkgayyISg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 12:11:16 -0500
Message-ID: <20241206112932-58020a1a7b48f224@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206041037.4013334-1-keerthana.kalyanasundaram@broadcom.com>
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
1:  8b0ddf19cca2a ! 1:  0de7ee643fde6 drm/amd/display: Check BIOS images before it is used
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

