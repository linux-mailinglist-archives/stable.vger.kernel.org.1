Return-Path: <stable+bounces-244102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHufAbvd+WlPEwMAu9opvQ
	(envelope-from <stable+bounces-244102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6C4CD3A1
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2967330B55D5
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A142B72E;
	Tue,  5 May 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hyK5tr9b"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92619382F17;
	Tue,  5 May 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979125; cv=fail; b=SSdYnz8mXbsP9EnmNrEuYlgGPWiCdiIwf2Ixz8LXmodbS+oUXpzlmripFXUIQfXoRA7dTb7Sep7sjqThp2uutVo+jL3Dw9R+EhcmNMgsQm6ABPRejJCEqsiOHFjRRJGqkt8WHWG5cvft40ZJok52us+DcU1/aJ6d007KAkNkeZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979125; c=relaxed/simple;
	bh=qURNuEsMz3hewPYCsslBAFgS24KuaXLAmh3JH5tswQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2V6pqNLR8IGbFkVPBQBAegzthWtyhs4SAMckI7kq4abtcDTFffhIy4m9o5NztX8e4qOm/WKQ8NTmOXUYV71lBoVcS7yJrK0yAetLLGy/V9h8FXPiWOAm7nr6MGLAM1njar3I8sLL1CDQxUGRPd/eQp2FWpDjhcs+ngbS+0tESA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hyK5tr9b; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQf+R9WzFmWKbE991qgLvUw9biM3IqT9KWald2uWjStZX+l2UO3d0mHFPFolxEnVzRQoeSRpaNbhcyaWd522mbvTlxV7rBDSOP7OfJPMRQioSeIkbWtqRuEbUiPvElj1an8m6iJP5PfkmX7LR3QJif+BsNcg7eyAbp4OIWfwBaG2E5oIPH6xdIbDF9EHfen4hCGbfHMH+iEPWspE5F88I6xdZSt3qiGyT+Lm//th2Jgrk1kdYi6RGftzGq5+PCZCrx7A+DhVE7ecKet307CKxu2DQlgBJV1uWMgnTjHz3lKw8DH798QPT6vX8wJ90hBhm0L8uq1rW8aDARU/ps0ACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD5N0btH1cf6wfiHbxvxG5xUT8OpVUAUfde85QkRyV0=;
 b=fw27ZEQQcDOA0kOWLjzhjEfvyBzSOafoY1szgIDDICnIuhYbWLPRGuAqHwlkCUUx5aA/s3EUwMKuewLDF+/FU5HTOZoVej49tf3tL6vYNpL820XM7ehYqreRqtsYChxAN2aGoZZL6UPCgi6UnEPoGT+e+D9zCeNHgDv+ODmU+5qPqmAN5+eQ9y2xUe0vza/xcri+BG9m1fnXMoDu8ylKMBgRZueQF0s/IoDHhMEIM8p46NhF6PxKosS5PFvVYKPPzHUpGUP3tZUElhbblxfs3ZQjl1aGNSMsw51zPZ2j/xGYyjRoPqorJxjSnnwZJMkuxeNUXJEzhTqHntmV8HYQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD5N0btH1cf6wfiHbxvxG5xUT8OpVUAUfde85QkRyV0=;
 b=hyK5tr9bMyszrqf7rAyd8IFAls0Y/m8ATseobHMAzqHwoSiD6pNHzWxbfbBcDO6mYLjJIueigOpUdZdTTumse3Cd/QKhpnbxRKaf3zv4Kzj788WdDlcqpN3xpLRYnkJ2ED30hCBo1WFpCgnSf5Mq5MqMbdd46W9MoYPIwTjra3U=
Received: from DS7PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:3b8::17)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:05:20 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::39) by DS7PR03CA0012.outlook.office365.com
 (2603:10b6:5:3b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:18 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:18 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:17 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h82831834;
	Tue, 5 May 2026 06:05:11 -0500
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
Subject: [PATCH 09/13] arm64: dts: ti: k3-j721e-beagleboneai64: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:10 +0530
Message-ID: <20260505110631.1144200-10-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260505110631.1144200-1-s-vadapalli@ti.com>
References: <20260505110631.1144200-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 74286c15-6a4d-4101-16ef-08deaa9631a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8bsCOnlMqrlTVrIgZpZT5/9TGPkm8LwrAxte9k1SdIpatuxAIoYJWNPyg9cCc9me/paMs4gaDb6UwXhNjZ76ga3Upv6R6DGLADzPP+OLtZpjsnm2MJZRxHR95etC7g6Wnf54zabjGMicQswek9ILtc4Z5L+5ECVRfxV5ZrUn6zE4TLQ8lqsRQdvQXcBZ+EfirxbK4vw75qbV9NNep8RttnnTr9yJ2ldkQLaAD0I7OqGc+pD7sM0WCkbADWJya5xWbo5EcSLegNalu2l2alD0HxlOMKpW+ttaKsoOFv+Fb50pPNPelr19kJ1ocA282mZAnGHMYmzm69smTxZi5dsMXkWUXRbpB6P1VZX+AyEal1H+E8wx37IyR3kAs7dn+IcnhbYt5QP/ofG7NrFzGOhXKHs46b5CHnHX8sA5SnAnALlWQIqP5PqPJB305vaWyHQiLuQ9n1rXo2ouA/bJfteclG0GyJUvbSKuyKcJzpUjcan/pvtXryzMADDEt0HQta9G8g2pqEQP9xD52B451Wm/sFW+fWE3xjrCWsWXYGw3k5veDv/LvHHzIchuSPM+tDvGIyWXOMg9bU8vpWrZy4bg2Apy5gNDjGqzFqWRMqHBAu0a27edBBBWAGbWRwDTbTI6F/CSEkzBgJr4XWgr1zpjZ8pY8vOV7u7AQAouZt8WXbMp6RJ2R1C6JPEdZIvAgHOVR+StkHPkiBxhI4V+uFy8OhJxzmOnPTL8Frde2kmUzT5Gq+/Z6Ya9Q5zPlghcL/gPYvAlgJHe9La31c9wCoxvUg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tVjAfJsCDOrcXsIQfwerL7bubogZUeydOLleM+4GrxKlGyvPAGnE5RJaAkuL3kjGNEk6kWefyax1aKWP1RCUuwwA28bYIFpAQpXuEq2EpqWrXzDB3sDsHlyx0znmNIGaB58XMSg5XT8Wz6Dx2We6PhTaFkYofS+/nqDoGB1aMjp/cVJa1R/gDM0bDzSpIB34b8ChHUvKPnBwxJsQwYuWvrJlBu0M53ck5zQx2205rdkZxRPsljLTJF64IYYQ3HtRfXjpZ8KOQMhZdaFL+WDy3DfXZFI7f/3egnBm2nP9VMjwuhHiamvXunrY2khxeeysmvATaFDynrf0da1xxHx3MtQFm2EsZUshMttpOxBGIop0eVsNQWH9BelEuq/vJLLqTyl0kG1UGFtGGAiJ/dk4Ci4tcszE7S3blkgPCJXgB2ush/X0ga1CyFLsuk/XUlBx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:18.7125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74286c15-6a4d-4101-16ef-08deaa9631a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Rspamd-Queue-Id: 5BB6C4CD3A1
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
	TAGGED_FROM(0.00)[bounces-244102-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.1:email];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.927];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: fae14a1cb8dd ("arm64: dts: ti: Add k3-j721e-beagleboneai64")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 8040b6528c18..1e87c6cf146a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -578,6 +578,11 @@ &serdes_ln_ctrl {
 &serdes_wiz3 {
 	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_LOW>;
 	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes3 {
@@ -586,6 +591,7 @@ serdes3_usb_link: phy@0 {
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
 	};
 };
@@ -621,12 +627,21 @@ &usb0 {
 	phy-names = "cdns3,usb3-phy";
 };
 
+&serdes_wiz2 {
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
+};
+
 &serdes2 {
 	serdes2_usb_link: phy@1 {
 		reg = <1>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz2 2>;
 	};
 };
-- 
2.51.1


