Return-Path: <stable+bounces-130873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F57A806D6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C87E8882E4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CD26B087;
	Tue,  8 Apr 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVoWzxCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B326A0B0;
	Tue,  8 Apr 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114883; cv=none; b=oPkg5rGACEg79xKh+LLSmx119qJZn8NBNLe6XXlJ6zIN46kW5p+hx/V84nX2U4iPCO0Zjj9ZJ2UqFkZAjyrqIQtjQrYMBYBh8djt0Vz8cOuwce0/h8Gbn+MR2lg+hKssnhuoHpLYzDQ7oFBIa9pBdEWphFlZzPF/OA7VsO6h/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114883; c=relaxed/simple;
	bh=et3+nStsflhIfJirlIFqXQi7wz6s5lWaqN+RnlP9rao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViNTTQCJLcb5dBih3p+VOLOhIJIPb9vGLaPAzBm290xrv372YwUlbj4U3uEe5aHoEy4z4Qfkkn/jS9mBryi4k6GhrxAR+l2gwR/ecQfaUon5sIVCJsCG85WcTAiKLowmf940mVoLS5Ddq0E9mfjvFNwkQ5F92DEfgZSKn0neJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVoWzxCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AA8C4CEE5;
	Tue,  8 Apr 2025 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114883;
	bh=et3+nStsflhIfJirlIFqXQi7wz6s5lWaqN+RnlP9rao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVoWzxCh97BMks48VB2yr10cgwKvStfo01zgJZ/5F1NFLIkPjjGiUZocgK0W/j4SN
	 BTUazlWAz5gGEqHVDIUvVaZAsN/vHNOj0G+JQsL+sSOwNCVjYeNMms3ZTQE0z2WZr1
	 djnRb6Nj9npX+7FW/vUtdxgacccbIjc6KGVh4F94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 253/499] um: remove copy_from_kernel_nofault_allowed
Date: Tue,  8 Apr 2025 12:47:45 +0200
Message-ID: <20250408104857.526061193@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 84a6fc378471fbeaf48f8604566a5a33a3d63c18 ]

There is no need to override the default version of this function
anymore as UML now has proper _nofault memory access functions.

Doing this also fixes the fact that the implementation was incorrect as
using mincore() will incorrectly flag pages as inaccessible if they were
swapped out by the host.

Fixes: f75b1b1bedfb ("um: Implement probe_kernel_read()")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20250210160926.420133-3-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/shared/os.h |  1 -
 arch/um/kernel/Makefile     |  2 +-
 arch/um/kernel/maccess.c    | 19 --------------
 arch/um/os-Linux/process.c  | 51 -------------------------------------
 4 files changed, 1 insertion(+), 72 deletions(-)
 delete mode 100644 arch/um/kernel/maccess.c

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5babad8c5f75e..bc02767f06397 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -213,7 +213,6 @@ extern int os_protect_memory(void *addr, unsigned long len,
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
-extern int os_mincore(void *addr, unsigned long len);
 
 void os_set_pdeathsig(void);
 
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index f8567b933ffaa..4df1cd0d20179 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -17,7 +17,7 @@ extra-y := vmlinux.lds
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
+	um_arch.o umid.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
diff --git a/arch/um/kernel/maccess.c b/arch/um/kernel/maccess.c
deleted file mode 100644
index 8ccd56813f684..0000000000000
--- a/arch/um/kernel/maccess.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013 Richard Weinberger <richrd@nod.at>
- */
-
-#include <linux/uaccess.h>
-#include <linux/kernel.h>
-#include <os.h>
-
-bool copy_from_kernel_nofault_allowed(const void *src, size_t size)
-{
-	void *psrc = (void *)rounddown((unsigned long)src, PAGE_SIZE);
-
-	if ((unsigned long)src < PAGE_SIZE || size <= 0)
-		return false;
-	if (os_mincore(psrc, size + src - psrc) <= 0)
-		return false;
-	return true;
-}
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 9f086f9394202..184566edeee99 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -142,57 +142,6 @@ int __init can_drop_memory(void)
 	return ok;
 }
 
-static int os_page_mincore(void *addr)
-{
-	char vec[2];
-	int ret;
-
-	ret = mincore(addr, UM_KERN_PAGE_SIZE, vec);
-	if (ret < 0) {
-		if (errno == ENOMEM || errno == EINVAL)
-			return 0;
-		else
-			return -errno;
-	}
-
-	return vec[0] & 1;
-}
-
-int os_mincore(void *addr, unsigned long len)
-{
-	char *vec;
-	int ret, i;
-
-	if (len <= UM_KERN_PAGE_SIZE)
-		return os_page_mincore(addr);
-
-	vec = calloc(1, (len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE);
-	if (!vec)
-		return -ENOMEM;
-
-	ret = mincore(addr, UM_KERN_PAGE_SIZE, vec);
-	if (ret < 0) {
-		if (errno == ENOMEM || errno == EINVAL)
-			ret = 0;
-		else
-			ret = -errno;
-
-		goto out;
-	}
-
-	for (i = 0; i < ((len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE); i++) {
-		if (!(vec[i] & 1)) {
-			ret = 0;
-			goto out;
-		}
-	}
-
-	ret = 1;
-out:
-	free(vec);
-	return ret;
-}
-
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV);
-- 
2.39.5




