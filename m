Return-Path: <stable+bounces-244098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EmeGVHV+Wk1EgMAu9opvQ
	(envelope-from <stable+bounces-244098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:32:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4674CCB28
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684C8317E1D6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30E38656E;
	Tue,  5 May 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZEQJRip5"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8E31A7E4;
	Tue,  5 May 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979099; cv=fail; b=KKJmuQACO+HGogQTcnXL2NC7dreiTmeAurYHlHKUAUtSdiE1M6Wk5rXxQJ8fb57oT77hjRcjtCtmC1KuGrdWasi9xzxOwMkgAAwFMZtoL6zHaFxIgyI1SPadYgVsvfZ2ZTJJxT70He3WQDr/otnQKj2U318YrPM/Fn1ks9pI98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979099; c=relaxed/simple;
	bh=78i8czuvsJZb7IG3bQ2gPCL/WDM0XvbXaPnam/entdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6x5sqYXX5CPNDUkF0tvkanpIfM2jZOS8K3QxJaM+GxRUULEr2kAtpStOb0fwIMcPqg1ceewC8QKH4htuV48x/RlWnD7II1MbZGaJh1LZubC3OPbN3MfV3ojme8xsV8k0bgtmAK5CuP9+kqAFrJ+wnyUQoQyduTQqye/ySgT1XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZEQJRip5; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPU52cFaqGsPco+BhQH4Y09iLldeH+IWSqJqpZG+cP2ND/KtPxhZh9MWSnfmxx/viqlrGLSuBwgjKKnEflHnPuNOS5mCnN91mdo1yXL4PwSMrpPJZlM+srwFm7w2+9pJ7FylSSGTkGLxkSiLODCFr8fa84oIcuRBZCEHnSwa1Wk1cah7K17EPt7AqkrAYj7V9jCoUjcMjpAn0pUY4jv7utgPW5rv92e42qPwt628dCfkolO1toboUE8wPwv+Y9sqnGlKNEtyKlUpeZhQCSPp53+y151rZg/ydeIDJudakeemZEyrUZm6HlnD4qQ++IlQu/57ny7aSKJ/JfYhvV7k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKtAUMp8I4InAjO6BNf7Pxp+hYj1wnC9eytEYfo3tps=;
 b=GUjjC7ryNrVYaW0P29E4nu5XwMqlacSzKTuWFb76aDfM+7w4zooFOUfL1fgr8LVPn+xJV0RT2duAC4i6s4o08VdCl0600cRDWCmJfyKuU/40t675M4utfyyBR+ERTbRw7+9ENM+jWzNJsj2EbPuBsICyBh2y/q3rwYffV4jiq6452J8CO81HIw23R6itBENumbAYrM5RLPgv0sRJaKpxvosWx4dPrwoOpyMpIpIqaTL22erhrGrQbAsaPt+JDub1+ARmX/6T+g1YB2zCMZ6STdDzvMYgkbWwoyGhglld5nqjWdrjslIvrD/VA2JFie9cuz7QVubtWRhBaU5EQqA+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKtAUMp8I4InAjO6BNf7Pxp+hYj1wnC9eytEYfo3tps=;
 b=ZEQJRip5rV7V1cJ9zgkr1ztNWE9d9TCOlNFNq/nXaSE4LYfkOm/xUEapHfo1qO1oibNaMoNotxcc8wvDr63lwdE8WhSwiCtAF85mDx5x151YUwpjIicv+iiAsvs7nHL9eQqYD3LI5vOyJKp7T+RmDiME+LNsiNSKIm2Jcc9b5Nk=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 5 May
 2026 11:04:53 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::f1) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:04:51 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:50 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:04:50 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h42831834;
	Tue, 5 May 2026 06:04:44 -0500
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
Subject: [PATCH 05/13] arm64: dts: ti: k3-am68-phyboard-izar: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:06 +0530
Message-ID: <20260505110631.1144200-6-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaf4462-cc93-41ab-f9c5-08deaa96215b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ub2irB/gUzK3deQJQJ4dUDjAr6AvYgWCUu4+zKLa121HAtx/HLvykhVCXgjBroqVbQhaxwduAA448NSINibAflZ0hYf7A9V9kUqnBnay4FZOca9FSd8Z5CQ70UE9Awd/rQ/FsvQcnlWqbEDs+j0jGVi8Cd7GXXDhFN3ZvE5RBHH1SRJd0KB33133T3vrG2Zu2SLDJ++UBYshjXPus519p2xKPgamu0bqPavaq5YZ3Rm551+BMvfNcKNbYD2z0dU1YsQqksggw0LeIqbJJHMf/uq3Nj3aUIhnt5KmJDNHWRRrPXFI4AbqyH3NyaWBbU4c1d8HA7I5/YbH0BSb9mQ2gyhZLiEDN95J0f7ct6Hesp9M2A9CRvLHF5/rcBpVuAlWBVH4O5RG+z1//oTHE7ZfJjlQOI0gzFMXglE7IaScowXouN2wRXb9cXmvOfpGDdJyVlw8+6A81EQFyNlMfonMuxtKIlzqpbMWrO5zdsIyCfULQPLtL3aIX6U4bD86kiJsrUpGyO17em6oUamCpWIZrNckm/4Bxn+magAnbpNUrjblLYg4/t91+gH7MOMeIIbtxMBCCXKu7ZLqOSc7R+zLWthyZ1zOEJf0NQ4AMD6OAm7Jw+4thjezVJ/okm74TRw+pfXbosYHbAZlZWUpxA8B/CIVaqvP2InGbLQMzMEbu6iQ2riMttyTxVFbQOLTDZM25yY/DN67laMm/5GPDCduubSd1KeDjSaKuIL8JA34P4sBAqth0gqfsvJjop/NlpQccJps1EICqSJzcIkMyzc2rg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lyENaAjX+XT3lVJysnig4WFCDfZYJlt59w5YhYh7jHwRNYVIwphHqBVt32f7uIpVJjKIyKqK/JziE2G+7QtHc+f32oEJmC3eQhq9k2PQ7GzMB1kgHII2NFasURqkj8jDnaV4fPeuFNPKdWTxcM+r4hVW/CsQCh85PKHsA2VVWNQA0fSzfSNHEgW136Uh6FAbv/ZVBHyh6vJhgwpkp6oIM33ietzRP+Q0DBcSSH48kHNBdD2fw/dkRnHBsXMbmSicBEMMgi3+tGlHTZet3hOFnDFJ11TIfZu75F41n5Q/JKIjffcTo1yDsl/KthHXwjrY6EQcr8CESSumQ/mtnXP4MIie1rZPh2nbPdqkemcO5xNn0hWHOhpbGR4YDzR1QbvzJnb7tIyRwNxX2B6mYhKc+QVosZumsXpsCxto+HozNuWnk7ZBG0woWYJTstQ8jcOe
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:04:51.3333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf4462-cc93-41ab-f9c5-08deaa96215b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Rspamd-Queue-Id: BA4674CCB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244098-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.1:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 8bc3b1c86452 ("arm64: dts: ti: Add basic support for phyBOARD-Izar-AM68x")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
index 225fe7a7803b..d9b61e426ff8 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
@@ -505,6 +505,14 @@ &serdes_refclk {
 	clock-frequency = <100000000>;
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
 	status = "okay";
 
@@ -522,6 +530,7 @@ serdes0_usb_link: phy@1 {
 		#phy-cells = <0>;
 		resets = <&serdes_wiz0 2>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 	};
 };
 
-- 
2.51.1


