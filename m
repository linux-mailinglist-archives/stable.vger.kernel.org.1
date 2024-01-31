Return-Path: <stable+bounces-17528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0D844894
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 21:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F671F22A9C
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186D3FB16;
	Wed, 31 Jan 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1dzO6D3"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0B3F8F9
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732154; cv=fail; b=PD6DRWS8xixAciMk8OFKOeZ00BCCnybhFMrQsRKaIYOVL9+SHxDMN9rNdWC5YRP4DqfuQ6QDh+45mVeQCxGEEuORQK+86Nr5Mwe6kb5uqtuxtlR8j1zBtQtdCN94rrQ8UOPR/EXTFjBgQBGuS8Pji9FF+rqMhUIV3PRcIq8I52s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732154; c=relaxed/simple;
	bh=+r5klbzjvzj6HT1UDSzV9aL1JxuqoBUdx0NJa+036eI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YakMdGbuaQ90OJLu8zDdWmgi52hvnyXgWYG/nP+KuFO1++mQvu+r1OxWw2XpnXarqQsEw8EKv9m5bcNgnh5pKuLB2f93NAt5OoXbnpXbM4xhloy/3Pgrx+t11uJ60qKVFzVmkfaVTBzFt3c/dGfrXDRNhYJz0QZW/rdcgHUBrW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1dzO6D3; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ6TSDHiZWrr/HNYEf3LQro/UrQwXgAU+27bUsz5iyZqzuzX4UF0By7i9a7sw8f9CBXLtf8RHKOFQji2kbCS81w+jZvrm4s7yaev0otN6XQ4c0ZP0DZAzfghOC/NLIxCCJ/lTPGTxTfpXwDPB0mljn8W49KCr6nnjWeIgDZSoRQa1lL7xLLVfppkpOggOdlNB4g9CUkQdt56czdAsbGKbCT69djwDj8rud/sIyharfSM/Pyj34/QjKZ2yvL9G1bMzYxq1VhairwQmLxnLduJb2Otjpwi2QUwYDtTg4fuEMVCAUiSaCDElIbTXvqjCFPHM9kwvCrwTWU9RYvafGmi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiROGyWKDuIl5zbMb3PIp+xXM337ozdqHldugy18UsA=;
 b=YkYnDBCUFTI3I72cybSqs86Yd98hXEBcXMsH9epC9NdZesHy7x0rJv3LNE779+SToCYDKaZwguL3sx3hH3VPzRZJ9u4AEEF4qwYxNpHAvsql+PSI4LlcuCb94q0R1gTGGlWy5Sk/gXyGQVrvr/9ccyxcC+burzgfSaW+VNMpLqmj1+c3/LaRFnY49+m0u9q8DAg8299QXgHZ+rFPKxpmi+fmLrbZHLMkrKmIUmvLuvHsKM5Io6Z1tn/gWYgWirVO7fgN1vFRUIsEA30BY1UhKRFWaLAOls7s1FSuP1b5M5R+4kgkvwln6x6F3RGuLOF3t3RlK4fcq4A8D8y+Gwz69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiROGyWKDuIl5zbMb3PIp+xXM337ozdqHldugy18UsA=;
 b=i1dzO6D3UeH9hd4gEh+lzd/GCr2Lb95cmeN9yDmDlo2jaB/22WSvxYHY5dxjz4EndIIOJyxB4Z0HjkdLUdvxZDSw8nh6BksbtqsofDfurrj51aJ5yW7iNhkQASt5/n6bH6uk/g5DYXZkO0a8qCCb/8zLmeXh258VHZWEzCVRtwg=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 20:15:46 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::6e) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:45 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:52 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
	<stable@vger.kernel.org>, Samson Tam <samson.tam@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>
Subject: [PATCH 16/21] drm/amd/display: Update phantom pipe enable / disable sequence
Date: Wed, 31 Jan 2024 15:11:22 -0500
Message-ID: <20240131201220.19106-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b536087-4afd-4f84-857d-08dc22996848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PoE//CzC6U4nEkw/8PFQ3vQdjdJsU8yVmVoQwCb2+r+EX5z6mrDQrY+SpylnJN8KsglkW7tZ5u69mvmHsMu+iJl1UKyv2uqZIhWAzbgezvXjJPmVLMcO00x1nexO0hmBj5fKX8mzLv2LGvmUwe+bf8HAdj01btyft8pmGmlx4i6VGCExr8wvqtPBAYTqCbMaUgkZ1C0nNDuHZ7VfSjcpjLQovuBTwZRqXnNAyvSPpbRfRTmd1Kp3qjBwAHicmZ7xnpzscetDgt7mB+XdVU2hw+xuGcyO5ix23oYvT5ruijsuFg4gStEh/0zAqShKUMMLxl22qWxtcW/mFG+rksQWQ1/J7NnPgHzUnGsfsLScNfSv7MJ20+ri92xpxSbBNhYeKhA7QBU7eB/bt+M5nOLPeN5NKS21XHLy0IEs2Rqn0kPOyRq/0QNXYKj0JSGBpm5HJ9ZPyfJOWKkI7HzArKjU2pL2mOdShKNGDHQSe+o201gImNMtpvf9KTX9wIkRRtFEV/B+SoIHnKsUtthP2xt98vUHhWpS1X8ExHEB0QQouIebrYNo5vUKJWjBFfz/08+WR+UwoYefyB61t1EzSrKi21GzDEwy0Y6RQ3BuCFyjNaq18ycB++g1/q/knQ4EUR1EtwPEMQeVMC5zlIE6s1zMC0L0+JcKaD7iPjEBlxat6nADTccyh/Os6dAKkl9oAdRl7xN9zqy13eWGWxmW0YLtecGNk/F4gESwBxUnH8B5Apr/6qzgJ5PzrLkQUfB/Qm+Pye3PNv5ESJJHCFkO0JiolQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(70586007)(70206006)(54906003)(30864003)(15650500001)(5660300002)(44832011)(2906002)(316002)(47076005)(8936002)(6916009)(8676002)(4326008)(508600001)(356005)(81166007)(36756003)(86362001)(36860700001)(26005)(336012)(16526019)(6666004)(426003)(1076003)(2616005)(83380400001)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:45.3910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b536087-4afd-4f84-857d-08dc22996848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530

From: Alvin Lee <alvin.lee2@amd.com>

Previously we would call apply_ctx_to_hw to enable and disable
phantom pipes. However, apply_ctx_to_hw can potentially update
non-phantom pipes as well which is undesired. Instead of calling
apply_ctx_to_hw as a whole, call the relevant helpers for each
phantom pipe when enabling / disabling which will avoid us modifying
hardware state for non-phantom pipes unknowingly.

The use case is for an FRL display where FRL_Update is requested
by the display. In this case link_state_valid flag is cleared in
a passive callback thread and should be handled in the next stream /
link update. However, due to the call to apply_ctx_to_hw for the
phantom pipes during a flip, the main pipes were modified outside
of the desired sequence (driver does not handle link_state_valid = 0
on flips).

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |  4 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  4 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 76 ++++++++++++++++---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  3 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  7 ++
 10 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c81f8af5d374..72512903f88f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3851,7 +3851,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		 * programming has completed (we turn on phantom OTG in order
 		 * to complete the plane disable for phantom pipes).
 		 */
-		dc->hwss.apply_ctx_to_hw(dc, context);
+
+		if (dc->hwss.disable_phantom_streams)
+			dc->hwss.disable_phantom_streams(dc, context);
 	}
 
 	if (update_type != UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 88170ab0ec7e..a390a9ef81d2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1528,7 +1528,7 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
-static enum dc_status apply_single_controller_ctx_to_hw(
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
 		struct dc *dc)
@@ -2355,7 +2355,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
 			continue;
 
-		status = apply_single_controller_ctx_to_hw(
+		status = dce110_apply_single_controller_ctx_to_hw(
 				pipe_ctx,
 				context,
 				dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 08028a1779ae..ed3cc3648e8e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -39,6 +39,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context);
 
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct dc *dc);
 
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7557e58f58b2..bc0a21957e33 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2671,7 +2671,7 @@ void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		tg->funcs->setup_vertical_interrupt2(tg, start_line);
 }
 
-static void dcn20_reset_back_end_for_pipe(
+void dcn20_reset_back_end_for_pipe(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 90316327e6fc..5c874f7b0683 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -86,6 +86,10 @@ enum dc_status dcn20_enable_stream_timing(
 void dcn20_disable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_enable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn20_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context);
 void dcn20_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6c9299c7683d..aa36d7a56ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1474,9 +1474,44 @@ void dcn32_update_dsc_pg(struct dc *dc,
 	}
 }
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
+		struct pipe_ctx *pipe_ctx_old =
+			&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(dc->current_state, pipe_ctx_old) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream || pipe_need_reprogram(pipe_ctx_old, pipe_ctx) ||
+				(pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)) {
+			struct clock_source *old_clk = pipe_ctx_old->clock_source;
+
+			if (hws->funcs.reset_back_end_for_pipe)
+				hws->funcs.reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
+			if (hws->funcs.enable_stream_gating)
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
+			if (old_clk)
+				old_clk->funcs->cs_power_down(old_clk);
+		}
+	}
+}
+
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
+	enum dc_status status = DC_OK;
+	struct dce_hwseq *hws = dc->hwseq;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -1497,16 +1532,39 @@ void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 		}
 	}
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (new_pipe->stream && dc_state_get_pipe_subvp_type(context, new_pipe) == SUBVP_PHANTOM) {
-			// If old context or new context has phantom pipes, apply
-			// the phantom timings now. We can't change the phantom
-			// pipe configuration safely without driver acquiring
-			// the DMCUB lock first.
-			dc->hwss.apply_ctx_to_hw(dc, context);
-			break;
+		struct pipe_ctx *pipe_ctx_old =
+					&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == NULL)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx->stream == pipe_ctx_old->stream &&
+			pipe_ctx->stream->link->link_state_valid) {
+			continue;
 		}
+
+		if (pipe_ctx_old->stream && !pipe_need_reprogram(pipe_ctx_old, pipe_ctx))
+			continue;
+
+		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
+			continue;
+
+		if (hws->funcs.apply_single_controller_ctx_to_hw)
+			status = hws->funcs.apply_single_controller_ctx_to_hw(
+					pipe_ctx,
+					context,
+					dc);
+
+		ASSERT(status == DC_OK);
+
+#ifdef CONFIG_DRM_AMD_DC_FP
+		if (hws->funcs.resync_fifo_dccg_dio)
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+#endif
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index cecf7f0f5671..069e20bc87c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -111,6 +111,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
 
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context);
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context);
+
 void dcn32_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 0980df6c65ea..2b073123d3ed 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -109,6 +109,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
+	.disable_phantom_streams = dcn32_disable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.subvp_pipe_control_lock_fast = dcn32_subvp_pipe_control_lock_fast,
@@ -159,6 +160,8 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 91b1b43a728f..f89f205e42a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -381,6 +381,7 @@ struct hw_sequencer_funcs {
 			struct dc_cursor_attributes *cursor_attr);
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
+	void (*disable_phantom_streams)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 6137cf09aa54..b3c62a82cb1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -165,8 +165,15 @@ struct hwseq_private_funcs {
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
 	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
 			struct dc_state *context);
+	enum dc_status (*apply_single_controller_ctx_to_hw)(
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context,
+			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
 #endif
+	void (*reset_back_end_for_pipe)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context);
 };
 
 struct dce_hwseq {
-- 
2.43.0


