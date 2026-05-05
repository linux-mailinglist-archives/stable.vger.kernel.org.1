Return-Path: <stable+bounces-244104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNIHC6TS+WkhEgMAu9opvQ
	(envelope-from <stable+bounces-244104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:21:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CB4CC796
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3F0B30870CF
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA847D95D;
	Tue,  5 May 2026 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FmOBOmaQ"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0342E004;
	Tue,  5 May 2026 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979137; cv=fail; b=XlUvtbLUKdLxv7daOdF4ENyb8Tud+EtsbNKAVIZ3ZIVRuYUn9+ZFx3/HbuZwO5FlttUl3TZ195Ps9rCRo2W9gTg2qlyrp5of7VV+1GEEGGCUy9sH7lZ1iOcilIU+gRNR6r8peKck/KwiHGsML7MWlNUo42zdhWicwT/lCYFBT1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979137; c=relaxed/simple;
	bh=gRtpjf+iaFdjtD7jhgp6xQ6m95eWx32aTgY6RMlrmq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSCqZD9eBtsvaMMJiZNhj04S9JMis6p0ZVG36JdMTGdcHAeZOC4/iksE4mgjBk+JGQqjrXUzJvGxMTUPrlBdnH8AWrvJ/EbfgKXhNMlYlZCLIIOYV9/i5ZMz0t335xUDMg+PmkatSIX0gwESegoeqnOywFNFXN7zARqqBzr3W3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FmOBOmaQ; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDNRKZvlRJy+oYbm+c0J6Mqy/QCUjV8Xnxm79hrbIrxtaXhzhyeRrSQUQhAACYX0Bf8kawEVrpPZqkAz5tqzkVU72zTOuYIBdIENBXu9QN6TxfmsZMGm89zp96f7JUWmscic6jlUgN4j/iLv2KfQAGByQ0xDGJ3E41OIPcpKsNl6x5ZFndX8ELOKx99J8CB4tg/6YfzqJHPJESV6rn+FcbTu8UbFMwSuxlJf+rqlgLuDkxgxUb0VZU5IfFjSUucCAJVlxgiyX2HzCcl+L/Js6mWsQphyPKc0gQbJ0iIfAQZjbk/MtoX7oBVRCOrqhQKZS97R2y8GzWh96eRGqxuXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAS/7N4fJDHODS/vx7PoqgDWoC1FJbkAr4cnk1ytWzM=;
 b=L4EqaL6waeMuhkLp8XUciFa928uD0nKlnLIzmTrJtLSidhNIkdHiieR3x7ymOYqWj94dbXOZidQTgJpDV6lqM7v2cP0pZGnbeQcoUP5M+XY0oj/feW4DOZa7v96E0LtvZVmPVaFbDvSBLw/6r2Ck4tYNgI/2IYSNH71gDHKpnWv+cJZkr9DDFlZpxE8OMHcmnDI/7ZJAu2VjUH/a7HOAgylKRz6I81/vw5D9XJdqXud0VjILtor2qD7gJBxdUxT6V+48/J9Eowmb8QnDHkWIcm/obite8YDCjsVJQVlmzqKC29V+pta96T+O5Hkf5BRjCPJUlsKsXB3Ln/unVRqTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAS/7N4fJDHODS/vx7PoqgDWoC1FJbkAr4cnk1ytWzM=;
 b=FmOBOmaQrqDjnm8cDcnxmhbEZbyTo6ni1L1/V3LfymCnrK1ai9CBvMMLS5TEvjJajECVphMqDcfCiCLzvrotsJFKn6eycP9XooRMsq2ZHuCqrjQB/zXgNedC8PqC/vS3xtseyt6NCvDAMquNAWl7Tu4axoAHy4uviL7GnIBshdE=
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:05:33 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::4e) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 11:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:32 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:31 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:31 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49hA2831834;
	Tue, 5 May 2026 06:05:25 -0500
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
Subject: [PATCH 11/13] arm64: dts: ti: k3-j721e-sk: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:12 +0530
Message-ID: <20260505110631.1144200-12-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: efe40486-d95b-4d32-e932-08deaa9639d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nIMBSsaulneiP+zpq3m/w3m0n+zP8dwqTahiBwoE3Dq2xw9SqKfTrf5joiBt73oHnJcw1ONb2Xa2K/oEgvNMmEWlD27IasNlb5Rhxns7Q3XINe2LooDridEhrbq1Y9GCsXlKXcpeLQUuvhH617NW9t13geLSw+tpjoPNOLVy4lAL7ieuBmsCZ+xQ7Um/3HHeNqmIytTgrDwdLepIjDNlxTwLokISxoryNG0pzzDXcRI+ZXC8PqmzDMcMZ0nbDKM6lQ+JKDRxdIkWiFmfk22KrslSLblzq2MBkRgl/K1vlCXEfwuqR+Piyjv130520vheMs/q0sAOfL42t6859L0LMC+6tInF78Foj1IatYsDkVmxkPxJ70OVpRlQSgNvLyBfcwa8w4qifLHLKYJUb0765W6qic/0svoQ04GcELBY6s6C+gM+V/a0+rE5vvZRwCBQioFRDhDbpusVyQ2c4R2iiTfRiktnKvkn92PQsf88WbZ34agTHAmVvUt0WuitS/efkCCkynTaosklBO4HlvCVkN1ajoFmvi5Ds+fhqBlR04wMIILk5jOwcrVQARA6lhWVdA9hVn0dnVYFYI1jHcN8ZOYBMja70FvE6fNYsDwGbT+4foTdvAAwlLHDINYNCHEF179LcV0701xhGPxeO07DunmHCE8sPIyP3c21YNS6dNswa3y5pqaViZqXwqBw+zRoscDwmlPPbiR49a4C3gV3qLiM3LSbBhnIB2NLgUnpF5DyycSQ1YIGzdnoSlCNFIA9qXegTVcXex1yIqz5/+0FYg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kgrPZslZoQQbFdBKyF+6yza5zT2UvDd6VvA3gzeT+W9Ym64Pefjp+bycZVee4RXWG34A0fOfDymi5mzwqLJJ+1vbhpAfqYShwqE9Hx0rorqQ4oSkl0IVvbcd5qr4B0XndB5viiD4sIIAdyj+b/K239RoE5d2FYAObkAFZqlU263gL8++8gbOqR+kFA5d3szUcxkqR7quPLP3f1P8ZrS458cmLzjO0YikhDIcbUmyDF0KZ+LueHnyHrpaa3GTADtCsibzgkRvaAEjSWzjfzpQEMlNYCrey3/3pi6gEzBs5xFU4HbgdcNyoQgWf0sLVFNLgWjvFu0NbZha+piS9phvVBmp9wzgiIHvNLa8SZz04oK0rssY0sVwoPlVbw+Tsv3Nu+0HGy/A2A0I4frgUC96zN8m9GAJ7We5Rfz0d+3Wk1p+TPu+sCptlxYZLOUxcBt4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:32.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe40486-d95b-4d32-e932-08deaa9639d9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Rspamd-Queue-Id: 292CB4CC796
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[ti.com:s=selector1];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244104-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.927];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid,0.0.0.0:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 689ba2ff81f7..79927a34edff 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -960,6 +960,11 @@ &serdes_ln_ctrl {
 &serdes_wiz3 {
 	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_HIGH>;
 	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes3 {
@@ -968,6 +973,7 @@ serdes3_usb_link: phy@0 {
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
 		bootph-all;
 	};
@@ -1006,12 +1012,21 @@ &usb0 {
 	bootph-all;
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


