Return-Path: <stable+bounces-163901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67547B0DC36
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4679567601
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196C2EA49D;
	Tue, 22 Jul 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmjokI2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD02EA491;
	Tue, 22 Jul 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192581; cv=none; b=YiS+H4vLaAws8YrJEeUB1FgIYl2iilzfsL31u1h+Cu6ALdB/aa9UZu+w2mia98w+uvenhJdSBk1UzdyzohWY7RckAnTSnQPz7vA5bsRliDXeFXlD02ROUQwdy/Vk1ApIMouJOnh1vVBPvMjU4xlJ6x4sk8HEZRoe1b/kVFYPaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192581; c=relaxed/simple;
	bh=9FWxhZLjcMZ/kr+KAvjgynLm6ZupF1QRIK93rtFs5TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8iLt99EEjQgwOQpdwH9Io/ldCVxZO4k4uwV0w9kHypHH4cabISRVhjO+blpNS442L2nBdjG7ZwEmiXo8K4mGg+nfahSAqx9vW2f3VoyiCNk90NoPJ9axEAAWVXgMt+1jEaLHJqcRVJpzN/a0AKlFwS/7Dhgc1QWVPDCwUr0ygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmjokI2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D397C4CEEB;
	Tue, 22 Jul 2025 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192581;
	bh=9FWxhZLjcMZ/kr+KAvjgynLm6ZupF1QRIK93rtFs5TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmjokI2nrcO+cZztAXnyLAqFJG18EzCgKN+jEjts4RPBuOuWzJXfph6mvEepsGPsS
	 aYMZMYwj5C9WLyyDabDITnu7yFtZClkk44RIibH0xdPQYe957pJqGD/f5oIdlqksMq
	 z7P0a3++ydgFL6qPp/aGTZPcErFEjZloGCNXMKb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e4d73b165c3892852d22@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/111] Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
Date: Tue, 22 Jul 2025 15:44:51 +0200
Message-ID: <20250722134336.225751409@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit a0075accbf0d76c2dad1ad3993d2e944505d99a0 ]

syzbot reported null-ptr-deref in l2cap_sock_resume_cb(). [0]

l2cap_sock_resume_cb() has a similar problem that was fixed by commit
1bff51ea59a9 ("Bluetooth: fix use-after-free error in lock_sock_nested()").

Since both l2cap_sock_kill() and l2cap_sock_resume_cb() are executed
under l2cap_sock_resume_cb(), we can avoid the issue simply by checking
if chan->data is NULL.

Let's not access to the killed socket in l2cap_sock_resume_cb().

[0]:
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
Write of size 8 at addr 0000000000000570 by task kworker/u9:0/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:524
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

Fixes: d97c899bde33 ("Bluetooth: Introduce L2CAP channel callback for resuming")
Reported-by: syzbot+e4d73b165c3892852d22@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/686c12bd.a70a0220.29fe6c.0b13.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index aaaaf9733b589..9a906977c8723 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1687,6 +1687,9 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
-- 
2.39.5




