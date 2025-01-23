Return-Path: <stable+bounces-110320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90582A1A969
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E321169729
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9A1ADC9B;
	Thu, 23 Jan 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0dHP4O4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996171ADC91;
	Thu, 23 Jan 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655656; cv=none; b=DmVCs3eS1RGUM0nAXonzPBCieeu8t6C12Wfr59WMoKGgDrneD0yBQyvy5612V0SWuvjZd97sPV7ors6Mw4aVIFFviwWVGuoPsH7JmkLnq3wUq0psEP2njt0GKbHAW+liU2hzeRg9MSBDtoZ3GR3SfC1zwuK9JdJ/KeWaNmbCTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655656; c=relaxed/simple;
	bh=Dujc9SjNKabPLpXSHa8ntUQaYoZKKvksmo9oaZoC6Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNGQTjT77Q6k9qnqaeMkyiMK/pRMQ4ehEv5O37ok7fwvaAgxUsH/VRyO1IO/wyFtYUTf20VQKGKaZV2kH4z5WqekLXUbqibfPb8CrNgQkLPN/nwZApFsddpyjkaCjvwHJY49+MrQlA4mSZXEaoAbReREs5B1QwT/Oz3HMI3msho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0dHP4O4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63237C4AF0C;
	Thu, 23 Jan 2025 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737655656;
	bh=Dujc9SjNKabPLpXSHa8ntUQaYoZKKvksmo9oaZoC6Gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m0dHP4O4iykJnQMN/WRI4J0ZcGzGFUZNZR9Mbav1tU4rZIbx2RfLrNv2qAtDi5xNl
	 ZjbflytSqbIZHsCEVBaP1RWG9lQK5H4wXaevDvovxVa60AYtzUrceNddsOIb2WiUML
	 ifL9DtRutzSzBNIc8/yU0hAstHIdmNRQiZ2PYdeCDXSeEktz0RG1vfSVRevVzzFvJk
	 i8Dup6QdRWeRpk6kIjm5dFed9gDmjYK6MC67lDfSyVfe+TXI0iu4/WGsyAebOd8i2/
	 FJaUogRmQq9dyFdxCHk4B6YLlgnwHnBHYPk7FAW32NJf4VAIrcnZMUXQhlNmxiyvBo
	 NuVIAZJTcpwZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 23 Jan 2025 19:05:56 +0100
Subject: [PATCH net 3/3] mptcp: handle fastopen disconnect correctly
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-net-mptcp-syzbot-issues-v1-3-af73258a726f@kernel.org>
References: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
In-Reply-To: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4428; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S9jbuUp0DAVRF4aad/ku5eB15W0ks5b8jrDtRGmwV6o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkoVbQ09Q5sEHcj6HFHpDlC8R0yHhxl36mTET7
 dy+3zBA7TqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5KFWwAKCRD2t4JPQmmg
 c+jZEACFWp4B0CDTBMC9Mw9YeHkFDmzeMAZKMrZfEevktbx2/nqvszs398USMOj6APZ5BFZx1BS
 NKu9VzZRJctclWZ/iCwxuZbkldgj/QVIhxTR51bc1IEPA4XsM1DiwLtg5Y6va7wod4evhi1QYbr
 lAJPaKRzxn52zNkzuYvLDJjpiJmFQj+lhnehPlJI0w0T0TNAkQmxOyWZz/vnBX6sp49buBguNbX
 QW7U4f0+g1MBL15LLqowD6MOdUxAhxXMtd9VMo64nv79b1lxlAQJZsPMx12RaiHdMXqM3mw5nxA
 K0z9iQ59N9B5IXHlAPLXx1ieFtbChbd2me8JabGIssm631okDHMTFcCDiPQPeCTSPRSJc7dJqvz
 mfrt68m2+VZmr8QX59GBNYJoOQ+CPvrxwP31m5R7uBa2JZjh8JEoawQ5JaagKuPpPB0ZPhaWGFm
 ysubSqODMQ7ZbxQaH/OHC07sCs/8Vae3tPI7+rsvFDsOa6UFM5+ic2A4132SYXhM4d5JvG84FG7
 BQsIYn9m3IXcE9CPUkEjwlyOUzf+O1c5nhQkc54DYYiHdUHnwRV4z5n6UGmPwLqVYJmcHvBd6eH
 NRNDaNQ7Z+9BviJQHpwrBExwnXnLx2X5qQu/f1Ql/W04fiAEx9voUQF72Ojr02HLm02F9yt/QvD
 UC4NG+Yz/4Wt0VA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Syzbot was able to trigger a data stream corruption:

  WARNING: CPU: 0 PID: 9846 at net/mptcp/protocol.c:1024 __mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
  Modules linked in:
  CPU: 0 UID: 0 PID: 9846 Comm: syz-executor351 Not tainted 6.13.0-rc2-syzkaller-00059-g00a5acdbf398 #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
  RIP: 0010:__mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
  Code: fa ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 8e fa ff ff 48 8b 7c 24 18 e8 e0 db 54 f6 e9 7f fa ff ff e8 e6 80 ee f5 90 <0f> 0b 90 4c 8b 6c 24 40 4d 89 f4 e9 04 f5 ff ff 44 89 f1 80 e1 07
  RSP: 0018:ffffc9000c0cf400 EFLAGS: 00010293
  RAX: ffffffff8bb0dd5a RBX: ffff888033f5d230 RCX: ffff888059ce8000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000c0cf518 R08: ffffffff8bb0d1dd R09: 1ffff110170c8928
  R10: dffffc0000000000 R11: ffffed10170c8929 R12: 0000000000000000
  R13: ffff888033f5d220 R14: dffffc0000000000 R15: ffff8880592b8000
  FS:  00007f6e866496c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6e86f491a0 CR3: 00000000310e6000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   __mptcp_clean_una_wakeup+0x7f/0x2d0 net/mptcp/protocol.c:1074
   mptcp_release_cb+0x7cb/0xb30 net/mptcp/protocol.c:3493
   release_sock+0x1aa/0x1f0 net/core/sock.c:3640
   inet_wait_for_connect net/ipv4/af_inet.c:609 [inline]
   __inet_stream_connect+0x8bd/0xf30 net/ipv4/af_inet.c:703
   mptcp_sendmsg_fastopen+0x2a2/0x530 net/mptcp/protocol.c:1755
   mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1830
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x1a6/0x270 net/socket.c:726
   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
   ___sys_sendmsg net/socket.c:2637 [inline]
   __sys_sendmsg+0x269/0x350 net/socket.c:2669
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f6e86ebfe69
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f6e86649168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f6e86f491b8 RCX: 00007f6e86ebfe69
  RDX: 0000000030004001 RSI: 0000000020000080 RDI: 0000000000000003
  RBP: 00007f6e86f491b0 R08: 00007f6e866496c0 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e86f491bc
  R13: 000000000000006e R14: 00007ffe445d9420 R15: 00007ffe445d9508
   </TASK>

The root cause is the bad handling of disconnect() generated internally
by the MPTCP protocol in case of connect FASTOPEN errors.

Address the issue increasing the socket disconnect counter even on such
a case, to allow other threads waiting on the same socket lock to
properly error out.

Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
Cc: stable@vger.kernel.org
Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67605870.050a0220.37aaf.0137.GAE@google.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/537
Tested-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c44c89ecaca658bd2a2fdbfd72bfa2d33a8d95ea..6bd81904747066d8f2c1043dd81b372925f18cbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1767,8 +1767,10 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
 		 */
-		if (!mptcp_disconnect(sk, 0))
+		if (!mptcp_disconnect(sk, 0)) {
+			sk->sk_disconnects++;
 			sk->sk_socket->state = SS_UNCONNECTED;
+		}
 	}
 	inet_clear_bit(DEFER_CONNECT, sk);
 

-- 
2.47.1


