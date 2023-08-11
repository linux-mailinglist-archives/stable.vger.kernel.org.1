Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F6779934
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHKVIw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjHKVIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE7AC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mue0rvlaABbl3g8lowT22ShQ5iW0YtNhywnGPRcGGyfM3WBoez77DytoqBjCwSc8ogheDXghK8bfMG9Ctu1AnfAQw1hoJ2O/9VwRXYSJlZR2al76Zj1SIg0t+8gYesFhj8WT05qa27Jx6glrBFeH/AeR4zkmlns1vDAPYIzusmmschHjoc36TlyYu/4Jy9kM0ezTsEDU8qWh78dXXbdrb20J56Q4gx6d4EksucQDnlDUWhBnAC7ghXq1vE1LArSlU0efbSHl+nNvEO8OuqOMTa2FHiSdr8lit4epKb/PrgazGob5+LTTvkJ2UDhPNKAJDVmL14sAjryrHxhMX8q0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qMuHQxKuYBCic/xSIPr1MUWUw5EpVh9oT8tce0dor0=;
 b=BfET8hJ2gpKVVIAmAg3/qfp1qECWDk+Lt77P4DWUtrWi3zQ2Arw0klGRYF4jA0N/BEYx8BhQd2wEM0xYBOXnTvDaIQsvfzhAC9PY5q6R3G41rq2NsmHBrSjX6HRisEpOGXinbysqypsIT56vXRYEb8N/Il/Bj8nRG1jxhhq5i0SfZyuhSoYRNzYaQgyjrNKKHmKRZ8pO9WupqvvpQOfqUn4NpdA21ti5ltsChsdG2rUwla8AW2UVSeWXEAO4eXv25dDTNh2njSM5x8If3XZ8x633bsv8d09WzuVSBOjBr7pEgp6i/pqB7XZyt9P1d4CvVLcziv0s0Axw56q6wkS02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qMuHQxKuYBCic/xSIPr1MUWUw5EpVh9oT8tce0dor0=;
 b=nJG5aLokEZDWYmbjmh/icQrDeomgX8L4InwbXYHO30h70WtC9e3wH8WMEbwYIEvz2AP+kc7pO1ZVDrGdWKvyAe6AVhirtwEqWTmyhT5w8dxQ2SSsLZmq/FW3egGVL1vApYpYSLxIBwU5G5UMALPdeJiOAaDS2Vtnh5IE5QztLsU=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:08:46 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::4e) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 03/10] drm/amd/display: Handle seamless boot stream
Date:   Fri, 11 Aug 2023 16:07:01 -0500
Message-ID: <20230811210708.14512-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb96c76-eb5c-40d7-7863-08db9aaf26ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xocJJGaMM1E1+Alt1PmKmlfGASHKmp5go9H5IbIxa8RnlU4OWuAMkxEC6dl+rJumBFFUDpKGD/QeI6pmaHOrSf/SbnlasmCkHFv8tZdo3bnCu/15gJmk/Hlmm18uO5aBXCjST1mSPkK2spgg2NGQaQTEsqw786C/zhtqzTtGgtEwICw1R3EdJl6Y1LwipaJq+5Ez7fZFmw38QVfysGw1m+ggOb5pOIyFxVaTPyLh2CmNVIDc+P11+8doRo5c586rpZtbiBKZ73kNM13qhBJO+kQMkEZx1005LTB1BrT3x9EegGfRfmdkSrOR7FNSciicgLiwaiCfVUAtKPv7qPhKIQDy9R8HuqFYyhJyLo7zfPmuRDoW/zWHTegtzIhFfs5ya4AvqO+MGBJQCxdeVI0lIqLXK3cuF6edo+WxvOFN92fpQ21fYiUq3X8NoP2lWz/H/sFfCqDX7FHsBVljuMLTTCi4+6Ur1sMO12+Elns7PMDYdhjujHyXaaIe4d2kwsLi3EOIhZEWxRvF/Lfd0FYsizBHKbq3sa/QgAmJWWYw2fD7Imy2AUP+u3uO8EtsXkMGmQYy3SUxMa0Zq00JvuWx4bC5yAcujDD+0lDnC0oaaH4rD89kftvU8qkm1Pgy/yg31YVxVzQdbXW0A6fbzkb9KJYFftPgssx+8uMlWg6XKPpH3UPnv7sGXrpKxO/02GnVt2O1dXQOk7EmGJQSac/8c8Hw3336r8zYd1S0QHi1JTiPQb9pDP2sSu7IeIE94NBGDXOYbT1nJzckDVKip0jwSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(1800799006)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(86362001)(356005)(82740400003)(47076005)(40480700001)(83380400001)(36860700001)(81166007)(44832011)(26005)(16526019)(2616005)(336012)(1076003)(40460700003)(41300700001)(478600001)(54906003)(426003)(2906002)(5660300002)(8676002)(70586007)(8936002)(70206006)(36756003)(316002)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:46.4546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb96c76-eb5c-40d7-7863-08db9aaf26ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

A seamless boot stream has hardware resources assigned to it, and adding
a new stream means rebuilding the current assignment. It is desirable to
avoid this situation since it may cause light-up issues on the VGA
monitor on USB-C. This commit swaps the seamless boot stream to pipe 0
(if necessary) to ensure that the pipe context matches.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 170390e587a69b2a24abac39eb3ae6ec28a4d7f2)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 613db2da353a..66923f51037a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2788,6 +2788,21 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 			goto fail;
 	}
 
+	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx
+	 * matches. This may change in the future if seamless_boot_stream can be
+	 * multiple.
+	 */
+	for (i = 0; i < add_streams_count; i++) {
+		mark_seamless_boot_stream(dc, add_streams[i]);
+		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
+			struct dc_stream_state *temp = add_streams[0];
+
+			add_streams[0] = add_streams[i];
+			add_streams[i] = temp;
+			break;
+		}
+	}
+
 	/* Add new streams and then add all planes for the new stream */
 	for (i = 0; i < add_streams_count; i++) {
 		calculate_phy_pix_clks(add_streams[i]);
-- 
2.34.1

