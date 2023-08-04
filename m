Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C864770498
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 17:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHDP21 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjHDP2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 11:28:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B25249
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 08:27:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so2230335276.2
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162857; x=1691767657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=520TPAR42nWNvH3iwlw29nIZA75JEpTNGHc6Ua8ufv4=;
        b=TyIdh0Xc7bjO/FKNU6ggV/1Dv2MMNNGLkgGiA1/wDC4kswrAYhcsNTWyI3nJOXhJeP
         aqsdLhrq6CUrp6q3DossAbcj51QnYlaAgR/aq+EsQJ3GN3Goge3dO8goY6tsWeahbwLY
         Emnw4tOdwC3ADtuaCKz1puhigXXZzjx89Nbekny2jzBpX5vMePV4JC0cjOazLXCBYExZ
         v6vsGj8x/91TJQOhZ43Nfe9PYgY1043oenv1qnEYngwp8wioDACX0eYyz//e76Lw3d64
         gfVCR97aftdiX0XPkdD7dGCrEAiTfg0V+/tVEv94gIvaHCopa5EQ7aDwdogtXW1JtUu0
         wsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162857; x=1691767657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=520TPAR42nWNvH3iwlw29nIZA75JEpTNGHc6Ua8ufv4=;
        b=i5AVGqzumhupmFMJHjfqBo7YAUUEtjBwI+jrJNXm+p52SR6QrLq5j3Q0Bvj41I6yAZ
         XpUSjMXSf3eFeddoZ6HEhMcNElkWogf1IZoTjgk9MpTEBiEIAafCSlHgjA0oipTPyDXM
         HESV+7G0Pxh4096B7nd9TPd+MvvqZRrSRnGRuL6xhZdN+qBhloHr3gEPDaSTsQtaIhuW
         /6yd2hJ/WbxefHP2dfcc5N6jeH4rAFt0MC7oluYFLPJ7ximdrYjYCWH2gpH8ExJnN1/N
         C+8oBIsDxrLyN+c/56Pj83zlmRipqrP9iO8gWrktT+dkQn85Hw41f69cRV4g7Zh9XWl1
         JR1g==
X-Gm-Message-State: AOJu0YxS252fu4fWuvSCqLPni6mmpn4BjyEUNA67ZxQOzSYTX0QLdhtV
        0nVg5/FWol8v1t1pKkJugc2vHq7pGYw=
X-Google-Smtp-Source: AGHT+IGlTGXhVU4fUQkbJkgfXB3PlqbjxRUP6W6WYZII59aJQ9IDvYRKiBgp8gXvPph741ZWOBMBJXs8JB4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a25:ce94:0:b0:cf9:3564:33cc with SMTP id
 x142-20020a25ce94000000b00cf9356433ccmr10206ybe.13.1691162857007; Fri, 04 Aug
 2023 08:27:37 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:22 -0700
In-Reply-To: <20230804152724.3090321-1-surenb@google.com>
Mime-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-5-surenb@google.com>
Subject: [PATCH v4 4/6] mm: lock vma explicitly before doing vm_flags_reset
 and vm_flags_reset_once
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Implicit vma locking inside vm_flags_reset() and vm_flags_reset_once() is
not obvious and makes it hard to understand where vma locking is happening.
Also in some cases (like in dup_userfaultfd()) vma should be locked earlier
than vma_flags modification. To make locking more visible, change these
functions to assert that the vma write lock is taken and explicitly lock
the vma beforehand. Fix userfaultfd functions which should lock the vma
earlier.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c |  1 +
 fs/userfaultfd.c                   |  6 ++++++
 include/linux/mm.h                 | 10 +++++++---
 mm/madvise.c                       |  5 ++---
 mm/mlock.c                         |  3 ++-
 mm/mprotect.c                      |  1 +
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 709ebd578394..e2d6f9327f77 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,6 +410,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
+		vma_start_write(vma);
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..6cde95533dcd 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -667,6 +667,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		mmap_write_lock(mm);
 		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
+				vma_start_write(vma);
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				userfaultfd_set_vm_flags(vma,
 							 vma->vm_flags & ~__VM_UFFD_FLAGS);
@@ -702,6 +703,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+		vma_start_write(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
 		return 0;
@@ -783,6 +785,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		atomic_inc(&ctx->mmap_changing);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		vma_start_write(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
 	}
@@ -940,6 +943,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			prev = vma;
 		}
 
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
@@ -1502,6 +1506,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
@@ -1685,6 +1690,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 262b5f44101d..2c720c9bb1ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -780,18 +780,22 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 	ACCESS_PRIVATE(vma, __vm_flags) = flags;
 }
 
-/* Use when VMA is part of the VMA tree and modifications need coordination */
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
 static inline void vm_flags_reset(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	vma_start_write(vma);
+	vma_assert_write_locked(vma);
 	vm_flags_init(vma, flags);
 }
 
 static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
-	vma_start_write(vma);
+	vma_assert_write_locked(vma);
 	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index bfe0e06427bd..507b1d299fec 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -173,9 +173,8 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	}
 
 success:
-	/*
-	 * vm_flags is protected by the mmap_lock held in write mode.
-	 */
+	/* vm_flags is protected by the mmap_lock held in write mode. */
+	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
 	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
 		error = replace_anon_vma_name(vma, anon_name);
diff --git a/mm/mlock.c b/mm/mlock.c
index 479e09d0994c..06bdfab83b58 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -387,6 +387,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (newflags & VM_LOCKED)
 		newflags |= VM_IO;
+	vma_start_write(vma);
 	vm_flags_reset_once(vma, newflags);
 
 	lru_add_drain();
@@ -461,9 +462,9 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * It's okay if try_to_unmap_one unmaps a page just after we
 	 * set VM_LOCKED, populate_vma_page_range will bring it back.
 	 */
-
 	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
 		/* No work to do, and mlocking twice would be wrong */
+		vma_start_write(vma);
 		vm_flags_reset(vma, newflags);
 	} else {
 		mlock_vma_pages_range(vma, start, end, newflags);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3aef1340533a..362e190a8f81 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -657,6 +657,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
+	vma_start_write(vma);
 	vm_flags_reset(vma, newflags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
-- 
2.41.0.585.gd2178a4bd4-goog

