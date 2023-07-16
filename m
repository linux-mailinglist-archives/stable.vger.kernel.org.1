Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199CD75512A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGPTx2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTx2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D354199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF53A60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08157C433C8;
        Sun, 16 Jul 2023 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537206;
        bh=BbcvVudddc8u9/yqBnr457mSYU+MbJhA6sCX10fcsWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhJC2AqCUn6SVXpi5gjf4Wms/Frh/vS7Z5GS2Gky9DZU9+R2wMHvahXlE8su0IKVy
         e/nixufOVUNRf3qN/ECtByMkxc8gX581kQfh0HxqDPdW1C17ULqDgAGzFOVEGxoFrw
         11uejkKVlSH7BG6CCHxRK1IdEYfg+wWaYt5MUuuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 014/800] s390/kasan: fix insecure W+X mapping warning
Date:   Sun, 16 Jul 2023 21:37:47 +0200
Message-ID: <20230716194949.436211575@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 2ed8b509753a0454b52b2d72e982265472c8d861 ]

Since commit 3b5c3f000c2e ("s390/kasan: move shadow mapping
to decompressor") the decompressor establishes mappings for
the shadow memory and sets initial protection attributes to
RWX. The decompressed kernel resets protection to RW+NX
later on.

In case a shadow memory range is not aligned on page boundary
(e.g. as result of mem= kernel command line parameter use),
the "Checked W+X mappings: FAILED, 1 W+X pages found" warning
hits.

Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Fixes: 557b19709da9 ("s390/kasan: move shadow mapping to decompressor")
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/vmem.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 5b22c6e24528a..b9dcb4ae6c59a 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -667,7 +667,15 @@ static void __init memblock_region_swap(void *a, void *b, int size)
 
 #ifdef CONFIG_KASAN
 #define __sha(x)	((unsigned long)kasan_mem_to_shadow((void *)x))
+
+static inline int set_memory_kasan(unsigned long start, unsigned long end)
+{
+	start = PAGE_ALIGN_DOWN(__sha(start));
+	end = PAGE_ALIGN(__sha(end));
+	return set_memory_rwnx(start, (end - start) >> PAGE_SHIFT);
+}
 #endif
+
 /*
  * map whole physical memory to virtual memory (identity mapping)
  * we reserve enough space in the vmalloc area for vmemmap to hotplug
@@ -737,10 +745,8 @@ void __init vmem_map_init(void)
 	}
 
 #ifdef CONFIG_KASAN
-	for_each_mem_range(i, &base, &end) {
-		set_memory_rwnx(__sha(base),
-				(__sha(end) - __sha(base)) >> PAGE_SHIFT);
-	}
+	for_each_mem_range(i, &base, &end)
+		set_memory_kasan(base, end);
 #endif
 	set_memory_rox((unsigned long)_stext,
 		       (unsigned long)(_etext - _stext) >> PAGE_SHIFT);
-- 
2.39.2



