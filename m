Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43C7E5E22
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjKHTFQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjKHTFC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:05:02 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5825A9
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYQ1iGvVhWzG/3vQzcBMg6T9mOV2PIE30HYwWZPfVH5H8PnjT4NVGT4ccop4sKMaXSXQf0gqIafQCYm62MVzCTS0ltMh/vz4ZHX7hrhAYl0sttzLln+H9UmgIa26ESJMKNwZ1TzDy9TovX2gRgFE6U/Ym5TvcdsLECs0/OL3zlG+AVWKrRFTZVJ9EgxhdZrzyb14o6Uh46sBKofDzAW/FX1YEg6YOZFS1IbIfkU1Muh4kO2RuE7sUQ2LAjhR7QxAWF4YVz2jjtzeszzbWRNX8XYTtWIIYeinNkF/n0nM7lSr6zDR6W4GiS/o+a0O5Z7kBQIbTCvJOEZl+KaM3PtWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj74F78vmT1mtc8GrzIoCTd9CYdh4owj8WM5TGNnd7Y=;
 b=RpCD3b66UXqBWfjMqd3MjOdnQNy4OyBvqva1x7rKaCLGQv2pUZ31iS3t+x9UkZ9DxL32uODfyn9QS9o4KDuR2jWqZNUo0JiZmvvQxnEPxNThDNZQCWFPMiLKPHNKkmBlgEc3fLrAjvRM62+9qpCRiF7iB2kBxRSU13UPV7w6+iel1lU48/8tCquvbd+7cpZetDM3kFoH0jitxUBZ5mn3dDOJHlRZaF+ox5nDlNqDmx9phnqeZwShLykjnoos5/bQ6lIEAKICnlGGG2WY4CGagy2Luw88E+cymhnwmLg0ZgoWiYDOeSsnvoArLtgYD1DfvR8pQbP6Z01mBCMPFtmbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj74F78vmT1mtc8GrzIoCTd9CYdh4owj8WM5TGNnd7Y=;
 b=v7U6/Enl3uxiYDqWIYtfBBnS+VT6meakEHIaGrUhnLknnoJrFGtbzH8K0y0tOrOcc4kPZPlpQuJgFqXnQvl2mJ+cn8LCEDvKj0MAG1vxZR9lz+lFQVFo2zZytxZtwDJh/bUQiAFeMfw7l57zRij1Uq5PuRQVcIFd/eZkoPoeJC0=
Received: from MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 19:04:12 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::b4) by MN2PR03CA0029.outlook.office365.com
 (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:04:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:04:08 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Muhammad Ahmed <ahmed.ahmed@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/20] drm/amd/display: Add null checks for 8K60 lightup
Date:   Wed, 8 Nov 2023 11:44:21 -0700
Message-ID: <20231108185501.45359-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c750ae1-f2b9-4438-1012-08dbe08d7eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNoBWBabkmKFsvk+u5aR9h9CdtND3XhcwrsjI/HSWDOFr/GspMgXYkZRSDg4IZdcOhoUIXLzfuvZ5ihpQ8jMbEwjR8cLrzlQFa2XnvFYhTrmCgyHKXxJf3zmDEyBpse8LatkpXwVBJLCH+O7sn9b5Ig+QN2fgUgpLNy1I6rpENp/CsmcVysyyqkUu043TWDYQFP2seVM+9eXAj031ZnWzefepyT+rj946zUYAv/VDTyKGpliIrIVUvtCHOEN7R8j7HJGEs0twZkdvI6sN71eyhpgmKspAzjNnp2/p64duflge6eb6qBaCnqRsDeEAdzaU4g8ODDyPh+rNf6xkSK18yykObWgQoG4D6ctkvJIKw9ldJVA3Wa8T6BsRBtETUm2tKAE4SwH/YQrtweNG9eDSNClgNyiTlDJaRvrESFHKTQ9Pp1d0HQSM8p8006xC9CoRMfU3iqkZgLcib4Hvmv0aWg6C6AyL4X2YK5nMVLuDcvZyydQg7g1G3VIoq7nIPOdAv/GduGEcb0FNSr4Fp0fPZ4fz3mbvZVttVWDLx/qnEjAHoDkyHZpZNci9j9o9U+Iil+7U/4vZoxA0E86w8IoMFWXg6DiU4ACulNj/yK1dFYJiiCJXo1/q3KhqalWWFNYYRikkTf+HC0w7jzok7WO171gx+Pi9nSYynFKC2H9SzYeqmQRdVZpk7nb4i418PAkzflrkJnDmoNB5U5iwON2/SDMcVJN0xQBRrlnuUZe49nu2vYNsTs/0PqqNKHTMFTqEdSujSpWmilRN180sYAlVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(2616005)(44832011)(7696005)(47076005)(83380400001)(41300700001)(36860700001)(6666004)(336012)(2906002)(426003)(16526019)(26005)(6916009)(54906003)(70206006)(70586007)(316002)(8676002)(4326008)(8936002)(478600001)(5660300002)(36756003)(40480700001)(81166007)(356005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:04:12.3525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c750ae1-f2b9-4438-1012-08dbe08d7eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[WHY & HOW]
Add some null checks to fix an issue where 8k60
tiled display fails to light up.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b9bf5cb4529..d8f434738212 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3178,7 +3178,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
 					context->streams[i]);
 
-			if (otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 06fc4c5a3b69..6159d819c5c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5190,6 +5190,9 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 	sec_next = sec_pipe->next_odm_pipe;
 	sec_prev = sec_pipe->prev_odm_pipe;
 
+	if (pri_pipe == NULL)
+		return false;
+
 	*sec_pipe = *pri_pipe;
 
 	sec_pipe->top_pipe = sec_top;
-- 
2.42.0

