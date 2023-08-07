Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70D771847
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHGCVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHGCVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1A172E
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crj4npfV6iTNE8nRbNz9XZ7tiYrlpQN1adfNF0FgKiGh04vgAte4R+1sb7JrQ1tX7cyNq2e+rnNk7TAORnDI8idWJpzB3JkiFsShyC/oX73kAx1tub8mbnEFtGvs9xIUo4TrbUHlpCsVsHQbFvyGvFnP1K858K/C/2/OoVSK5RJtBXCpu6v384+3/ygDa4uEhs+FaJp/Zep3cXHGMDSIZcV2UJ3bQ5k3WnOC77cIeIghFGf/PO0oXhEe8I4n5Poes3RGHoFTovLoJcW2E5Oqlna62EhK7KPXExhPAAeKWXQ29CfI8vzAyXC3THP0GFkS83cyFBOBmJmcTMRFBziFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZo+HoSXb2mMRasVKQ/s1pqaHpMcWx94K7OJmnlkADA=;
 b=VxeYgXrzlIIXYZNC3fQv9TVKYUs7T6CFoNmS4xOrRUeSZluzYT6dXnvISsh44nMyd+1Dp3UMBApDA4och3b2bBIy8NjgdvkYAzggGAgnrtrLw1OqJQ5tKJJ0RXo+YMB2jFNNRUn+mLviHFDNHWU9HrWDBS0IoAKVU1kY46RS16DbimKiV1/Ya88t+bdw5VsBKvp9iiCJkXx+rSzaP16U+fBezM7rx6rs6/SGFw/jiimSsDHOlIEP85ghe13TBOxlZoyyEitHZWcfHXB7DtfP+QFikOuWj5XMegB1+bDRKdQTgArISnWMKj5DWMEA6uHrb5JBtCZ+x5Wi6UORd8hRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZo+HoSXb2mMRasVKQ/s1pqaHpMcWx94K7OJmnlkADA=;
 b=42JAb5Wa/ZFu0W00b4UU7AaicHEBYsITXyw5tkm1WKqVcmhghy/MqW2nYl71G2JAQb4NoGhbhalbX75sgVAXjvszrZ43bQt/NpqTsEj8leNjacIl2xc/zKoM0+eb5j2nq6FE0QFCJfPYJuIx5NVYs977jI+FzP4tshL7lk3Jvo4=
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:45 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6f) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:42 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:40 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Brian Chang <Brian.Chang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 09/10] drm/amd/display: Retain phantom plane/stream if validation fails
Date:   Mon, 7 Aug 2023 10:20:54 +0800
Message-ID: <20230807022055.2798020-9-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: f17e1390-17b1-4aac-a689-08db96ed0b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ePxqJXN9zOf+IHk9ww/6AbcXZUIDC3P/8KidkA33wR3W6MRUUSNr6NHJf2kbdHmfUDSx6RMyLMNTQZNnutE7Fy7Cy4L7EKcBF8WH0z8226AC5KpT3ZMxHsAujNSs/3p/yyWK0TSbn8ttvvwa9TmurvPbrfOAvvt/li0nRVSh8r/T/57w4BNXNBtPryjkEaQRJQqzey+TSANwpNimqk8U3/7gsfSkTArK6OHjMPc0HZvIfHEbC2uGzZLkX+mUbPD+icNkwLRmqMttDAukD3k3lZbxA1L3lf0/rJq2xSkfFeP8OeAPfLRpP+uIO+R9cbNYfsGm3sZurf1SVIYKx/4O2udhN+yXnbZODCVDQUJ7aT0pam23oqSXdtyQjK6uB/bF1Y5U5PTq9h1kIChug2Bw7NqdKpdaydK6oiFiTTymrVc6EyQnYpIEFg2Pav2qgEsOxjM0cKqCRfPDvot70s7om+lvVyJ9/cvMpY+61tRLmWaLB1O8cMQnTR2elhVwgKK+jrH/sD2vxE4Hw/NTOVdbUBF+knmT6OU0mam8c/5Rdiq8rfC2TIGCP+kMUoE6x3RZ4smqHh2Sw9MzzwVaIXLQZb6TY6K5hahKbIz+f/q6hyCyL07DJHTgBzbbdhYUKLn5wc+Pt7dwtvwY/ZHTbKyQGoZ+wVRHvvPbuKGygVbzmN1MlspjfJCzmSWMKXYLhufT9rVLkTaEL6IxWXBioEqIyJAii58D3G1KXlXmYmmOpNE3LAOCjoJSRONGEQxeZITYpPi4yiEMDEzW7ZO11CwdxRAmo02ljWuZmy4thUEi+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(82310400008)(1800799003)(186006)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(36860700001)(426003)(40460700003)(40480700001)(2616005)(2906002)(54906003)(316002)(6916009)(70206006)(70586007)(4326008)(8676002)(8936002)(41300700001)(81166007)(86362001)(356005)(478600001)(7696005)(6666004)(5660300002)(82740400003)(1076003)(26005)(36756003)(336012)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:44.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e1390-17b1-4aac-a689-08db96ed0b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- If we fail validation, we should retain the phantom
  stream/planes
- Full updates assume that phantom pipes will be fully
  removed, but if validation fails we keep the phantom
  pipes
- Therefore we have to retain the plane/stream if validation
  fails (since the refcount is decremented before validation,
  and the expectation is that it's fully freed when the  old
  dc_state is released)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 +++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 5 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f16a9e410d16..674ab6d9b31e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3149,6 +3149,19 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	if (update_type == UPDATE_TYPE_FULL) {
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			/* For phantom pipes we remove and create a new set of phantom pipes
+			 * for each full update (because we don't know if we'll need phantom
+			 * pipes until after the first round of validation). However, if validation
+			 * fails we need to keep the existing phantom pipes (because we don't update
+			 * the dc->current_state).
+			 *
+			 * The phantom stream/plane refcount is decremented for validation because
+			 * we assume it'll be removed (the free comes when the dc_state is freed),
+			 * but if validation fails we have to increment back the refcount so it's
+			 * consistent.
+			 */
+			if (dc->res_pool->funcs->retain_phantom_pipes)
+				dc->res_pool->funcs->retain_phantom_pipes(dc, dc->current_state);
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 814620e6638f..2b8700b291a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1719,6 +1719,27 @@ static struct dc_stream_state *dcn32_enable_phantom_stream(struct dc *dc,
 	return phantom_stream;
 }
 
+void dcn32_retain_phantom_pipes(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct dc_plane_state *phantom_plane = NULL;
+	struct dc_stream_state *phantom_stream = NULL;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe &&
+				pipe->plane_state && pipe->stream &&
+				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			phantom_plane = pipe->plane_state;
+			phantom_stream = pipe->stream;
+
+			dc_plane_state_retain(phantom_plane);
+			dc_stream_retain(phantom_stream);
+		}
+	}
+}
+
 // return true if removed piped from ctx, false otherwise
 bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 {
@@ -2035,6 +2056,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 615244a1f95d..026cf13d203f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -83,6 +83,9 @@ bool dcn32_release_post_bldn_3dlut(
 bool dcn32_remove_phantom_pipes(struct dc *dc,
 		struct dc_state *context);
 
+void dcn32_retain_phantom_pipes(struct dc *dc,
+		struct dc_state *context);
+
 void dcn32_add_phantom_pipes(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 213ff3672bd5..aed92ced7b76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1619,6 +1619,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
+	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9498105c98ab..5fa7c4772af4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -234,6 +234,7 @@ struct resource_funcs {
             unsigned int index);
 
 	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
+	void (*retain_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 };
 
-- 
2.34.1

