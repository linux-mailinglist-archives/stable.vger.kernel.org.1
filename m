Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052EF77094B
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHDUES (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHDUEO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 16:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD5E6E;
        Fri,  4 Aug 2023 13:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325D362120;
        Fri,  4 Aug 2023 20:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86289C433C8;
        Fri,  4 Aug 2023 20:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691179451;
        bh=f4kzrP63Qa2iWI1K1akhPBP9HXm1Z+om/Vkue1ZYNcY=;
        h=Date:To:From:Subject:From;
        b=ph830d5lhNaGJb7Y7H+rqy5BRI8ruJQDL8FDFw87P4qOfvjnpnWVo0RClNPie4bjn
         qOBbWs2//Rmi/GiwqxE6rvig0pg7KgiG+IrNPfQ4UGqGuQ1tFjkffbip0jkb4Z5Jkt
         gJL6SObgpa6a+uDpJDbKGFkyP2WPFCuXP1wehQ+s=
Date:   Fri, 04 Aug 2023 13:04:10 -0700
To:     mm-commits@vger.kernel.org, willy@infradead.org,
        svens@linux.ibm.com, stfrench@microsoft.com,
        stable@vger.kernel.org, rohiths.msft@gmail.com, pabeni@redhat.com,
        nspmangalore@gmail.com, kuba@kernel.org, jlayton@kernel.org,
        herbert@gondor.apana.org.au, edumazet@google.com, david@redhat.com,
        davem@davemloft.net, axboe@kernel.dk, dhowells@redhat.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] crypto-cifs-fix-error-handling-in-extract_iter_to_sg.patch removed from -mm tree
Message-Id: <20230804200411.86289C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: crypto, cifs: fix error handling in extract_iter_to_sg()
has been removed from the -mm tree.  Its filename was
     crypto-cifs-fix-error-handling-in-extract_iter_to_sg.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: David Howells <dhowells@redhat.com>
Subject: crypto, cifs: fix error handling in extract_iter_to_sg()
Date: Wed, 26 Jul 2023 11:57:56 +0100

Fix error handling in extract_iter_to_sg().  Pages need to be unpinned, not
put in extract_user_to_sg() when handling IOVEC/UBUF sources.

The bug may result in a warning like the following:

  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/gup.c:252
  ...
  pc : try_grab_page+0x108/0x160 mm/gup.c:229
  lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
  ...
  Call trace:
   __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
   arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
   raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
   atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
   try_grab_page+0x108/0x160 mm/gup.c:252
   follow_pmd_mask mm/gup.c:734 [inline]
   follow_pud_mask mm/gup.c:765 [inline]
   follow_p4d_mask mm/gup.c:782 [inline]
   follow_page_mask+0x12c/0x2e4 mm/gup.c:839
   __get_user_pages+0x174/0x30c mm/gup.c:1217
   __get_user_pages_locked mm/gup.c:1448 [inline]
   __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
   internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
   pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
   iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
   iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
   extract_user_to_sg lib/scatterlist.c:1123 [inline]
   extract_iter_to_sg lib/scatterlist.c:1349 [inline]
   extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
   hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
   sock_sendmsg_nosec net/socket.c:725 [inline]
   sock_sendmsg+0x54/0x60 net/socket.c:748
   ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
   ___sys_sendmsg+0x80/0xdc net/socket.c:2548
   __sys_sendmsg+0x68/0xc4 net/socket.c:2577
   __do_sys_sendmsg net/socket.c:2586 [inline]
   __se_sys_sendmsg net/socket.c:2584 [inline]
   __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
   invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
   el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
   do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
   el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
   el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
   el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591

Link: https://lkml.kernel.org/r/20571.1690369076@warthog.procyon.org.uk
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-mm/000000000000273d0105ff97bf56@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Steve French <stfrench@microsoft.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Rohith Surabattula <rohiths.msft@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/scatterlist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/scatterlist.c~crypto-cifs-fix-error-handling-in-extract_iter_to_sg
+++ a/lib/scatterlist.c
@@ -1148,7 +1148,7 @@ static ssize_t extract_user_to_sg(struct
 
 failed:
 	while (sgtable->nents > sgtable->orig_nents)
-		put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
+		unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
 	return res;
 }
 
_

Patches currently in -mm which might be from dhowells@redhat.com are

mm-merge-folio_has_private-filemap_release_folio-call-pairs.patch
mm-netfs-fscache-stop-read-optimisation-when-folio-removed-from-pagecache.patch

