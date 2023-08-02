Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D976C5C3
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjHBGxD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjHBGwk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 02:52:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF263C05
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 23:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/E1VAh4aFH77Akd5+Ll6bibMfxos5GEoctc+nYDh6MksKEkuu1gSZVd77XWIM8YNILvracP8DGRH+M+9TZ41egO+rvlxktz7k1fYuZoAYjdkRJcdKPztOU8/3SDliyj2UspKbMe6q3WIHL2bJ9PXtoT3J87TTY8qXimNXX06mvSTuqOu76YivEkItEID81nRmfoLioct0GxdnlgRZpDn5p9AGzq1u2UONak+wy2mzjoWnNUYuYKCbF+N8guM3EBYzgvK0swA9IN1xrOFWk7HsN8GRpRHPeHM0J30i941+ADXC8koKE4964gCak/wMtPI+DLOCuxi3aweY5aSfB3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0uMG3qR8qfmbk5oBzq6++E0PZz1+wrmjsHIaAomDZQ=;
 b=EeZTu8kuMEWwHkxM7WjuDtpRT79s300cF+eo+bU83N3Ta1cORHRBbb12FJ2hqZ8v7Ku1j3qu5soFxcsq094KLiMc+lH8fY5umejZ+MgEZVrgq7v99YMSad5zapyTzYfvcZ8glge4YMh8EQu8Uyy1zJa1NaiZjAY3u9k22kxmr2LAUnxQj8OjqW/dDk2dotPZjhy0AhSp5HhmLd+cuxrSeOTndJsqFatNN0mYEjcvheZbvp8TJOCGstyq6BO36mH+Bg8Ay7DFMHzN72zRiYiOZ84Uu0P/CSn2L3W9b9ImCBduO7Y3jo1N9CSnGYkyGPUIPNMWNh5JJelIxKSFbzLV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0uMG3qR8qfmbk5oBzq6++E0PZz1+wrmjsHIaAomDZQ=;
 b=tqpL13cF9Y6GZVygu9r9TLnl1qnKqXmR3zdJhVSGtOSN2I4QOy6vHkcLN6lhTBvTB1pfsMXk2ckvv70Xax7Pa2kzKKPxweCEwuZHxcvmdlrWBOIr9PKpxbbvzUK3rFY0j24zIPm9uX4iDLivgrbpKx/qKMtxVmFAhPGhBRrl7PY=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:51:57 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::f2) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 06:51:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:51:56 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:51:47 -0500
From:   Tom Chung <chiahsuan.chung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Martin Leung <martin.leung@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH 01/22] drm/amd/display: fix a regression in blank pixel data caused by coding mistake
Date:   Wed, 2 Aug 2023 14:51:11 +0800
Message-ID: <20230802065132.3129932-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 6015fdb6-447a-4f1a-1099-08db9324f671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAOu9Sl9mE470Gbd3Kj/mvQBTRmjzW8JW3mzvhbzbm67Tq7ye+IlVWVAMf9fmbRf31tzJ/wLyTZP1O1pvL3eoodn+xUwlK7ZjST13PRXI2z00LMvRX8XZjeduTBHXHjnkw7Ck1Wm6Mj2+XQy1dAVmqsMPxUvMONxGmikUm5eCmbgBDA9iKbww3IhLJh1TGwS3/jiyGl/qyuBwDkwVMmROAXIadA05PhwXykHYAoKpYEO2TIVCIuQsYTR1izdpJNJ05TIUH3BEz59LXqwefXAtDVNO6Jv3zAHkhcMQVFJ9/MbCQ3WyFykrCN9Sy6kzTMJCCu/o93iUkZm7tK8rseIq5+ydy/ytyeGVK98qXjDkaGUw1cIyL+wGhRM83NT3MDosMr6Fi9TzH0+EN9NF43I1bXv3d454M/PR/ditwSR+WTFkmMwg3V7UsS8H+AKqeyPC03YbuQqhSKGY9vcWFqCJMy33EsCnrMwhXR/kBOZ2Z8Eiijarjx9z1oD+wtNB0o4M47PcR6q1ha4H9IqpTuKBsVv6vuMr+u3e+8K8ufGQcpCKfNOPBBK9wk78sWDL7qp7/2jE/BpGpsP47PfRgbNSQc6/oBYyIiksjPFEfqPKBPDNMCqA5i3SpA7EcBq3CamVeA3xjbL4K+TvkmEhKLewu6zxERLHmKX6RsgIP0C8Ys8wi0J4k9mjiI21fo5CRi8SqEf7jSK2t+BSZEN4PnTiISGLIucaw7jaxKC+/+AlZApY7LYx2KM7E/8NX3N75UkPmo5crLRFILSypPukzW0Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(7696005)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:51:56.5142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6015fdb6-447a-4f1a-1099-08db9324f671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There was unfortunately a coding mistake. It gets caught with an ultrawide monitor
that requires ODM 4:1 combine. We are blanking or unblanking pixel data we
are supposed to enumerate through all ODM pipes and program DPG for each
of those pipes. However the coding mistake causes us to program only the
first and last ODM pipes.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index fc1af33dbe3c..b196b7ff1a0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1084,7 +1084,7 @@ void dcn20_blank_pixel_data(
 
 	while (odm_pipe->next_odm_pipe) {
 		dc->hwss.set_disp_pattern_generator(dc,
-				pipe_ctx,
+				odm_pipe,
 				test_pattern,
 				test_pattern_color_space,
 				stream->timing.display_color_depth,
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index bce0428ad612..9fd68a11fad2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -513,7 +513,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
-						pipe_ctx,
+						odm_pipe,
 						controller_test_pattern,
 						controller_color_space,
 						color_depth,
-- 
2.25.1

