Return-Path: <stable+bounces-147905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8DAC5FBC
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 04:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE87AA04E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3717C219;
	Wed, 28 May 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WrB6f52"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D528E0F
	for <stable@vger.kernel.org>; Wed, 28 May 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748400784; cv=fail; b=E7qna6U4UjklJKezSpYd6kMWLyGxu5tdV5c+NrlRYSH8UW7K3NmtdUbo84qbJsLFbN8Z1hjrqSSuNY2DwRmoJ9VFau3DsagdmoX6aFy4OVx+iAVvVvbA/niLQllbLQ4q8CqNO9bKiQ7FL7y0mQLaGk2aZ5pMf7r0Kes1rh+JC4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748400784; c=relaxed/simple;
	bh=mFvk0QdG/uyBWGnqbz7Hikh9cEjleY5a7do1q7WUkGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVQdKxmJMqEnSUJZTrAUxVgA82CWPcAbZcrV+PgeCq/NWmdl29Fv0Ow+w9CnwzpRkkrVdx7AdxvBc3TrmdZd/2uYTNQIl+udXymcIL3EWCWbFQr7CfO+gUx0MJeLGUPzjC6GbID8Vl6TB8FRRc3uuHLA3X4fn+PQl/9Of0x3jus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WrB6f52; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr9qyAvKVDekodznnbz31Na8qVfwOrK9jNIXi4bWMRNuY5rrvuaupOE6XnonQSP1SE13XYowSFKU8GEh28vP4b24cvZenLLF95pbrv/4j4ZJJG7VkHR7d7G2UG9BOsCldvFjH5jnV9VVj+/bR1s7O3mvTU7TB6MEjy1Y1W/Swf3i0dMNiMIshyuGgXQf+S9/oNIQLPYHKmqQcmwll9uC41X75NQw+aSc1cHywIlNnq8gAQsvwKuDiWcsTRitLcg4gFs9sqWcMevqNWPdzOHfIp3BotQZ5L2a87SWYnk1qYgpfdLuJt6QYNs0n+ZMovXAqaPPbDWhDa7muTRV/7PYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjaP8NSxBvoau2+nmfLxg9G9NAo+rS9Ym6/K9HoU2K8=;
 b=LXtfRW35tsHCjCJ54Vn4ugRxcqQtQFArnt6kQAnlBuAm70XXompBv9UIEl3sF9wy8Xtku6NY30I0CRVXrJmw1vsFX8DAihUuVlqvgte4KdZRYVGBauPbKrKdFuiW/4AnGCGRM3gtJO9+191EqAEA78Go7qe3eqB5cLXAuz/R/jFUfL2UFn1iVjQXbnG1IXmv/zi4uPFj7T1zdd5NxbwHrLDino6uvmqk104K6IvbVADokeavVqaOJIGNy0UOiKki8d6+ru4KGwNeQlO0kqXVSOsh7Hgt2zznbxz2icUtm8+clk2/NV5w82AcLp7MmvuW210P2eLQ2ZqRbjuVAD5ggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjaP8NSxBvoau2+nmfLxg9G9NAo+rS9Ym6/K9HoU2K8=;
 b=5WrB6f52hNFmDEON5/NRD+91cpvFZ7L09E7qpcYLok5W8AfUru7+zW+SPr2H3bC3DqPOiXT/mVY3MfxIjV6/3y+bV4Kl1kK2IR+fNDfDbD5Tmgmp6oUKexgPU+lZbWdxcZXoP9uXszQRLYe5FsanZOmR2nPFpk49gntazOqPF6A=
Received: from CH0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:610:cc::30)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:52:57 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::88) by CH0PR03CA0085.outlook.office365.com
 (2603:10b6:610:cc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:56 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
	<michael.strauss@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Wenjing
 Liu" <wenjing.liu@amd.com>
Subject: [PATCH 08/24] drm/amd/display: Call setup_stream_attribute after stream enc clk is ungated
Date: Wed, 28 May 2025 10:49:03 +0800
Message-ID: <20250528025204.79578-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5890e0-f6bb-4052-da71-08dd9d92c00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKK10uu/FxdsILz2mUn5L0pFbWXi1GwMBcDsFEaVUYNu8oi5BmFqh7xAs9Mn?=
 =?us-ascii?Q?YwYhQ0rHd96o7BurZuntlruWk9n1T8U/D8uHZUGlj9eMfVhA9mulNIDb/d3A?=
 =?us-ascii?Q?U4JyR1dClneaD9msEMIlSE1f++ny7WhY1nztQKMoVUG982AsZ49mFrMoL5Ih?=
 =?us-ascii?Q?1bt56kfAxQ/H9KQK0OJFUxSZMLIlk288QiSVH35/h3ibchYpSYTjWlWD1q3x?=
 =?us-ascii?Q?C05cEAYoeg+C0Tp83J++3+PLc1dDnUEOCO9DPeIz3sI81xxA5BVanaBNSv6G?=
 =?us-ascii?Q?MnuEKtXiKSLeNKCTHjk601HJe0utmkaObdHNx5Ez7Y0i2FigtDOS1fJvC3DN?=
 =?us-ascii?Q?oylGfmbVFBTxJwkAzm13f1J/yKG6+r9xgwiXXvXeZT8oMMxplDqIAWXFvpjn?=
 =?us-ascii?Q?/LejxapazTriYjRQnzoYLf4Ta4r4siL9e8QlVzYEpDJ2ovnuiwRlt89cpkKP?=
 =?us-ascii?Q?pNrwPH3AopifUACuM5c6BCoBxAXe1cazvBWv3am8pggxNZ7Snyc3/pdEuGYV?=
 =?us-ascii?Q?zzhE5nhpKfwHXJ/Op217Q/RcNgXXP9IdT8lEOoZ/brRd5HK7Arw6po2gX/JO?=
 =?us-ascii?Q?e/cYosguOoyPNdb87PZDqUCXaUh7WTzxpzHc073EHBx33tlGPbe2qIzfLOrO?=
 =?us-ascii?Q?i/L5WEg0ikCdhBAj1lG7toW/+4HuY2QGkLZbMjxmaovPQ21uzuzSBTZdlD1i?=
 =?us-ascii?Q?D/A0dnI/ol5sFGp4GZiWiy9wm6pAY5OixYSQJaZKwrqoi0dRp2D6GNxr3d4V?=
 =?us-ascii?Q?cVtvvcDJUplfXWyIQoGAgL33rX3VkD96yC3UjwybJkBfh8ufWMI5JUNKkEHn?=
 =?us-ascii?Q?5/SP4wNnDngB8lXjZMoByBsFUjSwDBR9nRQym899DyML9v1fFKwFCimZoJxZ?=
 =?us-ascii?Q?4NI7r9Wct91SE7EgiTHch6yogyvQ/ZBxx76bG8EihK5Offg3Q8zkf27BJSS6?=
 =?us-ascii?Q?qRZ+JSIUzMOufyxsRm9T4zNwD9NYeH02vYi/re4uMzvYATXjz2rwllPvG4Gi?=
 =?us-ascii?Q?rNjEsUV1lyeyeSethseqCmqdU14MSmlvn0GJpXg6+bo+gBfnADWBo++mII7v?=
 =?us-ascii?Q?DQnbX0mL8canXlhewIIqTAUofLpfsCOVnb6wB0IkV9JrTgawH3cwp8ZYLRXi?=
 =?us-ascii?Q?92fGJlxfCcj9/CLmy06uG1VwJ0eLE7bbb+n7gfRprm23U2Jk49+qu0JXC6yG?=
 =?us-ascii?Q?ijSDg77i88y9oWuBrURJUEGMXUOw66GFl4HnPzk4VFWI8Ou2Ax7RVf1JUJLL?=
 =?us-ascii?Q?ogE+sYNpK4J+I13x96llVwcJLOwwHkpqPMHT5Lqytgp5KEHBaCWfBTEwagRq?=
 =?us-ascii?Q?aPEJyUuHGzp6Y97WDn9/84mpeG09D8HlNFDG4VFNYOY95KZCCz4MuSrU26SE?=
 =?us-ascii?Q?Zy+HvfG11uGex67AFbNsq2stxJbM9RDKCzePTpETIwRoJurHuGk3YnHP30JW?=
 =?us-ascii?Q?7os5c6iBpV3REk2swzfYEyZ4VELHBPAhKo08fCAZZf8DKfMt5OEEAck6yAXN?=
 =?us-ascii?Q?Fzr4dqtlEejr/EnjPJufzwrfMklIfiJX3+gA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:56.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5890e0-f6bb-4052-da71-08dd9d92c00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
If symclk RCO is enabled, stream encoder may not be receiving an
ungated clock by the time we attempt to set stream attributes when
setting dpms on. Since the clock is gated, register writes to the
stream encoder fail.

[HOW]
Move set_stream_attribute call into enable_stream, just after the
point where symclk32_se is ungated. Logically there is no need to
set stream attributes as early as is currently done in link_set_dpms_on,
so this should have no impact beyond the RCO fix.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c            | 3 ---
 .../drm/amd/display/dc/virtual/virtual_stream_encoder.c    | 7 +++++++
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 23bec5d25ed6..28f37437176e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -671,6 +671,7 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4ea3b4ad179b..9f082a4c2610 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3046,6 +3046,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ea28c75fdace..82b13cc7a262 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -967,6 +967,8 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 273a3be6d593..f1b8f8f7b3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2458,7 +2458,6 @@ void link_set_dpms_on(
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
-	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
 		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
@@ -2502,8 +2501,6 @@ void link_set_dpms_on(
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 	// Enable VPG before building infoframe
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index ad088d70e189..6ffc74fc9dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -44,6 +44,11 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link) {}
 
+static void virtual_stream_encoder_lvds_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing)
+{}
+
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
@@ -115,6 +120,8 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
+	.lvds_set_stream_attribute =
+		virtual_stream_encoder_lvds_set_stream_attribute,
 	.set_throttled_vcp_size =
 		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
-- 
2.43.0


