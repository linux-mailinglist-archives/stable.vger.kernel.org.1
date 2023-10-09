Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A867BEA0D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjJISuV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJISuU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:50:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30A9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ckp9Z8g9Zo+Se+HlZF0n98gwTSXX8em6eGsEwJMYzUwQ0S1HaC4SAzDFaauiHltJVabGRQR5FVLoaXvsIJI2pUy5ZYNhtB1QG8zgKqvLwu6zr5NoFEJAg8Tpyip8cexcme6F23fYR1s3w9rfzY5jEigSqeC74wiuhYU0XPcHMBHkoFzXb5UqAKJIPUrOHw0RmZcMyQVRZnKWEYctP4VjH6zfU7ct0ohfi2pjaSmShuKhtVB0S/XXl409Od2c80e/2MC4+ZNvXpc8WC13fUbv85sjj5PLGgapxaNi2JPU7LQcO8F9eb1VkebcMs6Nt15uowO8VKbw6VTKg8sJX1g0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjXQCtbiv+zkLDSnR2tlDJPBKfRbhM+uQXpRbj0+epY=;
 b=BVu3yVScE8YllvZAGE2NB6FxCzaCnXDlB1qCIhPgdg2/D4HRU/zAY/uYvlOtOy3dbbBSUZ0hdJuOhAriSC8ImDnS6gU5dtnVM7LFM9+/jAeoQSwjESlyOnBtWaZ0bU8xtGieqUEBFV4bkJ0+gzi5+JyJSZYJD3wcGZzjJYFxTFELgoj/ADwu2nOAwY9TRdgE03J6bz29NuQi3vg7rQMdQ6oZ9SG86xMQ+QB31nTMyNd2OH7wirOE7YsatjU0HLlKuJkG2Gh0Ut7rTErZXsviOWWfZicwv9xq663LLObeWkMjSy4QPD8PD/ii8bRIuQ3VzXlLYEiiv9Wcip6eSskkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjXQCtbiv+zkLDSnR2tlDJPBKfRbhM+uQXpRbj0+epY=;
 b=TbkGPTkk6gVvhS5cImKNpAial6lrjJjwYq/hW00zg/E3R9CVzCqqm9QwkUP03Qm4wFPFzVOjFVK0e+P3q4ZyuChG/i5id5sXBAYefiKvXI0HXAuHH2tOG2R4sJYBe69HUUCcIahiKKttu42nxMNkX5XzDhwWOwJJo4RpjPT6EHU=
Received: from SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::25)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 18:50:14 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::31) by SA9P221CA0020.outlook.office365.com
 (2603:10b6:806:25::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
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
 2023 13:50:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Samson Tam <samson.tam@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.5.y 2/2] drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only
Date:   Mon, 9 Oct 2023 13:20:37 -0500
Message-ID: <20231009182037.124395-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: e43fb888-b96f-4933-0915-08dbc8f8928f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUNZcfWnZ3RhQcwKflK+ZeVhASzW/ke8Oyt/hA7iN7/8GPZXCK3RO7WYWgtDHED9ENrV0dtyuLWracJGsGX8s6e0p9lM9mW3JjarIPoL8e3lEz7FWyFVqPbqDu42IZDIsK99kPDln20HeSpqwk6HrJWQRQeF1Q7itrwEpCYPYVqnzP8y+vRUemZUdMijKHDSFISBhbFr3ZNDsY+BYN6dwkJBrOWzIvJcqoScBoPn+Yjj989I2w+8+8OkEgMUEzqu0qmfsCdVH/6jANgN+8P8qoowOBNCy5WdkofQ64l8Lg2xYYkdZa/RiQKM2VWxUKbhihhcMNRHIu+RYX4v2Lwx+3jOAQ/SA0m6MFveg17kb0uBi9ESIF2FL9RpfK2RZnOW8B6Gm4GUG1Nab1G6lWpoHJu+tsojTe3ovs/rXk9F847+fkGSeakRnCyknWxHGrspmN1M6zwXExJzdEVQ4lsryfdZ2VkR7LD40fKrg/2+TQ+NZz0J74tAWY8l18et30HfiL09XwHZX25WjzW1EDw0bLV/Ujm1adRHv3Edx5TS7422Yu4B0gUb1Qj3DNFboHZnI5pDBWl+cUbGcJzFrNeenRO1QbZb/Fh671HA8TmNZ5xRs3hJ/Fy77igolSZ3+C5LEBHa+fkHsLcczv1h5Z/gMR43FpwikKSuaA+2UVqaHY0aGw0sEKKH7jlmsOMMUfJlGZ2pLERvCvifXjGvN6qZwhLLXNs2Rw3VO8QFJWqLHH2ggawvVC4wmiR7PA/oejXU84wv5z3AA9U9PQkn5Lzz/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(81166007)(86362001)(356005)(36756003)(6666004)(40460700003)(40480700001)(2906002)(82740400003)(478600001)(44832011)(41300700001)(5660300002)(4326008)(7696005)(8676002)(8936002)(426003)(83380400001)(2616005)(336012)(1076003)(54906003)(6916009)(70586007)(26005)(70206006)(316002)(16526019)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:50:13.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43fb888-b96f-4933-0915-08dbc8f8928f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b206011bf05069797df1f4c5ce639398728978e2)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index 5fc78bf927bb..475161521082 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -355,7 +355,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -401,7 +401,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
-- 
2.34.1

