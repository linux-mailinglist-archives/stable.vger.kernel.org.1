Return-Path: <stable+bounces-244106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFbQJ6fV+WlsEgMAu9opvQ
	(envelope-from <stable+bounces-244106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:33:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC94CCB81
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F0CE327D4A3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864B342E004;
	Tue,  5 May 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rhiTP2J8"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527C3845B3;
	Tue,  5 May 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979149; cv=fail; b=ncyA6d3lLsmf+ldmeCi2azSp8np2g0mhOQUdwrz3YoP2bs41+ZrOdLMsfW51xp/3Y263P2S4SzdsOtTd+0MLf4uURTfgBMJgLctS2wUzUkAlzIsCg5471EIQyoQfAJcHQ0HHNpmBvgDeD2f6BUBgKFyZCQVCuYiNowBlU83GWvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979149; c=relaxed/simple;
	bh=YGSAlENsAq0lG137GHQ5Qgw1dgH+9ZVSfD+HXFxjVCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wde5d6UquoySVTjR3bQB9AFs9BjF/IzksXTQ8Qyb0DwWK45iXoyZRO5cnpO8qATr1MiF4migkWz2GuUao42DyobiakEL0tVqU72pfI4oEGpiXLt/HAaTqI6HkbsSdoui5F4fxoHQl7pVemLLrubfxrvTeo/rcuKQA5dZhWcc3zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rhiTP2J8; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip4yIHmxfBraYGmntC+QwffLBb6C0J27FoIKwk4zUsWlb6MtsBrsYT/lAvvTr+LNaxiGsg9eASDCHnSt2c42J1QsJ0e/Vy/E5CEyW9zQlDarekng6AaMDtR+yHlsNYIyJsSK6r+JKYfL6dA4YRNuygTh2BWeJH6Y0a0ps8zR4FzqZE862+2803VMvLXKMj/mIsJycALjsJRtjcs30FmgSSlL137riVTtPiAYq2mPtMMHPOSxNy538++87RnSV6zTEbB35BYaRgDus+4PscuXIy8HJ94a2W1v7ijkCydNYbefCQY+N3Mlb6xDRF3eFCPis0jQqZP9ch0Yg/sXJULyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N79X5KRz+NKEQoVayD4aItAcw+8tPQJfWhnX52y0C8g=;
 b=NabeEllsar9dSgqcNkwfwCBtx+/poHzMrp0j7SuC330SovBV1vzYvDACla599IFdWYFbjEBG4p2iGkwhw06AZYxe8dpl/S0t0uW3D+v6xnYGMA0oMEVewVuLX9MfK7QyxHLNs69nHHZWrRQGwb34dpq1tB3JXXLLyS17wymRtjXC3efihxF5YEALeSFMV8ws5MC8pOnKPlyJZ8e1gSqWB9mZ6QUQT6IHRTCPmnNi+n5fBnO2Gv/0jawWXDRuMFJPN0YibniGMGruKY2ErFF79thkyrXVh9Ur2+LoeGxV6d9GqPv5o9pajHBItKYa5+mZZybhoG4YRmlIG9Cmea5ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N79X5KRz+NKEQoVayD4aItAcw+8tPQJfWhnX52y0C8g=;
 b=rhiTP2J8gg8kvqaq7S0Lju7i+VVpIpH8iyh9Vi8wjaVL13sxtzqR5citOiCPojSaluF81PhYaKOlVmrpfY9fyr/vhR0V+W8ShqXKtqXu/6bQk6xDO9I6TLdGqqe83fPleIXE+xZddjtTN5N3Eq06FjPodeQuzNc+yqZ2Mt/TavQ=
Received: from DS0PR17CA0004.namprd17.prod.outlook.com (2603:10b6:8:191::12)
 by SA2PR10MB4603.namprd10.prod.outlook.com (2603:10b6:806:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:05:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::9e) by DS0PR17CA0004.outlook.office365.com
 (2603:10b6:8:191::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 11:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:45 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:45 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:45 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49hC2831834;
	Tue, 5 May 2026 06:05:38 -0500
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
Subject: [PATCH 13/13] arm64: dts: ti: k3-j784s4-j742s2-evm-common: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:14 +0530
Message-ID: <20260505110631.1144200-14-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA2PR10MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 514fb063-f0ff-49b2-cf03-08deaa9641bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1nalBken1Nw7LjgBa0KKbR4nfBXkg5u9InaBwx+kU33ApC2ZLXdOPnxG51yhvBiQcyKiKeBU+g1pwMqfy/oF9U+ivaG8ahBKChPAkWj6DHm+qPi8vbmFpoqdDkgzJ5qrUxtOPGgAiHCNZl8ADXWZYjUO5E3BRpjfn7F2jwU+D+8NVGYJ/A+UXVwwXOx0tvnHOqUI6kFHFBX4SXgYWxYMmg8KeG7kr5ylX8dFXHJoj7g1+c/8NIEQ6q4p3WA1Y2gV8bO4AVLGTBXmWx1Q3+BkPQ4aTmsI7oA0h+P2fTlhrNfBsNeM1jR8PYVnEPucWhzigAhnk8tMOYN71M/GD1vXmCm3XVqsqqwwq7FRGlQ69bkCfJb6Ddq0hwYuUH9aML7dGX3vbUx6QmT8nWRf0kJ+zNkIyD2/Z/YPrvO63DQODQssNDbcMO5+zTxkmZaro6hAA7LPrQckG/PfXNLkVttp/pgbZFa0EFrjWhYOdMtp8/ylsViLBs3kXBHka0RYo8o8lf6QLL+o71Fy8EVSt4uHhJVrWV32G0nSoe7g2wNojovo1XGMLTGlE10sHkc4zpaHvCty0j7kRCDYy8wNjQuYphr5wOBUyxl0/hK5KwZIxR9vONAgJ3hTS/bzOmyeo76xaGPdKmHCiRO1sjIRmOmDW+zX5tWJfhvPmtSlFa2nbMWK4eaUU1+o1xBslg9WvtrDzNe8yeuFuSa4hSUykaRzkABjdInI4MI3Y5e0Sz5LFLcx+TTZIA+cGFK/8UXKv6ellWi+W/3e2iAo2oJjBDAXdw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ylNwQ96SMneSgH1f5wtqJk1gQt36ksmqCBd4C+wPPVO39BSyJhU8mF1ujwnln6feOYmye9VaehoRE+VjomCRyGcDbkYXRvhnzJry5lWFgeO21PAb6FsCCW+qZUIQk4JUhjXJ9oLm6T0X9fexp4KGz7QZD2lOPCCtxV/jRJzjXYWDD9EMdDsaFCnbmVTt3OYbGLUiJidNSvEYNLofcZFnSQiNIgtsFlf0m+LgOCKdeD/9Aj/QyM0G7aktYO6DcIO76Qi1U1kokND32T1G0qekus0uqXrbv4RuclDSA6VCB4XPbKxvPwP+cHxURpLQ0GSChdiG5bP/VBC0k0ZE2jfA96Nd6HZWVi/J/LmqK4f8K+vWe0A80u2LBqZ/aB5jU0Fv5uJd0kKFNMZEqvpGrbGSREBynt/V0DGHroKbtQqcX2dlOxvgj/TgE2mCLCUK14WU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:45.6829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514fb063-f0ff-49b2-cf03-08deaa9641bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4603
X-Rspamd-Queue-Id: 07EC94CCB81
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
	TAGGED_FROM(0.00)[bounces-244106-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.3:email,ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 39b623c05c46 ("arm64: dts: ti: Refactor J784s4-evm to a common file")
Fixes: bed97e94ee2d ("arm64: dts: ti: k3-j784s4-evm: Enable USB3 support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index ff3a85cbc524..0884773ad230 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -1010,12 +1010,18 @@ serdes0_usb_link: phy@3 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 4>;
 	};
 };
 
 &serdes_wiz0 {
 	status = "okay";
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &usb_serdes_mux {
-- 
2.51.1


