Return-Path: <stable+bounces-71328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388596144C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF271F24934
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2FD1CDFB9;
	Tue, 27 Aug 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QDPGPOn3"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BD54767
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776880; cv=fail; b=dzaSwM+qWIIOAYBpgEDs4bd9aHkrAp+jSju2NpgTPGCMojF/1Fl7hJ2iCVgvypFZc2yH8uplwOp4teiyGVdgdeDJ8Tyu+RhepiNUcETB4dRgKQwRirNlBYXMpZjjy3WPOw4/Ev+01qgT4ebO8w4lXL09xQPvgDqECrZqMwZ9png=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776880; c=relaxed/simple;
	bh=Vc9KVudyer+6hm1Bzfw7JUT17iQABxsWqurPZ+cc2I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDXQQ5ki/+3L1LuOj62eZ+3dkNiJ/VgHfA8rj6ODeoER0PxYBschb3nleH+0JwAcp9VCEqIaow2uRnvTNn/mA16fKtvPmYZjqivkxN+UexcTh4+7/IA+psCtJbiq3tbTt/vB2IdDz40px1VYYcnf5D1xPUtNCCeIwd8PxyVBObU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QDPGPOn3; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GASau3fyaIDHWITq9CGE0L6sFqDPXBndh+gu9FK1i0WvE1XWvY+sgSLYK/slHkx57E7kqimhYqtVdFpF6Y/lFQY585zBj5gtTi1looKgWUTGEUpAkVZ9xMbbKs7YuRnxwbqAzCfAsDLEBbU2PRxKYVZLzpMolRksPgSnZbd4bJxPHplfKKVR9q/huUO5Edcqq4q0MhFeNJnHheag8u8mUTd57YcEakyz0vLWD7Na0At1OQwvWOoBaGQql4iktb/S9sMiylpWIXty5jLggLs96oQCDIEyE8WATfKlxqVj5aHIP3Y1VuHfWeGqrzWdm3W5vbOWx+9Olr9NNKwLieSlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D61ECN86avG+H0tvUSFyjl1YV9O6sZYn6QjwUydcr8=;
 b=uNJnaXzylm6NWVR276Pa8gkJEuQjPvtQ/dB+078OQ+ywo9VT9oRabfT7dheCo7hS0+lXy9FpWkwAxLJzDOpkNu6csaTGu4d7cQsqO6rCyFa0kGa7mX4/ZyqYueYZC6iU9Eegd42aElc7JM6UqkKWLkZbYuBGRoeqqMjckX11VVzJ2zLMieaCoWB7op8Ax8Jfm52vnrIY1MVd96gL9YnwYhyXWH3yy7wRIYu/ci+K4LmWNsMb4G4UZsp3OP2X+DqWRGSOAIoEMvjDuEtIDms0HvrJavSVaL9uZUPFuIcFimSOdQ+bXB5O3QyYMITwgLDZX4Vo1e3IslhQgIVSE1W4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D61ECN86avG+H0tvUSFyjl1YV9O6sZYn6QjwUydcr8=;
 b=QDPGPOn3v5QejUJiL/nKBrKBds3wHPhlIu3yqs7x9cG62gpw3uHWPj1n5dvHfD0uPHT3JJ8cNeVP8QJd7S/FCPlhVpl5OZNBpLxpMi28GnKqolVF931Mi4xZAta7EJVPtnBwe33ENefQFmUbCOc79KrNN1QmERhlr9S7i6y2to0=
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:41:15 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::24) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:14 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:10 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
	<aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
	<roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Qili Lu
	<qili.lu@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/14] drm/amd/display: fix dccg root clock optimization related hang
Date: Tue, 27 Aug 2024 12:37:28 -0400
Message-ID: <20240827164045.167557-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: a618ea04-fabc-4036-a3aa-08dcc6b71130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evVJYsHcYYXmo0STCHgvzS1yMokOucM7unVi7qpJK6FhIpPNfFAd03LF07Xx?=
 =?us-ascii?Q?FWY6DspvQ4Nap5Dh1n41wAenQVkShKkzX/Rn8lKgV5u5rFuLHMQH0OlRzubS?=
 =?us-ascii?Q?SbB1Ib5+SXjV+YINKLo3g1jpACJsgyF8P6YhRxVI32PeAEpi5z3ml5JDQ0Ol?=
 =?us-ascii?Q?xGldmb2CK+lrlJ0IVuqYMMSd2gXGJ8RLPRlsZt9gvfqrkYrDxRry2o9Xl+n3?=
 =?us-ascii?Q?SFXrxx/2PjIOzCVz4cPbjrgdzBVPxpkzZGJEK75PBKDaHkKbB65ddKLxltdx?=
 =?us-ascii?Q?DxDsjAkB0JOcgJj2XPjl5LKP7prnendsHgSmH2RzkxM3PsYHann/Zs5digQY?=
 =?us-ascii?Q?rguTJ6MES8M3AUn6CG3P2rQMj0MkfmxAytHhLicCccntKSEayB+aBCEthC+P?=
 =?us-ascii?Q?rR//5HeyYqBUuwRRBcMLunMjirJKeLYt4Q1e2NeD+z0MhT/uOLQaQteIkA7D?=
 =?us-ascii?Q?ylG7shJg8OknSxF/i5ZVnzhpirNkmbefUif/44pm9WKKXd39iNEpGUtwUkYz?=
 =?us-ascii?Q?9JLcYHinBa59ulzxPD9YQBs7sxkenhZXD0v0ODAdLn3tFQorcQ+4GCBpwnxq?=
 =?us-ascii?Q?8k7T+VXsF1JvIwaFCH+L2/h3BXjabe8+eZKB+ttVaDtb8zfCXAMVQHKcN8uu?=
 =?us-ascii?Q?dY5VEfkDZmAwCAXTIrsMN8pX31GIIBGkU/lIp+EhV3qDvwwDFJS6WFPbLWiV?=
 =?us-ascii?Q?Rjt3AJwi7i7IC+ujkQgwKsOF6d52LmaLgbEhhpHLANgWIFS9lh3ceQi0VX2x?=
 =?us-ascii?Q?So4IgBfOgygTRZsQBUhnM48+KPxLs1SbD+FCCwb8DFDu/nk4toMvo6kTSgf4?=
 =?us-ascii?Q?JcT7qJPPph/GcNeZKUVmaOWwaO6WaDs/aw8LxNAuI+21Ti7jJBTLcdZIOYeK?=
 =?us-ascii?Q?EDaIOo9mDODF4iuJ7PAtfyFweu8dNPuvVbdMokrCzrlxD7xm65TNRCdxzEGl?=
 =?us-ascii?Q?tRWCMlDI/K3V33g7mkioheRpRt1MplR0EMrJzX1EhBayobyZeDQ4XQnqSY8/?=
 =?us-ascii?Q?aVizhZ85cQ3MtiQ+JY/4TYegBOdLPXypGE1OOg8HXDFWSnK8KEvQyEFrfPND?=
 =?us-ascii?Q?QI8i2egxCIBWIJFIlIttMX3lxhaPSJy4FPtoOZhdZQsf+5QxvDRqdg0TaSN1?=
 =?us-ascii?Q?fhBEywHGhZymJLlGqectLMG7HL5AK/7Iwa8KVrq3L/73LnzaPAOwRfJdiJwu?=
 =?us-ascii?Q?dpz2c43KgCYdVBqmE0peSHtNPIig1gNbkM/vBvLYHITw9vwsUKKjOtZQoloc?=
 =?us-ascii?Q?g1gtSfcvJ/L9Y/DtmySiw+ubgxdeDmi7j8Zj2LJkHcQkKSW5yXSDUqe8tiKg?=
 =?us-ascii?Q?Ym5Ku+7BHzvk2dDKx1d1XoGvEiPmCu2u0CPGvC5D7sCIkLP8/qJt43Imwlk7?=
 =?us-ascii?Q?NSWPEcRLSlPphzRgG273PvoCP43d3JypY3U8xX8yOKwFrNjVU3Bpmjdn3X9E?=
 =?us-ascii?Q?DUKPo/Ss0nlKDqvlJNwDHjb8oHl2vD0/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:14.8857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a618ea04-fabc-4036-a3aa-08dcc6b71130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

From: Qili Lu <qili.lu@amd.com>

[Why]
enable dpp rcg before we disable dppclk in hw_init cause system
hang/reboot

[How]
we remove dccg rcg related code from init into a separate function and
call it after we init pipe

Cc: stable@vger.kernel.org # 6.10+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Qili Lu <qili.lu@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 14 +++++++++-----
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h |  1 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 889f39694cb7..8b3722a0011b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1721,10 +1721,6 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
 		}
 
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
-		for (otg_inst = 0; otg_inst < 4; otg_inst++)
-			dccg35_set_dppclk_root_clock_gating(dccg, otg_inst, 0);
-
 /*
 	dccg35_enable_global_fgcg_rep(
 		dccg, dccg->ctx->dc->debug.enable_fine_grain_clock_gating.bits
@@ -2303,6 +2299,14 @@ static void dccg35_disable_symclk_se_cb(
 	/* DMU PHY sequence switches SYMCLK_BE (link_enc_inst) to ref clock once PHY is turned off */
 }
 
+void dccg35_root_gate_disable_control(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating)
+{
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
+		dccg35_set_dppclk_root_clock_gating(dccg, pipe_idx, disable_clock_gating);
+	}
+}
+
 static const struct dccg_funcs dccg35_funcs_new = {
 	.update_dpp_dto = dccg35_update_dpp_dto_cb,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control_cb,
@@ -2363,7 +2367,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
-
+	.dccg_root_gate_disable_control = dccg35_root_gate_disable_control,
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index 1586a45ca3bd..51f98c5c51c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -241,6 +241,7 @@ struct dccg *dccg35_create(
 void dccg35_init(struct dccg *dccg);
 
 void dccg35_enable_global_fgcg_rep(struct dccg *dccg, bool value);
+void dccg35_root_gate_disable_control(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 
 
 #endif //__DCN35_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index fbbb20b9dbee..7ed75c5fe25e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -271,6 +271,10 @@ void dcn35_init_hw(struct dc *dc)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
+	if (res_pool->dccg->funcs->dccg_root_gate_disable_control) {
+		for (i = 0; i < res_pool->pipe_count; i++)
+			res_pool->dccg->funcs->dccg_root_gate_disable_control(res_pool->dccg, i, 0);
+	}
 
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index d619eb229a62..e94e9ba60f55 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -213,6 +213,7 @@ struct dccg_funcs {
 			uint32_t otg_inst);
 	void (*set_dto_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
+	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.46.0


