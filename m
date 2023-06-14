Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C0730668
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFNR6U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFNR6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 13:58:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFEA10E9
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmp0HSb/Wty8IF3Cdza5iYJyq//xR0N2bU5XaxKcClR0d/VacBDPouS864o1QqCelvdN+OUgdHO7jnQO3fgE0ATeEvJ+chODLayUSyOLJiuwYOnWIpb6kT8ismy2VO0vM/cbK0kOFXz5rr7wNHHUpIoDVfU5nUIF9MhAXghJxSwP5N6l9wQkAy+60s3+0lSZEu/rreieTD58ruyvWAPfK6qlJFPFmMy58OQbd/vjB+oP84tJnKKb2CxVx4Xdm03WLPiD22VyS2EjWUryJXV5oPhsvirt2Z0cBGZF5zgrw/RgtjGtKKKqKtNJ3uueWwUDJnrDGKb7Ps3H6mQKay+5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KGuGR/ORR+Q1U5den30R0TrV8LlE8an/LSBKsAS09I=;
 b=Ez2lqvL9t950/ZVn38ro37IHq3LUGPglTxQ+RDwEAhHxAEzLqSyBXSR2B/oGPsiiJDB5gcOtiOP1k7tuy6XQZObgKDjpvpt5uxnZqToUfnsSskEzfyLsBNbw9KbHLTObLTGIeerUlVmt/CGuPcMGY9NT4mXXiPTHK61k8CqU2Ety2ItzIgdGOAJoMajQNH7bvrWqz/b7af9/oLGJGSE5YHmCLJVwyIfvoTIQ1T8zyOBge3mzPCyufxtmH7KhCTwXgQeOThN0ysrz7SNzyk6bBn1S3i3i7+19GnwjI+nOyveAtQKhjSNeWaS6kv6bPfc19rKA4/fp3l6WxzA4ywKcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KGuGR/ORR+Q1U5den30R0TrV8LlE8an/LSBKsAS09I=;
 b=W+W2A9qiJVgBeCLlv8Uye7KJZ0AxEoBkanM5zEX6TDVn3Lh3wS5gMTvbVm8sGEOcF+oRNezNyOA2yE48lKXHCewjcC4Y8AwAAoEjvITMWvj6nJ0v5gEneQpTvrx5D5YBweiSzh0S8PIbllF47SeAbtwTUBAiyJ/8nlMH1FeCqIY=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Wed, 14 Jun 2023 17:58:15 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ab) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:15 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:13 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Daniel Miess <daniel.miess@amd.com>,
        <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 04/17] Revert "drm/amd/display: Move DCN314 DOMAIN power control to DMCUB"
Date:   Wed, 14 Jun 2023 13:57:37 -0400
Message-ID: <20230614175750.43359-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbb3a3e-a42b-4d30-3caf-08db6d00ed9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRXFcAInS30PIst2lZvz05K6tMEx0vM/c4U1yrQUGAK8+Ot8jvZmNXoA2+PUBwyQxoFCj2Cx7iqOh7HOTrM1DltHVuxpa47eF0t3nbiBao928hN9z4x1ZJRhXzY20uH6MqV/c6tB2F7Rt69Hrprf+da2IQcfFksgAQaqf4Hfha67uW+38pNqD7uIfMWKEDlGuegBg1JBstbE9Zv5FC+wVCOz9R1i1m/CrUgExjqX3A6Yln6LV9hZ7jqABd6KsP6H6xM+jRfpnieGhVcdiqOGE/6FVl73XizSusmOucjH7IYQH+337+IHfKpZjzj1Nke7zs4H8OR45TAUB8JO0lVbvouFuF46HdyPWTEGowibpC132a+wIfdLJtWuRdhBFsI7TYKQHqtbnGCZzaJslAkjQ/DZbidDyzqLp448UXfY/QcNtvisOcaXgDPv1Xe5AhihBj06CCQS80vToAHbd18xBM/vqHZ/pE/o5eoXs0RqVyr9bFcaxEjLZthbIQom+UE5zEr0ojDFzin64o6y++t3TeIgiSLko0TPFu7C2RcCjd+zNaTZfv7OjtUILAxkmS8b2RtokMl1IBcp8pchVi5oJKs56+sQBpDzAtkfzL8r7cKvkYrTPiRwaM3xB59esIZko/K3mK1l5z2AcSYh4lRed+rF+Vna4e2+LU6+ngyEIIOURzcwg7ZbtUghaQRz+5TIoVxQslbBY+6jiChaq/MY7yykjqUksP0FxOhk1ZK1yjP8FVqIcXxLSULOsbij0uyoUXFWpWdmSit7lvJE6dgEaWof5EApB11/jr2qWwTKm+2fqmfv9sqJvv2H3GGqsYP4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(44832011)(70206006)(316002)(6916009)(70586007)(4326008)(40480700001)(36756003)(5660300002)(2906002)(8936002)(8676002)(41300700001)(40460700003)(47076005)(54906003)(86362001)(82310400005)(478600001)(6666004)(186003)(16526019)(1076003)(26005)(36860700001)(336012)(356005)(81166007)(82740400003)(83380400001)(426003)(2616005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:15.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb3a3e-a42b-4d30-3caf-08db6d00ed9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Miess <daniel.miess@amd.com>

This reverts commit e383b12709e32d6494c948422070c2464b637e44.

Controling hubp power gating using the DMCUB isn't stable so we
are reverting this change to move control back into the driver.

Cc: stable@vger.kernel.org # 6.3+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 21 -------------------
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 --
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 7a43f8868500..32a1c3105089 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -424,27 +424,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
 }
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
-{
-	struct dc_context *ctx = hws->ctx;
-	union dmub_rb_cmd cmd;
-
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
-		return;
-
-	PERF_TRACE();
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.domain_control.header.type = DMUB_CMD__VBIOS;
-	cmd.domain_control.header.sub_type = DMUB_CMD__VBIOS_DOMAIN_CONTROL;
-	cmd.domain_control.header.payload_bytes = sizeof(cmd.domain_control.data);
-	cmd.domain_control.data.inst = hubp_inst;
-	cmd.domain_control.data.power_gate = !power_on;
-
-	dm_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-
-	PERF_TRACE();
-}
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
 	/* There are use cases where SYMCLK is referenced by OTG. For instance
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 96035c75e0df..3841da67a737 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,8 +43,6 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
-
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 86d6a514dec0..ca8fe55c33b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -139,7 +139,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
-	.hubp_pg_control = dcn314_hubp_pg_control,
+	.hubp_pg_control = dcn31_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
-- 
2.40.1

