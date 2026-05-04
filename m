Return-Path: <stable+bounces-243632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IrPHrit+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:31:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF64BF989
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24A773036C11
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5323DEAC0;
	Mon,  4 May 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmKMTq6z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C773DE43C;
	Mon,  4 May 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904382; cv=none; b=FZ4xunkOtRa4M63NVlnWx4frlH260YD731QemOUix/J471Y7AgRPSved0yHfrrpcxl0dTA5H/2qzvP5nn6O2CVt1oJaLgUaZv/D1HN4eOxNuCpibZvSEcBTBJkUPld1Ma40OtZroeHTTnA4UED3HC+BdiyuD2aNP0cT/Sj/WykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904382; c=relaxed/simple;
	bh=FuWhybO8+6t/rrQbT6e/IyVArVtHxK8kqzlxHM435es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf1IF7H/tmBdK0dSMObwl9lckG21HuVMw+tk7Mozr2l1eiizX6uQDLp6YXxQz5ulhAfjN+jylbzOF2t+DtdqmVbh0uHeZ7dcy/Y50MlXP+l5ozvdl4tMjkEs20AbbKRnDwDvk/CDszad0eOrNZ8GjTh/zuHNs928mhCn+R0euTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmKMTq6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BC3C2BCC4;
	Mon,  4 May 2026 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777904382;
	bh=FuWhybO8+6t/rrQbT6e/IyVArVtHxK8kqzlxHM435es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmKMTq6z9g4rbJY/pTmqOrgO+4NhkWuLvDKmP46KURs8lEdsLaS+x4iEqXzqQudWY
	 AKB91phCEljsrdNBPjlTsDaDu7ewk1hLextSfesBFFYv6KSPfLmVsAyXb6BliqeN6c
	 /c8zSV+U9EOP5Q34rc/YuPy9o19rvgRnpZLL4ab9pYm1AqvdgtuR700BEAPWVG5/1c
	 MMPLZIhMNrlskbqWA7mMHOHZhPO+Pz4bnALhkrpVAyNpV2pLkT1wcZZD/xYks/5u92
	 oGwm7ryLT3rX9ZrogBJlqzQSQbGGCwTPAZRKobJhmpVNe4MXGnmZz2v5QtiApZ7T6j
	 qskyhdf9yvjyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
Date: Mon,  4 May 2026 10:19:38 -0400
Message-ID: <20260504141938.2378270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050146-growl-viselike-2a67@gregkh>
References: <2026050146-growl-viselike-2a67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FFF64BF989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,vger.kernel.org,lists.freedesktop.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243632-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.freedesktop.org:email,deferred_work.work:url,gmx.de:email,fb_deferred_io_state.info:url,suse.de:email]

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 9ded47ad003f09a94b6a710b5c47f4aa5ceb7429 ]

Hold state of deferred I/O in struct fb_deferred_io_state. Allocate an
instance as part of initializing deferred I/O and remove it only after
the final mapping has been closed. If the fb_info and the contained
deferred I/O meanwhile goes away, clear struct fb_deferred_io_state.info
to invalidate the mapping. Any access will then result in a SIGBUS
signal.

Fixes a long-standing problem, where a device hot-unplug happens while
user space still has an active mapping of the graphics memory. The hot-
unplug frees the instance of struct fb_info. Accessing the memory will
operate on undefined state.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 60b59beafba8 ("fbdev: mm: Deferred IO support")
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v2.6.22+
Signed-off-by: Helge Deller <deller@gmx.de>
[ replaced kzalloc_obj(*fbdefio_state) with kzalloc(sizeof(*fbdefio_state), GFP_KERNEL) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fb_defio.c | 178 ++++++++++++++++++++++------
 include/linux/fb.h                  |   4 +-
 2 files changed, 145 insertions(+), 37 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 8df2e51e33909..0b099a89a8234 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -24,6 +24,75 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
+/*
+ * struct fb_deferred_io_state
+ */
+
+struct fb_deferred_io_state {
+	struct kref ref;
+
+	struct mutex lock; /* mutex that protects the pageref list */
+	/* fields protected by lock */
+	struct fb_info *info;
+};
+
+static struct fb_deferred_io_state *fb_deferred_io_state_alloc(void)
+{
+	struct fb_deferred_io_state *fbdefio_state;
+
+	fbdefio_state = kzalloc(sizeof(*fbdefio_state), GFP_KERNEL);
+	if (!fbdefio_state)
+		return NULL;
+
+	kref_init(&fbdefio_state->ref);
+	mutex_init(&fbdefio_state->lock);
+
+	return fbdefio_state;
+}
+
+static void fb_deferred_io_state_release(struct fb_deferred_io_state *fbdefio_state)
+{
+	mutex_destroy(&fbdefio_state->lock);
+
+	kfree(fbdefio_state);
+}
+
+static void fb_deferred_io_state_get(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_get(&fbdefio_state->ref);
+}
+
+static void __fb_deferred_io_state_release(struct kref *ref)
+{
+	struct fb_deferred_io_state *fbdefio_state =
+		container_of(ref, struct fb_deferred_io_state, ref);
+
+	fb_deferred_io_state_release(fbdefio_state);
+}
+
+static void fb_deferred_io_state_put(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_put(&fbdefio_state->ref, __fb_deferred_io_state_release);
+}
+
+/*
+ * struct vm_operations_struct
+ */
+
+static void fb_deferred_io_vm_open(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_get(fbdefio_state);
+}
+
+static void fb_deferred_io_vm_close(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_put(fbdefio_state);
+}
+
 static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long offs)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
@@ -121,25 +190,46 @@ static void fb_deferred_io_pageref_put(struct fb_deferred_io_pageref *pageref,
 /* this is to find and return the vmalloc-ed fb pages */
 static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 {
+	struct fb_info *info;
 	unsigned long offset;
 	struct page *page;
-	struct fb_info *info = vmf->vma->vm_private_data;
+	vm_fault_t ret;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
+
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
 
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= info->fix.smem_len)
-		return VM_FAULT_SIGBUS;
+	if (offset >= info->fix.smem_len) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	page = fb_deferred_io_get_page(info, offset);
-	if (!page)
-		return VM_FAULT_SIGBUS;
+	if (!page) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	if (!vmf->vma->vm_file)
 		fb_err(info, "no mapping available\n");
 
 	BUG_ON(!info->fbdefio->mapping);
 
+	mutex_unlock(&fbdefio_state->lock);
+
 	vmf->page = page;
+
 	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&fbdefio_state->lock);
+	return ret;
 }
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
@@ -166,15 +256,24 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
  * Adds a page to the dirty list. Call this from struct
  * vm_operations_struct.page_mkwrite.
  */
-static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long offset,
-					    struct page *page)
+static vm_fault_t fb_deferred_io_track_page(struct fb_deferred_io_state *fbdefio_state,
+					    unsigned long offset, struct page *page)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_info *info;
+	struct fb_deferred_io *fbdefio;
 	struct fb_deferred_io_pageref *pageref;
 	vm_fault_t ret;
 
 	/* protect against the workqueue changing the page list */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
+
+	fbdefio = info->fbdefio;
 
 	pageref = fb_deferred_io_pageref_get(info, offset, page);
 	if (WARN_ON_ONCE(!pageref)) {
@@ -192,50 +291,38 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
 	 */
 	lock_page(pageref->page);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 	return VM_FAULT_LOCKED;
 
 err_mutex_unlock:
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 	return ret;
 }
 
-/*
- * fb_deferred_io_page_mkwrite - Mark a page as written for deferred I/O
- * @fb_info: The fbdev info structure
- * @vmf: The VM fault
- *
- * This is a callback we get when userspace first tries to
- * write to the page. We schedule a workqueue. That workqueue
- * will eventually mkclean the touched pages and execute the
- * deferred framebuffer IO. Then if userspace touches a page
- * again, we repeat the same scheme.
- *
- * Returns:
- * VM_FAULT_LOCKED on success, or a VM_FAULT error otherwise.
- */
-static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
+static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_deferred_io_state *fbdefio_state,
+					      struct vm_fault *vmf)
 {
 	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);
 
-	return fb_deferred_io_track_page(info, offset, page);
+	return fb_deferred_io_track_page(fbdefio_state, offset, page);
 }
 
-/* vm_ops->page_mkwrite handler */
 static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 {
-	struct fb_info *info = vmf->vma->vm_private_data;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
 
-	return fb_deferred_io_page_mkwrite(info, vmf);
+	return fb_deferred_io_page_mkwrite(fbdefio_state, vmf);
 }
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
+	.open		= fb_deferred_io_vm_open,
+	.close		= fb_deferred_io_vm_close,
 	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
@@ -252,7 +339,10 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	if (!(info->flags & FBINFO_VIRTFB))
 		vm_flags_set(vma, VM_IO);
-	vma->vm_private_data = info;
+	vma->vm_private_data = info->fbdefio_state;
+
+	fb_deferred_io_state_get(info->fbdefio_state); /* released in vma->vm_ops->close() */
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_mmap);
@@ -263,9 +353,10 @@ static void fb_deferred_io_work(struct work_struct *work)
 	struct fb_info *info = container_of(work, struct fb_info, deferred_work.work);
 	struct fb_deferred_io_pageref *pageref, *next;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	/* here we wrprotect the page's mappings, then do all deferred IO. */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
 #ifdef CONFIG_MMU
 	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
 		struct page *page = pageref->page;
@@ -283,12 +374,13 @@ static void fb_deferred_io_work(struct work_struct *work)
 	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
 		fb_deferred_io_pageref_put(pageref, info);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 }
 
 int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 	struct fb_deferred_io_pageref *pagerefs;
 	unsigned long npagerefs;
 	int ret;
@@ -298,7 +390,11 @@ int fb_deferred_io_init(struct fb_info *info)
 	if (WARN_ON(!info->fix.smem_len))
 		return -EINVAL;
 
-	mutex_init(&fbdefio->lock);
+	fbdefio_state = fb_deferred_io_state_alloc();
+	if (!fbdefio_state)
+		return -ENOMEM;
+	fbdefio_state->info = info;
+
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
@@ -315,10 +411,12 @@ int fb_deferred_io_init(struct fb_info *info)
 	info->npagerefs = npagerefs;
 	info->pagerefs = pagerefs;
 
+	info->fbdefio_state = fbdefio_state;
+
 	return 0;
 
 err:
-	mutex_destroy(&fbdefio->lock);
+	fb_deferred_io_state_release(fbdefio_state);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
@@ -352,11 +450,19 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_release);
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	fb_deferred_io_lastclose(info);
 
+	info->fbdefio_state = NULL;
+
+	mutex_lock(&fbdefio_state->lock);
+	fbdefio_state->info = NULL;
+	mutex_unlock(&fbdefio_state->lock);
+
+	fb_deferred_io_state_put(fbdefio_state);
+
 	kvfree(info->pagerefs);
-	mutex_destroy(&fbdefio->lock);
 	fbdefio->mapping = NULL;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c3302d5135466..da2fdabd18cb3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -217,13 +217,14 @@ struct fb_deferred_io {
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
 	int open_count; /* number of opened files; protected by fb_info lock */
-	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	struct address_space *mapping; /* page cache object for fb device */
 	/* callback */
 	struct page *(*get_page)(struct fb_info *info, unsigned long offset);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
+
+struct fb_deferred_io_state;
 #endif
 
 /*
@@ -490,6 +491,7 @@ struct fb_info {
 	unsigned long npagerefs;
 	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 #endif
 
 	const struct fb_ops *fbops;
-- 
2.53.0


