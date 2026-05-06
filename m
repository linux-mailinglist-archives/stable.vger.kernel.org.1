Return-Path: <stable+bounces-244399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGWaI79N+2nWYwMAu9opvQ
	(envelope-from <stable+bounces-244399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:18:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF294DBF7E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC593107FF9
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684F48125C;
	Wed,  6 May 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ibk17i85"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFA48122F;
	Wed,  6 May 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076556; cv=fail; b=G/SYFxP+RTg3PZTQviimj3VBfbw0Kq4amDQPFrYXwrnr2EHWG9ATFAa95lTMudKqqXaFNg3e4bOQxI7Uc4561BWMfaUdmn5iBSk0PWwqGCL1nWvsjSO1l5+BmNF6R762C7Q9hzLDNAx7KGRwLbrV66vpmE/19hsSxwBCVp9kVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076556; c=relaxed/simple;
	bh=kcAY5FWdUyudlfVrRPMRCTsD4ClgI71Y6/GCSLV9dAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJ3FcaljHmTg8U7CJ9E4GWb9hHtzy2wzDGdZBnlg6v3saFFrH1X1FagStee9ajF39R8Y+enVvNciKO3CQ5CbiF/U6+cNBEJHJEWnrOwfV0SkdRinD3W0MLYb7/IkafyvxWvFvWY6chdrhKyigbcEHOf0Gjst0qeEdi2w9DJ3Zyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ibk17i85; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxG7Gsq/hv4gDMUFVVp/l/CpFY1MXn5w/KI5SeWir4XRpeY00yTr61tkMiMyYIMulPIjJ4nq4Tqkl9ga3OYlxVheVJepHXYbQqN81jrOj9jvNr+J70GiJ+zuNq3L+iodKjokHPMfPaCwlE3xD7yivIDVyVgur/PofoGspBXr1H7Mqp0j6M02jE8t9cPjm6s5EhNm4Q2f+myCfEkaVLLCyfeHL/tUrYvyZPcWZzwYi2DyRpZCPspT4OKu3xT7Vo4z0Ktu9nVFE8FiAt/Z8yXGHUQHP9mhD0X1wxjLEsvkOL12srFD5GV+oE4he87qgvgW9K5Mh6Izy/HzlTZ2Ip7deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tMacfCHTLjhTUHmlyeFMaJm5hvn2qD5WagdQJM+8vc=;
 b=lS1wQD8S+SjIZDxO7z7HFsFhM632USk5BzJ2BzW48iZlzhqYuquObCfWdy8ORoWFrCZ+PqqNi5ge1ey36mw99df1xxrtSiCHEnVUmfcs6QinqJYEOiP5EC1NP5Vut20W2Zc6SxR8dm6iDAmo6AIuiFYbZ3kKGohTNNUv2eaNSkW72xFb2aXLf7/kwyTAmKwkd3aLNon3TZY9+Gc4PKmg/Wg7i+WHZKgdex8BNgOKmdW+iVobwqLBX9AWqIX23zjapJ1IeqSNV5kO7O0DDhrbM22I/f/M6fgrn3c7kOnRImwxofHDIX0G+TTU/xght1cvVMaWwYOW2L8dsueE2c4TJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tMacfCHTLjhTUHmlyeFMaJm5hvn2qD5WagdQJM+8vc=;
 b=Ibk17i85LLq4QCoM3OKyY1yTUxxtYCOtNT6qOMec0jktDeC7z4mYEhCRtjyaxdbowlD8muGE7bh2eMR6xKO9cQ8LSSkV4bVe3xx7pLTnjOvhg9Zj8QBjq5FBCSIfpXTi0IcGw/00NFXICluYUP++x5mtUL89JY2GjhUfmRKExg4=
Received: from SA0PR11CA0180.namprd11.prod.outlook.com (2603:10b6:806:1bb::35)
 by LV8PR10MB7966.namprd10.prod.outlook.com (2603:10b6:408:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 14:09:11 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::57) by SA0PR11CA0180.outlook.office365.com
 (2603:10b6:806:1bb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:09:09 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:06 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:09:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:09:05 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWr1221395;
	Wed, 6 May 2026 09:08:59 -0500
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
Subject: [PATCH v2 06/13] arm64: dts: ti: k3-am68-sk-baseboard: fix USB clocking for compliance
Date: Wed, 6 May 2026 19:39:38 +0530
Message-ID: <20260506141040.1368918-7-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV8PR10MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce9aaac-dfbe-4382-59fd-08deab790ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	o5LnW8H1iuLwOcKz/mw9Nk6LzlUlWcXXh5V/OA4bVjGLSxEoe9fGYjZGBzVbm7f3rHWvdii2e58tTPu3UGchPpoxtiEYU1gfzwW7hqMvIf/Q7tHM41L8eCtj7IdnGQN6afkAgeNfnyrymAziqjUFlUpCL20WiueJ1hwYQhVoycSo0ERUL4WDtQy/brIHD+0DA7DZU0rKdS7QCi5Qp2qJIKsk3JxMlHQdMF46SEv/85PAOT4tVizYHPGFgx6NxHcUvguxd0NeSzsCaanv9lCOgMjZFoaarzav8kYLFxZ+ZLP24+UoikK5fkaKxcxJ+pZds4FMwXJpw1iceKfxQkE9wsSGbxCN8eCCi++LhZ5zeE3pg5BhrUoYWmBY5TDIPn7l6nfZ7r9ev0DrxMML5lavMxoaDHenIhMwPniiPH+prki8z/KIQvSEn+soRpGE1Hkl4/Q50zYExRMbmZjKpTX4nNlnEfjmkKkPMexoZapu2C6NpRfcVdNaQJufCLZFm9QHPpfQCtu5ZjEQfgwN05ScPb107mxY/tmLmIY3HXRpiF91O72LpyhgE8Q4bn0jEQAJ7LphRZDf5czikObW86xg6TzRO32ZNTl3oOUnh/6bOSdjB6JO6fK7Ev91eJBaclOPn4kgzhoqaTzZDljpTSV9a+iHPWpuAXcscoaTpy+kudkpRKr7oG3qr1pkWPQUZnExNoWCzT2k/vBkxxoJSL+wEz6VvsxITjOHEG0wK/Bd5hieRyiTFs2h3apb78J4j2oA/2AtQxIq4W71VjvWk5bHCVsp1OAcd4r5PX2vFLJpyFM=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q+5r27uFsmuJk2L+e3YvLNE+ZEtCf2PdkfQ4a2DMsBIproczru06HMzRm+3LIzLezAda1Y9CMVR8cJ23KnwMypnN5aXo8jvVpDdJqfzeftv9n6qnzhGsxEfpXU18ddry0SrCGOsE8OL20UN2tqqUoCnmfpnbic3SH8tlMrPsdYo89bBD3PlnlPfII181MuL0//h7kmXORbyr6PDO/VcgOCB7IOIqQHz0NfsyYw+bILng2c5aZzF+P2VFuvbWYj5ksJQ0iYjxYRlHqTMFCxEKOYG4CDjsUjTmMiemER7+wvPkrigsa5Oq03jmpRugjDJQPcL1xJnkD70k/idcKMKAFQpr+b9iLpWPEARnQQpa/2BTndeuPJ0PkXtB7VCmWELOonmFpmnm5gdfDg4HdM1kChAMN5s3ffGmtCM3CXUngLtjbcr0YEN7IvLCcQ/J4WYz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:09:09.4346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce9aaac-dfbe-4382-59fd-08deab790ae1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7966
X-Rspamd-Queue-Id: CBF294DBF7E
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
	TAGGED_FROM(0.00)[bounces-244399-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.2:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 067878e6cd25 ("arm64: dts: ti: k3-am68-sk: Add DT node for USB")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20260505110631.1144200-7-s-vadapalli@ti.com/
No changes since v1.

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


