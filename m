Return-Path: <stable+bounces-98930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE99E6552
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 05:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542F116A5E3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 04:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92B194082;
	Fri,  6 Dec 2024 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QFfIgl9H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1847F4A
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458460; cv=none; b=HwbBc0JzBQD/vhDR1q/8/t/KJYT2tIIwBlvxrixcRxIfPzZ9e+QdZMPka1UhiweJEf0XYAAkH2vRZvf/Y6HbQbGnSxC+RknezM3RyF9r81Plkp64aAVbxiZo8fddlliUsssrF6KtYRPJWyjPSiK32HcqQ2x+8NmwDCT0kj/pNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458460; c=relaxed/simple;
	bh=V7/lKkhMDAzPFuNdlkfXeN81gLMB4rzzuf0y3yjA3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnAu7Ii8S6k5908FLy+ZMJ7j+LqavNtoopTPY3DjaR+BflbZI8hPoDV98UP6hf+y23RxCEJdJlPnwYkuZWOsofYmwTOVdaFiWY2qXtU07BM+8FsUjD8euMxIf4JfuA121FRf+wfDi+CnliW5AJnSecj+i9uz1SAHBJcEVezbUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QFfIgl9H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21589aa7913so2764215ad.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458458; x=1734063258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=QFfIgl9HOrD3S8ikmjypLfL7GjnE8SsI42SfWKr1AfkSV8iKuaIDiN4BEcq4u1iXGz
         w4EwQBhVJbCHyS4NuXTORnjsEZBywhNOxtC7YFtwls9GrP09gPUyRz8LIp3kTMqFO5PT
         z/BykIR541RacDYbHq7USnONE/ngns1XfnzY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458458; x=1734063258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=LjMVzEsTlN9QBg/2POef5aNhCGFCSb+dBORctsobKVMR3nilPmkqs6dY2hpEJGVFcx
         NVefKLt8FAC/6e3NzAXtAIqWefKr/Xc3ujdq0z+rBU8uX2AS/abwZJNiyXw5hw7ehD31
         MLkZyh0GkQZcEsQwp2PkFgkORlGEVgLiOHtg566ZwZ5aFddKeMwixEQXQpXSXY+L79VL
         sVN/gPRPgfV/7VoLMdl7gyRfhU/EH3qfqwEFJjveswnhkqZS4yQrvlQVOb5AgFlln8qQ
         AQmmXxn+BLeGDweRpIix1vEEEVRpsOdyyoLP0HRIQZvh2KIF4Q6su7U1U6fnZVIzdoDZ
         tSRA==
X-Gm-Message-State: AOJu0YzU+Ib9Av/G1IzXRWDxEF2prr2uyC4/NJGw9IuSsviKXQ1tphPU
	2IiBYvzd/0erVzOJLuV/ldGuhE4+38UiIhkzj0+lR3g7blnkZ0SXTcGs6TW+HQvCwu1a3/VIXFQ
	NPjfJELl9+nRPNxi+DjtjeZ3srWSM18nGvEBchRbfOPcBQq+r5UJG7lu+wTu/FBduAPVEt1PHxL
	lqQkmcL8boCDxx+7T45iDDSxBV49d9cSQxzrB7Oe7eAJuezrMAVP8RedQcjMeOkfI=
X-Gm-Gg: ASbGncvOHOba5X/CftLbo9a4I6phgioXBPTtjjE7ffjj21GlK5b6PmE9y9WCf8LSlBk
	O7elMbkQFpGM4a1afcArjou//VhfxsXxRG8YkkOrw+vSo3a3gAS64WtosjwCEqusjMr3LxN++ps
	6Nz6WfKQwmzcjWZxc/ijRIOHCOliLKDDDmyoUD1ZNhMSpKxuzR7zZIhqZE/UyXKCEPV34IbC0ls
	nqt/U5v0rFcu/O4592v8D30offNLDTukqzYo0nYgojtDTYZ7L/P8JEcfwIyENvvvdWQI7kuugm3
	5L8JX7Lo5ehlajsNlRnE8A==
X-Google-Smtp-Source: AGHT+IGLQ1YPW/GMhrOQCuIQu21lc9n4+a2xgkTaktnhXR5veCtx5oSsXukViRHArRUmvP9dHaYNNg==
X-Received: by 2002:a17:902:e88f:b0:215:9a73:6c4f with SMTP id d9443c01a7336-21614d5365fmr7802885ad.6.1733458458137;
        Thu, 05 Dec 2024 20:14:18 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e8afsm20079925ad.18.2024.12.05.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:14:17 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	dillon.varone@amd.com,
	hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 04:14:14 +0000
Message-Id: <20241206041414.4013356-1-keerthana.kalyanasundaram@broadcom.com>
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


