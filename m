Return-Path: <stable+bounces-244402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FdgDtdN+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:19:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D944DBFA0
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E6F3110695
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EB48035B;
	Wed,  6 May 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qKh86olk"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35229480355;
	Wed,  6 May 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076576; cv=fail; b=WWsFLIq9fve82qcH9k01aA2+j7wKIfbbHALlnM0Z8EtD+u7D58oGL7XdKd6I6uYykcuci2XZqbOTf4/1P/gmUHkpJrPmU7z0PIJ5viKTsGstj2dJqVKp1wXAYVSmKZOoXbOQXXSFqA0gV/5p0VEL+gfGZeKruHwr88+lggVK7dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076576; c=relaxed/simple;
	bh=AjdbUjzSpzgtNIEICDhW3hJ6cWIOjXawYMHBwiemI/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1RaNGbxpxsBvkD3ZUR/JDrBCVrD9nJF9WWr3K/3TA/xAZ22pbTSKAcvUib7zzgAKtGLbmFcnG+nhN4ZeNExnXI2++7fea8X+zA/Ny/H0huIyQj/XWEBuxHzJ39HphBHzaR5gGdM75a53VqjfnHNwjDr5hbM05iNIHA40w/u580=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qKh86olk; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAZNt9vrzr5ELORf6Tc8aeiXc6b1uKRWswzet9DsO1P3jyY2sUEtKZXBl1EwU3LuLAV90scDF6XpSBlpA6JXaCGJid7LveOv2zszu4++858J9daZb+68qpWl2QKRIecDRQsKQEaFIpvSvO2ItT4fDpVxtTZtgCLtSsi2oBH4RJjVbJ4JJ9X5ridc+xZ8Zu7uK9eM0hCFsdrl5ZWoyNCSwlCib9xqQOhNt0vnAvhkmc3FPXmOLHkQcyXgY3RxFh52k2qDUvjElLbzUcFfZ2ShA5bl0HO+yrahkQ6DTKUR8ucnrkzYEAZVxrW3kT5Yr6JeKf3ZZI8FPwlQO+uCxYUT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wENkkocfv33Eu+N1AJY8biL8WJvvKj0EPHbFigieoFU=;
 b=ROg9wyYJ+cN6v5QrsIKGV4lmFR1f6PXBGmn3kioyjrdREzBK537zPn2rzTZfmpTNR/mMrmjPjuZOG3ZqrvMpGZcqR+n1t1TjKPaSD/EtM1HUYtCh/ZxZBvvDXxz90uY8ajx9AC+0R4IM5y3hCJZ8WQeBoeSfONubEylDvmzRubXrOKwVod7felRCJNq8bn4dTwyXayW6n5LFuaLMkbwc6Vc9VViNC6xPJa+s5RMqJNDkprPds6sneOwjaSl2MOthCVGKPr7ugzwW2HreZwLpBbtS5w5DtUbMC51jxl51sEM59vPrt8RAelfICAnaXY1PJw0/9hMUb1CXv1D/DggAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wENkkocfv33Eu+N1AJY8biL8WJvvKj0EPHbFigieoFU=;
 b=qKh86olkm40m9iJhTwS1VouvDMpKsYu82iYWYezya6Ihy2NWb6aKv4pahUMFsxfVi66jaVW5tajrLhmLVpi/F9McuLckUvuxtwqDRC0Tb9ngAuXQB8ioXgJ26z3HG/5zgabrR+LT2sMynVyDJ1taoUQnKwJwYLezQHGAbxPcBLY=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:09:30 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::60) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Wed, 6
 May 2026 14:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:28 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:26 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:09:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:09:26 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWu1221395;
	Wed, 6 May 2026 09:09:19 -0500
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
Subject: [PATCH v2 09/13] arm64: dts: ti: k3-j721e-beagleboneai64: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:41 +0530
Message-ID: <20260506141040.1368918-10-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bfce4a-b4d8-426d-8d91-08deab79160d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kW5GVq0LwdIPuZOmYAQNZGKpq7Brre907MjXv74drKID1EjMk/i3lRU39Qfh1LRh+RmSONtZPrnwajcguCC6RBiwkEnK/t4ljmVAsK3wJ9K4XsDGPbkx7RvZSLaRtIOdPALPuobmp4GRQ8oLecAM5lVeplGiKEfGdbNfTdyQIW24xHkat30BrvZyGRd0JtvsLeoPcUXTcg8ZSIVX5K/Mg0a9QkKWSwvE2VQwBQkqiwGGWTj35M6SSUf8E1cBo/BM6DSHh+yUV+SFp394L8b4nJejJm/gbctJB6iBrDdHlxwfO3Q8doMpKe4RpoMgmBhYme4tp3le6GgVlKh0UeyyD4o8HrCJAdJOcZC6GlR++yeH4g3zmf9BAWmVTDbVWoNcuJO/RkvPKxW70jHJzkVeUi1U4wI5kaMV62dGyWF00jBJ8dhmjx+H7+SapXOrjbwfVYDNtLlgETOh9L3676h3BY/l4X3jjGIw1Oi+x3fbefcXR6YQ3sRu76GKXWpjL0DSKac5wS4B2MqyFL+83rQgnZX984Duzffe80m5dP5JJaE3fxZTia3/WOW9M7MkZDKZx8jt6Q1iivXXzZZIglUsqPT9ImADPFiYWSiqnBIBhzGikW3NJzySflv8VkvHreEaNOxPddxULdhrCd4+PIphFa5TAnON3VrYFUoSijCnED8mbRS18DkYbCvNZVWa8og803NUs06LiH2RAYXebjaL00FUesyyOBiRB3D7+0beMB1jC+Yq3rNGA7/pPHhXUEjRZlxuiEn7cHHlplXv80g54M4xXnWFxV/6htFWRnQM9Uo=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YLq0iUTZn257oFfE2Qo6+MEhLIAtGXmt0Vkqj1bgBb1CvThuoQ++DV9EJoCQHxyby15lsQSNskcxx5SCs+zXiZgVZfsfpxpH1z9B2tDqRe+kgjrlB4XhFERkx1y6E2oP26P/L9MwQmF1GU+9yXys7J9umUiIsveb4gbl/+WMfHAYGBrZNsKKUVSL00LY6gmvgvVzLhonnPbU2PXxhJe4O/Bo+gkUdHlMtcLQlkFvXYuXCqPcdppd2U9HA3CWE/fomx12o2go9YdSa7c4FYjE+wZB3hNtxCClETioOPIoN0AH3g6j54oTKiKk3PYrSkl7+VL1HFRX5zHc4FzHTn1/lmcxL3KTG1Qn/aHM71qcwxrLJ6TVXjKm533cpZlvjdvrw0z3D+bILMzAW6GtOOlVWybuKUYmKB0EwUSGGb4x/gcChKIvn5zTFE6ofitKtqmJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:28.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bfce4a-b4d8-426d-8d91-08deab79160d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Rspamd-Queue-Id: 77D944DBFA0
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
	TAGGED_FROM(0.00)[bounces-244402-lists,stable=lfdr.de];
	GREYLIST(0.00)[pass,meta];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.886];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: fae14a1cb8dd ("arm64: dts: ti: Add k3-j721e-beagleboneai64")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-10-s-vadapalli@ti.com/
No changes since v1.

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


