Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18D7175E2
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEaEt3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEt1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:49:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2CC0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdGvUj5jo3wGLmdxsWyJj/GWrddGyULOMdV6dt0cTNPvEKDeTUmf1qwVBSfKRB7EljgM/2NizzigS9kVG9bmcDf+J3eRjp5pO8OjFg5wDZ+4Nv0Tv3i5IWVygMcom2XPoIkDhmwzHtXDKQ3ShID3ApdaFDmd2O8ButBYhktHbOybd7Zy8At59VHmifPGBYkEw2Y6fwOwv7Y+lQwRTbPOUEzotZKf47Mzytbq/aMpV9sP8kb/vA9JOLypSo1hzFdE51SPpv756CwVRTyNcqjhwkiTjnbUp2BUs6Aw/oWzNSg8mm6gYnYf13bhCP+rCxscbKPhCuZB+AsKbQ6faVFBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9ITJyozy/cMFFEYZ5P16pnofzZp4PjBN01m42tUd5c=;
 b=aU3jkMLIEWAi8NadE5i+4ITT1mxKTs9gFFqLIASE+LORm7/j0lhBE3UiPRcbI7zOXH3+SsnxutE9gCIVray0xDvkMhvpe/gGGh5lNXDofGhrtkSLgaAea7VWKFfd7IxT9ngHAzkbNJUYDxzq/F+LRCUSygUwVT5xOL6IHhzW5Rpqq0YHD/wjA7XiwBx7oxSkm8ziw3OTKP7qt2TlgoFw665i97ag1v7dNnk3jWVv4No0u/+DX3vY+uM984HizNhWKPlSor3VLTP2C7nwuLlZPhWV/Fs7FImOWxe1N7eJnvNherTuTnSoGqCEH2V+L7EtZq17QAoFldihs/orIMLUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9ITJyozy/cMFFEYZ5P16pnofzZp4PjBN01m42tUd5c=;
 b=rwAYUG6k79oQbdwvMf6A2GuXexI8G3ReTHM2x2JnN5ceGRfb+9W1vo7COBqD9dvHkG63oIdZ9WRZfQNiIjOjx+03GTAgOFDDbUfHPvIAatrq2Rn6WpRxyWGLMJwJPktfX3tNWiJT9pfRPTU0HkCMlvYPRwxu2ArB0bwoQyB+2t8=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:24 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::6e) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:23 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:19 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Nevenko Stupar <Nevenko.Stupar@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Reduce sdp bw after urgent to 90%
Date:   Wed, 31 May 2023 12:48:06 +0800
Message-ID: <20230531044813.145361-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc5fc3b-1519-4aac-5d52-08db619267df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt2eOuJkpcpEmrZ+RG20SMUA0pPxuLAyQitFqQsSxRrjOwTfapAH0zfFCefX8gboQ1YX1v9HVLI86We2LoyStmpybv9U/y5QpBsRoplVptAh89u2CmDyQYSUpEadFDH0kl7FGtDxMW1a1p9qjTBq2XWMvkS0XrebBUYj4uF12PEjxYMZFE6mA06q2T9byf1D3XQiPvF6XYXRIOMwV12B+baHqXxsOcJmFJwmF4wdu8cesjYra6eRZnGzHyndW9qRewoV7JPzNy3IfHDkIuDMLCxcRjpBtHfedcOnhBXCLcUyOVbyULaDUSO17QqwiYB6HIOXCENMoeKo82mjeKIWf1rJT7YNMhzEvcUolR1XgZ2hBC6n8vvIqsLb1HFOD34UufbUkXP/cBh9ssbGxyR79C/R/Kh0fbhHkSP8J3ThFd6bSBsMp12VU2n3/cs5dXg2KmBCgoCsA5nw3nY2sBw0Wj1Sc0+IGbSbgSJKyRIa/Mf7P4kJJL3Y491zlde1GEzz5bWeiZsZgN/3zRM0wtXxoi2iyIAm/xqGA8e+qVK8tUqpQU1kGhIcuOp4BXWGqppFIxqKUKjwjoPChU6vSORHhN+0LNjUue4vV9u9vq36DCmyTqFd+Wd53GmaKvs56lnzxlK9047M83doaXFsDcnKPjzhrm3DZWiBecxc67AGHXoh7dxppvqnFI+9ytjmU7NqjVcMpeky6X8QOoqQ/x00HKQAfH6KeFKUvdOG30WFjnk065ZIwu94k1KUXfzywQiBGWBN1R+cPblFD5f4hGWFNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(426003)(336012)(2616005)(41300700001)(83380400001)(1076003)(26005)(186003)(16526019)(36860700001)(7696005)(6666004)(47076005)(478600001)(66899021)(40460700003)(54906003)(70206006)(70586007)(82740400003)(4326008)(6916009)(81166007)(40480700001)(316002)(356005)(5660300002)(2906002)(8676002)(44832011)(82310400005)(8936002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:23.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc5fc3b-1519-4aac-5d52-08db619267df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Reduce expected SDP bandwidth due to poor QoS and
arbitration issues on high bandwidth configs

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 137ff970c9aa..b17f30afa189 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -147,7 +147,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_sdp_bw_after_urgent = 100.0,
+	.pct_ideal_sdp_bw_after_urgent = 90.0,
 	.pct_ideal_fabric_bw_after_urgent = 67.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
-- 
2.40.1

