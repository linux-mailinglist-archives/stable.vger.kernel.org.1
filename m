Return-Path: <stable+bounces-146285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0397AC31C0
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A8D189B3D0
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA181E835C;
	Sat, 24 May 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgOCmoQR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C731DDA0C
	for <stable@vger.kernel.org>; Sat, 24 May 2025 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748124506; cv=none; b=h5DGpbVebUTeXFf2fGRiQUGo4/ILAXARQgOisSkwKV2oG2wzdcGqG6DxArkcTBfJF75X34Upk0TpBNgvPtu0eILvFhII7byneO3AG3ivm41jgPuDYVhZeqp03sKFaEoZ0XDLHUsZup4UkqSDrx/x5ZHeBOJyB1hVqjGVv0Nom7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748124506; c=relaxed/simple;
	bh=tZs7NRKsUJ2NMCg2LzJ97LxL4RE+ttC9dN2NrHYBeGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IXqrgza3UAMrJC+hioqWaR29V1CqKlSflIqcbUy4YzROUgqM2kUUjaKwlBqLC3LcW1EGvhtE/NVgZqCmUAiK8F/LFL+WTH6nQCIaJ1UU7N7DKUL4fiFFr1oyZkwK8i8kMoStHAtMNDbQKktdo3KGwmSldAQlMwxRGKDDxDWzF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgOCmoQR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31147652b1eso184063a91.3
        for <stable@vger.kernel.org>; Sat, 24 May 2025 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748124504; x=1748729304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iskZ0wbtxEgIO67o7SDMCe9ZJO7/1YZczvX+o4kIFTo=;
        b=WgOCmoQRqIQWB9LNRWUhGOUThZ0I76zqFCO4uwxmMP5ylG3RYVONNVnZ/anvrLSiAP
         121JnwbowfBERy5phioyJmhWAt5GCNPQ4Ra8cZ9vd9Y6Xx+bKkVbFcBWxmoFIfA95PTw
         0f54woSIV+GXxx3hrHkQE9SkdQ7CozJV10ubPV86DRptF46bA0xf0pqlYiJJ0aPpXs/b
         zGPrO/WqoiR3CzmkYf+E+uIWypcdzFZR9T4WAa/zZs+2WWak9RV6pRMNwp0ltou/Yc8b
         in0hnuyJvZdZISRFVKEzI/1HSnF/gK3ZOHoqMnGLkgtR+mQT47g8d2K0vmiibrFwD2yO
         lkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748124504; x=1748729304;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iskZ0wbtxEgIO67o7SDMCe9ZJO7/1YZczvX+o4kIFTo=;
        b=bdrWRXaYwpngqLtC6IpUrrAFwXRzW7UzB88qx7qj4PvF1OTn3U9frmxM9bdmFjUiAa
         sQrRVYrqXINHVOyoQp5PqXXLOG+D/jKQkRGSErfHtlDYsBaXHaTOe7gzJxYM4tUgNgJl
         4yRljh+krpabsrObC6xrKytDgYaRpB7zMON1Qak6tWE3GijpN0mAs0TxCU5IpdjEXlDH
         j1KGnBLSHOpb0E+6TE0/z2yOBlSBNjT4NYanVh7pabTVnI7AVYH2j0F7L2xlc+smN0QH
         ++4RQRcTIigI9MfNLRP2APIE7RaDmaDWKy4oZ3O1t5pZ6NMnTUcmhywrhT7l42Mb2b8n
         1Cqw==
X-Forwarded-Encrypted: i=1; AJvYcCUywXQ964p8jxrFbxkR7LDgCC/o+VI00Hz205gKp1Z+DS6swqEpvuIJtwcqz9p62nYGCtyulnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdjU1h/3TjtUKJQ1h3BMQPWuvHaiR3sUqJv51TYyMWpv2GLmE
	+E4ZPqAayAoOY+aM4BJnmcvz8np17kW2/kLhnWIb8vXVBoQS3KdDncGPOx8B6hh7F2HCU1r8x7C
	jL6PasV5GoTZnhA==
X-Google-Smtp-Source: AGHT+IFSOu2l1RSQyb5J33cvCnuI8bwGn0Pmrl610mWwBVpPxY+L0tTl9KYax7U1Qo44s1kzSSsp1UIViDf/DA==
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:2ea:3a1b:f493])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d88:b0:310:f340:79d8 with SMTP id 98e67ed59e1d1-311104b6599mr4040692a91.22.1748124504610;
 Sat, 24 May 2025 15:08:24 -0700 (PDT)
Date: Sat, 24 May 2025 22:07:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250524220758.915028-1-cmllamas@google.com>
Subject: [PATCH] binder: fix yet another UAF in binder_devices
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Li Li <dualli@google.com>
Cc: kernel-team@android.com, stable@vger.kernel.org, 
	syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
addressed a use-after-free where devices could be released without first
being removed from the binder_devices list. However, there is a similar
path in binder_free_proc() that was missed:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_remove_device+0xd4/0x100
  Write of size 8 at addr ffff0000c773b900 by task umount/467
  CPU: 12 UID: 0 PID: 467 Comm: umount Not tainted 6.15.0-rc7-00138-g57483a362741 #9 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   binder_remove_device+0xd4/0x100
   binderfs_evict_inode+0x230/0x2f0
   evict+0x25c/0x5dc
   iput+0x304/0x480
   dentry_unlink_inode+0x208/0x46c
   __dentry_kill+0x154/0x530
   [...]

  Allocated by task 463:
   __kmalloc_cache_noprof+0x13c/0x324
   binderfs_binder_device_create.isra.0+0x138/0xa60
   binder_ctl_ioctl+0x1ac/0x230
  [...]

  Freed by task 215:
   kfree+0x184/0x31c
   binder_proc_dec_tmpref+0x33c/0x4ac
   binder_deferred_func+0xc10/0x1108
   process_one_work+0x520/0xba4
  [...]
  ==================================================================

Call binder_remove_device() within binder_free_proc() to ensure the
device is removed from the binder_devices list before being kfreed.

Cc: stable@vger.kernel.org
Fixes: 12d909cac1e1 ("binderfs: add new binder devices to binder_devices")
Reported-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4af454407ec393de51d6
Tested-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 682bbe4ad550..c463ca4a8fff 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5241,6 +5241,7 @@ static void binder_free_proc(struct binder_proc *proc)
 			__func__, proc->outstanding_txns);
 	device = container_of(proc->context, struct binder_device, context);
 	if (refcount_dec_and_test(&device->ref)) {
+		binder_remove_device(device);
 		kfree(proc->context->name);
 		kfree(device);
 	}
-- 
2.49.0.1151.ga128411c76-goog


