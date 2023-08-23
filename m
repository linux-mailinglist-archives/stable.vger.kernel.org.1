Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8D78607D
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjHWTS4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjHWTSm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 15:18:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C767CD5
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 12:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1S4aNb29YdvJ9L+L+TJXtP0yZs3NiWW9FWxMTgjcuxHpou3aIbDDSJxOEfMO7iYJl8zktiLYQVWO1rtrwd83/kUuZoElWH3zaFPM0Xz0iZMgj+3rJqPNEH0tAao1sTCe5/VQK7DkP+my9OLR1g5PZSfn9ZdQyJT4svTT95R9+hOH/b0Qo2+MK61Ks+tZWHQbKtc1iPBmkuA8vcFKgIjV+ieU6vvV+/ru03PysYjiUoAwAUJwW9itA+z2G5jK2FxRh/t9iMp75wAkjZ6Pgz8BkFQchRPThFWe4iXGWm3kSV0FnJF1Au42N7wCt6XdO7piX4FVVmWFF58HXW1kPpQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mKd3arf/3afrIXUjRB7T0C1vzZbK9dvGMlj/74HnNM=;
 b=KrGEnSbf1cxbA+GWBxH/OPICr6i4cdKD3JZIzo9YVdUiIP1Zx/PXtwoWqvsc/QHgG5PJL6Wc9l9JWbBVj+rM6PWW05hlrm1L3jRha8x/Lu+J+IdO74wWNiYUQVBLpvngo8lkNZG2nWt6V6Ig+eLuf5DbAtlrl0vvJR8VO4xVaW9beO4yt2bl/WzPZ0vzprN9+Y4nGXsvw7XFmI0R6uKzaLLk6t8M/rzCg0pr5+ShOYlakUYzuSg4qnItm/Wh0TI7CxIcAVD0qURkjspTuOocTwqWyKX0m9hwcL/FVMcZad8P5jdp99vse+tti/dqnRXhMAdIv//dPhwg8x0Al2IF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mKd3arf/3afrIXUjRB7T0C1vzZbK9dvGMlj/74HnNM=;
 b=ESkYPL2nr5FMZFW/164xVu+2J8V1cfKsLV+iMn5+fYw8B98aWD8HDDes8ivjXQNdkZE/liY5DByJ+jG17fczmCsctpnmuqbBlw5SVDb3xKi2sE1z96loT7ipEw7JmHboPHpwzuhKVN4RciRsdhzNonRFZn/pnMzee7s+Oyca9e8=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 19:18:37 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::6f) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17 via Frontend
 Transport; Wed, 23 Aug 2023 19:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 19:18:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 14:18:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4.y] thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards
Date:   Wed, 23 Aug 2023 14:18:25 -0500
Message-ID: <20230823191825.26861-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e060919-ee5c-4c33-af76-08dba40dc0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD+j7uvH0wtpFj10Oco+8jcTwTZVU14D2+nKP6bBqd1hjabGKu79+xEC+H0P5m4PVElu8xNCaly2c/TnN8KIVpOeWtiKZu/SRctVyaDQmwVL+RX7BhaXaReQQwETZSEC/Aonw/8AFHz1vZlkFaGFvd+IoXeMJCuMk16sUih4N3sXiNpoIH+rt6EBgpmoopGVKgW2T+XN1D6oAPed+EEY+mp75sOWLna2iHCWolJqxLFgHDeCjWKekWMvLTCWgB1FknpDwe826ZuLfnR5EZ/W5boEog0//JmbVNjVAaXiZFXXFtWZm8RjAgOSqbae6RD6gF5ns4osbydvxUw6zqdZ9Z4CyEFGQ0DzVp6vJ45w0NxnqhfxmjERM0AtQe8kb/+fHG/drD+fyIz5XP5qClafC1AY6ZD6TUeTrT00UBeqkmSzdOapoNb1UMXEKGE4tMKdemCrOm6WnisCRS2cEXN7urC0nR5Egj+xnmHk7KkeauZwNzixJvhWk3vUrTXFU09WtELEOe7HlyI3AHuWJFl+j71yQNT4fqQcPcF0SIWJIRuu8QHgIeVMVlIyeQZdpicw4bByLS9dX+T6hmJp/sXQ25eFCwOjkXMqEGfDKtvmm+vhVX96glO8kOy0HLbibXJsftYwA4g1Qo/o89KS1S0CCneIuTpkmupHT3KB40LL2aposvzWPRhMWMEkooxGMuZ2eoDXrOl9HcMzaQDlNkHzvHBQ6Idfy0BuJq9LpIcaIyEoRBTPzr+/+SvVF9pDO2ZzbFeQRXdt7raeCi+7ROUeyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(478600001)(6666004)(426003)(1076003)(16526019)(2616005)(7696005)(2906002)(336012)(70206006)(70586007)(41300700001)(8936002)(26005)(44832011)(4326008)(86362001)(316002)(6916009)(5660300002)(8676002)(36756003)(47076005)(36860700001)(83380400001)(66574015)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:18:37.5789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e060919-ee5c-4c33-af76-08dba40dc0ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

