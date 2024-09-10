Return-Path: <stable+bounces-75378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF77973440
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA67328D996
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AD1991D9;
	Tue, 10 Sep 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBol7TfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8E18C324;
	Tue, 10 Sep 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964558; cv=none; b=UpKELm07eV0VarKNQ+cvtJh2G/UulzuQTp4ZP6fV7B5BihCfoY/3cJ/JVmNrXB6FDvGYeXwlMpw4ztltJPMTkLuErRPFwrgUpciiycYTWyQQAkMui3WD+3L4pK+C2XySfTVm+0Xk4I8744o73lPXDV3fPn/hHV6L46Eojwe4GJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964558; c=relaxed/simple;
	bh=R0LHvsQwowd7ebHltVA7QMmbf3v6OsD23Eo2DMxZIW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/d7P8w1e8/O3v3uxLQkGjUcNdY4k0TB82YlA9+IYDlAE+gVbsHxaLpzLJpkcA/1IDRryFovKJO8adZt8v0b5/Xh1qx3Gc1Vpqdlfy9KBfzKRNxJnKtwKztub13sRKDKHoBUgp7rRve+YaSbpgB2UK+stR+BzcRuOVQE/PuCWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBol7TfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB6C4CEC6;
	Tue, 10 Sep 2024 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964558;
	bh=R0LHvsQwowd7ebHltVA7QMmbf3v6OsD23Eo2DMxZIW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBol7TfCefi87q8ZO2s80nWAh0NdvX4C17PfRZVfXdn5vFxDW4qW5V5T296Kd+GCY
	 iP2MD5/K1ABkeQXOrmU4GvjE92TaikrwS7d9MeXgHnH0xnEiKm7CfchQVBSfhx1Wcp
	 2hHCRqNwYq/yk+V60FQTCj6bNZ3PTAm0O43GbrfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ole <ole@binarygecko.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 224/269] perf/aux: Fix AUX buffer serialization
Date: Tue, 10 Sep 2024 11:33:31 +0200
Message-ID: <20240910092615.940498550@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 2ab9d830262c132ab5db2f571003d80850d56b2a upstream.

Ole reported that event->mmap_mutex is strictly insufficient to
serialize the AUX buffer, add a per RB mutex to fully serialize it.

Note that in the lock order comment the perf_event::mmap_mutex order
was already wrong, that is, it nesting under mmap_lock is not new with
this patch.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Reported-by: Ole <ole@binarygecko.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c        |   18 ++++++++++++------
 kernel/events/internal.h    |    1 +
 kernel/events/ring_buffer.c |    2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1255,8 +1255,9 @@ static void put_ctx(struct perf_event_co
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
@@ -6352,12 +6353,11 @@ static void perf_mmap_close(struct vm_ar
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
@@ -6374,7 +6374,7 @@ static void perf_mmap_close(struct vm_ar
 		rb_free_aux(rb);
 		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
-		mutex_unlock(&event->mmap_mutex);
+		mutex_unlock(&rb->aux_mutex);
 	}
 
 	if (atomic_dec_and_test(&rb->mmap_count))
@@ -6462,6 +6462,7 @@ static int perf_mmap(struct file *file,
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	unsigned long locked, lock_limit;
 	unsigned long vma_size;
@@ -6510,6 +6511,9 @@ static int perf_mmap(struct file *file,
 		if (!rb)
 			goto aux_unlock;
 
+		aux_mutex = &rb->aux_mutex;
+		mutex_lock(aux_mutex);
+
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
@@ -6660,6 +6664,8 @@ unlock:
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (aux_mutex)
+		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	/*
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,6 +40,7 @@ struct perf_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
+	struct mutex			aux_mutex;
 	long				aux_head;
 	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -333,6 +333,8 @@ ring_buffer_init(struct perf_buffer *rb,
 	 */
 	if (!rb->nr_pages)
 		rb->paused = 1;
+
+	mutex_init(&rb->aux_mutex);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)



