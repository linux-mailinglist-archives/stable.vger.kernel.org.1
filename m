Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B2779937
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjHKVIz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjHKVIx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366FAC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLQtbfayrnulc+w8wzgM8y0uvxqxK477rujA4cqvZYVOKqagP2cmSxc+ZkCDhPpVstEkNrlqFRnUj/F6UbBpjOv2ziDp/IH2vJQKCPmTAwJt50Xrj2VvWxsnDddRPd6NJ+3378ls8cUtwdnsAkNRkQWvuiurCi3685Xa/LsMOkgsweFfFfd3ATMEnBsn6FAMjSBxc9u0WDzPz8+Kc5cuJToar+phKQ0T91BQ/WmBK2RqSiJXME7rNdNYT8P5jMwExU+dkvy1e+jFOVd9FdMqHBoe9izBL55w8+YE5xrcNwHMoKmeD0feUrCz6MNR1F+GDytz3+2uwPUU9AqHf5VE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eQ0/h7gTokSkW7CVWYJ3QFWtSlO6bvJ16OKOu/o8Lw=;
 b=IrsUIsK/K3lybxphNhieqEs2tHTUUv0SC6rigS1YyWk7eaG9dwlxtC2NHyEsCgb7801eoqmol/XQBrQIjHYf+V7R1ookqIlIn2Tj62fflZBhrvvqK8kstrQN9m/XojpIqA8MDIZ4QryHuyS8IKh17CHGNQL4bMSsDrHWZwHbkbL5WXj0SYYbdzlWlHa8eXg38dyA/kA3nkt3Ja/bJRSSfrxH45hNEUqNOzn9tQE7ghBVOXi+dsn6lce7Bzm4yMIJwtbKoGyZSnyRNBSS1oAHJQSCHw6quodCHMB6O3hP+YrYLOemvJFw+SrbKzDha8zVCWK/W/JJvD6qv9++4yGFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eQ0/h7gTokSkW7CVWYJ3QFWtSlO6bvJ16OKOu/o8Lw=;
 b=fpUOV0xuCdlSXztws9oCHqb6Z7NS3THHRxYU01B2Jdb+jL6TSo8Eny9ckjSWCijuiEKJabcOZAl7ELgALqoK6rlR+GDC71pDrEcZF2K/4HRaOX3+mnJmoSpc9Urvbajwl1Vwzrft+ReHUKaCTm5rueH3Bjvb6K8z8vx1NEM07Zg=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 21:08:48 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::2) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 08/10] drm/amd/display: Retain phantom plane/stream if validation fails
Date:   Fri, 11 Aug 2023 16:07:06 -0500
Message-ID: <20230811210708.14512-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e14535-386e-4d14-cde2-08db9aaf2806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oC/D0CoLp6IKU4naYbXJzI3nrjfYC6d8DSamA9dNv3eeqz0kgfqTFDkeD/+lFwSf5n4AlepacKYRKKuKdIiI6po+jrsQQ9fEX4Aq6OfJTYmGKkaFKqIO3ombNto5ptn0SYwCpyhNF8OK3q4ZSy+CP/sdEW4jDi6uSZ+Cbu1sxp+u1DwUpACs1Z+mjK3lN+lsnXQtGFT95cMRcEBLihP6QrA7nF/Lo2qnkD+KYZ114IxHd5+j7KCF5EGMHRl266g9OBoZLLz0gafBxwLX8P3EwJLvGAwxbwcI/2slRPjSir+TyewbjxOJtOt6h1HyRP9EfNLxjdSaVKN2NOp3lba83hUdGaZgZJxGjYH5ej5NIGn+4/SIPygFrkhDedCCYpNZt6kW3C5gdCvJAJojPEjB5kmeWoijrk6f7FQQsnQgGYOI+wdSbNkLX9KH82WBzYhcInhjrVrABAVUli/6kkC9rEG0coFnJvkfIzee5mUcYDCRXJRjTkgkC6l3nXOGYO/SahOT7rBDOfViaM7oT8hRhMrHQePBpF7DQqlwhHatsPrMlIbAP/nDXLwAVddJvNbYhfPwK0MeBi0XLFXqhbLhjxQMkVuOwDWmX0S9jcB15bc1q9mIzya5v7ARifmUW1QGNVX7twcDhSAgzmO5e24xiEW5GpLE+tPbegIxV0l26E5+bD5wVAI20QndIUcE7cXLp4TqHaY6XoUSl//IHzoGbxi03z5LiqS57KT6ElGeH4u6XsgBXP+fgA98M5ij53aqxyPjvQWfuclGnG7B1qltQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(1800799006)(82310400008)(186006)(451199021)(46966006)(40470700004)(36840700001)(2906002)(44832011)(5660300002)(8676002)(8936002)(86362001)(41300700001)(316002)(4326008)(6916009)(70206006)(70586007)(54906003)(40460700003)(478600001)(356005)(81166007)(6666004)(7696005)(36756003)(1076003)(26005)(336012)(82740400003)(2616005)(40480700001)(16526019)(426003)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:48.2827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e14535-386e-4d14-cde2-08db9aaf2806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
(cherry picked from commit 9b216b7e38f5381bcc3ad21c5ac614aa577ab8f2)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

