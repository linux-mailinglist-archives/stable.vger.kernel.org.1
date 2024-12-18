Return-Path: <stable+bounces-105185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4C9F6B98
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B4E1890885
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B81F76C4;
	Wed, 18 Dec 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbtQonUD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94C1917F1
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540997; cv=none; b=USiWGMseOuFaMvXEtl0VdqOK145alHlULYw7kgkxbI/sJIrK8t6NEOMcVIjlYPbSPNOd2KsEdm6dwBgz26o5FTpdtfSy8Z06abcuxLFivvIjYSH+Fn1ovE47HY6L7v2g5LLjDXetqQgDTNC+j6OGJ2Bbl8L8mzMw0BIkFhmgmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540997; c=relaxed/simple;
	bh=MMQEj7LAqkGgvcG6MI8Z5DjGkXDNXgywSBSnTZ1Hw2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SgekuGgu0HQMYVgsPmrW5Nc+DonSmi5zDkaN2zCiQFRC5F5/+aJdmWn3KqljfhKFLNwG8tZuPw8g8YKb9z+AwoydGLptP+Bd7LD0Qp7//gaQ4W3JSyXqDWePM3xP0rGICKCSuUmbG6lqokXxe9LWDQORk9PWOIZlCvhMMkaRKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbtQonUD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361d5730caso59875e9.1
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 08:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734540994; x=1735145794; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ5voeoEGvFIlnkWTtVGdlj8CKOl5YBTaqd9AzIPNK8=;
        b=IbtQonUDVfNK5sOsZ+Zi2vrQZRt5Px+lnl+NdCykArSpZXE+AbdOpFldru3ZDcyadn
         PfTdM3dBd7SWosO4r5zwF8hcPKuRWjYMax1m/GrwTAYnm3kdYz0r2hW/FpMiuMlDrNBk
         kSfNuiZq+tSdDWPMPzJpdIkgHqkaIqFS1CdyhJYF/q94stJfzNu9H3ciy766u0OD+Vtx
         /FITLPjBvv3One4amVs4pnJD5OcnTG6GeyazCdXvmu91kECRm5KYTmE8DqYgnxQS9Rnu
         r46UXaOSoF9N8mQOdRvuaOeDKYqOPHOXEtti8YGD/dpuMLk+Qst/Klqh6etQOs2fyCgH
         e++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734540994; x=1735145794;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ5voeoEGvFIlnkWTtVGdlj8CKOl5YBTaqd9AzIPNK8=;
        b=BM0G/g033OIn9my8NhJmoXzw2nBwXujxcXG8gI2V+U+pa6s/jSEpdXvSgxRz67/SX0
         WJauRpCq70/J3s0GUY/TA2i/188/FK6nPogtVCxy9MP4cPJd4rgNqtV3FA+rukljeDNX
         Jrsq9zyOKeo6hy0nxzdv8+zkwcMTb1Ib4NTxh7XgWE/DLeYPeyQoHfT4dW4xomXSY+EA
         sTOFmWwGb7sMZSMg/IC7p0lqt1qIEoPUoZvCwkI9jPlgnZjiQ//5XF4KrLlHpEkN8nww
         uw3u1j595++SSVi1nNt5Ec0yM6WHzCK7CD+jvCB/dqHFBMnNeg3gfIozL6LaYJXR48lG
         USTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5JiAkik2jFvr2eYCGg9ox/JFnge9Xe3bgtBUsIBRcoI48iuVI/b3U+AbGny2XX9U0TAgkeEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8ZIIIXl/vn2IHG23vD7ZJHEPo4CCmvJN8IhGgEoG/vbkSToN
	8Mda/w6LuK7QKDfjwbj+zE+Dd20MFFB4/q+ceVBzIoaB31fmI49SHBPpjxYaOQ==
X-Gm-Gg: ASbGncvB7NJBoSdA04B7z76GELEzyIpo4aFQcifcwdtttfwj/JBs6jGWg9jU7vJ5lko
	msByXu4IRLTM0NFZtbiNTUNNVPh5LIGKr1gptJI8oS9fAceWWRcs3LiBRaPcddkCh2xYHrJ1TkW
	2P+Q/CR4YgfdliqcVN+vAun+zuZ3zRVdygGkNF88gQHMobjRRir2KtgcYJJi8Qa51oXepJNSDzv
	MD+rqth4vCaZsLKR9IT5yNC6IL+d+yn0iMOViddi/o=
X-Google-Smtp-Source: AGHT+IF3N05RjEQCj8gANjJelHtGo09ptmZGcgO6vIz0C3tgi4N57ksXoYFvu4L/kTUaof9juBi3zA==
X-Received: by 2002:a05:600c:4c97:b0:434:9fac:3408 with SMTP id 5b1f17b1804b1-436553f2cfdmr1449615e9.2.1734540993148;
        Wed, 18 Dec 2024 08:56:33 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:2ea4:1f:c82b:c76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80162b1sm14336097f8f.38.2024.12.18.08.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:56:32 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Wed, 18 Dec 2024 17:56:25 +0100
Subject: [PATCH] io_uring: Fix registered ring file refcount leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-uring-reg-ring-cleanup-v1-1-8f63e999045b@google.com>
X-B4-Tracking: v=1; b=H4sIALj+YmcC/x2MSwqAMAwFryJZWzC14ucq4qK0UQNSS4oiiHe3u
 hh4s3hzQyJhSjAUNwidnHgPWbAswK02LKTYZwddaYMaO3UIh0UJZb7hNrLhiAob79va1NgbC/k
 chWa+/vA4Pc8LfNFqYGgAAAA=
X-Change-ID: 20241218-uring-reg-ring-cleanup-15dd7343194a
To: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734540988; l=3962;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=MMQEj7LAqkGgvcG6MI8Z5DjGkXDNXgywSBSnTZ1Hw2o=;
 b=p0JbFNAOdCET2T9VN0wW0XHaTI88fETWFrtk8qqq4YrThql8d9t+tUQs+XQEOcPAAWiw262YK
 E35OYEkrSBDBnVd35h2PGpb4GAofl3HMlVqzgnkojnoOSKLFWkpmCOq
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, io_uring_unreg_ringfd() (which cleans up registered rings) is
only called on exit, but __io_uring_free (which frees the tctx in which the
registered ring pointers are stored) is also called on execve (via
begin_new_exec -> io_uring_task_cancel -> __io_uring_cancel ->
io_uring_cancel_generic -> __io_uring_free).

This means: A process going through execve while having registered rings
will leak references to the rings' `struct file`.

Fix it by zapping registered rings on execve(). This is implemented by
moving the io_uring_unreg_ringfd() from io_uring_files_cancel() into its
callee __io_uring_cancel(), which is called from io_uring_task_cancel() on
execve.

This could probably be exploited *on 32-bit kernels* by leaking 2^32
references to the same ring, because the file refcount is stored in a
pointer-sized field and get_file() doesn't have protection against
refcount overflow, just a WARN_ONCE(); but on 64-bit it should have no
impact beyond a memory leak.

Cc: stable@vger.kernel.org
Fixes: e7a6c00dc77a ("io_uring: add support for registering ring file descriptors")
Signed-off-by: Jann Horn <jannh@google.com>
---
testcase:
```
#define _GNU_SOURCE
#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/io_uring.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define NUM_SQ_PAGES 4

static int uring_fd;

int main(void) {
  int memfd_sq = SYSCHK(memfd_create("", 0));
  int memfd_cq = SYSCHK(memfd_create("", 0));
  SYSCHK(ftruncate(memfd_sq, NUM_SQ_PAGES * 0x1000));
  SYSCHK(ftruncate(memfd_cq, NUM_SQ_PAGES * 0x1000));

  // sq
  void *sq_data = SYSCHK(mmap(NULL, NUM_SQ_PAGES*0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, memfd_sq, 0));
  // cq
  void *cq_data = SYSCHK(mmap(NULL, NUM_SQ_PAGES*0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, memfd_cq, 0));
  *(volatile unsigned int *)(cq_data+4) = 64 * NUM_SQ_PAGES;

  close(memfd_sq);
  close(memfd_cq);

  // initialize uring
  struct io_uring_params params = {
    .flags = IORING_SETUP_REGISTERED_FD_ONLY|IORING_SETUP_NO_MMAP|IORING_SETUP_NO_SQARRAY,
    .sq_off = { .user_addr = (unsigned long)sq_data },
    .cq_off = { .user_addr = (unsigned long)cq_data }
  };
  uring_fd = SYSCHK(syscall(__NR_io_uring_setup, /*entries=*/10, &params));

  // re-execute
  execl("/proc/self/exe", NULL);
  err(1, "execve");
}
```

Leave it running for a while and monitor `grep ^filp /proc/slabinfo` and
memory usage - without the patch, both will go up slowly but steadily.
---
 include/linux/io_uring.h | 4 +---
 io_uring/io_uring.c      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index e123d5e17b526148054872ee513f665adea80eb6..85fe4e6b275c7de260ea9a8552b8e1c3e7f7e5ec 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -15,10 +15,8 @@ bool io_is_uring_fops(struct file *file);
 
 static inline void io_uring_files_cancel(void)
 {
-	if (current->io_uring) {
-		io_uring_unreg_ringfd();
+	if (current->io_uring)
 		__io_uring_cancel(false);
-	}
 }
 static inline void io_uring_task_cancel(void)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 06ff41484e29c6e7d8779bd7ff8317ebae003a8d..b1e888999cea137e043bf00372576861182857ac 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3214,6 +3214,7 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 
 void __io_uring_cancel(bool cancel_all)
 {
+	io_uring_unreg_ringfd();
 	io_uring_cancel_generic(cancel_all, NULL);
 }
 

---
base-commit: aef25be35d23ec768eed08bfcf7ca3cf9685bc28
change-id: 20241218-uring-reg-ring-cleanup-15dd7343194a

-- 
Jann Horn <jannh@google.com>


