Return-Path: <stable+bounces-244406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JNgNrlO+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:22:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5D4DC0D8
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31BF930DEE24
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE448C401;
	Wed,  6 May 2026 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LZmR2vtI"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702B480332;
	Wed,  6 May 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076604; cv=fail; b=PJcBDFUZepKUp20IBOQJ+rc4zVkybQsyRxBu9ywOgqOBN8BBKHyZwt+EzUR7gesXnWy8iVVe02X6C5CAxPxxR7ro0TQQ+TmIlcFPCYO5CmbGQPW4p2ECMXrH8SZQlkRr9PQnpXF4wKlbKShTGqIuytUmivkXAI9zK3io5yJpIUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076604; c=relaxed/simple;
	bh=YAkBGtWDaBhQXIlGKHAVLjH8yYxgShxHC/wSirKSQaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUKc7IW4gBHNZ35dC4QwkSckkuwO1/iPDkNoB2Ttb76AwB0vHJkcwEz0n0nzpobqEH+d8Xbpji0ZAu0J7JoA+QJcSgCFSMoJTXk3EbIDoFrkkKLOry99M4EibiXUJVwXPPPHDnLseS3K50dhmUfH4pU0sSu2UUfrG0SUDJemGMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LZmR2vtI; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwXno+GmE7lvwgZkD1P5DU50aUuKrVqGqw1znNtoyydTHECiFAJ5JnqwopQwBI9oEVm6DicpcxerM71Y62ZpRzWOguhZq/FfIG+hx8Zm0u9aouqCacHIZZdkx5zKqHa5k10xAd9D+Ks+pqbrVWpqZhbnLy8nTBOd4ycHoAmjvNr2tQK9dkEgtqIA77gQwocQFLLg5uHhLcoLOfbyQVyBqKFfWT7ao3YuvY8Pz/CIiOtf/cSy/ztY4WLE3r34ZvqG4WNK72/YvFCE30018Ki5OOdFgrH/BzlHfjr5q0cvW2tIgZ1O1ijzuU/90QI2EAhVTty5GP+F8ra11flCoEM1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlpY9EvJhc31Jv9oEVADrjrkVBSZqp9gca74S1uauhg=;
 b=HkBe/1gOM7+2l5YcAoCyzk9ZCH/68gUludiMLTz55cJpj3G6izh8ANDNp6ZgNI7ck8Z66j4YBhbD5droMYIpxMpDu07PevfeZRWNErrAbLAnUf+RtUyp/9x2vYHae8LBCZ9T4kJ0lGyANfzPZ+rHsldhFQLnZ8QU/ko81AgX9jZfwBiB6h/R3fSoPaD8bVOI1knywdoX+vgiLVK5JlDDa/yTxhAoNqHHvrGgl4w/FefumP9S9P+6rFtDt3oWg8UQHmRoScAnmkfANFZWTye+dWge1QRbWb+zYLw261nZum5n9o4+sdAOQBH7UJRacw/hqB3T6tjRozwQ27QnAkwYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlpY9EvJhc31Jv9oEVADrjrkVBSZqp9gca74S1uauhg=;
 b=LZmR2vtI10ERTVg3YYWegCDW7sKD5WOdklP0TCPQExpLRvEc+yJRPtMFtV+vl5hkNCdqFHBMvFsJg4YyDXcy59EzWyVdJbTwbBR9z6z4XwzZ1ZF5fm4gg1lxJtDqrShasYAIwPo+lS99eHVhNdvgA2qlMhExJG6yQVE+H2TXF+A=
Received: from CH0PR03CA0430.namprd03.prod.outlook.com (2603:10b6:610:10e::15)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:09:57 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::f) by CH0PR03CA0430.outlook.office365.com
 (2603:10b6:610:10e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:55 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:53 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 09:09:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 09:09:53 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IX01221395;
	Wed, 6 May 2026 09:09:46 -0500
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
Subject: [PATCH v2 13/13] arm64: dts: ti: k3-j784s4-j742s2-evm-common: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:45 +0530
Message-ID: <20260506141040.1368918-14-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SN4PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ed6956-8f72-4c8f-0695-08deab79267f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|82310400026|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	cs7ZRKeocyNH9qIWwkVExjqH3TLkUAbkuwn10SgEBeJ8qpS175NMRAFueExtqgasMiGxh1VJgTM56cm/NiShzs47IV0mktaM1qAcoJNmh6YUvxhiGEUmBcHVPpnX3jBocXtm+APu+UnvWO3L1LCdvejNi8siI91cKxshElQEucMWbcHQg6Zs4PBotx7NNo0JuBw4XVyxiwi5bS+HLKlJmjLRv2mopSAlu6HICXgC7ix+4zRwBLUTFtCPEsAdQKmnnHHkxL6paAXmDcYvlmzOpfn4LhfNjzxIQkevj+7i5L5VrV580SKf5rY5o595g46qiIjMhJAA4Q2IgFAuxAI8uR6mcWeu5QCSr8P+QonFo6bnp9gQdEAJs50ptPduAepPgGhDnPeqLx2EIHRnWm1JYn58Y7XI+CLeM6ORNP56ka9rkyU7j6QeLs0gCLVdQLNmCXgILykSqlsujeTuDji5nU4PuxhmcJ4ilQe6kiL59hw8izeyN26jHfkJl0qJKVMp4cd8MTVNhV0DpJU8yv5BGeqgMdWyymqZz/4peE2n0V7e/QHsHKcP3VG43Nau8arbjuhA5xrQgoriJdOsHpYnJFlWwcis0iccCojqu+8ari2O3V3HuIDD+Rn7U68I2FbsV8A5/3gmZhE7DN3/LS+11xGhPzyI+lub6jwTj+ww+JPoCHhPSHlTtz8iOSFNmG+dgH9HGYonorvnYWiyzaP1kkSZGDZtmEsXYMwANYZk8ktNrVNLh7JIcKNEjKAJR/vK8TNfC5p8sHshhii7toEXXvjg0WzzH8cSCGy8OQ+3vPw=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(82310400026)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e38lsA2wlns/39/4LMq9Km060A/90rDk28pavMU89Vu7USa2AWQTu3Gxuy2jv6gQvYSuwjR860rUO3mTkdgLbVjejz2EZyABiM+0/3vhgBdeEIxdaHhatkcM7+YLpqSb1Rp3SfdhbqALhW/BcXZfuxnz1yDbO3yGOulEjKzesuVlU4H99U0W91UMJQBUwQOOO0Fw5xfEcx61QA0SKUZFE4rPKed4+Q7f/tHxIr+X8x5orjsm263Yvrde6SU48oeIxncjxzjJRxjEPe6sgN3PxvK4ak+BMLVIBN8opkozsbfZch4pw3DpLeI1aP2lhuNKXNe4LlM9qd3QCVTORNo53U2e7CW6hRYCJ4Rl1oQZfg36VQSwLQhagu/ujWtTHx8NXl2YOsOZWgTyYZEgzH15zVLJlXxl3Abpn8/HKZcXhf7ppAog515v0nxrTqeXB7f0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:55.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed6956-8f72-4c8f-0695-08deab79267f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Rspamd-Queue-Id: 50D5D4DC0D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244406-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DBL_PROHIBIT(0.00)[0.0.0.3:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 39b623c05c46 ("arm64: dts: ti: Refactor J784s4-evm to a common file")
Fixes: bed97e94ee2d ("arm64: dts: ti: k3-j784s4-evm: Enable USB3 support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-14-s-vadapalli@ti.com/
Changes since v1:
- Reordered properties in serdes_wiz0 node to place status at the end.

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index ff3a85cbc524..43a74118e859 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -1010,11 +1010,17 @@ serdes0_usb_link: phy@3 {
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 		resets = <&serdes_wiz0 4>;
 	};
 };
 
 &serdes_wiz0 {
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 	status = "okay";
 };
 
-- 
2.51.1


