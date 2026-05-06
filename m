Return-Path: <stable+bounces-244395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLiuDFFS+2n+ZQMAu9opvQ
	(envelope-from <stable+bounces-244395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC14DC57D
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E194030556D6
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218D48033E;
	Wed,  6 May 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MTHf/+EU"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561647ECE2;
	Wed,  6 May 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076524; cv=fail; b=ppGgaJjBV+p/bx2ikxCvBbTT2VK8JTVLJwGVIo6NijX8yvDoUNUnxKTaTTTSOg81H4SG4LS3qzDhMwW9tVRSv2xCTlXYshEIJR6Obo4zy4CJ+og4g24x+UDuIB/EYteuy4C9SFaROVnYIR/jghq/ju5uoz4oWLOlzCI6bHH3pjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076524; c=relaxed/simple;
	bh=hcY3CkNFU3LUEew6IvBU/Kec46ZyZuF1Y0icn2q6ONs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZO4H/OYMH7wWqUoFlIdxMt8kpKdF286LtKSv5GNhIJtFo6DWVWMViuLm72V33/cI8nENVBRmvQ+azaoe+hUum++I7+T6y5xNyPBtAJxskcBAsMIuYrdYKDIWAd9ov/cATnmG+dky0iuObK1fa4RG3DlgQ2BX52IKb4fX/4yDR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MTHf/+EU; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLOIue+PagrBFKgt4NavwB9kQdovQJ98WucztHdQaq7TJrTxfGbTRQ1lN4ePwUXVHj3GAGSnJha99QOqbuzVb6r7wK+WF5g2WIOLn7PtX+s/eP4zQv0kLVM6yQ/n5DParF2mCrqS9RCnCfh2pA15JidKETmkj8MpyCfDzsHxaLTrHLFviklk9mMK9HpoZul43Z5KktbL3G6CjV609lhVfDrwNipun94TCNmvjycJJpKgO/qUjR7eucibtsUELY7Yv5wdFvfuxwe73SXAjB028rv69Y539wy6yPP9i1G+WxVVerd08Ee+O6xRycGd3Oe3ivZ7IiLT/IUIqZSm/kU5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQXQY0Y9qflbIkJepHUf9YeXaRH3eIzGC+WS57V3IIE=;
 b=H1G2QHOBECbo/XtYncZOycurm8RrJnf/FH+KCI5rK9wT0d1X8y03w11SjJrTXG4R77QYtK53eG+Z7M+xUufeEpiXiyHKLAVIMYrkzToACSIMcFP7P4KpMuk+cs3SRqr4zmf0/1/SOJZCi05PPKUERaIagZ9kJESQlY4nvk6u9QyGjG1AyR2eac/aB4/9WgpYCSvsdsZHez5fsDrsShPfuG8zHCyMb9K0omD/hEuCXG2UgoyD9vNmJ6d82RZRq4SGPhnYwUdWHS1tfbXKVhwCIhZyQtj2yStbgor/rQ82Tek0AAINle1dUBlV0MVtC4JgT9VNKfJ2hqylBtcmgme50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQXQY0Y9qflbIkJepHUf9YeXaRH3eIzGC+WS57V3IIE=;
 b=MTHf/+EUfOyAiDUSi+pOLrcHUExDJIzjO91Dxt1DcnW6+W2xOj0DlKXbLlhI05FfsLFeF2ube5YTK3Hh5LvzfZNYIkYE/sc9ZUhManxXIEue6dBtbI4Gsq8uBApX84sqEju4xqyfDl5+evCWDP39vEnfAQzaf9eRs/0neAqY13s=
Received: from BN9PR03CA0311.namprd03.prod.outlook.com (2603:10b6:408:112::16)
 by CY5PR10MB6117.namprd10.prod.outlook.com (2603:10b6:930:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:08:40 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::27) by BN9PR03CA0311.outlook.office365.com
 (2603:10b6:408:112::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:08:39 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:39 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:08:38 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWn1221395;
	Wed, 6 May 2026 09:08:32 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <josua@solid-run.com>,
	<w.egorov@phytec.de>, <matthias.schiffer@ew.tq-group.com>,
	<d.haller@phytec.de>, <francesco.dolcini@toradex.com>,
	<joao.goncalves@toradex.com>, <emanuele.ghidoli@toradex.com>,
	<ernest.vanhoecke@toradex.com>, <rogerq@kernel.org>, <eballetb@redhat.com>,
	<robertcnelson@gmail.com>, <afd@ti.com>, <u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<luis.parga@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 02/13] arm64: dts: ti: k3-am642-phyboard-electra-rdk: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:34 +0530
Message-ID: <20260506141040.1368918-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260506141040.1368918-1-s-vadapalli@ti.com>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY5PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 54670be7-24a7-4260-d7cd-08deab78f928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UQYm95/GtmKzyYCFjB3myXdXbVzEA3zFykU7h+bL1H8wKc9OEccSf3LH8cv4/A7TcnJd/QT7cfOWy2CiAdOn3jnXGKwijMbPYbUqnnFeqc855eZv+oRkrVO3xS5mq73Vx6tRjBMC2f8+1tUzoDSmrcdlYcUtV6UXRZLw2lObgdcH/7nUKCl6tmhZdlv5SP7krfiCV5ENOHRrHHI9nPnseD5WKi8OKBDQdzr4KBosi2jf3Rhm5BD4g5rIXwdXJ8OxAH4CeKdF0mR1YAHTnTIwTWSULpl9XZbUZQQaML5brDW7hmeh/dlTNN84GMoew6VvCpJgnhE4VTtXRlFjY5PjdSnG34jfBxnPyD8b85QAXvnTkefm0q4eVjlBLSe7owBkispc8HvNwwzs8LEO5oXTTf15ezfdT8Tv2Ol7yxkI/D49X3LecI1Hvv8YGV7Lhk8v4PplxxxgUlSpeyxgsRTxu3ZmdgFF7zrnJwkB1r1tiz7KTbyTN9bFiZ8BJibtfeQsEgdzP5J+AZX7rCg/BNNKF4y2ymH6uA8KihDQcLVvhww2neu7+Wv1cak6P6Wn/WRC8TdlUS6UDohdgwTqV6l2Jq+qDWNzuB2URfWEDNFBqJSCEGy61FJB8VI2AZcewkS7p75/MUVlCbcKLE4VCHRndtO6C4lwjhqM+uPMhDfflx5rvUt7lzXcA6e8Zssbz1Yo3VrRxE0R1lJwsv8ZMVVgDPykyM886+RB3GZxp+jw4kYCtFMoHBDj8ZGSCEacK11TTzE5Qy/QOk2gsg/etx1b8MsFAk1R65tNQ/rfekWPuYI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YnnrIjwg/Y4SqtlaRFhtCHK2OSSNMxLNek/202BrASHrep+LRdlL9iRKRjdbXp7TUmYkBq9N+dkbLY8alumZgFgOciDkxES5axUIoH10x+uPxqI1UJ62b+OHM9oLRXUggqprS1q7T7816/wi+79VFqLqhzqrYb47v9BjRwIH4a8DeGTEMcWSAbz4mxEt4Z9mMEEVsfjg5/Qd5pVnZ76O+y41IrYgZ5cpLgMVT/b/VW+xoP0Ur3cpO4/SLavajHCNNNC/vGJtIzPZtABhBkswC5OXtOuZ/atHowJO0LythwqYSzZRRla71LmhMCJFBeDtp0CBbEW3kPFWr8SqAcjscbixp8V+2KIb0GGf02lCBDW7uUMTsuir3TV5/e/BKo5BMb4DmaxkDyDPygyi6nfcV4dJrUn3IOngnFAYz+A3J2jOL6+oexdcbAhv8s79e6dY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:08:39.6625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54670be7-24a7-4260-d7cd-08deab78f928
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6117
X-Rspamd-Queue-Id: A0FC14DC57D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[ti.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244395-lists,stable=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.879];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-3-s-vadapalli@ti.com/
No changes since v1.

 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 793538f94942..a85d7d08bd1b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -439,12 +439,21 @@ &sdhci1 {
 	status = "okay";
 };
 
+&serdes_wiz0 {
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
+};
+
 &serdes0 {
 	serdes0_pcie_usb_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 1>;
 	};
 };
-- 
2.51.1


