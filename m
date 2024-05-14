Return-Path: <stable+bounces-44783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F68C5464
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30221C22C81
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B050278;
	Tue, 14 May 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pngpXdwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4947F5D;
	Tue, 14 May 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687164; cv=none; b=mVTCm4PevGgrq6KYiE6yWNHJZYoEWkUwKX4DnGfbm3rvYD0F/kBJ0ylAuKOWROPO40s0sGbaBsrbDua0BSJ/V5ErzkwbQPaDrOeyAAPR/sMp43cgkM4y9gJOLR0O2JIRKZVw72Rk9/jZhzOipidRdJITQu6Oa9zRxzBaMVCqh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687164; c=relaxed/simple;
	bh=LkMzixLOi+Iuw9gLnvVWaacxzyNlRoBgZmtVfRE59lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO7QsDqSDTXxqAMjCvQQOJV69nuMTsuFju2byGMMxIjjPGnaWVGEtk/0oCT9RL5EMQ+kwQcbm1UqwYEaEhd/5yTEQQAU/AwUjXjJxJKiqd+j9/jECRyLFwsOeUbfV7xtAIGu8Iiw6hEPH66GXqygYm16r+D1BZDz6mimRuMsEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pngpXdwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CDFC32786;
	Tue, 14 May 2024 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687164;
	bh=LkMzixLOi+Iuw9gLnvVWaacxzyNlRoBgZmtVfRE59lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pngpXdwDUFhCE2zuZ/TLnEdKitfRTwbGpcQSY9X8gQHi4LRH8g30RuSMzhaiDjYdE
	 3Fvx3rftYCA2+hIU2o3Mr0oscGsc5FyQX/xxyaqmEGPtxzVAQ0UKaMxxzjIr4V+5gA
	 VbYMzJIkNjKp/0xAmBKGtLNL92MI/GjfF/GxsXBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 66/84] Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
Date: Tue, 14 May 2024 12:20:17 +0200
Message-ID: <20240514100954.167186400@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit adf0398cee86643b8eacde95f17d073d022f782c ]

There is a race condition between l2cap_chan_timeout() and
l2cap_chan_del(). When we use l2cap_chan_del() to delete the
channel, the chan->conn will be set to null. But the conn could
be dereferenced again in the mutex_lock() of l2cap_chan_timeout().
As a result the null pointer dereference bug will happen. The
KASAN report triggered by POC is shown below:

[  472.074580] ==================================================================
[  472.075284] BUG: KASAN: null-ptr-deref in mutex_lock+0x68/0xc0
[  472.075308] Write of size 8 at addr 0000000000000158 by task kworker/0:0/7
[  472.075308]
[  472.075308] CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.9.0-rc5-00356-g78c0094a146b #36
[  472.075308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4
[  472.075308] Workqueue: events l2cap_chan_timeout
[  472.075308] Call Trace:
[  472.075308]  <TASK>
[  472.075308]  dump_stack_lvl+0x137/0x1a0
[  472.075308]  print_report+0x101/0x250
[  472.075308]  ? __virt_addr_valid+0x77/0x160
[  472.075308]  ? mutex_lock+0x68/0xc0
[  472.075308]  kasan_report+0x139/0x170
[  472.075308]  ? mutex_lock+0x68/0xc0
[  472.075308]  kasan_check_range+0x2c3/0x2e0
[  472.075308]  mutex_lock+0x68/0xc0
[  472.075308]  l2cap_chan_timeout+0x181/0x300
[  472.075308]  process_one_work+0x5d2/0xe00
[  472.075308]  worker_thread+0xe1d/0x1660
[  472.075308]  ? pr_cont_work+0x5e0/0x5e0
[  472.075308]  kthread+0x2b7/0x350
[  472.075308]  ? pr_cont_work+0x5e0/0x5e0
[  472.075308]  ? kthread_blkcg+0xd0/0xd0
[  472.075308]  ret_from_fork+0x4d/0x80
[  472.075308]  ? kthread_blkcg+0xd0/0xd0
[  472.075308]  ret_from_fork_asm+0x11/0x20
[  472.075308]  </TASK>
[  472.075308] ==================================================================
[  472.094860] Disabling lock debugging due to kernel taint
[  472.096136] BUG: kernel NULL pointer dereference, address: 0000000000000158
[  472.096136] #PF: supervisor write access in kernel mode
[  472.096136] #PF: error_code(0x0002) - not-present page
[  472.096136] PGD 0 P4D 0
[  472.096136] Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
[  472.096136] CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G    B              6.9.0-rc5-00356-g78c0094a146b #36
[  472.096136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4
[  472.096136] Workqueue: events l2cap_chan_timeout
[  472.096136] RIP: 0010:mutex_lock+0x88/0xc0
[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88
[  472.096136] RSP: 0018:ffff88800744fc78 EFLAGS: 00000246
[  472.096136] RAX: 0000000000000000 RBX: 1ffff11000e89f8f RCX: ffffffff8457c865
[  472.096136] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88800744fc78
[  472.096136] RBP: 0000000000000158 R08: ffff88800744fc7f R09: 1ffff11000e89f8f
[  472.096136] R10: dffffc0000000000 R11: ffffed1000e89f90 R12: dffffc0000000000
[  472.096136] R13: 0000000000000158 R14: ffff88800744fc78 R15: ffff888007405a00
[  472.096136] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
[  472.096136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  472.096136] CR2: 0000000000000158 CR3: 000000000da32000 CR4: 00000000000006f0
[  472.096136] Call Trace:
[  472.096136]  <TASK>
[  472.096136]  ? __die_body+0x8d/0xe0
[  472.096136]  ? page_fault_oops+0x6b8/0x9a0
[  472.096136]  ? kernelmode_fixup_or_oops+0x20c/0x2a0
[  472.096136]  ? do_user_addr_fault+0x1027/0x1340
[  472.096136]  ? _printk+0x7a/0xa0
[  472.096136]  ? mutex_lock+0x68/0xc0
[  472.096136]  ? add_taint+0x42/0xd0
[  472.096136]  ? exc_page_fault+0x6a/0x1b0
[  472.096136]  ? asm_exc_page_fault+0x26/0x30
[  472.096136]  ? mutex_lock+0x75/0xc0
[  472.096136]  ? mutex_lock+0x88/0xc0
[  472.096136]  ? mutex_lock+0x75/0xc0
[  472.096136]  l2cap_chan_timeout+0x181/0x300
[  472.096136]  process_one_work+0x5d2/0xe00
[  472.096136]  worker_thread+0xe1d/0x1660
[  472.096136]  ? pr_cont_work+0x5e0/0x5e0
[  472.096136]  kthread+0x2b7/0x350
[  472.096136]  ? pr_cont_work+0x5e0/0x5e0
[  472.096136]  ? kthread_blkcg+0xd0/0xd0
[  472.096136]  ret_from_fork+0x4d/0x80
[  472.096136]  ? kthread_blkcg+0xd0/0xd0
[  472.096136]  ret_from_fork_asm+0x11/0x20
[  472.096136]  </TASK>
[  472.096136] Modules linked in:
[  472.096136] CR2: 0000000000000158
[  472.096136] ---[ end trace 0000000000000000 ]---
[  472.096136] RIP: 0010:mutex_lock+0x88/0xc0
[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88
[  472.096136] RSP: 0018:ffff88800744fc78 EFLAGS: 00000246
[  472.096136] RAX: 0000000000000000 RBX: 1ffff11000e89f8f RCX: ffffffff8457c865
[  472.096136] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88800744fc78
[  472.096136] RBP: 0000000000000158 R08: ffff88800744fc7f R09: 1ffff11000e89f8f
[  472.132932] R10: dffffc0000000000 R11: ffffed1000e89f90 R12: dffffc0000000000
[  472.132932] R13: 0000000000000158 R14: ffff88800744fc78 R15: ffff888007405a00
[  472.132932] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
[  472.132932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  472.132932] CR2: 0000000000000158 CR3: 000000000da32000 CR4: 00000000000006f0
[  472.132932] Kernel panic - not syncing: Fatal exception
[  472.132932] Kernel Offset: disabled
[  472.132932] ---[ end Kernel panic - not syncing: Fatal exception ]---

Add a check to judge whether the conn is null in l2cap_chan_timeout()
in order to mitigate the bug.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9c06f5ffd1b5f..8709c4506343f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -434,6 +434,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	if (!conn)
+		return;
+
 	mutex_lock(&conn->chan_lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
-- 
2.43.0




