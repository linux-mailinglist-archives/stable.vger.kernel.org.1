Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DD785CED
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjHWQEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHWQEx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 12:04:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9703E78
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 09:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5vlnjxrOjB3SaIz/wNSiQUMFYCUy9fKQ9/DhZIQuxnwQPUzIiHinhrhe0wV5Rh0R5OhHNWIDL/umMz2Gs6e29c+82wlqKmGjToGbINDj/zE1THrPiHFYpMWzuTWFhSRQfpBYwViEsrC7Fi94pg3vDPYsn/ggFNS8+ApWFBjABNxvMip1pHRmxzunFkSmumF2yDV6vT257pZQwlE6ce9VV/nJcI/cLhn3ooMHrnbQLAK+Yq02RNPR6/Kms2xz/rLGAcKD8ZsuK9nMtoA6rSgv5EXfPW7RZie361zuChdkQNwShBlHOQ7f3WlyYN5GrxdiU3SZVZLv+Vhd1AJ1AUopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZsfuoQIe6XeasPT5Yq0sHP1lUe7w3m5k/yV2UoToe0=;
 b=chsCrCSgB1kQcy1TMfgKHh2fQxw9ydTt3Vjxpln7Fw/dvg+oGMSvYTGGPBdC66J/UEXNjnushPbE5vh4fCk65/e1zkgu94GnJ1f9vxAmSdvyHH306hXhaoFK15hTXW4SsTS4laQwO7gBziTni4QpnpkMYitRTj402ZaPz8Qlf09Qnenl9I7LdxGF9T8Q7rcyta9XuydUtelq94V2cWJ+fLK/uMjKa2jk6soZ54TMPcMhb1NtRgmEsd+8qclM2Bidi6gbPRdIFY6/qorS/8maCJCWeN2yXfadSYOTQ3z1j3ikh+yh29HPXNKBLWBtf4K+ujhaKUw8ALuKaWQeQhlYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZsfuoQIe6XeasPT5Yq0sHP1lUe7w3m5k/yV2UoToe0=;
 b=OKEawOBTPYo5HLuEXFOaRHBc5b/Sfj9KdqgHIm8/0qgHfovzydhSFp99PDeOT/f4FEMBsEmWIzBo3Ofzl1de3SoRIpVPi6Y1hxlbpKARQv1UIO9kzlqG73xwoSw4QC2kwZsGsq5yO9LjBSoQFmKL3FYq0K14fDc3WlZidH9Kt2c=
Received: from PA7P264CA0108.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::8)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:47 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::3) by PA7P264CA0108.outlook.office365.com
 (2603:10a6:102:34c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:45 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:36 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
        <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>, <stable@vger.kernel.org>,
        Jun Lei <jun.lei@amd.com>
Subject: [PATCH 15/21] drm/amd/display: Remove wait while locked
Date:   Wed, 23 Aug 2023 11:58:17 -0400
Message-ID: <20230823160347.176991-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0369d0a5-1b42-4cb8-defc-08dba3f2ab9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faxA9QGqLGMNwbk9FB8/Ns3f/fa0XBdusS0kdVNnH1qhN59GR6561j7FqL+tV7PA5nopTlc7ltjRzzSNE/MMqkC0qCqbsDVLT7jFlFmDOxVwiBGLjq9fXjheDDFDc0eAyR3TGt79lps9tNRbwOvWOyha8n3xiLK7glqHAkiRgR56GRnK8Me2h9Vo39PXHkEIxKaem8TKKvUtIpKTsBlfWndDV+ok8u6oHRzyL3CXSSCb/lbQdwLSLQ/jGc0n9dmDV+ueAWqst1AXDhWoUGiEPvHRV/Iz+gfjTkqROBNuzkCL4yG3R7zzQbZjjHxNarM68GpPW9TcNkR0TC+ynbQlY41TYjKrjMB3RmnSnNty+H01u0sxq1RE0maMB8+TwqKx3uVsT02+2Npl1vvn50cZjzEXZaaazpyw7TC9b0hdHsuge62UoBOzk2ce+SDHDj+g/ETryyX6p8b5DrKWhi2NSJfUKM8cqdEnWSPoHWvzCMIbqbpoOLkXA96cKZ5O3lLrtcVucmrCGBh/PQ0u14dAtnDoyrLUGSqS4Pst1AXrh4yxp9pKnplthnVOAqq8EIXM3y7+LVmAvK6bjz98F2Q9qTTwcCRHdL/DxncYSZy/BsqmcdSfg0I7eVV5M/4gs+KAVdtGbhGA5P1+dONROmgbtooeXLWLcmFkgnVgWztTwayo0pNsGDBVYlbdCmEMVGvQ0iy230rdVADolVVVzdo28f7+KtGCoFkajuAE9jLiSxBsxzMkHlz6f3XtPKm0PX5JTDBsLMJPbXv/tUaeZJQBkePAErLlAma9gTVC/cHILPSV5qz9J6v2FrfUAHnM/m4a
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(26005)(16526019)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:45.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0369d0a5-1b42-4cb8-defc-08dba3f2ab9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
We wait for mpc idle while in a locked state, leading to potential
deadlock.

[What]
Move the wait_for_idle call to outside of HW lock. This and a
call to wait_drr_doublebuffer_pending_clear are moved added to a new
static helper function called wait_for_outstanding_hw_updates, to make
the interface clearer.

Cc: stable@vger.kernel.org
Fixes: 8f0d304d21b3 ("drm/amd/display: Do not commit pipe when updating DRR")
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 58 +++++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 ----
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 69ffd4424dc7..1b8c2aef4633 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -78,3 +78,4 @@ DC_EDID += dc_edid_parser.o
 AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
 AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
 AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB) $(AMD_DISPLAY_EDID)
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c6f6dc972c2a..5aab67868cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3501,6 +3501,45 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		top_pipe_to_program->stream->update_flags.raw = 0;
 }
 
+static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state *dc_context)
+{
+/*
+ * This function calls HWSS to wait for any potentially double buffered
+ * operations to complete. It should be invoked as a pre-amble prior
+ * to full update programming before asserting any HW locks.
+ */
+	int pipe_idx;
+	int opp_inst;
+	int opp_count = dc->res_pool->pipe_count;
+	struct hubp *hubp;
+	int mpcc_inst;
+	const struct pipe_ctx *pipe_ctx;
+
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
+			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
+
+		hubp = pipe_ctx->plane_res.hubp;
+		if (!hubp)
+			continue;
+
+		mpcc_inst = hubp->inst;
+		// MPCC inst is equal to pipe index in practice
+		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
+			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
+				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
+				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
+				break;
+			}
+		}
+	}
+}
+
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3519,24 +3558,9 @@ static void commit_planes_for_stream(struct dc *dc,
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
 	subvp_prev_use = false;
-
-
 	dc_z10_restore(dc);
-
-	if (update_type == UPDATE_TYPE_FULL) {
-		/* wait for all double-buffer activity to clear on all pipes */
-		int pipe_idx;
-
-		for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
-
-			if (!pipe_ctx->stream)
-				continue;
-
-			if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
-				pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
-		}
-	}
+	if (update_type == UPDATE_TYPE_FULL)
+		wait_for_outstanding_hw_updates(dc, context);
 
 	if (update_type == UPDATE_TYPE_FULL) {
 		dc_allow_idle_optimizations(dc, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index dd4c7a7faf28..971fa8bf6d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1563,17 +1563,6 @@ static void dcn20_update_dchubp_dpp(
 			|| plane_state->update_flags.bits.global_alpha_change
 			|| plane_state->update_flags.bits.per_pixel_alpha_change) {
 		// MPCC inst is equal to pipe index in practice
-		int mpcc_inst = hubp->inst;
-		int opp_inst;
-		int opp_count = dc->res_pool->pipe_count;
-
-		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
-			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
-				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
-				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
-				break;
-			}
-		}
 		hws->funcs.update_mpcc(dc, pipe_ctx);
 	}
 
-- 
2.41.0

