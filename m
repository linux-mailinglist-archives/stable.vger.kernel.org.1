Return-Path: <stable+bounces-98929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6429E654E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 05:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC388283E4A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADA1946D0;
	Fri,  6 Dec 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P+xqFfYO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4018CBFE
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458244; cv=none; b=nofYjYLuada4hOdFJ8gbPswFggw+vsRhA0MuX4rZZhKrHyGn6AR5K1M25IFosB0Jstk1cCJf3fGJXjgYuFv1z2qizPrskSHI/tFEApuKfEl1pSQsOsUkbO/XvEchRn57FW56KvczbzQEso2rlHwAOYWq1JGVyk49Dm2RMyRLtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458244; c=relaxed/simple;
	bh=V7/lKkhMDAzPFuNdlkfXeN81gLMB4rzzuf0y3yjA3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQ1lg5hCaVrU1z/szoKS6yKOEmt/rNS571zkIcr4Ue7O2Sa3jR3BZHqT5G23Onpxid8/nhYoEYycth7i+ADFhgilh5wdEnkJ/7iYNf45oO70EAOIAzke47Xdk7tg/akwh34sTg88lyeJvYznz2uG30UBW0HJysZL1/D6oeiaus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P+xqFfYO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215564e34acso2354585ad.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458241; x=1734063041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=P+xqFfYOAjcuvi3EQvMz2SobiqR9F3csyExT7dpA4KKoSzC5wZxvmDlY8qtEbuH2Fa
         sAm0alTQbEHpz72FEIzR9hG/3tAO04xGpHk7mKPvPN5tiJltgVWmhleOgIUiy+F/7V06
         tCitc8SaxKVbSnXmMffCae3Fe1edy5TmAvyV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458241; x=1734063041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=L8AFxwCSa0Xz4LA7jRd9FIXfSQfcXuLF1Fq2w0sGHaHdL4ZL0Li0dKZg2ThVg6URGM
         KVX8d0uCbIbEMg46iPx7eHvOVZVgs6GfP8J0yau/txZWVOxoY4Drp1U4hG5eaHLWAC2n
         9ga0Mf7A9a4gpwv628DxRSEegKMtWSE9hN2DUb6F60lSuX/80anTLMRCuteNBd9EeC2h
         NSGRqKNFRMv3gtryUc7L0UKp0nBFoV1HBqnAzghvackbjnvwyRc1opA2wWyRWyQ4FGNv
         SlmFh/rzMbaCDTo3F5O8N+RwKyGslrPQCKjX4HzfLnJqtG4y3TWDDMu9py3RUVwnmWek
         smlw==
X-Gm-Message-State: AOJu0YyeJaE0z8EXVoJnXY2L16Rxyzb01KocCAUYluimOZrCBZU3aVzI
	U5g0zByiwDINW1Aw/rRxKqFgPN97WxVpi/hFY9qy7N8lj0vy6kaw1dVvb0+lztjr/5o+9FtA8bX
	/7ViwCFC8DOsziHAkwocPD76WFdROnQWdpiL6GVgocyrqQT0pDDkByFEOtrvZG305xuomt7OyyV
	dUR7g5sy6kS8XLRHS3gnVQXFz37Ivn7mCHDW4o3IRpGD8aRjhdM6NAjoh2jQd3bz8=
X-Gm-Gg: ASbGncvznVNVKvdpNxxPyJ8/EWh6yi9UqyuaRWO1S6li6HudR0mi512tJ/yax3kCyab
	DNpzBNtUB5tWiUQLhdnfm+x2pyKIqZkQj9wSCYmVYtXKnkIjx1ymosIVMUC3ukIKCOHCdlXwo2c
	9JWtl66jutH6mgXXEED5z8F3zhWnqbESX79YvI+L+LwQR23MdpTkW/NrlNHl78lh3oqPx1s3Dsg
	+29JITofsM/15V+8BVOh3yb76H8iKfXrUZzphzq5sR/z/WJwOiTHotrPgxc+2Qtb9XVKVR6flhv
	KBIB/7soMzrm+YBoIg==
X-Google-Smtp-Source: AGHT+IHIPKNeut07aOTI89zxMd3Vl+EMqCNUz246+xUnyar4QNLZ+a1aZ5TrSWJS1HODt0F85bhzoA==
X-Received: by 2002:a17:902:da8c:b0:215:7ced:9d59 with SMTP id d9443c01a7336-21614de3df3mr8726785ad.12.1733458241448;
        Thu, 05 Dec 2024 20:10:41 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e807sm20053675ad.57.2024.12.05.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:10:41 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 04:10:37 +0000
Message-Id: <20241206041037.4013334-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a..0f686e363 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -664,6 +664,9 @@ static enum bp_result get_ss_info_v3_1(
 
 	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1031,6 +1034,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 
 	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1104,6 +1109,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1631,6 +1638,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1711,6 +1720,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1748,6 +1759,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.39.4


