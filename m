Return-Path: <stable+bounces-12220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187D48320F9
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 22:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C8285E44
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612662EAE6;
	Thu, 18 Jan 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru49Vsla"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88592C197
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614193; cv=none; b=KxXkrDt2mLD65v1QOfqtU+A/ENsRgstdqOJ8e0QPSrJoxugx2o3p9kHV64PG2sjBsZLCkgo/zjS2e0MRml6YPR+XOjCODiyv4HQH4ziXoJV4nJo/ePiCXozVyWAeYe3sCbUCMkNJ2ofFnbr0Ko/Wxwbzvt+8qcwRZyHYKNzEBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614193; c=relaxed/simple;
	bh=j8yOfncxkjjdOCkRzCJpbak8qwTBuE+nUC17WZq1y3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qx5R0wTcli/EvE7ldXPoLomF3kMsLlOf8us7cBgDgsd0HDqzQ054HCmxJAQanMpNEz9/HjntTbOD65J3XSeLhcnKl1GjKLpGM1LLlxNhlrK3d47Ydu7In/iawXECUxpocIyVSMmY+UhpqxaNsJp7whlQRbwHzYdoks6SPuIjwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru49Vsla; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e617562a65so1860977b3.1
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705614190; x=1706218990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Co98/eaTR5iaXZeYgbld8aWqZnRUEzyOIm0WUOGIVo=;
        b=ru49VslaxHTZWzHBDQ82vpvFj1wCgSJKLH0kNZUJYObbNLJh8SgngjjNtII4W+meoh
         zlptr01+Al9GfemTXezUDQCsHEPB/DPIUZ9dSKCfTQcmPLJRlVmvc5eNpKGDxelHDhQJ
         /k+oGoXCUnhZfzqY/FG3eR9lrAas1+bQEewTp/HlsS/Zqp4wy7hgpFk2vzi6I7VjoG+U
         UNC4iqC8pUEfnBMMfZgpxI9Z4z81tkVmwBBroRRPpiWqrraCxj/1rZeHTUgNvxTIMxsa
         9xFoHaI41IGAo7Z/EozUPMUuAcWjJfKXMprj23VABvS4hexxeEafbrvHfZVyQr/n7ip2
         fm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614190; x=1706218990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Co98/eaTR5iaXZeYgbld8aWqZnRUEzyOIm0WUOGIVo=;
        b=eVoAoJUNoHF3N5Ltf6yk+bIrl6iuMxqCUp2Mrr/edsH1TbBOfFv4MrNhh885JANd1f
         TZdshCwYOrW6tcZFm7qol7lFn0WupNrh3YlUXQGv8lYnWRqJI1msRW2m7u5opKonSjzV
         NRGM62zi1nVC9eF40/JEDxSO+YB72A8ACh5iHnTzbri6cIPojYY6EA9LedwE+dnyzmRb
         FJRvKGZYwQ9pHH1RR9FI2xSj2ibkweXpozlJDzx+FxuOeR3JsaXiSg9fBLED+xsVg0Tg
         8ZKfDD0To1iMqgC84YVJOe3U+a4tLMMu3uEj0Mws5K5KoHSokbEO554Jgotuuf27NgWC
         hdRQ==
X-Gm-Message-State: AOJu0YxboLcwRYzl0t0iiBF47dEKzSLedO0jb0XwhEWVRCCazM0pkjdH
	sL8JXfqOLvj4w737YvXf+IzzKr3YeZd7eEh8/Eg1okTADj6bYNvp1WtpIARTYRKXs8cszEFnm5Z
	Jde4K81mFCrSRjIxVGIv55fWuSnviaj7D3F0DMp+Yn9U/pjPTgobN/6rPEpQFr3qCHrX9sO24B6
	1coso6XRkQudf8HUB93T7rwP6Zn1KjjuZ/L5IDrRFYYtQ=
X-Google-Smtp-Source: AGHT+IFzQjXztABPa+d6GHbYxizlFHE4C9ITCZlSr9sx6kyuFsfSIRo1qbUYH5E0Ghs6mdSry040Nz/4hY0xhg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d80f:0:b0:dc2:195c:602d with SMTP id
 p15-20020a25d80f000000b00dc2195c602dmr653308ybg.11.1705614190658; Thu, 18 Jan
 2024 13:43:10 -0800 (PST)
Date: Thu, 18 Jan 2024 21:42:46 +0000
In-Reply-To: <2024011855-lyricist-marshy-4883@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024011855-lyricist-marshy-4883@gregkh>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118214246.938824-1-cmllamas@google.com>
Subject: [PATCH 5.4.y] binder: fix use-after-free in shinker's callback
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Minchan Kim <minchan@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit 3f489c2067c5824528212b0fc18b28d51332d906 upstream.

The mmap read lock is used during the shrinker's callback, which means
that using alloc->vma pointer isn't safe as it can race with munmap().
As of commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
munmap") the mmap lock is downgraded after the vma has been isolated.

I was able to reproduce this issue by manually adding some delays and
triggering page reclaiming through the shrinker's debug sysfs. The
following KASAN report confirms the UAF:

  ==================================================================
  BUG: KASAN: slab-use-after-free in zap_page_range_single+0x470/0x4b8
  Read of size 8 at addr ffff356ed50e50f0 by task bash/478

  CPU: 1 PID: 478 Comm: bash Not tainted 6.6.0-rc5-00055-g1c8b86a3799f-dirty #70
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   zap_page_range_single+0x470/0x4b8
   binder_alloc_free_page+0x608/0xadc
   __list_lru_walk_one+0x130/0x3b0
   list_lru_walk_node+0xc4/0x22c
   binder_shrink_scan+0x108/0x1dc
   shrinker_debugfs_scan_write+0x2b4/0x500
   full_proxy_write+0xd4/0x140
   vfs_write+0x1ac/0x758
   ksys_write+0xf0/0x1dc
   __arm64_sys_write+0x6c/0x9c

  Allocated by task 492:
   kmem_cache_alloc+0x130/0x368
   vm_area_alloc+0x2c/0x190
   mmap_region+0x258/0x18bc
   do_mmap+0x694/0xa60
   vm_mmap_pgoff+0x170/0x29c
   ksys_mmap_pgoff+0x290/0x3a0
   __arm64_sys_mmap+0xcc/0x144

  Freed by task 491:
   kmem_cache_free+0x17c/0x3c8
   vm_area_free_rcu_cb+0x74/0x98
   rcu_core+0xa38/0x26d4
   rcu_core_si+0x10/0x1c
   __do_softirq+0x2fc/0xd24

  Last potentially related work creation:
   __call_rcu_common.constprop.0+0x6c/0xba0
   call_rcu+0x10/0x1c
   vm_area_free+0x18/0x24
   remove_vma+0xe4/0x118
   do_vmi_align_munmap.isra.0+0x718/0xb5c
   do_vmi_munmap+0xdc/0x1fc
   __vm_munmap+0x10c/0x278
   __arm64_sys_munmap+0x58/0x7c

Fix this issue by performing instead a vma_lookup() which will fail to
find the vma that was isolated before the mmap lock downgrade. Note that
this option has better performance than upgrading to a mmap write lock
which would increase contention. Plus, mmap_write_trylock() has been
recently removed anyway.

Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Cc: stable@vger.kernel.org
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20231201172212.1813387-3-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: use find_vma() instead of vma_lookup() as commit ce6d42f2e4a2
 is missing in v5.4. This only works because we check the vma against
 our cached alloc->vma pointer. Also, unlock via up_read() instead of
 mmap_read_unlock() as commit d8ed45c5dcd4 is also missing in v5.4.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index f766e889d241..fd5e55db44c2 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -953,7 +953,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!down_read_trylock(&mm->mmap_sem))
 		goto err_down_read_mmap_sem_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = find_vma(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -979,6 +981,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	up_read(&mm->mmap_sem);
 err_down_read_mmap_sem_failed:
 	mmput_async(mm);
 err_mmget:
-- 
2.43.0.429.g432eaa2c6b-goog


