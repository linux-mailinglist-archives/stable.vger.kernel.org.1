Return-Path: <stable+bounces-90055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476029BDDDB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ABD1C20BD0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13906190468;
	Wed,  6 Nov 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjCwqUb7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7224B26
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865539; cv=none; b=EoT10xwZz4L+oxxmmSG5sHOHtroWadjS/d1rv09rScUeeJTOKUDfWH8X2Z53b66+gcelwY7Ka3PUe3vk6bPtiJFh7yHPiB+yvojsmEPn4E7DRD9XG/hyBNZ6jswObVqhYXfPdJ8aPNURvJRdwYOGrNsNAAzFqZWSfSUkymyeekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865539; c=relaxed/simple;
	bh=Ozw/mrNKmago4Zv65zzkmzuy497ipcEMlOK0B/m55xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sm58XNjF5rQ4T3mglEl9RiH2f5y9PSoMQS2bpcLOYul3uKxSa0ufeZ55yik/o4Cir/8Z/1l+bOVbt3ok8ejiKCj+p6n1Yu5OzidhfLJLJ9iKB+krGNyvhX/MdBadTJmqSqXDH3S4Rqa6t+k4k2uX3aghLpqbfHWkjokHGgP6ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjCwqUb7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caccadbeeso67621895ad.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 19:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730865537; x=1731470337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDgkOa3EtcIe8niyN9x7RtDp1kdIlBblt1NjJfwUwaQ=;
        b=BjCwqUb7NpKCwOrh6HJpLHPFADFOTrhgLCupVhkUSwgURuj3bTh8vHSFvo0o3s2j5E
         zp84Ru9gxeNFAcbhqO2TD8wARBUGeX3ixpCr1w5ZO5lgLi9hTeJ3g2SsitF7eNb4Z1L7
         4bZC9FIUz4c1xTayTPve4I2QLqSUPs8wSgbTQs88A5y28/WsjIg8WwIqomcNzrf7E1dN
         MDe5yI/wGV3DEsdk4OtEUyccGo1kOt6m4TfQiW7jHqwnhVP2JLUc1DfBLmmUWekOFd7U
         yibu24Apbm43KOt/up1vdxZP5OCxvm2fRcNS6rUk8s9jvArS1X6eS16xeyjmjjtOsDXs
         7tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865537; x=1731470337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDgkOa3EtcIe8niyN9x7RtDp1kdIlBblt1NjJfwUwaQ=;
        b=G6dvdZn4bN+DvsP5wVMC9UDPHvUJ/e8+xCHOOZrXKCJMJFiSoW4f5FfbpH0jt+6Us0
         fiYth9oZjXCLVQepXrrmM54ipGNWvpeAgippFhSVGvd0DUwnga6BGEOp9MDInbvIfzJK
         Umwo+sYgcgX+xm4g5EDP2gbzKQLUvoKm3qlVhnJwv5oBwpI/tDm3PnVp3JyA5R8MoFW6
         anspyJa2wj3yISeIqVkXFcyw2iLGrRG1TV0f9h5//awNR9SaJ1gggs0QqUQ8uROOnVjW
         KsNcZ0KqfeSBmBUI0F785AihqaSP3zQfoe5dW0NBmQiJPgARln0I0A9od03F6BXp/ua7
         KagQ==
X-Gm-Message-State: AOJu0Yx9DfwvQoFuFJ/DcJjmTV474vOWlST36ccX82XZimO/MwRWLs1N
	OqZq6uXn3+RdzkzFewAzGbMA42AENSed20VCJXtvln6lOpMz6rT98pWCG1EO
X-Google-Smtp-Source: AGHT+IHrCO2s0GQ2qz28jUtNfT5S8ja6bLWfFCyV0hcYMqudMCJTR+SdT9O53EpmUQQR5dgLomfOZg==
X-Received: by 2002:a17:902:f542:b0:20c:e8df:251a with SMTP id d9443c01a7336-21103c77a4dmr301137535ad.45.1730865537101;
        Tue, 05 Nov 2024 19:58:57 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8141sm85734545ad.277.2024.11.05.19.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 19:58:56 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot <syzkaller@googlegroups.com>,
	Hugh Dickins <hughd@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] mm: shmem: fix data-race in shmem_getattr()
Date: Wed,  6 Nov 2024 12:58:51 +0900
Message-Id: <20241106035851.17863-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024110551-frosty-diploma-2492@gregkh>
References: <2024110551-frosty-diploma-2492@gregkh>
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
index 264229680ad7..6bd14e590e3c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1011,7 +1011,9 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
+	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
--

