Return-Path: <stable+bounces-12221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D3832117
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 22:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD31C24E74
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796872EB06;
	Thu, 18 Jan 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSRSVcjE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E632193
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614685; cv=none; b=KaJ9Q1moXkY8c+UY7l5Mwf7xtZ/CCWAy9YfRLViNUXvyQloVQVKJu3Cz45JQ5tdPASUVfB+SLnQuLQC6INLKzs8SVCS1CKEilVJEQuMJtNYq9CO7YQuetYS9gLSDTnIjl0WzACTriFYuZSvioxxuQRLrd94N0KIXIIaURH4l/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614685; c=relaxed/simple;
	bh=AWjc/5pSQC/fXekBaY9x5AcXjvK6JQ2ukKnkRouiS3A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pzz4vrh9OLWoNpsY7Ri+XrGb1ztSqDajRTNJM+fCw0cggbTfYy0/GVmwulC1CZ8K0sgiKfxuD0VV5Oo9pLC5cWlhfmtLx2Eh8fkasMkux9WS3P+Sy2oBqgATfP15C5+FjM7mv0aMC1Sj/PMCuqLZFsEVUfpnC+tzoe2d1zdiHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSRSVcjE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc265e24eccso39279276.0
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705614682; x=1706219482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txIFeJvia0pMllsmsZtmcaqJmLFp22N+ZM+37AjL20g=;
        b=rSRSVcjEL0445bMtNe50cJ0YbWSNLZunUJizBC2DgGUHc1Ac5amPM01CZ1Z3VdwiDZ
         BQtS2Qn3x9KmgZqiokNw2oa5Vc5UD52Til7ncoyQIJ2JNmVy3elLSNTuIzpLoU7TIrZS
         YMwc9i14ayFclwsoelhI/UkKJAAB87KNy+RTs2KlJ9Cb2kwI+6BL0OQSxnS1Xr2BbBVP
         TScSRd7rp3GgKCUJulB1pdlVNbKvFUwwSDHfAuHQjfYdw3MULv9ERUVEAyjVrSTFUU7J
         RLOY0EQxCNzq2q0Nn3yVuE0cSbqMfQmdWgvYcNcHmDYKfK6jE51Q8ghHV/0ycU4pmGFP
         LDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614682; x=1706219482;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txIFeJvia0pMllsmsZtmcaqJmLFp22N+ZM+37AjL20g=;
        b=JH1lDKZ1rMeLbTGsIFRRuT3DtYXOwRvekaEXxmrg3K+rPwNYx30sH3K4OacXeEPmED
         f1H3qp5BVVBjpn+vvAA5B01wXmF+9I2ZSsCrq73oTh3pyDDNuRFoPEwLEnw1AdlJmPsj
         ZXjB7RzFEY6f35+2V9qWFtDBU7KXvB+5ct4bSMWFd24UDlzUdfWizF58nGNtcMUEzk29
         MzjvxHV9CII5vC5ToUM8x4r7eYu6CvXPUhG7gcOhdTvQuKEsXDA6HMdBW8dtWh6HaIOe
         PSkj9U+9fskSItPyq/Ix/4ITABrh5oCCxNdd5O0WiZVtrnwu/7Frxzuz5EhLKp7aCX0p
         pUTw==
X-Gm-Message-State: AOJu0YypnuW4eHA3+3Exym7OUxnSNmyHtIR3jMquiWWdaYY/A7BveO5O
	twgk8pZ/icw6+3/Hr/SNazCtH78QpSjSeu+JeCEjoV/riE8I2A4SRbhM17QG3Z3Yio1gFbL7FtJ
	dhDIofeHAtXC/DCANPj6WXsHm1ociJlZfHgZ1U8VBK/pJek9ubzFNdvubZG8k564K4nuwW1wXRR
	uwawkII3eI2WIJLzQ0oaAhHuMb67ll3m/xz1XWw0ofnRc=
X-Google-Smtp-Source: AGHT+IGFO6zJzhif68HqhsZHjZDnz3M7neBTxhVtiBgpNDFxePU9rRHsSVcV7y5YBbYgJl/CdlpCuwSps4b6bQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:26d0:0:b0:dc2:3441:897f with SMTP id
 m199-20020a2526d0000000b00dc23441897fmr646708ybm.6.1705614682750; Thu, 18 Jan
 2024 13:51:22 -0800 (PST)
Date: Thu, 18 Jan 2024 21:51:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118215119.1040432-1-cmllamas@google.com>
Subject: [PATCH 5.10.y] binder: fix use-after-free in shinker's callback
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
(cherry picked from commit aaa8cde67eba56b3ebe8c2c155e896f9ccaa8bb7)
---
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


