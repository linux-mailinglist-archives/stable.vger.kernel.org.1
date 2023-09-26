Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F77AF686
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 01:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIZXD4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 19:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjIZXBz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 19:01:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA161DB4E
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 14:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlVHBNkm3xE1/n7cnXNdx8IrV+PXcd5Es6F/6pVJejnZtCJ1Y3aRPxO5N+9AYxwal3O5P5QX5TJdQddlSDjRF1jJ+OnM7fyl8icH8SPicQEcgLtwmaC1/TrcE7nIQOT9b+zGCgj9+HkT/gH9XxaFYmGr2BbtLu4NC3XM/keq8N5kMnXavM4ZzTrTYdpB1i1+Bx3NaV3USPKL+GWnHCucz0zqbmaF2IGcA0sLbaMMhEh77UDUxfe18CIL7HCOqcBgiZEsH9rKVuRVNESREdeo8OFa/MiBmy4GO0vyeBHwf7teXU1pyUI4bmvRafCkGN+legnPgn6zmSaVcaUMCc6wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q546wH7fHdKcrklP6r5s1qn29vSAWcz9E4cKfTxgdOk=;
 b=XhYNazvR0tBN5n5bAg+pshf38BNQ9aEo+L1lxuWY7wPoits4dBd0WDOuIP78+LH5y16TB9FA0dXPrKWukQODkoHr+uusIf7edq9ZxhzlYz0lcztrI/MqKFK6hO3teX43u8oh358qluV5umjgXWxXv0PPbSkk34knBDQO+iLwZMZxPD1+nTPkD1cRwSt48tNySSioJrOJ9HE1HXNdz4CAxGIGJinvRCPHJHD0g/t8jUoUjDMvgdWxt83f+g0Qs07XlAE1h7HaZfh1Pl4I3PlStQuVZy3J4K/TUQuOJqXdxWAmaLpM3taCEiq+LAASKmN8Dn81qBuvi4oD0RyK7jVrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q546wH7fHdKcrklP6r5s1qn29vSAWcz9E4cKfTxgdOk=;
 b=vhdZRYdCjWwZ2uRwKIKXFKRh6RdfRduP3SqmJxbZKmJxHKX5U6exI5UE3QBqkZH9OTcrHXoKfHeMiAzP5qV3hNf/MbhJS3RT08/fm48EqUWyNAO+r9MY3hzEXijse3iquvwwSCKe6iln7mcNAYmitPaL6qFCdteNLk2SDDGy5JQ=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:53:48 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::5) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:46 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:45 -0500
From:   Aurabindo Pillai <aurabindo.pillai@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        Samson Tam <samson.tam@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 04/14] drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only
Date:   Tue, 26 Sep 2023 17:46:55 -0400
Message-ID: <20230926215335.200765-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ac6a98-e998-4a41-12fc-08dbbedb0fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edOaBpwWpvN/t3Wkp0yBdm6WxMbfM6lanakJ5/BZ5/gy97Xbx4ET5+n4AQ6nRnBlGw0RkjdpFVBNj01VeH69hEzcSooI/5dWoZmnoZeCb9TEBpIlg0qSWNpu4hTPCuBdUAK4nc1EyDLDygcbS3ekcvqR+TmJXTF2VQ3y5mE/wy7M/zqIkYtf11h+bsEcNAcaj9S0Aw/N30eQ1ozuIuMA053uiEIsmF7fLBA3sqzwh6dobAwfTKQMMM9h4rpxxT1BylWhTu475UH79TXbetk/I2aSfgExWZFnVQwLLQOVZ375jeNZdyM3m1CGXQl7mf8hAYcSn74s2W7DFJgar/zUyIDNmgv9gLKfMWK8U8LwGnGIFGgdp1VmKO4BBpzMrVykQhrmboAkaXj6ZvG04eqHmS/uivkXJ1PriWDo9nsdNRQYU8DRg83LxHGV2aiytgRf+ktA/Q74q49DnmauqKlcqtHQoklW7dlR5HnnH1quvleg9MTUTwFBOkYooPe2i6N02DmnHM3yL2c3n6pLT3ZabTARHNfrmc7iKwGWg8JVrS/fTXU8pINzmwQgpNC411VzX7w2H5050twRpPvBY/BJzI3S8oGRqxydiJSS/V9ihIhx6IRTn9d4qmejV5EmkTuWcseHr8bxPyJjRBKIPlsbcGK8L1xsnfihatX1C/LtQkKGnBoBgBseU+R+4hDAUKWPiYlOzddnfxfBC0MJFycKtjdpzilxDOg92Tr5/Y3xNP0IGmHFLyPHl+SeN7FA/sPcVCUvBX0Bgz+vprlKkssySw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(70586007)(81166007)(5660300002)(2906002)(6666004)(2616005)(6916009)(478600001)(41300700001)(316002)(70206006)(54906003)(7696005)(44832011)(47076005)(83380400001)(40460700003)(336012)(4326008)(426003)(356005)(36860700001)(8676002)(8936002)(26005)(1076003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:47.5381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ac6a98-e998-4a41-12fc-08dbbedb0fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samson Tam <samson.tam@amd.com>

[Why]
The edge-case DISPCLK WDIVIDER changes call stream_enc functions.
But with MPC pipes, downstream pipes have null stream_enc and will
 cause crash.

[How]
Only call stream_enc functions for pipes that are OTG master.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index c435f7632e8e..5ee87965a078 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -157,7 +157,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -188,7 +188,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 37ffa0050e60..a496930b1f9c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -363,7 +363,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -409,7 +409,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
-- 
2.42.0

