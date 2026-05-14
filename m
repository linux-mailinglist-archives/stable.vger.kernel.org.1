Return-Path: <stable+bounces-247163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOuUOV6lBWppZQIAu9opvQ
	(envelope-from <stable+bounces-247163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:35:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A75406E6
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF7E301CFB2
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BD368D67;
	Thu, 14 May 2026 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhgKtl87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411F3630A4
	for <stable@vger.kernel.org>; Thu, 14 May 2026 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754810; cv=none; b=nHoRAzJYT9cHoU9yycWRronbWVzUGOpdDVei/MDfBxDbXOLn9Kcfa9ROCPOTM1cfRYGe1tRZI2FM+KiD6U22UCuIIStY7HD/m2HwkQhUDSMzFSePdExf5IZLIh26yMCXUkhkn4KDexg4nEfL8ERscO7GZVhUeRty0vk75h/cFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754810; c=relaxed/simple;
	bh=UVpNi4Z4lfkYQ666fHOmUgQUWrFtq8Hy6hXi6J+onow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS/ajQYyMX9S5rBb7AudM2lp49hp6iZzi5MfJ44sEHi7Dj/Wt8dkViBMOHSHlZkL+pFzKeZ1nDDwbKGjus2lqolO5eunh0rAd6Om+mYIwLufBX9CUaVneTJB5qb2yAIJV54k02wxVIdzBaxQ5z27eRKvZhw4vkNs/aaxN3IGEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhgKtl87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADA3C2BCC9
	for <stable@vger.kernel.org>; Thu, 14 May 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778754810;
	bh=UVpNi4Z4lfkYQ666fHOmUgQUWrFtq8Hy6hXi6J+onow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PhgKtl879Z8eU/Uvk57S1MjS9EDKr6SCr4avyddZDXwJbgojgmJx5D7F+f7NBFs7Z
	 gUrUR2m1ZfGn/5QKy8saG0ivMpg179w6DeOa1MtXQS+PklrMhN41G7AS972Rvr2Jjj
	 bQzxPDAUFozIVptsNiZPMLCHGq0oRRvmmlG7zkBHo73BXPJ6bi3xsLKgcLmqrmLEkl
	 eGVzkJUG+vtB5i9kD3Vkkenu2vSRY2WTD7MUZn3wJ5p3ePfode4iom1d3/uj6FpKzQ
	 A+GTwkpKPvle2yjjP48t+F8j5xAQiDpixIaasOmZWu10IXTBMlK5xj2zC4bJV+XfCv
	 rcpuG5ycJjXhQ==
From: Lorenzo Stoakes <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 7.0.y] mm/vma: do not try to unmap a VMA if mmap_prepare() invoked from mmap()
Date: Thu, 14 May 2026 11:33:20 +0100
Message-ID: <20260514103320.155081-1-ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051252-diabetic-cognition-76a6@gregkh>
References: <2026051252-diabetic-cognition-76a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 565A75406E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247163-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.de:email,linux-foundation.org:email,appspotmail.com:email]
X-Rspamd-Action: no action

[ Upstream commit 619eab23e1ce7c97e54bfc5a417306d94b3f6f13 ]

The mmap_prepare hook functionality includes the ability to invoke
mmap_prepare() from the mmap() hook of existing 'stacked' drivers, that is
ones which are capable of calling the mmap hooks of other drivers/file
systems (e.g.  overlayfs, shm).

As part of the mmap_prepare action functionality, we deal with errors by
unmapping the VMA should one arise.  This works in the usual mmap_prepare
case, as we invoke this action at the last moment, when the VMA is
established in the maple tree.

However, the mmap() hook passes a not-fully-established VMA pointer to the
caller (which is the motivation behind the mmap_prepare() work), which is
detached.

So attempting to unmap a VMA in this state will be problematic, with the
most obvious symptom being a warning in vma_mark_detached(), because the
VMA is already detached.

It's also unncessary - the mmap() handler will clean up the VMA on error.

So to fix this issue, this patch propagates whether or not an mmap action
is being completed via the compatibility layer or directly.

If the former, then we do not attempt VMA cleanup, if the latter, then we
do.

This patch also updates the userland VMA tests to reflect the change.

Link: https://lore.kernel.org/20260421102150.189982-1-ljs@kernel.org
Fixes: ac0a3fc9c07d ("mm: add ability to take further action in vm_area_desc")
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Reported-by: syzbot+db390288d141a1dccf96@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e69734.050a0220.24bfd3.0027.GAE@google.com/
Cc: David Hildenbrand <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h                |  2 +-
 mm/util.c                         | 51 ++++++++++++++++++-------------
 mm/vma.c                          |  3 +-
 tools/testing/vma/include/dup.h   | 41 ++++++++++++-------------
 tools/testing/vma/include/stubs.h |  3 +-
 5 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ceba2c86d9c..2d6d268a2798 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4080,7 +4080,7 @@ static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
 
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action);
+			 struct mmap_action *action, bool is_compat);
 
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
diff --git a/mm/util.c b/mm/util.c
index e2a51e3cfb24..a14de66c9458 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1186,7 +1186,8 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	err = mmap_action_complete(vma, &desc.action);
+	err = mmap_action_complete(vma, &desc.action,
+				   /*is_compat=*/true);
 	if (err) {
 		const size_t len = vma_pages(vma) << PAGE_SHIFT;
 
@@ -1277,28 +1278,31 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 }
 
 static int mmap_action_finish(struct vm_area_struct *vma,
-			      struct mmap_action *action, int err)
+			      struct mmap_action *action, int err,
+			      bool is_compat)
 {
+	if (!err && action->success_hook)
+		err = action->success_hook(vma);
+
+	/*
+	 * If this is invoked from the compatibility layer, post-mmap() hook
+	 * logic will handle cleanup for us.
+	 */
+	if (!err || is_compat)
+		return err;
+
 	/*
 	 * If an error occurs, unmap the VMA altogether and return an error. We
 	 * only clear the newly allocated VMA, since this function is only
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
-	if (err) {
-		if (action->error_hook) {
-			/* We may want to filter the error. */
-			err = action->error_hook(err);
-
-			/* The caller should not clear the error. */
-			VM_WARN_ON_ONCE(!err);
-		}
-		return err;
+	if (action->error_hook) {
+		/* We may want to filter the error. */
+		err = action->error_hook(err);
+		/* The caller should not clear the error. */
+		VM_WARN_ON_ONCE(!err);
 	}
-
-	if (action->success_hook)
-		return action->success_hook(vma);
-
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_MMU
@@ -1329,14 +1333,16 @@ EXPORT_SYMBOL(mmap_action_prepare);
  * mmap_action_complete - Execute VMA descriptor action.
  * @vma: The VMA to perform the action upon.
  * @action: The action to perform.
+ * @is_compat: Is this being invoked from the compatibility layer?
  *
  * Similar to mmap_action_prepare().
  *
- * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ * Return: 0 on success, or error, at which point the VMA will be unmapped if
+ * !@is_compat.
  */
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
-
+			 struct mmap_action *action,
+			 bool is_compat)
 {
 	int err = 0;
 
@@ -1353,7 +1359,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #else
@@ -1373,7 +1379,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 EXPORT_SYMBOL(mmap_action_prepare);
 
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
+			 struct mmap_action *action,
+			 bool is_compat)
 {
 	int err = 0;
 
@@ -1388,7 +1395,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #endif
diff --git a/mm/vma.c b/mm/vma.c
index 30e8a2d254b8..5cd80cdcf82f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2708,7 +2708,7 @@ static int call_action_complete(struct mmap_state *map,
 {
 	int err;
 
-	err = mmap_action_complete(vma, action);
+	err = mmap_action_complete(vma, action, /*is_compat=*/false);
 
 	/* If we held the file rmap we need to release it. */
 	if (map->hold_file_rmap_lock) {
@@ -2778,7 +2778,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	if (have_mmap_prepare && allocated_new) {
 		error = call_action_complete(&map, &desc.action, vma);
-
 		if (error)
 			return error;
 	}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 6299c76c3b7d..79d34f448217 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1071,8 +1071,17 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int __compat_vma_mmap(const struct file_operations *f_op,
-		struct file *file, struct vm_area_struct *vma)
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
+static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
@@ -1082,14 +1091,14 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,
 
 		.pgoff = vma->vm_pgoff,
 		.vm_file = vma->vm_file,
-		.vm_flags = vma->vm_flags,
+		.vma_flags = vma->flags,
 		.page_prot = vma->vm_page_prot,
 
 		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
-	err = f_op->mmap_prepare(&desc);
+	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
 
@@ -1098,27 +1107,22 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action);
-}
+	err = mmap_action_complete(vma, &desc.action,
+				   /*is_compat=*/true);
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
 
-static inline int compat_vma_mmap(struct file *file,
-		struct vm_area_struct *vma)
-{
-	return __compat_vma_mmap(file->f_op, file, vma);
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+	return err;
 }
 
-
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
 	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
-{
-	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-}
-
 static inline void mmap_assert_locked(struct mm_struct *);
 static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 						unsigned long start_addr,
@@ -1309,11 +1313,6 @@ static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
-{
-	return file->f_op->mmap_prepare(desc);
-}
-
 static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 {
 	/* Changing an anonymous vma with this is illegal */
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index 11192a6c6978..c56d96979d4d 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -87,7 +87,8 @@ static inline int mmap_action_prepare(struct vm_area_desc *desc)
 }
 
 static inline int mmap_action_complete(struct vm_area_struct *vma,
-				       struct mmap_action *action)
+				       struct mmap_action *action,
+				       bool is_compat)
 {
 	return 0;
 }
-- 
2.54.0


