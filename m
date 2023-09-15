Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D639E7A258D
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjIOSWr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjIOSWh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 14:22:37 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57E2130;
        Fri, 15 Sep 2023 11:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3bmuE9szAsB9bU42yepnD3bt3+cQbNfRUSyYvqxV8hrMS/ZCCpZP5Cp+J2dThnUgrM5SXHbC2NmduaioDIwbclgWZKwv0NQKkfknx4OdG2by2k6nd1fJv1gGVzDpU6VNRgUxM3WZ5aNvjwoNwiFIY4P+W4gHZvuVfV/1e/dWAd9S1wyCm5pU70ufq8RRKJaYf+6lLmV2qDbkCmNBaqdO5BTC3D1b0PN+yRu/WXkiJwH58TySxOgjCC69M9EElayKo/zmN4dAaHXP8nfeYuFO7C6GcYyPlTVzhdLt/DbcJUQZH61DcJCW4jLLtUHVdLk6rZ2JEwARM5kJQSMoJIMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FETbCyXS9wjBtDZXo5BwM6xKdayPA71pB1MDIFkX1pg=;
 b=Fj8uZ+aSPnbKBhzr5dxz+Y2JPZ0FiVfuV9wyssc5bhqoy7PpBykUMoV9MUz0V4pranrnATtazSD8ldy2ySk86/p9aaLDDlqwG3fBn4i/6IkCLWTADgdS8540+yQtl983TEptee6d9fjgPRN9FgoLPvWcYZG9C6Cy7+7KVALDGd0sRSVrrfDkvPfwBt1d9/NiaSedi+BGWc4Wjk+xLmurVbBKGRUeoWhXflk9dq5MHTRU2qqqOSkaO0sfdERFxvmkFZny6X+SEKM5WA58YGvfKbq/tN5YiuErUvhsiqYyXmfAx4Xg5y0udDt3JbzT5fw7EjHZTz4jXennWnv1pdVrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FETbCyXS9wjBtDZXo5BwM6xKdayPA71pB1MDIFkX1pg=;
 b=osbXXZ0ogGp/a3bj8FH1LSWnvM6Y1uemjEueQiEn3nmgRIYkGXmVEW/H9hCNjhvtj0s63gAjZ29H+H1FUtvAAInfXK49X3yjM4ak9fHaKIX0NhwPXtddnIvNbAZC46iA5DPbEW9gXtbj0/Jg1/gQQ1Pt0epx+ay2N/GWzL9hS9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8524.namprd05.prod.outlook.com (2603:10b6:303:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 18:22:27 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 18:22:26 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     stable@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexanderduyck@fb.com, soheil@google.com,
        netdev@vger.kernel.org, namit@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com, akaher@vmware.com
Subject: [PATCH v6.1.y 2/4] net: remove osize variable in __alloc_skb()
Date:   Fri, 15 Sep 2023 23:51:03 +0530
Message-Id: <1694802065-1821-3-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03a2c66c-f15a-4630-522f-08dbb618b6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zUHH/qbA5G/iVJeqoXcEo+n0baP/ldoDap54CDn1dgS3ISxAuB0canLGAMRb/PU3w4Iy76nnyqujJVhd6L2EGitF2dnF1FCU3cAAO2mctcSnA+ce4lyUl537O0AIIPHV2rLDmUTP3ORX8bZAGgPH+RZvMVrwh3wrRmyaXhgipqZSsYhVmaEUHPuine4kFROkmu0EGp0rg6qv4aQ2SZ5q+j9bc2WCh1SCfeif71DsdDJpYV3Oz3IdyNiEjhu4ZrEJZwKlY9N4TmR4DeKnvPy2Uzg8oi4abbFHbI+e6suPBeEGxzbRXsISIkTJ7+N72SYmN80B0VQ3+lsE4IksOal9tuXmFpmKSh7H1c0qaLHV0EQZdWE6tAjg9ng/gkTR58yCkRxgNhVaxxKgMV0kh8Bi0aFGRk2DKGEWy7m2pHCE47YtkiC6iOhqIhvp7R18w65zCD/hZvq/OfKoSKvPIa/X3YXYfKfo3qPEgoLs/kQ+NTN5IegfMXXkEVCA439ObRZuDpNrq8F7eeXQOdmw3NmaIoHBJsm1l4ffTjnthKiyUzM+/o8UuG1sehACROkKS/iv69HgajbxGhvYu6kJXbrniY8ahvavqhYeiT7sUsna6JS0/kE0JDJWFn2K+0sfdM2qY9WOwGGqYuVVvcTEQJH6nzmQ/oKt2I1OPcZ0ACA8uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(36756003)(86362001)(38350700002)(38100700002)(6486002)(478600001)(5660300002)(52116002)(6506007)(66556008)(6666004)(8936002)(4326008)(2906002)(66946007)(8676002)(66476007)(6512007)(83380400001)(316002)(107886003)(26005)(6916009)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioTa0rLVhP6y61Tq5eTJnet5vvNKb1L9HE1bzFHuTvuDP530p63oP1Cv/P4x?=
 =?us-ascii?Q?saZzcEZ5y5Zjq708GwU/+I5Wuk71pDZ6jwgSXzU0vA81K7Gt99dYA8wkBIaI?=
 =?us-ascii?Q?AbQImGxQhESVon7cs5KAL1x/SAEEgF3mUvmzX7aFPhgmInbiwYlHA69Hrozr?=
 =?us-ascii?Q?sU1bFp9tI2rXJM2euVlTxOarU/uExMLmXBMXxI+8BLXYOel2DTScpocpOG99?=
 =?us-ascii?Q?gKc1kYHCPnQfaRJ9Vd3TvEh8ro7EquB6o8waFfm24Q+8RpDOtmEkhyIcpMRz?=
 =?us-ascii?Q?9i6Rfp0qS0x5rWU8NVvqpIIAbKlQ7GNpPgQMuzJnoHKBYjyoV+jes3q5Tkq3?=
 =?us-ascii?Q?F8xonPzaNmUIpDx4KlMxfPpUEMbdtRz5efbIFoyQLSfpGUaYmFHWeEMFIClN?=
 =?us-ascii?Q?A41Y1/avCVVeoGwyMKXJhfvxGk07zCxwa1ff/8l2vcsL+6Ss5/awmVjw/+Pd?=
 =?us-ascii?Q?IUcJnCX5m3TzWgDe9ilATOVDiONTpemTLOGrnX4lQGd/cmakfat+yzXCvlYJ?=
 =?us-ascii?Q?9Rx07u9SmxmJvKn3WoW4ReJrB0Vlxd6mEh3crDZWebdpOSwRd0KYMvnD4nZZ?=
 =?us-ascii?Q?o0lzDZr9q+QaQ5y5fVvRerMQhCJ3WF0vDpwCon6rYI/hfls16GdtmnfwkO8i?=
 =?us-ascii?Q?D7Fdu0IvDLBGvZjEwP3m6NKuHkcy13+CXcNlqk87BnQqOmtPKbId/OqAJAYz?=
 =?us-ascii?Q?+LkcfoYMjsE5pKSX3e+JRtXjAmezdbx4eMx9oKj60b8RH9gcFGEvbW/kpbEz?=
 =?us-ascii?Q?/Qbjj3WlXoDFt/XxD8XDKESsS1YTlGXIO5HmHR6mrMrKPpjdosxi4OGOWzzF?=
 =?us-ascii?Q?OJjUewRbAyyY5MT8vqHZcvCogoRFOZRQf7sz8wugefsamTg4NDfJT4Sp4FSb?=
 =?us-ascii?Q?UB3ZdBvxlw5mH8tAPENPI6+B2zaAkwNkZSWCuuU2OOBAU55pM5Sb6OY15d58?=
 =?us-ascii?Q?kAL9FDhy7HtPrGuVr6Zbr0O9SLBYS6WQ3hCwO+TB8RewYKVzBNvATIclVElZ?=
 =?us-ascii?Q?VaAf0kgug9RLOm08T93xwPnuAokHNO4zt8nMLrQpMTTImwsj8oJQ76Xs7s2m?=
 =?us-ascii?Q?4N+QMu6OrfTFS8IZncDGzFWS1S8nlymcf6FUa0LNkMHwfG2uRv2jh1l8RvHp?=
 =?us-ascii?Q?woXXq0CuJYNOhe0SD337RMPn/iVjoRugZE92sqVAZuzXBKyfBHeYXNlcCJTf?=
 =?us-ascii?Q?jatn5NMn1zVjihqyGB7MTIuTsSrxrxATT3YyTOzhma0v7N6C4kHebce/3XpM?=
 =?us-ascii?Q?L2276Uot1FqQ3VLWpRC+7l2cvg41MaN193WyepI3D1a3fOz2Pp7jdPeVojbr?=
 =?us-ascii?Q?76d4l5vv8RxOg2j5XWXY9ikJl560XtkmTiN8nLofEr0LNq+k0EEfv1c35Xml?=
 =?us-ascii?Q?JAmdlbfKraJsYVy5mpluoV8G8yPpUyOm1ufJrEPrVK1JsdGxVS7Jotj2QSfc?=
 =?us-ascii?Q?JMSAcUD1nhO55EBDfWhPozWAyCP0tfHLJ1q3S8FKoZ7fNzVgjsC5N4Z8GZ1K?=
 =?us-ascii?Q?kbvTsGav4NJpH00U8EdqS1qIGFYtF/dC80GRshAHzdiUT9yu4PJlDtgKjjmL?=
 =?us-ascii?Q?IzISHScBVIuv0wtHQLjrB9XOFx9Qr1y+q2codKhx?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2c66c-f15a-4630-522f-08dbb618b6f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:22:26.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGhfs/j9sVb6Pb/t76nebmMTGe1zHgpH7+Q/vrr59R7lgcV/jEnjKHOCqVjrW/ZiM3Tycxju0IRP7hxmSaYmjQ==
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

commit 65998d2bf857b9ae5acc1f3b70892bd1b429ccab upstream.

This is a cleanup patch, to prepare following change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ajay: Regenerated the patch for v6.1.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 net/core/skbuff.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea8f5..1c059b6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -479,7 +479,6 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 {
 	struct kmem_cache *cache;
 	struct sk_buff *skb;
-	unsigned int osize;
 	bool pfmemalloc;
 	u8 *data;
 
@@ -505,16 +504,15 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
 	size = SKB_HEAD_ALIGN(size);
-	osize = kmalloc_size_roundup(size);
-	data = kmalloc_reserve(osize, gfp_mask, node, &pfmemalloc);
+	size = kmalloc_size_roundup(size);
+	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
 	if (unlikely(!data))
 		goto nodata;
 	/* kmalloc_size_roundup() might give us more room than requested.
 	 * Put skb_shared_info exactly at the end of allocated zone,
 	 * to allow max possible filling before reallocation.
 	 */
-	size = SKB_WITH_OVERHEAD(osize);
-	prefetchw(data + size);
+	prefetchw(data + SKB_WITH_OVERHEAD(size));
 
 	/*
 	 * Only clear those fields we need to clear, not those that we will
@@ -522,7 +520,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * the tail pointer in struct sk_buff!
 	 */
 	memset(skb, 0, offsetof(struct sk_buff, tail));
-	__build_skb_around(skb, data, osize);
+	__build_skb_around(skb, data, size);
 	skb->pfmemalloc = pfmemalloc;
 
 	if (flags & SKB_ALLOC_FCLONE) {
-- 
2.7.4

