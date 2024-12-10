Return-Path: <stable+bounces-100382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD69EACA2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347571688B2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797D1DC996;
	Tue, 10 Dec 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQJ6zvf1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E841DC983
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823559; cv=none; b=ALtwywr3MrSIXkYBy/lCY/fBhAYksXm136xBaw9gg8+NU2DtQ6iHzk3nvo/zsm9PeBPT3uFHsYEUIAK72upBLkOnXxLA3KTzuluV5QF0BElwAHaPvTvOs/+KCNQVnMabO+kjTqxm/D5+uJ+PSkh+XS7KS6keJTk5il6ql6+W9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823559; c=relaxed/simple;
	bh=qMAxKzYVeTjGJdtq1TcMalAiIzymApGbpPvyyKbnZVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lFpm5kwq4NqdpfBwWFFvFrP4vp9V/VlIhhsL4udL7u1yULcdVAroyAy3bJHk1Z0/L105VWZi+nO0eSPt9ml9osm1OL1IAqw5qrT1lrm/9DhacJLaRKawqfm/7oFGvWgDjibXa7bF2P2qgZXbYeINygw/Uays6dgt21sd+hxC2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQJ6zvf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0271C4CED6;
	Tue, 10 Dec 2024 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823559;
	bh=qMAxKzYVeTjGJdtq1TcMalAiIzymApGbpPvyyKbnZVI=;
	h=Subject:To:Cc:From:Date:From;
	b=dQJ6zvf1/M3mIgLZLukCx5hWURjJRYzV8ZRLpklMPwH6P8olCr083hNytemiIhdAN
	 KuhOzXjWSIbZGprYJzbwam0qGzz3L/VjuUk7p8sVGuThngodOJnGnkXHcv2eRsoIzr
	 1CfYTLj7tugtD83NVI1H7N606v4UlBmZuVe+2AhE=
Subject: FAILED: patch "[PATCH] mm/mempolicy: fix migrate_to_node() assuming there is at" failed to apply to 5.15-stable tree
To: david@redhat.com,Liam.Howlett@Oracle.com,akpm@linux-foundation.org,cl@linux.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:38:33 +0100
Message-ID: <2024121033-xerox-resilient-8b1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 091c1dd2d4df6edd1beebe0e5863d4034ade9572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121033-xerox-resilient-8b1b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 091c1dd2d4df6edd1beebe0e5863d4034ade9572 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Nov 2024 21:11:51 +0100
Subject: [PATCH] mm/mempolicy: fix migrate_to_node() assuming there is at
 least one VMA in a MM

We currently assume that there is at least one VMA in a MM, which isn't
true.

So we might end up having find_vma() return NULL, to then de-reference
NULL.  So properly handle find_vma() returning NULL.

This fixes the report:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
Code: ...
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
 __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[akpm@linux-foundation.org: add unlikely()]
Link: https://lkml.kernel.org/r/20241120201151.9518-1-david@redhat.com
Fixes: 39743889aaf7 ("[PATCH] Swap Migration V5: sys_migrate_pages interface")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/673d2696.050a0220.3c9d61.012f.GAE@google.com/T/
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bb37cd1a51d8..04f35659717a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1080,6 +1080,10 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	mmap_read_lock(mm);
 	vma = find_vma(mm, 0);
+	if (unlikely(!vma)) {
+		mmap_read_unlock(mm);
+		return 0;
+	}
 
 	/*
 	 * This does not migrate the range, but isolates all pages that


