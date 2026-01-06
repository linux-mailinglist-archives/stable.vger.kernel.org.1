Return-Path: <stable+bounces-206047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E588CFB52F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1C23024118
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3262550BA;
	Tue,  6 Jan 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzBBt49O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFE2EB5B8
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740874; cv=none; b=s3FMLDSidnWHCz2BWtaQ0VFNUAvCCp4NMcQDkut40DQ8bPlw33+RxYVJfYcgfo5klUGwl4crfimDN/BKaezR7i22b2SZo/HmVZJgEMp9vEGaFrW8T34qgo5P7+I3pmVEZCZ82CWagWJMjRcX7uT04L973z/DC1iBFSTgQb9+IWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740874; c=relaxed/simple;
	bh=X6ROx7DZgQ3EirxbdHfO3RZvzn1Ve7AqdH2c6cYquXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcF1qYtlQ0H0YjZ/ye6zgkNydT/12cmaY1NaJ0f2BNEstl7f3sCEw1pBGQCpk7r1MvQmVrO3UXdQVGJvWgBEFT7X/lIYgl6PlNKllGX0WZeBvKzXc5Lico3RvMWEgJ3+o8vo9CqGWQMhnuUnVBucSdaEkTYJFbaVfGfDsY1K/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzBBt49O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7802C19421;
	Tue,  6 Jan 2026 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767740874;
	bh=X6ROx7DZgQ3EirxbdHfO3RZvzn1Ve7AqdH2c6cYquXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzBBt49OMWzHOPU2q1ZcJWx4rMR0vMm5OWx/97xJp3A4txGO5jBxy8HC9oc4Hxcvk
	 hI/IxKGEU7WBp/nuA1Zucq/94M4GehMe3eSVKaJoY1szbbSP/19EIsU95Eyy2MWPiZ
	 ffQ9js49ZwKqszuSUguoglh5ZR6e2DjGmJXDHWyCuoVAkmlDUmbjRYw1ybclAgQ/AM
	 iitminNwmhuRKGYyAbUEL+796p0ZvZG2eh9srM8wCA/cD3QWuQtZab9gcJevH43lRP
	 wIg5BN3sJ4Vq6S2q1dyfb+uLaKt6dQJ4ffv2Bak6ojNzNsLUu8CxRg27E5rkCzkQv5
	 A3xvuVK+ewk0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: ensure context reset on disconnect()
Date: Tue,  6 Jan 2026 18:07:52 -0500
Message-ID: <20260106230752.3447994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010549-throwaway-structure-a291@gregkh>
References: <2026010549-throwaway-structure-a291@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 86730ac255b0497a272704de9a1df559f5d6602e ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 8 +++++---
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ed29132fd48e..37b50c6edf3b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2475,10 +2475,10 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
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
@@ -2530,7 +2530,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		release_sock(ssk);
 
 		goto out;
@@ -2839,6 +2839,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
+	msk->fastclosing = 1;
 
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
@@ -3356,6 +3357,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->fastclosing = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 73b842350677..c1c1bc19d61b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -316,7 +316,8 @@ struct mptcp_sock {
 			fastopening:1,
 			in_accept_queue:1,
 			free_first:1,
-			rcvspace_init:1;
+			rcvspace_init:1,
+			fastclosing:1;
 	u32		notsent_lowat;
 	int		keepalive_cnt;
 	int		keepalive_idle;
-- 
2.51.0


