Return-Path: <stable+bounces-50172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD19041D6
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E7E28AC9E
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250214AEE9;
	Tue, 11 Jun 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lde+NJ6s"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AC6BFD5
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124756; cv=fail; b=cnIVhBQp2KQ8yQlFSjrKKB9YOt0uq1Z4wtMjHzjzlVZugAK6HgRpzht9hDO19xu4JmH7BkqC7AnuRx/cSkQmwsDdHBh+fBlbdTws+QKt25kN2ZJKgRdYobSALANHhzonrDeyppWqMKepTPAYmcp1c/OnHr4Z6UzOdiM4JWTEqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124756; c=relaxed/simple;
	bh=tOGyHWmqxGxc9tryb3+7xUIgGGh9bmsdJS1YsCqXn0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uriT1c64KcT7nl01QRMWAuYt6SL0FHasesUu/xXn6r7F3IqaJh8WlCq/hm+KpQEP3DSmXWAfiYqCLpVwXiPEIu2HtKO/pUSgjAKuwACV8mBWAvbxwNiVLETLT+9qpb7qAN8vjjyx5M9FdWWaBCE05Dq9nnA380HNDxOt3o211Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lde+NJ6s; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHutGXrnuZ5Unpw5FrzP7gBpKh51YFax4j/j6r0l0vJo7N1FHgNinzpK810peIxkEL+CHtfBB3E1G/pJoDnKAGD1Ctyjl6Ubfv91fVTj0UGPqsWHCM8zN1DSlHzkqRPcQ7JtQdLU+YRLJg/zgdq4s2Rq+pXoNQ70GaPALM4v29pAC40ItAVlHMKJfXNkO2OE+MH7gx7AiDpAjcdq6M7qSSawV7fgYe+PJgkGAAeFbg2HNyKO0yDd+2grmRDp+JnQ3uUZPB0CRKgYAJB+NVDa3GePS15ovHjCXVHnjjA+myPSboeFVt+r5QazLCfM0VPbsm2rNdhdaMM8i6zeWTqVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fKYjY1r3Z9m6/J4b2LnE9ti2jqi/Qgb+Lp+icX2PwA=;
 b=K+ZPWyi7Q3OzrQbK/MkaPpEK+5h2O78YnywqdddDTysc6JV2XjbCERpYGiNjCDfo/8UFFAWcDYNAE0oMd2OfkK8RXs6rM4+gkFe3W5YUil5/mPk6szmpeYCvgnk0XZy/BzTUFLYtlUt/g3soua085Yz0TTu8+qIXYJZwNbi5owPmWi9l6NolGyIZRLCm32Q8lepIyQ5Yk40Ho9GphDjTdS2kfX2G5aD2TvLRd/Grv16nvD2MDx9O+xDppu2FSF6dXeAPKLCdBlE07Ns2E0OhcPqdZ75s7S+2amrrteeNAWS1g1VN5FnPTZhyy+FG9gbFqbk5urHF2rbHannMqnj8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fKYjY1r3Z9m6/J4b2LnE9ti2jqi/Qgb+Lp+icX2PwA=;
 b=Lde+NJ6s3+1xkQK+z5n6GAjjMgwT+mPp/2teOe5n3mZNScucpLXJnvao4fpYLHlq+/G9le6QgMxEsatzslip9n6faB9j+HLJYkVB8uE2E7rpcaw/MQ8K11/zqUVYkQ6IHHGb/jWA/5fe8LflYN+EtP3Ck1rZdqEyP7ZcDlGuhAw=
Received: from BN8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:ac::20)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:32 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::e3) by BN8PR07CA0007.outlook.office365.com
 (2603:10b6:408:ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:31 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:26 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
	<Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
	<qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
	<solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
	<hamza.mahfooz@amd.com>, Michael Strauss <michael.strauss@amd.com>,
	<stable@vger.kernel.org>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 10/36] drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA
Date: Tue, 11 Jun 2024 12:51:13 -0400
Message-ID: <20240611165204.195093-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ce19a6-e46b-4c4d-d45d-08dc8a36e2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuTS95k0aWp6iYg4X0OIiKI6yikROJ4N3b2fB+YQIEptMySDWMfJL+y0GCXo?=
 =?us-ascii?Q?7CkgcsCWm4MjXCia7wftzSR61o+D7NawR4I787dgijRAp490T8NInV2kzTIJ?=
 =?us-ascii?Q?ocUaOnMztEXTuv7sWAQXKAwMFNrr6YDgUC9VbFwbNkO+LLIGtqb0Mu4jIhaC?=
 =?us-ascii?Q?7TAVPN3IzALOoKqot3NUDh4yuG/saSYs4cOGt9oX4eKW1Xe8K9go9L4QI++s?=
 =?us-ascii?Q?/WhezdkEUwH+pONhVrxXQBZLu+GNapVko0oweG/3NBIpotPs8zwi+frA0MB+?=
 =?us-ascii?Q?7uiK/KhhSWofjPwbAjdTkI8fq0XvCHS/8UAxXR6mlyvK0o5/RJjjigi71W2D?=
 =?us-ascii?Q?EwW9VHwwBCbGWhkZv4p/W8XgoaK6rnCdngDH0P9j0ly/MaaqL6khKr09X9CU?=
 =?us-ascii?Q?rORli5lQCkwQgz+Atu4h0W9dPuibtWQEaEmkh4QyWxgxqx5C9/IS1fIBfNMM?=
 =?us-ascii?Q?IWXMeO09AfUcwstHf7FekzWJmGI0Xcl4rIuz7gjgCAqZYDt9UBZuuMSs4Oqw?=
 =?us-ascii?Q?JmluaS2OzAZk6AILPqcB5h4DVpP/6AUGZ7PxAoobSAGxepgw8ApyIC/2UKV3?=
 =?us-ascii?Q?S7nyXHEycm7d/PHRmeRthGhVkJn3O/juv+gGqskYJrbKFhz0m6JMAqw2uPvq?=
 =?us-ascii?Q?xxfkYXwI2O2ARVQxUuL1v1H5MVRUyip0Mu3ZjE0Y+GivRnK5/VOKKyDq5iLU?=
 =?us-ascii?Q?oQs4PNaR1P0Qz2YeKRTs3lK6T5A4eOMNhbt3jnhcZLhIqNUD/qlJ062Txm9Z?=
 =?us-ascii?Q?ibmdJ0Ku6Y6fN/0XUNiWIBGrwx57EZt7z92btzGPkHMM/ZGwyklaTqOf3LlM?=
 =?us-ascii?Q?ZY2538noNSk6zAuZCiH7/yYGY+W1jSacEyuUnPMMX8h4ceckbOkNXQ7KykHR?=
 =?us-ascii?Q?QcrmaUxECldJ7bEcQAW8o6+KAcdBT70CyfK3wqdlrmxPTDIDcdFsOhIbXEkq?=
 =?us-ascii?Q?1x3Pip662wipz6y5MB5InCsJ5atAeI+ogto19J96I4hacmR5NppdMaq5NLKQ?=
 =?us-ascii?Q?nVMkL0q/NXWmFAc+9GaP1/DDW5pVb0FUSSWM8s8oYR3HbI3EVPAauVyGzf+w?=
 =?us-ascii?Q?smz3SZpdmVXXDsepMpwxOINNueCanQcf+qb6y5DQbg6oTr8gm9GoD+4UGi3+?=
 =?us-ascii?Q?FNNMy99SxknUm9cZe9jGZzrfQ/QvJgf7Dh63RzfTLEFjfPItSeEzvXEe8f4K?=
 =?us-ascii?Q?YvHsRw08rftYjuP2Qkdo+9oXGTS+HDkydhs5dw2SRGET0r4TmZrWsRXme5J0?=
 =?us-ascii?Q?NtjzMReKpZ2eTFC6nHeoqihGVu6giNLPzYtfXV4WWWFYDMRSoTkKDqZ64Do7?=
 =?us-ascii?Q?dpz35IsHR7TEgch9U6P/xe9CiCb0euln/BA8b/CzxMdnKz/QzgNHcJCECso6?=
 =?us-ascii?Q?bpGNzgROk27gtnhLs7m23WQp8DB3LK+sMTlHthodz0OmZQW34A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:31.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce19a6-e46b-4c4d-d45d-08dc8a36e2f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Empty SST TUs are illegal to transmit over a USB4 DP tunnel.
Current policy is to configure stream encoder to pack 2 pixels per pclk
even when ODM combine is not in use, allowing seamless dynamic ODM
reconfiguration. However, in extreme edge cases where average pixel
count per TU is less than 2, this can lead to unexpected empty TU
generation during compliance testing. For example, VIC 1 with a 1xHBR3
link configuration will average 1.98 pix/TU.

[HOW]
Calculate average pixel count per TU, and block 2 pixels per clock if
endpoint is a DPIA tunnel and pixel clock is low enough that we will
never require 2:1 ODM combine.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 72 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4f87316e1318..0602921399cd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1529,3 +1529,75 @@ void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		}
 	}
 }
+
+static bool should_avoid_empty_tu(struct pipe_ctx *pipe_ctx)
+{
+	/* Calculate average pixel count per TU, return false if under ~2.00 to
+	 * avoid empty TUs. This is only required for DPIA tunneling as empty TUs
+	 * are legal to generate for native DP links. Assume TU size 64 as there
+	 * is currently no scenario where it's reprogrammed from HW default.
+	 * MTPs have no such limitation, so this does not affect MST use cases.
+	 */
+	unsigned int pix_clk_mhz;
+	unsigned int symclk_mhz;
+	unsigned int avg_pix_per_tu_x1000;
+	unsigned int tu_size_bytes = 64;
+	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	struct dc_link_settings *link_settings = &pipe_ctx->link_config.dp_link_settings;
+	const struct dc *dc = pipe_ctx->stream->link->dc;
+
+	if (pipe_ctx->stream->link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+		return false;
+
+	// Not necessary for MST configurations
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+		return false;
+
+	pix_clk_mhz = timing->pix_clk_100hz / 10000;
+
+	// If this is true, can't block due to dynamic ODM
+	if (pix_clk_mhz > dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz)
+		return false;
+
+	switch (link_settings->link_rate) {
+	case LINK_RATE_LOW:
+		symclk_mhz = 162;
+		break;
+	case LINK_RATE_HIGH:
+		symclk_mhz = 270;
+		break;
+	case LINK_RATE_HIGH2:
+		symclk_mhz = 540;
+		break;
+	case LINK_RATE_HIGH3:
+		symclk_mhz = 810;
+		break;
+	default:
+		// We shouldn't be tunneling any other rates, something is wrong
+		ASSERT(0);
+		return false;
+	}
+
+	avg_pix_per_tu_x1000 = (1000 * pix_clk_mhz * tu_size_bytes)
+		/ (symclk_mhz * link_settings->lane_count);
+
+	// Add small empirically-decided margin to account for potential jitter
+	return (avg_pix_per_tu_x1000 < 2020);
+}
+
+bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+
+	if (!is_h_timing_divisible_by_2(pipe_ctx->stream))
+		return false;
+
+	if (should_avoid_empty_tu(pipe_ctx))
+		return false;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy)
+		return true;
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index bc05beba5f2c..e27b3609020f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -97,4 +97,6 @@ void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 
+bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 30e6a6398839..428912f37129 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -161,7 +161,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
-	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.is_dp_dig_pixel_rate_div_policy = dcn35_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
-- 
2.45.1


