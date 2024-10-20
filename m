Return-Path: <stable+bounces-86955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17949A534C
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA43281EAA
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6F12BF24;
	Sun, 20 Oct 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBzPdjhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E932BB13
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416564; cv=none; b=evVF2NryMadFa3mQtQ6xZV1ot/gvX05jyfUQbkG6GZfO191pOemYEDQOAMYipyMfyW8rDGS49cYUwNJYnrCdUQk+obaj1O/RPX1yh4x/NUlNZzxFR92MKtyiHZYfK2ilZT2bZ/eFybS772Vi1Qnt3gS2fzSseuiZNtO+2aeb/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416564; c=relaxed/simple;
	bh=epamzeSDTtY7PeUa4mmPf0HcCqnm/DvEkOt5Gw3Am5M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bcXySzw9qzoywGTWHvpljofo8pS6YGJrhQEQlbkVfK1/pndlUjE7ABnc6Dt8CBtbz7sPmNcd8iv0kwdJhYtmtlWJxF28xC+BsD1XiksZV7o/m1IjWDPd2OhZzmnZdzZ/Un0arDSwsZML6nD/ZsuTeAH3zxnavTX3e3T+MixoAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBzPdjhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D77C4CECD;
	Sun, 20 Oct 2024 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416563;
	bh=epamzeSDTtY7PeUa4mmPf0HcCqnm/DvEkOt5Gw3Am5M=;
	h=Subject:To:Cc:From:Date:From;
	b=HBzPdjhY36kyUDvnG513kqrF8ePIuaZ69sevgAPey4OANQwU3wCTfVE2S9Ab48PoX
	 AUUK64lo/gtJCr5NY396Odo/EF+UE6ONa7Ck2b5cac8Hp/eP2J0vJNHRLRGMwtasrE
	 FYsHEn3fB3YnhnCvg20qDbQwAgM+tdW/OwIubESE=
Subject: FAILED: patch "[PATCH] blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function" failed to apply to 4.19-stable tree
To: osandov@fb.com,axboe@kernel.dk,johannes.thumshirn@wdc.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:29:20 +0200
Message-ID: <2024102019-roundness-penholder-bb3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e972b08b91ef48488bae9789f03cfedb148667fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102019-roundness-penholder-bb3f@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e972b08b91ef48488bae9789f03cfedb148667fb Mon Sep 17 00:00:00 2001
From: Omar Sandoval <osandov@fb.com>
Date: Tue, 15 Oct 2024 10:59:46 -0700
Subject: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function
 race

We're seeing crashes from rq_qos_wake_function that look like this:

  BUG: unable to handle page fault for address: ffffafe180a40084
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 100000067 P4D 100000067 PUD 10027c067 PMD 10115d067 PTE 0
  Oops: Oops: 0002 [#1] PREEMPT SMP PTI
  CPU: 17 UID: 0 PID: 0 Comm: swapper/17 Not tainted 6.12.0-rc3-00013-geca631b8fe80 #11
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:_raw_spin_lock_irqsave+0x1d/0x40
  Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 62 97 30 4c 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 2c 0b 00
  RSP: 0018:ffffafe180580ca0 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: ffffafe180a3f7a8 RCX: 0000000000000011
  RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffafe180a40084
  RBP: 0000000000000000 R08: 00000000001e7240 R09: 0000000000000011
  R10: 0000000000000028 R11: 0000000000000888 R12: 0000000000000002
  R13: ffffafe180a40084 R14: 0000000000000000 R15: 0000000000000003
  FS:  0000000000000000(0000) GS:ffff9aaf1f280000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffafe180a40084 CR3: 000000010e428002 CR4: 0000000000770ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <IRQ>
   try_to_wake_up+0x5a/0x6a0
   rq_qos_wake_function+0x71/0x80
   __wake_up_common+0x75/0xa0
   __wake_up+0x36/0x60
   scale_up.part.0+0x50/0x110
   wb_timer_fn+0x227/0x450
   ...

So rq_qos_wake_function() calls wake_up_process(data->task), which calls
try_to_wake_up(), which faults in raw_spin_lock_irqsave(&p->pi_lock).

p comes from data->task, and data comes from the waitqueue entry, which
is stored on the waiter's stack in rq_qos_wait(). Analyzing the core
dump with drgn, I found that the waiter had already woken up and moved
on to a completely unrelated code path, clobbering what was previously
data->task. Meanwhile, the waker was passing the clobbered garbage in
data->task to wake_up_process(), leading to the crash.

What's happening is that in between rq_qos_wake_function() deleting the
waitqueue entry and calling wake_up_process(), rq_qos_wait() is finding
that it already got a token and returning. The race looks like this:

rq_qos_wait()                           rq_qos_wake_function()
==============================================================
prepare_to_wait_exclusive()
                                        data->got_token = true;
                                        list_del_init(&curr->entry);
if (data.got_token)
        break;
finish_wait(&rqw->wait, &data.wq);
  ^- returns immediately because
     list_empty_careful(&wq_entry->entry)
     is true
... return, go do something else ...
                                        wake_up_process(data->task)
                                          (NO LONGER VALID!)-^

Normally, finish_wait() is supposed to synchronize against the waker.
But, as noted above, it is returning immediately because the waitqueue
entry has already been removed from the waitqueue.

The bug is that rq_qos_wake_function() is accessing the waitqueue entry
AFTER deleting it. Note that autoremove_wake_function() wakes the waiter
and THEN deletes the waitqueue entry, which is the proper order.

Fix it by swapping the order. We also need to use
list_del_init_careful() to match the list_empty_careful() in
finish_wait().

Fixes: 38cfb5a45ee0 ("blk-wbt: improve waking of tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Sandoval <osandov@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 2cfb297d9a62..058f92c4f9d5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -219,8 +219,8 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 
 	data->got_token = true;
 	smp_wmb();
-	list_del_init(&curr->entry);
 	wake_up_process(data->task);
+	list_del_init_careful(&curr->entry);
 	return 1;
 }
 


