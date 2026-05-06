Return-Path: <stable+bounces-244398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOxFFW9N+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:17:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FB4DBF1A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 313523074C50
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FD480DF9;
	Wed,  6 May 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYTh3wlA"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E873E3C7D;
	Wed,  6 May 2026 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076553; cv=fail; b=rfaL+9WkCKRhY6Vtay91/t0xBJGKCnM/q20qTgpB/stu7bFhd/eOCSj6YyrbAeml8/78UZCj6zEsO9iJ1jGKnPt5o3VGIc6K4g947YpkqsUok6++RCkLqpBwT0bqjvAJEtjeygIl1pifQVKEVvLTs6JCuGt8Dv8WbG/cq6PyX8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076553; c=relaxed/simple;
	bh=joyFDJeKxj6oRu6eyImpk4qxWb1EKZRsnaJTlmpRL00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjmoODYGVYKLmgvHuqekfU/l0W7ltxNdEmyoLLEaEGRbFWQmrSsi2UtROh/bWKrLdXp5FuFZ2kWvfGyYJjbenV/2oUV9iLatzFTJiWOIDz0PICJXolKz2a/OJYm3+v0ieY7cVpkfKY7jfF3zCYWydF0BOYub/9l2mAxv3V6Op3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYTh3wlA; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTalOFQze60H4o5GsbSazjklCMjE16YGAXyYFEYvUiJP/yT7P7hobR973LXJbjoy8AZj1V+VlnU+/zvQwHHxMb2Ycf9iQml/ekOvHRZ1gflAS+Vky13WvnoXQ4tfc4EFHhbjoEigM7fU6HjFcS5B5xYKKzo4H1xLeAjemXMVCWp4dZuULAVK1dDb3aRyyoiW0R8GfSLi91qzzeLXo1d/wSR2psH5bFKTIopRQHocey7CH7yUKCztNbvJrzxqclT4lyn0Cttb3/OcfkqkiwE5lfr4gd9vPxHBmbtuddvj7vj4tb1pN0VwkwYMKkYdE8JOagdZGP3/sYqVeNtcW/aESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG7vAu+BupXGpEc4eD27QoP7UJjVAzairiyBqIaDfHA=;
 b=Kq+KBTJjhoFIqAHDYx40k30TAuJKF+mJZhEYrEk0sPZkj0U9wVXK92foeybCN0m0RDhPAfRavOTfYNit/O5xcsLULQ1f2sxHZX2gkIyAUtb6EQ35a2aHv80yTHALwHiJttyYL4D8/xb4MmF/z0oM1eo6GldMqoROWd8uK1vcGbeOF67DI6OyqWYuVb2OLHmpC1b/HesMya39FSlLTMBniRNrHEqdKVPOxcSRq7TnQMdK4pandCu2UjkmXjy2AluEVkzGfmc3yprkeMVcY0cvMhan8aOnCsU3QVvzMCUGhtbY/DYu/BqPUPDwg7USVq+SDvJ6wHPbaqwMMmbbQX+Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG7vAu+BupXGpEc4eD27QoP7UJjVAzairiyBqIaDfHA=;
 b=GYTh3wlAJ8Je8rQ8vFuYgqaRy8rb0D7YzcSG6JwPeDXlp7bWicZPUzo6wp1kFNAXrBQ6dqVjDwnvMioFN+4JLQ4Wayx64GDMbo3tjXdlFTp4qipH9CFFdcv6nN0EePte32dqmX72mDaKELV4VK14pPR3klmsTdjQf3aCSRN4AP4=
Received: from SA0PR11CA0167.namprd11.prod.outlook.com (2603:10b6:806:1bb::22)
 by SAVPR10MB997819.namprd10.prod.outlook.com (2603:10b6:806:4e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:09:09 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::c9) by SA0PR11CA0167.outlook.office365.com
 (2603:10b6:806:1bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:06 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:59 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:08:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:08:58 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWq1221395;
	Wed, 6 May 2026 09:08:52 -0500
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
Subject: [PATCH v2 05/13] arm64: dts: ti: k3-am68-phyboard-izar: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:37 +0530
Message-ID: <20260506141040.1368918-6-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SAVPR10MB997819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7282c6b3-62c7-4208-85a1-08deab790960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KUbyyChgflkqaEq8shu1Iy3hcULnWTQdad+qffzYpX5jg5L+5OD6XtsDozc7GUmqHYZtMhuPzwxuPiQKlMbjsfD0A9FGXBgve7ujlUlQMwfCl1DQq1u5m+08cetrTSgAP7e09+cbKP1WAnHS9PL4D9gU6/Flkz08XbpqPU9NadUWRTc1c+n4FBqCGgAl1P7J1vRd+j/IUOJgOVS42wQr00eVuxj2rRs8cu5+Q8fg7xmdernZfpL6xY0M/ZL2t993fze8A7ka62tbFdgCv1E1NlcfttrPMhb4mlbu5rpCwxy3XGTBxhR2p6VuBgaQKMumXiRhbzbPDrXU9fuNUjm1Od/6XwyCUngpO+N9J3rnsvOGbMCPRQXI1OkR9wIeuHpZq8vbDCi2c+Rb2Ap3ZcNQz4xAT8s/5DFKH6nZ0Hmo4Sihdvm7GHJE/HcWdtJiYGWg0lBU10boh9s9DcbxbA8CeFkc4pbFuy8naY8znJRh7GsxSw5/r7M+GTeleuKCvfiJ9npRXhdQClhDvYh6AKihIRDv4UYfNzYkLdx5pP/kUu1xwLP0nFVvaVRhbRkw7l2TYQCuMM4AVt6b+SKSdOBIhre1kICoz40JFrvbNuZvPmyJwooTimna3679dD7Skb/uA1vmAf+7iUIWsTUNEfQF2kwL+D4G5DvDg3FSHonbO/zy78IR8P3gW+BZg+j8RL7iF54lQPcTdszODxPnJuqK66pTABpyS/Sibhv+t18oBbBOOf5GMZj1wjqT4IAZMvaCeqnYZGWxAzDwzuc6LSnnrE5UbjiZu+FjtMb4VRgfYas=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l46aUBr9WgBETz+tArkn0uZY+EDMJr3F5FY+XWzUSGBsMo2wZRrPddEOiN2bJJW18Wf+OvD9Z4I235K8ah9Tsw9+F6UcUz21lgFxGx7yxYl63/SjAwRK1OZm2q1b09BndxKdS4hvz/LSXnJsrWh5UC9V05Aa3Khmy0wqblvVc53YcIqJ5oeqbIXWlG4Q21Ocrmz2/1UNCsR1qdxzWlMrOKUqd566q8bGJYtxk73wvXbgDWeYn3yp+fGLY5InzoQZeZ4N1EemappHAQy+Gemehcr8AZhLnAkEGG4+xWwyEM8wSoTxESeiDJGqRCTi9b87JNcOmvD5dwgsrfpZXZ4Qc3HzXhLo78//t/+WloPNVEmxE4o/2Jq9GhDx2u9nkfZLltmlhUxB6Sc7H9WlahhAjMShchTvzC4A9RprqJpQ6V8LxRjyAprOoB/xbzNti/Tt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:06.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7282c6b3-62c7-4208-85a1-08deab790960
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR10MB997819
X-Rspamd-Queue-Id: ED8FB4DBF1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.1:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 8bc3b1c86452 ("arm64: dts: ti: Add basic support for phyBOARD-Izar-AM68x")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-6-s-vadapalli@ti.com/
No changes since v1.

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


