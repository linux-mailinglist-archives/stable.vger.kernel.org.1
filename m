Return-Path: <stable+bounces-73972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F9970EBB
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED121C21FD8
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA0176249;
	Mon,  9 Sep 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekAfPIj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A7176255
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865285; cv=none; b=dDtUT4GCX4SuengFLHsikWQmNmNZWceC49k3jSe+EOu30i+D5ypFXsnUzAOxTSnTZhjZxZfCZZqvj1lvdLlzuVGP7tmxPl8s5ZBu7SSaeQWPZZGudHfK02A3vfoJiI/HI1Ews6G9AvlLj+XxHQB7ZjI0d7RUae7wIaePWmbiUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865285; c=relaxed/simple;
	bh=mGIWcpmgW/wf89hrstT6fZFP2cPpEgY+/jjoQ/vkFU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cy53KqnjqWx+whNQEsHhLbohijjimIU0zgS0oNrNU1iDNo8sHZJXhauAux2I1KoCfgA11vdfjcFYU5qjN+XcZZDqSGW8tnw8itTsakQt6phjaRmeaUkYEWYy3boNSEDnG7Ny2Wvotj0AJfry99XrMo9fh3MJXcMdgooPLu7GmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekAfPIj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0158C4CEC5;
	Mon,  9 Sep 2024 07:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725865285;
	bh=mGIWcpmgW/wf89hrstT6fZFP2cPpEgY+/jjoQ/vkFU4=;
	h=Subject:To:Cc:From:Date:From;
	b=ekAfPIj8vpK4EnpOy0gRI/zwQBB17hS9FXlPrJzNg1wSUShY7RLj5pB1dr2Kwnm11
	 t3cAxpFWgXzKq3FbI9Orbw1Y0u5BopzhqKvcgPmqhrDcKJTvos24HluFE4pxwlDRbT
	 1oeE9OL1jvE1/J/DCSeF1HSAs2sPKb5raj+c3o9Q=
Subject: FAILED: patch "[PATCH] perf/aux: Fix AUX buffer serialization" failed to apply to 5.4-stable tree
To: peterz@infradead.org,mingo@kernel.org,ole@binarygecko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 09:01:22 +0200
Message-ID: <2024090922-footbath-barrack-c29b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2ab9d830262c132ab5db2f571003d80850d56b2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090922-footbath-barrack-c29b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

2ab9d830262c ("perf/aux: Fix AUX buffer serialization")
c1e8d7c6a7a6 ("mmap locking API: convert mmap_sem comments")
d8ed45c5dcd4 ("mmap locking API: use coccinelle to convert mmap_sem rwsem call sites")
5a36f0f3f518 ("Merge tag 'vfio-v5.8-rc1' of git://github.com/awilliam/linux-vfio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ab9d830262c132ab5db2f571003d80850d56b2a Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 2 Sep 2024 10:14:24 +0200
Subject: [PATCH] perf/aux: Fix AUX buffer serialization

Ole reported that event->mmap_mutex is strictly insufficient to
serialize the AUX buffer, add a per RB mutex to fully serialize it.

Note that in the lock order comment the perf_event::mmap_mutex order
was already wrong, that is, it nesting under mmap_lock is not new with
this patch.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Reported-by: Ole <ole@binarygecko.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c973e3c11e03..8a6c6bbcd658 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1255,8 +1255,9 @@ static void put_ctx(struct perf_event_context *ctx)
  *	  perf_event_context::mutex
  *	    perf_event::child_mutex;
  *	      perf_event_context::lock
- *	    perf_event::mmap_mutex
  *	    mmap_lock
+ *	      perf_event::mmap_mutex
+ *	        perf_buffer::aux_mutex
  *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
@@ -6373,12 +6374,11 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
 	/*
-	 * rb->aux_mmap_count will always drop before rb->mmap_count and
-	 * event->mmap_count, so it is ok to use event->mmap_mutex to
-	 * serialize with perf_mmap here.
+	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
+	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &event->mmap_mutex)) {
+	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6395,7 +6395,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		rb_free_aux(rb);
 		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
-		mutex_unlock(&event->mmap_mutex);
+		mutex_unlock(&rb->aux_mutex);
 	}
 
 	if (atomic_dec_and_test(&rb->mmap_count))
@@ -6483,6 +6483,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	unsigned long locked, lock_limit;
 	unsigned long vma_size;
@@ -6531,6 +6532,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (!rb)
 			goto aux_unlock;
 
+		aux_mutex = &rb->aux_mutex;
+		mutex_lock(aux_mutex);
+
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
@@ -6681,6 +6685,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (aux_mutex)
+		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	/*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 451514442a1b..e072d995d670 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,6 +40,7 @@ struct perf_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
+	struct mutex			aux_mutex;
 	long				aux_head;
 	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 8cadf97bc290..4f46f688d0d4 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -337,6 +337,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 	 */
 	if (!rb->nr_pages)
 		rb->paused = 1;
+
+	mutex_init(&rb->aux_mutex);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)


