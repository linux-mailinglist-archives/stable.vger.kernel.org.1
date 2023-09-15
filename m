Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA47A2590
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjIOSXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjIOSWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 14:22:43 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013013.outbound.protection.outlook.com [52.101.54.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDC1FD7;
        Fri, 15 Sep 2023 11:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4UE0z2mO2sw10QcABLPNl8x98+BiH7EdsUAABIXHZ0J3atsyOFdvpyB5v+JxOc1bo25je1SoI//8yioKIXmcRGDfxy+u1Dw12nRPQFo23Oi6CVETQfActBfg3xwx69D/iKbL5HdNvPmfPrHmZhGeK0SAG2o5zE41GhbQonAklHIk7P7G+ExmEi/r4mPnvcnalfiTfIjLdfb9NF/EYhZG/CnAFNUUjGCmtV0LdoaTTUacfyhq0etNSd0uiZ8GDQBrebgetRbQm97p4KE4WGpfwO//pLXQOJDAncEEqoM1xeha9UtVcw5yzLIFkNcDfrgoeqh8+2N2AebPzSxbfv/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU/QmZmpJ9w+6il1KumZRKE5H8ISEDfI30VUgmpYsr0=;
 b=FipPjaNXbqa17f5M0ytCXXueNxjNUnAeiUao0OfuUQnH3U2RCd/cEOy3z7r9c8bS1kIgz7HextmH1eCKdURH9FJkkDfP0GJiKycRJk6ZNbBre/0oyWE3OqIqzb+gbLnxpC/yRNcDGGjUKDdkmcqpyJ6wfXWf8QL4ifJNo0PR6zeGXq+5DWtchSx1xEAOr4NSD2mgXtiD/25y8KAGk9au+Dj7OA0tu9iV0lG8s0CPwRUPd70dbXl9bb/aN3R+1EAHok1oUAQo51wBaYZ2NrZ/PGCVFPVlrMofpe6Q3a5JJERLmReuIHMW+4Cll5idnUwRFi2g5AIY8s25i0i+K95uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU/QmZmpJ9w+6il1KumZRKE5H8ISEDfI30VUgmpYsr0=;
 b=d2i4BAYnBlk2xnqkjC+3yXAdGSW07g4IFk1AWCX2s2z8s9YfQsMANvIRo66gJH4FQCvkdnoLgi8RXbYdNDBwkg+QmULA2zj274rnY1O1BrTeq5nlLPrqnsFH5I/gZptMwM63X86GBZgCfgSjhJ0+rhmvJys1OnJfxHfR1PKWufk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8524.namprd05.prod.outlook.com (2603:10b6:303:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 18:22:29 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 18:22:29 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     stable@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexanderduyck@fb.com, soheil@google.com,
        netdev@vger.kernel.org, namit@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com, akaher@vmware.com
Subject: [PATCH v6.1.y 3/4] net: factorize code in kmalloc_reserve()
Date:   Fri, 15 Sep 2023 23:51:04 +0530
Message-Id: <1694802065-1821-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694802065-1821-1-git-send-email-akaher@vmware.com>
References: <1694802065-1821-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1402493d-599f-41a4-a71e-08dbb618b85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8IBr/1QfWdQJ8jdZIYLo3PmV2ie5p60j7xJrWf99uvfw3Q3an8etS0WNrF23yn7ap6wIVckdOOTicOczLEoWStelj4VpfhWkhSpdSBpxVvWurw175iMxH3qozRGNELaBs98/8GMFy2N3JI3tY3GsPwx2xuZJQrXNTUHcRWNHD41oDiZ6yFhq0L6Gb1E0xSLQ6YLVS3gtjIqkOOsL+X0aaQxV0GQQxZ025rdRAtOf7W1QLqrj/E9hR9gBQa/CHdOeRkpsW4NTROKqkZc5SIkoytWqZNswPspOLhPxQT68xrMLZCX1KjN6Xw23TdnNdN7KbsMgtPALYXkAPC51djiD4uDmQlS37Ay6rTSVpnwxzVlOsNu7E08JYU2gpCVei514W2BS/2hbiCybVvXCnWtjZEGJdTSLReQGhVO92keYUZ94H3Qov/71brkTogY8VkDkYDNbT9PcRDyJFeu3o+80lNH5TM3Y+GtIgYAkQzH0KulfqtI6rgpprs2O/3/flixI9tACoxZdY7AH/MPeJxmcKtQvRZ+oAKjIIDc5DuZOWxe0rwmkof71w+TespkE5NO8/syuft+WtIm0HdpUvDR+8QDLdZBAc5S2wypyi+Cgqms2u2IO9rk+g11/XLwGePQQEAEDZEp2j2iXwq9YpN3SCF7ZHv2YhNw6bOCmx6TCDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(36756003)(86362001)(38350700002)(38100700002)(6486002)(478600001)(5660300002)(52116002)(6506007)(66556008)(6666004)(8936002)(4326008)(2906002)(66946007)(8676002)(66476007)(6512007)(83380400001)(316002)(107886003)(26005)(6916009)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CS6/2CfOtMSIyz+zKJwYQZTogxFIPp42F3C9XmFUNGYNoengect2BCu5SCS?=
 =?us-ascii?Q?tjFcJL/bqWD2OL7mm3R43UvJbPuDAJfvZIJqZwd6YJxCrIHHZeiYAibhy63m?=
 =?us-ascii?Q?MUBOBfwvMdRtvuJPdTHdZon+nthJ3+vaQGhDKIwvsop0VZrU7Po22OlHNjyk?=
 =?us-ascii?Q?wIWVQP+RcQg+ow8By/6raKNboDjmOngJ0R/E7srR9TlAM1TEfZgZs2zOZ4mZ?=
 =?us-ascii?Q?1aKvzxxhaXallNU7kX+jS/imehkUcIUponW5uEx6nwgps9hRDDvD1OubZIID?=
 =?us-ascii?Q?Axr0ZsbUqC0GF1p/zLrzY6LX9b80WgmPNVHlh3uVhGXB6GO0uW6x1AVRO/eW?=
 =?us-ascii?Q?IGgglVoJGE3t6vhgRQwfsEhfieE2t0mDK1L0fuiqM6FpG5uKbwxl2KqXeEM0?=
 =?us-ascii?Q?vTYfT1HeIp41imKNjx5BKbHe7XxcCMXJIBWvRR1wskh02JrF7/pmf0Wjw2Ya?=
 =?us-ascii?Q?HQ331UXST44pHI+fvR2Xr40u5V/9URxpYx1k8QupuhlS4ZqWVX0yqqqMUz+J?=
 =?us-ascii?Q?Q4QH1zmNuYQ24Piw7fmKBXZvxoNA0IryjYdY2kWSPTegn73c+h7KFNFVcM7M?=
 =?us-ascii?Q?rLtW8+fE+XLJrBLLrfHXgYqTrdTzDf08jZ1jC8rRoeMPDz5g9eG5CUIYp3vN?=
 =?us-ascii?Q?mWIj8hxGc6L7939g+PCnc21yOawznfk+HJfc77eTkkxySthPjUAmBH/+Ej1t?=
 =?us-ascii?Q?5TjbzmTllCmzVz+HnTsEbdoaok9Z4uiA0U2FJqO/US89PAYOV/T9xKuJlXBe?=
 =?us-ascii?Q?qW+IY+40Tbe3cpFPaOd9DDqG8iLVM1wQMmIgqLPZqFQAJ7A18E5H5VUiqK0N?=
 =?us-ascii?Q?YJiaOyR85NcyrDVWzilHdqYAeXJ6yhtCYgLd+X6KhlOYXp4ctXpMMa7qGbBZ?=
 =?us-ascii?Q?MZs40TW0C5jB5gZM9r65o8HFJ7uytMNZJJAHbm0rtuYm/GmZhYxVhXp7qdVb?=
 =?us-ascii?Q?90/OTfLdgzLIKixxzrgnUNBhmufFZvWE75oCOnGtY00PSISjDzXvWfcekW/1?=
 =?us-ascii?Q?U17awcfXHvQC9xJds7JFCE8tIfOvzkTmnuCh9MGcQS9imFY5uJSMAIx/cA4O?=
 =?us-ascii?Q?jFMfC/52u0yAlmlvkIBcOaEZqvKbjZbPXbInuYVnQ5fNjj1CwWVe6659J0Ut?=
 =?us-ascii?Q?NoY9qbEEVHQ2IVQk62UqCYCFPHprec7p+SyArLgnzaZZ1ma428BdpFYlsaX8?=
 =?us-ascii?Q?Y/xY6ilR+iInOLIRQ9Fom/x7+9YyVgerR0zNNkjGs0bII+3v+ZIzMj7hNzNk?=
 =?us-ascii?Q?LEmk5IKHRfHl1GVWiIUkQhpg/be0WELJW+5NXW5X9lhtXcqjZHpRnvNJbUxz?=
 =?us-ascii?Q?lUGPuR1sVwE2jbBK0ArHYRd+4hNasmEY9KUTMq4pYunlDtLnyh57fxMVUNpX?=
 =?us-ascii?Q?cr/8mYsP1zUEQdYuICry+KpQzyVkXsVts2Gg+CKdDOPBOoMycbutwKXDTGQI?=
 =?us-ascii?Q?BzDOwcumBvkReNdOFFbcztUl9WgoeOoy07x1M04/D/Tmd2ndFdwLuRP1nG6j?=
 =?us-ascii?Q?Cg1k5ZxgbgdtrvSY/MTId9kqRcg+18OYncSssbZpIzBlBYoUKZhiheB0g6o9?=
 =?us-ascii?Q?ECcF+N0L0WWzrh7Fx9CdF81nYEJotNttF7gQPb34?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1402493d-599f-41a4-a71e-08dbb618b85a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:22:29.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3LNwk1pmVm1Ksodtq6lKzjjWM3o8jB7p0kKvjDBPNQB3zQ66Y6DCPV/Q7kI71tTCCAu1ynlgY2wvCci2ky5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8524
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

commit 5c0e820cbbbe2d1c4cea5cd2bfc1302c123436df upstream.

All kmalloc_reserve() callers have to make the same computation,
we can factorize them, to prepare following patch in the series.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ajay: Regenerated the patch for v6.1.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 net/core/skbuff.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1c059b6..fb8d100 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -424,17 +424,20 @@ EXPORT_SYMBOL(napi_build_skb);
  * may be used. Otherwise, the packet data may be discarded until enough
  * memory is free
  */
-static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
+static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 			     bool *pfmemalloc)
 {
-	void *obj;
 	bool ret_pfmemalloc = false;
+	unsigned int obj_size;
+	void *obj;
 
+	obj_size = SKB_HEAD_ALIGN(*size);
+	*size = obj_size = kmalloc_size_roundup(obj_size);
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
 	 */
-	obj = kmalloc_node_track_caller(size,
+	obj = kmalloc_node_track_caller(obj_size,
 					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 					node);
 	if (obj || !(gfp_pfmemalloc_allowed(flags)))
@@ -442,7 +445,7 @@ static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
 
 	/* Try again but now we are using pfmemalloc reserves */
 	ret_pfmemalloc = true;
-	obj = kmalloc_node_track_caller(size, flags, node);
+	obj = kmalloc_node_track_caller(obj_size, flags, node);
 
 out:
 	if (pfmemalloc)
@@ -503,9 +506,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
-	size = SKB_HEAD_ALIGN(size);
-	size = kmalloc_size_roundup(size);
-	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
+	data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
 	if (unlikely(!data))
 		goto nodata;
 	/* kmalloc_size_roundup() might give us more room than requested.
@@ -1832,9 +1833,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_HEAD_ALIGN(size);
-	size = kmalloc_size_roundup(size);
-	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
+	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		goto nodata;
 	size = SKB_WITH_OVERHEAD(size);
@@ -6198,9 +6197,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_HEAD_ALIGN(size);
-	size = kmalloc_size_roundup(size);
-	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
+	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		return -ENOMEM;
 	size = SKB_WITH_OVERHEAD(size);
@@ -6316,9 +6313,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	size = SKB_HEAD_ALIGN(size);
-	size = kmalloc_size_roundup(size);
-	data = kmalloc_reserve(size, gfp_mask, NUMA_NO_NODE, NULL);
+	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		return -ENOMEM;
 	size = SKB_WITH_OVERHEAD(size);
-- 
2.7.4

