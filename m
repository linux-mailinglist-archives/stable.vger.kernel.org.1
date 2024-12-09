Return-Path: <stable+bounces-100095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B59E8B33
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 06:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF541885AFA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EC9210180;
	Mon,  9 Dec 2024 05:52:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880020FA99;
	Mon,  9 Dec 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723571; cv=none; b=N8OTTDCtv0A0lR/o47J1sx+o8pZSazcmEq4nvnrYFUOw2Gjt2N9z6OoTcZYGrqx2BerXOBFAzuawnpgJJEtukrMNhNwZG0LPRSZ1GhKMya9cAjjAkLEusBO3XqKA1dkyX4FNqjcHDHNvOYpDdnVHgiPPyMr5aNLf4yGcU7MfL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723571; c=relaxed/simple;
	bh=GDGTPi4d5yIoDO2bhGqiLBL86hh2U9JhaHeZ9Z+T7wc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZyzdKpGSu+i2ZuKIFgZjspEd8Kd2kauiqd9fQ7ANaMwZ82V1C/lUcpYblJKY8l2dOa7T2+Ry8v+bXAsv/xm9yBEX6BrkLgzhS35XpWI63GVpZdaoo2buEJ2qsMfbxmhyW9IjUdLkMvo5cMLcYfftoZ+ZCwKocm8rXmhI/ef1x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B94A6p9012518;
	Sun, 8 Dec 2024 21:52:42 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1s12r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Dec 2024 21:52:42 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 8 Dec 2024 21:52:40 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 8 Dec 2024 21:52:35 -0800
From: <jianqi.ren.cn@windriver.com>
To: <sohaib.nadeem@amd.com>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <wayne.lin@amd.com>, <sashal@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <aurabindo.pillai@amd.com>, <charlene.liu@amd.com>,
        <gabe.teeger@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Mon, 9 Dec 2024 14:50:28 +0800
Message-ID: <20241209065028.3427316-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L55cWv0bnikP6lBJk_6S08T_A_Y1IQhR
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=675685aa cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=fmNT8XcYnNex_eyvA98A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: L55cWv0bnikP6lBJk_6S08T_A_Y1IQhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_02,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090047

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[ Upstream commit 0484e05d048b66d01d1f3c1d2306010bb57d8738 ]

[why]:
issues fixed:
- comparison with wider integer type in loop condition which can cause
infinite loops
- pointer dereference before null check

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4d2590964a20..75e44d8a7b40 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1862,19 +1862,21 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_2->bootup_dcefclk_10khz * 10;
 	} else if (revision.minor == 3) {
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_3->bootup_dcefclk_10khz * 10;
 	}
 
@@ -2439,10 +2441,11 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v11->gpucapinfo);
 	/*
@@ -2654,11 +2657,12 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_1->gpucapinfo);
 	/*
@@ -2816,11 +2820,11 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
-
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_2->gpucapinfo);
 	/*
-- 
2.25.1


