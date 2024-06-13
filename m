Return-Path: <stable+bounces-50402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDD906514
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A60A288809
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371513BC0B;
	Thu, 13 Jun 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0wlAZpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B513BAF1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263821; cv=none; b=uV7WNKCwiTSHbe69+u4AhOXfK1RiF26GaxjQdEA45igfPSTv2AlLeuEK4KfIT8xot8Adp/mtkHZmUHFflTHYY3zzN04jdzrT1sODfWPZ4G7CyRqITe2rvWrwXTK60/RNuAvd3//LvMwVy0SwcRYPUTFE1Pkc0908Lh1LkEee6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263821; c=relaxed/simple;
	bh=c4uVhdB87hIx6Xpc85bzwU8n8m8nlwvhym7qRYeP0xs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k4YRVSsdSE28cnwTfnkZDTc9q0eGkH5TnASv3vGRsEGgjuMs+Xp7EPSOuX1aQddJySoM0t5ce/TzsK+bS/VUb0hv19y1isWEWQNoViVG9MLcS3+7zFh3lz6JL2ct8slBi2xg4eCLeCA6ttlKrZc9lblSmODIsH4uOX7iODyltOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0wlAZpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47CEC2BBFC;
	Thu, 13 Jun 2024 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718263821;
	bh=c4uVhdB87hIx6Xpc85bzwU8n8m8nlwvhym7qRYeP0xs=;
	h=Subject:To:Cc:From:Date:From;
	b=j0wlAZpRyEmaQXdjI2oLv2HMgR9F8YZ6X+kGQ60zlke7L5xfxh3G03Mg+n1JDfn1K
	 RAhspudmsyCWRezDbzt5T9V45A+44KFoGsCIlTWo3Mm5mj1Wcjnm0OETW/wZaCEyUv
	 7DbVuxsfUznPudi8yVC4Rs6Hu47WFw0Xce9yMraM=
Subject: FAILED: patch "[PATCH] io_uring: check for non-NULL file pointer in" failed to apply to 6.6-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:30:18 +0200
Message-ID: <2024061318-hypocrite-elude-31f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5fc16fa5f13b3c06fdb959ef262050bd810416a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061318-hypocrite-elude-31f3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

5fc16fa5f13b ("io_uring: check for non-NULL file pointer in io_file_can_poll()")
95041b93e90a ("io_uring: add io_file_can_poll() helper")
521223d7c229 ("io_uring/cancel: don't default to setting req->work.cancel_seq")
4bcb982cce74 ("io_uring: expand main struct io_kiocb flags to 64-bits")
595e52284d24 ("io_uring/poll: don't enable lazy wake for POLLEXCLUSIVE")
4de520f1fcef ("Merge tag 'io_uring-futex-2023-10-30' of git://git.kernel.dk/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fc16fa5f13b3c06fdb959ef262050bd810416a2 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 1 Jun 2024 12:25:35 -0600
Subject: [PATCH] io_uring: check for non-NULL file pointer in
 io_file_can_poll()

In earlier kernels, it was possible to trigger a NULL pointer
dereference off the forced async preparation path, if no file had
been assigned. The trace leading to that looks as follows:

BUG: kernel NULL pointer dereference, address: 00000000000000b0
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 67 PID: 1633 Comm: buf-ring-invali Not tainted 6.8.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 2/2/2022
RIP: 0010:io_buffer_select+0xc3/0x210
Code: 00 00 48 39 d1 0f 82 ae 00 00 00 48 81 4b 48 00 00 01 00 48 89 73 70 0f b7 50 0c 66 89 53 42 85 ed 0f 85 d2 00 00 00 48 8b 13 <48> 8b 92 b0 00 00 00 48 83 7a 40 00 0f 84 21 01 00 00 4c 8b 20 5b
RSP: 0018:ffffb7bec38c7d88 EFLAGS: 00010246
RAX: ffff97af2be61000 RBX: ffff97af234f1700 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffff97aecfb04820 RDI: ffff97af234f1700
RBP: 0000000000000000 R08: 0000000000200030 R09: 0000000000000020
R10: ffffb7bec38c7dc8 R11: 000000000000c000 R12: ffffb7bec38c7db8
R13: ffff97aecfb05800 R14: ffff97aecfb05800 R15: ffff97af2be5e000
FS:  00007f852f74b740(0000) GS:ffff97b1eeec0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000b0 CR3: 000000016deab005 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? __die+0x1f/0x60
 ? page_fault_oops+0x14d/0x420
 ? do_user_addr_fault+0x61/0x6a0
 ? exc_page_fault+0x6c/0x150
 ? asm_exc_page_fault+0x22/0x30
 ? io_buffer_select+0xc3/0x210
 __io_import_iovec+0xb5/0x120
 io_readv_prep_async+0x36/0x70
 io_queue_sqe_fallback+0x20/0x260
 io_submit_sqes+0x314/0x630
 __do_sys_io_uring_enter+0x339/0xbc0
 ? __do_sys_io_uring_register+0x11b/0xc50
 ? vm_mmap_pgoff+0xce/0x160
 do_syscall_64+0x5f/0x180
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x55e0a110a67e
Code: ba cc 00 00 00 45 31 c0 44 0f b6 92 d0 00 00 00 31 d2 41 b9 08 00 00 00 41 83 e2 01 41 c1 e2 04 41 09 c2 b8 aa 01 00 00 0f 05 <c3> 90 89 30 eb a9 0f 1f 40 00 48 8b 42 20 8b 00 a8 06 75 af 85 f6

because the request is marked forced ASYNC and has a bad file fd, and
hence takes the forced async prep path.

Current kernels with the request async prep cleaned up can no longer hit
this issue, but for ease of backporting, let's add this safety check in
here too as it really doesn't hurt. For both cases, this will inevitably
end with a CQE posted with -EBADF.

Cc: stable@vger.kernel.org
Fixes: a76c0b31eef5 ("io_uring: commit non-pollable provided mapped buffers upfront")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 624ca9076a50..726e6367af4d 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -433,7 +433,7 @@ static inline bool io_file_can_poll(struct io_kiocb *req)
 {
 	if (req->flags & REQ_F_CAN_POLL)
 		return true;
-	if (file_can_poll(req->file)) {
+	if (req->file && file_can_poll(req->file)) {
 		req->flags |= REQ_F_CAN_POLL;
 		return true;
 	}


