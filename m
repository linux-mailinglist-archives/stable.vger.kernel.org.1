Return-Path: <stable+bounces-244096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAGjK13Z+WnNEgMAu9opvQ
	(envelope-from <stable+bounces-244096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:49:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4374CCFB2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05C38301D31A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D49B38734A;
	Tue,  5 May 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="czUPouJA"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EA31A7E4;
	Tue,  5 May 2026 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979083; cv=fail; b=KggbrMVpBrfCnKvRTtbAReRbZk1IKKqtTbYNAFXOmBRRil2LBZK/nST0t3dwgeF36VtoUdMhjcnxKOg/70kVPKgP4mN1G/mN88Pat+jnzVH6c4yyGZc2N9LV+q85M58ibIJBTdqU1kM3y/68yxWxGyl638lVmK+xohDpPuBIufU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979083; c=relaxed/simple;
	bh=7otgU/TOstItww9FjPbardiWO3b/ukb21TEdy9XBkIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ln3BdhYVS9/TP6R9Z08zSn7epvoXjzmSHjbcTGeBqgdMi1TYydux5eF9PNRw6dtRNWsvVox8LCHBPhqVxBa6I8svkQ0mp7PG0HTR48tZ4tVPzX/1FNAhFOvE9/g4NZBGqqBQT1svsPlHHN38iUKRVZ+zFFp6O4jYkcLzwI/jV+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=czUPouJA; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x88WdsxGb8NMs/iJAXLGotNT0hr042MRyU4JEaFEjFv0CGXSQlIZjtO8aPE3vlD1yvV15yXeLnAr6gZhlz8z65gUNz+VgI3Y2nifrBA4b2CIDrzUoLiQBD7R0EipGWumD/VCB3yIXa6+ANunGaOzc7+UOSKfCkDJnnhwt4usdPKYQCE5Fcqj8l3FQjzZEfGz5HE2xWuev9KzR5cVFTd5SjVFGEaffEG/LukvdD2c70HPtSa53dYXDZLHH1S5wTL35wx5S6qSQKgyGW6swDLSWhCcMH5wszfnTAs2n9p9c4UuXp9GJbIhFiZ/9Hwyg1Emq67C9uBFOohUcZsaDR8Pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qziiPtUUrqH/0snOYOthfwzUGOBEGicaHa4w1UpRjsc=;
 b=Hd00QvUBj+0tlq2dY/mph7hoGnUCxCymR7BCeB0NvS9Uev5tmL4Qcdie4UBhSZ0D1lG6d/x5Flnmb0ZcYxyIjpOs0gJhi/D+wTRijhJiPg5R7czKIYTYzgDVeKVyQUerSv9j/+WmWbZn4Aq01Ffq0wKXqUo2su2FktcAa9fv/bB+6ztj7htuzFIplwgtl7CAbB6QUzvbr7r/d3EFhCqI4NCMq0HjbsxkajahspBGBC8wUIjtjaA8DTR/vuFoNavoSGwL8XgFDudSKKE78+YxrMSTxoB6wv292waEa4ux6JP3casMgDdM0mG/L8eHLfthoFz5NjoXFl02xAdyubpaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qziiPtUUrqH/0snOYOthfwzUGOBEGicaHa4w1UpRjsc=;
 b=czUPouJAn31XLRNcceoy6bjkOdh0GrOJNpg9vOubv/T3pIj8rbCexFIRauuBDUVPiZretdczVyHgm+bjmJaXUKCV3qCilVyCanGSsbwdLR06Cx2KAAkG0tv966/91CVb2aWlRBzJJWMZpPLWbiTKTG4ZQXR549wEHXbF7g1HJqQ=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by IA4PR10MB8541.namprd10.prod.outlook.com (2603:10b6:208:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:04:39 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::f9) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 11:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:04:38 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:37 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:04:36 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h22831834;
	Tue, 5 May 2026 06:04:30 -0500
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
Subject: [PATCH 03/13] arm64: dts: ti: k3-am642-sk: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:04 +0530
Message-ID: <20260505110631.1144200-4-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 40723dd6-e48d-4c73-7100-08deaa961999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UIPvPzoe+bLrxW9LDn4wslmaFH617DsYFj/TSgdRWT3HGWptDNIGI2O9VyR+pr2LeDbXVPSlWmT42rqQ/lnHySppcAAT8XE1P36c2q5K+hgbvS/bS0ymWOXjdvvbAf4/LxAcqYQYwYHZrM51PXQm2yLybXxt2gePHKBKdSIhudaZdXMsn5nlmY7CdSX+71oiKQvSRokl2O4VHEOP9pf5GYhK8pk8Z/HJsSqLLGmb5QZNl0NKFu+B+Y6V9+2q/oVQXJGOKy53wMrKu+fem9j6USUFTU8vLxpLh1xKghGje+IhDEjZ4nY+/wQJVoRhA6APkWIFmNd8+ZqXqC0SR+2YZXMMdTIPSv4amGbPzFT0iKR0tIWvDOQ/Q9V/ZdbLhEAHrQkYD4ivhnMq7n9vSbUKCEY3PFA47KWcw1wdBb63c806goEGBax6Ooge5CBV4TFSWeGSQ24iXVm0NFWbu1wte4KNgQlSGvkWRDRFW8IbZnbAjbmzVcHiE3YYEezVsB1wEplSj9zuxScbAo/CpsHwo3/YwAf9IiY/QJmmwvVLAxW5Al+lhJO/Up7JiFa0RhGesHjTPkzxCtyBkfx3Ax9Ar7sN0BbCMTH2b+n8O/X5MsC/xYeqiGxpbTs+LYf3TWURbM5EO3ZIdYJi9OEXGbW3fWUQb5A3IZUbOVQgM9y5k+X0fgMVFVYifgKm6wwtSbqqbfsVTKqF0Sk/SjOiCAMAFHuKjAA6K0yk3A76k9VdVJioLbLUv4FUnFO9zoIUJCbuSZlKn5N81lDdvN0XTRvTwg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7GY3VsKiVkTr1KhvJ1TOc+1jHQI45CS+8k/WtHiAqV3sbyjMyKIT0eKu55hvVotRV7oH79YzZ9eom/blfOHujDiY68NOCiLjSzH57ZkEDNmsvlJkqwdQ8HSSLKsXnF9v9fWASu9FVwvTMiUv6DB+wSulKFe9m66vx51AXo7EefCEgZDfcpdH3jl0lLZj75g4/hR0G72wSxS2kMwuB4b/huo6HB+d4m5jCG5xudlpOSmxzWWQ5XZnOgoBe+fIIkNfYYzbV8YnX3VwXsVvoZDMWlOf2HX6UYVbxT57NviWiGDNePs7HZVfIA4mAU63PGa86ATWvw41hzBrctyQhwK/IIT0yEcr7suUfCoXr1Ba9RoFVJcbECIV+r7RF91zDVaYHg3A1uTyxm4Q7wG+YzlRu9GaNljcL22tlj7YdpFwORlRd82OMRgTLDjeDbfVC0O5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:04:38.3158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40723dd6-e48d-4c73-7100-08deaa961999
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8541
X-Rspamd-Queue-Id: 9B4374CCFB2
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
	TAGGED_FROM(0.00)[bounces-244096-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.927];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

From: Luis Parga <luis.parga@ti.com>

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 4e8aa4e3559a ("arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luis Parga <luis.parga@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index d28a38c87f32..9f63fea5e6a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -463,6 +463,11 @@ &serdes_refclk {
 
 &serdes_wiz0 {
 	bootph-all;
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes0 {
@@ -473,6 +478,7 @@ serdes0_usb_link: phy@0 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 1>;
 	};
 };
-- 
2.51.1


