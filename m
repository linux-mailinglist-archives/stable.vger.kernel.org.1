Return-Path: <stable+bounces-35873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020289794D
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A341C26A4B
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDE1553A6;
	Wed,  3 Apr 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JTvbKbKm"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6B152DF5
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173914; cv=fail; b=K9EciqD0uXUDWdQWdmCdj3bOQ7IAsAEFTBcX+IaKrXXw9zRgF1Ibdd+MHJ0/KeikqFoKJU4z2hO0Wh52iD07NH4snLInSeXopM8y3GNv7xuOjg9fBaAUPQnH6Hm3oOmWP6MpD4K7R2MKg3sepKF50RHfUVRrQ68NrX0TMgf/L60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173914; c=relaxed/simple;
	bh=JPc1EP9ze5Li8X4H2YhVdmzMjYlPZ6q0G0Gy+9Zrhag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1LNG2opfSa2cTDPnBGh23vIgQ3JbUu339Xq14MNCqrgDezAiGofL+6DEB62E799+OglDKRck5JL0VfLTu7kbxZAeuelGQiexifs2TTcvedT+VeopldL2ypabP5QQd+r++0ZWBbd0pmwQXI5ADY+KwyomCt1KxIq/GIzOwJ4TN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JTvbKbKm; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvM5GAevHav0TTDD+2Sfl2gc7EGWawAh1b/5B0TlYODxWF5eVIpJq7yJUmrioVjdsnW1WsXnlQlL0zzOa2Or76TNBNzIrUNeTH3WjYwDNRUKaSKzdrLTjBgIMg+Ody/Pq7rQTkGij2TQ1yMENU5UlUGRHpA5Dyl53HMsnxThUoZbioMy0Fw8BCBHy8FtcnYQGI+bmCdSJS0UOUn1i4UmSQ2h1aAHDw52oyEkSDz4vXkNEenbivg02+6UAuwSFSy0qCyQispp3V/aGVPeiwueyAgnEcJG6jjvE/AF46aMejpkz+2x0K1io/0MJD8TfvFk2Rc8DF/1Rx1tLqSyoAo85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf50HEB7c46RxxGS2Gx1FYZwIgR3ugZvOn1bZtydcEU=;
 b=LoFgNUJWxuGsynxITkwDvuOdMEaj3QUlNVso6jTYuuw68VCwE0XB5DB99PPt7XZx0P0352EjckpuYqvUyiqL5RlUWrz3YdbvI2EJoUZKt20p2Lp7Q43zNjXNWl0AO2QXfw8CUPWV0aqHWVxvbQVPAyGJmz/Gss0th1ClN2MVv6Iig7FVgG2Em9SkFGeHYNP8+5JYQNYDS8hTPt9xxvIRftRjXmTZYKNjwMHNtEOofOdxXRqKBdpXtzsFZyeYB89eXjs3VRbVu3+Q91qIinvQeABwqJcsexpPgEy2sYN2nH8Bpr6cQinAC9BNhLl1pId0lS0PgXNEt55PhnwAVQ1ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf50HEB7c46RxxGS2Gx1FYZwIgR3ugZvOn1bZtydcEU=;
 b=JTvbKbKmnUsStSyQ7dwOXgUeVpY3JFszvU/9Lful5AX1BNJognNX3aglls8mYppcSYFFs958509/ckjNvkB1BCqWdreGSMSUhlneYRTmmoQJVw+dIs7rhzAqBNB15NPHVuTZlsmi+I2hxfY6lLKVSfAZapWyTh/i2tW70WoEpw4=
Received: from CH2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:20::24)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:44 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::d6) by CH2PR07CA0011.outlook.office365.com
 (2603:10b6:610:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:44 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:36 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Fudongwang <fudong.wang@amd.com>,
	<stable@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 07/28] drm/amd/display: fix disable otg wa logic in DCN316
Date: Wed, 3 Apr 2024 15:48:57 -0400
Message-ID: <20240403195116.25221-8-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e93b28-9748-4216-8dd3-08dc54177d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3cSWDEYp+8xhqGpMDHQ8CuGMNwLJK4hb/yvCD44sfqaBw9hzlwtYo45doQrba5cW5hpBsEN3RQnwU0tiE2+vMlmLag59qZwPxWJcSdaWYCZmY4tMm1He6dxZE9fADW88pWnUt2Ao30b+oDN+tmL4GG/v6xQWy8bPdXo6UNnm00hs+DausJD/6DvrT2YWh2kzW+oEU7gdb0SAviv759iWTDZaqunFoRD3UMMsvzOhs/H9J0MUpsbtx/4s/pCgPkPafr3ofIRULc1wGrE8aQrnMcpxOwOuJwWg2xr/fN1sM2AMGapBUGucqiAy57FcfikTOdSVn+P19vgRrYIdQsqIVl588qsDB21qkiTP5VVxISbTw+h62uqMif8c1vyLm3adW1w96du+/jRJQanepWojAgRo0bcYo2Rz7QCrkvLvJVCbVZz5S2pfbkYeKznJebpKLez75nojDagqgM3RtrG3diLNDHci5ye07hiBUk52DXsuBVYoydAZVNxUn+XSClhTQty8pFMRUy+jOd7VBelHFjJFZBO/u5dvBADZ/ycJUEaDbGPzCRhklXLBqawbE/xmGjcsqiyObRP3zKvMiYpNYeUdSGUv/C6EjsgVuGfLg36Rb0XZCx6wUcWOsu/yyWKKM0KwFC8BW+dEKHMSmMLDp94EUv0k1+xomXlAltL8M6lELmyvGOMb2ebnB4vj+t1QDyUKAM2yB21MRn1PZRetNloTfwJ32OdBJQeRxqArLOQZPvqbrCYW6PTUnX4DlikO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:44.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e93b28-9748-4216-8dd3-08dc54177d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

From: Fudongwang <fudong.wang@amd.com>

[Why]
Wrong logic cause screen corruption.

[How]
Port logic from DCN35/314.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fudongwang <fudong.wang@amd.com>
---
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index e4ed888f8403..20ca7afa9cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -99,20 +99,25 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+		bool safe_to_lower, bool disable)
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
-		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+				     !pipe->stream->link_enc)) {
 			if (disable) {
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+
 				reset_sync_context_for_pipe(dc, context, i);
 			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
@@ -207,11 +212,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, context, true);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, context, false);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
-- 
2.44.0


