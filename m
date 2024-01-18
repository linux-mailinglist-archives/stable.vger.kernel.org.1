Return-Path: <stable+bounces-11885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591678316BF
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3401C21EFC
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4C22323;
	Thu, 18 Jan 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LM9aqgTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5CB65B
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574404; cv=none; b=m0PWmrvvILQNccA04s+dXlYBrrQfqMsiKw6+O2jHgdbVbuXAUiAwq4xzu+v5BOn/C6Tzgg9ObQkBdfZGbPLntIWrtqcYX4IQ3Pr0066cZEXhjIlE6nWGZgXUFWk2Xegpauj6e5IV4MQzJ/bjwm45NsGHZPyUAA0fQz5gCvvifnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574404; c=relaxed/simple;
	bh=3ytFaaWYkPszr7rIfZZOqbu621H1BN8PhthiyCGLn7A=;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=okiy5PpbYIElf+grtA82nYwln5N6UDy7Rt/CsfhjNcU8n3oSFCrmQ6UaZngRSOffQVtyHHjUBDNUfYSgWYdMxPOWH1YTdO1OI1o0727//qUFwq7goitQ0NCRVkhuzOm4O3r0/a2UU7EMyFk5JVZNj9cFA3Gl6/S5yBdEKEZE5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LM9aqgTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B27EC433C7;
	Thu, 18 Jan 2024 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705574404;
	bh=3ytFaaWYkPszr7rIfZZOqbu621H1BN8PhthiyCGLn7A=;
	h=Subject:To:Cc:From:Date:From;
	b=LM9aqgTQtrwxRz9GCFyy+sOFWfcKmpJtbO0dB8NLvuAOAGtF9VKQN0tioos85a2SM
	 MZRRWLm2gpiDawmdC3vpFRGjHRMZZf7OwwQUjz+VBVosut8iszW/N2E3nwR1f8/Gs9
	 RJUl+I2MoPboJz6T+8w1psqQJ1d9dMFPNNjosLLQ=
Subject: FAILED: patch "[PATCH] binder: fix use-after-free in shinker's callback" failed to apply to 5.4-stable tree
To: cmllamas@google.com,aliceryhl@google.com,gregkh@linuxfoundation.org,liam.howlett@oracle.com,minchan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 18 Jan 2024 11:39:37 +0100
Message-ID: <2024011837-velocity-scheme-4395@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 3f489c2067c5824528212b0fc18b28d51332d906
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024011837-velocity-scheme-4395@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f489c2067c5824528212b0fc18b28d51332d906 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Fri, 1 Dec 2023 17:21:31 +0000
Subject: [PATCH] binder: fix use-after-free in shinker's callback

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

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 138f6d43d13b..9d2eff70c3ba 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = vma_lookup(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -1031,6 +1033,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:


