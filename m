Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DBC7E4F85
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 04:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjKHDe0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 22:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKHDeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 22:34:25 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3E18C
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 19:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTD8DS1g+pnGhgljqlBBqC/O4KTUdyy9uplGb2Kn2Q0RJ9Xcbn58kElv6qVnY41t7HlRWAZ0l4Xl4N4WbRRh4rU+t5ptRlik/S/1nj5dau1gAq1oTYCn/PljZz8wxcVFD54FP6jcyPTxE0JWJLAgNp01xGH5ad0ZOSfFujtVZpwF1JNl5UjItiiksNiR4CPOaQSkouXGx5g1ebWUZAzb18daGWqhGK27svEjjLN9mwjv6qMLj8KR6wcuom7Lx0uRLgupzi5mxldNkbHHXsP5QUNBbGxE3aMwXmHTjPvfH170mRGncRdeGN7ajRODCPVJfb4hoB2luevGlccHDk5Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwadO+5JmL2902jOn6aIVqPtJIeEoyQUImYQ4JsJ7qU=;
 b=jRu/4rQiedH8DK7gldLD2fmh4lIyMWXTidSvUAcRZKDx4WbKYxgK4tNSksutPJwctYyRJoiIZlHEUI8KZ2HwzilIfaHBn6ybpKPXPBSg3+2yxKpFWib7epxVQiAHLtOwwhO6EFE4bUh3zO48dTymY/4i3d2rIMHkQ2x7oNjL8rFrE8Mzkk5d/WJySRodPCjybYLoONrd+J/tEBURv0c3Fwtymux2bvOwxFhIW9AkhOitHMZ7QDni/Qk2qeycJPZ90hWjQMWgIhgyUbQO1GK7SvaGZz0oUHGno78RfNX1i9bzSOanGx64iv6ImDyk4ZeusoOt1wxT9Cn3GeWTg1AcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwadO+5JmL2902jOn6aIVqPtJIeEoyQUImYQ4JsJ7qU=;
 b=m+R1N9uU1fIwOIA7jjtOJJaDK+sPqXZ08SmvyWff32siRmMCSa8rXqmCGgVcWABhU1dF+QyVzC7dWaN48uofsU0mSd/NxpxHZqGTy+uxOFSXXeRPJrvJQp0bCjBeC4vffe3vKz738G1QXpGr5Pv/EpqV40jps6ivT090Hw3g5Ec=
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 03:34:21 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::4f) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Wed, 8 Nov 2023 03:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 03:34:21 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 21:34:15 -0600
From:   Li Ma <li.ma@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <mario.limonciello@amd.com>,
        <yifan1.zhang@amd.com>, Heiner Kallweit <hkallweit1@gmail.com>,
        <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h
Date:   Wed, 8 Nov 2023 11:34:00 +0800
Message-ID: <20231108033359.3948216-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dca8b1e-69fb-4578-1609-08dbe00b988b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1nTMmEe8PK2B5o8G1a1E2xfZ24eY27A0kb+GcUVYwUJwYGOvOy65W3jKWlLq2bXu/oalaJSjh1IyCHiH3wtCXNfwfsHARj/2s+84w8Yi2ks2qukXk842XH5xeWFhIjRqopc22/ubXyLN2DmDZfQZM9PZaLcniOGW8/40TP7l3XdyblK8PY1Q5kqu68MGy03cXdCHz0N6Lraw8kZ5O2sfxT1qhFiHX9uHSFVrALXrRCU2pU/nNy7Iz459HzLOlYL5z7s3ac4KeI6dEPYyCJl8BQ45trGA6fY23KQ0JyFeE+V6DI7bCGSxmJjZuTSqMkj7zQoipO37SNLx6QuMobUIste8RoD1N59I0AQGtAeastSSMvCtehZekykuyDWqqoMX6JPpogRJFy3Uc4AoYTQIKLrgBb1zdKMyuXu9VUZIuxYWWahGw6wNIes63x8TiFWUSkzeA6aKlGKKyGkUB2Rdn0eVaDJtbhcUkCruxcX+FHqeum4RTRC4Mu0NGzJM+f2iv7DaAKgC85/OBZQ1MYgUqJBpw7NRIZIUquqpvb7fm6ichwiPjciR+WeJCAfBbYn5uPsMmHDtMA4sFUs5jhQ0Blr/RB3BuGMDAwuJH1oav51y0VqVTGXrqeaLbuSB9mB3uFX/GRapRU1tp5eUDDOVVDK5LZJwYu31nE628Qyzgqg9V4Gcwhq3TWU+ZMprpIs1R5KH3edVol00zfvusBmArMI2GM8Pam45+DBDiAEu+MCFsToNf/3e5L8AjUxvjgclSapF9I0Zln/H8omBWHfag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(426003)(16526019)(54906003)(40460700003)(40480700001)(70206006)(70586007)(336012)(36756003)(6666004)(7696005)(356005)(26005)(2616005)(1076003)(316002)(81166007)(82740400003)(47076005)(6916009)(83380400001)(86362001)(36860700001)(966005)(478600001)(4326008)(2906002)(44832011)(8676002)(8936002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 03:34:21.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dca8b1e-69fb-4578-1609-08dbe00b988b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
causes tx timeouts with RTL8168h, see referenced bug report.

Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
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

