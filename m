Return-Path: <stable+bounces-179655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C80B58734
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2657A2A3350
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83529DB8F;
	Mon, 15 Sep 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zh+fRe+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305E2C0260
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974376; cv=none; b=CLOzKdS+T2qISRN6pTaMKdg1MjgD5iGDpV6cvUfj4yB1IBpH39rA27J33yMXeH5rsRx0103lxY20PbGfuVsXNhQBM34GMrJc2SgS3oRDBwJtaT+ro0Aa8/QRNvmqJuYPlhIGtq4Sp/Rg0sYigAd3yF4Qaut5rL9hfa+AwIrPmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974376; c=relaxed/simple;
	bh=DVlri7iCY4MppHBj5wNw7dj3I14e1CKN3HUDI+4tCxc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=arsKpb3nxthKcCyBTBPVob4IKCNZizohvhmp4xuGvyG7JeJDfVd6mm0qY5i74oPitLBola6+J6MGFkv1cItuS09UGSJIdOT+wLkN1I81t2RZv93mbHJokLTajCGje6fY7XobF45gIgNlhfWjK5Ces++1LljAA9SKcp/IoThlc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zh+fRe+Y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458274406so91454225ad.3
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757974374; x=1758579174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j87FXg7tFCRagVDld0PEyw37R7wt3rGw/96+RjwDdpc=;
        b=zh+fRe+YJX/Bb+/CxIxM+9MJ78BDesrkz23xE1ox02Wng9oGIrxafdZbpv9yRevap+
         ERjJBuTZbMRcGrmSoFiGlfkh2hwrfqmoA6o5qiGIp88zuCITmV0m9L0YUusRtzvK8dsd
         ypnfa+zZDGv+wTK7yOL26v6N+53S8SXh7HUR/OkzbVtcWIPiwxhcULXCGuk6QeqmNxEy
         I/txx3ltug6suifUM49ZK0DbwVREfweSzABoiSDPR24Fo0V9VojXxHE/dEkGox2gF3+W
         8WCzP/kwFoEA7AnRHYf3fscIAxY8hUdul9H/N3lyDAYargDQewMFlsZhwcK1e+pJWzVd
         rUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974374; x=1758579174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j87FXg7tFCRagVDld0PEyw37R7wt3rGw/96+RjwDdpc=;
        b=EUZxaKpM4fLugoWqAuVLKfX0vS001Mdc+jPQ9tVKY6mNZ8HbWrfCjbLumOStK8gulW
         ZZAgbgsPEj7Zdzb3o/V9DvNyd9qEdROVgbKd2uHsaoiOxBKXMx4Bz6EDCHePLpuucVOv
         /jLGPG+HKQqg0GpyWCI5iWbjcBSyfgMdPaaNvf5hFVGKiWfNFn49uqa5Nbrhjnib5Z+7
         ylboaWMyRLouTD+zE0BGouH9COWob8ZQrU2PhcQoEup9TvHDW/Azj19X2zc0mQ21/teT
         316qGahppOKknMFZJaJoEuo1InOHlb5ur2ZBuxdhvCdX8Esnwjca2exT4fqee+E2v23g
         N3sw==
X-Forwarded-Encrypted: i=1; AJvYcCXCw4eSYOJ5Gh/apT8LFPLFieffR6uI+XUaE7QVI/Z209DmSwrHFokqkctSCmeh2iDE4J2s+lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX21kYTWz845DnUpapn6T7l+gSuBdNhupvJHcZwFpbQ/jt0c6J
	Zt0zreAkx659XXOLXlKdUz3+rYMhi3lahdRhFLnb6s1ZLiBBKKjePEhcf4FAd4yjHEdkMNR21bg
	3lKnY/zLefSrpeQ==
X-Google-Smtp-Source: AGHT+IFESkUZb/k54fYGaZPTJJrL+f2Yr5vCiqX3z2w9zyP+DcCmdgG7J/85fpkmx6lSHtDQasSIhXCTc2ZlIA==
X-Received: from plbme6.prod.google.com ([2002:a17:902:fc46:b0:24b:14e1:af48])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ac6:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-25d25a72d8dmr182399555ad.18.1757974374029;
 Mon, 15 Sep 2025 15:12:54 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:12:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915221248.3470154-1-cmllamas@google.com>
Subject: [PATCH] binder: fix double-free in dbitmap
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Tiffany Yang <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A process might fail to allocate a new bitmap when trying to expand its
proc->dmap. In that case, dbitmap_grow() fails and frees the old bitmap
via dbitmap_free(). However, the driver calls dbitmap_free() again when
the same process terminates, leading to a double-free error:

  ==================================================================
  BUG: KASAN: double-free in binder_proc_dec_tmpref+0x2e0/0x55c
  Free of addr ffff00000b7c1420 by task kworker/9:1/209

  CPU: 9 UID: 0 PID: 209 Comm: kworker/9:1 Not tainted 6.17.0-rc6-dirty #5 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  Workqueue: events binder_deferred_func
  Call trace:
   kfree+0x164/0x31c
   binder_proc_dec_tmpref+0x2e0/0x55c
   binder_deferred_func+0xc24/0x1120
   process_one_work+0x520/0xba4
  [...]

  Allocated by task 448:
   __kmalloc_noprof+0x178/0x3c0
   bitmap_zalloc+0x24/0x30
   binder_open+0x14c/0xc10
  [...]

  Freed by task 449:
   kfree+0x184/0x31c
   binder_inc_ref_for_node+0xb44/0xe44
   binder_transaction+0x29b4/0x7fbc
   binder_thread_write+0x1708/0x442c
   binder_ioctl+0x1b50/0x2900
  [...]
  ==================================================================

Fix this issue by marking proc->map NULL in dbitmap_free().

Cc: stable@vger.kernel.org
Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/dbitmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
index 956f1bd087d1..c7299ce8b374 100644
--- a/drivers/android/dbitmap.h
+++ b/drivers/android/dbitmap.h
@@ -37,6 +37,7 @@ static inline void dbitmap_free(struct dbitmap *dmap)
 {
 	dmap->nbits = 0;
 	kfree(dmap->map);
+	dmap->map = NULL;
 }
 
 /* Returns the nbits that a dbitmap can shrink to, 0 if not possible. */
-- 
2.51.0.384.g4c02a37b29-goog


