Return-Path: <stable+bounces-244400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDZXFQ1O+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:19:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBB4DBFF8
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC56F307D5C7
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7769481669;
	Wed,  6 May 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h+uhXZq7"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8C481647;
	Wed,  6 May 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076558; cv=fail; b=HVdD4LZG9Q4jAOzY20ArTb1ZmSDK7ruTiTz4lVlM8xx961z6uJLMQji3db9i2XDMzxgfmhMK5eOPkp5sLBFOPV5oKRq5T++BqIbVZKcHf8OAm/QhA7C4+pzEthg73T3D11wOyjnbWXwXX/84JndZq2ZpaJSylypc34cEnKn4sDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076558; c=relaxed/simple;
	bh=artRRYH+Jf4/EiCZX7VVyl2BCWcEQ9tMap9kbEGEzl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L36D+6VG93M/4YTXnj/hN5EDKOlIMmJrSnubMFE4N40sWQ5nLMEm04gK2uIUhMdVOV29f95NdM+JzGGhthzlazSb7V7WsjWXhE+OEg3FVRELts185mR0g2HScpbrYcle/SwmZSF7ICrD1NwqoCawelFpO9eW7qULS6+yBLon89Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h+uhXZq7; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQTpcD50uLGFVTO3QQzHywsJpxlg8IzevfUgKsR708GsNwBv7zHP1GshgiA8jktb5FAkXDqwNaPfx3G4XI4Ww+VvYGm7AbsVVlzGez53hJWCtrF+KwpRtpllPXlMvDa3CJpmiSktIBuk5GVlQl6mXEN/W19cSle4l/DO4jX7VDFM7JBkeEwd8415lNVPHyV6gvfwpfETBaCidUdRWMQx50AH67dtXv1LVxENjdtyhC/2FkukfbXa99kcGVyOn7HKUxjHsxwjuNKqOn8CXwKVSLM8PLUku1/1YhNkDL4cePUEPMkRdOLXXQireZjKHLEOgvP9zG8J66v2yv+IZsaNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsPtpokJjeQtOjNs0PPBckEef/JByEKg22KHbbbffyg=;
 b=Pe0gDJpLeK9Uf6S2mJiTL9cz5k4txosU0tcx2xuzsnv/DEU7516gi8NERj4RRr8411tbCS5N3wqPtUxFWK9oWVmK3vQk4IhSob4UkVprRyyenKyXOQtIMk7wIDsr4ddNf1dm88Gyxm660lW0PVBm9R9KzP4ajzUTsF4oshbGXlPv2MbHaM1ATg59vYvS5BhLgq+CG6LzGR6Xo03SQ8l4rE8iCZpfiE9pdLnXqIPSOB5gzu9tJPwwqUJ3REhqDOK3yo2w6hDlp6g9kmw6zEpSEbH/p336mOvw8spAk/hDADwQMlEbBhng8MS/JCEo3qG/jYW1di2q2QXEsaXCSubFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsPtpokJjeQtOjNs0PPBckEef/JByEKg22KHbbbffyg=;
 b=h+uhXZq7VMAckrLkeXXoHVFKHaaiMoWB4OsdeFRIIN8HotfTP9MmXJfj7fMSjdb4TGWGc83iKH+ODm/Ow1YwSdzD59x/i7WmEUQk2eAv/t4PAIDxqUnUwkctgJEIbG/jexN+BoD/K3L/jXCm6f6oXkjYoAUxpD12QrdDTFD3Vrw=
Received: from BL1PR13CA0399.namprd13.prod.outlook.com (2603:10b6:208:2c2::14)
 by IA1PR10MB7116.namprd10.prod.outlook.com (2603:10b6:208:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 14:09:14 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d7) by BL1PR13CA0399.outlook.office365.com
 (2603:10b6:208:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:13 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:12 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:09:12 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWs1221395;
	Wed, 6 May 2026 09:09:06 -0500
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
Subject: [PATCH v2 07/13] arm64: dts: ti: k3-am69-aquila: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:39 +0530
Message-ID: <20260506141040.1368918-8-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR10MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a4c4e0-08f3-4ec7-83a2-08deab790d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KChCdl8pR0YB2xgEdR4XZSCgkF8EHGOCsoEKu1ueKluYvxYsrYqb++xs4VnDwoFTlCgRWgMiMK7Eh+eYdNcqIZpzCq6Z3MoBknHfAlYuMtpNMaYavOHh9rFHvOol93T9xwEeino87y2iJU6i8IWKlxfaFvCFD0xIqiZxOMBdz2H4Il2vzCccy8dS/sBKi9jiYSQzSVpIFx93aaTObCTd1tgyYl5j3p5hYPIYIHi8ANiVdZLsQHDVwaX4r/uHlHiYdTYxoWSdG1cfkfKjgaHaaDIeftBVayAHLz2u4oQlk1G0RmOxsxmPNL+Zx+6WIPo6RE51HoD+Rect3Q1QiEueLDTPqxdxsc2I4S13/marmghmuKJErUXQ0a6ZGsciOMPSxQNh9sbVDSLMdLvZgxEWiHuCHUW5aNJ8TJGOoRf36+qyVd8k3EqRdzhfP6nxKMDQJmF3CXd2NQqpdlb/mWTqJqJ5OrP/ZgjrkRoHdfSTjckqwJF9nIkgzSH6aZ7aqq+TQ8x6/7CVotYAYWvD4IyNiQ33KwYl9eeioJHuvCEmOJVnMgKO6lbvOUY3MqQjKVJAt1Gt9zMEvwlPUAwK5mWbWQoPciT/tpg3KpeDjpkpoRKyCkkk3XWvHHfYeBDt46sRb2Dyr1JCeBe7NpmZSMh3xb1xbZflrV5qsNZ9hh5y8gNjp+FVe24d75u7xNjbnUoDDLq7Ht4RXZ48chQPjqgj1HudLFQgq26qg+PX56u12HYG3NDAZVDne7MAcjZEqnlPBnUk/+WuV4Kvc3kdYpKE+hX2/RAzWAQhGx/H5TrGhc4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kkNY0tknsP29a6mPD23ueNJstUZ0eLSGWP+n+LcZ8EtKYu/T8dBp54T8b3y+OP3qH7lq1tL3ly8nE8OLYQIgQ1BSZeVbW/kRNhIzXFjtdQfZWQMH6vpmfp9fVTcSW7VyeBvmMUJytmxyHPyJIifhsakFxqYjwERpa6kX2gDXK8+Bq4mf0/CXZ3ahYu6mRo62Rw6mt/QJPE22dbfB8bXOEH5yxUNacxzV5JWldqslSJDfAeRsEbMwCfUotaCV7DF1NReBQQikpZ2k+imsBYFhq2SPTuqqs4wdP/ZzX3oLqrHxZzwMc5k6eqmKxzCOmkCytYNQvGaM5lL/CrCJG2nJh7TUPkrPcC+TdVXdKyMB8FsQRhANL7ZO/E2hKB/4BOXU4opiepT1PGSYdZgZJOgO/+iCuCl49o82SqxEeLjhmq5pTUEie/oGjp254QUOCBOk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:13.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a4c4e0-08f3-4ec7-83a2-08deab790d3f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7116
X-Rspamd-Queue-Id: 54CBB4DBFF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244400-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DBL_PROHIBIT(0.00)[0.0.0.3:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 39ac6623b1d8 ("arm64: dts: ti: Add Aquila AM69 Support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-8-s-vadapalli@ti.com/
Changes since v1:
- Reordered properties in serdes_wiz0 node to place status at the end.

 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
index 5119baf62a4c..a5228a7d8339 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
@@ -1423,6 +1423,7 @@ serdes0_usb0_ss_link: phy@3 {
 		resets = <&serdes_wiz0 4>;
 		cdns,num-lanes = <1>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 	};
 };
 
@@ -1501,6 +1502,11 @@ &serdes_ln_ctrl {
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


