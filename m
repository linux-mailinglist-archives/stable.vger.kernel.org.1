Return-Path: <stable+bounces-64905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC481943C19
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B56B25542
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358C1A4B57;
	Thu,  1 Aug 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwJrWgXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0214B943;
	Thu,  1 Aug 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471383; cv=none; b=WiIZUi+ZqKAilr5wCGSMXQB8NF7qu+DBBe4tAkqbcIchrD1mdCaSMtufBzowAuBUco1+/dDkAo9Hvr4fXw9sbWQOMwo7Y+PJjShWgHEBfunD6p84HvrukQ/op7vQttE/HWY6rQT9ljZFu1MXI93o20nm/GBskfGhU44rfU3xnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471383; c=relaxed/simple;
	bh=NalIKsMyK2iYXtObGfevdQZYw/GpJOJaN1pzbxhHlR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjvfF/KOY7BUHPeoPuTGsBk0aOkfij4fciv3rm0mgTyHuMq34vmK16/CZojG/XpwdTvMizoY7HsWbA/v25XZp42IdYY8pKUHGf8yjY1VgVZLBdRZKI4EwMTMsn58OayHDPWJVvWjpPA6g+6TUIb2ToyWX2H0dRO7g4bQRIq2oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwJrWgXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13395C32786;
	Thu,  1 Aug 2024 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471383;
	bh=NalIKsMyK2iYXtObGfevdQZYw/GpJOJaN1pzbxhHlR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwJrWgXje+vOgLR8Z2VfvH+R0eatfSC1DmfVb81HIa8f2yueT8M9SHOt+T/o8wSFh
	 rQjug4j+XgDc+2My83bnAm2FgDUnrP9Lv44KH7jevr80R9c/P6LjG22MkG7vUPLAts
	 3yT6KHsSrI2Bm6NnqQWGYn1YsaFRez7KH3I83dd8sjCzIBF/4tCAVyCJKKwgZnY1cU
	 Dyy6+IIPZQLVvZtFEH2OicekzXDsZcrnva+RPaOHnUK0r9exinQsaT4wturxHTkgq8
	 qJHPcztGMtI2vOetf1XyFBeV79yox3OaXX1wbdzHpJMYLNZp4HfiYVjXxmKexYxd1M
	 Mh+2OqiLya8aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hersenxs.wu@amd.com,
	dillon.varone@amd.com,
	ruanjinjie@huawei.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 080/121] drm/amd/display: Check BIOS images before it is used
Date: Wed, 31 Jul 2024 20:00:18 -0400
Message-ID: <20240801000834.3930818-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]

BIOS images may fail to load and null checks are added before they are
used.

This fixes 6 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 25fe1a1240298..3bacf470f7c5b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -665,6 +665,9 @@ static enum bp_result get_ss_info_v3_1(
 	ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1034,6 +1037,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header, asSpreadSpectrum, 1)));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1107,6 +1112,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1634,6 +1641,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1716,6 +1725,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header_include, asSpreadSpectrum, 1)));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1755,6 +1766,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 	header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header_include, asSpreadSpectrum, 1)));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.43.0


