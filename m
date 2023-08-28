Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6237678ABB7
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjH1Kd7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjH1Kdf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39456194
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BFCB63D25
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C439C433C7;
        Mon, 28 Aug 2023 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218755;
        bh=aUJu0L9teb3pZYHovjM8EVJ61YIDAKCsFVHBkCvoqdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioIFDGi9sxBal1PSJwi4+51pOyhWJkx61WhNUHgY1ny7M5KAa6uwtXbCgewC36HnO
         QQIvrd5H+dOhcwyU0DP1kFfdnVIv16BN+0SZQSsPaG6iJ8qJnsEIuA7e5eRWCq9Aza
         Xp1NKcm+kYT4ihg9BuJajZ6lPQejvw1hEIXIrGdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dylan Jhong <dylan@andestech.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 072/122] mm: add a call to flush_cache_vmap() in vmap_pfn()
Date:   Mon, 28 Aug 2023 12:13:07 +0200
Message-ID: <20230828101158.832343759@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2909,6 +2909,10 @@ void *vmap_pfn(unsigned long *pfns, unsi
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


