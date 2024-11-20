Return-Path: <stable+bounces-94077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781F9D3177
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 01:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB21F23307
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC5848C;
	Wed, 20 Nov 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gmPYL9P"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518971B960
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062860; cv=fail; b=LQWtbphMmvv8r6rfiiwI/utcG6XOdSr7QuFevMfsFhOOe3f2q9PvDP77IMjeEw1OSofextBb4lSyyVXsTQVE3Q3xPal7LCkuWzUAmgeVMXD/AliU1XpraApxqsrvxc2F3i43aQN7ZblXoC2nJnEM/lTz33NKikY2/TmcUdWxzhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062860; c=relaxed/simple;
	bh=6tW0waXHweAgWa4kfURY4M56hqJdE/3hINLv65eZMbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pg3Q3QOOTO+K/4Kv8vRRSr4Rw6DZf7PGiAka2JjDhrFtBXjGkznPn6xRcEte9qwqS87EihfzBCuMMjDEHPBpEsYBBBs96TBgW4ik4lL0EqDTxu+/ITa/zHDOrMjAn2KL3PL0kyfUn8r2aPojktT2OMSag2wAH6MOWVqDU2eMyZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gmPYL9P; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyKdENB2iwxR4tLpNVtf7f1JbVZPi9FdYS66UhJ30XkFALZ9I9Kb/BEnpPow6IVgqrIpX4KBPa2hxGiXt/q74zgciW5szndPSFGXGKx/0CNFdovU8LXXdyrT1Cc/Ui729qBqQUJ7zYnv7+LMTliE8rxxddSOcm98GvVeXG693IteH9cnB4FnEZRriuHRHgc05v5kGeE60wMEzLkOOiTMNjfcSya1KqQPz2hJJu3l7QodDQcFMV7nBriDEFU1/KLTi527b/fNyC9xfUiYV3a0bCvoPD7rwj4/Tpr2ofvcS6R2hvNrheAB8wDjqYPDqRUB3bnLEEAqbQJfth0Uz8sA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfcxE5meqmsLJVERPzilMRVB6WYafh1ksUu0oxaMTVw=;
 b=C2/3quufHR7EwXhe0/vLe0EZNYHNBsrDoVzvcN8BhatOndDKusIJPzJ/gph7eMucpZD212U3ZPQJoAsWxi5xtWwtQE4tQFY78PujUxu31Su0m+/XlGz6wUjqv888Xr6bp3jfaF3o0JSWrls2odt3NLIXvVxfOo0JNkNLMn3WJLMvihkufSOvOlYZ74MPDH0kjd1XKYytHoGT346ZYxUdttSqUOvxtwvBLvTRwA532f/Yp6cexzerYjT5tnleXjr1v59se+KAmdDQPrblmhX2ImiQ7umyPLkkzfwC0tdduppzVMy8cQTFuJr6c7B5dUNKi846l/D62t9KR4QmclVgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfcxE5meqmsLJVERPzilMRVB6WYafh1ksUu0oxaMTVw=;
 b=2gmPYL9PyqC9VKRmrcImtX7iFXcWHx0h7ujqOZN1F+uvZ6aojCpFAWyYwCopCJ7gBNpszq6eL4pr8LmOHCxzq/kmhLAdHP6qR4+stfvcul7zNcVkTkQmN610zIDdr/PWS5GrnZDLAEZN8IEfqXLFi6SWVrtDw4+kjaCjVg7HxMY=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 00:34:13 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::c5) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:34:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:34:10 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Jun Lei <jun.lei@amd.com>, Anthony Koo
	<anthony.koo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 7/9] drm/amd/display: Limit VTotal range to max hw cap minus fp
Date: Tue, 19 Nov 2024 17:28:35 -0700
Message-ID: <20241120003044.2160289-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: a462680e-f86b-42a3-4818-08dd08fb0e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|30052699003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcNduXyxRZf5oLZZ4WwIYDqGCHLwskJ+QYUmbhZ3pTSebtovhSYiQMebx3L7?=
 =?us-ascii?Q?Gm0DS7pctxXjS4vUYP4GFZlpEHfXJaEWgeA2UKuoLVHOGdMS8IyB0wFzfLBL?=
 =?us-ascii?Q?YCcaCeNqXcInwr1ZDL7RgUhnesyj7HCNNJT5hzn3geh24MUGpZibMGgCvVR8?=
 =?us-ascii?Q?KUCQ3jJn5q8cc4rUQUEsb39D86R7eBd8ExsBjfdOmkMdfH3Otl45+JT7OBSG?=
 =?us-ascii?Q?J0aYzcu6SRjyFcgOCm8sy6i3tG6XfVhcJra8Q0jp57DmzaKaXXbVn3VW6NOZ?=
 =?us-ascii?Q?YgLosmN9QYg5h4l91aLtQSZH0IQYo0XCw/zTwkA9BIYvlIq0NbK6D+DRqvIv?=
 =?us-ascii?Q?GXTsKJi5ANYpjMSDNw3Qk8ot5Y/0s71DOLfytSHVXdARJT+S8W8dnhQt1Vj7?=
 =?us-ascii?Q?L6FlTbf/2s5Si+BCSNsNWVxXJ2UO/8fhGVYSOMLAS4ngcdgJclZ6w6w/hQWX?=
 =?us-ascii?Q?SMTpPApzuCicAbfVdMqhjBjBWslb1C+6fMIkaZotKD5p68e2FWMej882L987?=
 =?us-ascii?Q?2fGKSD8Jcz8H8Q41wOVxf5N2GTkDn8ZOLawTToJQhVTdZUdTa7y13MaZZciS?=
 =?us-ascii?Q?XDQFPcaQw5Hav9t24ZhezSTtu1bPx0TM3Syfr9esdZzcPvv00Hym2o65R9H5?=
 =?us-ascii?Q?TnctvVIVa51h4dMtp/HZfX3+VFSeedkFwkfsORB+UecCDAtE0aXU5v9UXcWO?=
 =?us-ascii?Q?atVLGSyXRRl5wL+2d5Gmku2QGMba92kvDfeKgsE1HOm9kQo7O0SV85oy/mWN?=
 =?us-ascii?Q?NZnPt15LrlwDFuHqELo2z78Mkl3VB9HfUeCT9566sYgQZbZaIBj+Ah59L2+Z?=
 =?us-ascii?Q?3CYm8AKgj6yjafH3mYkDRBEE12g+MNNHCy5oU+8wfH+mPcW9z3BrCfARBOU4?=
 =?us-ascii?Q?eA7CjfT1EYztRX5dKkxHULNHJATKSTFbZ+ninwIU8q3sH+xcfXVNMzSxAkvo?=
 =?us-ascii?Q?4yCcqWXEijQMIrBhI8BUaMHNM5XAvUwbitlBrMmInuAYlF7MMUtiEkRWS6sX?=
 =?us-ascii?Q?79W7iIXyHVCE2nbowSHOzHUelffkANSM18fJlLbcdnkAebwxdVQdOnd91jkh?=
 =?us-ascii?Q?uTTRQYN6jCQgC5B6vJSTS/yNBsJMNOUUcNUMByEhB9Rfj2MSbeaA0Stgdgef?=
 =?us-ascii?Q?HigC3q/DCO2jyM3Jr83AN4uiOSk0IquJ7zU1Uk8W+q+Fx8mInR8SOsoUyOrg?=
 =?us-ascii?Q?9YE2wZtbGFq4MWzioA4hojslm1b8z7xUh7usXFFwM61v5QjEaUhIBFGZE2KN?=
 =?us-ascii?Q?DPmLrDoMFp3leXG51fmLAcfhR6eTiyhz8W/iQ25McJ0D8bDyxxeacj90wC6z?=
 =?us-ascii?Q?jc2496Oh/hiNR7DBclRhIefulACBvjc45kaKFxe8stTqNrd9RjA+HEYVhPGh?=
 =?us-ascii?Q?C1yDlzEvZTmr6BMgfIIv0mjlUz89bCE3BwPIb9FcE3yXFZFOJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(30052699003)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:34:12.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a462680e-f86b-42a3-4818-08dd08fb0e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
Hardware does not support the VTotal to be between fp2 lines of the
maximum possible VTotal, so add a capability flag to track it and apply
where necessary.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  | 27 +++++++++++++++++--
 .../dc/resource/dcn30/dcn30_resource.c        |  1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  1 +
 .../dc/resource/dcn303/dcn303_resource.c      |  1 +
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  1 +
 .../dc/resource/dcn351/dcn351_resource.c      |  1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 .../amd/display/modules/freesync/freesync.c   | 13 ++++++++-
 11 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 943e52bb2c31..5f1b3ce67cd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -290,6 +290,7 @@ struct dc_caps {
 	uint16_t subvp_vertical_int_margin_us;
 	bool seamless_odm;
 	uint32_t max_v_total;
+	bool vtotal_limited_by_fp2;
 	uint32_t max_disp_clock_khz_at_vmin;
 	uint8_t subvp_drr_vblank_start_margin_us;
 	bool cursor_not_scaled;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 138b4b1e42ed..f66493528f42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -339,11 +339,22 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 	// }
 }
 
+static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stream)
+{
+	unsigned int max_hw_v_total = stream->ctx->dc->caps.max_v_total;
+
+	if (stream->ctx->dc->caps.vtotal_limited_by_fp2) {
+		max_hw_v_total -= stream->timing.v_front_porch + 1;
+	}
+
+	return max_hw_v_total;
+}
+
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
 		struct dc_stream_state *stream,
 		struct dml2_context *dml_ctx)
 {
-	unsigned int hblank_start, vblank_start;
+	unsigned int hblank_start, vblank_start, min_hardware_refresh_in_uhz;
 
 	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
 	timing->v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
@@ -371,11 +382,23 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 		- stream->timing.v_border_top - stream->timing.v_border_bottom;
 
 	timing->drr_config.enabled = stream->ignore_msa_timing_param;
-	timing->drr_config.min_refresh_uhz = stream->timing.min_refresh_in_uhz;
 	timing->drr_config.drr_active_variable = stream->vrr_active_variable;
 	timing->drr_config.drr_active_fixed = stream->vrr_active_fixed;
 	timing->drr_config.disallowed = !stream->allow_freesync;
 
+	/* limit min refresh rate to DC cap */
+	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
+	if (stream->ctx->dc->caps.max_v_total != 0) {
+		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
+				(stream->timing.h_total * (long long)calc_max_hardware_v_total(stream)));
+	}
+
+	if (stream->timing.min_refresh_in_uhz > min_hardware_refresh_in_uhz) {
+		timing->drr_config.min_refresh_uhz = stream->timing.min_refresh_in_uhz;
+	} else {
+		timing->drr_config.min_refresh_uhz = min_hardware_refresh_in_uhz;
+	}
+
 	if (dml_ctx->config.callbacks.get_max_flickerless_instant_vtotal_increase &&
 			stream->ctx->dc->config.enable_fpo_flicker_detection == 1)
 		timing->drr_config.max_instant_vtotal_delta = dml_ctx->config.callbacks.get_max_flickerless_instant_vtotal_increase(stream, false);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index cd31e4f16c14..bfd0eccbed28 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2353,6 +2353,7 @@ static bool dcn30_resource_construct(
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 02af8b8f4d27..7baefc910a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1233,6 +1233,7 @@ static bool dcn302_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 7002a8dd358a..8a57d46ad15f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1178,6 +1178,7 @@ static bool dcn303_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 01d1a11d5545..984d23bcbc27 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2189,6 +2189,7 @@ static bool dcn32_resource_construct(
 	dc->caps.dmcub_support = true;
 	dc->caps.seamless_odm = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 5cb74fd9cb7d..06b9479c8bd3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1742,6 +1742,7 @@ static bool dcn321_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 09a5a9474903..89e2adcf2a28 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1850,6 +1850,7 @@ static bool dcn35_resource_construct(
 	dc->caps.zstate_support = true;
 	dc->caps.ips_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index fe382f9b6ff2..263a37c1cd3a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1829,6 +1829,7 @@ static bool dcn351_resource_construct(
 	dc->caps.zstate_support = true;
 	dc->caps.ips_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index db93bac247c0..2a3dabfe3cea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1864,6 +1864,7 @@ static bool dcn401_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
 
 	if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev))
 		dc->caps.dcc_plane_width_limit = 7680;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index f980a84dceef..2b3964529539 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -122,6 +122,17 @@ static unsigned int calc_duration_in_us_from_v_total(
 	return duration_in_us;
 }
 
+static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stream)
+{
+	unsigned int max_hw_v_total = stream->ctx->dc->caps.max_v_total;
+
+	if (stream->ctx->dc->caps.vtotal_limited_by_fp2) {
+		max_hw_v_total -= stream->timing.v_front_porch + 1;
+	}
+
+	return max_hw_v_total;
+}
+
 unsigned int mod_freesync_calc_v_total_from_refresh(
 		const struct dc_stream_state *stream,
 		unsigned int refresh_in_uhz)
@@ -1016,7 +1027,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 
 	if (stream->ctx->dc->caps.max_v_total != 0 && stream->timing.h_total != 0) {
 		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
-			(stream->timing.h_total * (long long)stream->ctx->dc->caps.max_v_total));
+			(stream->timing.h_total * (long long)calc_max_hardware_v_total(stream)));
 	}
 	/* Limit minimum refresh rate to what can be supported by hardware */
 	min_refresh_in_uhz = min_hardware_refresh_in_uhz > in_config->min_refresh_in_uhz ?
-- 
2.43.0


