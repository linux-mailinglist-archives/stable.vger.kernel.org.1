Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C67D30FD
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjJWLET (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjJWLEN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5D10DA
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA78C433C7;
        Mon, 23 Oct 2023 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059050;
        bh=f7Q3HBDgh6uhV6P+HY4UhTiNPF54RLn+wuP8Q3LY22c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuzB5AGYbAncp3pHJsVC5xrXmJor1l/ExzkryhrzaoyQIrQrk0P5Vms4a5mo55GZO
         gTtD7i+rLozDivrDmlHXlGja4EXBdTVF/y25C64BXs72XzPluxtfC6sV342qo9mtw1
         jo2I/T2+Tu3iNxEKgIs0fU72Xq8yHnDOKzHSlnY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.5 029/241] mm: slab: Do not create kmalloc caches smaller than arch_slab_minalign()
Date:   Mon, 23 Oct 2023 12:53:35 +0200
Message-ID: <20231023104834.640448345@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit c15cdea517414e0b29a11e0a0e2443d127c9109b upstream.

Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
if DMA bouncing possible") allows architectures with non-coherent DMA to
define a small ARCH_KMALLOC_MINALIGN (e.g. sizeof(unsigned long long))
and this has been enabled on arm64. With KASAN_HW_TAGS enabled, however,
ARCH_SLAB_MINALIGN becomes 16 on arm64 (arch_slab_minalign() dynamically
selects it since commit d949a8155d13 ("mm: make minimum slab alignment a
runtime property")). This can lead to a situation where kmalloc-8 caches
are attempted to be created with a kmem_caches.size aligned to 16. When
the cache is mergeable, it can lead to kernel warnings like:

sysfs: cannot create duplicate filename '/kernel/slab/:d-0000016'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00001-gda98843cd306-dirty #5
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
 dump_backtrace+0x90/0xe8
 show_stack+0x18/0x24
 dump_stack_lvl+0x48/0x60
 dump_stack+0x18/0x24
 sysfs_warn_dup+0x64/0x80
 sysfs_create_dir_ns+0xe8/0x108
 kobject_add_internal+0x98/0x264
 kobject_init_and_add+0x8c/0xd8
 sysfs_slab_add+0x12c/0x248
 slab_sysfs_init+0x98/0x14c
 do_one_initcall+0x6c/0x1b0
 kernel_init_freeable+0x1c0/0x288
 kernel_init+0x24/0x1e0
 ret_from_fork+0x10/0x20
kobject: kobject_add_internal failed for :d-0000016 with -EEXIST, don't try to register things with the same name in the same directory.
SLUB: Unable to add boot slab dma-kmalloc-8 to sysfs

Limit the __kmalloc_minalign() return value (used to create the
kmalloc-* caches) to arch_slab_minalign() so that kmalloc-8 caches are
skipped when KASAN_HW_TAGS is enabled (both config and runtime).

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment if DMA bouncing possible")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slab_common.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -864,11 +864,13 @@ void __init setup_kmalloc_cache_index_ta
 
 static unsigned int __kmalloc_minalign(void)
 {
+	unsigned int minalign = dma_get_cache_alignment();
+
 #ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
 	if (io_tlb_default_mem.nslabs)
-		return ARCH_KMALLOC_MINALIGN;
+		minalign = ARCH_KMALLOC_MINALIGN;
 #endif
-	return dma_get_cache_alignment();
+	return max(minalign, arch_slab_minalign());
 }
 
 void __init


