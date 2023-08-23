Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1778607F
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjHWTS4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjHWTS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 15:18:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674ECD5
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 12:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG4CPzXnVHs3U+qscZkgYvabcg6jxiKiWdW5pKk2/JD6gD1uSZFroBcA4NN9I8Wjx8e5mja9SxHKC+qneTFUHU4jeAWrrn0kd0UuQqSxiFeLYTAE/cWx0zvMHlJdx0voXqc9vfFZne1Z2WLi2w9HsEquBvx04PN7NwCzmZLn40Prer28/MDvzViMHMOQ5fq28MOmz0/gNDu9ESNHPT5tKAPRn7FYfYYO7MCsIOxs78QFv5DzwHgk3pDrscrXzfPVMmOSgcLgF5NR3qpozLlv8TkkwcM8YQVpSGQCTVoMkhtVD8TqWZca9YbpZsqMbwqF4fGwMfC9jzX+bOZISqlbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mKd3arf/3afrIXUjRB7T0C1vzZbK9dvGMlj/74HnNM=;
 b=NP7RVWADbIkuWAOJk5Cueq54fRf7GEYKSUBMJMV9TpDfiypsNKqmj9JBZe0IizeRS08c5J1fWJLKK9IOz2U6mVdB9K+x9VNWPPNVRxWWaS7vB2GioJvwYn9R+yvNe4Mq4EO4ymKOjfvfwn75akYNbLywwrxZvdcUT/8hPpHH8bx/BBDAeGQ3UGRkZ3r9OecvOYz6xC25lPfACl+OU6ohXl959GhbBZ61QOkqB8XWpO8X04wy0chwphF9gN2sXW4ZT9tVkvGHFMDL1dN/sQjeYBxWcaXaUEzm3Cc25sPZVmJHUMhuPpoIVKjPAVVWfdeI0Q4OP/5x4C06P0OcTUbXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mKd3arf/3afrIXUjRB7T0C1vzZbK9dvGMlj/74HnNM=;
 b=n39UsJjAh/T7gvA++8G9K1ZBgrdsVi68WDi9IEbxbN8QiZz1Mpr21QBOFzD0NNHBisU6gc0hieogVsbSrPj50Jx5CsXeIYRANq+Rk8nrUgIy12fX7HoMzZK+KToR3k0oKn3X17et2+rq/mEFk68hIiRkmrpQITgLK6099KaYK6E=
Received: from MW3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:303:2b::14)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 19:18:23 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::b) by MW3PR05CA0009.outlook.office365.com
 (2603:10b6:303:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 23 Aug 2023 19:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 19:18:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 14:18:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y] thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards
Date:   Wed, 23 Aug 2023 14:18:03 -0500
Message-ID: <20230823191803.26776-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8f8ddc-ab0d-49d3-63f7-08dba40db813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEA+69EBLroJusg/YW/7lZUTenq5HHgFG86iweGsRJlfREvx6zorz1LtfNd134XF1Ng7bNfDpEs0SrLmM0vMWhqdghO0Tba9JZoGX2EncEbfgMjMQGs2keCLSY9U6IF2gagLdae+wYdjEFgfccYth3VESRX7YCIip/fElmWKMXFtkyI5lycJxlQiq2nJL36Dk3YLP1G4lyebHRQxzp8LcV5kT7+tuYUCs7RrDoJ3QJn8TQfNuprsyFQbB9wWwKSoxFpIhtVAs88Yg+Th3hGOV8dMInKmWrOWQLmRI1/+C711cZBhVX5NNVkM+qi12iQopmOOq1LeYpLAcVWvDRlJ7WEe6z+JuPNBVZ9DjcGX2C+VoywFm2jm2s3WH3kQRR0HtbmjKlscxgG24CFV0OBGiD+8JY4hRPUbgnVx41jM+6y2niQQiQ/hl0gMttCQ3x3CGSXqqw94v5vxJJU94atl6W0oY+g5gDJlE3/0i/yZhXfnjKg1aU2Adk96n2KuZOFCc2p3bU8YLFznYn+/6UupdUnA3kQ5cJSoQiLOxq/+6xr1/J0iDmzLt+IUNMvcQmm1jNwW1Y3SvgHGrwGRD8cQiI3ERRCY3BkNWDChS3SF+3OLJmZ0j6ef4MXh/6gHtJfSgH891+CqB9Oi/vPxrZkNXzN7aNnb0vqeTTYgDP6Xj1CgmiVN0bV8k05zZPeTeLKk7LP6FaxrgN3Do08nbn17CoHn3E5fAklgFblsUNgst4aQYs4fujjD+AAYxBwZOP6V8+82DqZKpBGbD3NdxrfUxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(478600001)(40460700003)(40480700001)(47076005)(8936002)(8676002)(66574015)(36860700001)(426003)(16526019)(26005)(2906002)(4326008)(1076003)(336012)(83380400001)(44832011)(5660300002)(2616005)(316002)(70586007)(6666004)(82740400003)(356005)(70206006)(6916009)(41300700001)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:18:23.1459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f8ddc-ab0d-49d3-63f7-08dba40db813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Previously, on unplug events, the TMU mode was disabled first
followed by the Time Synchronization Handshake, irrespective of
whether the tb_switch_tmu_rate_write() API was successful or not.

However, this caused a problem with Thunderbolt 3 (TBT3)
devices, as the TSPacketInterval bits were always enabled by default,
leading the host router to assume that the device router's TMU was
already enabled and preventing it from initiating the Time
Synchronization Handshake. As a result, TBT3 monitors experienced
display flickering from the second hot plug onwards.

To address this issue, we have modified the code to only disable the
Time Synchronization Handshake during TMU disable if the
tb_switch_tmu_rate_write() function is successful. This ensures that
the TBT3 devices function correctly and eliminates the display
flickering issue.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
(cherry picked from commit 583893a66d731f5da010a3fa38a0460e05f0149b)

USB4v2 introduced support for uni-directional TMU mode as part of
d49b4f043d63 ("thunderbolt: Add support for enhanced uni-directional TMU mode")
This is not a stable candidate commit, so adjust the code for backport.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/tmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 626aca3124b1..d9544600b386 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -415,7 +415,8 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
 		 * uni-directional mode and we don't want to change it's TMU
 		 * mode.
 		 */
-		tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+			return ret;
 
 		tb_port_tmu_time_sync_disable(up);
 		ret = tb_port_tmu_time_sync_disable(down);
-- 
2.34.1

