Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888377E370C
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKGI6d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 03:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGI6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 03:58:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B2101
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 00:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0XqUgkoF7HK2Xbz+mB0f9N9fAJ41s49wf4i5bnfYZeAQ1ma5UNsjlq2ZzcvQfzKdLS/EErCGyRlqqVSpBe2re43sZTGrnQsQYne+jEjdK1mzFXimlpwXB5GRkbi+gq1rW5ObXUX8GOtqtFhdNpUKAXLRgYiW++u3LKb2IuByKQnJHv54HUlac2AGGzvgRR+TB95RBaqGgVRRpmV7ONz7pCV7xRpeTd2gZa2Fd4icBQosPaLhwCnPEiOIBUfw1EQ/0p16S8gD0E8e4VDXBzDexzR9H79iq/FQw/MlQjAXD1kVXwpnInRXVMMav2Zkxar0yETCCtR+7n7F0X0NctMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q4lEvNq/oIojGHrF2QNqPkqGFKtsNS7Lwuj5Uu9xxU=;
 b=dzmPcMncCL6zgJ5QdE3FcibgjouG/gRk66zPmw+Wc/JxezGdqet3V3Zx9sctdLXlEv7Xx2ousKiQiitQf6x6GdfQD6sqSpFCPhrFLXuIwE5i8VZfZogJme0YLJXp6d1wUT/ppyNvD3tFW8tFYEGwKcpQw2TAqaHk+NiX6jo5JcmUjknxCkFGfk6z19dAJ0KQvenhojtoJpWGZ7NsS/4elEG0Kn9CJJtaKkw+YNJeued265Wmnm2q5u5BXaTiuOK+1HEboo7foZtOKUeKkWtP8K0myCCVLWFGBd62/zRNdzZLYtyk0k4So4d14tBzYn9J1xd+UUi/yYn/YM1ZrNk1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q4lEvNq/oIojGHrF2QNqPkqGFKtsNS7Lwuj5Uu9xxU=;
 b=CDswdqwCe52EEOru+8SMwXBxxHeR+gTwNX9jU2MtVOTtDA5WJatr7EXls700AzlB/cl1khVJJG8ByUWt4IFXYd30SLKKInp4Tv3PRQhHMVAnnPzmJSqoMRv0dXnKdNTphN3DkteFF5AIw9A+Fgxi6BhvY9hs4iFNcWR4QZ2HpVc=
Received: from DM6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:5:80::15) by
 MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 08:58:26 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::e7) by DM6PR08CA0002.outlook.office365.com
 (2603:10b6:5:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 08:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 08:58:26 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 02:58:24 -0600
From:   Li Ma <li.ma@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <mario.limonciello@amd.com>,
        <yifan1.zhang@amd.com>, Heiner Kallweit <hkallweit1@gmail.com>,
        <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h
Date:   Tue, 7 Nov 2023 16:52:36 +0800
Message-ID: <20231107085235.3841744-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MN2PR12MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4afdc4-7a62-43ae-0a61-08dbdf6fb488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIxsuybxiwRx3clAtpKPxZOz+kBpAqkKxXWrSgBXFkK96vYx2kaQ1+7w78auDmbyc6eatNl6JfbtAvp6LLBqlRYcAYNXL37UEQymXJpU74+pz7pXyILs8WqmpdZi5g5EUySn32cfyC74e4QnDQ+EeAtPp8xR3MIl4/0zqFq1P+TAOB1S/XDWSg0RHNTQIj+7TnaLZHk7+7qYTYACc4EoIUTx0eOplVL1ThaBlgRGz5dcHKhatA/Tt6X7v1OIITYqYUHyK3q+jftG2f9XmzSEd4x8Bh03kAZ/SjgYU8q5cErS0Yb1Jj/84XMZ50drKohV/CKeFPeKszADOVnUP7WGmiIlH6ViVWIvdE0vq6Clt4ROwxqe6E8DmBCeX30Vt7vADnnYyJObajEClEHU9nSRT1shzwSEsYactD8puJrlipoFTzIL1goljHwCMs6xsVMJ6EJA/0OqrvX95gPZ7G64kSsPTCv6U/d5Nfa0JZwTum8IdYgwodo6wGNSlHTesEI6dc+pUPeNCNDtcrsYKfa41M3KN+nUWILFpS84FQ93yp3bFv/Jn0v6walndNJrzWaZBF69Bdkn6odOYWpGpz4i0TVSwwWcYODAdUnEju+u9YU0AQjqsbLqWqBXhITbzANoKjIw+8zXCFPLsmA+2DZo3i1V0koyojswWoF8mxEKkMhLsv3N5Don0SCdEfGjdCl2olXBSUpMdSai7iBVhQTMPf5w7MlahGRusrpSVcvQ7DQBnuF1+A3Ek8pEN8I4KLxfwenxY7ighhFVqlDlGIeRig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(41300700001)(7696005)(316002)(6916009)(54906003)(478600001)(70586007)(8936002)(8676002)(4326008)(36756003)(70206006)(47076005)(40480700001)(86362001)(44832011)(5660300002)(966005)(356005)(1076003)(81166007)(83380400001)(40460700003)(426003)(336012)(16526019)(82740400003)(2616005)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:58:26.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4afdc4-7a62-43ae-0a61-08dbdf6fb488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[Backport: commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e]
This backport to avoid the bug caused by r8169.

This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
causes tx timeouts with RTL8168h, see referenced bug report.

Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 45147a1016be..27efd07f09ef 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5224,13 +5224,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
-	 * Chips from RTL8168h partially have issues with L1.2, but seem
-	 * to work fine with L1 and L1.1.
 	 */
 	if (rtl_aspm_is_safe(tp))
 		rc = 0;
-	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
-		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 	else
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
-- 
2.25.1

