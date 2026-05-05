Return-Path: <stable+bounces-244095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oITiIGbR+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:15:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B604CC567
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71B763267D53
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0252421F03;
	Tue,  5 May 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kAf6nIYz"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171C383C63;
	Tue,  5 May 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979074; cv=fail; b=l8wZbyczsXXxXT0F/GYfXoIHE5dWq/QcdNLownobhi0zHEOIfyDXxxMcNfOiZCH5fsJPSftS9iPGCr1zFe3wkxp3Uq0lmCna59idZsZOR9+PSlT+WcFSRMgeCDU00O6HX3aHN9vkWVRYBKwcygF4wN0+YfjMraH6vyO1VOnx0Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979074; c=relaxed/simple;
	bh=DYZo2FjLXiI6Sb/dJ8xBOuZkPUMp5llHutOG8+egiu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaHeYC8zO7esIRF3Tl5rkcwpkO7jyAeYFiCXxv2j402ZsWMUfmW3JfPMJf9DAcd2GX00h0W4WFqVfYgYdYH28KvrjCqrouR1X2UcCcc+bznsa0J8oYcXpQfuoT9Amc8Xfb1jtPIUPPc+LROMOGceaVyR608ZT62xYHySFqZmpOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kAf6nIYz; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku9Htr209gOKuYO4oCcGKOxgt5xV39V4DHidsERkdwi+fxeCoGKSS1BTvWOHgeEzW1J5XYJP1nsIoufIqsEV31Bqc7k61u+NaOb7Z8i4CwDyf362CNaEhUIroq3a2w5T7N+sMsl18ySut6pipvr0hz9PCCuxzwCUHJtLJISKJYE8NI3JDBgQQtx2Fb8f1u8VpLv34pFIKf+QJ6uwwMKWYW2IFfyvk6Z+P5uUvTunA3Jbc28Qepq1wbJHqPKUrrvfa47QYhAlBki2Cm0Qox3/0RlNmlMmXbWXXJ63TRrE3mCMGGI7nBKPHvnF9lUJDzS5qaGG/BUuJm7c3HFdNFeHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAlNp1RcL4T63g+3z6Xg0lfh9IC0U3rIdewfojOaMvk=;
 b=mVyQqLC8ykQsSJjL2QppdjxBsBRIyBEa9ksnX8homIRmuBC2hTzXSyW2+bDlPzYAKE+xwvAUOU6scKFO7xNFq/YOkcCZDPcx8rn026SmpNeJo4mQHLsY0pJgpsKqgfK0H240zdtS8ib+5jUwB5g1a3YCPRLhpg9d0lFGTXcqpQ26Rn7W6cgbviMapp2keHS1oeG/6RNnc5bK3VJpetptZv/xv+zKKa652XEQOFf4n/p4d9+PZpXwvDBRXqILE+4kMyDzcswrjH/1OuITrrhNTCZffiXnVSuV/sXtWVZHbXY6ez8ttv/yDO/4DL7LeG4rDLdYW212hpfvn4/q2QFHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAlNp1RcL4T63g+3z6Xg0lfh9IC0U3rIdewfojOaMvk=;
 b=kAf6nIYz3y5VW6WNkt9nNtYguhZZ/fks4f8mg2Id/48HKF7vmCrTlQ59Nu5nVe7aOzuSQfEphACiIichg+T4uBx5CISfVvWPSzi4V1kGTKc9ql6jkVX2PPT2khBG5AmfdfHgg2aA0r48C3RUtVWzbRpMSaqsvFh6OREWZOMzd0M=
Received: from CH2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:59::20)
 by IA1PR10MB7469.namprd10.prod.outlook.com (2603:10b6:208:446::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:04:31 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::b3) by CH2PR03CA0010.outlook.office365.com
 (2603:10b6:610:59::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:04:30 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:30 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:04:30 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h12831834;
	Tue, 5 May 2026 06:04:23 -0500
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
Subject: [PATCH 02/13] arm64: dts: ti: k3-am642-phyboard-electra-rdk: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:03 +0530
Message-ID: <20260505110631.1144200-3-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: cb483130-395e-4638-5a84-08deaa961514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/ZVubsN3iHdGBRFacVQeWgvneFovqSQTA5Oice/MKy0q5GJidV+R0s5nQkkZXWg2WEgmUgVjMv0V/0DGFAI9Z3yKWxAUliIm6TbeBbXNUrI+5mjpGiTxWZtMduCF6iUbCJhoE08itQwnFFUcmPHb/Axj6msFM4Co0X8jSQqCrF13kK37ERXqU7W8w0jD9ALab4PfKFW/q0qlupLjNy9NVWDFVCkIDvyFUk5p7OOp+mkyEA/39Q66msrr0JqjbnK43E5Uz57VVHkkcg0i3QMYg01YROiSfyPiZ0PageAvAQuohedogpnMl5+NnWZs6SkDRv2uCzJXsJ+NZx5yQwdDR/Y1zlLSN8Yvq8PTIMvHKUhhAqBbpA9sM50X1IYpwDf+kSWUaF2LMUqHtpxxJWcrvNuib5R9NVEV6o1C0tPtf489y6Zj8zb/TxjtM3vih53nMl+wvfWZClo6ZyUbjei9vD/FnHq1p0sZzre9aCoSE5HX5pL43JWOK/8ky+YHzOTAR1c8G4XRi/xbRIziSNIdqmgUzMwaXkAt0o9w2e/WlknuNSTPi7ZaYfsJauLrLtciLdol3mThtBzbusn3bcMJNTYjr9A0umj/uw4i30SHtdXpWnHSGb35d2JPGv3IwjVs5vrzAf/d5iTerh/mMlxZo2ogpeTqUJBXJ++2mrFudU9Yy4+QJaYKbMrZ99TipCDtTYjmemzgljQjCTjueZkyp26VRotkNvDU+3JNQfJK7siF91OzI5bQTwKmuNtlrs+x9w6rKVNu+vPCB4RGzxHHjQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yZAxCCaIhuN+IafOF88DXidskIzR9SYwyZltcPeXAAwOwnx1zm4rFdCnFyf9Eb1nbrxdJhmrqI3lollWJh24eaFN/2azA499KHgqWQDDwQkEw2Ova9U5ksLPH7iLHw9u28wndsc+8wUTVnv3yCK1Fh3KYAuNeHENLvSG6WjbS6E9CSnHlr9OgGo4BlNc9q/MVsaIq+8v2BHJUULArvuV0OPaUHNdtrJ8uY/fG84McheVSyYt89pWVxFhJiWfh7UzZ+7SrQoHXu/k+/gpFhwvzll5kOFoN24A9qXF9wE6DnPd5S0ZmaHeZGqw0T34fI/s2kS46N7pjVj06jzIvWmr9RZ46kGKOIc9wip7LI6V/NeP9OQW3t0I0OztMIQnwHQF5AB9lqXZsREFKJsoAShLelrIsBuPWwcmf6jqpjYjtGiiy0jrxCtQE9vIW7BgcNYb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:04:30.7645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb483130-395e-4638-5a84-08deaa961514
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7469
X-Rspamd-Queue-Id: 17B604CC567
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
	TAGGED_FROM(0.00)[bounces-244095-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.928];
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


