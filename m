Return-Path: <stable+bounces-197905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C153C97126
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AD4E2149
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F526E719;
	Mon,  1 Dec 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSVvYYDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652E26657D;
	Mon,  1 Dec 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588909; cv=none; b=gWMrRyWnewxBQlF1Pn8QXFkzGdGIpm5lunRQlSPB8O/umh7Cu5T911QTbY0YdDtCkODTcFBQoSsnYTidagkAmMZE67pZxjLHJ+KdYbNdufVeEomCJBNKTXmYZPmdLS5ngFAb9AQZnnx651hfgOf1SMKuIRO8kSpL9CtKdsJND9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588909; c=relaxed/simple;
	bh=VqwYdTtpiD5/G8VqmN7tC+U7Rpt4TvBPToaNKdlwePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD046VQYkyqecIu/oY6hhKrjKNLwPAFxm/p+Oz3PqL0gMw9Dg0K3e921Rs7rnAQymozV7Ohj4jz3Fz5/30L5+jo+xe6h6dI2UDXm0WGCmjCMogSZ9AG86q52/PwVbABnXLW1wQA24Ot8cJYYU/NHtTqrSmxsev42KhS/62/2fkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSVvYYDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B92C4CEF1;
	Mon,  1 Dec 2025 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764588909;
	bh=VqwYdTtpiD5/G8VqmN7tC+U7Rpt4TvBPToaNKdlwePQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSVvYYDfroXwVQYiNIlvkrO56VYuR3ttsmAakoBjbrypdFCc1fCNGeIC2X3yGaU/N
	 6Fe+c4ZY+sRK+RzT/z6ftMMTI4c0n+9AuPIsHGgUM2huJ1/VXkJaNoOG2ma6Ja0Jps
	 nyf5UR0kwkTc0Y34fwmcgDDjnRcNfHAzANcuJZ6cKXDJsWcTczOigQ6I2O02zbBo7P
	 U+RvVAoXv6cYDZc4DJAOkiXcQPbZLiFZQF0tOkxx93Gi3AjVBB6azWvmhquoeZCptX
	 tjKRRDMC/Hc66pHOvB2g7UNwhjjXUhsAAOS2IEbKT0OCytLuOO/X7DHsSAIBxk4NF/
	 ejmi9Klu/KbTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.10.y] mptcp: Fix proto fallback detection with BPF
Date: Mon,  1 Dec 2025 12:34:58 +0100
Message-ID: <20251201113457.3641925-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112454-comic-external-4ced@gregkh>
References: <2025112454-comic-external-4ced@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3982; i=matttbe@kernel.org; h=from:subject; bh=tWlUAzgP2edVINQzQrOIyxKql5ok0E0A8hX+SlnZL7o=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ1a5O0T9huc+cSne/8tsbU67Vhu/iWi58WX5+asOOB2 pvIui2TOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyagbD/xQtzdScqg+t/Zsv x6RvPrA4ZOXOL/ecD5k2rDSv2G6iuZLhf0Zu+0Uf8axiu+pNj6/89/20qbQ9Q22++Gr1V+JKi+q 7uQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f upstream.

The sockmap feature allows bpf syscall from userspace, or based
on bpf sockops, replacing the sk_prot of sockets during protocol stack
processing with sockmap's custom read/write interfaces.
'''
tcp_rcv_state_process()
  syn_recv_sock()/subflow_syn_recv_sock()
    tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
      bpf_skops_established       <== sockops
        bpf_sock_map_update(sk)   <== call bpf helper
          tcp_bpf_update_proto()  <== update sk_prot
'''

When the server has MPTCP enabled but the client sends a TCP SYN
without MPTCP, subflow_syn_recv_sock() performs a fallback on the
subflow, replacing the subflow sk's sk_prot with the native sk_prot.
'''
subflow_syn_recv_sock()
  subflow_ulp_fallback()
    subflow_drop_ctx()
      mptcp_subflow_ops_undo_override()
'''

Then, this subflow can be normally used by sockmap, which replaces the
native sk_prot with sockmap's custom sk_prot. The issue occurs when the
user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
Here, it uses sk->sk_prot to compare with the native sk_prot, but this
is incorrect when sockmap is used, as we may incorrectly set
sk->sk_socket->ops.

This fix uses the more generic sk_family for the comparison instead.

Additionally, this also prevents a WARNING from occurring:

result from ./scripts/decode_stacktrace.sh:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
(net/mptcp/protocol.c:4005)
Modules linked in:
...

PKRU: 55555554
Call Trace:
<TASK>
do_accept (net/socket.c:1989)
__sys_accept4 (net/socket.c:2028 net/socket.c:2057)
__x64_sys_accept (net/socket.c:2067)
x64_sys_call (arch/x86/entry/syscall_64.c:41)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f87ac92b83d

---[ end trace 0000000000000000 ]---

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251111060307.194196-3-jiayuan.chen@linux.dev
[ Conflicts in protocol.c, because commit 8e2b8a9fa512 ("mptcp: don't
  overwrite sock_ops in mptcp_is_tcpsk()") is not in this version. It
  changes the logic on how and where the sock_ops is overridden in case
  of passive fallback. To fix this, mptcp_is_tcpsk() is modified to use
  the family, but first, a check of the protocol is required to continue
  returning 'false' in case of MPTCP socket. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0911ebe1f93a..70bc440c615d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -56,8 +56,13 @@ static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	unsigned short family;
 
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
+	if (likely(sk->sk_protocol == IPPROTO_MPTCP))
+		return false;
+
+	family = READ_ONCE(sk->sk_family);
+	if (unlikely(family == AF_INET)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
 		 * not an mptcp one.
@@ -68,7 +73,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
 		sock->ops = &inet_stream_ops;
 		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
+	} else if (unlikely(family == AF_INET6)) {
 		sock->ops = &inet6_stream_ops;
 		return true;
 #endif
-- 
2.51.0


