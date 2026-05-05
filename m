Return-Path: <stable+bounces-244101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPOuEG/V+Wk1EgMAu9opvQ
	(envelope-from <stable+bounces-244101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:33:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65E4CCB46
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BA030AF7C6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8F428467;
	Tue,  5 May 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N2rnB7u0"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A041C2E5;
	Tue,  5 May 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979117; cv=fail; b=fdvMtnrPoXGYy/66oTDhRRWgGRgB3hzbwB1uOyf5q5K79mdZrH8/5x/P3SdvaJmCnLxoSyRNR3+XcJJmxitxgaKbELdVuzhC65Nls7DmgbHBZAQhi0pdP+PjKsWYPFODZWpg8eHSjoaUeqD+IP+WVrvdGbausodA5eXOvGFKAYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979117; c=relaxed/simple;
	bh=WP4gGYtHiJ/jN36nMvhVOY2QTUXT5raDOZ/ZVyb5OPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh1IXuCCZuy9tOmcHBh6aHXKW6idzc2GXW0qSHU9FD9PA4CdUeox4jZ9QqDPkWcWscf4JqfgwyAwX9+zu4cbPORo6pwnAHln1TFCSPAdE8zXXzLiKBrK9DtRF6kX1EPlbhaTCcBm59kMC4v+fbb+3e6A0dMh9IWLyC5DlkuY2K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N2rnB7u0; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4CVT+RELxli3sB3VdNEH2ubfegk9dDEAX39k1SmcfJAfMosBEMmcuiV+TJPuzX1Ybj7awVlgcwlKNGbm06HLYgE9BANl6i/XKcUBUUH03B5PpvGP0YlAZlblJKZ90ITMDHPTCdKDAACIXU0/aiLxd0V7D95WvmdyPAiq76aSOsqWH95Y0L9r3u8RlPsNCU3+oUN8zob4Yl63jdBkvf+ZwBfLEd5d2egNOYVh8Jh+y4rC2ByoB+yVeqtT4l/2Sir8TKfmn7hk/e82AjGZuOzagePV+P3VKKW0v+NuIbJAprSlbvxvx6NjXKrI4hN1jrxa0SIB9x1INLYOgF8pVwX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzYO6+GtdVWN+dSsFYSeTriv4zTdz06pVUXUI2tMVSo=;
 b=COEW2qzwSTVshN20Dguq2Z6J7Q75/6v0Y3BV2U1jHzVNUOzN7xrNX5eXkqPSdsTQS5twIntafD/YakVdzwz/bupF5V5HzvPwkeIjVhfKLfSfzwni3sSgL7rsIvmqc018YIny1kAbbYmOpd88NXxzHTfKYEkFFXeh1ybB+sk5M3rRnCOMa39BRcSDOdcbZUIalTwDL3elCP9jirvUfQ1tZmwJhliqn7RARLOLhZk/u4MlXSsIC9An1tZvXsKVZxa3GklqAJMwNzSbXc/ZMlg8Cs41hs+kiZqia3BvxqjgMDFozrRb26dyQCT0oBVPdKmhaB2c/m7zEZbYmxButz2kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzYO6+GtdVWN+dSsFYSeTriv4zTdz06pVUXUI2tMVSo=;
 b=N2rnB7u0iO0Y1HHAixzeIe4bX7IEjfHiDWXErGqwZ6G2uM5A5eJ9SnO4JYKdxEuU0E2OxuZN04DZiXGww4dRnJt3Pf0s7+WyCrGuJ/hngKdQC5xj8XBN/XRW6IM9fUN8MUan8kiXefBfAkcnMLE1CFcnMrFA2V2MDoPydWYv/zE=
Received: from MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:05:12 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::f3) by MW4PR04CA0176.outlook.office365.com
 (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 11:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:12 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:11 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:11 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h72831834;
	Tue, 5 May 2026 06:05:04 -0500
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
Subject: [PATCH 08/13] arm64: dts: ti: k3-am69-sk: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:09 +0530
Message-ID: <20260505110631.1144200-9-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: de5885f1-f772-46c0-65c0-08deaa962dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fGeGsu/fgeY9lfNGxXxb+mMdP36xjNJTKFeWXM3U20qJTbSv5o0v9XOnSFjDgeVyM5hCPinUL9UQhXAItk6ztBiflBf9hOrI80kgksnizNBiCZxzRZt9+PEexPssbtGibOHnQE3WTkW6tQi/Fxpo4Jo31yLgFy/7hrVYtoLl1BDMwp6DNA/OPuf0xumb5pFPOZVym/EgwXdwlOOq9llaaS8QGUtHKvypTBU+j6G3SRiOINJnv1vr0YIkkrLTgLn8xfF1p2fh2Vh8y7SrGRCrO0VQ1WHkZSURPkgmKnVmjoo2mSWulD83Ivj25AHK7ZHjZP5Vnm2pdvjHXWI78AtsOxcEaTCg2gxNkjIVst4nmfWsUqd5kvS6L3YuHYxKcxVKbb1VjleguZ5FfSMYJ1eUZtKFUZ4otiolaJZPWpDUBJ8nlfOYP8fGCEe0ohkwekN6eQtH+eaPGrCTck14FZG7LHIFpuZElFduz8NCGgAGl0/csvHhJRICLE0aG40HsupsnPFkNky3K6fYgQYZWdgpuHEVnL/o/ryV7jhe7dh/9P4K76p2Je/d/y7hkE3B5r1GVCsRRiKRI3xJGLr4FAEhe30uoQ2VQOWrPzOs9K7oyp56mWBBdYO2jVgneqIIKe4oTUChfn/bo22ThQmyn+1U29V0TpSbyP256ocVCyZ0OefEBj6/+gk22DgdlcyKQOygL0efMx06OJeWZ1NYwZO8qy3yGiMGc+owc8b0/kxasDGpoalPOf5ZWZoYBZ4+/nfc8/+VI7cRmNcWX3hUfk1YOQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kLfkqpAPKc1sFpdYUFz6eMMNAwhTMkk1e+vssEedyvmutxGAgZWgiJAAHSeCUKSDqymRa0cu1fJbzYbzBX6kuxs507asU50ZHNkszNH3OwAnh/XFXKPcuPAwdRlSnQiz8H+dpKcqzT83uMPP6XigJX9wuFf7KYXAB6DYSzqJZ+eXrnUTLqVgBcwdkUaGfM1b/PxmslV6/hUJXXkswuqDnF9a0y8PZCm37Nv8Sb838IdiaqXrIF1mq/lhRT2zzMh3YorBFpg/DBzDA/SkmJiknCCjyOokiJ5EeMqltbOBRxVKV1RPeA4YmsXjd43kwV4it6O/EpejInnyHBfdTtc2B7deQkVrfesYyI6HUGXfDjn9BW+atMZXxchEVOJq0OOAlk6aKWmX3pyZrlMzlw5yWK2UynRPvV9MumnjqHLpoOO2ogQCTvfHr1h9sOdFM2H4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:12.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de5885f1-f772-46c0-65c0-08deaa962dc8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Rspamd-Queue-Id: BB65E4CCB46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244101-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,0.0.0.3:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: ff7b5e93f16a ("arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index e56772a334c5..0412552a927f 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -971,6 +971,11 @@ &serdes_ln_ctrl {
 
 &serdes_wiz0 {
 	status = "okay";
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes0 {
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


