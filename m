Return-Path: <stable+bounces-76862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0B97E23F
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DB51F211EA
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569EC8C0;
	Sun, 22 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw4zMfIl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380833C8;
	Sun, 22 Sep 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018242; cv=none; b=lvwtA0r4Nq5lVrsEu9GwvdPwS+JgoB38OPBLvn6wC7XcA3zpmAP2YKdiQbg/QLS62RuCwj+g/Bi1srvTalwloryPKHjcKi36MIw9rMriIPZQPk3eyU6TF9H5ke7SaNMh8G3wG3SX+VC6naTCygmT27JfbAIbb48m5uVbGI+ryps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018242; c=relaxed/simple;
	bh=QSgQcHKTsQqU2dL5yFThQ9AcmScauQffEc7sJWDlGZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ve6uQ0w7CeM84P01s2Q1rQCZLw45Q4IqrjA3jr+DbgGghhpTw//VqK+YwkjIfiYwbx/caVzRxo17YSCOVRKoFVtmMny2QqLoeXl88aCPBIlsf86aSE3PgNnh+cPS7queGqJplJAHouhjGVRfKZV2RVVotuTBeaU8Pm2J2Xb4hJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw4zMfIl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3179411b3a.0;
        Sun, 22 Sep 2024 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727018241; x=1727623041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg9rpCm4RXYexUUVsqyUtYoPeyurZbpl3+7GtcV4Rgo=;
        b=cw4zMfIlFMTMxyTcmZF9lWfloW3iFxDPty80EmdWyhNVQWBTw+ru9Jp3G4HhHJnIGw
         1+Oqs91meKuYzZ8xBlvc/OtEof24Lz1JB5e/r30ONFaCls12WPnqkz733+l1Nxrcei2Y
         nU7NCiyuc4psKjSGcSMKmlgUiRCNy5YWeAyaGgUWP/qmoW8KqPWLo6eMybW3G7kDopmp
         UW1oTCwkJf3gz/R2Cx+AYbgxzkoA+el9kFEAGxyyf9WD39kuiwvAipvTCoIfFv/NqxRO
         s082Nsh38NuBM/cz/nrMU17zlBrgvMcLpPXMC0yXSMcM3ZmsLPmEmmzXSc/sO65meAa1
         M9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727018241; x=1727623041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg9rpCm4RXYexUUVsqyUtYoPeyurZbpl3+7GtcV4Rgo=;
        b=uicFKRfgzKuRE3ebVVdukTR4XVwWnpjODa5mjsEEUDo/TXdluAcdJNmh+geftspCBN
         sjnwH46bXT8ZX59UZqEWo+bKRu/CFC946VCanQvZ8M+bY0YQQUtKBEIPPd5kLnjwQmJx
         dvqcc9ThYBBzV0mu6yVt/QC/INjoNV7AZxPgtyPBF5uj6Y2jtovW8dW+UyvXGL1rRSJl
         ktORMtSGLUArbY96tWIArwfKlFlqkjZmgretE6FtwC/u79K+Wmf/6iN1yuHDbc4VKu+2
         tjOuA5LICzF66oVAgyqDkFRkC4+hWuNyPm79lxLuE8ynisOtu2XQshJtGxae3oKS+rfL
         5Agw==
X-Forwarded-Encrypted: i=1; AJvYcCUMV8gkspK1nxJ3xlkTmHcTCLFzIO04emObwQ6KiR9ewnsnoaVbpbVyNxKipPAiAWFCm8AEQ3EK@vger.kernel.org, AJvYcCX3x9K9c1WzpK9MHi5WS5Xt3uGZgMCPLC3OkR/PlNnggFbMfCTK/EBFm5knyPZnoprywqdzKOG0V0y+WQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsPkTy8yqvmQp9GM0QcgsNYqVlJR1Rcq7YOJHnuWfM4p0c1cd
	IdAoiW2mLzSzVXbL16LW7gN3hTTwTbYc8kNW5WgCKs/SvEemadNE
X-Google-Smtp-Source: AGHT+IGXwmO/d3rlzE42aoJl6QCpT/8USlZLB1g/7Kyd3ZgVzZUzzBWo5L/ILlvxaPVb8SSLP0kNcw==
X-Received: by 2002:a05:6a20:8410:b0:1d3:1ce:3f2d with SMTP id adf61e73a8af0-1d301ce3fc0mr19178671637.20.1727018240499;
        Sun, 22 Sep 2024 08:17:20 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d98adsm14100178a12.7.2024.09.22.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:17:20 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	willy@infradead.org,
	david@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
Date: Mon, 23 Sep 2024 00:17:08 +0900
Message-Id: <20240922151708.33949-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found a report from syzbot [1]

When __folio_test_movable() is called in migrate_folio_unmap() to read
folio->mapping, a data race occurs because the folio is read without
protecting it with folio_lock.

This can cause unintended behavior because folio->mapping is initialized
to a NULL value. Therefore, I think it is appropriate to call
__folio_test_movable() under the protection of folio_lock to prevent
data-race.

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
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 923ea80ba744..e62dac12406b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1118,7 +1118,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
+	bool is_lru;
 	bool locked = false;
 	bool dst_locked = false;
 
@@ -1172,6 +1172,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	locked = true;
 	if (folio_test_mlocked(src))
 		old_page_state |= PAGE_WAS_MLOCKED;
+	is_lru = !__folio_test_movable(src);
 
 	if (folio_test_writeback(src)) {
 		/*
--

