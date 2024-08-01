Return-Path: <stable+bounces-65000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C42943D6A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3AF284B05
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E0322A;
	Thu,  1 Aug 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHC5g93J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516D1A4FC1;
	Thu,  1 Aug 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471899; cv=none; b=KdI6UOjOAushR0pXfAIwwKUk1clzfMX2kj9s2ulSjM1r4Q0/TE5wVGuJqXXqRpE99IfKcipHoBkTeg0IvQRqSMk37+5B2BOAFBFI8Dmi+EWDZ8bEG7Mv69mtYOocLdMc69votyln7o2rCXb5A34SUIbWrkbCccQ9ZrIGtJBUxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471899; c=relaxed/simple;
	bh=WMYfw2qOnX89p8Jga3VxchgeM6opSNkDWr4dFD48bn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDnrI6+BM3gwV2+iT2kaKWyTOgVWW6gODBQYvH9eU+gcRR+KQkovv2+On6vF99Nwzg5UW3o7b3808KaTSW6/JoNpd+aXcbofedifXwGsRJhRS0ncYqNTwJIYalyXsPtfOd+RXQ1thLbDBkM4lyMwrurq4kiLckPyjW57vfa601Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHC5g93J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A817C4AF0E;
	Thu,  1 Aug 2024 00:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471899;
	bh=WMYfw2qOnX89p8Jga3VxchgeM6opSNkDWr4dFD48bn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHC5g93J69v2n21W8O9TO6W6G3LyXywCSDueeQF6MQsNqPv9ZZihUhbI3L31DvXIk
	 Jxo2ZPtzAs7+4aaNaNFXMtnSULCSj+9IKWDJ0PDEiPixn7aUOuCpoyV85Z+bLhx0H6
	 yAnrNvGVUf8XKRDSsRzDVBaDI7Kd/1egyFHd+lv0j3s5qki6MOtiVfXuSSah3ZFqur
	 xMk1tv+lS/zoTzZYNytRnB08IMy8gMaMI3HHLSPYlC8a9yZ35rReqOGnfSwl5TL5x9
	 JBmIY9JTIn87y2GVXEAVlTIxGv6s7a+hQLgUk71z3GQGCrDczF+8YHP8OfC0DKADSN
	 3W7IXnJA4/Qgg==
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
	ruanjinjie@huawei.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 54/83] drm/amd/display: Check BIOS images before it is used
Date: Wed, 31 Jul 2024 20:18:09 -0400
Message-ID: <20240801002107.3934037-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 19cd1bd844df9..684b005f564c4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -667,6 +667,9 @@ static enum bp_result get_ss_info_v3_1(
 	ss_table_header_include = ((ATOM_ASIC_INTERNAL_SS_INFO_V3 *) bios_get_image(&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(ss_table_header_include, asSpreadSpectrum, 1)));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1036,6 +1039,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header, asSpreadSpectrum, 1)));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1109,6 +1114,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1636,6 +1643,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1718,6 +1727,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 				&bp->base,
 				DATA_TABLES(ASIC_InternalSS_Info),
 				struct_size(header_include, asSpreadSpectrum, 1)));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1756,6 +1767,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
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


