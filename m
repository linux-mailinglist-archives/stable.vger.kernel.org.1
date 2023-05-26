Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC3E712ED5
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjEZVRB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbjEZVQ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 17:16:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A19DF
        for <stable@vger.kernel.org>; Fri, 26 May 2023 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685135807; x=1685740607; i=deller@gmx.de;
 bh=2RCZDAlQUfqartv8jUGtYfCip2Ra2I/6hxC9IeGjgP0=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=UBV7nNT4Px2nAWDX2TQWZPVW8k6jhW3EqbBTPdymB9q+yY+z28PN+ssXshfMk1IXCSPVGO6
 SQPSVZy0XyiyiSG1Bk7d+wiQQsT7uUppXVn6UyV6hMv2kbuq/WUsfg+AHaBRWW1unagdmr2Ur
 jGyUNIrjwcR9LO7nOelmeUDRPCsydh8Mur7k9+dxEQsWneZYVpdalf63thAS8OXDgyTXNwxRd
 snLomCxQknE/QIPdvkouCf2eOdZwKozqmA7aDjWPKCxddFqIr/HkjkQjNFtTchvZBhKbSLoPZ
 yurIJNe3Ew82EXLNKGp4khuQrlw8PkBLNeDaeTNqO+szLOxwKQfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.158.115]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1qUoXY48yU-00jtHd; Fri, 26
 May 2023 23:16:47 +0200
Date:   Fri, 26 May 2023 23:16:45 +0200
From:   Helge Deller <deller@gmx.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Backport request: parisc: Fix flush_dcache_page() for usage from irq
 context
Message-ID: <ZHEhvXD7LsPaytEF@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:v4xoakljAlwF4nrBuUgu8T4Cxuvwf4kWNZ0XqXP1o2dgDUY/wyS
 WxfcavhaIyJQbornHAD2m16UUnSZX5ZmaIQyOXfNtSSjh9ovVkQGaGJfRV1fB8GOfnqzhu+
 iKq31KksKCFtPtsCdtt3a9es7fQ0vF5hyU4v+cucvsMg6hJ355o6A0ti11Ntn4meGF4izyb
 eQ1dCvdK7rUiuVDj8lQlw==
UI-OutboundReport: notjunk:1;M01:P0:+ac+0vY7H68=;CJkep34vhonOTQuqFaAx3hJ9uxq
 e3Eu5KDetWG0+RM1vuvdMWt/n2dyqSAIf4hwqbuHClkZCDzdUBsuE7o2Q072+ASXKf+ecpNCr
 /vnLnJ8U8+8R8cYmXlczIKma7unAWW62TeDSIwCZtPno1pdC3O1zWOrzTQvNhTI8nr4v+KboA
 umwWEXsI6Jl891wxCooD7eKCIFh0bOupPmEvl/YbmkS/VW3Jcr9xYx3VW/8WnyFcjZvBrxT73
 Upq+UFsAxmb0DoqpLKI8Cg8ekxkBxcbdm2lHbddirqpAUuvHX5rmXy+kNQ6GJgha9BvuX1Y1N
 GG2x+9uPJhJCMqC/An3TUlk4kZ9ehyFKmJ4RkQdqZ5SXHcM+1GKcnMzC4MXZLaLFjWpdvi4BD
 ygkDLP/u1Zhov+ZQJG38G/TvBQy20AK3FTXKUzlca8JZr9HxgICA0bNDDQ4aIVUiSE6HJcQGm
 LXlBB+ZkhtA/pIzzFkGlhomgjKAgS59J02xp5+Acr8ZuzcxxzvpxW+gIVK1/cPuiz5+DT8RV3
 4Oesgx0oRPZfYR8HYbNwAYsj7jg3bsXbEcViPQLm8xX3JBRLMaZaKCf/6EsVbPRNWOsBiQl8l
 GxGzBGxCC2qPAJGX12q0RQa/icCTUOFkLD5FePJy/fe5S7rZnCji0ck1JW9aF8BbCHOKWuuD1
 VvUr/1W25AKPqKT38lnLRK1GV7vAQdLnVIQi5eiYLFWBkAykh3lomcHcGqZSGFi/0VFzwNcNt
 Y+xvMX2Cwzg4cdlJPbJ3sHTOtL4qN+C6QNUoPblttEQ2Zk4fZzNQ52OMcf/BYy8ujGPYXk3NU
 UEAAjnQP41SZ0P5rQmyg2Tp40G8IcI3hYO54dhTJJEvYzAdo3xXzz36hMua9hmiiUu78PqxBJ
 qV8S4aJYs76J90dvZthIYl8j4lupEZRKU7RC3b0CZgQxGqVLRyZdttDLmWY5ECOGL2DPfa+e6
 E/tUiu7y0UFMvj3nTX+Enei4apk=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear stable kernel team,

could you please add the patch below to all stable kernels
from v4.19 up to 5.15.

It's a manual backport of upstream commit 61e150fb310729c98227a5edf6e4a361=
9edc3702,
which doesn't applies cleanly otherwise.

Thanks!
Helge

=46rom 97d6d8f6248364ec916e9642a58f1ed14a1eb147 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Fri, 26 May 2023 22:51:07 +0200
Subject: [PATCH] parisc: Fix flush_dcache_page() for usage from irq contex=
t

flush_dcache_page() may be called with IRQs disabled.

But the current implementation for flush_dcache_page() on parisc
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/parisc/include/asm/cacheflush.h | 5 +++++
 arch/parisc/kernel/cache.c           | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/as=
m/cacheflush.h
index eef0096db5f8..2f4c45f60ae1 100644
=2D-- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -53,6 +53,11 @@ extern void flush_dcache_page(struct page *page);

 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages=
)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
+

 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page_addr(page_address(page)); \
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 394e6e14e5c4..c473c2f395a0 100644
=2D-- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -324,6 +324,7 @@ void flush_dcache_page(struct page *page)
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
 	unsigned long addr, old_addr =3D 0;
+	unsigned long flags;
 	pgoff_t pgoff;

 	if (mapping && !mapping_mapped(mapping)) {
@@ -343,7 +344,7 @@ void flush_dcache_page(struct page *page)
 	 * declared as MAP_PRIVATE or MAP_SHARED), so we only need
 	 * to flush one address here for them all to become coherent */

-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset =3D (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr =3D mpnt->vm_start + offset;
@@ -366,7 +367,7 @@ void flush_dcache_page(struct page *page)
 			old_addr =3D addr;
 		}
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);

=2D-
2.38.1

