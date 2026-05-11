Return-Path: <stable+bounces-245293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MzAKMIIAmqknQEAu9opvQ
	(envelope-from <stable+bounces-245293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:50:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E2512A3F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99FFC30A0888
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D147A0B0;
	Mon, 11 May 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bU7jpOHq"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40AA43635D;
	Mon, 11 May 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517180; cv=fail; b=M6oHJ18wksP1Vp0vuQJMikybtXhPcMGSOOGfND5hua3KTEv7SIMGljtV60aj8SBHgk5bYkF3rDefebGNgHMRQU7kXMTgNk0sD1S/tclfaNiwWwGXLImuOlrJZtUd3LTZnWN8aHIos4mbcKjc3L6+lWlWC4LZkqap4dHHQ6CbHvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517180; c=relaxed/simple;
	bh=4S1z0aOnous20LKvRAI3NSz2fzKHRIEZszNFg8H05Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHTYjL8uAI+x+TtcQSIHO18GBB27XKo+uyvlpxK/GMmqxD4o6Ze/MotEEfzxkVvTsoBY3QinzFnOEyatTEEQHXF/pnzeQHYU0O7ytI0DtRdGqhgSSU8UzArNBm0gh/OcMzND6If201N3Y6GIuhylvpn7gE6WBqsKheQWbiVLXkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bU7jpOHq; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Kz8WW1lEdyIEOOExm+aBBz2xRhfthrKn5ioKV3qlHcN1P2HSuhfjvQaOXZXbZHK4FferXuRSk/xKeqRm9qz+yHC9XVUWksdxPQC3bG3WWjELd+R4STg1jsMr0B3DDIaB4k3oQwriiEenPXsAxpNQAFTTYW7TMpbOXOTgLv1/RXapPezABphgjH/kL8rFuS0EKziQjYYabarvbuocvFctnyHZ/jqIP7a9qbmYtcy7RANm0k8OaDhXT7+m0Dj1SKy4gfgkSKgANpkxEgIQqgjkE5n+xVi2TfjZ8wyNdtHIASJKSEZWjB2Jo6m4x1svb2kVaYoBqcKhvG8NBqn1CE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTBdThVFEpNHi2dU+mAd4gM1WT8C3kXv+HJ2zJ9hpyU=;
 b=qqyDqk/dbB6Uawcy0tF/4KKJ5A8oYtMAlCPtZffKuC1Jph4kSN+3VTNrt34K/iKUFo0H1gu2K2NREYWu2aH0UeBbA0KQOrqZxE1dFfu82WYJZ+eWAqv8o6lkBZU+q1tQl5THh0MoNz2r7xCAK4sssbFHZKCCBH4Zz+rY8FLso/e4BxAi77+XWGxd6caELGN3r226k6UnDbXpOiHNYG5zS0uor+7zN+4eXFVCF68hrewBGFFiruyvbq8Y9w4c6NRxdXiRop2h+CA7PtzMrhWhwVhEGFAK6NgdcaxxbqMWoGKhEG5VGwWlOcEgrFh4r5PGis3qUOwnfC91B0tTGBBDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTBdThVFEpNHi2dU+mAd4gM1WT8C3kXv+HJ2zJ9hpyU=;
 b=bU7jpOHqlth+ZMeKUGjpdlX2XGBFAKyQByXbjZDVizNSWryf8JRwhhBB0VxRlNL6EE9W+SJ1ULsykdSYDKAE/nrb/e0BfcOzqP1jUMRrBRcRZCbdjnkIot7vqrF3whbX+mbPwEGF0yQcWHjCxhFJeyRA2aJMRgwhICvi7u3osGY=
Received: from BL1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:256::15)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:32:52 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::ad) by BL1PR13CA0010.outlook.office365.com
 (2603:10b6:208:256::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 16:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 16:32:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 11:32:27 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 11:32:24 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
	<neil.armstrong@linaro.org>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 3/3] phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB
Date: Mon, 11 May 2026 22:01:35 +0530
Message-ID: <20260511163135.2924642-4-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260511163135.2924642-1-radhey.shyam.pandey@amd.com>
References: <20260511163135.2924642-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 512d3fbb-8984-42a7-7e7e-08deaf7af2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	4049EorZND+0+1JCmB5nO8Rq+nJD8DpDgBNUsAtGbPTe9YacBrGJczMH2upUvGJih8SBZNoyToaDEFFGGWAO/B5Cs8oxyqQbdkfF+zusd77BNVePhmH+bJhbg4eTjE4esf/8JfQRGKnly8hOmCfpx2TfG6qVM02JFQ5HKp3VrNyp4trcL/GtOYiRtfvSAGgcQZwxO7J/oIbobAoE/g07XjObsqyAKEcsD2PyKOq9XKy+syUQaRPXvejJIhOR54+kVbqhQemnCf68VNSTPdmzcCh/PM38TSDSMbbsDI1+oIGH5L3qOgP60uqoeaYJ4Lk9rj19zE+fjT414BaUiMYMaekFsGM+ggSkOHEF7siWScI95Fxx8j3cxSpEpe4GtE2SSzqsw+Ne4AUoo/kmKsTv9fKTN/dFkU9k0zPIrmu+ixe7axps5cVyPaAO53fsAAtU7V33t9N0ahd71nHCprTq0FVIQ0gHlYmM1t3Re+ZMEVuH5cpzXsDoVp8MNPUxcUOEyagpnKzy4KsC1rsjXVUtQ5bsLErCtlZ4vjFBnoTmxP9AHjQIwQ8X9LYHjzpZQwE5SKfRqJOZ4AeAW4eFzUOLNs95vNY0O+CIHCsZnsRhlH7kRVw6Ot9Z6IAKjUPX/kiSGvChivvfPGXVGk4mwRrk1l+hAf0TVGWUcTo/bTBzTpqPUbd+iup1P3vsVLJhEo7lbBoAO4RIka3thR+WWSCIwgJ5nqz+n3jXuC0rGlws1eQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/KlCj3WsU7w9EgVVg3K61imYNjRnMrOWh4OgnndL+6GOCtxSxTNbxzNtvwN3RaJRIIUlSKs2ddWLsFTdSmxsnKD1+jGlRRuPz7xR6d6bb082WBw9vAequWW6ez3Y4iRnOQOAiL1pp65CiOmgPIVBUmHv7Nge6JhWPPV75ITxiusXFGUkeGKuwiBwVTNiz1g/qSP1/a2BgoTaiHPPxvajn/lUXTppkKX93G4oruGdxILfHuMyw9EPATBC8a2IN0N7oWjK+82NQQQ9dscxja2upZSFu1XIEv6mVlUsjKKZkLh5iS6YUB5PaIQEsaH0XyvUkXEIXCO11M7bLTNK2UOHYNYHDYKkG/C5YfhkNVgzQHBzEeKmv8qMXQnLRvOdH1CixqUZ08rCFCDOm5nn/zVUu28PTqtyO8zZDJNv3KAfW4i5Xr+wQMlBNKILkkVeNApW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:32:52.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d3fbb-8984-42a7-7e7e-08deaf7af2e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
X-Rspamd-Queue-Id: 1E4E2512A3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245293-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Nava kishore Manne <nava.kishore.manne@amd.com>

USB Gen1 requires scrambling and 8b/10b encoding to be performed in the
physical layer. Do not bypass PHY-side scrambler or encoder/decoder for
USB operation, as mandated by the USB 3.x specification.

Scrambler and 8b/10b bypass remain restricted to SATA and SGMII
modes, where encoding is handled in the controller.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 39 ++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 6c56c4df8523..087fe402e4e2 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -502,15 +502,30 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 	}
 }
 
-/* Bypass (de)scrambler and 8b/10b decoder and encoder. */
-static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
+/**
+ * xpsgtr_bypass_scrambler_8b10b - Configure scrambler/encoder behavior
+ * @gtr_phy: pointer to lane context
+ * @bypass: true to enable scrambler/encoder bypass (SATA/SGMII),
+ *          false to disable scrambler/encoder bypass (USB3)
+ *
+ * Uses RMW to preserve reserved and unrelated register fields.
+ */
+static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy,
+					  bool bypass)
 {
-	xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
-			   L0_TM_DIS_DESCRAMBLE_DECODER,
-			   L0_TM_DIS_DESCRAMBLE_DECODER);
-	xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
-			   L0_TM_DISABLE_SCRAMBLE_ENCODER,
-			   L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	if (bypass) {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER,
+				   L0_TM_DIS_DESCRAMBLE_DECODER);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	} else {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER, 0);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER, 0);
+	}
 }
 
 /* DP-specific initialization. */
@@ -531,7 +546,7 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy *gtr_phy)
 {
 	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 
 	writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
 }
@@ -547,7 +562,7 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
 	xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 }
 
 /* Configure TX de-emphasis and margining for DP. */
@@ -707,6 +722,10 @@ static int xpsgtr_phy_init(struct phy *phy)
 	case ICM_PROTOCOL_SGMII:
 		xpsgtr_phy_init_sgmii(gtr_phy);
 		break;
+
+	case ICM_PROTOCOL_USB:
+		xpsgtr_bypass_scrambler_8b10b(gtr_phy, false);
+		break;
 	}
 
 out:
-- 
2.44.4


