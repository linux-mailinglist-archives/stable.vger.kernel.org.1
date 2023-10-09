Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622937BEA0C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjJISuT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJISuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:50:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E9A4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxeEeN6nGOzm+5+UbiVKctLGUyqVIJe0u3Mz0ZPnhL/Fmme7rSNxnCZnjw05h+ZH2/TQR6puFDwHCa9T3xOWfJvdGNlAH7F3iJ/IJHWxesaRoNjnDdSqSPlrt5Nu+H09stFpKK/HpF0lhdba9JIrMJSArJCWd9AtZwv78PIa5Qxy8bybY9qVn/bnrReZ6pOKfFrLnNvDROWMWhexMPbPiU0dlLha23FBPa9OJTB9PZo5kVeXNTK29/xDwuCt4ZYdw1zQ1ivzhYPeplXUpTsnAF1vRtIWSzwqRNbhq1aVnrxHr1Jw7MAtWqPKlVyTiJtU3XAMKC5Mf0MJsh7/bo0ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORUVRlPRldFCOD1Q/ZoUldC9MDB08rowuBahFmLbZZY=;
 b=Sx003/zoQbE8pK5R5gQDCFNVbinkuV4QSwpWZhVF6u+l+sYsYbftfAxoLtZKlVvdSYfPANWtelcV4O/xap+t+DA1C3faTy8ZsPemPJ0tBpppVXDGhfIFRTODbh/ipEjQYEz48xFa/0dVoPY+6HSSSRLf++Z67HyVTp1LON4cTIXjFJaZYRo5XxrdMzjjsGz/d2z9zu8KF+7+75wMMncUJyI+zxKKYi8FnhKhRh38+DfuYxYuFkadZbA3irZq3sVqNEFBEn0s12vD6k3Pgx4A7heaK7QheN9g1QBEq40TZRhqEOseH0rscKG30RuX0WGO3gy1q3zD/7m/o5mwc6Ttrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORUVRlPRldFCOD1Q/ZoUldC9MDB08rowuBahFmLbZZY=;
 b=M2Hk3AQ9Zv6t3m1KrT/dfqPNvqqxDIimj1WcEipLWw3JcbWgNQWnLjG2lhoLnqCeZQIUQC+R6Bp/HM77NV4PsloT7rZssoJwH2H5/zqTU2VNC/Nkq41DjqzBDmmfu7Zse1A2cf/M+DK8N1T9WbAc5vgky0fX0kPLpMmSQ9cYB0M=
Received: from SA9P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::28)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Mon, 9 Oct
 2023 18:50:13 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::60) by SA9P221CA0023.outlook.office365.com
 (2603:10b6:806:25::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 18:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:50:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:50:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.5.y 1/2] drm/amd/display: implement pipe type definition and adding accessors
Date:   Mon, 9 Oct 2023 13:20:36 -0500
Message-ID: <20231009182037.124395-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009182037.124395-1-mario.limonciello@amd.com>
References: <20231009182037.124395-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 5729d30d-4021-436b-59db-08dbc8f8925f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voxLWoZOL8URmmgx3mXxij6jNOLjEgvqXbgxW1oZwQK1iMklZfDwALWwteGverTym5cWGg2wohYftZ4/gSyqKKNXB3qttaqZ5by71xvx02qIO6+9FCxPem63KjMajnbbqTaaBw9P6RYjcloFXlu54GFEQrMvaFI/RbZu//QGEGASOXqVPBBmKqrosP9sJpq9D+7QMXNlLY7/z0vRUpsZMZNOHS5/7bESAAYL/SrpXh1XFryV407UhyMRWs9W1QG7yvPcV35DoHdNCeoh2dnriNoOaSOHMas+jre+n6k3Snz+XYjHwaDz1K7fBgarl9l9cVzgNYprQCBf21SOL1gxdyAXjfQAIGlF/i+v6Q0M51v1mUXusKQQmoSzM+kkh99x/XarI4UF+L31RCA63F2VpCnLAeVmqlBrSHmdMj4b/Nz19DWNlRzCiDlpxGHqfbi/DP19XyL2Flhnb97dhIa5mJ92W1KQA9dMZ4gfiYWtRp0kDA2XPp2vMsR4Brh6/DEh9SujwQOyucriePwRvZTgL9+zYYbuR5AaQ3cWF6ooJVbbkcdLGAdIqh9AotjkE4wXX4qRERU/P9h5FHGy680opSu/sztB3QPFKylTEuH69sL1ZesMk5bHb1Yme+nRaJvTkAWA+KTs3My8qBw47BqUx0QcQIz3kuciGu2MNY2JlqI5r3ok8ULinTjtU1gc8B0GvmfMJmS0eLX/lTCbxdmrexGG/W6Le33MHt0I+rzQDga8QtzpUDMSa4I3xrdbED5QcCXmkuTC+K5uK4UOq1MhtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(82740400003)(356005)(478600001)(36860700001)(47076005)(7696005)(6666004)(16526019)(6916009)(26005)(8676002)(426003)(316002)(41300700001)(83380400001)(336012)(2616005)(44832011)(8936002)(70206006)(70586007)(4326008)(5660300002)(36756003)(2906002)(86362001)(81166007)(1076003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:50:13.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5729d30d-4021-436b-59db-08dbc8f8925f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[why]
There is a lack of encapsulation of pipe connection representation in pipe context.
This has caused many challenging bugs and coding errors with repeated
logic to identify the same pipe type.

[how]
Formally define pipe types and provide getters to identify a pipe type and
find a pipe based on specific requirements. Update existing logic in non dcn
specific files and dcn32 and future versions to use the new accessors.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

cherry-picked from 53f328807946 ("drm/amd/display: implement pipe type
definition and adding accessors"). Reduced to only introduce
resource_is_pipe_type() to make candidate for stable 6.5.y.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  35 ++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 106 ++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2f3d9a698486..f2dd3c166af0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1348,6 +1348,41 @@ struct pipe_ctx *find_idle_secondary_pipe(
 	return secondary_pipe;
 }
 
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
+{
+#ifdef DBG
+	if (pipe_ctx->stream == NULL) {
+		/* a free pipe with dangling states */
+		ASSERT(!pipe_ctx->plane_state);
+		ASSERT(!pipe_ctx->prev_odm_pipe);
+		ASSERT(!pipe_ctx->next_odm_pipe);
+		ASSERT(!pipe_ctx->top_pipe);
+		ASSERT(!pipe_ctx->bottom_pipe);
+	} else if (pipe_ctx->top_pipe) {
+		/* a secondary DPP pipe must be signed to a plane */
+		ASSERT(pipe_ctx->plane_state)
+	}
+	/* Add more checks here to prevent corrupted pipe ctx. It is very hard
+	* to debug this issue afterwards because we can't pinpoint the code
+	* location causing inconsistent pipe context states.
+	*/
+#endif
+	switch (type) {
+	case OTG_MASTER:
+		return !pipe_ctx->prev_odm_pipe &&
+				!pipe_ctx->top_pipe &&
+				pipe_ctx->stream;
+	case OPP_HEAD:
+		return !pipe_ctx->top_pipe && pipe_ctx->stream;
+	case DPP_PIPE:
+		return pipe_ctx->plane_state && pipe_ctx->stream;
+	case FREE_PIPE:
+		return !pipe_ctx->plane_state && !pipe_ctx->stream;
+	default:
+		return false;
+	}
+}
+
 struct pipe_ctx *resource_get_head_pipe_for_stream(
 		struct resource_context *res_ctx,
 		struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index eaeb684c8a48..3088c6c65731 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -153,6 +153,112 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
+/*
+ * pipe types are identified based on MUXes in DCN front end that are capable
+ * of taking input from one DCN pipeline to another DCN pipeline. The name is
+ * in a form of XXXX_YYYY, where XXXX is the DCN front end hardware block the
+ * pipeline ends with and YYYY is the rendering role that the pipe is in.
+ *
+ * For instance OTG_MASTER is a pipe ending with OTG hardware block in its
+ * pipeline and it is in a role of a master pipe for timing generation.
+ *
+ * For quick reference a diagram of each pipe type's areas of responsibility
+ * for outputting timings on the screen is shown below:
+ *
+ *       Timing Active for Stream 0
+ *        __________________________________________________
+ *       |OTG master 0 (OPP head 0)|OPP head 2 (DPP pipe 2) |
+ *       |             (DPP pipe 0)|                        |
+ *       | Top Plane 0             |                        |
+ *       |           ______________|____                    |
+ *       |          |DPP pipe 1    |DPP |                   |
+ *       |          |              |pipe|                   |
+ *       |          |  Bottom      |3   |                   |
+ *       |          |  Plane 1     |    |                   |
+ *       |          |              |    |                   |
+ *       |          |______________|____|                   |
+ *       |                         |                        |
+ *       |                         |                        |
+ *       | ODM slice 0             | ODM slice 1            |
+ *       |_________________________|________________________|
+ *
+ *       Timing Active for Stream 1
+ *        __________________________________________________
+ *       |OTG master 4 (OPP head 4)                         |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |               Blank Pixel Data                   |
+ *       |              (generated by DPG4)                 |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |__________________________________________________|
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |        |               | blank     |             |
+ *       |   4    |               | ----------------------- |
+ *       |        |               |           |             |
+ *       |   5    |  (FREE)       |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+enum pipe_type {
+	/* free pipe - free pipe is an uninitialized pipe without a stream
+	* associated with it. It is a free DCN pipe resource. It can be
+	* acquired as any type of pipe.
+	*/
+	FREE_PIPE,
+
+	/* OTG master pipe - the master pipe of its OPP head pipes with a
+	* functional OTG. It merges all its OPP head pipes pixel data in ODM
+	* block and output to backend DIG. OTG master pipe is responsible for
+	* generating entire crtc timing to backend DIG. An OTG master pipe may
+	* or may not have a plane. If it has a plane it blends it as the left
+	* most MPC slice of the top most layer. If it doesn't have a plane it
+	* can output pixel data from its OPP head pipes' test pattern
+	* generators (DPG) such as solid black pixel data to blank the screen.
+	*/
+	OTG_MASTER,
+
+	/* OPP head pipe - the head pipe of an MPC blending tree with a
+	* functional OPP outputting to an OTG. OPP head pipe is responsible for
+	* processing output pixels in its own ODM slice. It may or may not have
+	* a plane. If it has a plane it blends it as the top most layer within
+	* its own ODM slice. If it doesn't have a plane it can output pixel
+	* data from its DPG such as solid black pixel data to blank the pixel
+	* data in its own ODM slice. OTG master pipe is also an OPP head pipe
+	* but with more responsibility.
+	*/
+	OPP_HEAD,
+
+	/* DPP pipe - the pipe with a functional DPP outputting to an OPP head
+	* pipe's MPC. DPP pipe is responsible for processing pixel data from
+	* its own MPC slice of a plane. It must be connected to an OPP head
+	* pipe and it must have a plane associated with it.
+	*/
+	DPP_PIPE,
+};
+
+/*
+ * Determine if the input pipe ctx is of a pipe type.
+ * return - true if pipe ctx is of the input type.
+ */
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type);
+
 struct pipe_ctx *find_idle_secondary_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
-- 
2.34.1

