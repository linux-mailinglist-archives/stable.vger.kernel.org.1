Return-Path: <stable+bounces-77840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888B987BD7
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D862285564
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B111B1428;
	Thu, 26 Sep 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUROLiVC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729781B1418
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393808; cv=none; b=I2rSNW4NEOWxMP09F4zsGxQMzjSRBMc1AjufhdyLu9DN1K5nvRa+sJApWfGzIX8+AdKDSOVLRhpPeB0O9ZkkDmnXG7/51YOfpEoWAOmUIJ/55k1kEXa6sXG0qMhMurqOW1JKRg41qc3Lgh+R1IwcqcF4vHLagdZljxVyw4Kskkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393808; c=relaxed/simple;
	bh=1H/W4FLKV9aI+2tDXe+blK4klm2uA7NNGPRe8emZgy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C11YKI7R/rVOV15wS3ISsM5ZROzlsyTucs/DHxFPNhkcoQZ3zpIWN/ZQJByywXGsdl4gcQ6aLuOie15OSSjKaQHGT51RHPrNJuUSfTXEvUgQKUUk57pqRS7IeNL4LCLTvcakI8zihau+DTw8XVxGcyJg9S6lX9J3pDiNbGzGFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUROLiVC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f8dc491so32075627b3.1
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393806; x=1727998606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZYDbwRcuTEgG5PxF68wd0LIkZGSaWChtDEKjs+v4lg=;
        b=rUROLiVCaZ/6WEcM5f4a0xoWS+ZKRfTIqSgmUfCa1NkZ1IHFi5e5q6w6sZYfXJyGJu
         axMKLhQEVkGiW+op9ptspVb9MvG+QuFZ3Zj5zW8JKl5KvHOA/lnHC52mfNTxnxDL6PZK
         sSR+iKhvy59NEXdM7NhBCYZnhOOToFV1vc7iechJN07fFMZaL8qsddanQ4NnIf8MzLc1
         ts2YxWo37bpRhMESiIeQYuYWMJNHNd9mAb9G/kg5wMYnFiIB0wqH380mpE9Go58OszpM
         BQMqnsMpFG5ZCigfncqGsNE+PuJQhI5C9eeQne3dPF4DGhWOQJZ6nJv6y9xOmb9fRPm8
         bc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393806; x=1727998606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZYDbwRcuTEgG5PxF68wd0LIkZGSaWChtDEKjs+v4lg=;
        b=HikJkZ6uHTaTBeLE1Nac48uRCzD2sfe2j+jvill+xTZknGt2TrcMHFX09e0R41pf9j
         R+994QJfv0qKLNqjc6aGc90APVwnf1LQpcE/YUvp9ZXhBSoAnZXVVoaL8CujlpCGUBE5
         rpjEdccojfJ8ApAnuOGfwbsaB0i2IZt+DXwICb6CzM/A7g6yXUlDfLG4Ms6djk4Id9hD
         Ej+kPRVX3gtQF9YCXjXuUT3eQCmErv+v4u/+ICnR/xx3IhBi3HgV+puTfw63KMJohHsK
         qHr2mm2Q/KD1adtjvcfE3289DV8lR5pyyY2mqJxxXpNUByjkypSNqI+EUPtqVyujvZ/r
         9xoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx07VFYMDkMQKbWM2llcgdsgMszlPWyL+KCskkpnm+TGL44VpHLgfhjSiHFsskPsC0kMLBsuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzitn0wSbQl5iNJ80ALguVf36vN2c8ZqyWN5XgTWRZCIO262gLU
	yBRAZFjbVD++RA6jt2Qn9SU2wdPn72Czw5Y63E6BnpcaEOLv3H9E1pezmIe+Yx+CuoJX5vykxMT
	FzZrewA8jhw==
X-Google-Smtp-Source: AGHT+IHUpbO3q7cBnv/gB0yirdup4+Tvvd6hv38/XsV96lDFMNN7F3BazQBkKmhQNTboRcKZJDjYAhbtpSu3lQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:3005:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e247604e65mr151807b3.5.1727393806468; Thu, 26 Sep 2024
 16:36:46 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:14 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-4-cmllamas@google.com>
Subject: [PATCH v2 3/8] binder: fix freeze UAF in binder_release_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a binder reference is cleaned up, any freeze work queued in the
associated process should also be removed. Otherwise, the reference is
freed while its ref->freeze.work is still queued in proc->work leading
to a use-after-free issue as shown by the following KASAN report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_release_work+0x398/0x3d0
  Read of size 8 at addr ffff31600ee91488 by task kworker/5:1/211

  CPU: 5 UID: 0 PID: 211 Comm: kworker/5:1 Not tainted 6.11.0-rc7-00382-gfc6c92196396 #22
  Hardware name: linux,dummy-virt (DT)
  Workqueue: events binder_deferred_func
  Call trace:
   binder_release_work+0x398/0x3d0
   binder_deferred_func+0xb60/0x109c
   process_one_work+0x51c/0xbd4
   worker_thread+0x608/0xee8

  Allocated by task 703:
   __kmalloc_cache_noprof+0x130/0x280
   binder_thread_write+0xdb4/0x42a0
   binder_ioctl+0x18f0/0x25ac
   __arm64_sys_ioctl+0x124/0x190
   invoke_syscall+0x6c/0x254

  Freed by task 211:
   kfree+0xc4/0x230
   binder_deferred_func+0xae8/0x109c
   process_one_work+0x51c/0xbd4
   worker_thread+0x608/0xee8
  ==================================================================

This commit fixes the issue by ensuring any queued freeze work is removed
when cleaning up a binder reference.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Acked-by: Todd Kjos <tkjos@android.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8bca2de6fa24..d955135ee37a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1225,6 +1225,12 @@ static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 		binder_dequeue_work(ref->proc, &ref->death->work);
 		binder_stats_deleted(BINDER_STAT_DEATH);
 	}
+
+	if (ref->freeze) {
+		binder_dequeue_work(ref->proc, &ref->freeze->work);
+		binder_stats_deleted(BINDER_STAT_FREEZE);
+	}
+
 	binder_stats_deleted(BINDER_STAT_REF);
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog


