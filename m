Return-Path: <stable+bounces-244394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLCrCl5N+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:17:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC74DBF09
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2BF30C4084
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5747DFB9;
	Wed,  6 May 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VMCmfuP9"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034846AEE4;
	Wed,  6 May 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076523; cv=fail; b=q+Zkzz6f6/UV+2BlSo7ukl5qQkqNJuQC91GqHF+Jg+WFRvDN0R8bGAzoHwljXNOVWz6af6D0c/OxGIaj8+Qwd1SV8UP+tngNybaJOvUyg9rZwHLw9/Gubw1X0bsu5yLyNV9Ehk5RnPCWLPa95F1jPjCSoW+3GyPkZRdaRsjaHnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076523; c=relaxed/simple;
	bh=fVgqg0TX+L1zR/BCxBusvFFRDO52Xj8N9qIUVhRSOhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmxUbNvmzOn+anWa7MRju6bKnxddpQkeUu4qyAT5WclyQpLuKLlHf58SkqkPQ536DGfaEvoBIMStVltTjb5Rw/GroccM1NKFJk6JA2VKUavZhc219vwsikOpFVWDGn0XutfCguphZqiOblOFRYZ4rPPV64NRYZXIOtxGwCD9lVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VMCmfuP9; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4j5mp+bGOIyduhuoCmY739EhoqaE7F/tZZ7TZhyImhCGkTCSKJ38zgrNJs+WrgFWZkGCNw34VV9LB7L5oGXLeOC4LJB8HTR5fXuTC500zj5ZZhNvaw8csiOlWkBEsQkg3SiS2GhuKAC86VT3Qy8urPu51lKd76/p7xbU7mcAd+j7RkqGb8yBI81HIvfM9uu5UulgFFVXNmluAw2n8ibogQ4O4ce3qEux4rwR6M+9MFXuGHSQJJkRAOKKzKznadmpDkIFO6j47PbsalqjJ++O4ocEciBjDbnJbnd8a7Ww5inSemXqE864Hii+TPDTAc5FeD+3HIKzzksRPMYkBKRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW/1TkLYgr5XIE7num5dj3NAKJ9Yh/bWgbju0gAjnHY=;
 b=ngV8vbpKupNBQyu/Y5dLatDrYh1V+rOJ1uz7c34NyCtpoWATvB3D/GxaU0RQZglp8CC9kK6+aDf5PkKlfLBrf4DUtJINGMwdK2WejOEXy0LyOozc9EE50dwXQl4iaSG/Jc7d/v0r7O6dVJ99zWjkEHudMSuJOAooG/Isz017X23xaAvE2khOb07M3uyrulFJUK7TcTMXtQoJnjTPYgcGvjkmyiEgm/vn50RwOP7b88V2eBUrUCjSy5hIUN5aKMn2J72PzAbeuXtWbS1vXXT4ep533xoVoW/Ufd9AW3UE1W6YZ7bavLsQ/B1C6B2lzVDXR3OBx+KaePIYIdU5GWX+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/1TkLYgr5XIE7num5dj3NAKJ9Yh/bWgbju0gAjnHY=;
 b=VMCmfuP9moyGGGR+buMrRM/ya69/hPgfBz0E2/jnagadmskBK4XpdK+3+y+vF5uAOnUUvPA2Ads10Z0HLUYhBgYqXR4EXQSixGvvWF7a/lwTG7hFa70A6g4LUfwkfn8lx6E98YV31q326dAp0Fo+1sC8L0m16G4vB/Z9wfWTKjU=
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by PH3PPFBE2296547.namprd10.prod.outlook.com (2603:10b6:518:1::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:08:38 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::41) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:08:36 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:32 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:08:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:08:32 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWm1221395;
	Wed, 6 May 2026 09:08:25 -0500
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
Subject: [PATCH v2 01/13] arm64: dts: ti: k3-am642-hummingboard-t: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:33 +0530
Message-ID: <20260506141040.1368918-2-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH3PPFBE2296547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aef3cd8-f864-4ae5-74b3-08deab78f71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2VV00E4IPmJ4rEyYKmyR7xcwqYQ4U/327+XzjYBlgFN2WJnmapcf3hbdFcJTYj2WEWRtVIAaiDS+1kTkSxkDH8Hnzlwtttg5LJmXL9MY+6UNh8QlGQTBmySe/N1zkmYoF+ExhlJt3kTrhrBrvQnp5UjnUWp1jwk78Kej8ENExmdAxcrnlvdKfQp3915ra+y9PmpQTvH0FibkXaaaYIaTql3HSMuNXOZNyUJeHFf9bEn5Zl7Sr/i2B2Bno9kwy+FDB3ZUG53IMDs5qWxxf2/qV6GEb1bWHu1km5tXJHlOTJN/6nXPW78I9phieqZvnFD2vilcehAMy6q6x1RQiajWx6kIxB8nhAC/5w0fdyKGmY5gY8uWMvxl9JESt80AWGxv9ylAB+VnqXOCO4CuCjTg3vpGJ0iXJSEEKbYEKztoGl9Q5YA1Ik0SBW26MPtJufZk1suD0dCA1j9gatkmwpzS5yu8cf0CQBLCHKBkQlIjdyjQZ9BvhMwYYLwxVmibyP9rFBrb/cx0xA9UIx6b72EfClYwYRtvsoobp3ajMOHTlTbTrG+A+RrzDP6+GXiFF9kdMEEHvCPbDpAMiO4axEwUkQcOzGVpF5/7si7tUfSuClxiV6naE6oK/LJXNAdN1x2oV2IEzEPD58kdekSAWxagEiizW94aKUIUHexYALsfGB1S8bRL2/zDWzoW6c6+ev0TPdKrg4o54qAS3OQSn7SUPonXw5pE8YUuaXij7pmvq9UcJenVQvzSRuVTSfzD9D1tWnoQL/L99oqZ6EX/r/Zy1yLQaxkjIOL4vIRK0CI0DW4=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HeCthE1K3VvV4m7voowzGQsI+IJoIlD2tyJvdrWCPa0fc3RLE4BELDCQ5LBkbzwlJ8URYlzyIG/4MegG7BCYMp0r1zkQt4xMOeAlTHr/WIfED2MhkTG6OLVoIY06oeD8f+9wTejlbH99PD+2fp4QxZFbKQk/4S1icCrQq9CXN16VbI2/SH7VPnozscD1uZhZcKjoE6Vjy+9hPoobAX9gJy0/e4HOC+e8caIJO3mt9mJ5ESDkWHWEbx888vVSPWO0flpI17PWuUwWDYeZxPfqtc+qDhsqFopC3IZ0twhcas42ChYjKzyO+z8jwLy4nAXswQvU478D3hK9lLyiJId/lGQwDoulIsVuzh7cuoxmwnnKsx8ESId/vzSMxMdSkZoYGWbL9hphs99vDFwjVec7TPZo1AZZU4WjxyeBxgj8iW2vDJQzuR8THcO2HMr3QgRt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:08:36.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aef3cd8-f864-4ae5-74b3-08deab78f71e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBE2296547
X-Rspamd-Queue-Id: 5EBC74DBF09
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
	TAGGED_FROM(0.00)[bounces-244394-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email,0.0.0.0:email];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.881];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: e2b691804319 ("arm64: dts: ti: k3-am642-hummingboard-t: Convert overlay to board dts")
Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Josua Mayer <josua@solid-run.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-2-s-vadapalli@ti.com/
Changes since v1:
- Collected Acked-by tag.

 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
index ee9bd618f370..90a158531f60 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
@@ -15,6 +15,14 @@ / {
 	model = "SolidRun AM642 HummingBoard-T with USB-3.1 Gen 1";
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
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -23,6 +31,7 @@ serdes0_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		#phy-cells = <0>;
 		resets = <&serdes_wiz0 1>;
 	};
-- 
2.51.1


