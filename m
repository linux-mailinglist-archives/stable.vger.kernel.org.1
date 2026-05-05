Return-Path: <stable+bounces-244103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPbYE1vU+Wk1EgMAu9opvQ
	(envelope-from <stable+bounces-244103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:28:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3AC4CCA16
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F154030D3BD1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE142B748;
	Tue,  5 May 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QLq8nRDG"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB6387369;
	Tue,  5 May 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979133; cv=fail; b=WjABuPIVxoSJ/noUrqh7cIbFW0P4NfsTp1+yluohp1tPAN7BZyjzy2ixRZvdz0729fYz4Opu8SKH3F0KQbxaXoP/DvgKjaLiZKogwP0PDKD3Gx0cgS6SJiKPy9GJGw0aQiHAc9XzrVQv0ALpE7v0qDiHy0zGyUxERO7/4oeJBRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979133; c=relaxed/simple;
	bh=z7W9zRJojWlKWUgpFSMkpmhB03beU1A1DynHZXduiV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXXYRzmE9psF99maT8lWkt3eLzTFMoNfmKBrRyr0FRu1P4YMm/XLmUOFCX/bd9a85VfdKemX90esqtnjocmLj+IPuNklOvI/YML4TzJAsnf/WdjNqs6aQNZNdRMSGr3+lNEx3MHsNCoHjh/9MFanmhIPsN6Nr5UYQhnhBVvyyLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QLq8nRDG; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIeKA9thrtv0gwCBnnVJ7CLBZA3+dCvJ3Qoa3zKIEEzRu+2tYEYGNfAKoROhOEQo4247ILWvSfMvfr9fz0yEkrOGbDBfUFTOQWHcTs3A4O7txEwQyXdS/cTT3WXHHAsbrAXXA3qTdamEJAETTaxj+ezjQjrzxTULOmQEePZluVBcppL0o96u15CKY6JeOA30ImWXsWjrGWK2JDc/ZqKjFcyG9YgHvzie9hK6zRJnnppdbmyB8RSJzwi4VorI2n39rwB0hOhIGI8+k2NUm1pMEChBIIEipbFmzJa/ip/G8T3QiADsu0+oRhM6ooJdgY9+KlDC97ltrNPKkX2A97BFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCFH9PnZazECpFCVvXazDC+9KBNvn88CA1Q7HWvlU3U=;
 b=NeWrFuxMiQRjB9zFTPb/texXdidVYFWjin316IIlSw5ayrIZDFgYpBiRwVbnZLHqMKJEa2DNBGb6KFlBJwuV3vlfKeF9fF9B8om45A23Dtjr1R1wpusKDdbgji3/4NCk6bGnBXeVUkc7LAcTlDJutuEszFsaRTtqxM+CIsEfyT9RqX8ozxL7///6bUh/TbFA/oZpUEpJbIC9GopaKIt/85wdnzFV4yADK7rVb1j57br5C7hc6E0z+6Oms/mU1CVwcV0E3aCM/Ap2/AlUxa9KPJsIttxnNgWw8aayIA1/BPBjYcGZF/nyQ/1Kc8FnM5f2osgSDN+hZbEOpEnKzzGMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCFH9PnZazECpFCVvXazDC+9KBNvn88CA1Q7HWvlU3U=;
 b=QLq8nRDGsDparMnRqepM9SNe7mldSXVKj2d+7EnioiIM5mJFUyl01QnFCm4RZeNOvC/ZMIMUJpFwV6IzHq73eJGLFxISZErh9wPtF+u1QA7iy1eQklEzvqy52nuhLIC0At2O707JqIHibT4LkuOnERe9so3jtWEvn9Kre3AZl0w=
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by BL3PR10MB6019.namprd10.prod.outlook.com (2603:10b6:208:3b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:05:27 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::3f) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:25 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:25 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:24 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h92831834;
	Tue, 5 May 2026 06:05:18 -0500
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
Subject: [PATCH 10/13] arm64: dts: ti: k3-j721e-common-proc-board: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:11 +0530
Message-ID: <20260505110631.1144200-11-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BL3PR10MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2e0b81-4837-42a8-5917-08deaa9635aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|376014|82310400026|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eSuUoNOTF8GGzEx4DqSFGxN7AjejcvROmrl9injjywgUSA1J2gv1wDu2BpZShN/Jl3mW+fcSyM9FIJneiptg/1Xr9UeA8wRQ9HZcSzJ9sJd4Artg03oKInnRGXxIFB78t5l8HrKUFdLuwtp5aZPDyqHCbg4oG4nee/iRhEtqHNqmYDFEBP9RAWJ2no6drEm1GA36s6/dYYVBEJOhKcZsEWAT+H9QhvEfiaX163W3bj9bMJS59npxulX61pcMRVX0VrE32yfbSoy3/hxhJy1apO8eXBM5ZgJykE3rDVfrTtnMtnuOF32DHYDjMObWNNSQ0Zr5VZOW2yhw0a7bCHjvkriiV8tDLsQGjPKXGNtHCJ1PQTe2uNR5dPDD7vYG3X/7ib6mPq1+FRk+6Mmi/etprON0hq0O/Pg0BKWCP11xYiuKeLuhZr3LDE+OI0VAifgNhxPXRpc1KJUbo6Ym4UFxJsNtt7/U06Urm/JoDNV3/KaFDeElgmPAPY90em9mD/7KhzCiOWgYCQpLUk8/2+T0f6fueOWTxjOTrjKYXBfowF6sY9+qYYidpaXc4lw2H7piPU4gqXhJKdp6h0aNg2/6+1Vl6AgN3CKdRgTpuCyqUQEvMd9Cpt3GGrbNCQkoBYUf5583uQdqP+R/X5qfYImhsbXSCh29conj+zJdT6XwPG71wsvR2cgbAL2lbCKf8bvXt4hYySXba8lvYcpwy7H+257T9KDKhAO8kNN8NhYKIYm9rTYLKS2UeG0LIkIgWKuSxbJmCI/gfqZdrRh2+nRPGw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(376014)(82310400026)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	edktPvRbHd05rRZnSwtkf8eOzPNg+hnQCH65qkyJ4UnD2VUxDXFh1ZQZaSGQ2oSrW4jnJ/wBzrVLXyzur+MqL9mqxqt2EgWpNIpjyuYPP79z9vzcCWs5/PeJohBqYWjV0uKRiD3ij4n1A9toV6OUOgSzbpBpJ6BOZCDvo4Du7BKHUnzgD/1Eec4AdkdtCBGDB4hKTNCtz4p8elttcDmXpiK96hwiy3zjSqA47K4+EBLxAY2vqdB2LV7t7Kw/imVM62+FFxZRW66/yfhT7BYGwwJWQ8vSawbGSLdjVyZ7QGNEAyyc29oWYd/FzTrb7M0XGHR0XgHRYbwhK8Whe+Q/4BIIQLEGnvrutjd0kqsmPFEKfzO/bfN6pCOe6wk2wu4HiNiVTxjo1R9VIKb2iPVZ2NhwJ1+OLzIbltG9oVxAdMBNHg0Q25HGU20MlFfXMVjg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:25.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2e0b81-4837-42a8-5917-08deaa9635aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6019
X-Rspamd-Queue-Id: 3C3AC4CCA16
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
	TAGGED_FROM(0.00)[bounces-244103-lists,stable=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.926];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 02c35dca2b48 ("arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 53e7fbcef52b..b25bce995b64 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -531,6 +531,11 @@ &serdes_ln_ctrl {
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
@@ -539,6 +544,7 @@ serdes3_usb_link: phy@0 {
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
 		bootph-all;
 	};
-- 
2.51.1


