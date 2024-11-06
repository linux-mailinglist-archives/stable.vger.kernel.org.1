Return-Path: <stable+bounces-90054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C19BDDD5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C01C220BF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AD1190051;
	Wed,  6 Nov 2024 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSUT9os2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689D24B26
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865371; cv=none; b=N6AsFD8aS4XaiyRNtz85heQHggn3M1lGH2qtrnAnwp2VBmJL+LXNtNjjN49RN9HW6EDwWk9e+sRoOs+znVlv2s4ZxJ4smm+zhpIrcSrQALJY4KxBT/Sv2lBOeh99ArDOt9C+VaFHbkoYq+UUhdNXHk40CYq/XHln9brihq8Kpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865371; c=relaxed/simple;
	bh=F8r+BygRU5qpDjgjRXvX31OjTl82Uv4/GXkfikSHYVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OT/nipqnJ94lG56D3pAE3o/31h2RH8x5lh9qfX+yTohM2QTE4U93HsAoIpTomQQLiDKcNztD5SUfMqzQ/7qX6TFr74VR9RpUHuQCD6oSNaUrAoerfhNku8aZszM4epo8/FVDZfqWCJk8QLnrXY6O+fZk5p97R/8l5We9H+oIe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSUT9os2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72061bfec2dso5766825b3a.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 19:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730865369; x=1731470169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU3e/uJ2BSsFmgtw7/M65m0LmjDlW2QbF8AXZrGvQ8k=;
        b=WSUT9os2O61M6gUcDQjgnFv1HIwihfUuXEuaO8RPwtVWEt6MprI1JBgmm9XnjYrf1l
         U46wEgsMvrRvQpQJMoWS8DzROrLeIe7L7TArVz5ha9rd6lbCWfpYXfN6iBYyenSkc+sk
         wr/XajG/TU4AosnHlK+ZoHYE9ZX78dF9Tx0iNh5jnMtxu1ivWX5X4esZ7k06IZ0Fx96T
         zjfpPlFEJUoL0Rf4u33ErfYLqVdupFP1R0BjrYSGwA4m2bvZJZZG7/LaJubLPIqlMpKe
         i8F9HE0IgORhYVBkexxMjZNCrCzBiKn0gwsVG8kZqd2UZmZmIPlm+Pvp+JXgbJOkQ2iL
         fFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865369; x=1731470169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QU3e/uJ2BSsFmgtw7/M65m0LmjDlW2QbF8AXZrGvQ8k=;
        b=ZMIN1pw+FHFw6z1Hl1n//jRYtnCEM9jo5FchRiFDociSvBh6jrEj2rZF3MLUBp1NGb
         klk5Qxl2sUN3wUKwaDfGkpAW5AqlNkdZyED1L9Pqf9YKQVS8fSznzWtovveUPETOIpW/
         8/judQiZrUzdw17RkgLjM61PDndY1kRzykHYyTP8lWGh6aseQs4Yjr21wsJjzgdvMUfp
         zBd2o+KybEjQP7//HcHpJVe7MZH4s5f9t4ZEcqXc5oX+c0yWfWOAznxcs8vcYWFw8eI0
         vAewDOtxfjtUl3ZcC+kU/z0oNCPRCgySriMWa5M/gUa4G1jbL0datv4d4zhkbIOFTQjo
         5FFQ==
X-Gm-Message-State: AOJu0Yzm2G2pj5Rf+d+L8ArI1znTN6dsiiohWldFEPvIjzGYY2pEHV8b
	CfWBzWk29qttv4f29zsYd2e98YgK0Ar2u4BZv5I5PSKN0qHYy7o3chcs980H
X-Google-Smtp-Source: AGHT+IEB8HjzUeaoGM3y3czujc4NfWfhRkwp4GaPc1brmyOBQA8bka2cwhrRNBHauDijswo8Nzw8CA==
X-Received: by 2002:a05:6a00:88f:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-720c990b37amr23608288b3a.15.1730865368760;
        Tue, 05 Nov 2024 19:56:08 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b9fe7sm10837930b3a.18.2024.11.05.19.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 19:56:08 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot <syzkaller@googlegroups.com>,
	Hugh Dickins <hughd@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm: shmem: fix data-race in shmem_getattr()
Date: Wed,  6 Nov 2024 12:56:03 +0900
Message-Id: <20241106035603.17471-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024110550-excretory-dig-7bda@gregkh>
References: <2024110550-excretory-dig-7bda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d949d1d14fa281ace388b1de978e8f2cd52875cf upstream.

I got the following KCSAN report during syzbot testing:

==================================================================
BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current

write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
 inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
 inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
 shmem_mknod+0x117/0x180 mm/shmem.c:3443
 shmem_create+0x34/0x40 mm/shmem.c:3497
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0xdbc/0x1f00 fs/namei.c:3883
 do_filp_open+0xf7/0x200 fs/namei.c:3913
 do_sys_openat2+0xab/0x120 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1442
 x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
 inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
 inode_get_ctime include/linux/fs.h:1629 [inline]
 generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
 shmem_getattr+0x17b/0x200 mm/shmem.c:1157
 vfs_getattr_nosec fs/stat.c:166 [inline]
 vfs_getattr+0x19b/0x1e0 fs/stat.c:207
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x134/0x2f0 fs/stat.c:315
 vfs_fstatat+0xec/0x110 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
 x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x2755ae53 -> 0x27ee44d3

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================

When calling generic_fillattr(), if you don't hold read lock, data-race
will occur in inode member variables, which can cause unexpected
behavior.

Since there is no special protection when shmem_getattr() calls
generic_fillattr(), data-race occurs by functions such as shmem_unlink()
or shmem_mknod(). This can cause unexpected results, so commenting it out
is not enough.

Therefore, when calling generic_fillattr() from shmem_getattr(), it is
appropriate to protect the inode using inode_lock_shared() and
inode_unlock_shared() to prevent data-race.

Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index e173d83b4448..8239a0beb01c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1077,7 +1077,9 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
+	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
--

