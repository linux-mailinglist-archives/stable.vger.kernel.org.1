Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F77A258C
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjIOSWq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjIOSWR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 14:22:17 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5F1FF5;
        Fri, 15 Sep 2023 11:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipUP4KQafOaRjYRz1vPJ7HdsTbgboDbT813AjW1pdlGGMkyUm0W9J5RQZ/O4Cj2VKzTDwbMQ2F6QwZHhcPJo6/THN79TUyqX9PZ4hw91xN/IE8PgPaGKdDsQDPrZTIV62oCLaE5mIRVQLKrQb6Z71ZktNfxvD6egkLTHNUD/ogs9VCDKISheX5VWFE+kHVgWvwGN5WeeITxKVdsuoCQf5xW/CCaCngl4UOfgstgx1BvyEDbI3v+pfn4Gtde1om9xYMRKFr2HZNi++EEAIZyXSFkHktn1X2r0ULaO21YOtOmrRNfQDnwgu2+YgYwGhQw3umWd4gRwzzfdPAp+Pn0WqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL23yudCxp5H9cLbs3EOICK63clnf5mHeA3+GoydjTI=;
 b=X1JqWBu7vPDXRwaXzlsoCBVwx+3KAHL83QCaPr0994MF9mwwNBWM7HERg9Xt0cORjIzdPF5mKMPCh4RqO7fX/IqmovniQABoPkEVsAA3FfNBVcyC8Aod/6V4ye1NZpQ9tuBs0MhWoWwkpFZuco9kzDP3LhOqX4gX+czAatbeDl7KKHWoa0xR758b/uzu7fx+gKYc67BPvxsUaN64WGblR3J5lnHBUnRuDU0j6mv12FdbzJ2K3eekudwSuHHwN3h2q6UmxjYK6NAuKZZDGapDiGUR4kiFfvVaGgKXRiEzpA/uCXm2JYyIfbioaLJh+yqx6e80QXT863vFd/t+soxpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL23yudCxp5H9cLbs3EOICK63clnf5mHeA3+GoydjTI=;
 b=aK8U1TByZ+tNFY+WblCsDNtmoyfLZSRrCU1kIjtSQsiYD24mWvUWgRwtoDUVGIzYuVbG+/hZtOCplhlOBifEvNR0eyOsa8/7d6RwjsJbEaKGD9XPOU0cBNEm2fgQMSiXuiHi8nQxtkKC1/jQqQHtOTVYT5j5weCEVGBlFz6Seek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN6PR05MB10209.namprd05.prod.outlook.com (2603:10b6:208:46e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 18:22:04 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 18:22:04 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     stable@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexanderduyck@fb.com, soheil@google.com,
        netdev@vger.kernel.org, namit@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com, akaher@vmware.com
Subject: [PATCH v6.1.y 1/4] net: add SKB_HEAD_ALIGN() helper
Date:   Fri, 15 Sep 2023 23:51:02 +0530
Message-Id: <1694802065-1821-2-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694802065-1821-1-git-send-email-akaher@vmware.com>
References: <1694802065-1821-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MN6PR05MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: 09523f12-caab-4be2-8bb0-08dbb618a980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWCea4zBwoKSC7qbKUhgLI9ZLdJwfwjajV4u7ppgP01UOKroBB5CU18ziWyK5m52RRiUSezHQcriRJKenNHP/CVbZUSqePp7POXiZAmNB9/Kql4xZNx8mTGesOiK+oJmTFE5EIdFyCLljPg6w3dP6Ymq6+xlb1ZUgytLbZ+BM7meAqSnKSW6hPBP3CB78eSRF4Z/7nh/A1kCh3F776h4Wiyvstv5LHGtkuxICPZPEs+xA4hXflK3IJ7FPfkHUqmfyj/C3m3Y+TKDTlI5oT56Ph7uY/uHqDNTk0yVQDvFjvxs3ihp8+VXMOJ42OOL2CMTOEDJFbWYKG2yv2MmVag3LQDSoAyyBYaFz3OFLjrV/0//YcIYuoyJPL47oDMbvTgKwtq7GA6Wy4Ryeb9G8tRZKX/n1JY8Yz8LVDsqjzff3QTQ0Y/xfKGi+aR8d6d7ZZDiQJIhVF0P6GszaIDQyaEl/hHyFMa9P0jORWoSNC0ryU5RtsZGFuu+GZSQqcLoI+OUOjKLdcCN6joHzvqW/DSvx/5oPSXqkSk/O1Fb+M0bRgUs+kVnA/3+kYuUqHt0kbvKlvdOUCvZEPCoiSJUimxI4U7FwJRS70vbniD1QPJees2x3OatkLHiD/EattWi9R9Tb5yB8Zp6Km+ndAQq6LA21IqqKvPn7aqe5L3MBFqFx3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(86362001)(5660300002)(2906002)(8676002)(8936002)(4326008)(6512007)(36756003)(6506007)(6486002)(2616005)(26005)(107886003)(38350700002)(52116002)(478600001)(38100700002)(83380400001)(66946007)(41300700001)(66556008)(316002)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IbcO618SWgPAh911jF3mwqbB8AqTBYCLieuyFBzp+kd+MY937pmzX6caEG4y?=
 =?us-ascii?Q?d9CBH52UtVJ09zx/h06p7HME8gVHkrTlA1UkFGY0cI2YyfpLlRmqQg7FE7nc?=
 =?us-ascii?Q?NUtC0VnDbeOO3CyRqLzzh5NkhyQpSVxayqm/Rco0cPKji+wQFKRAlL3rkii5?=
 =?us-ascii?Q?o8puZ3bsrHkmz0s2zMoPsH7v0PCiPX9x+yb3LnnuHAF+Hl2ZakJtHxuuSZ+z?=
 =?us-ascii?Q?InRjDFYqwRe0FEDlDTw67Y0ndVNQTE5h+0pqeda4l+eOEXUYLTNLdR+mnGts?=
 =?us-ascii?Q?+U9hPqXZEMTk1R+Ss0PnLuF6i9HT9an5v2o0JMVv7O3mC+aIvHLLbR+bCOvn?=
 =?us-ascii?Q?FX6RFycaeM3g6REAEs+nGyh/tJiCccDVdGLmRA5cMOLf2KHX5ZOetAn8qLL2?=
 =?us-ascii?Q?dajHnTz2uRpNj3nlI+Ig3aqVAmR/QJZ1OJFs9DEZsou15NLO/NkD3UghOtJM?=
 =?us-ascii?Q?uQli94TNSUHyYwEskOmEL9ytJ2pVTADjIT5qAsjeasWZrEF0/40bQcDunZBM?=
 =?us-ascii?Q?km7AEawGXM5nPkB0qxMYE7D6Z62DvH925opjVSSPBTO4fKdQRSf72SzEScX4?=
 =?us-ascii?Q?4HNydQkLHIxDY2YxX2d21WMmhSo8Ere0wSdq6dVgpkFQrBm53mb7RBFjhffE?=
 =?us-ascii?Q?jWRhynCeRnvngpvZUEjc+TA7tKBZizSjZlTygWfR9r9Ble7LET+K9QT7D8vD?=
 =?us-ascii?Q?fu01SDWbrXy1ZRa0yBqiFD8UB+srFP8w8H1+H1FmRXRtbldZdgfQrJTynmIa?=
 =?us-ascii?Q?1/BGSv0yJhvzZsaZYvTfmbG3baDHR2LwfNOqmkIh34GnDEPjVgxizMMb183Y?=
 =?us-ascii?Q?ddyRPFEzkWmcy9xi4B3+HDW9fQEQpviFVc4xhfD8TJvaOmS+VtbuQlQ9U5Ic?=
 =?us-ascii?Q?TOQ3NBZfh3O0nKf5cnpmpraFmAcR66CREFg/6tlJBYiLPtiWcz4UuKOV5t3C?=
 =?us-ascii?Q?tlAb17M45XMVtvilJnF3gJNnD/KYeqdLskLZ6SrWIl/EYTs+xYyR+yI7Xq5a?=
 =?us-ascii?Q?SghQYblIeZcCCW2WVfZlD4R+giYAIgfsCRMcAKMAYlxrZ8spCpXU/hLSHLv9?=
 =?us-ascii?Q?+KPXGkpzVpFxowZDQ1eb6zRU/ha+7zIL3/bEjDBxgaNt/dZ6ZaXURs0/I3m0?=
 =?us-ascii?Q?5+jEmY040pwX3miD/5e+/G1ah8N19wIsh6QADd2lStmy0/PWKYO+cOMSkIru?=
 =?us-ascii?Q?RZRv+OXqrkLUBpTtbIAkSpG2MWFHlAaz4JrWQUEATXVOOwV/stbTP9cWYIaU?=
 =?us-ascii?Q?pv6pulEUowZmVKQf/+eoXoha4jzd+c4iOjhvr9cjpKedIb55OhbhAZJhw6Jn?=
 =?us-ascii?Q?oT31zfRKvn5wBZpusaLOoJONGaT8DV9Po2DCi4J/iv97PEppCwhPf8Px/o0z?=
 =?us-ascii?Q?xvL+5IcnReDM93vR+CxRtY1ZPXGYD3tJjiXeZBVrcd3GgN4FTDU1Izhfwz4X?=
 =?us-ascii?Q?CJnz6rJejeBzeCxTh17RkbCl8C0guvpPxVr2fewEtTSPvqpsQAvIZgL2yqVO?=
 =?us-ascii?Q?0Z8PcwiTM8NWfM0/6pmaYpsWVc54IotHcav+FB9HA1lGE1x8nAN0NPk1Xg9w?=
 =?us-ascii?Q?93JdoJRbqyZ5p3UBQZKGgfmq7vCjRugiw0iIz2d4?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09523f12-caab-4be2-8bb0-08dbb618a980
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:22:04.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyO3MqXroToSkVz29w5d/++F7fB+rVwyoqD/xohdSsfiymrXmkPg1ALXnn3v68hSIDNEBGWHg+rxK/kxdFvCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 115f1a5c42bdad9a9ea356fc0b4a39ec7537947f upstream.

We have many places using this expression:

 SKB_DATA_ALIGN(sizeof(struct skb_shared_info))

Use of SKB_HEAD_ALIGN() will allow to clean them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ajay: Regenerated the patch for v6.1.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 include/linux/skbuff.h |  8 ++++++++
 net/core/skbuff.c      | 18 ++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cc5ed2c..2feee14 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -261,6 +261,14 @@
 #define SKB_DATA_ALIGN(X)	ALIGN(X, SMP_CACHE_BYTES)
 #define SKB_WITH_OVERHEAD(X)	\
 	((X) - SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+/* For X bytes available in skb->head, what is the minimal
+ * allocation needed, knowing struct skb_shared_info needs
+ * to be aligned.
+ */
+#define SKB_HEAD_ALIGN(X) (SKB_DATA_ALIGN(X) + \
+	SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 #define SKB_MAX_ORDER(X, ORDER) \
 	SKB_WITH_OVERHEAD((PAGE_SIZE << (ORDER)) - (X))
 #define SKB_MAX_HEAD(X)		(SKB_MAX_ORDER((X), 0))
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 24bf4aa..4aea8f5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -504,8 +504,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	osize = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(osize, gfp_mask, node, &pfmemalloc);
 	if (unlikely(!data))
@@ -578,8 +577,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 		goto skb_success;
 	}
 
-	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	len = SKB_DATA_ALIGN(len);
+	len = SKB_HEAD_ALIGN(len);
 
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
@@ -678,8 +676,7 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 		data = page_frag_alloc_1k(&nc->page_small, gfp_mask);
 		pfmemalloc = NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
 	} else {
-		len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		len = SKB_DATA_ALIGN(len);
+		len = SKB_HEAD_ALIGN(len);
 
 		data = page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc = nc->page.pfmemalloc;
@@ -1837,8 +1834,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
@@ -6204,8 +6200,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
@@ -6323,8 +6318,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_DATA_ALIGN(size);
-	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	size = SKB_HEAD_ALIGN(size);
 	size = kmalloc_size_roundup(size);
 	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
-- 
2.7.4

