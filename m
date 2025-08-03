Return-Path: <stable+bounces-165813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C64B192F7
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F287ABB01
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72627F727;
	Sun,  3 Aug 2025 07:22:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483823645D;
	Sun,  3 Aug 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205731; cv=none; b=ATJz/Gajk27f2i769O5sESGv3e58RUre4hOABMcC8RihWW1OLmkeqoyzJb6C8/KZ7boED2hF0StLKWk9lEtUnaK79rTdNawAqvBg8Q0UtJ7ryyiDPVnPVoJvdCV+rVLSJ3O2gSXoegbqNfwUys0v9QNxjDMkOseCLDmv9KlAcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205731; c=relaxed/simple;
	bh=fUq2Li45YAs5PecAJwEYKmqj5OXZ+QBFxr7/0K55pqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhikyywkPPVuMtl33aTAIFK9ValxNtiK9Cr2CPkKXhxtPOjdj1lI+dNDJ7kS9zo7cGwZMQcIgzbN5RwjNe8xNwfm3o87vkJPaflGt639Y+qrkgsma8F4ks7yZRrArz/KGZ80t1P64WG2ot4ztfcJOhgcHQ7tNDsJcfQsjcc7rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f5ed172daso537861a91.2;
        Sun, 03 Aug 2025 00:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205729; x=1754810529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5kjPMrRx3BCdvtMiXfak7wOA3clQMtvTSjhTHkH/fI=;
        b=M71yEWNYmY+U69p5hMnfKyfCm9M3+45okCcR0sSVIXtXrbowjvQBuNwnruTydGVnN9
         aTQoBzMcuTKYRh4dd2IeG5AVGuMqWgx7FGxhxAFvyZZ6egfv0Bhq8k2ItdPQmnYQcxMw
         KHht/Uuw05vJndm6deqQPN084R45/F7SXNibAWydPiIRqVQ+tYRnyDXJCL4oU0uEKN9e
         txOswNCZhf53TX0DyzXDlDkFGuIoo7gAqenDsMsO0oViSKnCL8i3RTLv2wxImg3HKj5x
         AT0gZHVn5vIFLKIJIS2qoZv7C6z18yXHus9L6G/yQnuIPdB4hkRLxtz8tL/JYN1cQVFw
         cDjw==
X-Forwarded-Encrypted: i=1; AJvYcCUXTDx/7lkEIZ7h5Y1jE+NJfhObu+mhqHF9cTIbrY2PJkdlTlV9bcRdsbVPGLLpQoj+ODImHwg+@vger.kernel.org, AJvYcCWpajzvzqcSxSXqmho2abYgRhvFCRu4vEeGKiQ7r2ea07n67gH7TTQO8pVGERG5X4pDr3Ldo/KYaYZF@vger.kernel.org, AJvYcCXP67LkfTa0jV4KBE1HRNOGxz1gDAMv2KO/PEg3wa4le2RJXrY/TuPhWZIiuJapKnvidtI35eH7hAGYImU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQw4sDv21OuYUoZ3/99DMkEAr6dStSVPXx3LR5BL52qHrLB1y3
	lnr+DRSQ3v9iJF1xKp+6fGpthdoluP1swu8zrDQ/S7DTFlPwGxP+2O+B
X-Gm-Gg: ASbGnctZEsJv5Ck69HHt+DQxSR0LZGKcVb9KndxUn4+FmHKeRgRK7tde0RH7EGSTKek
	UKz+yd4ZvcYzKYEdB2zWmtwLLNvrXCKQazE+UUGYdVcdiljiYcXTdKOS/O7ehxaN8kC+ze9OwTz
	xc5s3RQusyqpmA67pzD3CHR1+/avj80SIzZ5ICmQtMkX0xTDzpIoS8FrWeFC5g0cvR7ZA8Rafti
	UIOeQIIr/cWXk+jmGpIig4Y0rQpX5wSnfpJH4TDxmnPSuOckF9qB+ygWmn+7VeIjzRQgAEkYRNe
	VJT6bRupSXf3wLSyq+g9R38aj6sJ5NzFIPX6yOd53XlBlYdgqu0nolXQNJcSbAaJmeh0l5ev597
	aoaKCCCnT9CZ+
X-Google-Smtp-Source: AGHT+IFzgXBZ0NZjupPHVGqHGMmkqaVS7ylijLqV9m9w7OOaDlsbddfVokWVO7AIwAG6VLW8O6BILQ==
X-Received: by 2002:a05:6a20:9f86:b0:1ee:d621:3c3f with SMTP id adf61e73a8af0-23df8d6cec9mr3955467637.0.1754205729321;
        Sun, 03 Aug 2025 00:22:09 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:22:08 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and kcov_remote_lock
Date: Sun,  3 Aug 2025 07:20:43 +0000
Message-ID: <20250803072044.572733-4-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803072044.572733-2-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The locks kcov->lock and kcov_remote_lock can be acquired from
atomic contexts, such as instrumentation hooks invoked from interrupt
handlers.

On PREEMPT_RT-enabled kernels, spinlock_t is typically implemented
as a sleeping lock (e.g., mapped to an rt_mutex). Acquiring such a
lock in atomic context, where sleeping is not allowed, can lead to
system hangs or crashes.

To avoid this, convert both locks to raw_spinlock_t, which always
provides non-sleeping spinlock semantics regardless of preemption model.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 187ba1b80bda..7d9b53385d81 100644
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
@@ -84,7 +84,7 @@ struct kcov_remote {
 	struct hlist_node	hnode;
 };
 
-static DEFINE_SPINLOCK(kcov_remote_lock);
+static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
 static DEFINE_HASHTABLE(kcov_remote_map, 4);
 static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
 
@@ -406,7 +406,7 @@ static void kcov_remote_reset(struct kcov *kcov)
 	struct hlist_node *tmp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kcov_remote_lock, flags);
+	raw_spin_lock_irqsave(&kcov_remote_lock, flags);
 	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
 		if (remote->kcov != kcov)
 			continue;
@@ -415,7 +415,7 @@ static void kcov_remote_reset(struct kcov *kcov)
 	}
 	/* Do reset before unlock to prevent races with kcov_remote_start(). */
 	kcov_reset(kcov);
-	spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
 }
 
 static void kcov_disable(struct task_struct *t, struct kcov *kcov)
@@ -450,7 +450,7 @@ void kcov_task_exit(struct task_struct *t)
 	if (kcov == NULL)
 		return;
 
-	spin_lock_irqsave(&kcov->lock, flags);
+	raw_spin_lock_irqsave(&kcov->lock, flags);
 	kcov_debug("t = %px, kcov->t = %px\n", t, kcov->t);
 	/*
 	 * For KCOV_ENABLE devices we want to make sure that t->kcov->t == t,
@@ -475,12 +475,12 @@ void kcov_task_exit(struct task_struct *t)
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
 
@@ -492,14 +492,14 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
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
@@ -511,7 +511,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	}
 	return 0;
 exit:
-	spin_unlock_irqrestore(&kcov->lock, flags);
+	raw_spin_unlock_irqrestore(&kcov->lock, flags);
 	return res;
 }
 
@@ -525,7 +525,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
 	kcov->mode = KCOV_MODE_DISABLED;
 	kcov->sequence = 1;
 	refcount_set(&kcov->refcount, 1);
-	spin_lock_init(&kcov->lock);
+	raw_spin_lock_init(&kcov->lock);
 	filep->private_data = kcov;
 	return nonseekable_open(inode, filep);
 }
@@ -646,18 +646,18 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov->t = t;
 		kcov->remote = true;
 		kcov->remote_size = remote_arg->area_size;
-		spin_lock_irqsave(&kcov_remote_lock, flags);
+		raw_spin_lock_irqsave(&kcov_remote_lock, flags);
 		for (i = 0; i < remote_arg->num_handles; i++) {
 			if (!kcov_check_handle(remote_arg->handles[i],
 						false, true, false)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
+				raw_spin_unlock_irqrestore(&kcov_remote_lock,
 							flags);
 				kcov_disable(t, kcov);
 				return -EINVAL;
 			}
 			remote = kcov_remote_add(kcov, remote_arg->handles[i]);
 			if (IS_ERR(remote)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
+				raw_spin_unlock_irqrestore(&kcov_remote_lock,
 							flags);
 				kcov_disable(t, kcov);
 				return PTR_ERR(remote);
@@ -666,7 +666,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		if (remote_arg->common_handle) {
 			if (!kcov_check_handle(remote_arg->common_handle,
 						true, false, false)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
+				raw_spin_unlock_irqrestore(&kcov_remote_lock,
 							flags);
 				kcov_disable(t, kcov);
 				return -EINVAL;
@@ -674,14 +674,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			remote = kcov_remote_add(kcov,
 					remote_arg->common_handle);
 			if (IS_ERR(remote)) {
-				spin_unlock_irqrestore(&kcov_remote_lock,
+				raw_spin_unlock_irqrestore(&kcov_remote_lock,
 							flags);
 				kcov_disable(t, kcov);
 				return PTR_ERR(remote);
 			}
 			t->kcov_handle = remote_arg->common_handle;
 		}
-		spin_unlock_irqrestore(&kcov_remote_lock, flags);
+		raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
 		/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
 		kcov_get(kcov);
 		return 0;
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
@@ -749,9 +749,9 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		 * All other commands can be normally executed under a spin lock, so we
 		 * obtain and release it here in order to simplify kcov_ioctl_locked().
 		 */
-		spin_lock_irqsave(&kcov->lock, flags);
+		raw_spin_lock_irqsave(&kcov->lock, flags);
 		res = kcov_ioctl_locked(kcov, cmd, arg);
-		spin_unlock_irqrestore(&kcov->lock, flags);
+		raw_spin_unlock_irqrestore(&kcov->lock, flags);
 		kfree(remote_arg);
 		return res;
 	}
@@ -883,10 +883,10 @@ void kcov_remote_start(u64 handle)
 		return;
 	}
 
-	spin_lock(&kcov_remote_lock);
+	raw_spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		spin_unlock(&kcov_remote_lock);
+		raw_spin_unlock(&kcov_remote_lock);
 		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
@@ -908,7 +908,7 @@ void kcov_remote_start(u64 handle)
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
 		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
 	}
-	spin_unlock(&kcov_remote_lock);
+	raw_spin_unlock(&kcov_remote_lock);
 
 	/* Can only happen when in_task(). */
 	if (!area) {
@@ -1037,19 +1037,19 @@ void kcov_remote_stop(void)
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
 
 	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
-- 
2.50.0


