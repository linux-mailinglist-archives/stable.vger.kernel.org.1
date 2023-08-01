Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B079F76AFE9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjHAJvW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHAJvF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247672702
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1031614D0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE344C433C8;
        Tue,  1 Aug 2023 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883433;
        bh=S4NzDr6vPxXTR2iACmF/9s0oQejnAiTetVrk3Nafr00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0angSKuWfNWfSqkrVyl24/Qr7/d4LcIFZZ/GPQn85hOdvzEc73FCJEph+FQLyM9U
         gFCFcKHd0TiC4oCqaQRDsORRypCRXVYCOwNK/8PiyZuiLCdZydUySRsd8vhoevaKCW
         /9zdK1Re3ppV25AbvrQIjZjKAwdJ1WhVAz3cUSlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 235/239] mm: fix memory ordering for mm_lock_seq and vm_lock_seq
Date:   Tue,  1 Aug 2023 11:21:39 +0200
Message-ID: <20230801091934.502469891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jann Horn <jannh@google.com>

commit b1f02b95758d05b799731d939e76a0bd6da312db upstream.

mm->mm_lock_seq effectively functions as a read/write lock; therefore it
must be used with acquire/release semantics.

A specific example is the interaction between userfaultfd_register() and
lock_vma_under_rcu().

userfaultfd_register() does the following from the point where it changes
a VMA's flags to the point where concurrent readers are permitted again
(in a simple scenario where only a single private VMA is accessed and no
merging/splitting is involved):

userfaultfd_register
  userfaultfd_set_vm_flags
    vm_flags_reset
      vma_start_write
        down_write(&vma->vm_lock->lock)
        vma->vm_lock_seq = mm_lock_seq [marks VMA as busy]
        up_write(&vma->vm_lock->lock)
      vm_flags_init
        [sets VM_UFFD_* in __vm_flags]
  vma->vm_userfaultfd_ctx.ctx = ctx
  mmap_write_unlock
    vma_end_write_all
      WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1) [unlocks VMA]

There are no memory barriers in between the __vm_flags update and the
mm->mm_lock_seq update that unlocks the VMA, so the unlock can be
reordered to above the `vm_flags_init()` call, which means from the
perspective of a concurrent reader, a VMA can be marked as a userfaultfd
VMA while it is not VMA-locked.  That's bad, we definitely need a
store-release for the unlock operation.

The non-atomic write to vma->vm_lock_seq in vma_start_write() is mostly
fine because all accesses to vma->vm_lock_seq that matter are always
protected by the VMA lock.  There is a racy read in vma_start_read()
though that can tolerate false-positives, so we should be using
WRITE_ONCE() to keep things tidy and data-race-free (including for KCSAN).

On the other side, lock_vma_under_rcu() works as follows in the relevant
region for locking and userfaultfd check:

lock_vma_under_rcu
  vma_start_read
    vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [early bailout]
    down_read_trylock(&vma->vm_lock->lock)
    vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [main check]
  userfaultfd_armed
    checks vma->vm_flags & __VM_UFFD_FLAGS

Here, the interesting aspect is how far down the mm->mm_lock_seq read can
be reordered - if this read is reordered down below the vma->vm_flags
access, this could cause lock_vma_under_rcu() to partly operate on
information that was read while the VMA was supposed to be locked.  To
prevent this kind of downwards bleeding of the mm->mm_lock_seq read, we
need to read it with a load-acquire.

Some of the comment wording is based on suggestions by Suren.

BACKPORT WARNING: One of the functions changed by this patch (which I've
written against Linus' tree) is vma_try_start_write(), but this function
no longer exists in mm/mm-everything.  I don't know whether the merged
version of this patch will be ordered before or after the patch that
removes vma_try_start_write().  If you're backporting this patch to a tree
with vma_try_start_write(), make sure this patch changes that function.

Link: https://lkml.kernel.org/r/20230721225107.942336-1-jannh@google.com
Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h        | 29 +++++++++++++++++++++++------
 include/linux/mm_types.h  | 28 ++++++++++++++++++++++++++++
 include/linux/mmap_lock.h | 10 ++++++++--
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..406ab9ea818f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -641,8 +641,14 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
  */
 static inline bool vma_start_read(struct vm_area_struct *vma)
 {
-	/* Check before locking. A race might cause false locked result. */
-	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	/*
+	 * Check before locking. A race might cause false locked result.
+	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
+	 * ACQUIRE semantics, because this is just a lockless check whose result
+	 * we don't rely on for anything - the mm_lock_seq read against which we
+	 * need ordering is below.
+	 */
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
@@ -653,8 +659,13 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * False unlocked result is impossible because we modify and check
 	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
+	 *
+	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
+	 * racing with vma_end_write_all(), we only start reading from the VMA
+	 * after it has been unlocked.
+	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
@@ -676,7 +687,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
+	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
@@ -688,7 +699,13 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 		return;
 
 	down_write(&vma->vm_lock->lock);
-	vma->vm_lock_seq = mm_lock_seq;
+	/*
+	 * We should use WRITE_ONCE() here because we can have concurrent reads
+	 * from the early lockless pessimistic check in vma_start_read().
+	 * We don't really care about the correctness of that early check, but
+	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
+	 */
+	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
 	up_write(&vma->vm_lock->lock);
 }
 
@@ -702,7 +719,7 @@ static inline bool vma_try_start_write(struct vm_area_struct *vma)
 	if (!down_write_trylock(&vma->vm_lock->lock))
 		return false;
 
-	vma->vm_lock_seq = mm_lock_seq;
+	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
 	up_write(&vma->vm_lock->lock);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..5e74ce4a28cd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -514,6 +514,20 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_lock->lock (in write mode)
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_lock->lock (in read or write mode)
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
 	int vm_lock_seq;
 	struct vma_lock *vm_lock;
 
@@ -679,6 +693,20 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		/*
+		 * This field has lock-like semantics, meaning it is sometimes
+		 * accessed with ACQUIRE/RELEASE semantics.
+		 * Roughly speaking, incrementing the sequence number is
+		 * equivalent to releasing locks on VMAs; reading the sequence
+		 * number can be part of taking a read lock on a VMA.
+		 *
+		 * Can be modified under write mmap_lock using RELEASE
+		 * semantics.
+		 * Can be read with no other protection when holding write
+		 * mmap_lock.
+		 * Can be read with ACQUIRE semantics if not holding write
+		 * mmap_lock.
+		 */
 		int mm_lock_seq;
 #endif
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index aab8f1b28d26..e05e167dbd16 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -76,8 +76,14 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 static inline void vma_end_write_all(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
-	/* No races during update due to exclusive mmap_lock being held */
-	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	/*
+	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
+	 * mmap_lock being held.
+	 * We need RELEASE semantics here to ensure that preceding stores into
+	 * the VMA take effect before we unlock it with this store.
+	 * Pairs with ACQUIRE semantics in vma_start_read().
+	 */
+	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
 }
 #else
 static inline void vma_end_write_all(struct mm_struct *mm) {}
-- 
2.41.0



