Return-Path: <stable+bounces-244393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FcTBmdL+2mYYwMAu9opvQ
	(envelope-from <stable+bounces-244393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:08:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6804DBBC8
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44C973014535
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB847DFA6;
	Wed,  6 May 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g4XQ0UEf"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA060317177;
	Wed,  6 May 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076514; cv=fail; b=eLIaq/xugDX7wQf446ydJsyh/Rz64vcIpIWDXQsQNcwh9ciwok+x5OWtRzxrnQDUy//WyXwLGuP7mFtEOKxOMkKyxCxzYAe+gS+Q4+3sePAyWE0Mq8Z/SKpM8wY8y/FkUCzAgOksA/6Z48ACvwgvF0hhnBrUoPJJeVoV0nVgrx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076514; c=relaxed/simple;
	bh=ayBoWTgTZvW1j9ft2tZae5GhAKFQLyzfkvmlJJA5Oow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LhVJOpyEQGxtHLB09DVo2MD+VUEhxmqezl3QLSPP1iZW3mwWXTMKx1OXmoFz6EqrvY3H/83q6z3UqfG4hbbL0LVr33wx+Aun19OzDkM3NpezNWzJVX8GpBKxaidtCK1BMvieq2Ssj2soTTaE2bMRRhFLcAI+VlGzDZUOC1ldEBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g4XQ0UEf; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeP/5aQLo+xUMKRCrg73lOVxxZuSd+Af+YIRc29UCrbIonIoQgULz1y3cWOPGFqsrSqG/vyNqsETbMyk0k+g8ysfr726dNj2vSyhoRYBAh8BM8UWcQqgT/y4MKoAgxsls0cuWN1rVqCjkGqOi4XEjTuzJvSVZO/HuTR8Lmrwa/SDXz3kzHafb3cU3hRRKf6EXnLN8VK93yQLpLAIRuKntd1jlCR7PWebrtGmBGOAIgChmhrHv8LqoUP+4BBwGO+RkUc7capfWL+73gVSLzO298+wzgTxHeicY5WfYTIn0UKn1yaO3m4DSdkUPs2/bd0Q+pxV/ti5fvJZl49BG+kOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh3tn4POvhesUevZz6lcpZUxiElWwOWCSC80fCULLbY=;
 b=w0t4xsopbVZEgAZJNd4+/Z4M2Y37PJkUJdT3tGlQh7gN790CFWPWpmhTXt446gsBnjOCcvlmDn6MjVGLpioEVZ32HZMMq6p/FKwusilAKFQ5DpPwgy8NmP7x6Gkm30srVOi8rtxjGBiT/Wz3puktVhri/PO/q4tRoVgF53zoChFa5CwbJd007YhUGgqbKvIWT9vASVn8rgTkvvrTmkZ8m/l/B2AkF58SmCsrrmt0DxOqjHXxcCJ8TMcJvPUN5KLsPGv5hucrJg+vbgPq6KNdJlPgIDQFIWa/T4k457aigttd4OYzwzFk3o18gbK1E0RkKYnnH4uQPOVWiZuKIgjAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh3tn4POvhesUevZz6lcpZUxiElWwOWCSC80fCULLbY=;
 b=g4XQ0UEfjboMOSOUtQ1iu6KWK6wE/6np5bz+N+vptes+NZqvDMB77q9Y7f060piBQAGoC+86Ny86+CMp5xroP9RLhw4l0VS950JHM/vxy2Mg83FJ0EhOAfo4w+ESrQbticVlP+X6MrJGNOFrTWPw59Qc+Mu9WpR5QBRNNo+QOwI=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:08:28 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::1b) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 14:08:27 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:25 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 09:08:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 09:08:25 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 646E8IWl1221395;
	Wed, 6 May 2026 09:08:19 -0500
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
Subject: [PATCH v2 00/13] TI: K3 DTS: fix USB Clocking for Compliance
Date: Wed, 6 May 2026 19:39:32 +0530
Message-ID: <20260506141040.1368918-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a1eb12-01d0-4a4d-6320-08deab78f1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EssJ6CZr6FEmk823SmpaCv5NAzvXVXagTx9zeCspXnQpN/GZu0a5eGkE7yN5q3MsOeMcondjGbAeD62uEn6dD15F7BvjRaFCYGMeH+LpenCJxMPOas92PPWpslR9pk8+bgEdaNovETkS/q0zCYUzYMf3+enXpAvXTbxWRJXWGkaV/XYldjbU1Da6jRK9K/MeMviGXmLfNeBPVg7LLGOfxr3laR/yw+28EOwkXBpkjZQuhBS41uTEIaHDBhf3FuEx3PtuzqxAmCJx/huk38hE73veDWuX0ufbIB5YFqQMVf/d7U0bF5uq3WZXebwZXmv1PdWshpzjq5zAEIb1FzK9wD8C8YMM5B7mFHwk49CptHTPRKX/YtbGHGg3kTBjbYQwfshKDXHsNBzi66fQg/bTyG4ORzZaaeVENBmAnsOCDQVcHniuKh9ZXRBARV7UOPatzKw4Dnq8p00szfChnTAzvoxkeuCC0Bw5x37HBeg+zvQw2Zgo59J/yrV7BAAUaF0JYlWtsg91ZyTje1H2MCV+8uu/gxYA3axAbN3B4qO4MrP2hRDckzExISAO3Hdn3Szb3NtWsnI77tD2uIH4qYpsM8IdIFr0lsZc+Pq+Esom2T1Cc03KjcYCuaQZqbYazvAkQdYZNEDjgx61spJV1Y9cga455bT2LVXVYUk0EUt4M42rkAKKui8TgGqoOw77/xx4dR+yTe1Fs5ajr5AzDp7nGrRqPs7067727S7ZE0tK1PeDvoT6D1e8a20eyUvV/4graagEM7Y6PvJeh+T9UnSyEG3T+fSZlGZx8p6kgEY0bsk=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cyRaKRr02fLm8PmzkZ7XuBo+fqmwLMTnZxzdHmDOnrHHu413Fi+X4ChXXPy1IccYB9ST/M1BVLsT1KyV+6zPQ14UCIS0zL/SmJayqCjITUhzQHYnaQ3mJoI5sdWtdgLKiTRxuJWyQRxbq9AhKu0OYVg5N8SF+dzrNOOQqSPh7ZwE64by/3+9x2RNB41b3FMGoY2AWlxUilHvYnqCRB1Fbb2cQNqD96yOsolin271og4aWrwp48+0/MjWyEZaLmYRmrx0NAP0cAehxTUlHb9PwKtIp6XW8GhudHToCVg3We0cJhlspnpGwAR+l4E1SSWyndC282USWO/cdvEQjM+PKHLtt/IxlXjShk2BP90o2qkPk6j0htqk5loehL+vSpU/Iv3vT+HVdfYbdFYBDMYCOcoc5PlmyQPSkH7ASLaoZht/Ws8m5NWkE+grYkDGdnoj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:08:27.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a1eb12-01d0-4a4d-6320-08deab78f1a5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Rspamd-Queue-Id: 6F6804DBBC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244393-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Hello,

This series enables Internal Spread Spectrum Clocking (SSC) for USB
SuperSpeed configuration. This is mandated by the USB Specification
section 6.5.3 Normative Spread Spectrum Clocking (SSC).

Series has been posted as individual patches for respective boards since
the Fixes tag is different for each board and needs to be backported via
stable.

Series is based on commit
74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
of Mainline Linux.

v1 of this series is at:
https://lore.kernel.org/r/20260505110631.1144200-1-s-vadapalli@ti.com/
Changes since v1:
- Collected Acked-by tag on patch 1 from Josua Mayer <josua@solid-run.com>
- Reordered properties in patches 7, 8, 12 and 13 to have 'status' at the
  end of the node based on feedback from Francesco Dolcini <francesco@dolcini.it>

Series has been tested on the following boards:
1. AM642-SK
https://gist.github.com/Siddharth-Vadapalli-at-TI/d4aecc572697bd02bb65a0fe5efea393
2. AM68-SK-Baseboard
https://gist.github.com/Siddharth-Vadapalli-at-TI/371aacaada2b236776455be5fa15e593
3. AM69-SK
https://gist.github.com/Siddharth-Vadapalli-at-TI/1d7c6c3a5cbe6ec2bc966887c3e4d913
4. J721E-Common-Processor-Board
https://gist.github.com/Siddharth-Vadapalli-at-TI/f815f1a9b400ba492133e43c36f69936
5. J721E-SK
https://gist.github.com/Siddharth-Vadapalli-at-TI/0d1e4e72b47ab1482b5b7d1247bc8bfa
6. J722S-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/146533f0a89bde59b47ead582a924e62
7. J742S2-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/be8ed3e339441b7301f57ad006868238
8. J784S4-EVM
https://gist.github.com/Siddharth-Vadapalli-at-TI/62795430857387491162b21d9c9692d0

Regards,
Siddharth.

Luis Parga (2):
  arm64: dts: ti: k3-am642-sk: fix USB clocking for compliance
  arm64: dts: ti: k3-j722s-evm: fix USB clocking for compliance

Siddharth Vadapalli (11):
  arm64: dts: ti: k3-am642-hummingboard-t: fix USB clocking for
    compliance
  arm64: dts: ti: k3-am642-phyboard-electra-rdk: fix USB clocking for
    compliance
  arm64: dts: ti: k3-am642-tqma64xxl: fix USB clocking for compliance
  arm64: dts: ti: k3-am68-phyboard-izar: fix USB clocking for compliance
  arm64: dts: ti: k3-am68-sk-baseboard: fix USB clocking for compliance
  arm64: dts: ti: k3-am69-aquila: fix USB clocking for compliance
  arm64: dts: ti: k3-am69-sk: fix USB clocking for compliance
  arm64: dts: ti: k3-j721e-beagleboneai64: fix USB clocking for
    compliance
  arm64: dts: ti: k3-j721e-common-proc-board: fix USB clocking for
    compliance
  arm64: dts: ti: k3-j721e-sk: fix USB clocking for compliance
  arm64: dts: ti: k3-j784s4-j742s2-evm-common: fix USB clocking for
    compliance

 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts  |  9 +++++++++
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts            |  6 ++++++
 .../boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts  |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts  |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi        |  6 ++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts             |  6 ++++++
 .../arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 15 +++++++++++++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts    |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts            | 15 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts           |  6 ++++++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi  |  6 ++++++
 13 files changed, 111 insertions(+)

-- 
2.51.1


