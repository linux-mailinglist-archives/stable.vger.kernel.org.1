Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEE78AA67
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjH1KVz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjH1KVa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F025CE0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C0E638ED
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3F0C433C9;
        Mon, 28 Aug 2023 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218071;
        bh=kye2fGnNdGl+chNLB901inur56Zf0LZX0F0KlNiqzd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYNySi5NNtx/6xc6UozvpGL4fqrRBrVBxXHvh6eEkWI2Fo6ve+/BqmcntsxnoAYm9
         R9cMMfMxmJKTpaGuoAjCNVraIOYe7w8zTxxnPuhBIjeT/pEFYM5Ff7bYe6RrptCjRJ
         svRUZJe9NnpvS3jPSZM+upKNnva4muD5Hq8p1Bb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dylan Jhong <dylan@andestech.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 085/129] mm: add a call to flush_cache_vmap() in vmap_pfn()
Date:   Mon, 28 Aug 2023 12:12:44 +0200
Message-ID: <20230828101200.168768520@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alexghiti@rivosinc.com>

commit a50420c79731fc5cf27ad43719c1091e842a2606 upstream.

flush_cache_vmap() must be called after new vmalloc mappings are installed
in the page table in order to allow architectures to make sure the new
mapping is visible.

It could lead to a panic since on some architectures (like powerpc),
the page table walker could see the wrong pte value and trigger a
spurious page fault that can not be resolved (see commit f1cb8f9beba8
("powerpc/64s/radix: avoid ptesync after set_pte and
ptep_set_access_flags")).

But actually the patch is aiming at riscv: the riscv specification
allows the caching of invalid entries in the TLB, and since we recently
removed the vmalloc page fault handling, we now need to emit a tlb
shootdown whenever a new vmalloc mapping is emitted
(https://lore.kernel.org/linux-riscv/20230725132246.817726-1-alexghiti@rivosinc.com/).
That's a temporary solution, there are ways to avoid that :)

Link: https://lkml.kernel.org/r/20230809164633.1556126-1-alexghiti@rivosinc.com
Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Reported-by: Dylan Jhong <dylan@andestech.com>
Closes: https://lore.kernel.org/linux-riscv/ZMytNY2J8iyjbPPy@atctrx.andestech.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Dylan Jhong <dylan@andestech.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2929,6 +2929,10 @@ void *vmap_pfn(unsigned long *pfns, unsi
 		free_vm_area(area);
 		return NULL;
 	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + count * PAGE_SIZE);
+
 	return area->addr;
 }
 EXPORT_SYMBOL_GPL(vmap_pfn);


