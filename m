Return-Path: <stable+bounces-244100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD70Cn7S+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:20:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 449404CC73D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8CDC307CE53
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6441B361;
	Tue,  5 May 2026 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q7skuPfn"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C83407581;
	Tue,  5 May 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979110; cv=fail; b=kOZljLiikHw+YMwjzcFiHQk9v61ulpmbo80m5ERAhcglBoB7jzXXrZaScVA8B3Q0v2/FJlwbEqWyKCe1x1QDiyaMo2fc1GEDien+He8Cez/smX7J99v9S1Eu+29Y0AoHs2dxIMgiojrdvd2XTGvpQYA7A3wU4kwos1y7kd0L88s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979110; c=relaxed/simple;
	bh=y08yDLSWXzIyVSg2NH+9Se5SVPHHdhvXnoJAakxDr20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcOf3amUkAmfJzFXiJuPKutw40exh5BCOICUtalRj9W5uyK9G0hfsvP1SMkrqMTwVtb+R7BmWC/Dki8e/uJh/dwj5MIMMe3BLMCIyCWdqQ370bG5fGWQdaRlmH8qzAPjMO+NcDiAi+CDmelqS8JOFMg/EGhXWbhhljkmYl6EdNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q7skuPfn; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g68cbR/fFVCQbyAEDbBM1JEmGbhvLTRCzQ6hwj1cgF6R9w+m9J+aGovF8vmjWxIOh+Y6/udaoADfivWMJdo8ql9woUk7m1I8+Uco1kSfRjB8ntMoQ+17VbGH4HjevkfM7SM6q47ygAJixxCJ4SKoKobNWwDLkIg4SreGz0LpAZG3hebyYNTq9K/7arCQ6aTIvU4TUx7Y2aQsub6rkyT/5jT2HBsrjAARbOP+Z+YxmIyAb31sGWzk67wky8KtWkwMD57LAJtPD3GI68672i1b1tE+hm9ACwdZ5Bi2vRn911VpI6aLigQGj9DrECjP6UCJhxcDsSvwf7A6UMro61xfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyYy1o8R9oQHaT/NExG5bp7ZcJj/miWnDRe15o8VAMw=;
 b=dKdqFnvKW9KXZrE4+18j6csGWKilCesrAOPpUsqcVCN9B4iByFEV3aCdYTELah6K+m7udyivJniMcScxRh71Wq3GIavoio2c2quqS946ajFzlxrbDqyMR5N82jiRGDU+eplUxw1dIdTLDusBBjTKQY+shWlUMzC+4jQco5S1Qc8kBw9hz1RIB0p027A3KoU7Ixwrnc0ilkgihAvZbORfy8h6/bXD8wcW7AgwieGIlfRtoeZg9CAtCutnn8/UvijaLyKdbzbFvGVHI2LW1tOoh5PWcxnanNOzd8f7df6mKzRzlMLYlGVGg/Mb6Ztgygg62gar/SJzVbfYkXAeE85Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyYy1o8R9oQHaT/NExG5bp7ZcJj/miWnDRe15o8VAMw=;
 b=Q7skuPfnmFPIaS86KgBQSAAwyx5AoneWVm5Z0Uo8Qt7BFbSQgd5ntF66tNEqFggaBYHvrgYP695rYTWvOB8S6VKfWe6BuCvwCypqb1zEy5+Hth64z5uLLje2EYB4Iy2MdDReEpuKp40q0EEmAQd6nfJMpnYJv9hRy0j7jMWIPEM=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by PH7PR10MB7839.namprd10.prod.outlook.com (2603:10b6:510:2ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:05:06 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::6a) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 11:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 11:05:06 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:04 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 06:05:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 06:05:04 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645B49h62831834;
	Tue, 5 May 2026 06:04:57 -0500
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
Subject: [PATCH 07/13] arm64: dts: ti: k3-am69-aquila: fix USB clocking for compliance
Date: Tue, 5 May 2026 16:36:08 +0530
Message-ID: <20260505110631.1144200-8-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|PH7PR10MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c19962-304d-4bb2-28e3-08deaa962a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R3j+TNWWGEBupjS+xprIUrXRpoo4DSS72YR6imhlwtC5452zukfqk1Moiu6jt5MLKwB2wHodZE4zOQJKyl2BMvY+W7utlbbgn0cFcMVHCRnQSrtDeIACUDf5VZaH7uFztBxa0cEFI9HcqcxNLoeyKW9R4zMHWmn7efWJfkS6dFqOlt303ts0urromRA5bTkAclvBVQJkoEoF1Z93LsJApTpAchTtZAGREO8S75dAnbgKkNZwzY0+nq5w5OYp47lmRyw7NMHKRvOd+avCS5nA21zlp4J41RJ7A0jtkBva1zFGMkpN/ctJOWQ1v4SLbkLJCl+W30L53j2azDCUE2UfPgqU5Bdq3o2hjtnEEjhA9Kq/o2J5wmrq+2fJzp4sYc9imFrxglS6RHFpMT8neOqmzacGLbKTZ7CCfQFAnEwASVxe6vwe+zczSWItxspuLxm6heUloKUVbHLWjHP/r4WaGVHyYYx3aLqAs79FBm6XECRQxb3D/6udxvk3l49YJwpCkxkXj0G2h3lZaGQbU8FHRrWBEHnWjGWP+euof/Yvv3zDv6Rpw60k5hUotNuXbS2v0/Svs2uPl0zkcHuFB1gA+i8AEChzxTBGJkdC8rNjzlnjFuG3KYFSQGB6pgAPlMqE52XlxpTBH6E40pDgXUpnbO308gJk6De81rK9Hd66bVfKagvRAlU9S+cfhtm4D1p0L43gH9HvsWuyHXSyqLtfCfa9lnyIXr6B+9AqeATfgwPmab/9MLNV9qBo49f7ydZyqqv7xBA7mlIOMVTchSOACQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F3xGOb61D80nxQdajQvqLKt6Zxm5iWOuno5hFoc5bg0KggHXu8wsaF3bP2ViUHprcTk30Ixf5XW+W8HNptbIRkI0+5QN3dm0W9CWSnIYCUOXi33de2N9+z+q8PaqDM1tA848n9DZZ+pPdl0MjtnIgAesuCn4y3aF59gXdZSX79CVP3fQNTWAIdCa3egL4W3lB91KO/befO59uhp+IeCFlHtEbRS1HmRqAXZ0x4PRLbIekDsfWAEzve4jOIdWKm/Cld2btZy+NvW23esTcjQ4XgPWyk4LtXFCA7/DMv5IK8RukHJ/7Mt5XVjh+5qvkbVbOOUEYxhgwcvH2sAcfQf3apTtYfZjDIR6SHtv55qdr5s4rRXoZQQAsedxND8O0QLFer6ClS8PIF7jYS1LZI4MQOyUgVYFxmFLuTbRenI7GqsALOIrQXh2vPjd2Ert1QGN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:05:06.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c19962-304d-4bb2-28e3-08deaa962a32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7839
X-Rspamd-Queue-Id: 449404CC73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244100-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.3:email,ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
the USB 3.2 Specification, SSC should be enabled by default. This protects
against EMI violations. Hence, enable internal SSC for USB SuperSpeed.

Fixes: 39ac6623b1d8 ("arm64: dts: ti: Add Aquila AM69 Support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
index 5119baf62a4c..7c98ee81ccb5 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
@@ -1423,6 +1423,7 @@ serdes0_usb0_ss_link: phy@3 {
 		resets = <&serdes_wiz0 4>;
 		cdns,num-lanes = <1>;
 		cdns,phy-type = <PHY_TYPE_USB3>;
+		cdns,ssc-mode = <2>; /* 2 for internal SSC */
 	};
 };
 
@@ -1502,6 +1503,11 @@ &serdes_ln_ctrl {
 
 &serdes_wiz0 {
 	status = "okay";
+	ti,core-clk-sel = <1>;  /* Select internal reference clock */
+	ti,ssc-enable; /* Enable SSC */
+	ti,ssc-type = <1>; /* 1 for Downspread */
+	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
+	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
 };
 
 &serdes_wiz1 {
-- 
2.51.1


