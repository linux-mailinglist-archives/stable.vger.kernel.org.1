Return-Path: <stable+bounces-198218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EA7C9F25F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B990A4E0F32
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648882FB610;
	Wed,  3 Dec 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBjy99MH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD12D7D59
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768886; cv=none; b=PoforOShPLHz9UoOr9/+SKbEC0PCEnLJe/e+XOwvs37V97P0f1Tgxb2N5TAv2VjHQCf1XKN7CmGjuTXXEpwY5xWqxibn3ItmGWj5fUlk8V7x6kdHKAxh6VLR9iSazxTk+axRE4dfhaYLajnkZZ7em8OiggPElQ6LsIXA4ieS3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768886; c=relaxed/simple;
	bh=8fP4yMJKo9j6jbwbXi5BWCaXNEREbApJe3CmuFrqztA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=boxUwMhkkh3mIvn1HnMKTCOKF3R8vX8C4dNXN9QW/nUYece3FPbbnneVBQQ6HPPpC+4XQ81Snl5bAdESSgMhlwULcUxISSGim7Ep/CF9Tttd2LUmBkMlJFTBXNM56JqoNslzf2RSOGuSSPx6/7rhYVNm2BriSKCOf/w4O5GmO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBjy99MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A4C4CEFB;
	Wed,  3 Dec 2025 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764768886;
	bh=8fP4yMJKo9j6jbwbXi5BWCaXNEREbApJe3CmuFrqztA=;
	h=Subject:To:Cc:From:Date:From;
	b=FBjy99MHlt7jN1XVnkTz8mb7+g9hqkkJi4UH52ZmHP6UJ8UeAiaKp95607SxRk3ST
	 /zwQbJC3ldwUMO4iXgSQbyxKGdRNFQHFsCmX635s8VJq6CHerVF/gi3dKcow9yeKpV
	 0161dJ5WPRsCYsYOlCPvDo8wchX+MlRg4+LUFr6E=
Subject: FAILED: patch "[PATCH] mptcp: Initialise rcv_mss before calling" failed to apply to 6.6-stable tree
To: kuniyu@google.com,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Dec 2025 14:34:34 +0100
Message-ID: <2025120334-preamble-cobalt-4ca0@gregkh>
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
git cherry-pick -x f07f4ea53e22429c84b20832fa098b5ecc0d4e35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120334-preamble-cobalt-4ca0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f07f4ea53e22429c84b20832fa098b5ecc0d4e35 Mon Sep 17 00:00:00 2001
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 19:53:29 +0000
Subject: [PATCH] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().

syzbot reported divide-by-zero in __tcp_select_window() by
MPTCP socket. [0]

We had a similar issue for the bare TCP and fixed in commit
499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
of 0").

Let's apply the same fix to mptcp_do_fastclose().

[0]:
Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c 41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
RSP: 0018:ffffc90003017640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcp_select_window net/ipv4/tcp_output.c:281 [inline]
 __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
 tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
 tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
 mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
 mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
 mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776
 mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe5/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66e998f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
 </TASK>

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69260882.a70a0220.d98e3.00b4.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251125195331.309558-1-kuniyu@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8abb425d8b5f..1e413426deee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2798,6 +2798,12 @@ static void mptcp_do_fastclose(struct sock *sk)
 			goto unlock;
 
 		subflow->send_fastclose = 1;
+
+		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
+		 * issue in __tcp_select_window(), see tcp_disconnect().
+		 */
+		inet_csk(ssk)->icsk_ack.rcv_mss = TCP_MIN_MSS;
+
 		tcp_send_active_reset(ssk, ssk->sk_allocation,
 				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 unlock:


