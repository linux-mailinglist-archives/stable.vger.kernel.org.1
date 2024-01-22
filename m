Return-Path: <stable+bounces-12705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B9836DDD
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55471C27C29
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9255BAC1;
	Mon, 22 Jan 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxp5nVN2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEEE5B5A9
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942568; cv=none; b=vAWc5MwcBTWeejFJ4hntmDDrsCm6i+lUEb5PLuyBWA2pJGZxHJ++cfikYzazC9BiHQHo81Eoshe3/568i6+t98ZgaBTLXsKX1PTfHk7SCei+T5ZSR0e2UhYJ6FsE3//f6jpnMWwz59jQAnbP4Xu5EHDJSCh+hViTthd9d594W0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942568; c=relaxed/simple;
	bh=FqjirAP+Ut/vLC3+sj0UxT8xzIfifdx3G+Yn9noN5q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8jde5oq+5WyY+2kmvOD75NExFxi0/hBf2flRqFaS6rJIys1ljTJZMyhFTE2PvhJs4WZODg29xsNu2enkZDpF+ALofweVK9432mfapifyF4faKWXVoHyJ37Lcz97LEJOW8oIW88RW6d+97IZmswBggf8DctZNK0Y+TOkfadfzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxp5nVN2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c66a69ec8eso3799933a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705942566; x=1706547366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bgpvX7nPKDBQ/B4TZ6pXqTiQd5FJI9QOY3vZ8HezAk=;
        b=xxp5nVN28YsPLEOIdjG8mz33RDnZxGTqOESkx0YhllxEQuvgXcgVjwrIPulY8Kw7v9
         x/tsoHgrixrymEhhI8yQdjEPRC1mGExgp8NOJSJ98gr+1sm/phVqWbnJDmerGWDjl4u9
         rmv2D62BORu3cCYu9RVramZocFOuQHKdER6otixEliXBieJElSwgwZ96IJXseqgYRv2g
         yD9RqT4nrNMF+2r39Cp8r4hULfVTk8N9cfsL8uNAtAhFoGLLJEol5E/gK4pLVMnhsiOU
         Ez87hZsCm505nMpMTuKaJhDvQ4tx92cRDckBLmMvWfbo4yvFrA+Jz4RrTAR8Gc5eb5MS
         qjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942566; x=1706547366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bgpvX7nPKDBQ/B4TZ6pXqTiQd5FJI9QOY3vZ8HezAk=;
        b=axSaQbdRx7C+sV/dnbGRRakmbQF1DgQ03dpRMhUePoQHJ7+2EsLIzW0FXeBw3VIIU/
         OTxBUwWlcyHBPozdaF9Mh4MwGA5oR5pxuNrAgLVQF2Q8DWcaJZHeVrTSVtOxdtGcth3n
         Qe1oa7dKdqKg0qNyDB+awniXHIS2u94XJGpaKGkPPUHci6l9QexukhKWAtNvnwb7+DG8
         dYkWcvM5Fi8ihhYZaEyRRtx4mekbtIQ0/qnQ6Z4vY5n+iVcrRIYrKsf07Enuv30nAC8p
         MYqNh5kGiMyigEtEAPaOy+n7tRVvdlyIi72L7bsO7gl6m7dlyoGJ3wN8ntP/MopIuAJC
         Q0jQ==
X-Gm-Message-State: AOJu0Yz4812/rewkAo/JVTMw0ttWg6EsmZwL/umpwQ8PuuhCn/55Jip0
	rzI559fkY2RmV/dDQvoolC+lQpMwgWPAD65/raXTUpdbMctE+/n702EPHmuFqJAibsCWncw9umS
	+WAPpwUZUva95QkxZJlFUHtg29scQz6Zf8EyshMVJMIYRn2P0kta7yfGjjhDtbZX8WneAz0Il4v
	k+iLiUrW9i1ACAmKBU5L73MAFiR5YAVtF+vWZMCd2ygzo=
X-Google-Smtp-Source: AGHT+IFncsRn2tdN7gPG9c0+tB8Ja+tptk4227hv4ECkQHk6a9VQ7+m67yTuaAMa/iIxT7rKx6Pc3TTJGpgdTg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:4301:0:b0:5ce:6c6:6973 with SMTP id
 q1-20020a634301000000b005ce06c66973mr24396pga.8.1705942565609; Mon, 22 Jan
 2024 08:56:05 -0800 (PST)
Date: Mon, 22 Jan 2024 16:56:02 +0000
In-Reply-To: <20240118215119.1040432-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118215119.1040432-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122165603.2107402-1-cmllamas@google.com>
Subject: [PATCH 5.10.y v2] binder: fix use-after-free in shinker's callback
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
 is missing in v5.10. This only works because we check the vma against
 our cached alloc->vma pointer.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v2: remove leftover cherry-pick line from commit log

 drivers/android/binder_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b6bf9caaf1d1..61406bfa454b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1002,7 +1002,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = find_vma(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -1028,6 +1030,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
-- 
2.43.0.429.g432eaa2c6b-goog


