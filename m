Return-Path: <stable+bounces-244397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH70CdlV+2n+ZQMAu9opvQ
	(envelope-from <stable+bounces-244397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AD4DCA6E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95183306AF3F
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9547F2E4;
	Wed,  6 May 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hn1LNGVy"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1055480965;
	Wed,  6 May 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076541; cv=fail; b=q9RIQxIheBNLJ08d8tEDyEZwQG9qYdP4rA27k0ZJJBd/KZ/FggD/mZi+M0fSiVtKfkS9ZMmXgMNhc7pl2ueoxVDyLrYmAMtpqu8lAMT6h+szstL7EZuWY39r76aDZK/D9lj6nCupQQpIMOgZxdVhf2k4/tASkSQBTCS8kj8333g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076541; c=relaxed/simple;
	bh=tDYkJsS7Abx1vX/zzAVN1HmoMqDRVFpwDU9kvRZTsj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJeWcADuy3/lnvmzOa4jLkEPlHEAGqH1cyiuczqR9hWEBe8u4sKGOiuXbEccgPPkdT98HpQJI9+uyPZj3ZFaUBMO54byh3x3dUqPrs/Sccz/yRziW+WXgrE0y4hnhbmhRPxSx4KbvlEZEYrZ+Bl0xicpEEM6AigHLYDNUF4jv0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hn1LNGVy; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc79Li9n5BYiVifzTb5CENkIIGJD8Y+uiGWRaifBWSwTVU0xQtzKiJvKU2oD5E0+TgK018jjFfKGOI4wh8RPG9K8wCD+yWZOMWw67cP7p3QYdVb5nr1OYUqanR8QnY8q9kbB/oYBTl+77OPnyG3+OgvweQ/9MdvrhgsI5NC2o5dFehQ2OV6jTixrv1OwLPk7pPHLHM5zGOvu6ViLGXk1gQOVRjb/7BM8rSD2g+cDdEvk8l0lGkFQKQoI2g0Fa18lZrm+gfPITopIw1Rj9SXxboSp3t0R2XD6GdgmGHMNqBynQRZhpIdLBIR+uV3ORDIlotq1WQJg/0cAfyaPD/+nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sABG+lKtAHUTO5Cqxkxq6R2TEVtprUt9atrmsVTwQpY=;
 b=BeRdrewuuwzWb24EC+q97Q67CfuGXEKZoTi42Vd6a5Si9pzt+anZtCzEfCIUBQ8D+Sa5xGx9xsVsjP1n9Nq0s0dM+3jCS2w4O5cIUzAMUbiL3qyfEpCUNtZphPlyRjaYoL8gg2aUTbg79wcb8b9OVA+ALvebvz/0tWoja6h+FYS9QeYvqlWiuCqGZCcJ8r53QQ5WBsM9LuAY2ulEI3aQqJZny8ctsc8U1WYrgwPjHmXVIEbl0qeVhAMQloaqWc7/YeBMVh8B/SsrmCY5rww12txpOurZ3l98TGpwGMXO2CtDFoAUB3nPkNYUyeeLOFVvR/YRmeNh3UeZwzLcBA1W9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sABG+lKtAHUTO5Cqxkxq6R2TEVtprUt9atrmsVTwQpY=;
 b=hn1LNGVyArmtE71dwRlJRY74xS6sXSp8XoukKpBOKlrnj4W4eXvhV/HIiCVxf8UMPv1l1iD+RMD2pzrqEjfd/RH7lmFfUcLQmr7kAVCEXjnt4YeK9y2JuBIvOgNJUAulc3GBEQQyxgi7xPaGnxOtKkomx0BBQ1vPcw04L8VBueI=
Received: from MN2PR15CA0033.namprd15.prod.outlook.com (2603:10b6:208:1b4::46)
 by DS0PR10MB8127.namprd10.prod.outlook.com (2603:10b6:8:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:08:54 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::94) by MN2PR15CA0033.outlook.office365.com
 (2603:10b6:208:1b4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 14:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:08:54 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:52 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 09:08:52 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWp1221395;
	Wed, 6 May 2026 09:08:45 -0500
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
Subject: [PATCH v2 04/13] arm64: dts: ti: k3-am642-tqma64xxl: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:36 +0530
Message-ID: <20260506141040.1368918-5-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR10MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b5cfaf-aa41-4234-48c5-08deab7901fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	KoAuZjruF4r1QqylJvQjzXg9mFVRYWCZraYVg2vv8G2iHPJ6akXM9lkU8rRolq/cJjDh7RucZP/4Xl0rT0B4iBd7NMJp7vlS07QTqkmhPrEUHuRo6UKfjMK2bAHMuX8xw7+SaF5nWe06+22MQbLZ5ln2xjJD3I9u5rLBMReML04ZmrYdQT3MoqVzd0wsT5+WRJkJluBC6Rl8MGGH9FhFWU4HzJ3FdcnL2/Iitb+gcPo7U7quK/Ai5yRO2V5QiCaA3aeZEF1zN/2aOAESgVglzN++OYR7OjiGM6Q21B/AWX8FmQ3ufMOZfJIlHF0cZD2vZXRaaWX6/Ckb0+rPZVt+wfelvtPt6oUGySH3bel5mlpkKd0PEc9kC3DtqeNUafVjc44DdwqwqzOrt2gReOPf48IlNopfagLYyk7Xd6pY2/FQwBMIoKWbS11ps3nx2eaj6s9uED3+da2qFLpaKY9B+kZgsYMTeO7FcCN+5HPQnkpl3YsGrE3HhzmcxB7A8TWF6/bYWDbDhSYRUO4WWbMNUQDfdJ62GMdKL2kHh+9TuaoIyS4+DxRBUIQMETmjdte8J1wJepc0dPA2//Mu+oRn5HK0Ct19N8bUBdgLZDaSjirEDJoeRri9qPrIbI/btYIEiK7F3BaaOtQqeq5bO18/WkudtQbR92HLQYIe51zxIvT7YWHdGIdxyudnetwJ7756bK+X7ubz4ez41Ef2dxpZenURBAGRX9CIerxsDM1VWKXprMjbKumGqiD8OLFaRpso2hpVoboVNBe5TESzbCQpqlXA+auruBqeTP07UznT2f8=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rcvk3uNYPIblNrIQm4qKtvB1hG2P4+tu19z4LLVlFViPx51SoqueS5eCvJ+34rSmqDsOMp1dhmVtlWzPPXt26O6cdpKEXZz/bF3nX9MrUaqOOPMvH8KFhj/gQf94FISIKCSA176UbWFEbUpboWmumQttdnpN0TKPPZVjSUR/1wlw0i4JO/jG1PcCTqUtnw39SYNxcgotxP2CviCePMkpd+aMlN0QM+u3nU8zp3IZNgNUr4U+OVFK+S3hhv4n4+ygwoLnyi/cKIjjUifKsH0JL2i5WiWV3JOI91EIqANGlUsdtqBq8LFlh4/LsLIpL3fDdbCGAD/lk/Jife44bCbo1Q+q9kGEMfjnss3qtnp8Z6BEWoSh6GENlONHWriSJ4pjd9/U8scZSoiQMzWqoyHq+V1/C2v3HNjD64V3BiGylNpygAYbyKL2DJxxfYpr9DXx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:08:54.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b5cfaf-aa41-4234-48c5-08deab7901fe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8127
X-Rspamd-Queue-Id: 564AD4DCA6E
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
	TAGGED_FROM(0.00)[bounces-244397-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.886];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 4717a36f31ec ("arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier board Device Trees")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-5-s-vadapalli@ti.com/
No changes since v1.

 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 46be6824dd16..e5d1b2ebf2c8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -504,6 +504,14 @@ &serdes_refclk {
 	bootph-all;
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
 	serdes0_usb_link: phy@0 {
 		reg = <0>;
@@ -512,6 +520,7 @@ serdes0_usb_link: phy@0 {
 		bootph-all;
 		cdns,num-lanes = <1>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 	};
 };
 
-- 
2.51.1


