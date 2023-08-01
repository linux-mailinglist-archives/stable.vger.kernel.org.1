Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13A76A915
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHAG3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHAG3Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 02:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C92130
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 23:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 466666147D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5531FC433C7;
        Tue,  1 Aug 2023 06:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690871334;
        bh=FuQ8TYzIhHaxdPu04yqCmQ1rVzsb6N9cHHBsV75m/Ug=;
        h=Subject:To:Cc:From:Date:From;
        b=zzJmWd13S18YJzO5nhxlSOBgFq3p2DeEZLedyrtQYAK8eSbuJs4EiZoAc1q8Sj7Ww
         O+Ej0zCH3CXbQIKk7hYBwkhaBFOsw1yZkpjLWnoumFtzdgvcfy/QHu28MUCHK0j++0
         IL5lEdYpKNUmNvdowufq/PWy4h08vhwGLXdnKjcU=
Subject: FAILED: patch "[PATCH] mm: lock_vma_under_rcu() must check vma->anon_vma under vma" failed to apply to 6.4-stable tree
To:     jannh@google.com, torvalds@linux-foundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 08:28:29 +0200
Message-ID: <2023080129-surface-stench-5e24@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 657b5146955eba331e01b9a6ae89ce2e716ba306
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080129-surface-stench-5e24@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 657b5146955eba331e01b9a6ae89ce2e716ba306 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Jul 2023 23:41:03 +0200
Subject: [PATCH] mm: lock_vma_under_rcu() must check vma->anon_vma under vma
 lock

lock_vma_under_rcu() tries to guarantee that __anon_vma_prepare() can't
be called in the VMA-locked page fault path by ensuring that
vma->anon_vma is set.

However, this check happens before the VMA is locked, which means a
concurrent move_vma() can concurrently call unlink_anon_vmas(), which
disassociates the VMA's anon_vma.

This means we can get UAF in the following scenario:

  THREAD 1                   THREAD 2
  ========                   ========
  <page fault>
    lock_vma_under_rcu()
      rcu_read_lock()
      mas_walk()
      check vma->anon_vma

                             mremap() syscall
                               move_vma()
                                vma_start_write()
                                 unlink_anon_vmas()
                             <syscall end>

    handle_mm_fault()
      __handle_mm_fault()
        handle_pte_fault()
          do_pte_missing()
            do_anonymous_page()
              anon_vma_prepare()
                __anon_vma_prepare()
                  find_mergeable_anon_vma()
                    mas_walk() [looks up VMA X]

                             munmap() syscall (deletes VMA X)

                    reusable_anon_vma() [called on freed VMA X]

This is a security bug if you can hit it, although an attacker would
have to win two races at once where the first race window is only a few
instructions wide.

This patch is based on some previous discussion with Linus Torvalds on
the security list.

Cc: stable@vger.kernel.org
Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..603b2f419948 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5393,27 +5393,28 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
 		goto inval;
 
-	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma && !vma_is_tcp(vma))
-		goto inval;
-
 	if (!vma_start_read(vma))
 		goto inval;
 
+	/*
+	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
+	 * This check must happen after vma_start_read(); otherwise, a
+	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
+	 * from its anon_vma.
+	 */
+	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
+		goto inval_end_read;
+
 	/*
 	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
 	 * it for now and fall back to page fault handling under mmap_lock.
 	 */
-	if (userfaultfd_armed(vma)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (userfaultfd_armed(vma))
+		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+		goto inval_end_read;
 
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
@@ -5425,6 +5426,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 	rcu_read_unlock();
 	return vma;
+
+inval_end_read:
+	vma_end_read(vma);
 inval:
 	rcu_read_unlock();
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);

