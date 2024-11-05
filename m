Return-Path: <stable+bounces-89925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884419BD6F7
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD1A1C22B19
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CF213EEF;
	Tue,  5 Nov 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sGJD4ad3"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F58213EDB
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838292; cv=fail; b=M9QGHQ6n5SN6ZFw3y71BUVNAIicVf3wdS3ouhux0DjYDUdami++058s+/30gcBKFJi/f05T5P9f7lzAdvB+xOjVjE7eZiESryJEldX+dDTFu8O4+L9L9gecC6tPWH8iLN7qVmUrHnMYSRvaiE0s6US5XFk89nq18vwS3A0UeDdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838292; c=relaxed/simple;
	bh=YOTKgGZ5v39G1+53oCuq9zkTQ3TzRB2ltuAiUaz+gJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzbY1Va5A6bVdu3lwSGSIX5wMnuWgoS+rcUnV2tgXXxeQQUJqQuCrlFMZMyJetf8zlyLn34khub/MYyT13BUhmyG75P5QrjZtTsey9u9v9WnaoBrFiT2iDuqZmcETIdY6stLH+jg63A2P9cJpRSVXN3okALktvyykDPJnuMb24U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sGJD4ad3; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcjGXRsJtYT/1M/VttlQIsWUx7TBkJjQrk/jlGQ07YKnjDkZu7ZJ0k50J3B1RhjXG6ejT/J4/Q2xXx0TquCAAzfva98wqLIKzuQic6oFXhES3artq/NI9hXhHdBO52FyvW6OZ/DJ5VE1+jNdiXcqlg4oVXZ9op0UuzwNnABItow4xu6K7lLZ7f0QNFMZ9ctbyOXfz2utHscKcDUoTZBqrR2y2jpWMBeBj8rX45Z5XTiJGE3n5yR7ImdmLnsSgibFR/R3dnp/8yRgaayEXy5IJHjGbh8w6dAGRdHW0eiBxyt0bG46/2mH1ULiHx1deqk5qL2lhUfKJKyI+Uqtj+QYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Uym+PxPRJ4/51W5N4PqLMq/tI16W/lUyrewvi92NQ=;
 b=bMQksGNt8fHe40QJVp3tKagTPHWDciFBYb3NII/+ETehgk9OgVd5162mlbOR3IlmQXlWP6km3j0Zort8b91N2OrEZ0arl3P00uQnQVEmF2uJtV5iVshKuBiZbMMJalYWtMG9Ohwp3695m1JibTi28ANSAKgi93aU/LFBvaG2kmHlNNM7VPOzMXpVpkW4Ztkfwifp92sLn41CAR8cO80soKoYtsKUvDD4fRBl4vlhWAVJJW6h9UAaHta1Ztblw1xwlwZYgfQzpe+C1SgaDfOkfoeKlCUzDjF/Vo5uhj2327XofsaKpP9nT3GorrWT8TzplgA2chzY2LwXEbIhuO5E7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Uym+PxPRJ4/51W5N4PqLMq/tI16W/lUyrewvi92NQ=;
 b=sGJD4ad3qmXM1Fg9M/VzV18x5EU12ug31I0OHyN+9ARTcZEklJPvqlkGgRs43SAYIZz3LE6tFmm6TK31OncJ93bm6twcGHexRqUFIN3bTHIds1CBR9xwsORKo9SGjiQtMP8D/7RnnXkeS96drB/8rFdmI4NQ66hRSHPbdjRHWl8=
Received: from BL1PR13CA0171.namprd13.prod.outlook.com (2603:10b6:208:2bd::26)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Tue, 5 Nov 2024 20:24:48 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::9b) by BL1PR13CA0171.outlook.office365.com
 (2603:10b6:208:2bd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:42 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>,
	<stable@vger.kernel.org>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Require minimum VBlank size for stutter optimization
Date: Tue, 5 Nov 2024 15:22:13 -0500
Message-ID: <20241105202341.154036-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 236a6719-ae9c-40eb-4906-08dcfdd7e4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZWTWJdmmo7zY34j4alvCl+HDwE90mEj6Vp2CGW1m/qeXk1HQ9J3hGAMCAeb?=
 =?us-ascii?Q?qmfJzQzGYQ4cdMEdiIoBq4zWjXxn+iSkCi38AWc8hVlymtNOeT1kkW07yx3x?=
 =?us-ascii?Q?1ePIxCi2UgrA3r9TYPJQ2u6BIZ/CVj3+vCll0MCgCbcrjpTPR2kViXIO5pUA?=
 =?us-ascii?Q?0/Jq5LuZK/zemp1oKaTWZsVrgRCgBdrJuVJzcp+/Y7mx4pdN2sGqmBzhYSbM?=
 =?us-ascii?Q?NPGLDeXF3luQjF4c33yOu1SbS/TXmlxfCNx+bp72pYGedj9NWWH+hlOCQg7O?=
 =?us-ascii?Q?7PfzwzBjG19d7ndEfkgJPJG+3nlsA45QXT+NGlm8mRdnRWebQCzxuTWv8Qp6?=
 =?us-ascii?Q?unY60e3myApjncQDrKR5hthij6be0/S1KigCElLtMB8dnmJ6uyqWERhSJQ0O?=
 =?us-ascii?Q?R/KtBCRWQj2zQlqbqlMGoi/LodPbGTS46///Mjm/Olfe7Zf6BO4li5ZnbxM9?=
 =?us-ascii?Q?mZ5Nv1sOPJ4vDkDm+RQap6N1EIlBN9i1ncxV2yMAe4SkRxO5AMx8uePraS+O?=
 =?us-ascii?Q?jbxMnfkheI7nMum4Egf2WYfQVcvxFIe4Dr5IVW5r2yF/3lvrDVZhg40OBWa/?=
 =?us-ascii?Q?gyjUf8E9crlzdRWDd1yWpqJOFaDLuN1wsbHCiGQ4qheepD52CrQcCVNo2VJm?=
 =?us-ascii?Q?I3YkKOOqF+ABFxvCrSkrvCCwwMc2S/N8Dunn/Lq9Zzw/RHId+lvAxmj7hSnn?=
 =?us-ascii?Q?BCoQWlLfEdwqN1uCbWbT6rgNuylJqsnVYabm6KFRletx4Y/t8qrpEHWyviFb?=
 =?us-ascii?Q?+NdWkvcavEioKcvo7UlJtghVOoT0mB/kpDh7z7oimNco2uzrKLBOAUuUAUSo?=
 =?us-ascii?Q?7QgHbINfM1R1NMyTIQor9fbGvGjPckDWda6RCkMR6qj0NndSDvHF3/OOz78m?=
 =?us-ascii?Q?377GALAyVZTKEKH29y1PlQmQo1llAhcpLxtiIjP0eg2p190pTkPhRxeKVuI7?=
 =?us-ascii?Q?iOlYgXtclRvQ4rp4hQovBdpMdxI4LnmU0Vr5rC1rh+xBHEThRWfsERVF6prx?=
 =?us-ascii?Q?dNIw7XQoc4YQg4NVig86yduWQi9VFC7uLYBiNKnGcG3mg7fmVq85oVXrPM93?=
 =?us-ascii?Q?zh2/tQ4O8Ee985ELE/d7OAYr5AgbSPviM2rrL+XUc9CziTE9RiICeegYuB/4?=
 =?us-ascii?Q?R9vElrH0E9K9tKikXh5XC7832/4j2//U7zrq0ZRwxOqoiEY5brIr8R9ehF3b?=
 =?us-ascii?Q?f2yJ1VXt1Eul4l+WNNhE8n5nW4fJo5uVozLQ182Fp2Uel+pwjXguLYQ7jLPM?=
 =?us-ascii?Q?PNyTd+y7P6XQnTWCgMtJ6HXPrtYxnrO2WhLPnZYam8T+u+4K9y105xSvtieH?=
 =?us-ascii?Q?mKYtzYPnMF81i8vNbqLqk+8ivCWSJGTna2SwGMab4TsfDRFQRXyhkUEfKkwl?=
 =?us-ascii?Q?sqtJfNm9BIoLPHMYLaueBg/kgQaEpzcoIJ9484d6MCH9kYBlVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:47.6382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236a6719-ae9c-40eb-4906-08dcfdd7e4c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

From: Dillon Varone <dillon.varone@amd.com>

If the nominal VBlank is too small, optimizing for stutter can cause
the prefetch bandwidth to increase drasticaly, resulting in higher
clock and power requirements. Only optimize if it is >3x the stutter
latency.

Cc: stable@vger.kernel.org
Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 5a09dd298e6f..92269f0e50ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -8,6 +8,7 @@
 #include "dml2_pmo_dcn4_fams2.h"
 
 static const double MIN_VACTIVE_MARGIN_PCT = 0.25; // We need more than non-zero margin because DET buffer granularity can alter vactive latency hiding
+static const double MIN_BLANK_STUTTER_FACTOR = 3.0;
 
 static const struct dml2_pmo_pstate_strategy base_strategy_list_1_display[] = {
 	// VActive Preferred
@@ -2140,6 +2141,7 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 	struct dml2_pmo_instance *pmo = in_out->instance;
 	bool stutter_period_meets_z8_eco = true;
 	bool z8_stutter_optimization_too_expensive = false;
+	bool stutter_optimization_too_expensive = false;
 	double line_time_us, vblank_nom_time_us;
 
 	unsigned int i;
@@ -2161,10 +2163,15 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 		line_time_us = (double)in_out->base_display_config->display_config.stream_descriptors[i].timing.h_total / (in_out->base_display_config->display_config.stream_descriptors[i].timing.pixel_clock_khz * 1000) * 1000000;
 		vblank_nom_time_us = line_time_us * in_out->base_display_config->display_config.stream_descriptors[i].timing.vblank_nom;
 
-		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us) {
+		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us * MIN_BLANK_STUTTER_FACTOR) {
 			z8_stutter_optimization_too_expensive = true;
 			break;
 		}
+
+		if (vblank_nom_time_us < pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us * MIN_BLANK_STUTTER_FACTOR) {
+			stutter_optimization_too_expensive = true;
+			break;
+		}
 	}
 
 	pmo->scratch.pmo_dcn4.num_stutter_candidates = 0;
@@ -2180,7 +2187,7 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 		pmo->scratch.pmo_dcn4.z8_vblank_optimizable = false;
 	}
 
-	if (pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us > 0) {
+	if (!stutter_optimization_too_expensive && pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us > 0) {
 		pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.num_stutter_candidates] = (unsigned int)pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us;
 		pmo->scratch.pmo_dcn4.num_stutter_candidates++;
 	}
-- 
2.46.1


