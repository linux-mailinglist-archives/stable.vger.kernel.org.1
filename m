Return-Path: <stable+bounces-54745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC8910BE5
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154DE28754C
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9D1B3751;
	Thu, 20 Jun 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vo5n/KPP"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E41B373B
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900291; cv=fail; b=qMr7bSCCndCLgSNX9kHywj9rP+7Tl4VOT4+zlQXwSWC3CpNYDAVXfYswJbwdjoRFWriB+zgapceRS9rk4wDkmU13/9KTA2l8Hr5UeSKb43s1SADuWOJJLmx6y+hKKySR0GQydLgk6DngXMRb21aoM2OP/VdaTChcaUo497wa/jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900291; c=relaxed/simple;
	bh=XS6QzCx32HHVNZ/wxr/XP/yqMpx5dbW4mFmH7I9jEFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Um8MqqnUze+iJXagXmjA5e6a4tJZoao6oV2U0Oc/7MTXDa+VKvlax9h/lxUI0cEcJfbmEanXjWTZpblsoHwistM3vtAZFeCg0baw+lZuiqQOlV/EnMrAKnRcFgwalIZpSRVF3enLicJNmyNw+nEXiTKoKoQmqDSZPs1I6leUL2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vo5n/KPP; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxI2pGYYDbHnG/hz/m7LBr3lg0vxjvjB3LHc9rsHPJ4qzZRZhP4xHiW5aScaUnopsqlIdAxuiFAQ4XzhqTEgP0Ykz4UV+sLdO9w4idi1xtHi8zK58/l4Ilg/WEU48fbBoQpOCTHPgmY05+RKfXMhgDMeeocdpYQnvQoCqQDFfTsAbDaw3L7K7o6k06p1/3kklJcx9nwaPdqBI6IAVGYGedyBxfh4L8GBHO++j7pT9TADisGD+imddMW7kfXnS0gw694sta2pMBfGjuAWmRfKzEiEKHQv/WoA53JL0CbL0B92dtyLtoN363ukCVGqFesAxT1GaATqeeNEx8GCnSdQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+PgRkCmQD4wGL7BI02koa0eHY6T/N6GQzz4VEPn0mk=;
 b=QAYIh3wjfj1UOYxqribQVYXVgw8l9UuZ04NSNKxMjkvHDIzj9DK4lEXgZEwGTdSd6Fd5zV9PTFAP6/p6zaTqu0tOgA13SrxEaQfh6oDUvxm9Zh/RMJ1EbrcY+QgjWKs29miiklMlm0wRjsHodt0I5k+cPXDIXCBd2BLOlJZEfGAGd4x9vSA4MknHsDZ77QUNX7z+63Mgt7HN/KdWy8D80QgTr3xSwiUzZoUUNlLcEEyBCGAu1hZH5RCVjtqvMqztFOZWlIKyfAhgCFDyjzmOk0HBr2FsFqytxVCvLGi+1RlQvsnkZcvnF6SmJIHOCfbv5G7wefSUesdu3/cyJ9bMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+PgRkCmQD4wGL7BI02koa0eHY6T/N6GQzz4VEPn0mk=;
 b=vo5n/KPPfzMIMO6GarE+sWnbbC46xIIe5gKjWBaTIXMZJKD0MeX0sEKYxu5vCBAVSogPuVxy0xMbv8psr3X2PlhpipRF75P91yEzcWEIUUNIPO8AQtdcaN7Q89iwhZdao10ChFDkYuzIjMjLxvf/YqFZgWEAyVZjqUw3mHRQlng=
Received: from CH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::26)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:18:06 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::46) by CH5P220CA0005.outlook.office365.com
 (2603:10b6:610:1ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:18:05 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:18:01 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Duncan Ma <duncan.ma@amd.com>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 25/39] drm/amd/display: Reset DSC memory status
Date: Thu, 20 Jun 2024 10:11:31 -0600
Message-ID: <20240620161145.2489774-26-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d70937-6ac5-40e3-3c32-08dc91449131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fhajShAjdZjHkQInXRB+6bnSKQLU7VZJlWrn7jiJ2ZHc2cnvKX3/j/NvHZX?=
 =?us-ascii?Q?IEFqjoz2Wu4a2oFIYziaD1cKhCcZ0yFSMCkWZ1Iu6Q7VdIBC00U1uRbZuX6T?=
 =?us-ascii?Q?/gs/sxSH5Ajzq17WaDTWTAxquvLgZwuiJtLi33O3uKVSGfZwHXMVwRKd+Du4?=
 =?us-ascii?Q?JYIaKRoBgXGViZ/pQOz8MWaITSCKi0Phi4QwfVY0eIEjz7dNlb9tSs16vbiz?=
 =?us-ascii?Q?bOWDAypHZhG2pYonUYO0wrYUkY0l5VqHyxHq0E9HMT0Nc4dTRw8oc/OLgKKt?=
 =?us-ascii?Q?VUqaKtL/UQUxV48LS4gfUdYqb2mAkgb7iNOdlrAl4qLTy7YymP77h26z0g3F?=
 =?us-ascii?Q?uS0DU4wYBh/z5hbSp+vk4zzLm7jWFWu/RBPzzO1M+TISzpLCPjjS/4yFjNK1?=
 =?us-ascii?Q?yMMVBGkvSoIxv3uwgN6wzeONK4Ceeo5gOXNVmNJOmdEmaV5qQIn2Qd+dtgTz?=
 =?us-ascii?Q?fUAI8s7lwzOinZqNjq3JU8fuVbir0rw0DszW4ZYm3kjav2/+kzYswK1QoCwA?=
 =?us-ascii?Q?WQGhzpneNr9EetpnG3mRE3OFZ0VVqPiiFDZ8QYjGp/UvvuWWsBIaGz0VppIX?=
 =?us-ascii?Q?6G+RXumtHAkS2Qo7ZC3I2c5shg+mXTWF0pzaRTvHGZyKQDuwzRKHBbp0tgxZ?=
 =?us-ascii?Q?WDxuW5zxabmP+bu5EbZq5gDUqc5XXDfcP7u/j/u/58MPl2c8ZnUYVEpFTkbt?=
 =?us-ascii?Q?IgIDckJBe0aigdmzttaUIi6mR7RICYUVppwl3mercUBme681k5QVA62Nav9/?=
 =?us-ascii?Q?EyCBxob76DyJPXkME32vLXyXN/36P4w+mS7z3IVorjxEwy5ZPgOsRKZGi8oe?=
 =?us-ascii?Q?3abjuWasUUaCRflL4++uHYaYhUKoEUbpQGXdTCyNX/CPYvdkayNTPsfwNzcz?=
 =?us-ascii?Q?UvGGANadaUxn7kIl7Wb0quZT5hRXB0ODo5OEi3T2K5dysVzwZc7+Pv5u4RM0?=
 =?us-ascii?Q?joaB/X5Wj7Az3EShdC/yA53YYDF1NWXIT/CRb8u/GRySmYhK2a8o69jMWleZ?=
 =?us-ascii?Q?D0BTiiWd+FZjxyIGv9TpOLZsvOBFlISSo/OFHhUo89M/FQQn0d5Re5gMm4cU?=
 =?us-ascii?Q?cco5QTVp21JunAjrIykdESVwHIoQYa8VNUaho/saVV8X9WaJ8hZhE4FDvT1A?=
 =?us-ascii?Q?Y5C/Ani4f9WxfZH5tl3wwBOuTAysA3bgZWzx/UmYhBduinI56ran0f/LTev/?=
 =?us-ascii?Q?FhHEgMf2D40OzWGVPJ2R8MmGL53qXCSmSRnBRPAfu6Ee6X7OAjw8J43XE0m5?=
 =?us-ascii?Q?WB9uqmx1r9YLg0RT1blKTv8Ii/3y5kfSryYvL0m1hX/F6ORt4reQ98KuCapk?=
 =?us-ascii?Q?f8hjgtpB6tFylvELPEk2BvU7yenEYG094oL7/pHbbG2HCsn60GDF/zLBAisd?=
 =?us-ascii?Q?vnfQnC1qWWFF3VpQ1y5f+zfoH7aMrYGTb705IyCE/MLrovM7dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:18:05.8556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d70937-6ac5-40e3-3c32-08dc91449131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

From: Duncan Ma <duncan.ma@amd.com>

[WHY]
When system exits idle state followed by enabling the display,
DSC memory may still be forced in a deep sleep or shutdown state.

Intermittent DSC corruption is seen when display is visible.

[HOW]
When DSC is enabled, reset dsc memory to force and disable status.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  | 24 +++-----
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  9 +++
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  | 58 ++++++++++++++++++-
 3 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index d6b2334d5364..75128fd34306 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -32,16 +32,6 @@
 
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
 
-/* Object I/F functions */
-static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
-static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-static void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
-		struct dsc_optc_config *dsc_optc_cfg);
-static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
-static void dsc2_disable(struct display_stream_compressor *dsc);
-static void dsc2_disconnect(struct display_stream_compressor *dsc);
-static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
-
 static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
@@ -156,7 +146,7 @@ void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
-static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
+void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
@@ -173,7 +163,7 @@ static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_ds
 }
 
 
-static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
+bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
 {
 	struct dsc_optc_config dsc_optc_cfg;
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
@@ -196,7 +186,7 @@ void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_conf
 	DC_LOG_DSC("\tcolor_depth %d", config->color_depth);
 }
 
-static void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
 	bool is_config_ok;
@@ -233,7 +223,7 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc
 }
 
 
-static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
+void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 	int dsc_clock_en;
@@ -258,7 +248,7 @@ static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 }
 
 
-static void dsc2_disable(struct display_stream_compressor *dsc)
+void dsc2_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 	int dsc_clock_en;
@@ -277,14 +267,14 @@ static void dsc2_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
-static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
+void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
 	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING, 0, 2, 50000);
 }
 
-static void dsc2_disconnect(struct display_stream_compressor *dsc)
+void dsc2_disconnect(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index a136b26c914c..a23308a785bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -597,5 +597,14 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc,
 		const struct dsc_config *dsc_cfg,
 		uint8_t *dsc_packed_pps);
 
+void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
+bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
+void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+		struct dsc_optc_config *dsc_optc_cfg);
+void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
+void dsc2_disable(struct display_stream_compressor *dsc);
+void dsc2_disconnect(struct display_stream_compressor *dsc);
+void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
+
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index 71d2dff9986d..6f4f5a3c4861 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -27,6 +27,20 @@
 #include "dcn35_dsc.h"
 #include "reg_helper.h"
 
+static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe);
+
+static const struct dsc_funcs dcn35_dsc_funcs = {
+	.dsc_get_enc_caps = dsc2_get_enc_caps,
+	.dsc_read_state = dsc2_read_state,
+	.dsc_validate_stream = dsc2_validate_stream,
+	.dsc_set_config = dsc2_set_config,
+	.dsc_get_packed_pps = dsc2_get_packed_pps,
+	.dsc_enable = dsc35_enable,
+	.dsc_disable = dsc2_disable,
+	.dsc_disconnect = dsc2_disconnect,
+	.dsc_wait_disconnect_pending_clear = dsc2_wait_disconnect_pending_clear,
+};
+
 /* Macro definitios for REG_SET macros*/
 #define CTX \
 	dsc20->base.ctx
@@ -49,9 +63,47 @@ void dsc35_construct(struct dcn20_dsc *dsc,
 		const struct dcn35_dsc_shift *dsc_shift,
 		const struct dcn35_dsc_mask *dsc_mask)
 {
-	dsc2_construct(dsc, ctx, inst, dsc_regs,
-		(const struct dcn20_dsc_shift *)(dsc_shift),
-		(const struct dcn20_dsc_mask *)(dsc_mask));
+	dsc->base.ctx = ctx;
+	dsc->base.inst = inst;
+	dsc->base.funcs = &dcn35_dsc_funcs;
+
+	dsc->dsc_regs = dsc_regs;
+	dsc->dsc_shift = (const struct dcn20_dsc_shift *)(dsc_shift);
+	dsc->dsc_mask = (const struct dcn20_dsc_mask *)(dsc_mask);
+
+	dsc->max_image_width = 5184;
+}
+
+static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe)
+{
+	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+	int dsc_clock_en;
+	int dsc_fw_config;
+	int enabled_opp_pipe;
+
+	DC_LOG_DSC("enable DSC %d at opp pipe %d", dsc->inst, opp_pipe);
+
+	// TODO: After an idle exit, the HW default values for power control
+	// are changed intermittently due to unknown reasons. There are cases
+	// when dscc memory are still in shutdown state during enablement.
+	// Reset power control to hw default values.
+	REG_UPDATE_2(DSCC_MEM_POWER_CONTROL,
+		DSCC_MEM_PWR_FORCE, 0,
+		DSCC_MEM_PWR_DIS, 0);
+
+	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
+	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
+	if ((dsc_clock_en || dsc_fw_config) && enabled_opp_pipe != opp_pipe) {
+		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already enabled!", dsc->inst, enabled_opp_pipe);
+		ASSERT(0);
+	}
+
+	REG_UPDATE(DSC_TOP_CONTROL,
+		DSC_CLOCK_EN, 1);
+
+	REG_UPDATE_2(DSCRM_DSC_FORWARD_CONFIG,
+		DSCRM_DSC_FORWARD_EN, 1,
+		DSCRM_DSC_OPP_PIPE_SOURCE, opp_pipe);
 }
 
 void dsc35_set_fgcg(struct dcn20_dsc *dsc20, bool enable)
-- 
2.34.1


