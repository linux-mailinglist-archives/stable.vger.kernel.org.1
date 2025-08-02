Return-Path: <stable+bounces-165801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE6B18F20
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 16:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9F189F677
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBC23C4E9;
	Sat,  2 Aug 2025 14:29:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B011F4C99;
	Sat,  2 Aug 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754144957; cv=none; b=JqJkqQ4gSVK36KG6f+pguAzWAhyeWQhD2zoUB6eNqylCqevUpG8QzBnbme8aTWDnDI+iJFQKEM5SLDK7pZVdJVR+kOOo0YNGmncBbGgXneuFawG17X3HPtBSsuI53ixQ1ZVhk+Ru1A3SlQXhV+HHKyVxVGpRt6tJGWiSYVI0aN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754144957; c=relaxed/simple;
	bh=yv8X9xc/9WTt6k4IAYjjS+6GoRUW6LAE+u2YqoKqv5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNcK43B9YzDsODiNtFT2f34j7mFo0GfkX0QeyIcbsH9gRrXJ2QyUNMpKdWqYvFd4+RksGAjHJamXoFDYBdadgk6R5HDWm657v2504di5oa4bBN1NgsTO/6rY0WE0uKSTSzXmC9PYEiNWpXbM4v+E8zEAYmLXOYWN+Eis4HpkS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2400a0c3cf7so4704195ad.0;
        Sat, 02 Aug 2025 07:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754144954; x=1754749754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GT4acsfxr3w5Qitiyweq0pnAwjYfSJgX40mxl6GJEo=;
        b=WssVkyUAazk0wPxWoLXanl6YOYRJxj5bAYjI66zDHbzOGUn6BwjfdFHD3tWktID5YR
         783o9T3JgvV3IR7/6oXZVXcK/ZcPjTyBO0roGJ1VTBPRPlX+pGHFHL/WcJL0cVBnc/TR
         F/+YhSJfvWCbuuEfULtYSu/Ce0uLmfwlV2QqbjQEathHxxGoKTJHBFhzeHxdGct/vqZk
         0QCyx94Z/l3Bjil3/M/knSvhPxaRvT1b362NA6Wo71AgJ6a2mQDk4GORFOHyECk4My14
         aH5PPPxlLTSpIv1euTHA/04bMtZHd+ypo2ITLc8U9cQTb/kxvGafqUUABxef9g8dI7/n
         YJpg==
X-Forwarded-Encrypted: i=1; AJvYcCU8jE79YaiMp5QIi6CFPIjmmeGV5KVePAj1izldj2t5oI/DCOYIi86nfiYrxQliz0yV5ux1Newn@vger.kernel.org, AJvYcCUnIwagx3ntdDyfHQtfn9pqr1XrrNrBHWDIju7YxQAhYvISoXcOzaZMndbd9tJzfdehhBuw7ItvZ9i2@vger.kernel.org, AJvYcCWsNs8UBvC/WUf/B3eekNY9GfgtE63O7q7jmmBj2GCSbVAMjgJZ4sI5U7SaRbUAwVWimKvUY+2PBvJNUWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+1m/Aq0Ws5Y9G76PVuIETsrJB0vcz7ZgwLgI+xUvylcx5ygx
	HR3UMs1Uevi2aXvG1Vnt+IPfine+aY3ZHKt07Wq8oBRsThUHha7ziDd5
X-Gm-Gg: ASbGncs9ouwxaNpJ8qdJtG1g9e0djOX75dvnAEYNvhc61bgCY00i0AeiyvFrVf5zWe1
	bsrc1jew+hT4Biv7atyh1FZow1voKB9qGBL1bv25Z36ctNU7UPj42oE1wYRB1BGNQlnsdrYseHQ
	DpmoPK4Oe3bBY9NlcB1BfPme6s0UHLd+o5GQ6Ff/pn8eGlc/7zdG9vPrTX5K6R2PpuoHD2UZ+y7
	/dz/unpgFJE87OoO9EzP9vaVraPfvq0bszlqImmzaLyUpbKFi34i6nLuIC0AD4NQVmgyTtMgVDr
	CLFoTdqGWbBLoKMxEfB/HVVbiBUfcNkNDzOKL8JQpxbfswau0ujQQ3B3IuodOOLiqMvpSo7L1pg
	s75hKESGaD//G
X-Google-Smtp-Source: AGHT+IEalD7iTZn0WfUaHQorrq90EOZoLgtQO4rk3/sa+x7vQ05SW/rgzKzO8G2QmvUA9IEiOxkGEA==
X-Received: by 2002:a05:6a00:2e9d:b0:74d:3a55:42ef with SMTP id d2e1a72fcca58-76bec4c8559mr1792267b3a.6.1754144954447;
        Sat, 02 Aug 2025 07:29:14 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd88dbsm6541336b3a.103.2025.08.02.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 07:29:14 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	"ppbuk5246 @ gmail . com" <ppbuk5246@gmail.com>,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org,
	kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Sat,  2 Aug 2025 14:26:49 +0000
Message-ID: <20250802142647.139186-3-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KCOV subsystem currently utilizes standard spinlock_t and local_lock_t
for synchronization. In PREEMPT_RT configurations, these locks can be
implemented via rtmutexes and may therefore sleep. This behavior is
problematic as kcov locks are sometimes used in atomic contexts or protect
data accessed during critical instrumentation paths where sleeping is not
permissible.

Address these issues to make kcov PREEMPT_RT friendly:

1. Convert kcov->lock and kcov_remote_lock from spinlock_t to
   raw_spinlock_t. This ensures they remain true, non-sleeping
   spinlocks even on PREEMPT_RT kernels.

2. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
   out of the critical section. All necessary struct kcov_remote
   structures are now pre-allocated individually in kcov_ioctl()
   using GFP_KERNEL (allowing sleep) before acquiring the raw
   spinlocks.

3. Modify the ioctl handling logic to utilize these pre-allocated
   structures within the critical section. kcov_remote_add() is
   modified to accept a pre-allocated structure instead of allocating
   one internally.

4. Remove the local_lock_t protection for kcov_percpu_data in
   kcov_remote_start/stop(). Since local_lock_t can also sleep under
   RT, and the required protection is against local interrupts when
   accessing per-CPU data, it is replaced with explicit
   local_irq_save/restore().

Link: https://lore.kernel.org/all/20250725201400.1078395-2-ysk@kzalloc.com/t/#u
Fixes: f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq")
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Byungchul Park <byungchul@sk.com>
Cc: stable@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Cc: syzkaller@googlegroups.com
Cc: linux-usb@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 243 +++++++++++++++++++++++++++-----------------------
 1 file changed, 130 insertions(+), 113 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 187ba1b80bda..9c8e4325cff8 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -54,7 +54,7 @@ struct kcov {
 	 */
 	refcount_t		refcount;
 	/* The lock protects mode, size, area and t. */
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	enum kcov_mode		mode;
 	/* Size of arena (in long's). */
 	unsigned int		size;
@@ -84,13 +84,12 @@ struct kcov_remote {
 	struct hlist_node	hnode;
 };
 
-static DEFINE_SPINLOCK(kcov_remote_lock);
+static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
 static DEFINE_HASHTABLE(kcov_remote_map, 4);
 static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
 
 struct kcov_percpu_data {
 	void			*irq_area;
-	local_lock_t		lock;
 
 	unsigned int		saved_mode;
 	unsigned int		saved_size;
@@ -99,9 +98,7 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -116,15 +113,9 @@ static struct kcov_remote *kcov_remote_find(u64 handle)
 }
 
 /* Must be called with kcov_remote_lock locked. */
-static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
+static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle,
+					   struct kcov_remote *remote)
 {
-	struct kcov_remote *remote;
-
-	if (kcov_remote_find(handle))
-		return ERR_PTR(-EEXIST);
-	remote = kmalloc(sizeof(*remote), GFP_ATOMIC);
-	if (!remote)
-		return ERR_PTR(-ENOMEM);
 	remote->handle = handle;
 	remote->kcov = kcov;
 	hash_add(kcov_remote_map, &remote->hnode, handle);
@@ -404,9 +395,8 @@ static void kcov_remote_reset(struct kcov *kcov)
 	int bkt;
 	struct kcov_remote *remote;
 	struct hlist_node *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&kcov_remote_lock, flags);
+	raw_spin_lock(&kcov_remote_lock);
 	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
 		if (remote->kcov != kcov)
 			continue;
@@ -415,7 +405,7 @@ static void kcov_remote_reset(struct kcov *kcov)
 	}
 	/* Do reset before unlock to prevent races with kcov_remote_start(). */
 	kcov_reset(kcov);
-	spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	raw_spin_unlock(&kcov_remote_lock);
 }
 
 static void kcov_disable(struct task_struct *t, struct kcov *kcov)
@@ -450,7 +440,7 @@ void kcov_task_exit(struct task_struct *t)
 	if (kcov == NULL)
 		return;
 
-	spin_lock_irqsave(&kcov->lock, flags);
+	raw_spin_lock_irqsave(&kcov->lock, flags);
 	kcov_debug("t = %px, kcov->t = %px\n", t, kcov->t);
 	/*
 	 * For KCOV_ENABLE devices we want to make sure that t->kcov->t == t,
@@ -475,12 +465,12 @@ void kcov_task_exit(struct task_struct *t)
 	 * By combining all three checks into one we get:
 	 */
 	if (WARN_ON(kcov->t != t)) {
-		spin_unlock_irqrestore(&kcov->lock, flags);
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
 		return;
 	}
 	/* Just to not leave dangling references behind. */
 	kcov_disable(t, kcov);
-	spin_unlock_irqrestore(&kcov->lock, flags);
+	raw_spin_unlock_irqrestore(&kcov->lock, flags);
 	kcov_put(kcov);
 }
 
@@ -492,14 +482,14 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	struct page *page;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kcov->lock, flags);
+	raw_spin_lock_irqsave(&kcov->lock, flags);
 	size = kcov->size * sizeof(unsigned long);
 	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
 	    vma->vm_end - vma->vm_start != size) {
 		res = -EINVAL;
 		goto exit;
 	}
-	spin_unlock_irqrestore(&kcov->lock, flags);
+	raw_spin_unlock_irqrestore(&kcov->lock, flags);
 	vm_flags_set(vma, VM_DONTEXPAND);
 	for (off = 0; off < size; off += PAGE_SIZE) {
 		page = vmalloc_to_page(kcov->area + off);
@@ -511,7 +501,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	}
 	return 0;
 exit:
-	spin_unlock_irqrestore(&kcov->lock, flags);
+	raw_spin_unlock_irqrestore(&kcov->lock, flags);
 	return res;
 }
 
@@ -525,7 +515,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
 	kcov->mode = KCOV_MODE_DISABLED;
 	kcov->sequence = 1;
 	refcount_set(&kcov->refcount, 1);
-	spin_lock_init(&kcov->lock);
+	raw_spin_lock_init(&kcov->lock);
 	filep->private_data = kcov;
 	return nonseekable_open(inode, filep);
 }
@@ -586,10 +576,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct task_struct *t;
-	unsigned long flags, unused;
-	int mode, i;
-	struct kcov_remote_arg *remote_arg;
-	struct kcov_remote *remote;
+	unsigned long unused;
+	int mode;
 
 	switch (cmd) {
 	case KCOV_ENABLE:
@@ -627,69 +615,80 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_disable(t, kcov);
 		kcov_put(kcov);
 		return 0;
-	case KCOV_REMOTE_ENABLE:
-		if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
-			return -EINVAL;
-		t = current;
-		if (kcov->t != NULL || t->kcov != NULL)
-			return -EBUSY;
-		remote_arg = (struct kcov_remote_arg *)arg;
-		mode = kcov_get_mode(remote_arg->trace_mode);
-		if (mode < 0)
-			return mode;
-		if ((unsigned long)remote_arg->area_size >
-		    LONG_MAX / sizeof(unsigned long))
-			return -EINVAL;
-		kcov->mode = mode;
-		t->kcov = kcov;
-	        t->kcov_mode = KCOV_MODE_REMOTE;
-		kcov->t = t;
-		kcov->remote = true;
-		kcov->remote_size = remote_arg->area_size;
-		spin_lock_irqsave(&kcov_remote_lock, flags);
-		for (i = 0; i < remote_arg->num_handles; i++) {
-			if (!kcov_check_handle(remote_arg->handles[i],
-						false, true, false)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return -EINVAL;
-			}
-			remote = kcov_remote_add(kcov, remote_arg->handles[i]);
-			if (IS_ERR(remote)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return PTR_ERR(remote);
-			}
-		}
-		if (remote_arg->common_handle) {
-			if (!kcov_check_handle(remote_arg->common_handle,
-						true, false, false)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return -EINVAL;
-			}
-			remote = kcov_remote_add(kcov,
-					remote_arg->common_handle);
-			if (IS_ERR(remote)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
-							flags);
-				kcov_disable(t, kcov);
-				return PTR_ERR(remote);
-			}
-			t->kcov_handle = remote_arg->common_handle;
-		}
-		spin_unlock_irqrestore(&kcov_remote_lock, flags);
-		/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
-		kcov_get(kcov);
-		return 0;
 	default:
 		return -ENOTTY;
 	}
 }
 
+static int kcov_ioctl_locked_remote_enabled(struct kcov *kcov,
+				 unsigned int cmd, unsigned long arg,
+				 struct kcov_remote *remote_handles,
+				 struct kcov_remote *remote_common_handle)
+{
+	struct task_struct *t;
+	int mode, i, ret;
+	struct kcov_remote_arg *remote_arg;
+
+	if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
+		return -EINVAL;
+	t = current;
+	if (kcov->t != NULL || t->kcov != NULL)
+		return -EBUSY;
+	remote_arg = (struct kcov_remote_arg *)arg;
+	mode = kcov_get_mode(remote_arg->trace_mode);
+	if (mode < 0)
+		return mode;
+	if ((unsigned long)remote_arg->area_size >
+		LONG_MAX / sizeof(unsigned long))
+		return -EINVAL;
+	kcov->mode = mode;
+	t->kcov = kcov;
+	t->kcov_mode = KCOV_MODE_REMOTE;
+	kcov->t = t;
+	kcov->remote = true;
+	kcov->remote_size = remote_arg->area_size;
+	raw_spin_lock(&kcov_remote_lock);
+	for (i = 0; i < remote_arg->num_handles; i++) {
+		if (!kcov_check_handle(remote_arg->handles[i],
+					false, true, false)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		if (kcov_remote_find(remote_arg->handles[i])) {
+			ret = -EEXIST;
+			goto err;
+		}
+		kcov_remote_add(kcov, remote_arg->handles[i],
+			&remote_handles[i]);
+	}
+	if (remote_arg->common_handle) {
+		if (!kcov_check_handle(remote_arg->common_handle,
+					true, false, false)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		if (kcov_remote_find(remote_arg->common_handle)) {
+			ret = -EEXIST;
+			goto err;
+		}
+		kcov_remote_add(kcov,
+			remote_arg->common_handle, remote_common_handle);
+		t->kcov_handle = remote_arg->common_handle;
+	}
+	raw_spin_unlock(&kcov_remote_lock);
+	/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
+	kcov_get(kcov);
+	return 0;
+
+err:
+	raw_spin_unlock(&kcov_remote_lock);
+	kcov_disable(t, kcov);
+	kfree(remote_common_handle);
+	kfree(remote_handles);
+
+	return ret;
+}
+
 static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct kcov *kcov;
@@ -697,6 +696,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	struct kcov_remote_arg *remote_arg = NULL;
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
+	struct kcov_remote *remote_handles, *remote_common_handle;
 	unsigned long size, flags;
 	void *area;
 
@@ -716,16 +716,16 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		area = vmalloc_user(size * sizeof(unsigned long));
 		if (area == NULL)
 			return -ENOMEM;
-		spin_lock_irqsave(&kcov->lock, flags);
+		raw_spin_lock_irqsave(&kcov->lock, flags);
 		if (kcov->mode != KCOV_MODE_DISABLED) {
-			spin_unlock_irqrestore(&kcov->lock, flags);
+			raw_spin_unlock_irqrestore(&kcov->lock, flags);
 			vfree(area);
 			return -EBUSY;
 		}
 		kcov->area = area;
 		kcov->size = size;
 		kcov->mode = KCOV_MODE_INIT;
-		spin_unlock_irqrestore(&kcov->lock, flags);
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
 		return 0;
 	case KCOV_REMOTE_ENABLE:
 		if (get_user(remote_num_handles, (unsigned __user *)(arg +
@@ -743,18 +743,35 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		}
 		arg = (unsigned long)remote_arg;
-		fallthrough;
+		remote_handles = kmalloc_array(remote_arg->num_handles,
+					sizeof(struct kcov_remote), GFP_KERNEL);
+		if (!remote_handles)
+			return -ENOMEM;
+		remote_common_handle = kmalloc(sizeof(struct kcov_remote), GFP_KERNEL);
+		if (!remote_common_handle) {
+			kfree(remote_handles);
+			return -ENOMEM;
+		}
+
+		raw_spin_lock_irqsave(&kcov->lock, flags);
+		res = kcov_ioctl_locked_remote_enabled(kcov, cmd, arg,
+				remote_handles, remote_common_handle);
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
+		kfree(remote_arg);
+		break;
 	default:
 		/*
+		 * KCOV_ENABLE, KCOV_DISABLE:
 		 * All other commands can be normally executed under a spin lock, so we
 		 * obtain and release it here in order to simplify kcov_ioctl_locked().
 		 */
-		spin_lock_irqsave(&kcov->lock, flags);
+		raw_spin_lock_irqsave(&kcov->lock, flags);
 		res = kcov_ioctl_locked(kcov, cmd, arg);
-		spin_unlock_irqrestore(&kcov->lock, flags);
-		kfree(remote_arg);
-		return res;
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
+		break;
 	}
+
+	return res;
 }
 
 static const struct file_operations kcov_fops = {
@@ -862,7 +879,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -870,7 +887,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode = READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -879,15 +896,15 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
-	spin_lock(&kcov_remote_lock);
+	raw_spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		spin_unlock(&kcov_remote_lock);
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		raw_spin_unlock(&kcov_remote_lock);
+		local_irq_restore(flags);
 		return;
 	}
 	kcov_debug("handle = %llx, context: %s\n", handle,
@@ -908,17 +925,17 @@ void kcov_remote_start(u64 handle)
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
 		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
 	}
-	spin_unlock(&kcov_remote_lock);
+	raw_spin_unlock(&kcov_remote_lock);
 
 	/* Can only happen when in_task(). */
 	if (!area) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
-		local_lock_irqsave(&kcov_percpu_data.lock, flags);
+		local_irq_save(flags);
 	}
 
 	/* Reset coverage size. */
@@ -930,7 +947,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -1004,12 +1021,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -1017,12 +1034,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -1037,22 +1054,22 @@ void kcov_remote_stop(void)
 		kcov_remote_softirq_stop(t);
 	}
 
-	spin_lock(&kcov->lock);
+	raw_spin_lock(&kcov->lock);
 	/*
 	 * KCOV_DISABLE could have been called between kcov_remote_start()
 	 * and kcov_remote_stop(), hence the sequence check.
 	 */
 	if (sequence == kcov->sequence && kcov->remote)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
-	spin_unlock(&kcov->lock);
+	raw_spin_unlock(&kcov->lock);
 
 	if (in_task()) {
-		spin_lock(&kcov_remote_lock);
+		raw_spin_lock(&kcov_remote_lock);
 		kcov_remote_area_put(area, size);
-		spin_unlock(&kcov_remote_lock);
+		raw_spin_unlock(&kcov_remote_lock);
 	}
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
-- 
2.50.0


