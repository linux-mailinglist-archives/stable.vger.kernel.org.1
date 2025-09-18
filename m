Return-Path: <stable+bounces-179878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C68B7DFBB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77609189CC1F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1712E0B5B;
	Wed, 17 Sep 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipWMk3zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07C2C3261;
	Wed, 17 Sep 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112691; cv=none; b=hHAdxlP6vQ54p9YLAnlrwjtj16bJ+Ly9D2EeYGUe2yTNnUa77YFPKBnCgI7twvlzw0bV8o32nmabDgA2C1PCdA8scD3gAvxgDWArJl/OJaqB/1jcDDh9ejFS3J5SfaEEB5siu/kh0v3yy1OXdQAldF57KlQpibEz2zs54BtXiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112691; c=relaxed/simple;
	bh=tVvbSUHeXbATpNi+YJHbBZyE/BD2m1pv7M4TX0gpb+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLrV+q/B/jeW7qJ06ulmD+ZfAQacnWqYuQhf1Y9u6TYt5sQJWGjWiqy2zfFGBPv0EJ3JENreEgDDftRZ+zndKSIHbkVHRYNh6iodaRRAqCOqpkmI87eIrTPcQXVjRJTFlvJT94T2yfncQKzKOHrimKcbGQ9KUd/XkMv/uZ4FJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipWMk3zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECB6C4CEF0;
	Wed, 17 Sep 2025 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112690;
	bh=tVvbSUHeXbATpNi+YJHbBZyE/BD2m1pv7M4TX0gpb+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipWMk3zhHmruB7Kf1ul+jsYkfUyNKYB9Lns/ncsxvK8oGdoBVeY2ajOeT8QbN9zV4
	 0mTVCbqRcMw0of9Vjej4sgpLgA8FuBooUvr3K6DJhp/Ysg1sjb1A0n5EQhWZ3XAyK8
	 pCLFu7AtlD5ImR3ktBgN2or76VUExC2KUZtzqZp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 046/189] tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.
Date: Wed, 17 Sep 2025 14:32:36 +0200
Message-ID: <20250917123352.987047305@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit a3967baad4d533dc254c31e0d221e51c8d223d58 ]

syzbot reported the splat below. [0]

The repro does the following:

  1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_bytes)
  2. Attach the prog to a SOCKMAP
  3. Add a socket to the SOCKMAP
  4. Activate fault injection
  5. Send data less than cork_bytes

At 5., the data is carried over to the next sendmsg() as it is
smaller than the cork_bytes specified by bpf_msg_cork_bytes().

Then, tcp_bpf_send_verdict() tries to allocate psock->cork to hold
the data, but this fails silently due to fault injection + __GFP_NOWARN.

If the allocation fails, we need to revert the sk->sk_forward_alloc
change done by sk_msg_alloc().

Let's call sk_msg_free() when tcp_bpf_send_verdict fails to allocate
psock->cork.

The "*copied" also needs to be updated such that a proper error can
be returned to the caller, sendmsg. It fails to allocate psock->cork.
Nothing has been corked so far, so this patch simply sets "*copied"
to 0.

[0]:
WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156, CPU#1: syz-executor/5983
Modules linked in:
CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff ff e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e9 e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __sk_destruct+0x86/0x660 net/core/sock.c:2339
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68c0b6b5.050a0220.3c6139.0013.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250909232623.4151337-1-kuniyu@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4b..a268e1595b22a 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -408,8 +408,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (!psock->cork) {
 			psock->cork = kzalloc(sizeof(*psock->cork),
 					      GFP_ATOMIC | __GFP_NOWARN);
-			if (!psock->cork)
+			if (!psock->cork) {
+				sk_msg_free(sk, msg);
+				*copied = 0;
 				return -ENOMEM;
+			}
 		}
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
-- 
2.51.0




