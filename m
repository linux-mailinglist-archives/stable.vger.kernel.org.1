Return-Path: <stable+bounces-108566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BEA0FE87
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 03:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633CA1887F4B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0963595A;
	Tue, 14 Jan 2025 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LvqlVPu5"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A71EB2E
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820669; cv=fail; b=IQU/eZ0kiPNoNN1Ck5poSxt2+NMaCuV1FxwpgyZYtAguTGI+LMCOzo0HgOhao0T4ire3Sh9iGW+dS8+I4iLapHQdMp6n9i4nP2FLhMegUl6MbW/4ieyzXQHKd9bMOAVkWd3RFLCmHZv28MAO0ipmagt37Af7aWU3RrYO1RVMBFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820669; c=relaxed/simple;
	bh=SXrxpDaa+YFCoy5o1V7Msaobai6SiIO5PPQ5YXB4P0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGQfsgA01CdDog941Nl+irrRpj/CmGHktKXUO90RHmiRRMNWMh9fAmGfAUhS+pzeBlH3f6txITzrLARcjokLtQ7pkhmgXxsnYxLvdUEOQrX6SeTw/L9raxEShQPHZ0hPpVtbjYXuFTZo/WNTuzGKf/+YJWV070Z4OfIsa7vODLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LvqlVPu5; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwTRf9b14764bFscA5Q6NYxQSm3IYEzZH5YDy/oGwGwwZQAX6UC1PhOdBCXv9WXN19r21qDUmg09fsmzJvXVjtxolxM6OhMAlu8JQqHkFSR0CiYSxgNT0csnkXuRiwB5i2V56cwD+TqwyKT1dXdhFC8hXUQECtU1R9LR60PCdpuGhjWoCGzXTpiMilcB4sV0E8I9i8++Klkj5r2pQ9HvdCxOmUrOUxg8SE7jbMw435a1gIIsWd79024bcmMFGoMXJbAS78K6OsUJAhJvlYfyEZ3P4i3l/nYtXyhK6nQL+hvwWBWL6N/MVJdfFblxj3CFfaC0E3WeAP9OSeqKhtnPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdFiFsPKpo33c7Sqy/Usxgk82dW9RX/wTlsRcY6JX8w=;
 b=ewzyrtgXMV1boUlPGMpXOE0X9q+d/MrZI0qERzwJx51RqIImKupek4jw1wR7MjYbslbvanot8vvc4kDbM/LmCaVpcAaV39HaZA6zl2E3Dil/tannygqlDCBahYuzq206VfdHCsdzJSdbevDWpUsZUsHSDzasr54mf04O+Blb/5oIbPg2dtu69YJRPHxwm/UmvEtsRoEWPJybgm7ZDbZDmMpTQwk3E7koGt1XCEzuaOw4N46jJVBB01/Vkyese9h7Hqdx077TznL/M6ZYrMS/wD0Wb0AvtYcwh9dIHR0fMcoHlNRGFnl/mrwZ9kpgWZTjSgCRiyEyoAfAxWmjB8gx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdFiFsPKpo33c7Sqy/Usxgk82dW9RX/wTlsRcY6JX8w=;
 b=LvqlVPu5efoKGkTxfWSEWoJm7IH8ZnS3R+87F59yUyToeEbg2zbe/1vOOEZ/N2x4zbApabjQB6FcC5mm2ItadQV/NfRx464bv+bmoOiDdG0wD+hqQj0XQGO7KDYwh19tkX8//g851zE/9LL64claICTd9Q7bwzOtaW/3SyP8aN0=
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:10:59 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::6c) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:10:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:10:58 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:10:53 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
	<Aric.Cyr@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Sung Lee
	<sung.lee@amd.com>
Subject: [PATCH 08/11] drm/amd/display: Add hubp cache reset when powergating
Date: Tue, 14 Jan 2025 10:08:57 +0800
Message-ID: <20250114020900.3804152-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e5b0b-5a72-4317-d347-08dd3440b050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeMuxJ4ebiSvv0le0dCvRaLLOHxRxtm7nU9T0DGtlAx/veKk449njZR+f3TJ?=
 =?us-ascii?Q?fYGVqBeepFTcq0iQA9oWySW6+PJ6g4c32bEaPbKG5i6rZtTDVpe7jVarqTto?=
 =?us-ascii?Q?ijfbCH/mRvKAwui6FLfbiw8s9jXK640FKu3E78qsrX3rnf5w9E4bzFvvTKrj?=
 =?us-ascii?Q?5NMyhpUWKT7EGBooMVN8nadZ7mC5APsfDN3N0a9x3GfphUIIYJF238/EFu31?=
 =?us-ascii?Q?cXtGq6Qm1OPul+9PPjNci3joYYyLTepd8aA7KwuzrtD2+wPekwwCvKSOh4UV?=
 =?us-ascii?Q?X9nrLwhRNL6m4t3OdfJ66ivYW7JQt44KtyfU40TKV9yxm600F5+kFO+UgK8H?=
 =?us-ascii?Q?se3Gb9oM24Nz1Sy4SaFFn/RkdFTibknBJ8FLZEVR1crCDitmfM823OxrrDA7?=
 =?us-ascii?Q?7K370AMifKB9iwwD3af45RRHb0ADbTNWhnzzjl3DgvdljUze3c4cUKwVRKVw?=
 =?us-ascii?Q?rRdq4vZAuHvAC6l3MMEzk0x5cU1uCuCrAR/jOYen7WjxQ6ZrDhPN9DrnIDmA?=
 =?us-ascii?Q?5N48bbihNHMEUqv2ehQdpeYKCPNy1S31SjoZbZgGPOmF/ywkHmL9D41z3142?=
 =?us-ascii?Q?tLLZSn1dGxYcYpfdoa7veBfIoRhL5Yz9SKwShB3ZkeAPv4Ptl4faKE+8dSPz?=
 =?us-ascii?Q?TEHryRrPG+G6d4OJ7U53We/R6ncVnE/Kcfip2qI7It5xPhgIDIKihKgJDn5Y?=
 =?us-ascii?Q?0//1vvicdHXoMDNi3jyWhUrXNSlK77R45iqMm0CWONsM15mPFOjS9lfKoPVl?=
 =?us-ascii?Q?XrW6UG75X3TCAdEqGJoG2d62CffpzhYFq+9DHtzH7tXFKShDzHMAdt9ZcSVm?=
 =?us-ascii?Q?wIxzrV1ZH5NP04BXjC75cuSyRi8y6p/5RtoduBwpKTJK8TBXx1sJycXiH6xz?=
 =?us-ascii?Q?thHeRcLekNWMdJKMZ/0bL241wBBUFlsmYqj608Xzkix5Z5viMQ4tnNaDwKrj?=
 =?us-ascii?Q?33z1LcB6LcSiWDpumIplaCKzzf/WfTUzmWFNZQJFh2ymdfC+e3Y60SaKiE6N?=
 =?us-ascii?Q?qwsojlvMLeKKzKZUNPaIlhG5Ri5jcRw3eKdP+InOjxgjWyLIcKkSs1VoEg6u?=
 =?us-ascii?Q?DJ9nywBvfzw8nFMdLEFt6nO8UAgfdsmtXijxCbGaG0+2mSLG6L3PdB0Sheg/?=
 =?us-ascii?Q?DJQ/nIn8A6heR66U+3erlIU9A5ADOu8H6f7cwHfAN+ttI9WuCWyFRanfTVrh?=
 =?us-ascii?Q?tv0pDu1jUF6vXYPEaXRTsC1tiAciv9pzee6Rcca/+GV6CM1LvKhZjayq8Ndf?=
 =?us-ascii?Q?WdwnYjXWJKnv364WDpw1Auclwb42XK700f2FnL2GB87ifMqIIuw3g/zXOLTT?=
 =?us-ascii?Q?SRQXxpV0mKvBroKdUz0Oem/QBVsvyNFCd3llLnuR82X32hEtRq+57XfSPyyu?=
 =?us-ascii?Q?+QgNR12wseYASCkVVobrRXDwiqicghbVvGNs2qZVa0cwrseoMJ7DYxWDvaSO?=
 =?us-ascii?Q?I2TIJ4tcTkavECDuheENXjV4uARNlW4MX/T2cw2zOYKejX6D+nYzad+Y6cxr?=
 =?us-ascii?Q?pLPLeWpeqw8Xzcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:10:59.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e5b0b-5a72-4317-d347-08dd3440b050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

From: Aric Cyr <Aric.Cyr@amd.com>

[Why]
When HUBP is power gated, the SW state can get out of sync with the
hardware state causing cursor to not be programmed correctly.

[How]
Similar to DPP, add a HUBP reset function which is called wherever
HUBP is initialized or powergated.  This function will clear the cursor
position and attribute cache allowing for proper programming when the
HUBP is brought back up.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sung Lee <sung.lee@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h |  2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |  1 +
 .../gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c   |  1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |  3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |  3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c |  1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c |  1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |  1 +
 .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |  3 ++-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  2 ++
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h           |  2 ++
 14 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 8f6529a98f31..75fb77bca83b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -194,6 +194,9 @@ void dpp_reset(struct dpp *dpp_base)
 	dpp->filter_h = NULL;
 	dpp->filter_v = NULL;
 
+	memset(&dpp_base->pos, 0, sizeof(dpp_base->pos));
+	memset(&dpp_base->att, 0, sizeof(dpp_base->att));
+
 	memset(&dpp->scl_data, 0, sizeof(dpp->scl_data));
 	memset(&dpp->pwl_data, 0, sizeof(dpp->pwl_data));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 8364c9f9231a..9b026600b90e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -546,6 +546,12 @@ void hubp1_dcc_control(struct hubp *hubp, bool enable,
 			SECONDARY_SURFACE_DCC_IND_64B_BLK, dcc_ind_64b_blk);
 }
 
+void hubp_reset(struct hubp *hubp)
+{
+	memset(&hubp->pos, 0, sizeof(hubp->pos));
+	memset(&hubp->att, 0, sizeof(hubp->att));
+}
+
 void hubp1_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
@@ -1351,8 +1357,9 @@ static void hubp1_wait_pipe_read_start(struct hubp *hubp)
 
 void hubp1_init(struct hubp *hubp)
 {
-	//do nothing
+	hubp_reset(hubp);
 }
+
 static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_program_surface_flip_and_addr =
 			hubp1_program_surface_flip_and_addr,
@@ -1365,6 +1372,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_set_vm_context0_settings = hubp1_set_vm_context0_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_hubp_blank_en = hubp1_set_hubp_blank_en,
 	.set_cursor_attributes	= hubp1_cursor_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index a85dc3be786f..c7765e6f09e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -746,6 +746,8 @@ void hubp1_dcc_control(struct hubp *hubp,
 		bool enable,
 		enum hubp_ind_block_size independent_64b_blks);
 
+void hubp_reset(struct hubp *hubp);
+
 bool hubp1_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index d537d0c53cf0..91259b896e03 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1676,6 +1676,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp2_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
index 65c628078ca2..ec88ee424a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -121,6 +121,7 @@ static struct hubp_funcs dcn201_hubp_funcs = {
 	.set_cursor_position	= hubp1_cursor_set_position,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.hubp_clk_cntl = hubp1_clk_cntl,
 	.hubp_vtg_sel = hubp1_vtg_sel,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index edbdb8c88d5c..e2740482e1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -811,6 +811,8 @@ static void hubp21_init(struct hubp *hubp)
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
@@ -823,6 +825,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp21_set_vm_system_aperture_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp21_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp1_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 12b282ed7067..be0ac613675a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -499,6 +499,8 @@ void hubp3_init(struct hubp *hubp)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 
 static struct hubp_funcs dcn30_hubp_funcs = {
@@ -513,6 +515,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 46b804ed05fb..c2900c79a2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -79,6 +79,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index 8b5bd73b8094..edd37898d550 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -181,6 +181,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index faf37febc6fb..5661d7a80d54 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -199,6 +199,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 03bfa902dc01..5ed195377a6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -141,7 +141,7 @@ void hubp401_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor
 
 void hubp401_init(struct hubp *hubp)
 {
-	//For now nothing to do, HUBPREQ_DEBUG_DB register is removed on DCN4x.
+	hubp_reset(hubp);
 }
 
 void hubp401_vready_at_or_After_vsync(struct hubp *hubp,
@@ -1000,6 +1000,7 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp401_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp401_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 65d67095918f..c3cf2706b6ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1287,6 +1287,7 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 		if (hws->funcs.hubp_pg_control)
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
@@ -1448,6 +1449,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 59fc1c114fbe..623cde76debf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -800,6 +800,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
@@ -956,6 +957,7 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 /*to do, need to support both case*/
 	hubp->power_gated = true;
 
+	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
 
 	pipe_ctx->stream = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 2a530a4a39f7..b610beb075d5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -163,6 +163,8 @@ struct hubp_funcs {
 	void (*dcc_control)(struct hubp *hubp, bool enable,
 			enum hubp_ind_block_size blk_size);
 
+	void (*hubp_reset)(struct hubp *hubp);
+
 	void (*mem_program_viewport)(
 			struct hubp *hubp,
 			const struct rect *viewport,
-- 
2.37.3


