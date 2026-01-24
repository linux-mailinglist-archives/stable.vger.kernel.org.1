Return-Path: <stable+bounces-211444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eqR0BJh8dGmr6AAAu9opvQ
	(envelope-from <stable+bounces-211444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:02:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A77CF16
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 971D83009157
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D142048;
	Sat, 24 Jan 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=list.ti.com header.i=@list.ti.com header.b="jM92l2QK"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678411713
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241748; cv=fail; b=Mn7l6Sfnsz5o2M3StmZv/CQ8d0PbudrP/DFwDLbBGzqNDizyDzt936d0Z+t9Jy2IcRy8Rp2ZdtFrRHkCn149wqBWzg+hUIoNht2AwF4ooSV+qofPF2Yv9rdNKVEGo9nf/2CUr8yM86xmUlw+3awyfRiIWw9/N5SLOh7mUPp3S9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241748; c=relaxed/simple;
	bh=T+wuUXYqOdJDqb3muaLE/hN9tkMxIonBjVpRYqYta/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOj02fmzOw3NzlFxoFOXbvwlXn8QDuwo7wDNSlVFCVapMQmrsWq7H6hP+kyS6weUUP7BnBQj5OvgoTRA48V25oGmDkSmp7bydnnt/53yxthVkoIjiXO6ZnGu3EUswV1bAtenPuq2gUJJy3OC31zghG5n8n5466Q8br425Zi/7Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=list.ti.com; spf=pass smtp.mailfrom=list.ti.com; dkim=pass (2048-bit key) header.d=list.ti.com header.i=@list.ti.com header.b=jM92l2QK; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=list.ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=list.ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOBU+S+NK/X0dirq6xmbBXi7CgScluV00T+BnbOmzHGHTqFtq0DLiPd9vzuNuZSfmERNJRwZ2RX1lFsviHFVVMFdFNiCp70IKuh6TtRZATWWx0uxEZ11Ta7f+93OEdJeFNqF5ceGwlDpYbYPpd95UrOF5d/Jz0w0b6W53jdYm6YGRhACDRPbsaA3pwSddJB2mwR2keShBZuJYO/S97wBeNmmNquRnOfRHFJkzNRJ+NA6pqtbeN1t+dGs1eRRkWxtoZnp4AYu3ED8OIoY5Y/zeXQTvk3fsHp5YxLhjhsocr9khvjK5uOhjf0F0fBj78G0zoayIuNasK/mucu2bAst7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rem19N8LPPA6laYEy41ZXNyEX9JeXYhRg/Nf0h0nZNQ=;
 b=uE+9Gk9w/KBAdCDPnkEr8AmMqYElHhwvAnoObYfbytZjOzRG/oGm+6o5haNs7EHXKJvUaCr/nZiD/3waVyLPpedq/UJFab9ZObkunMTw4yigWu6UYk+ePXeC+wIEJutAcFJuuBqmhoUMnUXz7MWfqUFHZTh/CkBKqBUQuzL8W8l0WxgKdKlAp3UvQK2ua1pgab06WLdkDLSlpm1mVITjZ5n/SwN93uAa+5esuE96H1kLuRjeioipaX3VZ5blzi/6xQJkjBROUtGKyb93nIqyvI49KqK9vChWVHvCMb4+N7GDLcwLt+W3X1v4iqX61x7EcAtwMe42pFpEyx9Cq1pOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=list.ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=list.ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=list.ti.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rem19N8LPPA6laYEy41ZXNyEX9JeXYhRg/Nf0h0nZNQ=;
 b=jM92l2QK0H43qTU0DGd38tgUbgLPhHkL2Wu0kv3PUpwHAPIIsltKIeU8OqG6DBsK1cp/3b/ixvEpJCgvr4Qqq6r1g0vElfj/2nGAPfhDq13/XvG+RjNSPg2Vw5NKg+eaAOa68Vku59aHny+oEJVf3CgeeIzbZ7r1LR9zDG9sxcqKmnCxy8m1jae5zmRk9b/H13Vj83j/DfdRWvGU3Kk0F68Ai1uubymPzQRC2VagWt6ZlxNNQvGpcabJpIernMosv+rhpw5ue/5s/v8Ib/ifEcuTqvLL+sOOieeemo2khLsL8w893KiQuClunhwd2oAXnm06M0HCinQpVAqlsOZGhg==
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 08:02:21 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::42) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.13 via Frontend Transport; Sat,
 24 Jan 2026 08:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=list.ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=list.ti.com;
Received-SPF: Pass (protection.outlook.com: domain of list.ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sat, 24 Jan 2026 08:02:18 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 24 Jan
 2026 02:02:17 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 24 Jan
 2026 02:02:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 24 Jan 2026 02:02:17 -0600
Received: from fllvdckhpci031.itg.ti.com (fllvdckhpci031.itg.ti.com [10.64.72.41])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60O80TBn3632859;
	Sat, 24 Jan 2026 02:00:29 -0600
Received: by fllvdckhpci031.itg.ti.com (Postfix, from userid 60899)
	id 2DC469ACF4; Sat, 24 Jan 2026 02:00:29 -0600 (CST)
From: PRC Automation <prc@list.ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
	<stable@vger.kernel.org>
Subject: Re: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for DP83867 PHY
Date: Sat, 24 Jan 2026 02:00:29 -0600
Message-ID: <20260124080029.2810485-1-prc@list.ti.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260124070651.2152967-1-s-vadapalli@ti.com>
References: <20260124070651.2152967-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR10MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cfcc13-0dc3-4bda-cf20-08de5b1ee522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ckaE6WFfva+vtsXInNbHKJtwj/ydombfry8xmSsrWE4/NP2OqBPAhKVLuzd9?=
 =?us-ascii?Q?QWb/eWR7Xs3RgHYDbVbBxsOEF6yZUP3LwGhFQd2ntM03vWIP1TB7CmAWqTuq?=
 =?us-ascii?Q?BrRJ+t8IY/5gE/2VL/moTbqMIXcz8fpFKqkTgrBTGe2gSL/Wqv7DCQ0eX56Z?=
 =?us-ascii?Q?cSuymvukPzmiiONYbwuLyD9lOlI74Kl8NX0YMRk3FWc4t2zaNqf1rK2rvdAx?=
 =?us-ascii?Q?oHQxrRQ3UV3qDHKWvfXDeLQXnzxoxJSvyC8dAEHF1jjJPcL6Cl/p1q0wFrbw?=
 =?us-ascii?Q?w9PPCGgN51LEh2i604i1Rzrz8xm/w2btZzyKQjg9ilNCyuGXubXqS48FpLrM?=
 =?us-ascii?Q?IeWyfpc234YJYQuodwa075fn2iONK9+F8OpXIzYnVYz974sJJXarVHLoMJf3?=
 =?us-ascii?Q?nml926NyDSPx4MLnse8+0dSRZxoGQE0ZMelyQZmkeJuWX7Bgi+91YPPv2Akr?=
 =?us-ascii?Q?vBmPJfs0z9rCiXfsknbt3uo6jnwO7mmouT2Sve3vBrYo+K/JURQIO2S0j0y/?=
 =?us-ascii?Q?AJGphcugl/ARQJwCcL2LsJSJU4EqaznzgrHADYFuFsnu6jWChsVLsqigOZC1?=
 =?us-ascii?Q?+5YZss+rzwuGtSlumbqr+NgiCGdVc03k9AfkBg5I+syl1IcKOSs6R6GylouZ?=
 =?us-ascii?Q?RIDfWfz33WGzA6s9K5y1UITN60+v+KhiApgT3SEME1CV+RNSzMPgVhiAWI8G?=
 =?us-ascii?Q?prcZu+7ikxYvu8QZI6QzYhsq1zRFn/xg7alm52GGs85EqtrBbIUDieZxfJUR?=
 =?us-ascii?Q?fKiYqZWUm/6IE3jsDg3cxLsBRWfIF1qf3CPVy0Y+TMasYBr183T3qfXVpsBu?=
 =?us-ascii?Q?TwE6Qdsl/lDOJzXviCE58AK7MOV42QDstJoW/q/m0iavA/Pb6WkvlzK+sDCf?=
 =?us-ascii?Q?AtRejhmSxffl7PdA/kNplAXnH/H7vCOlbp7BSZ7kudSdhiF/CWNr8EUyVvH5?=
 =?us-ascii?Q?HQyN0dJRubE3Pezii39JbaeLlONJN/7E0hGyqET/RMAnM3iS9++5jovTUmRo?=
 =?us-ascii?Q?1T+Sq/014EovB7XxY3DDZ2c+jdRhmJw+QEmZmViphjqxKiUi8rd/+Q1m0dFp?=
 =?us-ascii?Q?mVgb2F85CDpAdw3WWxwzAhuD8bA2o0R1mOvaJQ9D5l/T89sYaSNSXOCzIxKr?=
 =?us-ascii?Q?n5iY2qqTYfWb5q5H+3bnFKqTpZSHMZIpB9s1z8jlOPi5LAHWtDu2BAObEnkL?=
 =?us-ascii?Q?i/cAhizdciGbqYchP4ptU/qpvvcKmVEg6rlsP5FpQ8UwQY2CudBKaLk92KKP?=
 =?us-ascii?Q?McCD/zRXzSifhphRMY8k69K1c54+j3Zoh4wcp6xoRFJ/9J7qbVDXHQ/sb/Ul?=
 =?us-ascii?Q?X89yWGC1zi695AaIBBVSTw4sWTx6eeLhkphlsRnUysoi+6Hzf/j8trM3eIuD?=
 =?us-ascii?Q?Vj26Yfi0M4fSD07VRQ6aozbFoEod2pcaF9k8ThSw3Xg11HIyP0tXo15fRaxa?=
 =?us-ascii?Q?4sld3tUgfyEKEP82lDXRqJTdUj6hRBSGiHxQneanOQ6y9f4j4WZHKB8l8Woh?=
 =?us-ascii?Q?BRDzugC29/xjy8DrQ35INgWmKKDQ+npluGRBnd91o9VQ6ZkZkaFpErgedyxh?=
 =?us-ascii?Q?/gtCPAJAddZJ6NQ3w3kehyovcuaylZ1Y1hyk/4Dp8F93B4BkaYQb8lkQfXc3?=
 =?us-ascii?Q?eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: list.ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 08:02:18.3777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cfcc13-0dc3-4bda-cf20-08de5b1ee522
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[list.ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[list.ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prc@list.ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[list.ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,couthit.com:email,list.ti.com:mid,list.ti.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 153A77CF16
X-Rspamd-Action: no action

ti-kernel / 6.18 / 20260124070651.2152967-1-s-vadapalli

PRC Results: FAIL

=========================================================
  apply-patch: PASS
=========================================================
Summary:
- Patch Series: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for DP83867 PHY
- Submitter: From: Siddharth Vadapalli <s-vadapalli@ti.com>
- Date: Date: Sat, 24 Jan 2026 12:36:46 +0530
- Num Patches: 1
- Mailing List (public inbox) Commit SHA: 17b1d51fe2ff3be3a867d71baf22dbb3153135b6

Applied to:
- Repository: lcpd-prc-ti-linux-kernel
- Base Branch: ti-linux-6.18.y-cicd
- Commit Author: Parvathi Pudi <parvathi@couthit.com>
- Commit Subject: UPSTREAM: ARM: multi_v7_defconfig: Enable TI PRU Ethernet driver
- Commit SHA: 3e1b5fb10cace2688eecd366e85af7c1f5a69fac

Patches
----------------------------------------
All patches applied



=========================================================
  build-and-boot: FAIL
=========================================================
Results: http://lcpdresults.itg.ti.com/build/results/prc.ti-kernel-6.18-20260124070651.2152967-1-s-vadapalli-202601240719

Builds
----------------------------------------
FAIL - j721e-evm
Logs: http://epswnas.itg.ti.com/coresdk/builds/prc/20260124070651.2152967-1-s-vadapalli/prod/j721e-evm/prc.ti-kernel-6.18-20260124070651.2152967-1-s-vadapalli-202601240719/logs
FAIL - j721e-sk
Logs: http://epswnas.itg.ti.com/coresdk/builds/prc/20260124070651.2152967-1-s-vadapalli/prod/j721e-sk/prc.ti-kernel-6.18-20260124070651.2152967-1-s-vadapalli-202601240719/logs
FAIL - am62lxx-evm
Logs: http://epswnas.itg.ti.com/coresdk/builds/prc/20260124070651.2152967-1-s-vadapalli/prod/am62lxx-evm/prc.ti-kernel-6.18-20260124070651.2152967-1-s-vadapalli-202601240719/logs

NACK

Boot Tests
----------------------------------------
FAIL - am62dxx-evm - am62dxx_evm-fs
Log: http://ep_systest.dal.englab.ti.com/vatf/eptf103/eptf103_vatf@am62dxx_evm-fs-01/01_2026/eptf10301_24_2026_01_43_36/files/session_iteration_1/test_1/dev_test2_1.html




