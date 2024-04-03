Return-Path: <stable+bounces-35874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA389794F
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CFD289CD3
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB701553B1;
	Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gTIcRAkL"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400431553A1
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173915; cv=fail; b=GTevdNVZ17/C4Z1Ya5xjY0y4ssnEni8IuSCqn9AY1mJ5PtxCMyQ5Geq91g30qZ+fXnlUL2kToM/k0PomE3bMSPZwokZcd/84KXotKZ9y6ZzPgfpeMwWfFmQljr1SF0gH/NA/25R9gi4bT4D9nFgyxM4ERbwkN0hrvyvC9CAsu4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173915; c=relaxed/simple;
	bh=wsTC4V2mXSlME7mS4paRIrbM3zVt90INFbh0W67nXtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEM+IWQ82Kons6rrW3LTLhPusUSWJ49pjWl512Oehht1XsuahyfyKFxOzGGRf3jYBX/a2wqk8pytNEMpP2oHTB9sJ943DBo2vfKwG4ndx2Zb4OeK6WrdCIO29Hp9NZBHML2ynGIe8F7FXdkioZG8RTzXw40e4C73YnVpwxkvM0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gTIcRAkL; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V59ZcEHS6nAmIcqIhBbUWYIZIkb8VOzNDH/kRbxbAXXbI7Wi3fA7vB2pSD19hjjN67Mp88/QjQLvSxUY1MHOzXcYiG+4PN/oixG5kPGCki8/Ge9ajmZROKDBQDSlfEtEH9fEz/N7Aw/YJ7m5LpkJk5B2TbU6OuAL0Xi3C2kaxnZVCWEe1Qo91m0W4i4afOYVHjl8K2ExSXviShodGHNCdIvAlA3F4iZjdTPQHIpj0MNbPiJbEiJGC6m5/0NBSyIFT+ZWTskpGa31awP1KiVga6PduDT870z/ihj4UnHSpat6HLv7Lwg3Dehb7vLgwqo6QCQNNXF6ZUir57SmCQnwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxHeFSSIS3G1hi5OV2VWVWCmpCf7oDT2j3MLwNd4Vr0=;
 b=T2RuidPxQqZLZPf5ySQPhi/QjxQ0KPabqIc8zcCSQGRJex/L6LrJZT7xgSnwwftBS4U1wRtwKQR5FzEknVPx8ra+CBGwYGOlo0BsnR26jOcq/9EZwWR0LG+urehrxaDUT9e7IjTQxLMwkAHcqfcwPQJZn5AX0OHsVUDwIUJ5+W3tQvdT3Se8/JDF+sR8x8ogM4TKdj6hkSvvOL/5f1kg3WEhujk05J3Ljl1mpfvnMxn+6XbbB2drf1xXNCymRc3Kwsw4cMsxEu892Ss8TCtnOU/WvjOixIKdeHuchAnJcAgaAvxfDhHXxEJM5chGq3JJaqMoF/UhEi4MUUC1rdpikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxHeFSSIS3G1hi5OV2VWVWCmpCf7oDT2j3MLwNd4Vr0=;
 b=gTIcRAkLeV+X7yzeCjZ3KtFeqCJbi08J3y8OjdQzecOFJxFgm16HGR7lAFgct97ygtRMA4i8J/+9w2PEqTXNifD0MvTWx4L2Pr/nHwhs3c5glJKtsyUls79E91xQFbugNqXP6ghUDL5/8esXfzsZem9TK9KCCCZH6K9CTDIdRuA=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:49 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::8c) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:49 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:42 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Zhongwei
	<zhongwei.zhang@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 13/28] drm/amd/display: Adjust dprefclk by down spread percentage.
Date: Wed, 3 Apr 2024 15:49:03 -0400
Message-ID: <20240403195116.25221-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6866c1d1-c754-40e9-22d9-08dc54178052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bClvJ/EDvC/AHIXuM2iEe/VkYCz8PX412PvJJUfhNLQDx3KjL9/Q0zxO1AwozbDhxKgoRscCxQcVHsB3HgEYAUsQNUNK9Iesk1armHjkKHlW46NFc7RsDgLqDZbwSgITNjHsoIrmn6cwQ1iYzBciYHKvvtq5LiYT2ob1efR3H/S0Fnxf/3SgifloxJxP+pc0ZCkwMzcCqMTZKGLdvdAYBsqslw+kwqgjOWYIac1T9Q1RcEVD2SkUis/HHe6wFQScw46tJhWa8FXvxZna0vMw1ftxnXvrhzUSg+32RPcWPyqLw7StljspZrgt3XODJZWvdfAgmFNJv2ZGznx+i8NTon0CwhF0eb+riX+2zc7GuOmvAtYLmvtPuOiZ3maXygu+2UnPwtK9Vul6YxFQnuHD/ibDYOYHXj1sG1+CUK+16MKkojAMoO1x+L12i1Xfeozzb4JG1jTSBNYXJA1LWh0kDNBlO8OMec+rWwp7fYEMU6ye8PGjZJERRqkZCZNw3oiPA8RxaxG+P1lfFPypiS2R/6gRUDn7FrAbvWSXhvGuq9jyW5Pcx6i8IszB7Htp+oc6Q9P+fJ6vaHEWjkGqHFEcn6/q6xX1W0eJ+57SqqFMYFMeJFTN71PqOfWj/89lufj73kbom1cHMmEJZY/ORXezHlgzR5Q12mptLdqAy/4+im1rCUpZ7zV2f0hSrssfckxIL0fm0sA0ILbjafIrOk0euZwwGBiiX5ffV3baXVPJUuUG8wQ5WsfFaHfgHEEW2fsF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:49.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866c1d1-c754-40e9-22d9-08dc54178052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

From: Zhongwei <zhongwei.zhang@amd.com>

[Why]
OLED panels show no display for large vtotal timings.

[How]
Check if ss is enabled and read from lut for spread spectrum percentage.
Adjust dprefclk as required. DP_DTO adjustment is for edp only.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 50 +++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_clock_source.c |  8 +--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 8efde1cfb49a..6c9b4e6491a5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -73,6 +73,12 @@
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
 
+#define regCLK5_0_CLK5_spll_field_8				0x464b
+#define regCLK5_0_CLK5_spll_field_8_BASE_IDX	0
+
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en__SHIFT	0xd
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en_MASK		0x00002000L
+
 #define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
 
 #define REG(reg_name) \
@@ -412,6 +418,17 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 {
 }
 
+static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t ssc_enable;
+
+	REG_GET(CLK5_0_CLK5_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	return ssc_enable == 1;
+}
+
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
@@ -429,7 +446,16 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	init_clk_states(clk_mgr);
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn35_is_spll_ssc_enabled(clk_mgr))
+		clk_mgr->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+	else
+		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+
 }
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
@@ -518,6 +544,28 @@ static DpmClocks_t_dcn35 dummy_clocks;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
+static struct dcn35_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
+static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t clock_source;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+	// If it's DFS mode, clock_source is 0.
+	if (dcn35_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+		}
+	}
+}
+
 static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn35_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -1024,6 +1072,8 @@ void dcn35_clk_mgr_construct(
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
+	dcn35_read_ss_info_from_lut(&clk_mgr->base);
+
 	clk_mgr->base.base.bw_params = &dcn35_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 970644b695cd..b5e0289d2fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -976,7 +976,10 @@ static bool dcn31_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+	// Apply ssed(spread spectrum) dpref clock for edp only.
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0
+		&& pix_clk_params->signal_type == SIGNAL_TYPE_EDP
+		&& encoding == DP_8b_10b_ENCODING)
 		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
@@ -1093,9 +1096,6 @@ static bool get_pixel_clk_frequency_100hz(
 	unsigned int modulo_hz = 0;
 	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
 
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
-		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
-
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
 
-- 
2.44.0


