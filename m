Return-Path: <stable+bounces-244099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPI5MDTU+WlHEgMAu9opvQ
	(envelope-from <stable+bounces-244099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:27:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8D4CC9E3
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF85B307A58B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D93D523B;
	Tue,  5 May 2026 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UgXVrE3s"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6742387367;
	Tue,  5 May 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979103; cv=fail; b=dB3AijNcOkFqvD3co4mL164WX7vXKwFHSEVMgEPb62E7WTiuxa4kw3D9ScNFCEIMOTFQ0aCPOCqLy6rvHfarmLlDP6hSO6y8dIOftJjiIxkGBhxP0p8VuDuFJSW8Dt8v0k5PQnJui9X5Hi3iuTCXnkGud/ZYpb8Ot34HpMPjopc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979103; c=relaxed/simple;
	bh=Q1aLkwCkpuagYbR/WMh8IOwKnM73N9ypxfe3V1jyBqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEymvV8GbcFMwGzcXJBCzUCXN66NDsaoncOrjr+q7mTi7+Iv/KklS2V/ijjIsld8culILPxQVdrlTS8qDtJv6HZbrqP0X6whe9dCKjQwsuEtzunhUZNrHdmqYnoHzBAC6C9JwQvHV87UGGC9ePZ7TdK3JkXHF5Dx9+EfL7A1vVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UgXVrE3s; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr50jC/XzCy2C5DAXfOpu19I9RanoJqIj9fwaO55D9OhqHm2QLGm/sOlfh6uL/ducpuxpH65nOOaboH0+IzcmV71sCvza1fFs6F50kYk1P59ErADWrPfw6AzZKl2XLGGQ1t2huZnd43l2JjgqpJsEOtpVKU9vl281UJKUS9m/HyJSPKhNIc5STwtkTfbudQcKAVe9+0O3VaKPaDez5PLShpmCFvKjB3cMAqR0XOZiwir0tGb0ejD5aKTzxdVtiUy4EYhIElrpE8QSVIfga9JQi0Gu6Ctq0lPAqvzH61Mz8XZ9HeXvBITrDG1qHyqH3L5oWWZk7ubmCTp6R9T0wZ1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bar/ljvd7nPiLEOci2PGghOx8THrPZgdyhfX26g844=;
 b=WarI8espnmpOFaFU/C/HKFK2kLKU5IGZROf49eKCO3wG7Ym19Ds53SI/9OMhfKTwHHGLTUhdDHyGxYSEdjKM1zT3MefS+Dzw6H5r1mTbLzkJi1Deolw0cRAGvfy774z/H5qAqzlveLfiECTfBNjz67iNpVa5kuSnJ8Koz1/otzIp2qRNDxGeeaCN09Jf92RiYY7y0WcbLaFGbWa73W8tkLdh5zx4BweQAcIbKibvYdc28aaWtj4p84KYckHmZIROrJHV5I5sFyJH6yo8eBCD2i9eBv5NtP+qXDNtTOfo+j/bSYuhxN44QVHHT2hLrp7g2QZokimCufmf4KzdkQxexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bar/ljvd7nPiLEOci2PGghOx8THrPZgdyhfX26g844=;
 b=UgXVrE3s3wGzYQP4gChgLMOzDnJtf9FK8ObgD9rTGKWhCz48d3L45g/G4xEOeZciM1+O940cl593YiQ2nlbjcDNukXKF/i8I1Hr8MI0qpPgQe/1VtBc4d4wsE5knRnMMiEvd2IOVYBXzD6XdKq8XsA8fXcpEd8V1YQrVOPDx878=
Received: from CH2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:59::18)
 by MN2PR10MB4383.namprd10.prod.outlook.com (2603:10b6:208:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:04:58 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::69) by CH2PR03CA0008.outlook.office365.com
 (2603:10b6:610:59::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 11:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:04:58 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:57 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:04:57 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h52831834;
	Tue, 5 May 2026 06:04:50 -0500
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
Subject: [PATCH 06/13] arm64: dts: ti: k3-am68-sk-baseboard: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:07 +0530
Message-ID: <20260505110631.1144200-7-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR10MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eafe7d5-02b3-4af7-ff6d-08deaa962565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Izgjs230yKWWNVhCTz01CzSmh2nmbYG7raQ6geIUi72qkSaY50n0/cJfxo4vfVa+DXkm8U5i4KC4kTLWNWzWpcrAd0Zm7OpSRMHRivVeUmCle9T+gIx8xwEtm2QMPxnUM0leDi1FTPcLfLiKsvwaGrJDVPFXz0Dg2YRFUSQgNoAZvLPl/94UgD4bhktbiDvT4pCnUAYOhy7zxutJ5lt0DJ4j92OviP/MON79dqJYagZYOFsoF+SqtcpQwcuca3mCAyiPovMKKJsBcM9Pf4q+TR6KpEd9L/JIZ8dGe+0hiijhwgO33nO5cOQFmoVM9tRtCwDnf/rlMEuZ4gPAW2+cyaOHh7aXbIYaFIUcPay25QIJcxlMceeBjhAyame3+VrlOX9BahKQOnWWEr67/uujrvfxkIw35xnbKmnGX/y0gQJfsoNZuLqOZ/eGVxzHnRI3jVaJXG2FADDPXuF8T6YkHaaIIt+OL8T0My/wBlu6Yi0iw0+3U0ubXIBst2b/f0tCRUUdo0jMWzWWYaEzeSb1xEBqAgAGWdlp0qNDuGErsBc+msacOBykwbwHvO8yo9+TBRoFQURQTr8mjDoR7/2eOAKgHPznQ86AzAZjdctDuo/atqpENUroH5allzu5FgECh4XhKkrfbkzE5BS1gdtCohC2UDWI9VnYlHSNkZCQgE1WBnLuPxLWqX3tvRMoeP7fcK0LmEWEdbqDONX7KFQBX56zknXdFmDiDWFQb2WJWNzn3/wY7COlNciGsGA5j/40xX470gB/yAisy7BJrYf24g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvekPSUaXskI6vhDImF/y+2GKsvRAuLvtDx4h7pmLeaLa8WTljVLjnjvmKmq3IMS5qCcfZnARMH4p/o38wWmwV8r1ylY7CRtXfiQo2lRaCEBZGBBv4O+clQ8uFs4x7ugphlcubz6pflE9YoSOVvmTp2g/qf5PIpvuS8ImFZlwViMxI849TJoTGGjNgSS3PY7hv/z//hAZ8/Mz1aEO+MDqPWzsVEp7RrHb7vj6/zzXOgy5lQXt+EgvU+Ad6zpo3wfBqa7kwkMFKIyiDJZW+Re1oHiFmnn4Xmjkuw9VRfduRtgQCPaktwL9a/gWo3pEEyAjZ6McNI6wWAyznmEdUaE3HDFtGl4i6+DkiHatzQsKb+MuLi28oHyuMM8djUs1zd4y2SX62ShaR2euLcBM3JJBRYx/wX6jzLK4kLu6huTz8KD3RAXfgMJAlv+bflruJ40
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:04:58.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eafe7d5-02b3-4af7-ff6d-08deaa962565
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4383
X-Rspamd-Queue-Id: BCE8D4CC9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244099-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.2:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 067878e6cd25 ("arm64: dts: ti: k3-am68-sk: Add DT node for USB")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 8178333fb2b4..d44c3685503c 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -793,6 +793,14 @@ &serdes_refclk {
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
 
@@ -810,6 +818,7 @@ serdes0_usb_link: phy@2 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 3>;
 	};
 };
-- 
2.51.1


