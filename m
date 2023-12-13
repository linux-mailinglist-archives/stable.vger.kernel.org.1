Return-Path: <stable+bounces-6147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AD80D90D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6197C1C2160C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E751C2D;
	Mon, 11 Dec 2023 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uo4v/JQi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D655102A;
	Mon, 11 Dec 2023 18:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4C1C433C7;
	Mon, 11 Dec 2023 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320639;
	bh=mwg2usYcSWLqz8TbgE9dAxDWJkN/ruUtk1W06wUpSWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo4v/JQibac6UvEpCS3keSYy5Y2YY9e5rRIQw3WftX5mJT25PP4P/emmtkS8prwvF
	 J5VPPn4gl5j/zGO2Gy0uTkDXmvhYLaZLi0CccXi0x2yx4lUVfO5T9shHDEAzz2721i
	 k1ZbgpZpqqdIa6EvvxHB9GPjBaM3Ma2GxeVkpKYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Todd Kjos <tkjos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/194] binder: fix memory leaks of spam and pending work
Date: Mon, 11 Dec 2023 19:22:05 +0100
Message-ID: <20231211182042.630305137@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Llamas <cmllamas@google.com>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e4a6da81cd4b3..9cc3a2b1b4fc1 100644
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
-- 
2.42.0




