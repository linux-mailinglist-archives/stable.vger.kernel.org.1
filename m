Return-Path: <stable+bounces-244396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ODoOEVS+2n+ZQMAu9opvQ
	(envelope-from <stable+bounces-244396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:37:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D04DC576
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE68F30AFA2E
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845BB48BD4D;
	Wed,  6 May 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p1+BbqXO"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29848AE2B;
	Wed,  6 May 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076537; cv=fail; b=lkjXcxIESqd/j4QGIZHR4RcD7YghJ6X6WuQAlGnDaVXUftxHfPYRZRUY7lXQCAx9t/BsB25E32u3ki8ueOF7F1ZFMdq6Yzro/M+uvlkqCFTq1XGh+uKSfZRV3IWb+ThwJrjQVdWuD/bDN4bHM045OgrxCALEk9ztcR9Y8uGM5cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076537; c=relaxed/simple;
	bh=2PmiOPR1nhqjgrHXwT7zW9VgLRnco39lzrbnLYaYlLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+2q9RYo7Za/1C05QWLAZUmynYS+6LQl0HS/5kewJdd1jlE2uXB4XRyrQcgIEkBJrUzQDlX9nhIaGrWlF864ZIo6T2nqct1ZPV3fsWtF/3fNeCPmVrtBOJ6ygTgIrFlCWWAAyF2w3T9ihBuMdlwJlRAj9T8uyO+W4FfjAnOjOAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p1+BbqXO; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2OfVGcFqI1b39a6TB/jUzOy9XNlpPPBBSjEtGA+FWih/8Xdn8juiXdmagnhpSA8rRjQT4tkczm5kmt5qLeSgc5whTqYGULatJThaHxZ9bMTY/7OqJMdUmWuhQuArOgPKS33k8l/qr4TfVnIUoKCzYtgnU1yOUWaYZqyL7TiSlRC9v4/4KntuQJvf45ykz9wQ9DyCjepbjNuhy8dpzQqbCDl1dJg6ZI66oPP6brDpj2vrBDbUPK/PeNcxC3SXbLIPt9EQtSJ+7GHGf8cgLMIfhT0WAZ4lmKU6alCx6wTmM30/eywGFwL+htwSVSvl3zfK9+24jpI23HJFVsOU/MlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgi+A/ZIfv7/qbiGk9UAv8jE3kQb4C8q8+nRTgbh1Q8=;
 b=gNX7RtVZ+H7qJKpyZTHE5U1sKipIo9ZwTyPoRHJqq040w3Wc0dKibSlWq2iFqkyrHxFM9428odEoYBUyxlosXxn/XwwzbCvNz9lrG9RF/Bvre7QRYKRFePZrviFxRnhmBJ5S9zoVzkNQEP8n8fw0pMfCFhuWeDOYoYVMTNxbXEgsvBqvrgjdkGGc1Pj16xkpdN7nL18HHMZ9IV+68avtkn+zPpMchR6ahfAb4V/MXu/i0RCFpMYfNxOJ+ExMJohmhAguoQ/yVpuP+xlJHfKhqfq9BvrWjaZXZghCjvqAfh1ayY4Ly3IuMBSo2tOSqj1r6bB7nSebxBXN7cahtzP3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgi+A/ZIfv7/qbiGk9UAv8jE3kQb4C8q8+nRTgbh1Q8=;
 b=p1+BbqXOBn4IowyXfhK8nVD+LmaLgOhbL2+PBcJMBTOkAkBwxsAsIzRb2nRMFWfMFTetCbfLyGaZVCqEFIBF7mvlU3Wh2YJ/FClldYZUHOlmwjLdEnWfrGoyPyc3on2ezqbjdpHt8CfDkluScT+uJ6qztHRzw3AsABvWF9CxEM4=
Received: from CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:08:53 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::2) by CH2PR19CA0001.outlook.office365.com
 (2603:10b6:610:4d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:08:51 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:45 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:08:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 09:08:45 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWo1221395;
	Wed, 6 May 2026 09:08:39 -0500
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
Subject: [PATCH v2 03/13] arm64: dts: ti: k3-am642-sk: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:35 +0530
Message-ID: <20260506141040.1368918-4-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 962ef1d2-3032-4566-de43-08deab79000b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rBSVhIcb/dFuFgaLSHDkzY7Lia7eEUZ1ExeH8oc6kcqPUcK7cRQX5SuIK8ile5ocU74e0pMDKn2YufOOLqlJBSTHDpuAG1t8xNDAl1eNsr09aJCRSEr/d3h9DChEWGgiFnbhkJ51shJYSaRArUbveAi7C1qw8m30/VH08S61nV59YACuq6qLiIkjjl54eSGEVdK3fBfa0v3HRR0D6RZP69G7jCgwNe6pG6bnWIdKgYZ+k0dc9KSY8QbDHvaBAUtZDCvTrmdjPrCwUWelp8EVD2dT1G8K38TbNB3sSyhucxPS6lIw+y1a9ly/VUxn9WQDsB1Jfm+qV9Gs1NWL7ODJ1EnrOmztMO1Jw8qyCeY4LT460Fs9ofTY1J5WIQJBkGH8s0IRSwcyUlM1phEGXnq+oU5L8JfCogDyFyhZTSjBGUHBjlSp+owcF63pDk7khjNST4UOVshSnkBkB1Eiob9yes0T+RF+TJOqhoVMK+kkKj9v+7m8eOhkJxI8YmcaE2bhm/rXjqZKqWGFIzRJQzHxOPp58+c47e5w7wO3xNhh90edy3Mx64nqD/7kSPhn3DsIUdEO1WD/bqSRPrBsKQVBdF3C+z08DTETrwmhaYTkA9KJ5K8AXIqLT6GNEDRirfSjvhtJDsrFi1nJWKnPnpmGt+aDSFoa2tsugJsJooJ/cO0s+PQiCf5Lefq/HJKu5IFkM8/sUsYjO4DmOWoA9dGiZTlAS5f7BWR1keqiz6JOgm5bVqzSo4D/rBiP7Fa3dxLW5LOdssm13jBnYbl51Mt9VWBaZjuo31J8Hi13SdsME6M=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X1Jcy+4Yu9DgV5TcOvBjAeVaNG5rr8jqL818qBIF1OgeBrZ7mxCqlu93zrDR1UCRdiGCL82TQBd0y3P68DWAGSQk318BMbTpM4A4TX75bXe2DEp7v90ppcrL+OiIfFPRDi+boywEZqJcvFFaUi50S1FGe4HyVc7+cDOJu7hFIk0ChuWkY04PiS6XqikI+c3TxSFLIF49O1SffLCSYcs3R4yIHPg1nwyrOpez6mXB1rxIHLUJXEf2hNGLLjHy1wUn+ip86XSLgBY7Xs6/9Rdg+DImLAdWVXTsSkLtvFzpbTRVaNtegTkTakgDLOzX5Y5Zhha7xmjVOmxbWsLYqOMYgNQJDn/zk4BZbKw4YzMnSFZ1QyZyfXw9jv6nciczUUNNNzqpreneprDSp25DbVXogslqUtCS371vQ1TfHypGEs5GDD+ZSgR2GMndBkLsXD82
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:08:51.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962ef1d2-3032-4566-de43-08deab79000b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Rspamd-Queue-Id: 5F8D04DC576
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
	TAGGED_FROM(0.00)[bounces-244396-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.885];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

v1:
https://lore.kernel.org/r/20260505110631.1144200-4-s-vadapalli@ti.com/
No changes since v1.

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


