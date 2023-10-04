Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCD7B7BDA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjJDJYC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjJDJYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:24:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584799E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 02:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9vqwR182qhGv/vaPksJm36puT3oZ5v3fCXqm06KqAfuAuQ13X28DBZadqWBBJIJrzmKTIhfdNBwE58+GuFet7ekl7PAzv5JKWB+X6ZUWbpinbqmZPCs/FvfPOsEfOP+WuooVSJ1Ug4q8MJ0nNTIhWddK8uxsKMPCG2+riy+fH0hhvuwFgS0Bu6DsKurC4TiPIchUIHMVEJCP+ZkPOqzBQ6etbM4p/ZEVggRpVRhfflAnEgncdQSMPxGxuMLVNYhKktJbFyuD4rHgfcfTfcSRAgd0srz6ADkEMyag0d2aOIGnJU8T5e0uyAQ3HyQBdC45PRDNgKKLs6xUQVelA7MhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41M2EQVEOCpcEw6vuJvIbGiYKKx1qNLFeMFE39qNTa0=;
 b=hycMayDmphKZVAH5VJlt4NkDuzI1STtEe2cUgmFX+zqVFTsXrnZP3+37f/GEaoMSc3XFvyA0CiebQLaw9bnezA4KPmLUCF8dxd/ZfSF5njK7L4Lse0D4FucaQDMYs9sV/pkrY+pUAkMw4eISVZMWJoamixr02FIEVlqZK6sArWper2GHfPuAqAWU4Evmy/PHooESnWeIFFTeEHqVwMBFcOzPVGnzoC/HMvEzfACadc5GodorDEldXiQsKZj1IgfFR3jnyYQozvV8hEkD9xvCXPI1Wer42u3f4Fyg1BwdTNg/lITAQ5EAAPmRh17rzBmsRxIfYhgWWR+1DeUWsGCp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41M2EQVEOCpcEw6vuJvIbGiYKKx1qNLFeMFE39qNTa0=;
 b=GjElBpSc09WVTBLDIhnecsMo+tYm2tsdwhk/2MA8get8NL6/FxSWEwtmVD7IeC7tvytq0KvxOgkbmg324uff7ZFAaPJYf+Mvo+/NEdLCf1q2cjMXMimKi0uYQgAtUqUkh4gMmv9myHnRWeTSxoDDjemKV/R30ndSm++FZXP1wgg=
Received: from BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 09:23:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::7f) by BL0PR02CA0121.outlook.office365.com
 (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:52 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:46 -0500
From:   Tom Chung <chiahsuan.chung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        Aric Cyr <aric.cyr@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 05/16] drm/amd/display: Revert "drm/amd/display: remove duplicated edp relink to fastboot"
Date:   Wed, 4 Oct 2023 17:22:50 +0800
Message-ID: <20231004092301.2371458-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 339f962b-75d5-4167-55d8-08dbc4bba061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9lve3sQgKeP4pTkmJy6xaQDnM2iPmr7ZcBwKp7DgnZjlvvkZgYXC6gvQ84oLucLMguP1xIUZyJFQQSYhc9X12XRBbzi4ZYe83RufVX65oYoggD6OjMdy/afFWT+3F9sxTObxuJOxWKOkkj4pdWpMnveFzvTsN5FdvcMe+G9UQM/DtYairenBiI5I2zZR+5nnuahWYF30fui0ufOM8xRal8sI2/uLiKDQJeJxHn8SISOvT+aNKIP7IBeAzC3yfz67JAlBvAZc79TiT6BnNWAH5vRsExA47vGcZ/z1384u2ock+RCNUGYEYaPioGZulmAbcQpqJ+TfcvsZAmzbGfq5zN+xqOfHD7INyVrShxyP89J06JuJizUPDJfJhoEIM/DEqhuIXGcuDZal23kh7HVWi23lqpFIqK0JGYybYMnTy1Tiww6tZnJEvMy6Y1aKZEUGNxDVpyV49lctsJYPBPUUl1rkOMbHfRSGZ9wckpVWZ8cn6OwFGfpfZVTvdBpoOH8FHnpiUI54tKCbD5z989OyTEFgaPMJJeOLAffVeLzJPP0ftfSYRNrQxT43kZWfO+prXtVmiChssTdYTpiYldZ1nFKIM/vIkbiEUWMcc9AvM4cGCIhA42PbVUjy41gSlS4x7DoDpz78VJbPdv7TvN7VBeyPMY9ByCHkaGp/DFoAsF45osxPK840EDKUdM3AUuhI0xojaJawYCQW9LdNpTzoa8N8bf6RoCkywJpn8HtKGKNuptdALnJ4Z4dOh1wMZCKt5/rvXKT49blZYxQ+SPkng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(426003)(40460700003)(1076003)(2616005)(36860700001)(336012)(82740400003)(81166007)(356005)(86362001)(36756003)(40480700001)(83380400001)(26005)(47076005)(316002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(70206006)(2906002)(70586007)(7696005)(6916009)(54906003)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:53.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339f962b-75d5-4167-55d8-08dbc4bba061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

Revert commit a0b8a2c85d1b ("drm/amd/display: remove duplicated edp relink to fastboot")

Because it cause 4k EDP not light up on boot

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 63e97fb0a478..17a36953d3a9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1213,6 +1213,64 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	dc_release_state(current_ctx);
 }
 
+static void disable_vbios_mode_if_required(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	unsigned int i, j;
+
+	/* check if timing_changed, disable stream*/
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_stream_state *stream = NULL;
+		struct dc_link *link = NULL;
+		struct pipe_ctx *pipe = NULL;
+
+		pipe = &context->res_ctx.pipe_ctx[i];
+		stream = pipe->stream;
+		if (stream == NULL)
+			continue;
+
+		// only looking for first odm pipe
+		if (pipe->prev_odm_pipe)
+			continue;
+
+		if (stream->link->local_sink &&
+			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
+			link = stream->link;
+		}
+
+		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
+			unsigned int enc_inst, tg_inst = 0;
+			unsigned int pix_clk_100hz;
+
+			enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
+			if (enc_inst != ENGINE_ID_UNKNOWN) {
+				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+					if (dc->res_pool->stream_enc[j]->id == enc_inst) {
+						tg_inst = dc->res_pool->stream_enc[j]->funcs->dig_source_otg(
+							dc->res_pool->stream_enc[j]);
+						break;
+					}
+				}
+
+				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+					dc->res_pool->dp_clock_source,
+					tg_inst, &pix_clk_100hz);
+
+				if (link->link_status.link_active) {
+					uint32_t requested_pix_clk_100hz =
+						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
+
+					if (pix_clk_100hz != requested_pix_clk_100hz) {
+						dc->link_srv->set_dpms_off(pipe);
+						pipe->stream->dpms_off = false;
+					}
+				}
+			}
+		}
+	}
+}
+
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -1782,6 +1840,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc_streams[i] =  context->streams[i];
 
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
+		disable_vbios_mode_if_required(dc, context);
 		dc->hwss.enable_accelerated_mode(dc, context);
 	}
 
-- 
2.25.1

