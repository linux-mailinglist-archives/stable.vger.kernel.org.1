Return-Path: <stable+bounces-10462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7F82A3A5
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 22:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693B1281F5B
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F14B5BE;
	Wed, 10 Jan 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MIjA4aGt"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5794F5FB
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpPjhkkKLVzocTR0eH+Z5+YvsXJl8eC3ZvWiVCCUGDWTrnRZEs8CVgG4xBh3ODDzr9BLh4xkibGWkGmyh4PywA1Iy66xV51nFFJPGewtV4K8LcQlEwWJSXGj8OBI0cbYuye806jnUqiEIMzuaHz72BGq9iLvb2IoLxwKJk2J22jlXeLX4i54b0K25yc5olgUm8uO5H09+tx7ACchOvVl0796sUnw97yRwjZpQezK9BJnYvq8rT6Y0YToebMQAD4PZMEwuv5GAVUA8hQ/YNkbCic3Bgf+SVEIGkm0LNL0APcdM0uS6DXeXG7k5sFmwI3JPZhXF0mjQY+v4J2lkerG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jU4RL427Dqk5UZxNhSVi8y2HBrweLozfXO61lafVvQ=;
 b=LSHdQ8tj6LASlKbPP0FpUTUqOeLuG31ZjR6hdSpF1WUiRb/COyVkv4zKtF5mzdpIMA1mlbGyfbh6cHMOtTkRb+kRu25S+el5fjx0KdOeZ8MXAC9Ky+11XHc+yiKDd+Ci4HSOWcHdovwkbURddpAUHaT95vC01Zkqn7AY4+Ff5OINVDh8Q2vmzBKcTWmUOrLPzV2zlB/s16V2mT9CoPOofrOpxjjfuGFeP4XpJsk1OABBz6awI8v8x0KeChj/026Aohzgum4eaIG0an5JlNmkeRjp780M5bdpu/ZBDktzZMvuh4XmUScwojyuAN0tQA/3eYvLNjzlzZnBflat37fwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jU4RL427Dqk5UZxNhSVi8y2HBrweLozfXO61lafVvQ=;
 b=MIjA4aGtvHaNlafWLEhJpm4I3Tk/0ynCRKBNLGg05j6/hK/JYhfaPQ4agfizKWNrWhUP1NN7/EHIdfZQ+kImtdMpvUBRvzTyjGTeTEcbJxsSeApW7OX3Zm/e0U4uUN81Qd5igt6hdKXpdOAffMQK5saM5aVbuX4zu5K4gniQPsA=
Received: from BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 21:54:51 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::e4) by BYAPR21CA0005.outlook.office365.com
 (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.8 via Frontend
 Transport; Wed, 10 Jan 2024 21:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:54:50 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:54:48 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 05/19] drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A
Date: Wed, 10 Jan 2024 14:52:48 -0700
Message-ID: <20240110215302.2116049-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bdd3d7-29cc-4bf4-1a49-08dc1226c57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lseUsIkkYhX51gSrUmC4fqBMPHmg8vmrXJprhP6/RrLAiCe5C/ACzU+rC3OBalZcq5aXKJOMiTTQD3AGqJZ7yt4Achq5QPLJTWUAacQMwDuAAYMbx0yxQO6zESY96w6O+6fUSAwNjwLD7WhmQZsUqVdEnP8OMZIw5JObgndytD3+Dl/O7WTqJ63GFPjvSG2HUYaA5YRgq7/R1kHXkiRoZfh93R3Y+tYO/FnJ1YBTQ/Og6XmbeN4zO6cs57xnvusgzcYqrf31cHfxfkHGxGcWCKjGXP+rIKeBFvWLgNu6DsCjZcgyz4AQGgoCCdzgSFr8zUsnh2bncgWTb9n+rZRdS3KuixlIKULePD9TLrtFTfx9KOZt71YXFkCa3Ks5vKAv7QM5I6oORfkX1rH3RooKffhmzHO8i0uG8nWjMH405t1Eybr3Vwnzp6ZPq8Xc8iopI5Jf5se/HmbTFBaWa29rmdAnil/BApb+tFCKrv3WL+CjQLKFcnBsHCdz2W0/z0tW+FYgZE9kmzh4C/SDvaLH4EnCn2Dflq/cr2RrkfVi7QGHsAVCbg4WY4jpf4STyZKkUdhtdkTMeE/KUuC8U/7Y6YLiD/CARzc54sa0tDI8KhUhGbKjP2mRwRFQ6+IHoNkQL+wPIxvkw9ONt4/Qd8Nxx35cI17A4aE/x3AAmJ6JAUHV6Tilc+1mdx4/+ewBZ7W/NhSP0VLSv2DH7HwG+4yBKES6mPW7DIL6A4L77vCpRgaXpWm4Itmejje1a2MHQkaUPKoUk2flApzrVyBhFw2r2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(26005)(2616005)(478600001)(426003)(336012)(7696005)(1076003)(82740400003)(36860700001)(36756003)(86362001)(81166007)(356005)(2906002)(41300700001)(83380400001)(16526019)(5660300002)(70586007)(70206006)(316002)(54906003)(8936002)(4326008)(44832011)(6916009)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:54:50.9597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bdd3d7-29cc-4bf4-1a49-08dc1226c57b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We can experience DENTIST hangs during optimize_bandwidth or TDRs if
FIFO is toggled and hangs.

[How]
Port the DCN35 fixes to DCN314.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 878c0e7b78ab..a84f1e376dee 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -145,30 +145,27 @@ static int dcn314_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+				  bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = safe_to_lower
+			? &context->res_ctx.pipe_ctx[i]
+			: &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
-			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
-
 			if (disable) {
-				if (stream_enc && stream_enc->funcs->disable_fifo)
-					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-
-				if (stream_enc && stream_enc->funcs->enable_fifo)
-					pipe->stream_res.stream_enc->funcs->enable_fifo(stream_enc);
 			}
 		}
 	}
@@ -297,11 +294,11 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn314_disable_otg_wa(clk_mgr_base, context, true);
+		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn314_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn314_disable_otg_wa(clk_mgr_base, context, false);
+		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
-- 
2.34.1


