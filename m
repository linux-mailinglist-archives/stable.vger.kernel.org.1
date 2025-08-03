Return-Path: <stable+bounces-165816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F8B192FF
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE76C18950B5
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654EB283FDC;
	Sun,  3 Aug 2025 07:23:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C5283153;
	Sun,  3 Aug 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205830; cv=none; b=MYQ3r+FQhdg0AV8FtnnrFFmRztJ2cAs+oQBInLRuaBxjDphK6Ps8hazqoTedOGc1I5URcXVgjwJXYO8C0oPUoNTml4p5vvxf5bFFBYxwv0UAPARMX1NxnS/Z+KXXTpkZH5kbJ0cVDArmtZlir4PaMh4HCCS0P8+3RvjVlrE0mqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205830; c=relaxed/simple;
	bh=o7Sze8vSL1lmHX9XqvuAQ36eR8fWKDTdm/ltFp30Vv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM1hj4C9a1B2/2G3KGfQFSjcGzVkwmOKDC0+KMhLYlV6JxoJm+4jlfM7VVfA/3ZQ87HoKUul4fBNm/OKDIC+h0POXr8u/1aUARr/cgB7ahAwFXj+WQ6+a4t2WYhgjz1UbhE4So82eS8eOWEIdyhRc8JXa5LOA168hEwCGxzmgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31ec291f442so583749a91.1;
        Sun, 03 Aug 2025 00:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205828; x=1754810628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gFNaxZHXVjM+wPnIV705hxHarQ4JJ47HvINcfGklyo=;
        b=nRc8Rh88aRlV5MvFaMk0Q1XFHNbSXiZ4bMTxgtYcEKux8n6C0C0P0+H0HUJ1m3bqAw
         SOKLx3xn5pCvCgTEGR3VBnZIRc/kC64w+CIa1lBw62HWRApeUEviNjBGFgJtj8RSy2dE
         qYL9B+3T0F6KaYJifo256DHimtxZL73ob+K+VSjajlT+SJra2s/FQLJeBUqGRqHAJvxt
         p2e0rmdYwInJenHKvUhGbeFpWqhEwh53bvawEaANB5SIffr5/JYNC+5THNxfQOraiWzC
         FzB3jVHNYlWTuSxe/D+s9qXXec8hv65T9KHcWHRXhICyJ/OWmuDtL/rZgmpuqJJ7Rgsz
         88EA==
X-Forwarded-Encrypted: i=1; AJvYcCVwiY9Ya+zsd5+rNls+6Z4CnJFAE1nktb+NxTZj5DpkFTvdBcYlIjJe+VsiY/Xq9VNbOyjuO2or@vger.kernel.org, AJvYcCXksUSXUcovFrcxDN2/BALwd5kLAOyJpklu+Azhu26r0ByaOamTcMBHn+6zLPUkW2KVy1be46jJcg36n2s=@vger.kernel.org, AJvYcCXwgl3GszLkxG6dEDFqiQ1wQzGjOlxFSoynj41fadol8Y5RCqOcYkNbEesW4zVfXSxkYty+ImAE/s3r@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbkHL5pANP+SsHGb3jHrkeWykYEokBRXcUpKsvyAh4fZ8VGIJ
	c/oQ6xhmlR9bNTCGR0GlzLEdSjYkitW+KSnwWUGJ9Ef8jXSowvJkkgpJ
X-Gm-Gg: ASbGncvHC2T5LbCIm0K3wzmIR2dn6em17XDgpT4d4AQcE6gtPON5bvj3ZevCndhp80G
	R9LSEgU8Bu4a4qYF5tc4YlYMWmCdfMpl1bOFM0RUzCC8lKYGod6x5SvB1mHfHGVdaPFke/Im/00
	0DkINYBkmBK4xlzmwxOP54VhcWk3UQWAstIjlgedRunux+IIoOgeHhzzuKmn8Zwf1pz+4FqleKW
	T83R5TELpeHx4Pj7e194QHrrrRn+efTnvr6WrFRiqCUEiKIvYRJIOE7r7bv+HQ+J8cksMVDXjxO
	iGFs+n2xfZ2aA4UvHBtetDDS078+xgOf1g9C/Mb4lOm8CKrry4oTciaSrbc69klakYuZ2QA4VPS
	JURO6Rc2zF2uM
X-Google-Smtp-Source: AGHT+IHvGJIfC5VXqgphZ7FgmcKBMtlLf0lp9Zp058suCZRx8lnKA8DsXGVlqbqZPFKDrux4mS/HIg==
X-Received: by 2002:a05:6a20:7287:b0:240:75c:6f53 with SMTP id adf61e73a8af0-240075c7fdfmr14637.7.1754205828126;
        Sun, 03 Aug 2025 00:23:48 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:23:47 -0700 (PDT)
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
Subject: [PATCH 4/4] kcov: move remote handle allocation outside raw spinlock
Date: Sun,  3 Aug 2025 07:20:49 +0000
Message-ID: <20250803072044.572733-10-ysk@kzalloc.com>
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

To comply with raw spinlock constraints, move allocation of kcov_remote
structs out of the critical section in the KCOV_REMOTE_ENABLE path.

Memory is now pre-allocated in kcov_ioctl() before taking any locks,
and passed down to the locked section for insertion into the hash table.
error handling is updated to release the memory on failure.

This aligns with the non-sleeping requirement of  raw spinlocks
introduced earlier in the series.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 81 +++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 1e7f08ddf0e8..46d36e0146cc 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -113,15 +113,9 @@ static struct kcov_remote *kcov_remote_find(u64 handle)
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
@@ -580,13 +574,14 @@ static inline bool kcov_check_handle(u64 handle, bool common_valid,
 }
 
 static int kcov_ioctl_locked_remote_enabled(struct kcov *kcov,
-			     unsigned int cmd, unsigned long arg)
+			     unsigned int cmd, unsigned long arg,
+			     struct kcov_remote *remote_handles,
+			     struct kcov_remote *remote_common_handle)
 {
 	struct task_struct *t;
 	unsigned long flags;
-	int mode, i;
+	int mode, i, ret;
 	struct kcov_remote_arg *remote_arg;
-	struct kcov_remote *remote;
 
 	if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
 		return -EINVAL;
@@ -610,41 +605,43 @@ static int kcov_ioctl_locked_remote_enabled(struct kcov *kcov,
 	for (i = 0; i < remote_arg->num_handles; i++) {
 		if (!kcov_check_handle(remote_arg->handles[i],
 					false, true, false)) {
-			raw_spin_unlock_irqrestore(&kcov_remote_lock,
-						flags);
-			kcov_disable(t, kcov);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
-		remote = kcov_remote_add(kcov, remote_arg->handles[i]);
-		if (IS_ERR(remote)) {
-			raw_spin_unlock_irqrestore(&kcov_remote_lock,
-						flags);
-			kcov_disable(t, kcov);
-			return PTR_ERR(remote);
+		if (kcov_remote_find(remote_arg->handles[i])) {
+			ret = -EEXIST;
+			goto err;
 		}
+		kcov_remote_add(kcov, remote_arg->handles[i],
+			&remote_handles[i]);
 	}
 	if (remote_arg->common_handle) {
 		if (!kcov_check_handle(remote_arg->common_handle,
 					true, false, false)) {
-			raw_spin_unlock_irqrestore(&kcov_remote_lock,
-						flags);
-			kcov_disable(t, kcov);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
-		remote = kcov_remote_add(kcov,
-				remote_arg->common_handle);
-		if (IS_ERR(remote)) {
-			raw_spin_unlock_irqrestore(&kcov_remote_lock,
-						flags);
-			kcov_disable(t, kcov);
-			return PTR_ERR(remote);
+		if (kcov_remote_find(remote_arg->common_handle)) {
+			ret = -EEXIST;
+			goto err;
 		}
+		kcov_remote_add(kcov,
+			remote_arg->common_handle, remote_common_handle);
 		t->kcov_handle = remote_arg->common_handle;
 	}
 	raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
+
 	/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
 	kcov_get(kcov);
 	return 0;
+
+err:
+	raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	kcov_disable(t, kcov);
+	kfree(remote_common_handle);
+	kfree(remote_handles);
+
+	return ret;
 }
 
 static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
@@ -702,6 +699,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	struct kcov_remote_arg *remote_arg = NULL;
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
+	struct kcov_remote *remote_handles, *remote_common_handle;
 	unsigned long size, flags;
 	void *area;
 
@@ -748,11 +746,22 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		}
 		arg = (unsigned long)remote_arg;
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
 		raw_spin_lock_irqsave(&kcov->lock, flags);
-		res = kcov_ioctl_locked_remote_enabled(kcov, cmd, arg);
+		res = kcov_ioctl_locked_remote_enabled(kcov, cmd, arg,
+				remote_handles, remote_common_handle);
 		raw_spin_unlock_irqrestore(&kcov->lock, flags);
 		kfree(remote_arg);
-		return res;
+		break;
 	default:
 		/*
 		 * KCOV_ENABLE and KCOV_DISABLE commands can be normally executed under
@@ -762,8 +771,10 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		raw_spin_lock_irqsave(&kcov->lock, flags);
 		res = kcov_ioctl_locked(kcov, cmd, arg);
 		raw_spin_unlock_irqrestore(&kcov->lock, flags);
-		return res;
+		break;
 	}
+
+	return res;
 }
 
 static const struct file_operations kcov_fops = {
-- 
2.50.0


