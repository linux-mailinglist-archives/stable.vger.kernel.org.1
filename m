Return-Path: <stable+bounces-50210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F321F904DBE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D24E1F215C2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4A16C876;
	Wed, 12 Jun 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Du+nDq2M"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA245948;
	Wed, 12 Jun 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179958; cv=fail; b=Fn789p9WFq48NohfXdhE2Pr0iJooTvC/Ge5a+puB9lTEPOSCDcu6wJYXF69sYcIFmkdA4q8tyGv/J9Z7xModkuDHavSFoCF7BW5c+6fpKsIZsfACYkJ5z8PSOevB6x8zZKVj94h5el5cIYGLAqB8wkZ0kjyx1XIL6ezNSpfmtwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179958; c=relaxed/simple;
	bh=f5OPzfzU++w9m94FRWNU6f9kEaQXnVO7T/pAwtnTLFU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b4RHJlHDFQmN6ZZiohzpcJf9tSuVU1PY6Gdhvyir9CTJkUqs1HnseNcdfNyRpsSkXjwgpEo4gq+ccc0UBSl7G9jAxY/UhQhrfjxpPWLvqLbyPzOHtbwJG8HSAZGEio91FaF7demIJGDVU6hE0/qiqv6/G7ZCjCPmnDOqWjwh/bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Du+nDq2M; arc=fail smtp.client-ip=40.107.6.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfCnFQ7cw2MM7vcAI5016IPGqlPR91poLkWtPvy6CJG+aLv0ZjdqYndseGnlYYyCDBORQ25677jsXNAYv5YadK3DXA9m8qQ7UEC23lAimwEy0yhuQnP/D6JLNfzebdkKY0NJeQYJdIgxfoXWMWSwsaqUqJgfV+dlXxPdN8PBjLgAxZtZH7PDCUjFr2ROHDPW6qoyp/iszJ7R4Jg8y3Vi44BM0IWqcOxBAgT3KxrgdZUIkE5SENOfMjvzC59MntjdjCcJBbZBN1CmmitX8+na4zism37/I79/j69Uo665JU+qjZ45xqZ1T7rdnSJYGm1iIf8DO/TNdChqOgU2ELMd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUqfj8ucXnL9x3rX6r51XUh3SIM0GrPkK/ueJkalQHw=;
 b=jE9sfH9SM6X/zohWeoJLOhR2qe92WsN/EfyKOkRr3QKNSnXkIBbz796sEWTUqneYD7Q4pXiQ1G1uB9sdJFWl5gp4YXvjjXEMEZNs5fpizbZTQB2n26e/VHo0EFySy5AjbBGcNdUjGx/9cAjfHeS3Xt3TtX/XMmXig3dSmHlScVIu/kqTSMNqoQXUDtx1IxdUGuTODHJoYHQ728U97YQXj7MMdgzPw2PqOcaw8vOlDP/3TDI7sUjzl/BoAUSD2MTkdz64H8WFJYTnXZHndHgHD+0dgkj7nlOeUxBpTBlpDaTYPH6+80zCl59hn00mPkeuPL4TSt7z4PXVIV8SOoFlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUqfj8ucXnL9x3rX6r51XUh3SIM0GrPkK/ueJkalQHw=;
 b=Du+nDq2MDxu8LUAZd8Ey/IUdNHNL5RLn5otYj26lLyjjSPTLhBibcxIeLWkboYBDjY8Oo43U4PaGPjpOXuY87uyTsD5tWBpHrnNGK08BWRo7VkNLAQE/BuTK77eLJ5pz0sEM9jda4V9+IyGBKQyBdhEMzXZbit0mPfJCHZJSFF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Wed, 12 Jun
 2024 08:12:32 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 08:12:32 +0000
From: "zhai.he" <zhai.he@nxp.com>
To: akpm@linux-foundation.org
Cc: sboyd@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhipeng.wang_1@nxp.com,
	jindong.yue@nxp.com
Subject: [PATCH v2] Supports to use the default CMA when the device-specified CMA memory is not enough.
Date: Wed, 12 Jun 2024 16:12:16 +0800
Message-Id: <20240612081216.1319089-1-zhai.he@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AS1PR04MB9559.eurprd04.prod.outlook.com
 (2603:10a6:20b:483::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9559:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: a748f26d-1c89-4c9a-b1e3-08dc8ab768f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|366008|376006|52116006|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vaoihh+DX8sAWGElf/sOnBznEvCG8uLIb978Y95zPwPWcYKdPdxMLQ98sYwH?=
 =?us-ascii?Q?RnlVch9jMxAozhT5YiaMkI7K0iWd7Mgwml7v04IigRMR5hfUCLfLzJgVKj68?=
 =?us-ascii?Q?QRyrFPyE7ZCrHc0QTUQCUGXoNbvpo/AO9IViZDaCo8MLF4jmFD/LJK+Kq9uA?=
 =?us-ascii?Q?e1oChRHUuWxZLpKjzJnQHq3byfY/KD9qRw6jOxqIPg8N5L3IfAhz43Noo8PR?=
 =?us-ascii?Q?3EQ4kj7F8NBXrK7Yi1W4ZNFQ9Wy8QVbmyVSnRATa/ZpHTcS2cGY8vwVEWzb+?=
 =?us-ascii?Q?rx+6M0jfBzWqWjklka6F4ErRVuDXf0+3ViYX+rdWEsctsinBqZJxQEuTCGmx?=
 =?us-ascii?Q?P0pxa7Z3osJ8XeXYCLphNFdTCiAaBYB7z/yhk3u+NhP1C9Piuj5p4DDpX4Zs?=
 =?us-ascii?Q?kSYT8H5gqP5AhF4w0VXpY/wSMlbvzqByaE8W9D+bFH1Z4DZ6ewKAsiw3arev?=
 =?us-ascii?Q?TUUvX6mMwWSMN8GTMvEkojDhs1iE014ZizMrRt1g+T4HXVfrHVAwONFYTfjH?=
 =?us-ascii?Q?ceEUtyBExsvhBKO4MJs5Fxut1P4cKdP4xWu1/sPQy9SQ5OdWgXFtt/IZKCR0?=
 =?us-ascii?Q?aCYymjJ9TfFHYUVZPIyfyImRnLx45ynZ28SxAUOJF93SGTabmjRlb0zgpti8?=
 =?us-ascii?Q?1eM7vRmGPHzVA4diahi7gtjQB6uAyibRKqSKLJByfADphGbQMNt5uZIm+Jcw?=
 =?us-ascii?Q?aSR14xi4aINJ0r+ce2Q/dr+WerI/itD4hRLtaqoOX53Dsd5YDoIPi4Q7y3nr?=
 =?us-ascii?Q?QUlOw5i0eqleE4VP6OkTHgBzcSwnqKWs0J+qlUg+naQnyA1Wts5sF7xS+j4J?=
 =?us-ascii?Q?5E7AcseWfPmmr/DaqD8oPzKgfPTM6lrfKEesJgwr3RIY+MlkBC25JQVQLlgj?=
 =?us-ascii?Q?b9kAptuKDrjie8jX9/o8pmD+SzcL3SdBYYtK/NTHcrj4VsNZTknJVoCop5xH?=
 =?us-ascii?Q?meKz6TU/MfuNKBVOxHhEYSXJoeQCeo7JNJY9e3hD0/kvawj5XKonD6+bJmsu?=
 =?us-ascii?Q?Q0QfBDommtER9OGqCPcWIr68x72fWMHrJ30bTHYjzRKZ6SntEalTqWvcX62E?=
 =?us-ascii?Q?31Uq4En2oS2clapREL4wBnj0WLZPu/+E+KDDFwULG4obgKoX3Tg6umR/1PIo?=
 =?us-ascii?Q?pJ2ic8QeK8npEWs6LM5uXjt+7aOFqQKoeNEypKodaSjaxZEN6y8sn9lXD15U?=
 =?us-ascii?Q?nnRjrkDI/pAuaAUfzGC/aiY2N1chQ9H4c82u86CYGXjQ6EXRDoW1gdeMBCu9?=
 =?us-ascii?Q?7TOxBmXpShZ4z/05oYRRlLvK3R32ScuHYzpD9MPzem/sNvEGP4V4ZTFbrAmQ?=
 =?us-ascii?Q?FA8fYwBPvyPFHeYWUUXx0lMsCGuHrvFRp7ogOaCWZSvVuWLHGr4P588v+Fw3?=
 =?us-ascii?Q?8Jqf/6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(52116006)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yD8XECzhXPd0WOn7zc/1+X3uwVSScC70j4TFwwfp5YqGZ9NCJpm1gIlWTOGw?=
 =?us-ascii?Q?6UWrRnjYY2ve1ltYoCM+ycBZ66j1hX4gJTw+4umjEcuaULmeuzquHZaWcBZz?=
 =?us-ascii?Q?TPMLLk0gLIYBK1igf4wMdZwLyEraFR0J3qwW05K957SfDBPOGZ2kiwzhuudA?=
 =?us-ascii?Q?fKZoIwfPhKHlTwG17/1EZHUJQo7Ymj4JRZwHpdWuC5cd17IjENFoW0GRw2Tq?=
 =?us-ascii?Q?XunqfUp3nyPlp5r+s64doZh/ZmlcDTfayZXTZTrMoIJz+MZiCytSjOzj5Qjy?=
 =?us-ascii?Q?RNC+ElmHVLB6QVmFbV2E4HYFxtVtNPwffd63Qec8oDQhyLi2PEn3JHja8raN?=
 =?us-ascii?Q?k6bpoT3kKE/ecCHbjHO3EO/rOph9MwVOdmyyTdOAIrDzKUjy4i/KOxCVWity?=
 =?us-ascii?Q?m85c4AhD/gm9ZQALTyW8amJ3BmCDNT78i/LmYmo89008uRQcSj0uAXM0WoIS?=
 =?us-ascii?Q?8DAnJkN7Hgu1nRZjDb/tyvR3t/IMa70AfE92Sr68UppOhBr+YQVwzAyjw0Ng?=
 =?us-ascii?Q?tf8oHs/z64v++js+Bs7Yz+eI9SGsWz9ZIc8ybdehyc7zrG2oxnNNE4rqThsP?=
 =?us-ascii?Q?z5q89+zzh9byMhhgar52w9VYxZTGZMBEVnuML4a0fWdFsjf8NzWgdJW+u6RT?=
 =?us-ascii?Q?VwyrXpEVTAUS+QPCikc51iyHEy9xrEiG4mQ6DxwQbC2jYKvOxA6lOtu0N2L2?=
 =?us-ascii?Q?7fvzbes0vWlAe3yRBBmC8GbqxSsN6mvT6gU/Ntm0KZstelCMU6k0k/1LFtYc?=
 =?us-ascii?Q?CZXMm0JU3vGMMTznE0RlxqD4VaaZJlsMA5APeWN4M2vb++7emTKf0nNfrQK4?=
 =?us-ascii?Q?4xruSU8eL50RnctP2WeWOevV6QH2dJ7yNID2Ncv2yIWDYm6XZcT90RR8DzUi?=
 =?us-ascii?Q?PjzKpKD4smFmoVKcfJ7RIFmgwhMNH5jvJhtoXWsYW8TaWA4Hv66EV9X8TKbY?=
 =?us-ascii?Q?utJm0xMQ3kQJHw6esjMZirt53gPe128gevyDe+gMGOqIFCpEILSq2A3yZjLO?=
 =?us-ascii?Q?wqFZlarv1QYaUZOQ4QHG9hLv4WkAOxN7CjnQ6E9ISGrFXdEzPG75CzjgQPAF?=
 =?us-ascii?Q?nNIXxXB4n7wiY6LCiNfzpH6zoET5WWhCEOTiQ4unQ+Jndf80opeIembw9Aju?=
 =?us-ascii?Q?RFlyl3/T9sksEvrJkfs4HT2vm0p7r8G86BSeOEcNOCl/rKDFRGQgomSKPNAE?=
 =?us-ascii?Q?HqVNLB/qy/y4PMdcsCzQpl9f15nfET+uaVahfHM4sBJn/HpB9dVAKMPEvxDq?=
 =?us-ascii?Q?mA2m2XCUVII+PXUxlGDL4rzliju/vhIb/Rv2OeiuCYfPqSWD0L7bMrN4vvqe?=
 =?us-ascii?Q?KY0YeVv6XT2h7Rz+EEcbKRTWoR6OPigefXdcgHl6DNsL9ORp+j1w5GNZ1lTL?=
 =?us-ascii?Q?LoHByMKnlgaBGXtJ3lgjHqE5ECE2zAMNVxeTf7KJ/cX7g3MaQhS50HH+C202?=
 =?us-ascii?Q?oCpxY+G4d0mfjm8MAoSOIf4KxON0EWjpX9QRUyvvyGMVcstfrJAzBQDysQcB?=
 =?us-ascii?Q?rKMZTqiiK+dUTNKPMfUq/qOst1R7uogXwWdnn68BvBoECffe49udT9L5qwnl?=
 =?us-ascii?Q?jo427GT5NJPWmTTC57uv9T1/J/l3bU7KetRtuRNQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a748f26d-1c89-4c9a-b1e3-08dc8ab768f1
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:12:32.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnyQf4renci8OuXWPZZA4001VYJ2a0EmM6TMuUC6bXDrubbYp/MIoSKpN6PL4OKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

From: He Zhai <zhai.he@nxp.com>

In the current code logic, if the device-specified CMA memory
allocation fails, memory will not be allocated from the default CMA area.
This patch will use the default cma region when the device's
specified CMA is not enough.

In addition, the log level of allocation failure is changed to debug.
Because these logs will be printed when memory allocation from the
device specified CMA fails, but if the allocation fails, it will be
allocated from the default cma area. It can easily mislead developers'
judgment.

Signed-off-by: He Zhai <zhai.he@nxp.com>
---
 kernel/dma/contiguous.c | 11 +++++++++--
 mm/cma.c                |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

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
index 3e9724716bad..6e12faf1bea7 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -495,8 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	}
 
 	if (ret && !no_warn) {
-		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
-				   __func__, cma->name, count, ret);
+		pr_debug("%s: alloc failed, req-size: %lu pages, ret: %d, try to use default cma\n",
+			    cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
 
-- 
2.34.1


