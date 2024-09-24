Return-Path: <stable+bounces-76993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECA984650
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284491C23088
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E115575C;
	Tue, 24 Sep 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+0DUvR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C91A7AE5;
	Tue, 24 Sep 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182872; cv=none; b=Nne8V4JIearulpwe3lXUoEb3uft1CRlqgXLVoGKrjMprd4sNU9E35T14UBK8bJ0YGwz2OA/G8YFwR3ZA4GcFoLGcq3QdPH/dY2TcPdOAtI0OU083S2Gh00/StYsAJxghUYIVh48VfhmOtdAKtVOO4u9py17Kp/dDM2Lf4hD4b/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182872; c=relaxed/simple;
	bh=AHph5tTw3pY4ut4EgOM4JWTBeqBUqeWrNT59219FqE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbC3KK9AGLiMsM2jiqIN3/cjLU3QRXjeh/WxwXqQKpcU5mBjawMwylHqKX/Xinp++hVaZr5i9XkPMI6XKWjfRGj5GxDVGrPjS2fql5BEG4e59y1tri3UQ8qn0UAT7V5+usPd7BKXhvKiNCVEkWqLMsBjI2PIJwaUErW1zFfCYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw+0DUvR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2055a3f80a4so34403665ad.2;
        Tue, 24 Sep 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182869; x=1727787669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOHx3jt17bRvX9omo0JNdSDeC4C6PZPInAKFhyka334=;
        b=Zw+0DUvRRRz6nFn/gWADH02a93XQLeXqLaLmajWSZmmOu5wV1hipdksw5aoznNjPSq
         74XBEHa8pMLHKVLMe2bNtq86tTGRYfAd7QSP2OeonRs89X+k7mNNoBsMAhCeUIP8Xa8h
         q0+DlsywDnaB0HZiHhDQysEUFzQtr2mF+sxBVh3MrT8tQ7N9+ee0qIISVzj+uaFlUtDF
         rKra3uIL8Hliar3jL6Mh8Btgf7us8aMOmZabElThorWyzXxTezUZtKJ5rIfpn0ULIo0Q
         Um0VpJSqnKgjzJLGtOXORheT7qum1yWoIa8YzERIEsAofHNNuiNKU9vZ5KzKllsTEUPj
         MRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182869; x=1727787669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOHx3jt17bRvX9omo0JNdSDeC4C6PZPInAKFhyka334=;
        b=la3mXLPlQBEcxUlYtt2lYHeTo5Rnc/37T8yoyCNSLHZJAm3pHYxMu66tknJMbivjRX
         dO3FjIYBEK4Z0DE/+KToM/xPr9Y6jK7eS2tNihVvaUb9/vnHKsaXUwPYs6c0GuVdp0Mg
         t/+gGzNfOnS59MCOngK7wqmbDYcu8yrPQ6Z7OxL9VyAZ5x8PY9MBuD++w4UKPkuBXKbb
         tCDkwzBhDWnwzYaBES0RntSNsLKPvEPSUBKp3PQVq1bo9gM/LmEIGv0m2+6ogB9y2zJw
         KmLlnHt5BhTZI8fA2nNIhP0f/DREn2x04RoPXpBRerywK7LjGiQpKDuRxjE9pJL2JqHQ
         3XXg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2IPa1Ny0Qa71VsopDO9DD5K3Ktn1cTslUF74qXVlwhmDkEdlEFXfEfELzJB6pUsFDc4zTFbqCcIBDKg=@vger.kernel.org, AJvYcCX6BVXYCu5Pkqk9cyjx1kPRSljypEV3VqIdD8hx8+5/CQx7x8OyqcItv8+PhJfHrk777cFOo/Sk@vger.kernel.org
X-Gm-Message-State: AOJu0YwPANZoCv/I8XThWkmIlrKPWbQm1yD/3Hd0SlcDmywFYSQnxQ00
	/+BAjTgd2qzxZvEp831T/H5F1MbxA3gULneCulStVfZ//VXncoxwHNRJegj/
X-Google-Smtp-Source: AGHT+IFi/yOofOOt9bF3sPPRxdrO5yL/oo6fP1unaQK+KC7RWRazovhiSEyZuzaNmKxTi8Xi8+MP/g==
X-Received: by 2002:a17:902:ea03:b0:205:4a1d:ba37 with SMTP id d9443c01a7336-208d986a5a7mr209150565ad.38.1727182868925;
        Tue, 24 Sep 2024 06:01:08 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1822c43sm9983085ad.193.2024.09.24.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:01:08 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com
Cc: wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: migrate: annotate data-race in migrate_folio_unmap()
Date: Tue, 24 Sep 2024 22:00:53 +0900
Message-Id: <20240924130053.107490-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found a report from syzbot [1]

This report shows that the value can be changed, but in reality, the 
value of __folio_set_movable() cannot be changed because it holds the 
folio refcount.

Therefore, it is appropriate to add an annotate to make KCSAN 
ignore that data-race.

[1]

==================================================================
BUG: KCSAN: data-race in __filemap_remove_folio / migrate_pages_batch

write to 0xffffea0004b81dd8 of 8 bytes by task 6348 on cpu 0:
 page_cache_delete mm/filemap.c:153 [inline]
 __filemap_remove_folio+0x1ac/0x2c0 mm/filemap.c:233
 filemap_remove_folio+0x6b/0x1f0 mm/filemap.c:265
 truncate_inode_folio+0x42/0x50 mm/truncate.c:178
 shmem_undo_range+0x25b/0xa70 mm/shmem.c:1028
 shmem_truncate_range mm/shmem.c:1144 [inline]
 shmem_evict_inode+0x14d/0x530 mm/shmem.c:1272
 evict+0x2f0/0x580 fs/inode.c:731
 iput_final fs/inode.c:1883 [inline]
 iput+0x42a/0x5b0 fs/inode.c:1909
 dentry_unlink_inode+0x24f/0x260 fs/dcache.c:412
 __dentry_kill+0x18b/0x4c0 fs/dcache.c:615
 dput+0x5c/0xd0 fs/dcache.c:857
 __fput+0x3fb/0x6d0 fs/file_table.c:439
 ____fput+0x1c/0x30 fs/file_table.c:459
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffea0004b81dd8 of 8 bytes by task 6342 on cpu 1:
 __folio_test_movable include/linux/page-flags.h:699 [inline]
 migrate_folio_unmap mm/migrate.c:1199 [inline]
 migrate_pages_batch+0x24c/0x1940 mm/migrate.c:1797
 migrate_pages_sync mm/migrate.c:1963 [inline]
 migrate_pages+0xff1/0x1820 mm/migrate.c:2072
 do_mbind mm/mempolicy.c:1390 [inline]
 kernel_mbind mm/mempolicy.c:1533 [inline]
 __do_sys_mbind mm/mempolicy.c:1607 [inline]
 __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
 x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888127601078 -> 0x0000000000000000

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: stable@vger.kernel.org
Fixes: 7e2a5e5ab217 ("mm: migrate: use __folio_test_movable()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 923ea80ba744..368ab3878fa6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1118,7 +1118,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
+	bool is_lru = data_race(!__folio_test_movable(src));
 	bool locked = false;
 	bool dst_locked = false;
 
--

