Return-Path: <stable+bounces-85808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1E99E93A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FA51C21E24
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084AD1EBA14;
	Tue, 15 Oct 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FKfIomWL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93EF1EABD1;
	Tue, 15 Oct 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994368; cv=none; b=pPqKeMoPvt4XCgo/4reRE9GJ8NqBO7FTNZRPsflg7Al8wQOYMWGxvcuQJIXY7EqnU5vn3pkenfgJ3yNrzw8eLHC2p3+uorXhkEdfIyHskXVChJI2JexBwNz4R0qIY8LfZbGAC8Q1UiPBdoCa6f1w4K3zkNyM/jFpv5R1600XkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994368; c=relaxed/simple;
	bh=CPox/CLV13moe3Q6CXiKy0hhGF7Z3mZ+1+NLxZ2hLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX+nVAOEC83IghZO366HFtd3PEWMVYWRd/RVNOSre4cfWqdP3WJgEj5sxo9C66VAWaUxI6MQBxHCyIq39DzSN/r1A55NQ2QQi3JQiEMtcastv5im3NMgkEzDyKIpGTHkGYqHx9kiQD4+/3nG17C3P8ka1fs8GcuK3L5cUopoE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FKfIomWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD4BC4CEC6;
	Tue, 15 Oct 2024 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994368;
	bh=CPox/CLV13moe3Q6CXiKy0hhGF7Z3mZ+1+NLxZ2hLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKfIomWLGoFyVlAs3k0on3oaE4/7eIrgQ/YH7DWF/JMLzJJo0ERBC3a6DSCc5A3Te
	 M4fdhSnxkm2ZctVvpC7AOSNJC3Px2fQk5awotH7GoUTCZuPcAP5BKRP+SOck4mppsp
	 UBB1PZwVO1sSjVWEhYgmQBngFBypbGWFQihKk8l0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frederic Weisbecker <frederic@kernel.org>,
	syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Hillf Danton <hdanton@sina.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 678/691] kthread: unpark only parked kthread
Date: Tue, 15 Oct 2024 13:30:26 +0200
Message-ID: <20241015112507.233176708@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit 214e01ad4ed7158cab66498810094fac5d09b218 upstream.

Calling into kthread unparking unconditionally is mostly harmless when
the kthread is already unparked. The wake up is then simply ignored
because the target is not in TASK_PARKED state.

However if the kthread is per CPU, the wake up is preceded by a call
to kthread_bind() which expects the task to be inactive and in
TASK_PARKED state, which obviously isn't the case if it is unparked.

As a result, calling kthread_stop() on an unparked per-cpu kthread
triggers such a warning:

	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525
	 <TASK>
	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
	 ops_exit_list net/core/net_namespace.c:178 [inline]
	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
	 process_one_work kernel/workqueue.c:3231 [inline]
	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
	 kthread+0x2f0/0x390 kernel/kthread.c:389
	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
	 </TASK>

Fix this with skipping unecessary unparking while stopping a kthread.

Link: https://lkml.kernel.org/r/20240913214634.12557-1-frederic@kernel.org
Fixes: 5c25b5ff89f0 ("workqueue: Tag bound workers with KTHREAD_IS_PER_CPU")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kthread.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -578,6 +578,8 @@ void kthread_unpark(struct task_struct *
 {
 	struct kthread *kthread = to_kthread(k);
 
+	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
+		return;
 	/*
 	 * Newly created kthread was parked when the CPU was offline.
 	 * The binding was lost and we need to set it again.



