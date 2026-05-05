Return-Path: <stable+bounces-244097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKuVIkXV+Wk1EgMAu9opvQ
	(envelope-from <stable+bounces-244097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB934CCB12
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08C0317767E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54379426D37;
	Tue,  5 May 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wFB3SE84"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012029.outbound.protection.outlook.com [40.107.200.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551531A7E4;
	Tue,  5 May 2026 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979089; cv=fail; b=s5QG/7rtU1vOy9NfGL2wdQe/SyRPh875fkaYnggPKXQfWpBy/q0+1t7c+LsEmdfQKULl/Ir/hJ2tEIVqRBUSBZlU3RbtAHgpVkLgFsK0iCelMoY7gL4AqGBrqwFht2nJZaKEwapX59Q51dVqCMW7qPbB+294BYjBlhO6keXyxXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979089; c=relaxed/simple;
	bh=U3Ka405ADYNkvW+QCgeFOI97L4ObyGnaJu7CNZFs1K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM4gamXHo+IcNTyWPTpVa3MkIpjDfHHzPLW/JWqudiMoTqzMeRhTS6zk/XT9+/r+50x7KSAc4HW+8/xrCdOpfm+tKpc3rpRN+bfxn/XoELRLJDvdY7M/oaLhTcRuq2R//PC4i6fjdx3AsPPnmAWTmp0d9k2k9e21afKPuHVv2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wFB3SE84; arc=fail smtp.client-ip=40.107.200.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STXxa9SSahpJp33B4S+u2ehFAL+mlHdkBQ+xnXflUE3GlkYOBaLdDP7C1t0bPGYVHGPBq3Lt7oRNzrmxQjTCuM3xNZHuj6xCmHRnJcgBGcLriYJQA9ihFVmYqkjNoIZDWS+iZjhbs8Z3J7sVA+qKBE9BrlbU5BzsCl6sJwYQcmICIgifATrx5ZpMkMHUW3Q3YsidPlRnjjPZWatUV5q4OV+Yfen3msf/Xino8LHhIjfWDOOEkwFlbrtqcQ3YROa5gXRfxPae7EmRnfPnB2s069aCJc+JJtFCjymgBIhPa3Bn+pI1uBCLQH014Ik8JkYVQmgCrHdKiqonmygmifarfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztJYPqqWo+4ye8/QbwqrDprW5aYbbPu/748b7wrChMU=;
 b=Ug55xbqR8bLg3qxT81LIXkBcg6S+b8N3eUIY67LM+t64X0zPccGKIMWj9+62FV+ummvXkqSPUJbEURwmijgYevGgw/MrGXv9Ik71ql+OOPM68W8lDjHOzXoom2O3AVO4Tm8Gl002uBgjU4aW/tiqzA7Dyrlm2pi50xoXZcYM8t9PoBNVJTfDr6hK1lfhJU0oEPRWzcldJ7tcyNCo6NBprfB/UV5Hn1oK1N8tF+enhIVmrkkaXcOjpZR9sX5kwYP8NNZwOnTV27G38z/SnA7K0Jh30h1nnDT5vwLuiTBcxkVYNQdHKohRZri/XjZXzZn+qnqjng0VRqVc6Cny2uldrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztJYPqqWo+4ye8/QbwqrDprW5aYbbPu/748b7wrChMU=;
 b=wFB3SE84N5YyPKdcFP+cBKJ7UhkuYbI75yBufZ7ByaMRlLr0SwI2HROqkdWYqh1SIEZCcLD1sKBCqOn0w6SUFxrph31I3EWYWUfESipFLtluzid6UB3oKN6LxaQs2xgS28NbCXI7tRcnKGkIT+h3b8MCnD8U1y0ddUdLMbEq958=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by SAWPR10MB997879.namprd10.prod.outlook.com (2603:10b6:806:54c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:04:45 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::93) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 11:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:04:44 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:44 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:04:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:04:43 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h32831834;
	Tue, 5 May 2026 06:04:37 -0500
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
Subject: [PATCH 04/13] arm64: dts: ti: k3-am642-tqma64xxl: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:05 +0530
Message-ID: <20260505110631.1144200-5-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SAWPR10MB997879:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6957fe-d5ed-4393-b8e2-08deaa961d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Uja1JwMn6/X2TAEtRiY7E8cKT+kUZPkQuvBoU/qL1KGZSPWLbR+aOBU4gXUZpB15dCIOsIRmf1H9P7rp6flP+widmrAfIqFjqy/x1elYId4bAw6kBQLvG0xxbdRf+5mDZHfi8DhiEYfgmujNVHl6Et3vy8CJlMsC43mtr5tIwqPk1dPUfJML01Qx7o2fQL4uhVtxxE2fJNIGPIeIuFsKfJI8VY/Uh7VPKHOG/gDAYo+YOF3QbCAhndxILBHLqESjl5dd8psdbNcFoxsqLvNi2Z94qpfoTaJ9RGdJQ5y84Bxe6YtUZNlZh2C2ICMYtlZX6E7562AosGc097XHjXc9l/ThEuKAvdvAqy1aF1rLBRZvVqKu1+SMvlrPQooaUXlIqCoI4W6ytJhpYMcP44gWs6bKwL4zQbVCxqZDYi2d+p3TlJLdsTdphKAI/d/7cCX6UDOdgEKwO+P+ScOVRrGdS40iYJ63jiYhIiEeY7LTcTcxhU2/1kW1cEngcEvi1oaojaHGAOVsQ/OVnbKGfy8fHBY3PjTf/fHuM91e3PvQ+7gYTFiYZ5eLx8QpszVd9jLPYywOoaI3eZWSe/uGpx3aBkCWnyyFcGX6Xj56UxkIiraZmBX93Ga4W10lkn1XjVGk50J1gRomIXjj2f8Y8ktLsIYxTpGNeiCLcleYDdZcsBlvJVRFfAhqe2Darxbp/GJyu/3zq4ohh5uzjhyRpCLv2zcHJFW1raF8WNckTPrPFKc08sxeI9fpWZMIlYODEFB3IX8e4KfhjzeJfKJO/m8Fgw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FFShvLqmuy0W+T/d/R4T7L6p3q4XQQJC0JGfkMN+o8dMtBa00wE/HDK7gfeYYanv4EZ/QLvZiDEEx/uSggBOmGShSQ1jI73wmewX+tRfF69yzzhTZoR855+wTt+GHKNLmlej9EvUH0hAc8N2sPUJgM/PPT9/wyGY8GUzbCr2tPeK6R6dydr4/iGf+YUp4k4GJ2Jf99t78atgPvJ8dmz6G0spTrsYNI1KTR2XFvS7KodrPTslWxzRLU5zOitA73RYgqyCOHxVuWo08EYTfojXz397DCXLvuwkL6rCpgqCV0tFzswfflB8OIAR9wz92d/prrfziyO+qIRGSkRK6iiG+ynvpLooqV/vgb0vkRtwyOsbKceQ7gpW4Cp1Sg0EDWntsivGnv55KlAflQ3k74yy1XOsiKiaOelwihPtC5EZmcdpmsxPsDmPzwD78FDvkdrF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:04:44.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6957fe-d5ed-4393-b8e2-08deaa961d53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997879
X-Rspamd-Queue-Id: DFB934CCB12
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
	TAGGED_FROM(0.00)[bounces-244097-lists,stable=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.927];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 4717a36f31ec ("arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier board Device Trees")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 46be6824dd16..e5d1b2ebf2c8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -504,6 +504,14 @@ &serdes_refclk {
 	bootph-all;
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
 	serdes0_usb_link: phy@0 {
 		reg = <0>;
@@ -512,6 +520,7 @@ serdes0_usb_link: phy@0 {
 		bootph-all;
 		cdns,num-lanes = <1>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 	};
 };
 
-- 
2.51.1


