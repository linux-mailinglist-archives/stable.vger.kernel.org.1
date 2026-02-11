Return-Path: <stable+bounces-215870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNnzAFTUjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D66127121
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F053090B2A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211526B2CE;
	Wed, 11 Feb 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdmjTZNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418B303A35;
	Wed, 11 Feb 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836820; cv=none; b=qokhCJoDE4TgwFT10/sZVbyl4/rkasuVj5AMIpDIhT4RmG16exSOtXAndgl6UJgCbfd/eHLrlUKqwVps0OpKs63FUq6niMWF9pUHM5UQ85xK4OfHdNsRggyqxNMnJUJXSsGd8qGWXk98pN7CGSAdHvOzUAgP5RMaTSQIQ6pvPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836820; c=relaxed/simple;
	bh=rMABZ5ULTsN0/8tg3HM626ypUOFeIMxiTKhtnZu4SKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxwWvYm4cHZaPYuVPpj1lyc6DLVHctQ81P07crvO2PklvhAtDNWeiE4h8MrFbXWTz+NndVcvenOUuBUAU9+KmHn6DEu6jUqY2Qw3g3A8qBoJ+0+R0uZF578evA8CzZec+A7xJ51Rtylf1rBbps02FwRBbpNsLQAIdg60Zb/I0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdmjTZNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC0C19423;
	Wed, 11 Feb 2026 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836819;
	bh=rMABZ5ULTsN0/8tg3HM626ypUOFeIMxiTKhtnZu4SKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdmjTZNvzZ15iJ9pcgo7W1JzsO4Xi8iyVSe0VFVQBUGJLOOLv+01Zv+wyjpl+p006
	 vPZImeO7gYAIs1BbYTP0j1t4LYtcsa0ew8ZfJQ64KFTj9vOnTfe4FSTSDrcUpEQO5C
	 OM6NMHWjSX6Bw1eMdItL/EhimX3dgZUiZzKXOMgczmMN/XMRDvcah2rox9FyO0sA1n
	 GrpDIrj3ohwPMITz6MEr/Koe7ls+noNFpvD2XBdqA2jIklEY7/8HSo2VEJuf4Z7RfU
	 uXwjC7JgryQJB9ZOBZSTbErO7GG546QFj/zsSk08RVJuUyuSccXG7Ir9KSBL4/4nU0
	 E0NthlffJB4Jw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 3/6] mptcp: ensure context reset on disconnect()
Date: Wed, 11 Feb 2026 20:06:21 +0100
Message-ID: <20260211190617.77192-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211190617.77192-8-matttbe@kernel.org>
References: <20260211190617.77192-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5474; i=matttbe@kernel.org; h=from:subject; bh=w+gVDIMZ7MyhCPB9jDcoWtrmZeRTY8/GXkykQ/ll+k8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7LusZ+7yU+/+55MaiN14N5w6Vn81j2tWcPHuaXNWG7 GeWSma8HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5Ls3IsG3FF1slpWn/Qntb phrnLz14TYLpYXip99F9533/PTZ/ksTI0H3bXyln8tQ7yjuOxEmd3Or8NqPP6oXl2d1CIUIaN1+ fYwQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215870-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 58D66127121
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

commit 86730ac255b0497a272704de9a1df559f5d6602e upstream.

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
[ Conflicts in protocol.[ch] because the context has changed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 ++++++---
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad0bfdd308be..5274b19a5dbd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2456,10 +2456,10 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
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
@@ -2511,7 +2511,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		if (msk->subflow && ssk == msk->subflow->sk)
 			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
@@ -2802,6 +2802,8 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	msk->fastclosing = 1;
+
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
 		return;
@@ -3290,6 +3292,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->fastclosing = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6575712c789e..dd5070d57d74 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -289,7 +289,8 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1,
-			free_first:1;
+			free_first:1,
+			fastclosing:1;
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
-- 
2.51.0


