Return-Path: <stable+bounces-204738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B8CF35A1
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D49D1302D5D5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D8315D3F;
	Mon,  5 Jan 2026 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmTvCuNC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5D314A78
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613751; cv=none; b=s9W+Zb+fN7q2lEAa4sKqyzkurNPnu0b70AnOSGneRqKEA7eZBwK50V03J2RVFZEkFJVvlL/1jzL7xXKK29dVzf1igUKfmp64Y9i5iM4EHYWZ8qaGB/XBw9uUrK6xub151LE53Yz0SBJ2fzCyFvm6RtYGYe3sHH5QSMmsyVEyDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613751; c=relaxed/simple;
	bh=HPXTBN1aodpsaSH6CkG8KoTEj1/i5HgehbnwBxIowSI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tzcm/6qrptiRZ5xXDChit0nsR+OeDtE1Kmq5iM0RFwW2uG9teqQ8Qc29al833xf6YbEUXUgCLkYlhCU5kNa+wgVhHJQyOJagdyFXjGLyhMXdElX6SLmGyjRnjPJ9gVxOUqfskkPdvX0KWAwQcS1pC/ZkcxIhcJgD0UGp2g9j8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmTvCuNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3204C116D0;
	Mon,  5 Jan 2026 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613746;
	bh=HPXTBN1aodpsaSH6CkG8KoTEj1/i5HgehbnwBxIowSI=;
	h=Subject:To:Cc:From:Date:From;
	b=qmTvCuNCZ3A1cgGSIA34IZBAXmuUp56RtnZBpWbajL6uuQn386bmZh+7rCGJ7wiIx
	 SJ6uf6U4cLeCrNgESyzkafDz7DAB5TIW5usi7zv7Yl371CBkdL96WNxE/Cj7ETWKs3
	 oHEkIHR3ldutOu4DImdGQ91/s2HvQXesKDiR+3vw=
Subject: FAILED: patch "[PATCH] mptcp: ensure context reset on disconnect()" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:48:50 +0100
Message-ID: <2026010550-dropbox-chewing-26be@gregkh>
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
git cherry-pick -x 86730ac255b0497a272704de9a1df559f5d6602e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010550-dropbox-chewing-26be@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86730ac255b0497a272704de9a1df559f5d6602e Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 12 Dec 2025 13:54:04 +0100
Subject: [PATCH] mptcp: ensure context reset on disconnect()

After the blamed commit below, if the MPC subflow is already in TCP_CLOSE
status or has fallback to TCP at mptcp_disconnect() time,
mptcp_do_fastclose() skips setting the `send_fastclose flag` and the later
__mptcp_close_ssk() does not reset anymore the related subflow context.

Any later connection will be created with both the `request_mptcp` flag
and the msk-level fallback status off (it is unconditionally cleared at
MPTCP disconnect time), leading to a warning in subflow_data_ready():

  WARNING: CPU: 26 PID: 8996 at net/mptcp/subflow.c:1519 subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
  Modules linked in:
  CPU: 26 UID: 0 PID: 8996 Comm: syz.22.39 Not tainted 6.18.0-rc7-05427-g11fc074f6c36 #1 PREEMPT(voluntary)
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  RIP: 0010:subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
  Code: 90 0f 0b 90 90 e9 04 fe ff ff e8 b7 1e f5 fe 89 ee bf 07 00 00 00 e8 db 19 f5 fe 83 fd 07 0f 84 35 ff ff ff e8 9d 1e f5 fe 90 <0f> 0b 90 e9 27 ff ff ff e8 8f 1e f5 fe 4c 89 e7 48 89 de e8 14 09
  RSP: 0018:ffffc9002646fb30 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: ffff88813b218000 RCX: ffffffff825c8435
  RDX: ffff8881300b3580 RSI: ffffffff825c8443 RDI: 0000000000000005
  RBP: 000000000000000b R08: ffffffff825c8435 R09: 000000000000000b
  R10: 0000000000000005 R11: 0000000000000007 R12: ffff888131ac0000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f88330af6c0(0000) GS:ffff888a93dd2000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f88330aefe8 CR3: 000000010ff59000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   tcp_data_ready (net/ipv4/tcp_input.c:5356)
   tcp_data_queue (net/ipv4/tcp_input.c:5445)
   tcp_rcv_state_process (net/ipv4/tcp_input.c:7165)
   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1955)
   __release_sock (include/net/sock.h:1158 (discriminator 6) net/core/sock.c:3180 (discriminator 6))
   release_sock (net/core/sock.c:3737)
   mptcp_sendmsg (net/mptcp/protocol.c:1763 net/mptcp/protocol.c:1857)
   inet_sendmsg (net/ipv4/af_inet.c:853 (discriminator 7))
   __sys_sendto (net/socket.c:727 (discriminator 15) net/socket.c:742 (discriminator 15) net/socket.c:2244 (discriminator 15))
   __x64_sys_sendto (net/socket.c:2247)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  RIP: 0033:0x7f883326702d

Address the issue setting an explicit `fastclosing` flag at fastclose
time, and checking such flag after mptcp_do_fastclose().

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251212-net-mptcp-subflow_data_ready-warn-v1-2-d1f9fd1c36c8@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9b1fafd87cb9..f505b780f713 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2467,10 +2467,10 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
  */
 static void __mptcp_subflow_disconnect(struct sock *ssk,
 				       struct mptcp_subflow_context *subflow,
-				       unsigned int flags)
+				       bool fastclosing)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    subflow->send_fastclose) {
+	    fastclosing) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2538,7 +2538,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		release_sock(ssk);
 
 		goto out;
@@ -2884,6 +2884,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 
 	mptcp_set_state(sk, TCP_CLOSE);
 	mptcp_backlog_purge(sk);
+	msk->fastclosing = 1;
 
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
@@ -3418,6 +3419,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->fastclosing = 0;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bed0c9aa28b6..66e973500791 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -320,7 +320,8 @@ struct mptcp_sock {
 			fastopening:1,
 			in_accept_queue:1,
 			free_first:1,
-			rcvspace_init:1;
+			rcvspace_init:1,
+			fastclosing:1;
 	u32		notsent_lowat;
 	int		keepalive_cnt;
 	int		keepalive_idle;


