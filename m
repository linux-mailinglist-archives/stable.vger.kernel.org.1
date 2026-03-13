Return-Path: <stable+bounces-225320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCY2HWoetGlLhQAAu9opvQ
	(envelope-from <stable+bounces-225320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:25:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9F284E8F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103013295DC1
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E76539FCD0;
	Fri, 13 Mar 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qZjRdRtu";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qZjRdRtu"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023103.outbound.protection.outlook.com [40.107.162.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4138C2C9;
	Fri, 13 Mar 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.103
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411664; cv=fail; b=GsUw7VYkWzVzW1G7BquVZPQWbt9fSeEI8KzppP6jJPg98Fxr3Q0RjIznY7ZXCM+j7wYP1kH/nox0vsKIsjMQeymXr6wzG0ecPadjQ8RwsevJFqKfbVWqiZzPFwBORS+2DNcGzNaQ2ifbwEv81XtZyiMp6vfh0xD+hs/wNmDXHbM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411664; c=relaxed/simple;
	bh=TmMnlxDPQNRzUva1WHv+bE/TNcsHF+eJHBQzeE4UyTc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LSiPpj1k7i6bdFsZyvzSPQBgVT07VYiu8BkRoAXdksnA/86v592pnOXkGeyW9I4NU7UwNriglFwxKOCx4u0e9XoflifRPTlhEGDlFFgGAOIzFQPTitDJBvf7kf9mCf9fsGuqcLdV2d8ZPAN/ibyNOTra0OEvARPzC6VSk8kHc9Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qZjRdRtu; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qZjRdRtu; arc=fail smtp.client-ip=40.107.162.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qPegYToyOFeu/ZJVYDhFrNCEjv7oop0w4sR9V/TIk97VSugL61p3yWGE78EX0njj07pjZP7jsKwGTLzgCev/g6CTCJhPCNaQypDPcki6VCNPJcnV4+9kykwBo8zcb3WOAKo7UZ5qJclQIrEXe661wNgLNJ2CNMep/ingSYfJsWwALwLXUvhiqxIo706bA6EOgNuTL7v3b3Tvt9kj/YYV5FQ3Ks0AEx6gwof7bgbtiqfyuSD6r622m8pKPVcYkq8Rk0Tn6fU5bKV9BhDc9ruNYBZ6A/nRnppmDqPXLh74bANAbMuUEposOSTK9s4mwn5PkohNDs2RKsAah2j7ZPserw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnwd5OOe3VlPnGFelQa9jmVz4I5GwHEhBDcLXDD55Gc=;
 b=vPe7ymwUzY2SSTazRrX3oE3188GURON4yVcQHaVB34Yjq0ewcSGVfcwbHdL1C1pszUeUr/S9bQLod8e50D+sQVjn4kJKWwa6nE+312N8b60STI8Hp8UzcsYE6Hn+lRGLmlRnCg+HAbbZWbxBmC5FngO8+OwCe6s73igVHRV/TvMsvlO1J4sMhFMuqhy+3YojitfMRyPzBqkmmL2mfDqfO4P2HPgVWhx45csPiT34/v7ZK2ULx5d5vSqDTSib7XB2BQqhUowssuoZxx4TTobBogBtPF93E526V7FtPVNMO9fKgZa9CCw9GQ57zTJzMqyJUVSX0zvS+gnnnEa7EYXTaw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnwd5OOe3VlPnGFelQa9jmVz4I5GwHEhBDcLXDD55Gc=;
 b=qZjRdRtuzzBZsQfuIUcrU0Tu5VhTOeVgFxkyOpIqzig/sHhn6fPk0PHHliTTUU1KHrv7wVoRDVkDlNalWc6F7u87OxnzqxLCjxOg5ryzKWV2L/5unmBCkEUB9+E6O3uzrVNFFIntZRkPNHgm05RQi9Ouhcec/wJqzkUz9mlEZJY=
Received: from AS8PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:20b:459::32)
 by AM8PR04MB7796.eurprd04.prod.outlook.com (2603:10a6:20b:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:21:00 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:459:cafe::b) by AS8PR07CA0054.outlook.office365.com
 (2603:10a6:20b:459::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Fri,
 13 Mar 2026 14:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:21:00 +0000
Received: from emails-1215738-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-17.eu-west-1.compute.internal [10.20.6.17])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D2A4780C4A;
	Fri, 13 Mar 2026 14:20:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Fri Mar 13 14:20:53 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoNSwyWoYbwH/RVBqpO8iPGl1qTZkD4oRshgB8MLy00b7hc4e5tQhO308oWU+wEaGRtA70jmM+gRvea2gQQcEvj1UrHsm60gLPxhwnp39PtTEbEcjSVUFYOuQXptY4fu/3czjEnjROkKRvn73BCiGzvpNG5m9S8KaiELezY29KRx/tP7+CsYwdO9fTNwGtJnP5C+0YISP1Z4lfnj4bKUvuLkUstJ93VC6l89uiBa1sNkGW3S6r1/WER2wDYaIq5W0ty+qlK+WxbCGa4l433LXbmsX6b1lpJPXqHswDPNnntBKJvkH+HilmzCOjT2wsn1p8b/JNn+lj2hVxL0ua4fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnwd5OOe3VlPnGFelQa9jmVz4I5GwHEhBDcLXDD55Gc=;
 b=H4BXdsYfD3YgdiptBx4TJkhe8nvLnOBMkmYq0bMuI8877z27pMegn9upOvMf/clART6+GeNs2kg+NxZlhvF2gy/eaF0qmNbMK/4/hPqMTG21x8bRCwVAG+dsgCI6aeSbA1BfuTyfeYyd7sYA9Xo3uNVAb6ENorz7vgxmtbmVcpjXEHypYHH4WiBhzRu+5wnjVr/Am7zOi7euRmEb3E8aL+JELBQJf1jJPEWYj9zmQcyOQ3Ye/2kp3WS8wAvwfYd4Rx/V3ktNCQl2vnDjzCiEFV87CtNIZ3br6/48jePK5XvQtkzRHS3UT+wH8Ihl2rhCI4Zrr8vqJjygZvH8DE6nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnwd5OOe3VlPnGFelQa9jmVz4I5GwHEhBDcLXDD55Gc=;
 b=qZjRdRtuzzBZsQfuIUcrU0Tu5VhTOeVgFxkyOpIqzig/sHhn6fPk0PHHliTTUU1KHrv7wVoRDVkDlNalWc6F7u87OxnzqxLCjxOg5ryzKWV2L/5unmBCkEUB9+E6O3uzrVNFFIntZRkPNHgm05RQi9Ouhcec/wJqzkUz9mlEZJY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 14:20:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 14:20:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 13 Mar 2026 15:20:42 +0100
Subject: [PATCH v4 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-lx2160-sd-cd-v4-1-aabcf230fbff@solid-run.com>
References: <20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com>
In-Reply-To: <20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM9PR04MB8355:EE_|AMS1EPF00000042:EE_|AM8PR04MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dadcd83-fff7-4dcf-8b16-08de810bc02c
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 jCP0/rB5DLK8+EcmEYHviqAx6HcYb9piKL2gRmC8fj02jngKKAWO5LBFwNriVHohxAlFCLVQOHo+y46UrpZmB97RNNC3fjXogvT7JhUcm1kiRNNBnU4iwQUx1n2+WTD31sbL32h3GMpRHZtLhQiFl5nH4J+66RoAyxhc/YqQumiYCBT6A4Sn379Q3pbB6JzUwXV2iojzv1asvXvaAK/tPFCQhmwSkxCnwZdUtkbSlAoswQzPSV/KHg7a+CZLEtwnXVeYWf8dEX+I5Cb7UCtUyfCsBIBsm6yec18fv3E5OXwhYalBGRBCMiHbE64wxAYwwHMqQrEGH/927VvX6yNBQ23AmczCS5J1i0Hh2/mzzSnA+rTCtRI/b7ABZ+dlLnhCr9o2CGGgSJw3x8Prd2rol5uNDWqFVbI6AcupBbiF25aCHM+tqLTQGUwKbOCoT5GjsFDRgkPfcB6BcQ0metAeNVe8d2uuandIAyXZ/vdy5jOVqtL8A8qnnwLAZ6QhcxoZ7qDoPapmrxZpKROEXej0zC13uJgy7B1t7SaCSf/CtajDdwhBRSHLydP8CD6FsPhpQi0SY+nyKQL5UOzt0taJyVIrhEzw8SM4mkbutA2h+8eBCuduYnQdu03dLZo+jq4sqEJr3bmiEKRf4cnjnlOodVYMlc1qNZ4ECz6Hx2L5iTLhJuV2gkOfbzbfDv6FeKAqugtF/S99nR2XzA7JDuiUl/yZpxomZb54zny3/CML8j0du//aigRnOU+MagnzNBl8YGH+yAvGlONNv/jhDftlJAMQXqTmfFTTncUPSuh6DM8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 kTevQSEoSCEKyiZXfL+rFxSD5hICh6hEV2YxBiflBCmOriZM14DuLTcs4rc3GIpUposmhCbPj9uYSRV38dreXFf2KzblyQfNAHEoulGHm5emWe7WxtBrgt+HZfDLBufH7s9pgVtdM8X66IWirGGFi45iKJ+dVQmaVWU2U/b82qB0rR0E5vebxDKxl8zbHFyuHchTntMgRvb2enMqaxZJlj9/bF6qMx3RBcLp7nzX/RZfBveNcZlpacKJVzKVE7ceXU/f3Hn5mA9BdmwAopRT0u2jfFnb6enoGKYsuHj+k/z5+iSLd70stG7v4KimpgHgGE4j0V/Wh6/+XZk7lOwtEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 79c58bf6023946fba7e83523ed236495:solidrun,office365_emails,sent,inline:952c2005d0ac146f0096286976e8bdc7
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0792d59a-c467-4855-d274-08de810bb20e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|14060799003|1800799024|35042699022|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YXh5Ye1etn0U/2G/d4Qu4v15bs/oAl/1ptquEUvSK1s7usmkx/ZaoZdbTTewrsZZ2TEnxjJbhg0Sff0lsvuor4nqe+OZNjCEOji7+BGbzGnj/Bvmo6VnxUUHOM0xfzHghAwvM45D4Ol3tP1YtoQWhVIGoDmClQb7LKwqXJJ5nakKsFmP4FBBVXQPe0LEOt928BqkSyEPTfCU8FI7+t7ZoIO+ns844s5LEFMofdPniz3NugI0jJbYIJClnj9bqUR6AsR7NFzlwyA0qPYWH7rLLRHM9uZm1BFvgs4FuwFD2X/Ad76n5oz8wzLFwUJqfK+3t0wL2P0BptUF3PXStStTt4KuIXlYVopIfCoBWY0fj7u3tB9wZYi5Z8mbkdwm77YvAVy5Ef7BKaDo6thLvP0UnBhBYPVIevL/HJIwXghDpqQUXMY3XEOjBMw2bU8qBbiHy6TR9KIx8Wn8/6uzBTJpGWPiptIUjrCui/Q8EJHSh8G5l6dZpEhyxJjiUbaNcXupo9n3AXY57AEYNVvDqeF4c+GLWcLN3Hkc0iAZLmPZoF/MavvY5ElXkK3Cb1zuMFHxHIa23BVE9ll6SPZ2VXCyeqxDlUQIKJ3k6QHNhJW7nZuQpq3UnEjsigiohKO6HXwvMYMtXW4OCgVGpYHpd80l4oVH3oY8m5D3vvv9/2nn7kHHO+/EVxJC5h0ERL/1hdCsTD+qe7oWDq/rGaAyAXOta/WNmpNgyde1G4e0S/XI66EWVhw9syAtUYq2nT2x5cT7VDjXB3IT0+CRUZOZ381ktg==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(14060799003)(1800799024)(35042699022)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SQBjiqoZd+tq2HlmXcZwqiG7RUgJVTNluUVK3nvaihMiWjy9tPRnt9I3c4T2Si/ueLb4FBFy3klUz0h9hZgxAfNnM7/x4wOo6wEHxFl9dF+J3VtteEnDDXGNY+RMIPH7vS84JOX8f0u0eayxQhdUUAPBhjEwBQAEyZAiMaMRVyflIbPPuzQy8AOKMtyEXKR6GWCoQomSee06gugtTvmTjRjw2uc1x+lUjLDSKRc+LyP+kHkv9ld8fPly46s3PupS8v1rVhZ8EefcqVSHXZpWqSngFifnL3BV3tF0Pmr5pZjNfO8faYR7ETzAHmg+Awpnv6+AP/4chVMQSGllEEtdkwqumXRr81T2FlTUvKoq5tCR4kjd1sw6x+DSKD1tIr2U+uB4646MRv009ihufemLaRPPfC9SgGuURtl820k730xR6LQANJqW+i63aUBoMqKC
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:21:00.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dadcd83-fff7-4dcf-8b16-08de810bc02c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7796
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225320-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,solid-run.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.15:email,solidrn.onmicrosoft.com:dkim,0.0.0.51:email,0.0.0.0:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DCE9F284E8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to
support bus recovery") introduced pinmux nodes for lx2160 i2c
interfaces, allowing runtime change between i2c and gpio functions
implementing bus recovery.

This has caused unintended side-effects on SolidRun boards where the
first application of a pinmux node cleared all bits in a 32-bit word,
corrupting the configuration previously set by bootloader.

The LX2160 SoC is configured at power-on from RCW (Reset
Configuration Word) typically located in the first 4k of boot media.
This blob configures various clock rates and pin functions.
The pinmux for i2c specifically is part of configuration words RCWSR12,
RCWSR13 and RCWSR14 size 32 bit each.
These values are accessible at read-only addresses 0x01e0012c following.

For runtime (re-)configuration the SoC has a dynamic configuration area
where alternative settings can be applied. The counterparts of
RCWSR[12-14] can be overridden at 0x70010012c following.

The commit in question used this area to switch i2c pins between i2c and
gpio function at runtime using the pinctrl-single driver - which reads a
32-bit value, makes particular changes by bitmask and writes back the
new value.

SolidRun have observed that if the dynamic configuration is read first
(before a write), it reads as zero regardless the initial values set by
RCW. After the first write consecutive reads reflect the written value.

Because multiple pins are configured from a single 32-bit value, this
causes unintentional change of all bits (except those for i2c) being set
to zero when the pinctrl driver applies the first configuration.

See below a short list of which functions RCWSR12 alone controls:

LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
IIC3_PMUX              |||   |||   || |   |||   XXX    : I2C/GPIO/CAN/EVT
IIC4_PMUX              |||   |||   || |   |||XXX|||    : I2C/GPIO/CAN/EVT
IIC5_PMUX              |||   |||   || |   XXX   |||    : I2C/GPIO/SDHC-CLK
IIC6_PMUX              |||   |||   || |XXX|||   |||    : I2C/GPIO/SDHC-CLK
XSPI1_A_DATA74_PMUX    |||   |||   XX X   |||   |||    : XSPI/GPIO
XSPI1_A_DATA30_PMUX    |||   |||XXX|| |   |||   |||    : XSPI/GPIO
XSPI1_A_BASE_PMUX      |||   XXX   || |   |||   |||    : XSPI/GPIO
SDHC1_BASE_PMUX        |||XXX|||   || |   |||   |||    : SDHC/GPIO/SPI
SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI
RESERVED             XX|||   |||   || |   |||   |||    :

On LX2162A Clearfog the initial (and intended) value is 0x08000006 -
enabling card-detect on IIC2_PMUX and control GPIOs on SDHC1_DIR_PMUX.
Everything else is intentional zero (enabling I2C & XSPI).

By reading zero from dynamic configuration area, the commit in question
changes IIC2_PMUX to value 0 (I2C function), and SDHC1_DIR_PMUX to 0
(SDHC data direction function) - breaking card-detect and led gpios.

This issue should affect any board based on LX2160 SoC that is using the
same or earlier versions of NXP bootloader as SolidRun have tested, in
particular: LSDK-21.08 and LS-5.15.71-2.2.0.

Whether NXP added some extra initialisation in the bootloader on later
releases was not investigated. However bootloader upgrade should not be
necessary to run a newer Linux kernel.

To work around this issue it is possible to explicitly define ALL pins
controlled by any 32-bit value so that gradually after processing all
pinctrl nodes the correct value is reached on all bits.

This is a large task that should be done carefully on a per-board basis
and not globally through the SoC dtsi.
Therefore reverting the commit in question altogether was considered,
but received pushback in review with the argument that bus recovery was
important.

Instead add pinmux nodes for all fields of rcwsr12 as used by affected
SolidRun LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog boards.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  7 +++++++
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |  2 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 24 ++++++++++++++++++++++
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  2 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  7 +++++++
 5 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index eec2cd6c6d32a..7f6e39e27ce5c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -162,6 +162,8 @@ rtc@51 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -177,6 +179,11 @@ flash@0 {
 	};
 };
 
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
index af6258b2fe826..580ee9b3026e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
@@ -89,6 +89,8 @@ &emdio2 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 853b01452813a..af74e77efabc5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 0x1 0x7>;
 			};
 
+			esdhc0_cd_wp_pins: iic2-sdhc-pins {
+				pinctrl-single,bits = <0x0 0x6 0x7>;
+			};
+
 			i2c2_scl: i2c2-scl-pins {
 				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
 			};
@@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
 			};
 
+			fspi_data74_pins: xspi1-data74-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
+			};
+
+			fspi_data30_pins: xspi1-data30-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
+			};
+
+			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
+			};
+
+			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
+			};
+
+			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
+			};
+
 			i2c6_scl: i2c6-scl-pins {
 				pinctrl-single,bits = <0x4 0x2 0x7>;
 			};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index eafef8718a0fe..8920326a06735 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index e914291e63a1a..e1344942eaaee 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -30,6 +30,8 @@ &esdhc1 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -80,3 +82,8 @@ rtc@6f {
 		reg = <0x6f>;
 	};
 };
+
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};

-- 
2.51.0


