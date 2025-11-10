Return-Path: <stable+bounces-192923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 867D8C459CA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD74E4E97E0
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2143002AD;
	Mon, 10 Nov 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaYzo5LK"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA82F7AB5;
	Mon, 10 Nov 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766584; cv=fail; b=VBOdBw0lKE6xo6LLKV4XqBeCM1SZKf20/nsGUPkUDhZMHf8Ix6FH2+kcXG6j8gkSUSD2+vJ+4ZUbtCOEzAcGWx3PUpSPg2UTpstOgwyzAiP3srckXe22AROQxAvV6lb8vF20QkUmma/SvsWRKDGGdG2tkJ6DuK6pv+UUUGUHmVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766584; c=relaxed/simple;
	bh=icunUZ7iDuwYLuXeFh7MvArubdIedPNTgaxNtTOrN7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAX7N16gnUNlRKpkSQAUZ+q4HmtmUGYn7FMouiJpkgJ8B/bwocSFfc5Qmn5xgnUJTSMFm2I+qnesL3LpNWRYqH2/JHJU2YMQuG0pTpUuYS/62EdYxAFglkXs+OH77fi9jKDnSzckY/35gwql22PC8w9SyttikG678vP3wiydpS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kaYzo5LK; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcCCHw9xT7iZ0PxlkiEvT+6HGmQKFsUXN6+3Q8tdA63A06VcQvNDr+/Y45QhjZwT0k9M8ovOuPjF9JFs/+wGI5Dnp3pccvFicG1RYOfVFqEhSke3mXVg8SvMWmNboeb9/MaJ404XNA7M1fBm1J3IsPzSDLd0hBo/2smjoInevMleeGQMm2XdJP5Q534hg/u1uik148qmtInWgBdfAsFk446m1CedOxHHliECylzv4aq4CtSX7/paLcg5MrCasGvhYSXnyAMB8aKMShpuF3GJzMuMeKcxC1tZNWPvf/sAxs9vM0KLuuWLV9nBsJgusj2HMa8BvI5pzPHt5wSHiAiffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJH7S921AnDuXVgkK05Ud9SrROp4capxQMhSxPtjys0=;
 b=QQJ9Cc6uQIAsK46VDFzzBE2QC8Dvh9ixSQMTdsNRvU6BheGVtIHVPYSqjdCr68u3OrfJsEefzNXl8GqWDgz4fonytYFWjiiN5DQVejaYMLaCd0MUdxYDGTZMO+uKJDLLuuo4PsRmZIrWavCpAksjCIjbGAj9Gec8uEZbXJJhMPqE8s7aA8rRG4dy4V2zM8553GggtgIWS4+Ygozzlt1PjlsphNmwF9E1yYt0KFFQPm3hG6gkoFwKOkH18qhVytL9I1vo6/l7T9gbA6vDl7ivbfbr/oqJworhNF3OZFY+2SR1ZDE9gGXn6kLYpC8sCTjHA6VcNWRmqoBJ0R+JUxF4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJH7S921AnDuXVgkK05Ud9SrROp4capxQMhSxPtjys0=;
 b=kaYzo5LKUFqHd5h24lhKY3/7kaBYfxAQ5nd+AsmcdVgTDlUiYphoZ40smtgXUMpkK5a20wuN+ZEa4rcBSnmjP15iii8EDUDQdLkW5bv4MM6rCYFUrWqNqo1mb3Eq94k34WvpZtLemXM5qOcan286vauhQgvtVefD+OUOhXrH40fpMB7D7JlG44M7UX2OsTFgGFCZ9r9zdoSDeBvYXOzQqftYwhHCcE8FnvJOq3ktgEgc6uPj3tuXQ0ZTv4573D/PZF2sxM/EV4SbNm8DwQv1tYmaMja31daFT5sAhq1mGV5G3QMoX3zqffwFZK9dKlt/60jAWp5B4LyNgcbqaSxUbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:22:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:22:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 phy 03/16] phy: lynx-28g: support individual lanes as OF PHY providers
Date: Mon, 10 Nov 2025 11:22:28 +0200
Message-Id: <20251110092241.1306838-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f9c866-95da-4eca-77db-08de203abbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PcxpmZkzE+S7VRAQKbo5p3Ck4qhsVWqeHWlAbUAcFHOUNE+67FuEl8U2AHlp?=
 =?us-ascii?Q?D1abu+DLqrls9UtPkapqGk2Qup4s+n5CZICozvKp4eMGlElaU3CTrZl/RVUh?=
 =?us-ascii?Q?kvFbFNtGeo8jK8R+kR9D5ckE2WYVSS0WlGuCqfXLTT/rzjUfC5dsHqLLesuW?=
 =?us-ascii?Q?Qf8fCBPGTYeb/ITArGMTp6oOaTPJR4iqnBN3l5ZxTBm36Jxn2sRuANJIa5NS?=
 =?us-ascii?Q?xQjEmaQOHemuNupPKyMzX6I18rkyYZGcgzZgR40PweiA8Fvhpgjf+TQCwYZy?=
 =?us-ascii?Q?fidTYAp+IUAI51hJwro+WZCWQIz14cZjHJTOInQQ/bm1KjU73HVvtfxMHW/Y?=
 =?us-ascii?Q?nqL/eKtw1P7rdDsTVTjixoVzJMDiW4M+qv54ciu3Rz0Uwv6hFVdf6VUY2dTJ?=
 =?us-ascii?Q?z/bColbl48tXb9yjKvTcJscI6N9ZotoV2MwBrvuX3yncSoObIa4s7pbYZJaX?=
 =?us-ascii?Q?sjQS/x42I2OZy8ijWpAUT286h5QGDWl7VSlcvAYjPiA6s5j3mZ5V5U9pJa9g?=
 =?us-ascii?Q?BntkhuzhlQd55JeA6Zyp6Y+RF1ncnp/jypqmgOer26s8rCwBiZeoAPfM3dKT?=
 =?us-ascii?Q?W7D7rdD5jdbNzCjntp54+68/EZPwyUtcBJxVlP/vj+HDWvGnkRRkZb40CtCh?=
 =?us-ascii?Q?s8THDZj8j3lEDSLBmVNxZTby6+vnpe4+uUgUuZM65iAgzrQUUzuORggI8BNI?=
 =?us-ascii?Q?XAsjcJjFOXwikSTryPMCF9xffa/9v4ZPQgSpUB/v0poBQUBzP/Bswh4xt6EP?=
 =?us-ascii?Q?1lVC+vtsGEsZ2WgVMXnnkYGKxvUggQJiuP7HvBLq+Et5Xvuqz5ggDnRPtwYW?=
 =?us-ascii?Q?QM8kr3OKF7ARs1JKiuhMmU8b6EbJ8FPvaOOPj93plJDLR2M+9Jf5/1i01cl1?=
 =?us-ascii?Q?IJUcaQPuJ/NGnMwCBX1whPkFboc8NI0sZrqz7ynosFA/NS9+NrkaxC8IFijX?=
 =?us-ascii?Q?oeQOrfUutptUyDusFScjHZtJWuQ5BBCuyvuy5aTKchvCTH7Y6rmNU/Dd6FTY?=
 =?us-ascii?Q?FTXTC7BGtvHdk/7Zu6szVnUAzjn2giw4I4W+TGIbtyHJnLiQZzA8/Byub8Pv?=
 =?us-ascii?Q?WVVaXL/tPmPxlfEu/ksoCMURHiZhmOH4aUUjhMczgI09sk9Is/tvUXXhgsWP?=
 =?us-ascii?Q?20hA0a5HC+ovqmIxGvk/dwyD6wn3WaeYd/4CUyEGTngn3fOyozuDwyTjUkHN?=
 =?us-ascii?Q?iOCQupeD9wHBLB9wedGGqoOw81LRegXu+H/O1NSCk6vGqfPaRLoScUM9E5Wg?=
 =?us-ascii?Q?aoD/vlE/JlIFTHEl1ZWso5DKakbGDtAY8+h+LMHp38Gl9tyiE3j8pvUwLzwp?=
 =?us-ascii?Q?zZSs3SQv7lb+aj7KoLgzjd49Hu9066Fr9+0qT6W3FzXtP2KzsgHeI0X/hAMf?=
 =?us-ascii?Q?0hK3BA0lw5OJ2zRPN/QAQULUdeUykqgX7z8IzJf/QUG4JXDU3mdY0nF42f8f?=
 =?us-ascii?Q?wUAAKHjne59isTf7RcTq9M/FVG6/8shqm+3n7xiIdDeqM3rF+hkkboUBsZ68?=
 =?us-ascii?Q?R2B7pmEA2uWSYy57RiKfxbUBmdysY1M5ZuvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpyV04BhzWHPbPwIsQvq6lGJvJTH5ApU8f7JKpj8xvbHO9pMFIqe1Jp17MKp?=
 =?us-ascii?Q?FJBffjaYxezPyEhr0B9FfoerO3qBvrzjgqDU/763cfSwe+GznHvme7E6B/v4?=
 =?us-ascii?Q?uoscdbV7h3vXpOBwfhsnf/l3+0Lt82oWYmV2CACjRAYWM+bhLQu63+uEs8Tq?=
 =?us-ascii?Q?a0NYCEtY4WGHWgQ+lLicLsYwyjuJ/8GFm1T6HwUammZNsNG/8Fi/aX2B7M9T?=
 =?us-ascii?Q?1nfchXazizTOUmnsBD6TA9VI/Ader/U1ehEMijM+X7ejSXhybcUf3eNcvhq7?=
 =?us-ascii?Q?ZGkrwy4wIBA5V1T+kHf4gMjjW3pBsfvn1eAFLk7ZhlbPQFu22k2q9nSbEioa?=
 =?us-ascii?Q?nBex6atNYETDyeEtxWoWU9zsdRtsjxlMLW5bf+WPl2fcCcX56bpP6JDnwl9I?=
 =?us-ascii?Q?EJzEIFM7mp/j9vEOs1FARLNasFzHKFdoMvo7cpAiF/8LuBA3MDHvA7/lLr2q?=
 =?us-ascii?Q?iOuWa+c5gKUiOM+k2Bgu/6I/rlJA/8y5U5pYuvs0YdT0b/jUyX6hQVLxYdp8?=
 =?us-ascii?Q?pGnREUwFV+B8QPPwmG+OQF7mint90H8qzTNCmROkA/lO8TQXdanORkiq8vT/?=
 =?us-ascii?Q?d0zRm19DD2cF7aXvt6KAb2EzGNPlFViOAiyoWkw/+ftuYSOBCRt2bezShGG2?=
 =?us-ascii?Q?Ky7CKFI0tIvbKdcma9LbUK/kU4fGmK2zW6Ncui1C5RDHs4VaEjiir2smYy19?=
 =?us-ascii?Q?uQDH+UimMQ9G2o6JuDSXdGNNDuPII1pWUKQsHJJBnmcGFSV7GVpO5UTZhexc?=
 =?us-ascii?Q?o/IFmcirx2DUs9BUIj8hActAUGWWeSA/MYiaThI9c7V0QowxB9CkBMvEdQp9?=
 =?us-ascii?Q?7nogBMpqeRaH5QMz6qtKSwPq4W/fgbA2oIHco7x/ocUcFyXCN4KDoMz7uBuR?=
 =?us-ascii?Q?3hmWsdDzXOoI1RYqmeQSo69L2CjwYOQd9ofqGWrRnduJ74iTMkJWjybeBJLI?=
 =?us-ascii?Q?meKIeV+pQqm+nzDML4ITh9MRK4+sGal67HG/3sNxDOiDE+b6mJC9Puvhb2W5?=
 =?us-ascii?Q?6GxOXj3TNvwow3RW3mLsfv8IlxtpJALSE9sY2vxef8iVkcCcrd3VvNZK+Yul?=
 =?us-ascii?Q?MEmFz0GIOchd1qVCsVCsTLLDtKljntzMHnF5IE+XE7RtFSIdd6OWxi8bCcaZ?=
 =?us-ascii?Q?BP3G6nuqzNjPMKVqZJVQcBZlCeAyqwMMpQd+z+UtnGQAqF5V03jR+vIabtXw?=
 =?us-ascii?Q?yY6/tFB3XESJnvcVOTsfneIqalKhFejP07lmz8vv28eRtlEeZdiC/cGae7uD?=
 =?us-ascii?Q?ddc36yAg+FVLiVmAxz8g7dzNZmYJKVeIpCxkYK9yjEmG5nllEN77jt6DkRUu?=
 =?us-ascii?Q?Kl5v2erEp2YIWLmr1kQhoQJag5yH/U3Gmg412OqHFKSKw9QR9ln5BLQkMhDY?=
 =?us-ascii?Q?UCw9e2h5SEzKNi860abNXgDHtSy7uW4adPNkA9zFYN7jUAxCuBnc0ehI4Lqs?=
 =?us-ascii?Q?x2HGLKSHDH0dHTQiwQCGE5vJTWoiWtbWLM00Zq6Qq3kxKwz2cW2PCbwIdc3K?=
 =?us-ascii?Q?2VQ1qlOAU9cxJ92vkC2IgGGkVCi+QzjrkpbNgGc1vNWZm+7lIMZbV6kTYlFQ?=
 =?us-ascii?Q?SCMLIVC7BCQ0aeR7Yy5TcjSx43/45d+fq92MaLqWusEvutfU30HRcn+9dDv1?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f9c866-95da-4eca-77db-08de203abbe9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:22:56.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olW9OIIFP5dI2JzkHYuaoHzeuzdpkK/HK/fShP3TCPwjc1vJmDhYwb9xjYAwhGn30ApVyeoeKTW/RGpsczEV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Currently, the bindings of this multi-lane SerDes are such that
consumers specify the lane index in the PHY cell, and the lane itself is
not described in the device tree.

It is desirable to describe individual Lynx 28G SerDes lanes in the
device tree, in order to be able to customize electrical properties such
as those in Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
(or others).

If each lane may have an OF node, it appears natural for consumers to
have their "phys" phandle point to that OF node.

The problem is that transitioning between one format and another is a
breaking change. The bindings of the 28G Lynx SerDes can themselves be
extended in a backward-compatible way, but the consumers cannot be
modified without breaking them.

Namely, if we have:

&mac {
	phys = <&serdes1 0>;
};

we cannot update the device tree to:

&mac {
	phys = <&serdes1_lane_0>;
};

because old kernels cannot resolve this phandle to a valid PHY.

The proposal here is to keep tolerating existing device trees, which are
not supposed to be changed, but modify lynx_28g_xlate() to also resolve
the new format with #phy-cells = <0> in the lanes.

This way we support 3 modes:
- Legacy device trees, no OF nodes for lanes
- New device trees, OF nodes for lanes and "phys" phandle points towards
  them
- Hybrid device trees, OF nodes for lanes (to describe electrical
  parameters), but "phys" phandle points towards the SerDes top-level
  provider

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- patch is new, broken out from previous "[PATCH v3 phy 13/17] phy:
  lynx-28g: probe on per-SoC and per-instance compatible strings" to
  deal only with lane OF nodes, in a backportable way
- contains a new idea to support phandles either to the SerDes or to
  lane nodes, via a single xlate function that redirects to
  of_phy_simple_xlate() if the phandle is to the lane, or is implemented
  as before if the phandle is to the SerDes.
- Compared to v3 where we decided based on the compatible string whether
  to use lynx_28g_xlate() which expects the SerDes as PHY provider, or
  of_phy_simple_xlate() which expects the lanes as PHY provider, here we
  completely decouple those two concepts and patch lynx_28g_xlate() to
  support both cases.

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 49 +++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 901240bbcade..61a992ff274f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -571,7 +571,14 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 				  const struct of_phandle_args *args)
 {
 	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
-	int idx = args->args[0];
+	int idx;
+
+	if (args->args_count == 0)
+		return of_phy_simple_xlate(dev, args);
+	else if (args->args_count != 1)
+		return ERR_PTR(-ENODEV);
+
+	idx = args->args[0];
 
 	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
 		return ERR_PTR(-EINVAL);
@@ -605,6 +612,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *provider;
 	struct lynx_28g_priv *priv;
+	struct device_node *dn;
 	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -618,10 +626,41 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	lynx_28g_pll_read_configuration(priv);
 
-	for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
-		err = lynx_28g_probe_lane(priv, i, NULL);
-		if (err)
-			return err;
+	dn = dev_of_node(dev);
+	if (of_get_child_count(dn)) {
+		struct device_node *child;
+
+		for_each_available_child_of_node(dn, child) {
+			u32 reg;
+
+			/* PHY subnode name must be 'phy'. */
+			if (!(of_node_name_eq(child, "phy")))
+				continue;
+
+			if (of_property_read_u32(child, "reg", &reg)) {
+				dev_err(dev, "No \"reg\" property for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (reg >= LYNX_28G_NUM_LANE) {
+				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			err = lynx_28g_probe_lane(priv, reg, child);
+			if (err) {
+				of_node_put(child);
+				return err;
+			}
+		}
+	} else {
+		for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
+			err = lynx_28g_probe_lane(priv, i, NULL);
+			if (err)
+				return err;
+		}
 	}
 
 	dev_set_drvdata(dev, priv);
-- 
2.34.1


