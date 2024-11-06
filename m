Return-Path: <stable+bounces-90053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 119849BDDD1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982641F246A6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518118DF93;
	Wed,  6 Nov 2024 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNzGmS4a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0118DF73
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865182; cv=none; b=XYKjiKRO7FmaMz6kqfakJ6TwLVreaYqig4lyB/qZRuPpak6qSp41IblOIq2/+s8eNU7crnzvDGiLlxc5Gv1L+sM2UbkyDtk24y0pMMQ6vuL0ejMxluPuTNJj1pkOAyiSbPPb8HlDLgkGIyf75Orn/uvSEIEdcFH8bnfxkYdjIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865182; c=relaxed/simple;
	bh=BUtWdaHGWkCXqms7348XCgJNks980/IHM5CctS+scbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJ4OZynRElB2GqRCx5O9wE131/fjX23LM3uFysiEexeBveO4G8AP+jztISyDsOVFyyN8+CMylu3ZUA1FWndub8YHAVrjmZqH0VBSx+Z8PB26OFX8HFXv9uAXxW2Yp6/tgEN36ssLMNVy2rdigPDcYdK/3vqH1+BBiCFVGuWz9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNzGmS4a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so4475485a91.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 19:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730865179; x=1731469979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAJqsCMgiA9bj2W500JiJYbeSCH12GsBoQqMl0tiC84=;
        b=GNzGmS4a65sfENEqVl5N9CatuKUEhl7OEHJgHOGMw0GDSeZLbU7vFwbWKVFv96KjLQ
         m57h6Dnbh3XkLeZItNq7oIROLkwAklDnjZPolQA00x6SGcAVdbDNKz8LoDHdemOk2CIP
         vkYfqA+Qgqlix5H+lTSZs6SHhsHYgsrdz7lA3bWphhRqIycssLguKuIX4pqmIujdlIET
         +zphCpNUBGbt1NMkHlok+ezuiBvZvHYDUdUNuqie5+8p+V/Dqq9r1JYv1EArL2Tdvni1
         lXqiyfIvBA2qP6foCFQD0AcACmg6sHEAeyR8qHGqYm+3GeO7GbgTauPD1XxEbBVpMgiO
         ez0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865179; x=1731469979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAJqsCMgiA9bj2W500JiJYbeSCH12GsBoQqMl0tiC84=;
        b=lQHE827ZAqU3KpkLV9M8KK/1yTjt4//dWU3H6Grm1yz7cLzU+rmQpAkvjfOEl4zf0v
         Fi1WpNeLcgRABywyynNXjMhPL9KJQS2aJqFH2RmPbnwrVT6S/6qm+geqRwozDprN+5kw
         olO2KXVDQaDiTWRDKFGh6N3/qOisOmlwl4GYCHAcRzRfd0biLoyMXedQ307pK0/iTNEf
         YaPJRNofgaGKV41m4yArhOdeDI8H6UCGw8mDSRE4wUBN2jjZiMGw5r9THU5EwK6HScA7
         dVqjgsR+xK/OCoTYJtNxYqmsE2JsMOSRT0C2h0k4TJlyjz0HjA+xl8PU3fLuLhNQUD64
         P23Q==
X-Gm-Message-State: AOJu0Yw2MvHVYfyxQjiyiw9kyXEDISoQbFcm9BTJx98Ro8uBQcbk7OHe
	ojD0HgYnSDhAge3ONWyCFbsWw4u70J159hAD45CFKy0MDSemwwCg7aGFVbx5
X-Google-Smtp-Source: AGHT+IF5a2DHUYrNXBhzlAREoj0XQa4nO0yBf3K4HWs4XjAg1TF+SeOOxjH0hBhMP1NTGzCeciC+eg==
X-Received: by 2002:a17:90a:a58f:b0:2e3:171e:3b8c with SMTP id 98e67ed59e1d1-2e92cf2d074mr28266189a91.25.1730865179533;
        Tue, 05 Nov 2024 19:52:59 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e98af338c2sm2222266a91.0.2024.11.05.19.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 19:52:59 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot <syzkaller@googlegroups.com>,
	Hugh Dickins <hughd@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: shmem: fix data-race in shmem_getattr()
Date: Wed,  6 Nov 2024 12:52:53 +0900
Message-Id: <20241106035253.16956-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024110549-slate-undrilled-d94c@gregkh>
References: <2024110549-slate-undrilled-d94c@gregkh>
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
index 663fb117cd87..cdb169348ba9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1077,7 +1077,9 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
--

