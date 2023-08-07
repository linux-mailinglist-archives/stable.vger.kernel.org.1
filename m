Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F97726E7
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHGOEM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjHGOCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 10:02:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ADC5266
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGuRZdbH9WD/qh6tZNS22OlpeyTJFEbz1B9GHLEMtYhZtlx5xYlhFhMoUVs/YwPbAlL9zPaJmnst2103BaO9GTefKVaxSbTEbpyp0f8aaMDzyxjiiVR52pRtO4Nfvgm+lqF23f7f5BKDOrwRo0MelE0nDHLSvjul4CfzTBcQaqp+OJri6vmqpCuvHq3km+3VrWqEA1o1zvHWmyhI/mrnw8Fhu5SQF6CWfABPzgS4XzdCnN7h558Z5S4m/a1VmO52eik0Jlo8PnEMTTxwHKPSlOU83xirMt1J4FDbhwG33IO8I3SAticGkROeyC7xplL9Q+ppGFyGvvr3EMtDOrZpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Tik/kzy0UMHkiCEKktjthDZTbbkXUs6UqHG8OqfwE=;
 b=Zk8yFI5U9LMFW3WZpHPJhFCVRqchBDLjwS35YuUPB9Mmv6B0TuppiLqOMWQDomisEPut6GMGEfWSDoPqgPtZykSYHqJzk/oX8Q+YTmo8Zwie9gnf4FoisS/hjuZVFtlBRt7Bw+207bKZBCdErSqZiXIEXqyX39GvcVYWMzoulQ8d0I7SWIhOYAeiS8/5YNG9J+ujxzPUy/RM+4Y/cRK8ulxMiKhYQVngNInms09k3+5K5kL5SIIQGbmSElr+q6IvLwSvX1iHyF9sQ42MekDN/Fuk80CdsZ8Yx+ejC5hZ86XP1PcbqPudHVKVMh3RFnARlq84RRoN9sB2L9G1zVnOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Tik/kzy0UMHkiCEKktjthDZTbbkXUs6UqHG8OqfwE=;
 b=dnk3aJNk3ivHR/d/CLREq0QGk+z2OiTRA6W3XC9VQn0OBk/fiCcyoQ5qUFCG5gPIV2pvwXAQHSHKFduYvC93aGTIaour/Px0OSlgxvPD3+BsvnisMNJJIqp3nVLHzrJxvoChBQqS5qkiTEbbdPrGICHJ8umy4brLEKyQzfvnYpY=
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 14:01:01 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::96) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 14:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 14:01:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 09:01:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Peichen Huang <peichen.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: limit DPIA link rate to HBR3
Date:   Mon, 7 Aug 2023 09:00:47 -0500
Message-ID: <20230807140047.9410-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 14961c26-47fd-4cc5-910a-08db974ebd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWC3eW19g2UxueDNwZMUivD9y9cjIC+lh3a4h/KeEu4S38SDHY4xW2cwvkadoeTPb2l/oI3xfBf1Bq7rG6/5CUL1xjdHSmRTNk3osc4IwnTZThf8qtBLodwgSDB7aCchkTE0WxkWjB9CJifLt5jrbwx3w3WmL5E+2PMQai2YPOQC+I+Lp6kOMzfeyXVRzEaJHSncr+vGnAQ0QJXvDh2DavDWrkjHGVPhOOinelllQ75Os1dsf5stWqVGNwswjw/PjljBAqfX2lP2w3Il1nRULui+ALHPhnThpoGXgcQvgdJhee+kYIATlG9nTPA93XRWefiQ2B3SveqnqMgTKgdipCJyz8V0hBhcwQyetoodMXjHIW3WrdGC+cH0//3WYFj44cN8TUchsp8QTu3LQf8kqcesFLOPOAMY4OjkGDgM4pq51BjzcaIhuCf5e8BjZmbBb4+dyRBLt4l6NdZnKHbQRlCIycDq1Tj06My1WLfPGbxvL5YYnl4Qs4bHiUDVcGdjg42nh3DLKoCjy+bLsLO2BkAt3xGieJOLFPVf6pWj+lsd3eeMkKJks9wtUowd8gH7mPpV8btZHKTBVM3goVKuaCKR5P8dUEwvHcH62L6YQXlQvKMIn+B6fTT1Fi7YZVRGAWlsnE1JyDmIkejF0N/QFS39CQTDDxT9mF4IQQS2xRVH/Rq7rkmV5SHAylswYXBZzSCcb9ZFw4FJoZnxgPswDlqb3JfbASB+Tq+r2o2SL3EJ9UhlNVojniKPwmFXHddhZOX0eVwAB+n2CFTO1LVsOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(82310400008)(1800799003)(186006)(451199021)(40470700004)(46966006)(36840700001)(426003)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(8676002)(36860700001)(47076005)(8936002)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(6916009)(86362001)(316002)(478600001)(82740400003)(7696005)(356005)(54906003)(70206006)(6666004)(70586007)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:01:03.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14961c26-47fd-4cc5-910a-08db974ebd2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peichen Huang <peichen.huang@amd.com>

[Why]
DPIA doesn't support UHBR, driver should not enable UHBR
for dp tunneling

[How]
limit DPIA link rate to HBR3

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0e69ef6ea82e8eece7d2b2b45a0da9670eaaefff)
This was CC to stable, but failed to apply because the file was
renamed in 6.3-rc1 as part of
54618888d1ea ("drm/amd/display: break down dc_link.c")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5d53e54ebe90..63daf6ecbda7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1141,6 +1141,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 					(link->dpcd_caps.dongle_type !=
 							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				converter_disable_audio = true;
+
+			/* limited link rate to HBR3 for DPIA until we implement USB4 V2 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
+				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
 			break;
 		}
 
-- 
2.34.1

