Return-Path: <stable+bounces-90056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399189BDDE1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 05:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FAB1C211EB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFF7FBA2;
	Wed,  6 Nov 2024 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUq+56rF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313A1362
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865777; cv=none; b=Xq4EwCQGFfPtQ/eYTChFBJQNEiNIrsoEyidBVp9ROruPNzeclCDGZivnsQcEpIZxUw5/o7p+I5g50rswA69P9yXqapWxBv1HYQZbhRBRkezVIoT28LHsYpb9NCAuCvFmyUxzCycZh7XEn2Wq/4dHPcqlhIT1urI7blSYl12p9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865777; c=relaxed/simple;
	bh=00npNCztoXcOAbvIhx5/B0c08cphAMItTsSM7JpCd4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwlotgcqBzgZURvDsvdT7snKsYTKDWSAS1mBn2DFNNsbHD5nviyUSqZJFEEzSUcDx3xqJRQSDi/0HVuyRB3bVh/pTPjHoLs0Xl6apw04eeojQoTrqjoRfxmSnhGolNAakGfVgFh0eA1ypqdJaI/OYCk9fFNloNC9ZF5XnJnbeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUq+56rF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4476310a12.0
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 20:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730865775; x=1731470575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLiGz1e+pgrfaNpcG4dllC+wxOkcOHMXSFDtk/J+Xsc=;
        b=EUq+56rFiFi1xIa/WDH2K5Ah2xocIrA9rrp+ZphQY87KAkoRPYIfazEQBYlunuE4qk
         Irou9FBkPiYhQB4ffb+DCKccHX5wMr7QjR2hWVo6+O6eqLfUh1/9NA5PraLnRaw+KTKH
         nIiPpnDnT9KiTFVa/ov6w/sZaRZBHHuRVyny8VxGwncdhhdGxnT6VLZtCoHNSxXKygOp
         qfcWh5hidzOPzLZjUXxiW9GSL7hxfbphYarnM6akF2Z/e6FCAC0KqSpdHjoEnsg8bh/C
         9d6ZyCaU4b1oIlNyI6UbbZBHDmcYPbPq0ewwQa377SABZ53M5yucwcFf2gCMwJbLPB90
         ah9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865775; x=1731470575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLiGz1e+pgrfaNpcG4dllC+wxOkcOHMXSFDtk/J+Xsc=;
        b=bsHUC1AP4JT+3YTmQZQKQHE/Ry2uVZgUaWEH08ZOkbAvrIsLpdyMoUtMkrQzS1QLmM
         yCJmRQpyaSFCCe6dqQFBjmjVUPG2qZBYfBtEbUUlaKVFSWvDSvQAM6k//EiKptnRqdfj
         sc1IToCr3LiJZHDnWCuEIesWX55BQbu7oHERLmMo+Tx/wqTKi4NSrVAC8L0wbZCkcxFL
         kNbaHOh/L7J8yRgfWjEGnWYzMrmDowybaYN29UBZxPwSCv7oCiUzlhUI7ayMMtj+WxPj
         0HQp/O1En4JEzi1UBSdDK3OoTOoWhtr8pagUxnQSmrm8EdcG+ntPqp0YpSV7Q0ODXMNE
         eGnw==
X-Gm-Message-State: AOJu0Ywp+otKEt9Z5VGVXxL6IItbp3NoVumsosr3ROHfP5DAZoZwsmJ9
	tfS2A7ppWiXdoGuFKGLemjVVcc3AxH9tIsxxOT/oY8fyEz2Ke5emqso36yK1
X-Google-Smtp-Source: AGHT+IGsc2ORGYAMCLRFrbqQBlUw8+LgOMY6UVnTPv5VveeZ+9FQ2JsnOMjesZfoHnEX2yyVOPTuQA==
X-Received: by 2002:a05:6a21:9983:b0:1db:a919:27ea with SMTP id adf61e73a8af0-1dba9193157mr24410721637.41.1730865774747;
        Tue, 05 Nov 2024 20:02:54 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc20f494sm10902845b3a.93.2024.11.05.20.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 20:02:54 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot <syzkaller@googlegroups.com>,
	Hugh Dickins <hughd@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19.y] mm: shmem: fix data-race in shmem_getattr()
Date: Wed,  6 Nov 2024 13:02:45 +0900
Message-Id: <20241106040245.18323-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024110553-blaming-ammonium-3ec5@gregkh>
References: <2024110553-blaming-ammonium-3ec5@gregkh>
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
index 0788616696dc..6e9027cb72ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1014,7 +1014,9 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
+	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
--

