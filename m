Return-Path: <stable+bounces-244105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDUiHIvS+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:20:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CB4CC755
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05653274B20
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702543636A;
	Tue,  5 May 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZq+Mgd3"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41B42E004;
	Tue,  5 May 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979144; cv=fail; b=Lk0bOqXgSNdgpPf2vdjWEs6WwQGwdPAF2p8pTRr6SXNWywZOoWIHEZY6D9gFG9tdERhPpRlDhFXAnnJdBoZ52+5YeIIqhCXasvmPZ0bLkCGCOH8B4gIDJLXv93ja6cVxe91SLRhWcrpqXmD2BquMs8O93KNwOii/8vK7rxk9yf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979144; c=relaxed/simple;
	bh=GT2GlkkXQ1oFBvPn9K+DWoDOs61ESAlF3VjL7xU3T3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQeMP6+TzUr1ocZX2kXB9umL8fCoV0ooTi+/XifWqvxmk8A5G1LZcXOI3s+mP/cZ5J4/HIuXLnf/WbS84MpwvhpbOrtyPJePP8kPY6NIt8fw7MDQJoRK+JixqIVB5xXTiBOT9M7NvW1NYqMiBertGWG22lVYWNccpAyzQNGqESs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KZq+Mgd3; arc=fail smtp.client-ip=52.101.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/9Ig8sbWADlCvLjSgxTBwKcEvk2DrXpozWVKazbxxQVhuhJMYzuEklhomOwdmp0ak/XJS+chcwjmyVJEN4KKK9PxP3VCJUKybLGWtw+FprmtrXNrRlgXJUMiUhAebUigDzuSYK4a5E9FO+VQtgLZNhBzVQca1uecbM5A1vtm8jAy3GQLQzn0eUo21l3FphsrC3aJQo9U2K+ZuwjY68mIGL+OQJwpRJS+fMYdDRindazHzkI/ogMqw9tIuIKeB3vPk/3VoD+VfSg36w88j1naff6tkWlb4bp0TWdKRLSqhJ2FwTAbLfMIT6CvXwVFfHGm70cGyIxw2E+gUpBsKO8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3BODtDGv3FsF80uiN15bB2JpezG/2iyNkyo5E9B01A=;
 b=pRKcV1kwJEHfFhQvYY6pBOdNxRrwl/2wBjHRuEvN6wx8ZCaJT7gdH6n37VXnqIsykxzDNYPLEHOZVUbu4HXFZOqo5kNQ5eW4t+0vytA5vtdly3jyN6DRxcqchNe3sw5wXvk5DXP8e0e3QpWpHnjRX70mfKX5X4KeM8K0yGwEc1lltXRp1zs1mxmhqVsEF7Y4nk3noRL3wBb5Q38CEdbbPAY31Wm+JATJdtcpfYjQfhyA6ACyjg/QDkGxISjqZYzS5FbR9kZ73g2Fy1rvNijmHqLE65gfJXqimSFK/OMjZQwFNv3+4OfffBrkTbZ7iuSQdmjxV+L0IsFIRcJxpT2OLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3BODtDGv3FsF80uiN15bB2JpezG/2iyNkyo5E9B01A=;
 b=KZq+Mgd3I2N80HgFO48q3AND4j/Sl6znBG3okEFJMduoRDCmt+LFyM95+iHAnzzsAvbmVB9vd/YC83Ra6ZJcCqmJmJMWMRm/9CQt7GUsDTpFDXj77fBb+tRsTX/nzUElOcfChzM8INt+wrF6mqfhemE22ht7ejh3KCh3P0Qro3I=
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by SAWPR10MB997815.namprd10.prod.outlook.com (2603:10b6:806:4e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:05:40 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::94) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:38 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:38 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:38 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49hB2831834;
	Tue, 5 May 2026 06:05:31 -0500
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
Subject: [PATCH 12/13] arm64: dts: ti: k3-j722s-evm: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:13 +0530
Message-ID: <20260505110631.1144200-13-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SAWPR10MB997815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8a427d-fec2-4209-57e2-08deaa963dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vq6VLDUu+XY2Z+zC8mVjplb5WlXRIO3w6NdkwGQTymt/DWw/iHta6+dYAEYZFgMXzicyouih21dlEiGooykiwPzgOb0A34qKq8m2BIrrb5pIKQOJsslVOGoOSRx2iiv1sM9g1wnUImoFfUNQ2s3rzNg2u4TqAlIMkqZc6Zq52yqxsk0wyb4MqmG13M+aQBA+XEeSIDLNHzxhDiXx063qOlQjtNDqJj7o+8lD6j5C+AGmyJVgszg98bZpw6VQsjAKFhfq3mK0n9eAQs8j0RnIUaz3bV62RvOzJWVuu+yVdf4kyES5Nh8QeYiY6wm69pYeag+9xlSl8vFZfHwdKIgjmljqTUaOGD8VrI2fY9E54jSXwzYEvwS/+7VlRobXfXiWWfKatiUtbCa1vdnKBUI+dnSt2i5u5/Rd16Y9Nl/eQfTwPa69EvX13miMB59vOo4CNtmT2xvbZ3i6dR8JbrfnI12dJNU54o6/uvhqXq6PIK1Y8jm2ZKBHYjcbt83etVZMTrCjkqAFKrdzckaqzlXE05SArAvEEDwcX6MbnldjQ0f9yOk8mll26fospDwsGSJ9rTZG1VtuyvSyr2pzpjpa3zlgXyvtgfK0BdVh6O+2vJ/gm7R0Gjc6+k6DT5XqtONF4QyU0xrqFhz3iwxJRztQuQhJo6hkQSftsOqoZX27YzdOUeHJ8/rLuyodj6iSn6jGR1asHRr+Gog32151Po6rRH3KtJCo3JYRb1DhAWC8fI4tNv42G9qGZ9Q+loHoTiIUSzcSKKDXbHFms+YzKwQ/bg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g6RQPuBMnla2puWnpAS3RaxZnwYa85IA45WxYhfVn8R84ZS0oNDi/O3CeYi+/ZXHHels4oPSXSa4P+etY7EDEs2BOn6NHMu+uMlM6HO8+woFEkZsSKLdTAIy+WQ1Nitb+j2Uy/3sEJtswAaJGxBczvMCT8fdnlIwtXGnbXQ0az+0y5ZkGmVJRD8eu9NLz9G8SvLbP1bEPgScXB//zPRoopWteNWtZ4dPLlnozEXDGhdVDw+As1KgNYH2G/iv51G5X5HLKujpHk3GuzYyq/SuHQn9/0Z9shL+JjdSwjL+EAJlmLfzzPirWawC//rJ4o0ed8h266uZbqYLVBIv4IkI6jKX5FAH5lMojGUIRFtaPmQ/SG1Ctwm7lh6Sbxw+s9Uc0hcymLGrY62U949dHTkZpWwO8eRSRVLaFzD17XwejaSrXxCaeceX6Lqs4Od+qfkZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:38.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8a427d-fec2-4209-57e2-08deaa963dbb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997815
X-Rspamd-Queue-Id: C61CB4CC755
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
	TAGGED_FROM(0.00)[bounces-244105-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.927];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

From: Luis Parga <luis.parga@ti.com>

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luis Parga <luis.parga@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index e66330c71593..de62b7e135c6 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -746,6 +746,11 @@ &serdes_ln_ctrl {
 
 &serdes_wiz0 {
 	status = "okay";
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes0 {
@@ -754,6 +759,7 @@ serdes0_usb_link: phy@0 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 1>;
 	};
 };
-- 
2.51.1


