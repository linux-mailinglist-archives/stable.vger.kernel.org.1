Return-Path: <stable+bounces-189179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE464C03FC7
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 03:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2859F3B31ED
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA115539A;
	Fri, 24 Oct 2025 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOknb9pg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96A2C859
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267756; cv=none; b=OtLr8Q8gdIyIDozO84KVH1YFr0NxxpGZSczCajkHj0SbLXxVXLeg/0fyDbzBL4DYsHiNanN+yVbQGBo3UZ6t2XRh5cF8XQANVA9LS8lH75nUW3Zc3ooBjbaODuCt/paQPTKHybIkAbw64u6YWQ7VCd86zHLXDzEuNTLPnTPeXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267756; c=relaxed/simple;
	bh=G9pH1+RL2ty7Yo0cA6AVQ5NWeI40xyrDzY3ZAXbiB4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jltUjr+rMgvHs8QSfWSCpwpwbJtYfl7ZnpUpSJa/m6MevBGY4dAlY4wFb0R4Tz/rnJmcWyt+UFNkoXkMMoGdXiV+iXCfYIs/h0+BW9bFAKObqrt1HdPBmqZnloi0OIop8K/46M0I2b4RHfk5PlEVbU9av6SSI2PFORPC4dUsHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOknb9pg; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940e06b4184so155892739f.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761267753; x=1761872553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKDbt1wT9yJqALXoBzDuHO4g9TQZ25V02GA6xGAEZGQ=;
        b=eOknb9pgLvhHkapj+W8G5hNWhkKYdTWnk4Fvxm1/7a8mvTskoCueO+7AlC8FJm05sM
         rtUacEMagDG0kTbYKb5Zcq8quOm/6W1sD0sEXFZZqzrkAlyWPZKfx6nNLRCIAb3OU72t
         IKjTurtN5CYHJcYCRo51rmLCjTiAgohLjZXjDg+uMwSgul5WeakSlBqhBuG4k314M0lz
         /wLNVFCamy35K7pC+pniUG1Fq7wWUm08f4YSyqv7Pnq+M4BMKkmzqiJRusVCo1AvIRui
         6P4SiXsEkMVYBsAisg6CndYdVTtHYSNDqqCejFczwlofDymhe3KGmVFDmWXaXz5+KJEf
         FLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761267753; x=1761872553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKDbt1wT9yJqALXoBzDuHO4g9TQZ25V02GA6xGAEZGQ=;
        b=htBbUN3loaIsJ0hop5I3sz/ofzk57T25LfR+LOzyqjhH6Ws0YN5aLuftfPe4buuyMZ
         pPk6/t3rjM1pvjN6dky2577fJ5Dt+EogF4nhT3IGboTDnvxqUOvuyvedCjl7g6sVic0n
         eF/uhtFeRtwfSCyEAnv4wFRRB5bSCiaPh7RDIrhQxP8xnptmm1jCZGMDyaaj2J+1ankW
         RwTneswjSHddz3VNErRO8ZRSXynQRW9ig4WyXRRjcx1Fjc8rmiwU0sQI7dxTLxOsXbAM
         5XENChC918ZhGOuEDZR4KcWdC9yqrcOlvFof5+sbxx/xF8/OrmAtHRXWG7ngWTYCCukZ
         94DA==
X-Forwarded-Encrypted: i=1; AJvYcCV6HmtybdNUBSEOKpkL8BdIPgOZnpky3rBXthiLfgcO87hhvfCXQr0JYY1UaBwIYvYI1GF9XnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuix/+LA44I/mRvYqVehw9UZ4rBB9TaQEF45zI3sVcV0OJl1jb
	ptBF3An3y7+PXhldY/pnF5+Ev5wxxibyTboBxDhF1oKCuJM2R+buzPfs
X-Gm-Gg: ASbGncvpKceZIziFvQ/dz+yjvPo3f9duvwt6IQOh//VFCdRKy8ww4PQH58gp/4twwTX
	W1KdYizUPmoIm7WMYGteGi7dT0N9Qzb5xokSjh62AchajfEiIgt57mQtLj+9F9NrEvYUtUSeF/F
	k8AXHtLWTfAf8d+W0Qw9j22ibGGQSZSrjr5PND4B0SjWlIX6uC0TE1KYE6oxops9hIx4SyJuOKh
	L4LYpFPmq6CSd3kMoXty3WNG9T+XN24HJdabWC+IzPsVrjNV/nfnJl/yfnmMGmgwVpb7KJKoetk
	/y1I3lkPZwhD+LZ6YZzwQo+mblvYVnL5UIbVjFiFIfCOKm6zzjwjzefwPiN8xXSqGbGhkehszKp
	NxTog7L2w3kxPjNIbhtF9ZNKn9nEukoM5yFUTbS5oq/RgFVmkhqcq97smAQb4AvHSO8oJYi7ohp
	H74Y8dvK5u7SAia0uXyejYE6E9y7sAS1aPK8AbfttabkKfJ9clowXVOudN8pC6tJuirFzet0yOD
	VIRm9EZtjcfPtYZofytjU4Z+g==
X-Google-Smtp-Source: AGHT+IEK9z1XCO0/7ofKXVfCQ/mfQxCmtCOsaVIb6O6vKesfo5b3vwjLT3GVU6VPQlsM67rO3oQbtg==
X-Received: by 2002:a05:6e02:2508:b0:430:a65c:a833 with SMTP id e9e14a558f8ab-431ebf86680mr9062255ab.31.1761267753103;
        Thu, 23 Oct 2025 18:02:33 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fda03fsm1538669173.35.2025.10.23.18.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:02:32 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alastair D'Silva <alastair@d-silva.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ocxl: Fix race leading to use-after-free in file operations
Date: Thu, 23 Oct 2025 20:02:28 -0500
Message-Id: <20251024010228.1667904-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file operations dereference the context pointer after checking
status under ctx->status_mutex, then drop the lock before using the
context. This allows afu_release() running on another CPU to free
the context, leading to a use-after-free vulnerability.

The race window exists in afu_ioctl(), afu_mmap(), afu_poll() and
afu_read() between the status check and context usage. During device
hot-unplug or rapid open/close cycles, this causes kernel crashes.

Introduce reference counting via kref to prevent premature free.
ocxl_context_get() atomically checks status and acquires a reference
under status_mutex. File operations hold this reference for their
duration, ensuring the context remains valid even if another thread
calls afu_release().

ocxl_context_alloc() initializes refcount to 1 for the file's
lifetime. afu_release() drops this reference, with the context freed
when the last reference goes away. Preserve existing -EBUSY behavior
where the context intentionally leaks on detach timeout.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/misc/ocxl/context.c       |  69 ++++++++++++++----
 drivers/misc/ocxl/file.c          | 113 +++++++++++++++++++++++-------
 drivers/misc/ocxl/ocxl_internal.h |   4 ++
 3 files changed, 144 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index cded7d1caf32..e154adc972a5 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -28,6 +28,7 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
 
 	ctx->pasid = pasid;
 	ctx->status = OPENED;
+	kref_init(&ctx->kref);
 	mutex_init(&ctx->status_mutex);
 	ctx->mapping = mapping;
 	mutex_init(&ctx->mapping_lock);
@@ -47,6 +48,59 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
 }
 EXPORT_SYMBOL_GPL(ocxl_context_alloc);
 
+/**
+ * ocxl_context_get() - Get a reference to the context if not closed
+ * @ctx: The context
+ *
+ * Atomically checks if context status is not CLOSED and acquires a reference.
+ * Must be called with ctx->status_mutex held.
+ *
+ * Return: true if reference acquired, false if context is CLOSED
+ */
+bool ocxl_context_get(struct ocxl_context *ctx)
+{
+	lockdep_assert_held(&ctx->status_mutex);
+
+	if (ctx->status == CLOSED)
+		return false;
+
+	kref_get(&ctx->kref);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ocxl_context_get);
+
+/*
+ * kref release callback - called when last reference is dropped
+ */
+static void ocxl_context_release(struct kref *kref)
+{
+	struct ocxl_context *ctx = container_of(kref, struct ocxl_context,
+						 kref);
+
+	mutex_lock(&ctx->afu->contexts_lock);
+	ctx->afu->pasid_count--;
+	idr_remove(&ctx->afu->contexts_idr, ctx->pasid);
+	mutex_unlock(&ctx->afu->contexts_lock);
+
+	ocxl_afu_irq_free_all(ctx);
+	idr_destroy(&ctx->irq_idr);
+	/* reference to the AFU taken in ocxl_context_alloc() */
+	ocxl_afu_put(ctx->afu);
+	kfree(ctx);
+}
+
+/**
+ * ocxl_context_put() - Release a reference to the context
+ * @ctx: The context
+ *
+ * Decrements the reference count. When it reaches zero, the context is freed.
+ */
+void ocxl_context_put(struct ocxl_context *ctx)
+{
+	kref_put(&ctx->kref, ocxl_context_release);
+}
+EXPORT_SYMBOL_GPL(ocxl_context_put);
+
 /*
  * Callback for when a translation fault triggers an error
  * data:	a pointer to the context which triggered the fault
@@ -279,18 +333,3 @@ void ocxl_context_detach_all(struct ocxl_afu *afu)
 	}
 	mutex_unlock(&afu->contexts_lock);
 }
-
-void ocxl_context_free(struct ocxl_context *ctx)
-{
-	mutex_lock(&ctx->afu->contexts_lock);
-	ctx->afu->pasid_count--;
-	idr_remove(&ctx->afu->contexts_idr, ctx->pasid);
-	mutex_unlock(&ctx->afu->contexts_lock);
-
-	ocxl_afu_irq_free_all(ctx);
-	idr_destroy(&ctx->irq_idr);
-	/* reference to the AFU taken in ocxl_context_alloc() */
-	ocxl_afu_put(ctx->afu);
-	kfree(ctx);
-}
-EXPORT_SYMBOL_GPL(ocxl_context_free);
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 7eb74711ac96..c08724e7ff1e 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -204,17 +204,21 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 	int irq_id;
 	u64 irq_offset;
 	long rc;
-	bool closed;
-
-	pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
-		CMD_STR(cmd));
 
+	/*
+	 * Hold a reference to the context for the duration of this operation.
+	 * We check the status and acquire the reference atomically under the
+	 * status_mutex to ensure the context remains valid.
+	 */
 	mutex_lock(&ctx->status_mutex);
-	closed = (ctx->status == CLOSED);
+	if (!ocxl_context_get(ctx)) {
+		mutex_unlock(&ctx->status_mutex);
+		return -EIO;
+	}
 	mutex_unlock(&ctx->status_mutex);
 
-	if (closed)
-		return -EIO;
+	pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
+		CMD_STR(cmd));
 
 	switch (cmd) {
 	case OCXL_IOCTL_ATTACH:
@@ -230,7 +234,7 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 					sizeof(irq_offset));
 			if (rc) {
 				ocxl_afu_irq_free(ctx, irq_id);
-				return -EFAULT;
+				rc = -EFAULT;
 			}
 		}
 		break;
@@ -238,8 +242,10 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 	case OCXL_IOCTL_IRQ_FREE:
 		rc = copy_from_user(&irq_offset, (u64 __user *) args,
 				sizeof(irq_offset));
-		if (rc)
-			return -EFAULT;
+		if (rc) {
+			rc = -EFAULT;
+			break;
+		}
 		irq_id = ocxl_irq_offset_to_id(ctx, irq_offset);
 		rc = ocxl_afu_irq_free(ctx, irq_id);
 		break;
@@ -247,14 +253,20 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 	case OCXL_IOCTL_IRQ_SET_FD:
 		rc = copy_from_user(&irq_fd, (u64 __user *) args,
 				sizeof(irq_fd));
-		if (rc)
-			return -EFAULT;
-		if (irq_fd.reserved)
-			return -EINVAL;
+		if (rc) {
+			rc = -EFAULT;
+			break;
+		}
+		if (irq_fd.reserved) {
+			rc = -EINVAL;
+			break;
+		}
 		irq_id = ocxl_irq_offset_to_id(ctx, irq_fd.irq_offset);
 		ev_ctx = eventfd_ctx_fdget(irq_fd.eventfd);
-		if (IS_ERR(ev_ctx))
-			return PTR_ERR(ev_ctx);
+		if (IS_ERR(ev_ctx)) {
+			rc = PTR_ERR(ev_ctx);
+			break;
+		}
 		rc = ocxl_irq_set_handler(ctx, irq_id, irq_handler, irq_free, ev_ctx);
 		if (rc)
 			eventfd_ctx_put(ev_ctx);
@@ -280,6 +292,8 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 	default:
 		rc = -EINVAL;
 	}
+
+	ocxl_context_put(ctx);
 	return rc;
 }
 
@@ -292,9 +306,23 @@ static long afu_compat_ioctl(struct file *file, unsigned int cmd,
 static int afu_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct ocxl_context *ctx = file->private_data;
+	int rc;
+
+	/*
+	 * Hold a reference during mmap setup to ensure the context
+	 * remains valid.
+	 */
+	mutex_lock(&ctx->status_mutex);
+	if (!ocxl_context_get(ctx)) {
+		mutex_unlock(&ctx->status_mutex);
+		return -EIO;
+	}
+	mutex_unlock(&ctx->status_mutex);
 
 	pr_debug("%s for context %d\n", __func__, ctx->pasid);
-	return ocxl_context_mmap(ctx, vma);
+	rc = ocxl_context_mmap(ctx, vma);
+	ocxl_context_put(ctx);
+	return rc;
 }
 
 static bool has_xsl_error(struct ocxl_context *ctx)
@@ -324,21 +352,31 @@ static unsigned int afu_poll(struct file *file, struct poll_table_struct *wait)
 {
 	struct ocxl_context *ctx = file->private_data;
 	unsigned int mask = 0;
-	bool closed;
+
+	/*
+	 * Hold a reference to the context while checking for events.
+	 */
+	mutex_lock(&ctx->status_mutex);
+	if (!ocxl_context_get(ctx)) {
+		mutex_unlock(&ctx->status_mutex);
+		return EPOLLERR;
+	}
+	mutex_unlock(&ctx->status_mutex);
 
 	pr_debug("%s for context %d\n", __func__, ctx->pasid);
 
 	poll_wait(file, &ctx->events_wq, wait);
 
-	mutex_lock(&ctx->status_mutex);
-	closed = (ctx->status == CLOSED);
-	mutex_unlock(&ctx->status_mutex);
-
 	if (afu_events_pending(ctx))
 		mask = EPOLLIN | EPOLLRDNORM;
-	else if (closed)
-		mask = EPOLLERR;
+	else {
+		mutex_lock(&ctx->status_mutex);
+		if (ctx->status == CLOSED)
+			mask = EPOLLERR;
+		mutex_unlock(&ctx->status_mutex);
+	}
 
+	ocxl_context_put(ctx);
 	return mask;
 }
 
@@ -410,6 +448,16 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 			AFU_EVENT_BODY_MAX_SIZE))
 		return -EINVAL;
 
+	/*
+	 * Hold a reference to the context for the duration of the read operation.
+	 */
+	mutex_lock(&ctx->status_mutex);
+	if (!ocxl_context_get(ctx)) {
+		mutex_unlock(&ctx->status_mutex);
+		return -EIO;
+	}
+	mutex_unlock(&ctx->status_mutex);
+
 	for (;;) {
 		prepare_to_wait(&ctx->events_wq, &event_wait,
 				TASK_INTERRUPTIBLE);
@@ -422,11 +470,13 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 		if (file->f_flags & O_NONBLOCK) {
 			finish_wait(&ctx->events_wq, &event_wait);
+			ocxl_context_put(ctx);
 			return -EAGAIN;
 		}
 
 		if (signal_pending(current)) {
 			finish_wait(&ctx->events_wq, &event_wait);
+			ocxl_context_put(ctx);
 			return -ERESTARTSYS;
 		}
 
@@ -437,19 +487,24 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 	if (has_xsl_error(ctx)) {
 		used = append_xsl_error(ctx, &header, buf + sizeof(header));
-		if (used < 0)
+		if (used < 0) {
+			ocxl_context_put(ctx);
 			return used;
+		}
 	}
 
 	if (!afu_events_pending(ctx))
 		header.flags |= OCXL_KERNEL_EVENT_FLAG_LAST;
 
-	if (copy_to_user(buf, &header, sizeof(header)))
+	if (copy_to_user(buf, &header, sizeof(header))) {
+		ocxl_context_put(ctx);
 		return -EFAULT;
+	}
 
 	used += sizeof(header);
 
 	rc = used;
+	ocxl_context_put(ctx);
 	return rc;
 }
 
@@ -464,8 +519,12 @@ static int afu_release(struct inode *inode, struct file *file)
 	ctx->mapping = NULL;
 	mutex_unlock(&ctx->mapping_lock);
 	wake_up_all(&ctx->events_wq);
+	/*
+	 * Drop the initial reference from afu_open(). The context will be
+	 * freed when all references are released.
+	 */
 	if (rc != -EBUSY)
-		ocxl_context_free(ctx);
+		ocxl_context_put(ctx);
 	return 0;
 }
 
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index d2028d6c6f08..6eab7806b43d 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -5,6 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/cdev.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <misc/ocxl.h>
 
@@ -68,6 +69,7 @@ struct ocxl_xsl_error {
 };
 
 struct ocxl_context {
+	struct kref kref;
 	struct ocxl_afu *afu;
 	int pasid;
 	struct mutex status_mutex;
@@ -140,6 +142,8 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
 
 int ocxl_context_mmap(struct ocxl_context *ctx,
 			struct vm_area_struct *vma);
+bool ocxl_context_get(struct ocxl_context *ctx);
+void ocxl_context_put(struct ocxl_context *ctx);
 void ocxl_context_detach_all(struct ocxl_afu *afu);
 
 int ocxl_sysfs_register_afu(struct ocxl_file_info *info);
-- 
2.34.1


