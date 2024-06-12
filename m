Return-Path: <stable+bounces-50192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A805D90491E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1895B20FC9
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682CBA31;
	Wed, 12 Jun 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tvq3ItJN"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA21CABD;
	Wed, 12 Jun 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159935; cv=fail; b=Fw7uERQhCJrO5J+g5hqVa1BCF5iDYkAEqQRUMYP7UKDeyRbaNOOfcB/2ikVNQ6Xmnbt9UOZZ8mGUnlLnGiCtjIe/A3A7htyg+q5tnmjMPVwmrW5ALwfdZoNSOv8X7LqEAw3odqhe9jMkRdjlNVdSRm9X23W8uofSsRAp4ZqdrQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159935; c=relaxed/simple;
	bh=SQuHSsnJ47ye4SErwYXDm1ubNhKdrCa8QuR24ENKee8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fq37TiF7yVgxkD2UFwLIUwD9Oo4dI4tElwupr6+N/nDz+DoutdQ/PXW8kMDed1df0dvMcItHn49ES462Sl1anSYbBz+ov2GNAqkHOrnwBs2K9KASgm5pbOLNFHF2pYoCmIujoHSeszPSOSanAVvrplEMUH9s77CjaGmRhLUv4U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tvq3ItJN; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Mkau7zz75KKjp/h6uzmx+lRXtuYgTFnVtmDhOe/fBEoc86uI6HKgcSR8PdlJBsKlf7J4Q5IzxWvH0xuP1kDVoBbPQJfk2OQ5vZtw+4mFOkJNytBIIpsmuL92sPxUZarDb2mhifxGGQzyo7oKcEoDr7HzvwWSqhEC9iqMQinP3SS9+EyX4vozd7LltTEcUKjIhfuQk5Eg++Jqav/z/PZgUbZi8HFBXx44Ylw4v1k4jDdiTcglbJQj/SCOvhIRdCcrT//iV/W934srt5flpJEaEIn1Sp4n44b1u1OuWvIo9oFGH2eRgmcRV8SD21/mYmKuEa2gmov9X8Pce6Ecm00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziLjCjMD7o8TSzBfz30Z5Zw9V0z0CkBJy8oAIOtcWhY=;
 b=MM38ETuo00KMsatH+kNxi3A2CWQhjD200OB/D8vK1PpmlR6qTdxh4olOT50fzS4dsikTJFmCalag8UpmpHMJ7Jq3km40hhLGHLBTweDPqb9oOmBO05QEozLzWY19sflMd0k06yUMdGtbyhBn1GABn2oz/izpeMut9n3khaOcbUBOGOCgbW9PUHmvNymBbxdwYsiBjDAIMvQm5C11jC0a1r/lalqrDTgcO/Rxb1OGRkD4uAKWcQ0o9H4O2rh5trSDOLWhFvIsb846E+7kMKPkRIyL5VcKJobr9jBAS2zPMPqsXc/59XVPrdf8Oe5KMlmkrkfXiWtxVgqb8+yK7ccjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziLjCjMD7o8TSzBfz30Z5Zw9V0z0CkBJy8oAIOtcWhY=;
 b=Tvq3ItJNkDEVHesKg0gkQT2zvdP3n8kuXojK1y2KW0g3w2siQFZ3DYLDFGjKlnQ1Y4fQGEjtgna8E43NJq5irJHxwKkP8U5pOn/sfZoqerWXDIGskVztqno7fGR287gIHyNAHhruKGuxgELkDNh6IW/B5CPdBNN4b25m7cbgNeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 02:38:44 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 02:38:44 +0000
From: "zhai.he" <zhai.he@nxp.com>
To: akpm@linux-foundation.org
Cc: sboyd@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhipeng.wang_1@nxp.com,
	jindong.yue@nxp.com
Subject: [PATCH] Supports to use the default CMA when the device-specified CMA memory is not enough.
Date: Wed, 12 Jun 2024 10:38:31 +0800
Message-Id: <20240612023831.810332-1-zhai.he@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS1PR04MB9559.eurprd04.prod.outlook.com
 (2603:10a6:20b:483::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9559:EE_|DB8PR04MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 928b24b3-15a2-414b-c362-08dc8a88c6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7lpR3SDkjv705F28is8+kY3K08saQUSYw+trKMd/ymWKnzMIR1neOM1wtFB?=
 =?us-ascii?Q?Apl3WJybR3yhUVNk/IYaEbXxVtlb0O1IuIj7UAHW7FuuE6J6qgG8j5aWh8Pl?=
 =?us-ascii?Q?pZAZeesKkTlnRDJcK1h9hnCgisBSE6X4VkNpKpzAPWKFIZSnJ50g8xJjC/b3?=
 =?us-ascii?Q?+XuNu0SH5fdb11juD7TOD117VpzWd02tDyyzxqLOG0Xw2pJMKcd1Qn/8mpts?=
 =?us-ascii?Q?2TytvC8opnOQr3PF5AykD1sQ5csooTlPA19Dc+M4Nwruv5nKK+JiHvEHP2yZ?=
 =?us-ascii?Q?vd+tjAOuReZRISMv/dkukQk/LftS3MRoC+4ArFw/GTUlcAGgvuBa/skrGVIO?=
 =?us-ascii?Q?iwKuLR32rZSiTLPeGleO1jx1v7rg/0RJ3tAF4Q6zX7MjxlFv4coE5Ja1EVHi?=
 =?us-ascii?Q?pUTql8QYv5C4CRaN9jERYU0sFkowqPSLmpzDMAIGG+EUkPceEysGR3KGN39T?=
 =?us-ascii?Q?c9KitKt3aiYhK6wv+zJ+m3GzO/959qR8acmUTRGQEzZzJF7/ypu4gDWpTiE2?=
 =?us-ascii?Q?xZK3d9l+5d2FmWBLAxLUnjpfD/TO6/cordU9CMJVj6n8JxkpvhA4VVjQJ4MU?=
 =?us-ascii?Q?1ovKoZMm5o8VSNb0hgbpW+13ftjGDopBql9ponEefvLr9c1tTcELjkFxm7C3?=
 =?us-ascii?Q?RQ2vjVUhZ9fBByHaH7ppeCkRXfaaZdnPuwHhqbGxS5meLwMCeq9Ti+85koc+?=
 =?us-ascii?Q?C4SxUnqn06s02PL4CefR9QkJu5dlK1MXbfRLPc8WcePY238j9oB96STjsIxO?=
 =?us-ascii?Q?IvgD6uXy2hym0N4urQ+UV/dl2FH4R9yGbCOb9+7SahGsu6ragNtyTHRRCRmc?=
 =?us-ascii?Q?WM4UoU89Np0BFCWRi/0IRvBfHbAPdQtiI8mkJGltipffRxER2zJLnxMlymJj?=
 =?us-ascii?Q?LXccIr6BzJBhAJmUvT3q/p6G0A5z20NTiB1YQilwbMflSkP0yQLoDmPpn7yY?=
 =?us-ascii?Q?rCNLVcK3mC6Y8D/PuNsSMpP5rrHauE7CYCsRd7Nb+elY0PbX17m1Kyfdnfz3?=
 =?us-ascii?Q?OG6m22oL1nBmppMHdzrNmN0zSDnGpTFSdsxzwkerQd4RlVVSx8T/7akKm9su?=
 =?us-ascii?Q?FTsdreWTcDf7DgaL9qNTmUC0cK/XvYES96R/seIZeuYvtMbVXqcApm1gl7ES?=
 =?us-ascii?Q?fR4qURbfgE+qtrJbf+6iC1IG6fxb7JF6YRUeN8vAyecgIFTJQEtAMyDFE5AV?=
 =?us-ascii?Q?DrV5IPepcBTHqpv9KexMcR69yxPyWhZ0UDw8fG9lz/ZbP8lF3yPZ4LoMeapC?=
 =?us-ascii?Q?YSMc4Fzcy+x1Ya4R/z7OprXetzWPZt0+RHUjqLTj7D4f95XeId2ppzxwrkrT?=
 =?us-ascii?Q?io+6n5ATSa1cQ8ImqCd0d/DzeIH+RAv2kZc4GFsU6UIj4yX42AmEeue4idwT?=
 =?us-ascii?Q?hGDYw+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OvApplCOOhiCPHip9/dtmyZZofZAei7791ury4PR3rvTgjheTwgM0NPkyZUY?=
 =?us-ascii?Q?YRXyMovEPPmDLI/NHwAB/ZGCoTa2dM9HrPRnwCaCyd/4LB34EVML6sUeetZU?=
 =?us-ascii?Q?YRe8tbFJJ+3irWkH8zSuELUGLM3n8PNdSR5V1/Tf/eCcB3lmUwojnCcDIXuq?=
 =?us-ascii?Q?GNj58+aJVHjsrz0SRmvKhRUTnoQ9gesr2JbNak2/9spRqSFBNWCNo8O/Oc91?=
 =?us-ascii?Q?+K5GwCE3213TXg4fHqxd+YIwEc6bD7cwTD2VViqwNieNplKg2pdayzdxaWU3?=
 =?us-ascii?Q?k4nsHxXt96ds4HPJPJWElXESE9eIHvu+0RNOBpqqxsiWv4Vnxe/bg3rbhZwu?=
 =?us-ascii?Q?0nkR50GfoDyenHIQxcDHaeal6XA932PuH3ne5KN5eC/t4CufB1Z4lGOD6elb?=
 =?us-ascii?Q?ObVhZ27QQF7EN6XlTyLO8LYJvFLd/b+YuQA6jE9J4XI2/QPxt5B4J3SQ6pTG?=
 =?us-ascii?Q?Jq/MpCIt511zlzvsstFylSEdtevzkUM4R4P/XuGJLmhkKvQ4vLGrTGueWKU7?=
 =?us-ascii?Q?QhCkteijIhn2eC/wkxOYFB3iy75DTLLONgq689PXfk2NsmzeqTdujaclz81X?=
 =?us-ascii?Q?hivmrMtgEYNbOVQQhLh/4HUfj0FWZaDf1uUvadasB1/rZlJ/Sjl9H1jCDtDG?=
 =?us-ascii?Q?vMFq2xsJ4lwqi5ajRFpxPqpSrfybqfAzxn+nnJ3sR3aPwJZMmx/4o8gf5OQn?=
 =?us-ascii?Q?ZYw8WTs4mEmyFi6NuzSpOFRU24HwxLp2sIr2nKHkNcgq8oU8Fbq27jM/sywN?=
 =?us-ascii?Q?iK9hb2PD+z6eXF6faZHp62aTELaIslsa74VPII7kJHdhXQ4KqDsWDNBv/utL?=
 =?us-ascii?Q?Y+EN+oOz4QnksYCP2RqFb1fsXCbhxTJdn5Uym/FnAHfRcYGDV6oJ4YDaEfUL?=
 =?us-ascii?Q?5BhVuVTNctBD1nQ11cNvRBpUT7WW529ILtEBBInHeGLRIlf1ZWhYXzeWtcRg?=
 =?us-ascii?Q?z7EV+avy5kmjDeQGn/8Q6oP2XY3RYzoMl5NgApsDjed3UDmjsLsQ+t6WHfB4?=
 =?us-ascii?Q?vaxdg4ebpZzKd69BzLPuBoklAv5jIZJn3Fq4CpuyMtPkhdWty/vgTv8J+avh?=
 =?us-ascii?Q?bXf59x6rJirdmYafgUOTrGCV1tr8MNFeRmUP9Fu9NhRZc0A+PY6KRuAbt2jV?=
 =?us-ascii?Q?4491OXRtOBa5ow7BuweU9sST/niV9Kg+6TFGwrWvIJefqD+loZABeDAvsmWu?=
 =?us-ascii?Q?7l393tqSCQS2lGadY4CUEMoVnlGx+a6cCiG3N7CQ8+57ruVA5jtAnHM1OBqG?=
 =?us-ascii?Q?c9w84lhybmMZvPufCTAY0tHampNuFRdAMnRbgognkbuAnBVEhZcLfdd7fyZc?=
 =?us-ascii?Q?9FtaCR9YuCeywLHhEBAax76unxbrFgU/edKbYjZO8l8AVcueFnlk/jEs6Mgj?=
 =?us-ascii?Q?xBgKLcmnIPJ/AgwPNxH0+0xb0cJhW+bbNU2Blt2v2N3antSlxFgU+rmLcqo9?=
 =?us-ascii?Q?VmiZN/31vSnKui3TdSLOrIe3/ASSk+jVHCF75Yo+4tmj+arC3pbQ1F3zCbYl?=
 =?us-ascii?Q?hGz4mNBVzekdwWAzg+4aA/KMOexAkmYgPgmrL/Rh/7AmqdBlmzdA2yTgOLTf?=
 =?us-ascii?Q?fZUmtIbEOxWgb2QLQElYThaqksdVpOmUmLBMB0gW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b24b3-15a2-414b-c362-08dc8a88c6e7
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 02:38:44.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74sK/BgPjPnfuAHYquVateAZ50sKnmionShCjW4Fq+jawgQx63aXFPT7ieFcCMku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050

From: He Zhai <zhai.he@nxp.com>

In the current code logic, if the device-specified CMA memory
allocation fails, memory will not be allocated from the default CMA area.
This patch will use the default cma region when the device's
specified CMA is not enough.

Signed-off-by: He Zhai <zhai.he@nxp.com>
---
 kernel/dma/contiguous.c | 11 +++++++++--
 mm/cma.c                |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..e45cfb24500f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
-	if (dev->cma_area)
-		return cma_alloc_aligned(dev->cma_area, size, gfp);
+	if (dev->cma_area) {
+		struct page *page = NULL;
+
+		page = cma_alloc_aligned(dev->cma_area, size, gfp);
+		if (page)
+			return page;
+	}
 	if (size <= PAGE_SIZE)
 		return NULL;
 
@@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 	if (dev->cma_area) {
 		if (cma_release(dev->cma_area, page, count))
 			return;
+		if (cma_release(dma_contiguous_default_area, page, count))
+			return;
 	} else {
 		/*
 		 * otherwise, page is from either per-numa cma or default cma
diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..f225b3f65bd2 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -495,7 +495,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	}
 
 	if (ret && !no_warn) {
-		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
+		pr_debug("%s: %s: alloc failed, req-size: %lu pages, ret: %d, try to use default cma\n",
 				   __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
-- 
2.34.1


