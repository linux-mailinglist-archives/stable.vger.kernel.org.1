Return-Path: <stable+bounces-63563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2B94198B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B401C236C8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763214EB2B;
	Tue, 30 Jul 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/O/6qi7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3600C8BE8;
	Tue, 30 Jul 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357229; cv=none; b=ralpnhiHYDbBZIOktNhETNf+crtq72RQS+SF5j7F+6MYRSdCLrsZMjRx7eCmT+GTBvgcRDTMZWqwQvuJqv9Hf/A1XNyGSrJ56x5B4AJ1HFXNemoCKAuVs6tsodz33SYE5jdnBJm+YVdL+lQ0oOYYm7RC6MD2i5pvaRAo8pv+agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357229; c=relaxed/simple;
	bh=0YzfOoLZDF779MmXZaN89Io1AckgrD/Msz7+8pqj8lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHnV2opIVxCQt3fx/TDoATR/lDKGEaOjlAt6Ud1YOxpupBK1sHMrQ8ugm2gxI6Wj8xYHzEF0nCIT6uctwTVcrbjkQ0UD0U58WpPk7p+cxQL7ydLpkofuJqeGMULEj9r3cC5+G3Eye8X7S2F5A9f/WhbNPNMkMuI7q/6AxLhj3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/O/6qi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB0C32782;
	Tue, 30 Jul 2024 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357229;
	bh=0YzfOoLZDF779MmXZaN89Io1AckgrD/Msz7+8pqj8lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/O/6qi7iTULSLjy88slh/kSNK7yqD7TZIlNQurJO2t3jAD1avTRKPpi6/U4dpF7U
	 uGKK1gwDoG6BAJgzBleMcjISE5Yx8OWESXSxRkz9cONIesYIeDmzZRMuLVzpfYcWIG
	 HgAKrXfKeAw5Y3UF8erdYEU7sk/4nMr88mfFwfqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 271/440] mm/hugetlb: fix possible recursive locking detected warning
Date: Tue, 30 Jul 2024 17:48:24 +0200
Message-ID: <20240730151626.420247242@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

From: Miaohe Lin <linmiaohe@huawei.com>

commit 667574e873b5f77a220b2a93329689f36fb56d5d upstream.

When tries to demote 1G hugetlb folios, a lockdep warning is observed:

============================================
WARNING: possible recursive locking detected
6.10.0-rc6-00452-ga4d0275fa660-dirty #79 Not tainted
--------------------------------------------
bash/710 is trying to acquire lock:
ffffffff8f0a7850 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0x244/0x460

but task is already holding lock:
ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&h->resize_lock);
  lock(&h->resize_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by bash/710:
 #0: ffff8f118439c3f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
 #1: ffff8f11893b9e88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
 #2: ffff8f1183dc4428 (kn->active#98){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
 #3: ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460

stack backtrace:
CPU: 3 PID: 710 Comm: bash Not tainted 6.10.0-rc6-00452-ga4d0275fa660-dirty #79
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xa0
 __lock_acquire+0x10f2/0x1ca0
 lock_acquire+0xbe/0x2d0
 __mutex_lock+0x6d/0x400
 demote_store+0x244/0x460
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xb9/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa61db14887
RSP: 002b:00007ffc56c48358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa61db14887
RDX: 0000000000000002 RSI: 000055a030050220 RDI: 0000000000000001
RBP: 000055a030050220 R08: 00007fa61dbd1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fa61dc1b780 R14: 00007fa61dc17600 R15: 00007fa61dc16a00
 </TASK>

Lockdep considers this an AA deadlock because the different resize_lock
mutexes reside in the same lockdep class, but this is a false positive.
Place them in distinct classes to avoid these warnings.

Link: https://lkml.kernel.org/r/20240712031314.2570452-1-linmiaohe@huawei.com
Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hugetlb.h |    1 +
 mm/hugetlb.c            |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -694,6 +694,7 @@ HPAGEFLAG(RawHwpUnreliable, raw_hwp_unre
 /* Defines one hugetlb page size */
 struct hstate {
 	struct mutex resize_lock;
+	struct lock_class_key resize_key;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4353,7 +4353,7 @@ void __init hugetlb_add_hstate(unsigned
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
-	mutex_init(&h->resize_lock);
+	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)



