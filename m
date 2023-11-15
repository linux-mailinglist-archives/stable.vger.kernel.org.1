Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73297ECEB1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjKOToa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjKOTo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC812C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4HuSJ5KHG5LapaZVGXnJpnBwz1hm6gD9Q3651a0+LF3Bk8TMtbpDztyeP3JEC6ZTeURheJTNBFjOnFC8+5o8aYJLUEGESmbqSkCI6fRzSjT1VqnMw0yBUWjdhWCZhR2KpHYIJPQ5Yl9eMDplEShWya95o1uG2XeBEimRfHg/DW/zGhvVUVd+j4vyt0P3ie+PF+l7PSY/fz232a/MXU5cTYGn0bJX5y7sbI1JChFgH5jIzvnQuf/Ak0HiUxk8GsEKX/rSetg4dg2RbmUlR1lNGOTuBy6u4z9WgWwrrhtdyFgKMVj6u1yijtOp/0eXAACED6aVOKRiIAO4CSqmMHHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RPc/x0z3IXTo4KXN0BmKiO1KOcJFSvCi81NHdNi2Q8=;
 b=KktZ+g+De2zSTw5rOEm+CIz+8zXP3VYp9WVOvYMeSDQLQpwNuQ/jA0uzoaCbMghrWcLa4ZpIVAI4n4cr1gdPpwNKyDy1Ln4WXouSsPGudgHrYL3iiyaHDPVSByx9Zn9H3i2mXJTxhvtEB+IxhFjOO8b1XbgP4WI9l4SNTjQZcLhfL3B4KI7AkZMLjun7Cb/TjnKykpS6reTFVUVfvcF9QDZhVMOwzoJMkeYtTzR6c6HqqWwJ8XgAxkAjYcbvNPwR+OiUsJV+zzNquDOVLe+MueS7clDVDdCMfy/z3R5NIwHFmRHJwY1ChrVgj88S0j3I+ZEctRdc+iS2jPPDsM32PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RPc/x0z3IXTo4KXN0BmKiO1KOcJFSvCi81NHdNi2Q8=;
 b=AJqAToPXEy86oFPYnZQnQn6P80bv+CO3kkey3pCnOXVcoBnG1pXDu6C1IL51V0PRGEkFSWm6t2G9co+yxBI4lGRleaqrP6y8EdHA7pXxSs5BoRbHND1ug5/uXqsS+5gQ031gf3cfiurlJltqMP+ZcZ++IAYrRoI8/us17pfJTCw=
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:21 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::cd) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:21 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:19 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Ilya Bakoulin" <ilya.bakoulin@amd.com>, <stable@vger.kernel.org>,
        Krunoslav Kovac <krunoslav.kovac@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 11/35] drm/amd/display: Fix MPCC 1DLUT programming
Date:   Wed, 15 Nov 2023 14:40:24 -0500
Message-ID: <20231115194332.39469-12-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DM4PR12MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4663c3-6650-4490-aff2-08dbe6134368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37ODKTWB8U19ywqKIJV7lPLtbkxPtiRCbXtR/YmBryjzCs4DtJZDUhx4ZEMqTyvuo70yUWGYLo7hcMW1qSdq0dzMguETqz19XZWbozHWkWt5NeEiYjHyTbjrWJaJR6Wuj/RTYf40ocp+SZpQYKhTJWQRlzYwnRIuKlK+cDygquUeiDgjP+CJ7MBLQpq1P8f/OU/OzL/rrF0xWyLlSawvvIiG+vd6eVx8283ef6kq90OCKLvnTytODxMjvIXkNNBfEClpfq4riRuVoyn8DUjwe4H4OHo3EVZ3UYXC/PlzUzG/hq4XeQ650LH4/rKVHIEiOtqIO2t2mAzjPKW4AlpSHakstmjrK7REpttn4b8/0w3an6YhFqybWhTOFv16L6EWL2xPUz/Ls9MWztMdHCsKexgAbR7+QuyrG0JtVqBtcLvZlzHgtka8reQr1bZQafE0USjZNrzAT3O4SCfyYeEiCiCROfokGyf6DvQXP0v/8A9lueZOy40hUb3iTD/gqLdrYTcDW/hhbeulgQBPXLOWVntGwaQypxRKoZVSzYI5DEH/VKMw86FIY4WaKaWggUjNFNOsTfVoDuyYJchy9vOyqGNuhrZmMcAOX4R9sdIGLg2WaJyEWEdAAOuKjCYwu6UVRYbOx2BS7DPcLaVR+ccE6RhFdY5nn1wZ01JbDoy4TaD+GgzXJRpgFtGrRPQfBXc/uWQKP42LMiKHKxLNUXuFL7P8byYl/KHpz31vcrvAjAyHdVLAQje71NMaqqK1W2QRUI8T352r3MWGeRWTBnELARtexaLLKv2pvk5tE1uUY+jwBABLMOi25LAoXYIe2A8l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(356005)(47076005)(6666004)(81166007)(83380400001)(36860700001)(26005)(82740400003)(40460700003)(1076003)(16526019)(4326008)(2906002)(5660300002)(41300700001)(8936002)(44832011)(8676002)(86362001)(36756003)(70206006)(54906003)(70586007)(6916009)(316002)(2616005)(336012)(426003)(478600001)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:21.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4663c3-6650-4490-aff2-08dbe6134368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
Wrong function is used to translate LUT values to HW format, leading to
visible artifacting in some cases.

[How]
Use the correct cm3_helper function.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6a65af8c36b9..5f7f474ef51c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -487,8 +487,7 @@ bool dcn32_set_mcm_luts(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->blend_tf,
+			cm3_helper_translate_curve_to_hw_format(plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			lut_params = &dpp_base->regamma_params;
 		}
@@ -503,8 +502,7 @@ bool dcn32_set_mcm_luts(
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->in_shaper_func,
+			cm3_helper_translate_curve_to_hw_format(plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			lut_params = &dpp_base->shaper_params;
 		}
-- 
2.42.0

