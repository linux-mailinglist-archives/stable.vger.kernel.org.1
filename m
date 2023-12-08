Return-Path: <stable+bounces-4964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E8809AAF
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 04:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5811C20A60
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029B46B4;
	Fri,  8 Dec 2023 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh1atVs7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD91706
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 19:49:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c668b87db3so1227274a12.3
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 19:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702007376; x=1702612176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYsH0w1DYVjoMg1s5Zd0ZREoiBGPi4xz58SN28eyFJM=;
        b=hh1atVs7cxz1Y91hFEXwVAZ85FTHEqAqUoiT+g7IwnBYNh2HT8ViiNPUNUSwDg5y39
         WRVLif5uGksQYQqSe6tP8ZP9pneW/jluOHs8hJ0TV52qyynBNTN/x5T8OoF1LxMhLkET
         DXVTi+VULu7ySMyZV4PEwsK7PjpyR1XA36GCn7nUgeJ2JE0/nBJqRMGNUzpPLi0MtAcd
         wp9uUeS9OgPV05ltCpXf51LwLRGs3z4cM0/bFno8mhb7d7A/CYbHgvniKX3S3UaUAFx3
         AIZ+TgOvUwJcqTHzxWW2fjxkv/PmGPtZh+d+6oVHbEsFB10qPovAukNW31wICQcpMXJ2
         QZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702007376; x=1702612176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYsH0w1DYVjoMg1s5Zd0ZREoiBGPi4xz58SN28eyFJM=;
        b=EC01/wGbY/Ek8xlufT8ciQfmNTgUyg1rGamgAUJZoToVgdkaUxzDUClUCF6U7X5Pa6
         F4x09teRR20BZap3Fo3K0WlmvQ/GNrIWtiYfYlC63bGKh9hfGtfNIhQdyLP+vMz8SMx4
         dT/ptVM+2zcO/KsGDmIADCYOPhcGUGowPh3l8cf+qerFBHKdVBMfPErz+gdY+wtdCF4F
         cFohtElTcSFedWr8Ofz61Iwz5ygBys0rktO/z9ktGacB/Vy6pF3IwBcp9oFr3ljB9jlZ
         dvIH8qia+C5WEA/huKhqbJ7cxUg5WCqA6GTaJ45OsEA+3pbtZKuOTu/GRxb7uc6Ok545
         eRTA==
X-Gm-Message-State: AOJu0YyEewVePzuqpqftRz3a4HfbqVXzRhQ34+GmZ8RHDm0qP0Q/+eQz
	YshDfOeXfWovCK0nP1+NPLdHkzXB/zBoUvaPb4xWEIa6Cih4OYvhMe3jAUkrj0ifyV7W9Cpfalg
	ktGbNGLsqmjESzzdw4+Dkl7HeFdOcJc+vP8cNIsgKMZ3PbAIL9vOa2HR9/9bpPuF0b/o=
X-Google-Smtp-Source: AGHT+IFbDBvgJh5PJ3vnU82/4AM4QabQ9Vn0Dy2n8bkc5X63hpe88fQ6rjsAymgBgRPm43la38uUZfQUG4uyIw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:644d:0:b0:5be:3925:b5b7 with SMTP id
 s13-20020a65644d000000b005be3925b5b7mr43640pgv.5.1702007375894; Thu, 07 Dec
 2023 19:49:35 -0800 (PST)
Date: Fri,  8 Dec 2023 03:49:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208034923.998315-1-cmllamas@google.com>
Subject: [PATCH 6.1] binder: fix memory leaks of spam and pending work
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, 
	syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com, 
	Alice Ryhl <aliceryhl@google.com>, Todd Kjos <tkjos@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit 1aa3aaf8953c84bad398adf6c3cabc9d6685bf7d upstream

A transaction complete work is allocated and queued for each
transaction. Under certain conditions the work->type might be marked as
BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT to notify userspace about
potential spamming threads or as BINDER_WORK_TRANSACTION_PENDING when
the target is currently frozen.

However, these work types are not being handled in binder_release_work()
so they will leak during a cleanup. This was reported by syzkaller with
the following kmemleak dump:

BUG: memory leak
unreferenced object 0xffff88810e2d6de0 (size 32):
  comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
  hex dump (first 32 bytes):
    e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/android/binder.c:3152
    [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/android/binder.c:4010
    [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder.c:5066 [inline]
    [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/binder.c:5352
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix the leaks by kfreeing these work types in binder_release_work() and
handle them as a BINDER_WORK_TRANSACTION_COMPLETE cleanup.

Cc: stable@vger.kernel.org
Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace when detected oneway spamming")
Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Link: https://lore.kernel.org/r/20230922175138.230331-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: backport to v6.1 by dropping BINDER_WORK_TRANSACTION_PENDING
 as commit 0567461a7a6e is not present. Remove fixes tag accordingly.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e4a6da81cd4b..9cc3a2b1b4fc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4788,6 +4788,7 @@ static void binder_release_work(struct binder_proc *proc,
 				"undelivered TRANSACTION_ERROR: %u\n",
 				e->cmd);
 		} break;
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
 				"undelivered TRANSACTION_COMPLETE\n");

base-commit: c6114c845984144944f1abc07c61de219367a4da
-- 
2.43.0.472.g3155946c3a-goog


