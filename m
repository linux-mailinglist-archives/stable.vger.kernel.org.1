Return-Path: <stable+bounces-90052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DCD9BDDC5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D6AB21FBC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492541369B6;
	Wed,  6 Nov 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/8f6vBZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E1653
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864809; cv=none; b=l1Em1M79Z4K8me6llV0N0EnaA94IY4RQf6quZW3yj53lstRZUacF5H3Bqtu/yjdupCL9jyvRLhrd7e8l/9IoCXgoZzm8l3bZJxj+qUrtsuHSJeSXnRUr81q00e3vWzdU4OZQ8GZuR/QJb4HtxRqXKwOyAHpJeyY7evHjBSzU/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864809; c=relaxed/simple;
	bh=ewdA2fqPR4rvi62dHzfy/JFnu/ZMbbLj40MuNIaXW/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2PfKtMQ+J8KdCOjC7ELOMz8/PReqPfOdpnxiAHG0mgPZhMPW9i/DDO6PlXVlk/qrC13zOUkOCPELq0JDmVScy7HDghUnU8wLk3wAeZnB/hCjoMZuMby7/DO5VD3o34ZPmdAMithHNvZMS+ljyKTJ+UOlEUia9KpXseZ9u1U+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/8f6vBZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so4926583a91.3
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730864807; x=1731469607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz+awByteV4JLp4TU3lG3DQgEGpX/7EHC5w3Vl2SFYo=;
        b=X/8f6vBZiffgFVPNo2sU4CBhRY2kQtjwWZxK3ZyYU27fcpEr1yfD6k82p5jJkr6NEz
         g4PVcRHyKwK/KfN/gwfisvkS49Nd0havs9xQCmP/un6td28fZ0fxyt/C7CBHDTqb27S1
         ziSNNeKQMRPZXNr8bxzd2PioqsfhWgTbbNyV+4GwkeB3/7k7sXeE6JQ1C1UEUa0DWgEf
         aufJqZfngmcCvIcqiT+JBRu9JHmDbJBMNECkq2TFIjsWv9QVIAcYyQiLSro8HuHLRlzr
         TKjDXsD7hC19buMS6HJngEExW+uqjU1vTimFSlBa3utrjbLYxrweZkkyIGjWnX4N91lT
         D1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730864807; x=1731469607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz+awByteV4JLp4TU3lG3DQgEGpX/7EHC5w3Vl2SFYo=;
        b=QTqQrUt9Rd5c2uiTde2r7daRARnhtt8n7Bjindp67snq/uDV+smOE6eVWAKNkC0KK8
         YHt52ZcI9egT5lHrZCKm5v4Szy6sE03rhq8Iq3+Lo9YOiJPgJvj/27qROpNjpRcyDZy/
         H7XLfC1JzILkXK3+ei0UyDZg6sp9WpPKvphwprIM5taXRlo+aLou4+kjp3tQa983NPUf
         t6pnomnIAPrL1/mTi1oY8p+UQJ9XOM34p/MH4+Ut53277PrmtCWzJu/mW39axY3B4JFX
         UDuZHkou9JjYUN/wlENh/FLppiEyl2YsG/IScir1UWBohjb3uY6TCZaPMLV1AEWCGdvB
         rynw==
X-Gm-Message-State: AOJu0YzWPPYfeqIh1wB5qDOerdLjYApCkb2hq56tcHvKPncooeqJ3M6c
	aJ2BA3WdS83QEIQUsVUn/TSV7TCYXlyULs+kCDhc+VTVFaVa3HmbbEFI7Cys
X-Google-Smtp-Source: AGHT+IHhxnycBPikmZTmq75Z/JhbmppzMEtvPsv0mAyN1zWiTamBSFR4vDt8CmxuqmlI4qS7hMf04w==
X-Received: by 2002:a17:90a:ec12:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e8f10731c6mr40404555a91.21.1730864806760;
        Tue, 05 Nov 2024 19:46:46 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee412sm86908265ad.40.2024.11.05.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 19:46:46 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot <syzkaller@googlegroup.com>,
	Hugh Dickins <hughd@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: shmem: fix data-race in shmem_getattr()
Date: Wed,  6 Nov 2024 12:46:17 +0900
Message-Id: <20241106034617.16324-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024110547-snooper-saint-e58c@gregkh>
References: <2024110547-snooper-saint-e58c@gregkh>
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
Reported-by: syzbot <syzkaller@googlegroup.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index f7c08e169e42..0e1fbc53717d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1086,7 +1086,9 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
--

