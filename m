Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143597ECEB2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjKOTob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjKOTo3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D73AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO/OB6ePRU6sAFWgaUtFAfGPkcZH9z3rd3qGJgFgrTu0as6Y5QdkhdkhagyU1aTWJsPBHh0HsFLG6nhh+u1n3kc1h5JgjBojti7Kx1ARBGPEZMdHAzKFNMG/ctfzKzcRHI2a8tOpVk3Hiw5EET2f6bobsf3VTomMonuAuKerGWZLzKixTXw9C7wOdIjO9re6DUGFBkGvC0g9Cnv5N7FJFYEyj0xp65XQKksc+rdYWaSTO4FvVaa0IAE3P1qbaSVqrip6usBSQCG+WvZWRrC8zBei23AacSiLEv7buZL/Eg8oMFsQ5z67ZI/mYAwGDZPV6E/PuE/8VqyuPs+uOe74XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1CvIv7L1Qi5pd6rPOboXDbIyDikNPdppxMwdKZMsBI=;
 b=T2TksimS2fzfPhoieDVGFvVwlhmNq6rBbsq4dfuPTyD47Pz3h+MEkYpLvejHrVeyESOi+ULZ1GlvUqjsWpCOk+FpJplj2Yz125zBSbYyLqLWcAdIDvh077fHwnMTLcQUfuqhhqbGUysJm3WLP3kzU/nx+JWHkdhx9R/vQrc4WF06tDlZ3M2NM7qV40w0/NC6iftQGOvJJASaKNgeEIbBWlOuCBqyV9nCNOmC7oPeadeVvM+nJtZT6Dy0+S6QpvXAp2835Oq08K7b+gG1R+d3Wv1YlXMnTW3X0o9CNunapwA3KbOY+JxS8yXD1lxz8DE+uSQgfCI6aV09CrhV9HdW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1CvIv7L1Qi5pd6rPOboXDbIyDikNPdppxMwdKZMsBI=;
 b=XzsXeoFk+S10mTPsLw3Oo76eBbJL5pe7DZ8Okk6oEUiTziuLlLv4tKopZlJykJXxbtocrbWL7DnvSypT4MAHw1rLtxp1+rq3sLFW87N3dNeRjtYzNPruC71b0IwlwA5/P0nue6ajFoszAnepkHSzIcf3gFYm/HUFOx/9gvffPFM=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 19:44:23 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b8) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:22 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:20 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Alvin Lee" <alvin.lee2@amd.com>, <stable@vger.kernel.org>,
        Samson Tam <samson.tam@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 12/35] drm/amd/display: Use DRAM speed from validation for dummy p-state
Date:   Wed, 15 Nov 2023 14:40:25 -0500
Message-ID: <20231115194332.39469-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 4131c137-51db-4810-78fe-08dbe613444a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2HpRV+8EWkFuSLQmAHpWI7AuFtTt12jMNkSNFUDteLluIdXw7KAIiViF0wNU3VxM3lctWZdxnYIaUCxU/OynxxwBNx4E/Z5RF8/X5Us1pI5nJTxySUyTG+80iwTMblOd+RNwetlDky28XmR1vREhVNOrk2JNm6EyK4kfjlulkeJb3utLMBqnPqmJvYWvrDkOlbwf+PomRz6LZC0Hr3RE64bgkf2DWLxvJQ8rVofOW84/2eKJGJZENoPSEyPrwktztvBlHt5K1MB6/qFBFtdnY9935ALu+F5lYH4/TcQMBSwp/rfCigSiHKw/yswb7Qr5oF9dNtB1BfweRAv3ByMuHKcm8omdYS2d23AlH872WnO2IPaH9KmrXpXthqR6ANu00lulV1E+xAyEeJf8SgVU3/ASoyadYfXfVQ7wNHdadxrJvHCokwVz43oJLwQhNM3zMlAoMebjOx1nWf5hXMXrAg0c66wxfFta3oHq+ihSdC2tV533cEJ06SVvPcTuI5hN4yZivsBsi1+qM9HCLWfRrqfFYFzk9z8NTw0HMOyXiegUKNfykdUFh3abzVuMHkyFH+OKlnQKC033jod9u6mawnvBWRO8yt7ZRC3KY0GXegkfiEYgP6uYqqH0o9x/zLo0RFoSkqIRPkF7xA0ipFEHsgeC1GVE5morM7mIRcbqoBZ5iH8MO3xGZgaybjGUqKZRO3ZhVgkQJtk8mi/A5S8q9YdB/IKL9+o2cziB3Kl3xn9bf/D0/367m7Qgi2LJFNhI8FdJw2BAAY3mBY/88KgJskPmB2u57X7I4M307Uqe1Vxts+N2cN0ooMrFFp1FRtn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(16526019)(26005)(1076003)(2616005)(426003)(40460700003)(336012)(83380400001)(82740400003)(478600001)(36860700001)(86362001)(5660300002)(47076005)(44832011)(41300700001)(2906002)(316002)(6916009)(36756003)(81166007)(70206006)(4326008)(54906003)(40480700001)(70586007)(8936002)(356005)(8676002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:22.6774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4131c137-51db-4810-78fe-08dbe613444a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
When choosing which dummy p-state latency to use, we
need to use the DRAM speed from validation. The DRAMSpeed
DML variable can change because we use different input
params to DML when populating watermarks set B.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e7f13e28caa3..92e2ddc9ab7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2231,6 +2231,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	int i, pipe_idx, vlevel_temp = 0;
 	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	double dram_speed_from_validation = context->bw_ctx.dml.vba.DRAMSpeed;
 	double dcfclk_from_fw_based_mclk_switching = dcfclk_from_validation;
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
 			dm_dram_clock_change_unsupported;
@@ -2418,7 +2419,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	}
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		min_dram_speed_mts = dram_speed_from_validation;
 		min_dram_speed_mts_margin = 160;
 
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
-- 
2.42.0

