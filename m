Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6C7AF95B
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjI0E2U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjI0E1T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 00:27:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBB1DB4A
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 14:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBudU2HxoRYj5kdB74SVfBzoclB1Ts2MYxlp59tZEG9HSewMJ3ADwpsqBygmeH4fT1qpn0unHzJ1aEyx64ENMHHuGnWQcdZuffZid4GBzqW17T0rburk8U3O93kAgC4E1KXq33ez5rVi0b1700llTfLQYKgoGFj4SnjJu8GMHuaScJabFDrMGN6uUCxBWbYGAoBzuJP0qdJF7TSKYAtuARKwG6iqICz6fJhQc+ASmFKAWCQr6RmpWfz0AhRTuvv8YNlLHhP9seH41qalTfJXNQvV1Macs6vCizYsHvy8RVgDM7mDauQA9xaOZZ0Qs/ZGU/JBTv/eTM8WQhmJtSh9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK1LHHvfEOrRIVDPYcqE7Nd6S4eVkTRC0ngY46HM3yE=;
 b=Oo7UPpK20DFcg7xGwVW1z7Q5Y+nQuPkf1EyPcuYgPcMva4LzBDv8+15HjI8Tdcxhvl0JnOBJNZGbuzILp8W7iRBBs4C8SH6s/sbd0A0oJZ67RX8p2o7G+Oa5ssmeHwbG1qLRfZPrHucFrhKa9WL6Gwc4UCnbz7KLjkmtzNa3Y6LiTVy6UjbUC8ZwNf0Q/UQupEVUENnhov+A+KyySyxRnZE6ZLv5Yh2xoIoNIrlMFhWu919KS1f490hB5NaCAssbiWtEybQfRvnpmTAe+9pr4cQxB8kMtqpgEvTtsQrt3Eaci/wQYN6+gtkKx0u23fnWeIuH6whC7B8+QV6V+j5IRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK1LHHvfEOrRIVDPYcqE7Nd6S4eVkTRC0ngY46HM3yE=;
 b=aFzD7x61KDYb3UD8BRLLCP9+Su7KOm0CVQQ+yrvHN4LqvVKtwtWqL8JgZhroHPAax7xv63zp8arz3BzWU6W8SwtX0z5BCe35iMdO4/oaoOJ30thKTWr7bAG6L4pN3IPDbfqvicJ6bEE9h6w1/D68fcZt1doXTzFpdqXPupUkHhk=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 21:53:46 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::66) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:45 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:44 -0500
From:   Aurabindo Pillai <aurabindo.pillai@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        Muhammad Ahmed <ahmed.ahmed@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 03/14] drm/amd/display: enable dsc_clk even if dsc_pg disabled
Date:   Tue, 26 Sep 2023 17:46:54 -0400
Message-ID: <20230926215335.200765-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|BN9PR12MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9dd533-9778-4cc0-e03f-08dbbedb0f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/NKbEtEKlX5iv7GLHrdeE/x3KlBdxFQRpI1BqW+PR87D1DDO4xmDWjiO/ZeKFVNTof2U3J28o7oGHxQdNbebOz4ziLTBB+mjRcAGiz4c5mawbiv3PLKnZgOFY4BQE1zl8mcnQMOVQR13BNQTLWSHkkMGzqKj3mxGjYu3B3QF0Bt9SG9nXj6OdaQD91rv3FGqwSxlBvQnqTgF91am0jDTJtWrfaYBdsdj167cIP3w0WmiAR4O4twQFFPEwjahogd0xHLDfdAi6Mm4SNzupqDeEepmMTkTCMB67tLv8k3UUoOmlIxcX/076kXWLbh3rc3F9iBXcCFhzOeaqbn1rF7kRM9T3EbbOoD+DzUKC3deDebB3v1PuY1IrpqVdndgrMZSpGuK75/yfKN3u6RSg1CaJ6yh+74bFr1puQsmfv+CJSEDYB/TCLgVfXPpyPy3PsmKpxd8Cjgdx6GyuA6e6YqPl0ZPT926fw1tfLSIfY2D5VobtcxThJG9OvZNagyd37lfbKDGAAtbxdvs4+c1mC7jjST/6PjWbUl9aWl//+JLGQErWvQxawfe83rlohVaTZvxE1b6sBhWTUhC+GTS+Ab6T6SFLCET9KSubxgX1SxN41W3JGM/r+B3jG54OVQEaS7o1yEQw8x2WyjX+eivKSMHqPUXY5s62zVIGNA7yhJbbvKa+J33cvxy149vufmwXMm0xljq5nn5YWM+T63R4wbx8kpYUUt2Tbz9XTL/kn52tF4gAzSHqHQTRBTJOR24aWji6X4ZlxvcTGS7qXCD1A6UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(70206006)(83380400001)(36756003)(316002)(81166007)(6916009)(70586007)(356005)(7696005)(6666004)(336012)(426003)(40480700001)(26005)(2616005)(54906003)(1076003)(478600001)(47076005)(40460700003)(2906002)(8936002)(5660300002)(4326008)(8676002)(82740400003)(44832011)(86362001)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:46.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9dd533-9778-4cc0-e03f-08dbbedb0f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why]
need to enable dsc_clk regardless dsc_pg

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cb3cb2db90ee..6f2300f71ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1853,7 +1853,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
+	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, false);
 
 	disable_dangling_plane(dc, context);
@@ -1960,7 +1960,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.optimize_bandwidth(dc, context);
 	}
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
+	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, true);
 
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
@@ -2207,7 +2207,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 		dc->hwss.optimize_bandwidth(dc, context);
 
-		if (dc->debug.enable_double_buffered_dsc_pg_support)
+		if (dc->hwss.update_dsc_pg)
 			dc->hwss.update_dsc_pg(dc, context, true);
 	}
 
@@ -3565,7 +3565,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (get_seamless_boot_stream_count(context) == 0)
 			dc->hwss.prepare_bandwidth(dc, context);
 
-		if (dc->debug.enable_double_buffered_dsc_pg_support)
+		if (dc->hwss.update_dsc_pg)
 			dc->hwss.update_dsc_pg(dc, context, false);
 
 		context_clock_trace(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 76fd7a41bdbf..45b557d8e089 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -77,6 +77,9 @@ void dcn32_dsc_pg_control(
 	if (hws->ctx->dc->debug.disable_dsc_power_gate)
 		return;
 
+	if (!hws->ctx->dc->debug.enable_double_buffered_dsc_pg_support)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 10ae1b3da751..6214866916c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -742,7 +742,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_mem_low_power = false,
 	.enable_hpo_pg_support = false,
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
-	.enable_double_buffered_dsc_pg_support = false,
+	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.disable_z10 = false,
 	.ignore_pg = true,
-- 
2.42.0

