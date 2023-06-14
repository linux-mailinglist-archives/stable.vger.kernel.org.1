Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DE73066F
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFNR6m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFNR6l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 13:58:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588210F6
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAMkIZ7Tow8mqKtDH5QxVAku2bO3xqUOy/GIrhEoDCD44ayMmdSkGLeVwDOw75VgjbspQc1WIg3GfWaxAQ9yt2jWa7JT8IXdm35do5/grKQvgtbTP78hme4mqwiihnEFhtBfkpqP8biwIwiMwsiGuee3GvikI8Z8UFk1Bt3/a8BFh9TvqoT3r2N5RWDrSDcdiyek77g8U4DYmcWl/Lj4G4+ALByGyAVdKH3Htkhq9oiMumpY8/NE5nZDjUT0wJuaHq73UBj47+Mwcq1WI52tF4Tb4RQm8p5RSpzMvW1iE7LIMge7AvGY176pZQ8xq1pfQnoO5jNi7+SoWL0mDjqqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF6hNZMOIMmuTdKfZtbAFGb1juuYJz2swQ+8YNUu2iI=;
 b=PPJ/NtHxICwsUwHkbOAe4OAfZrbq5OpDebcbu98RQZU1Tx5XF1WyuWgRtcVpBWCSYtp0VDKvfeSYxWsIPj1H4syM0kIj8+zShJ4RxTxu6NDlwg05wDLAab8xFU71jRry/jcfnal79/SZl/hW8W8vS4VzuTkx3LuG1WgexyrFv3hNllz4yboUNEc8noy84tPhZw7CWG/lTUUSd8zvAbKjdyvGRiPwC4a4yyOd3cnGc06Nu9aUqXbeT/mGK1GSi9Ud/Pg/gm7JtcmksFH6fFM3S6UVoWH3IPQUk8T0NKiqKW//BDpPETg1tdApwcCaLAqNNqQfN7Pig4/kqLSAv48e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF6hNZMOIMmuTdKfZtbAFGb1juuYJz2swQ+8YNUu2iI=;
 b=Ljg1xCEV3uuCfI3lI/36Yg7Le8PRCrRhVaGMW2ELDkEi9UPdZj+SqPdCUY9hD8uqEbQDf4KX2iSJekRNMrFemdx74NeM+ilizW5KrgcSK7Rcd3sbs1XZMUbGnuBauWv+Gqv9Md000khK6egSzRkOQ/ICHSG6AMXDlkU4rGWIDfA=
Received: from BYAPR06CA0019.namprd06.prod.outlook.com (2603:10b6:a03:d4::32)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:37 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:d4:cafe::f) by BYAPR06CA0019.outlook.office365.com
 (2603:10b6:a03:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Wed, 14 Jun 2023 17:58:36 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:34 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>,
        <stable@vger.kernel.org>, Wenjing Liu <wenjing.liu@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Fix 128b132b link loss handling
Date:   Wed, 14 Jun 2023 13:57:48 -0400
Message-ID: <20230614175750.43359-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d55448a-6276-4945-5b9a-08db6d00fa1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmeYnQlmmfpLRromjP0fmHhQlxTv0rvfdFnRBEcWpmpVC7oosqrtTd1IiLEKffmtwm3t5N9phIhjl9Jq8mTSgPy0TiYPIJqTNjnGvP2nbt7oVNUNTNKXBr2rbXFnIFa9HWw87ACfrLZWcQeVZokubbgc+TkJrXiymjXGMBBteM/HbpRcEais7ImFAD2Vd6le7xpc6pbT94yhOJ/99xk6wAZH0B4USItU/IQymAHpWJAB3sApuhw59BIGBj9ySoX4H6VzrQ0P8Y0SoYkZUgKPT5rOs3wcUOfbxWa4WIjRC0TrvAd7orFwQ2uj33K4eBSXsP50fgtFAro6JLzsiLw+Lau36l+4ki5dnBrbXYUzNj2fPsrkTZZWeGPwGdpT6vTHaO2jUWrjHdDGs2NAYbty2lhlLkJdjvw1wJZyrB9uX5px30Oh8iOQPtHVk9zV8zI2GFv81Wwotax3qPXUosD/Jne7g2PdzYDRDViqvlrKAku7SEvRQkIB+Cj71icikg0DGa6uQR32V22JgPAVe5jc/FzidYohc/0DhxUQnnSf8kZFm9w/5UT7NHt+jzDHeZd04s+rtLEcyGgi49yRHZeEq84HhzhmSy8eQP/dQ28POnAeEpW5QIZh5T9BD7rd+TXSViiMj2I8JXQV+Oqhg4xZF0W9+Ba8C1rAQO4JqvUGJ+mcxhWGbbDzoiTqaMXrq1k4CPzwI9JaLiwJpFFvO+ywIYYZRuvwCiTBIJIEEI4FGPK+8RPopxVXuRYjQodtIe9qf7P8Z6kA1w5djnrdAHILDlisHZTlHRBXHO+Wah1B0pngqhflOYIfCLNsKnwJFw9h
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(6916009)(316002)(4326008)(44832011)(41300700001)(70586007)(186003)(70206006)(2906002)(54906003)(8676002)(8936002)(5660300002)(16526019)(478600001)(6666004)(36860700001)(86362001)(40460700003)(81166007)(82740400003)(40480700001)(356005)(26005)(1076003)(83380400001)(47076005)(426003)(336012)(36756003)(82310400005)(2616005)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:36.4459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d55448a-6276-4945-5b9a-08db6d00fa1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
We don't check 128b132b-specific bits in LANE_ALIGN_STATUS_UPDATED DPCD
registers when parsing link loss status, which can cause us to miss a
link loss notification from some sinks.

[How]
Add a 128b132b-specific status bit check.

Cc: stable@vger.kernel.org # 6.3+
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 .../display/dc/link/protocols/link_dp_irq_handler.c   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ba95facc4ee8..b1b11eb0f9bb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -82,8 +82,15 @@ bool dp_parse_link_loss_status(
 	}
 
 	/* Check interlane align.*/
-	if (sink_status_changed ||
-		!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.INTERLANE_ALIGN_DONE) {
+	if (link_dp_get_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING &&
+			(!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b ||
+			 !hpd_irq_dpcd_data->bytes.lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b)) {
+		sink_status_changed = true;
+	} else if (!hpd_irq_dpcd_data->bytes.lane_status_updated.bits.INTERLANE_ALIGN_DONE) {
+		sink_status_changed = true;
+	}
+
+	if (sink_status_changed) {
 
 		DC_LOG_HW_HPD_IRQ("%s: Link Status changed.\n", __func__);
 
-- 
2.40.1

