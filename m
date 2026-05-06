Return-Path: <stable+bounces-244401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBvzCIdP+2mSZQMAu9opvQ
	(envelope-from <stable+bounces-244401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:26:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8714DC1FA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA6A310D133
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BEA481644;
	Wed,  6 May 2026 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RsLvsWcx"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32F481A96;
	Wed,  6 May 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076564; cv=fail; b=m8j1kWfXD8XJeyLoqtfFae/4QxHvUBtcoRBqKSi1f96PV0qa/RG2vD3mPyrfGyTd0RzwjmjvrNqU9n8ToH3jxVC5N6KQuTmvtYHvwShEq6gdgjPSYS1eDl8IQi+seIyyf9vCt7cKdWBttDFNt0sbWnC09P7M+gLzGLo1F6kg9QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076564; c=relaxed/simple;
	bh=JNtJim+RSSPRcTnHtYhS9VXBHQ5O+qtD33zsZCu2NFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgWo0o5/AoQYXKLvPepz7KOqAtvbM/hY47gbPgp1ic7Z/ICdivt4iNwPV/qrLYYJE0KMF+2EDnckcPMEB4wY01v6gtASfo3RuPYLvtv60HdBd1s9wSX035Q7PP9+k+6u8jJNUwLDgrfVEXPJLvCHrk+8wrl3WqjU01hsXHg68s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RsLvsWcx; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L66W2xGDznf7N17IB0FrcPe4x4GXmnTubvOpeTQXA7ddAyKnSQankF2M3Z0crMvY1gfRVoPSos+rKd0odAQv9dGTRCrSPKXgFwi9F5DM83zOGgela1FuyXs32Th619Tk97RXeKDF7fXMChyGtCUi5e4XH7wW5gBn+cwdA1oCMjNQ0t5VdP+Tg5+bsBazCFF9icuTxk0AqvzUwix3td8R3tuESGHaTWwE8YFNgqFdKryBMByGEZIxYexjBD0SLz0T0h3+jb2caczbXHie0+iDXjeTQL6B2xxAqR25Mqp6PdhXmzu4uoMcpaAi6JG4HqA7uI8ab4xtIC3Z0EywVpUtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWozuSNoBYNGqYNb7nuN60SO2/wcA30byhgF1MhZWIE=;
 b=igvwLmAYEOa+/CrSTJJ41GK+Y87rrVQfF6CCAihyFUKRogG5e0cyKfIeyNpvi40MvXayFLobHU8cpHL1ySxqnFq05S5njR803g8fACLJbrEf1+7+yyIa0C2yLDzqolWYmDRxE3/q97Qug9A75mPo4RiIoGjHUcPHZAoA7TasJWgRGdBmIfMO8fw6lANUmA1/wEG0TbCqudes89fjqNIdhaEtUj+dkMI56RIhHi7VEu9uqZ0bMMSKomP6xY/er+cGzQyEDQPzmnSYoqMfnrtPaCF+qE6gi+1JRAtYp6gKg9JaMBPU7mJhZy8MPxQHirVzm/rEPBdKXKP7FbJ2/Wj0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWozuSNoBYNGqYNb7nuN60SO2/wcA30byhgF1MhZWIE=;
 b=RsLvsWcxCPysQpCd371MSIQIUknK5dk6VjBtUYOehfUiLNlZ3LsCzLMrcVBBE9LBkSgLtrA9IRWR/+sBeGzrkn+b/UjUSCHZoSwwj+5376DM0BBU9lhvSBptautr1as3yykYcvrMWyHchu9T/bCI8xXtWEgBR7jEWw1wWRQjdF8=
Received: from MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26)
 by IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:09:20 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::2c) by MN2PR15CA0013.outlook.office365.com
 (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:20 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:19 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:09:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:09:19 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWt1221395;
	Wed, 6 May 2026 09:09:13 -0500
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
Subject: [PATCH v2 08/13] arm64: dts: ti: k3-am69-sk: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:40 +0530
Message-ID: <20260506141040.1368918-9-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA0PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ea6063-0e51-4312-e73f-08deab791154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SZ5FU25dUV98uWVsNreCUjjeEaIak0jFgm9yFaMUZ2J9sclaXGWB4dvEeWk20iXK0thA1KytLriVwW+dXqU9DPRMOmQ0bEPyBxI/KkHbtibpT+WgH3yiCXCbGrSiT3H0pPeOyCjlmjW+wNLSAzZ1EkYJ7TPb/RYK2mtwCUlj404jwXv2FLmt5Y3xav7r9WAAaayOVhCgLG+fkOt4gCUmvztF2beV3BOFE/ZTEaFVhQoRLKxfBn8OayoiM1EPpLpqgWqJuzE51AgNLSzqWVTEdv6LT8ZjtN3pPimRDu4u/u8lw8VEVJZ/+psKzVfQ55/TlK+pjjyhh/CRTUqv08N3aAh56s2PgeSTruW5XGdU6JVRvppIcGWN82doCxRxHcv/QPLH6dX5YQAfL4QpfhTN34PP3nbLbEdavZbHlGmePdqMQWh42H2TFh+7NEZ+0nQFOvszjPUoyxn+WHesXVBk7o0dPwz2Y7kZKxbl7McgNrcFri/8xfdTEsDX65auIzawRCMNTHByVdt32V3fG0RMUKLCdzrD5Yt+fx2sa7BZI3QOikAzfEX30fFAaRqfU5Z+Z0oZlN9K/tuuqsww4Xhut9OHRCOuH6Q3xrUOMSOIFxnWvR19k5+q0w0vjAyPKtwDD5Y8nvoNYDmWEEf4NamL/56v2eUge4t+DwlU0oUJWreRdPVDPg9qwcUuvob+MND1zOkF5lXdaSQvB6+rXmZwcIkm0JlhK0FTcj/oUb/xJcwa+LZGp52vl4fGAx4WLqxrjJ4X9AYBu48ZHnWMdj6/bSaCrIv9mfGmy+b+KHrKAiE=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HURvuSvQOsCLkceOdAmSV7cxLjaptnV1Q2EUnvS1TBNpT6q68USPET4I6i3LTTIZx/xtvu6nAzedHaxkO2dfCHCw/Zck/71MeyPmPMeKkUAAkwvIMYNj9UrVZEFsr9o7dO4BGtOUl2wiKRJVPYmiwcY51lbIwOGiuMJF2RYLVSsv2qqJukvDEh+cMt7hqjtGRJX7CqwDSoTyDkq2jimLn1CaB9bMpjn3wGAM8siS/KVncYXulq+Q0InIguGDCnVmjRauQHdRGajxjYoEYs7sWDlReAui2sd6E9LM1Rc8+mKVma6taSo5kdKTIVNPSeKnfX9TYK5DX75v2V6O/ZIE0/mODp8Uo8b/hc5n1ftflDR27MvH85eCjhTmcaA5AouVzixo2scmSx21unyLJzGKtg2uiQDMfJqO7puY9ZSfQC/O6aDIvAkxeYcGIMeWXFli
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:20.2073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ea6063-0e51-4312-e73f-08deab791154
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
X-Rspamd-Queue-Id: 2B8714DC1FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244401-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	DBL_PROHIBIT(0.00)[0.0.0.3:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: ff7b5e93f16a ("arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-9-s-vadapalli@ti.com/
Changes since v1:
- Reordered properties in serdes_wiz0 node to place status at the end.

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index e56772a334c5..afd809104d1b 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -970,6 +970,11 @@ &serdes_ln_ctrl {
 };
 
 &serdes_wiz0 {
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 	status = "okay";
 };
 
@@ -997,6 +1002,7 @@ serdes0_usb_link: phy@3 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 4>;
 	};
 };
-- 
2.51.1


