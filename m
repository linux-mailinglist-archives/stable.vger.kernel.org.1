Return-Path: <stable+bounces-4963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A8809AAE
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 04:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C3A1F2111D
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6246B4;
	Fri,  8 Dec 2023 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa8vce7M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D231706
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 19:48:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c627dd2accso923646a12.0
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 19:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702007337; x=1702612137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUpTvp9Jtnn0MWNwbTieSu+qWCm4XF1ER3oT458kAnI=;
        b=qa8vce7MOvyKPB8iBBe0Kpc3Sh5IPtKc3CsV/QkwrKqJnsvOTgWFrLUCTaExAmpor1
         PU8Zlenbc6RkIi6mq26uLn3GXWJIycpBYDNHsO72hMToIRu0TlzqE4K8DQd4uGU6xi3S
         K+Dff7eeugVp+nti1YjZ4gm9gOoou88CQ4/BskoToX98kykqz7nxxVojc/oKT4fEXn6/
         dw62z6WOEF4RP6V/cdJv7MiAW0Oi8hDCoNDrR7dctVUweGrkvV4FncxhhAgN+W++hnQY
         /MTRQYJ8HjBHBzORlhOGgzgZZaLWYRWUqBSUgavKdGdmxLdVU56XpsXX0EvvIBSiDnUM
         XWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702007337; x=1702612137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUpTvp9Jtnn0MWNwbTieSu+qWCm4XF1ER3oT458kAnI=;
        b=OKhUlzUjuCC41m3c0GLgMn/Kk+COvFEQkddtFoylXYLD3UaT8VZfH1hQYBuT/gZCcw
         yJKn5Is/sTEbZv/fivFXVLljvijcCrzdhInyAMnZW1difb46FVa9HX2YbYSe0bjyUKTZ
         WrVyb1V2pmJ+jPiaJVH2K18aaOM1cc9wAHyCL8dbbV8jeIQGDuTknIxnItaizUrnhIsf
         siveSB40kDLYxwwQmnIvEsqJodHBiXE7hEj+BrJfTl7T9bZJqYp5DMmDyeUrz/0iEySg
         CjtsaeSfz26Y9wvN9m9Bir6mSYIF8fUA1JZX0uJmNaZAh/UmiFwpBd9oa8nWAuIxmluM
         S9qQ==
X-Gm-Message-State: AOJu0Yzea5FyQEM7a85qyVKEuM5DaD+Z25ANMYlpdGsLlCuLfCVhzaa5
	YDSHY4uY9fwi/bPcSAI1hzPBRJMxyIaTLWl26Grug4tk06gUmqvso4v1hbMKJonTQjdZ0k7WlOa
	AUavtzfZVTG7Vh9f0maS6X5+plVpVzFMm0uWrxbV8ejgfkdA5N8B6JQyHbNFQvcnY0os=
X-Google-Smtp-Source: AGHT+IFy1wPsbJ8df74DvOqZzg+2JjsC5bqJDbBglrG6HOG2omadnRjrWvaCC9czgMMZpGWgG6qnAKfCoIGRiw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:1f02:0:b0:5c6:5eb2:bc6f with SMTP id
 f2-20020a631f02000000b005c65eb2bc6fmr38161pgf.11.1702007335468; Thu, 07 Dec
 2023 19:48:55 -0800 (PST)
Date: Fri,  8 Dec 2023 03:48:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208034842.997899-1-cmllamas@google.com>
Subject: [PATCH 5.15] binder: fix memory leaks of spam and pending work
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
[cmllamas: backport to v5.15 by dropping BINDER_WORK_TRANSACTION_PENDING
 as commit 0567461a7a6e is not present. Remove fixes tag accordingly.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cbbed43baf05..b63322e7e101 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4620,6 +4620,7 @@ static void binder_release_work(struct binder_proc *proc,
 				"undelivered TRANSACTION_ERROR: %u\n",
 				e->cmd);
 		} break;
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
 				"undelivered TRANSACTION_COMPLETE\n");

base-commit: 9b91d36ba301db86bbf9e783169f7f6abf2585d8
-- 
2.43.0.472.g3155946c3a-goog


