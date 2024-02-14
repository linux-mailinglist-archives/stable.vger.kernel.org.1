Return-Path: <stable+bounces-20209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25085525E
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 19:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70D4B25F74
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283A133438;
	Wed, 14 Feb 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m+Jdgmzs"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00112FB1A
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936048; cv=fail; b=EBoEjm9YDO7HA4RwOixoOdjpHG/RcerKs1BIVgHoVa3OnCQDSwAMbttgqYx7vVuSm7hA+GyJ7l/RIvE0ujLtrxgP2vKBHYnSI9KQWG4wZtybNI7zASHIHE3qSvAmTc/X3Ke1TRZaZDSTmvEKnKuN3U7t+r0+zXF6g8bxm/NIwZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936048; c=relaxed/simple;
	bh=bXgFICHPcuxactKiaFGbTJjvL0feQpIitjzJbFagLF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEGYitAJ/BmkZ5J8Tr9058GzJRYziZNJ8cJZFuLqKak6zlZLnIWKDTwPs7Zrd963XwV7pAgdGNhrXWj4t2CL3Q3HJsWZPez7lAjxl6bI8H19q/4HUkg8LeCL2i59k8aS5J7rosxO9jk7mnYlDKQ4LYP6B1bFsNCOQpVgyq30l4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m+Jdgmzs; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNkH+hy9z0kBrfarWZhve9HuMTGNwbRSELpel3alP1jDGBfJuB1uNAZKYEHv4E163g1M/rk0kgcfxlnOQxaMYpyDmCwvRvxwsTMajlZ/6nDiajvBEc9G86+5krqtz3OZBxxhRwP9RqqlbY4uHKJMuUW1Dal21TSlHx+72E5b7AhlMti29fl8vwa9m5cjkgORPEf1Aqmxrp9GdCALJFycJ+OI4nAKg8/xc8Tx0g5qpWXq+EQqvthBb6Iy8elvt6OHY9PVZmNDKsULHajPWUcEtd/r8J8fQGEqXmuyawqP9JUm9x+sC6KAGPPpmwLGZRNHChBDWH4TXuBVlr3vSUPMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbGNdNke+fH9r4YHIlbh+JTCd8hwjIhUpyL5Sxqex10=;
 b=DrhEDPrkoGRO22V6UC2XaW3jxljPF4GxhPLVVDEVR6yMdKGG1Nup60POBEuoxMelB8uiAXUs1D9Osqk1ujc8J6wZaCl1D7xbutxTOnrj7cI9qhzG756YpaVWdP7ENUO7ZhYxDLt8/BgvsCImbptZji+D4ktWivKwHlKO/m2V23ZUtJ2goj5tGglloqMjgUd2mv5+i0d1cw4/SDQ/YIRH7WF/Lbzbp2d11cIfCejjbfr/m/L/obC1ux4OB2M4Qgt83VvQta8lXrJiW2tQgnSbxp/o65JoHUirwsXvOA6a009ZR2Vo3ipYBswDVl4TxB0Ghd4OyLZ8y8OFHfz+nU8OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbGNdNke+fH9r4YHIlbh+JTCd8hwjIhUpyL5Sxqex10=;
 b=m+JdgmzsU+JT5Rf8/5SF4T22igkc4Im9GHvY83keBdNdOcV2Z6BbVwaYUW3DCgL3sgf2I2jgypv/iE9aa6nwdPLkQGKmX3Dytnfpf7LzzuF+REPPvvsAgAPwrcvF1ToFgzsKpG42IM23VyH6BHuJXNo1fPyn0MWMMz9Q484XJcY=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:40:41 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::9c) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:40 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:38 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Lewis Huang
	<lewis.huang@amd.com>, Stable <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Anthony Koo <anthony.koo@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/17] drm/amd/display: Only allow dig mapping to pwrseq in new asic
Date: Wed, 14 Feb 2024 11:38:38 -0700
Message-ID: <20240214184006.1356137-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbc19dc-fb25-4901-d9f7-08dc2d8c71d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	18JAcLza7OYhAcO01dxhtMhupkBpVT45jyHs3G6j9oC4tRwydUPCuD2GiLIBCd4fPrLCw3bo5jF2+k2m6iGP+rjalgpRC9NaoouVMqodloyvEVFcBZ4qTiNo6sqdE6VhMl7K3VLokfvHiPkaZ67uQVh3J263hHPJuiDIeRVjl9aLcYNmya4WS8ZIVl9muxb+yBtF703btUXN3P0xvvqVqs4jr6HNFpaXb/B8U+h5UNlA8H6GTniUA76UqMa+VYq3Gz06JUgD/uk3t8N2cJ8pqtOiuDvB50QGYjA0wesCRsuPJNATZtLBn/iYWXVSsdK6M6N/0l5sMWd9vS6InTOVfaiusD2hU7GSvnr119+8CF1mzjsu3ZFBkscqqc1aAmbWr+NwnrTdl5uW7Khw31TuBgEIyxNVIz+NVzol1cFLdS3dMzPU++oW/7n/exwAgMzza5sAf1OJH02W5nkgiNunb9pJYHzPE57g4duVEOLOK4ymqDN78uP+b3q2Fg7QrxAMllSBKIe88pxSGOx5BLFsleGPquhaBGKaQUg2ZjxTHm5IwlvFfkkeldWrQ0xQzCpddZbGf6nWe+obObiakmpMAA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(230273577357003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(26005)(16526019)(4326008)(8676002)(41300700001)(36756003)(8936002)(356005)(86362001)(336012)(83380400001)(81166007)(2906002)(426003)(5660300002)(1076003)(316002)(70586007)(2616005)(54906003)(70206006)(6916009)(966005)(478600001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:40.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbc19dc-fb25-4901-d9f7-08dc2d8c71d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

From: Lewis Huang <lewis.huang@amd.com>

[Why]
The old asic only have 1 pwrseq hw.
We don't need to map the diginst to pwrseq inst in old asic.

[How]
1. Only mapping dig to pwrseq for new asic.
2. Move mapping function into dcn specific panel control component

Cc: Stable <stable@vger.kernel.org> # v6.6+
Cc: Mario Limonciello <mario.limonciello@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3122
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
---
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |  1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 18 ++++++++++++-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  2 +-
 .../drm/amd/display/dc/link/link_factory.c    | 26 +------------------
 5 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index e8570060d007..5bca67407c5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -290,4 +290,5 @@ void dce_panel_cntl_construct(
 	dce_panel_cntl->base.funcs = &dce_link_panel_cntl_funcs;
 	dce_panel_cntl->base.ctx = init_data->ctx;
 	dce_panel_cntl->base.inst = init_data->inst;
+	dce_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
index ad0df1a72a90..9e96a3ace207 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
@@ -215,4 +215,5 @@ void dcn301_panel_cntl_construct(
 	dcn301_panel_cntl->base.funcs = &dcn301_link_panel_cntl_funcs;
 	dcn301_panel_cntl->base.ctx = init_data->ctx;
 	dcn301_panel_cntl->base.inst = init_data->inst;
+	dcn301_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 03248422d6ff..281be20b1a10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -154,8 +154,24 @@ void dcn31_panel_cntl_construct(
 	struct dcn31_panel_cntl *dcn31_panel_cntl,
 	const struct panel_cntl_init_data *init_data)
 {
+	uint8_t pwrseq_inst = 0xF;
+
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
-	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
+
+	switch (init_data->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", init_data->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 5dcbaa2db964..e97d964a1791 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -57,7 +57,7 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
-	uint32_t pwrseq_inst;
+	uint32_t eng_id;
 };
 
 struct panel_cntl {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 37d3027c32dc..cf22b8f28ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -370,30 +370,6 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
-static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
-{
-	uint8_t pwrseq_inst = 0xF;
-	struct dc_context *dc_ctx = link->dc->ctx;
-
-	DC_LOGGER_INIT(dc_ctx->logger);
-
-	switch (link->eng_id) {
-	case ENGINE_ID_DIGA:
-		pwrseq_inst = 0;
-		break;
-	case ENGINE_ID_DIGB:
-		pwrseq_inst = 1;
-		break;
-	default:
-		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
-		ASSERT(false);
-		break;
-	}
-
-	return pwrseq_inst;
-}
-
-
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -657,7 +633,7 @@ static bool construct_phy(struct dc_link *link,
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
 		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
-		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		panel_cntl_init_data.eng_id = link->eng_id;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);
-- 
2.43.0


