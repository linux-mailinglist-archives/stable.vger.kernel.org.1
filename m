Return-Path: <stable+bounces-196771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDCC81DD4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA297348241
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAFD1E51E1;
	Mon, 24 Nov 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRstjhsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF45188596
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004688; cv=none; b=J9i0qAlJfF6wEGSqEafU1vDpyKBIXzfaBHaXJaTqOYbRbwCo/Hu8s5Q+dJR1UNViPEqCUK750z6J6N3lzX3pw9vZFUUkDWvVyDEG0G3fN8VPVRoueSwjIgywGt4RYHOPeWzgyfct+0xIk2SsyLbQazB4uDogmjIqFJjBQYrrSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004688; c=relaxed/simple;
	bh=9m9TQsG9+Hk0oAvU5vJSsjOrOc7n1UeV4A/Pio4Ff1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJqXsb5rOfNxEximVSou603pySP6mCrgua+OvtwtUFdYHVcXDX1nGqFDd9ysso6A/ot7BdO+mQXZJL7IyGnvFCP1IvNHUlq7R00HuCfnigUMe9rWpyKWAaaV+OA7fshNN98JrUAoKjRTv/fq3z9ul6YJe+KgvhS3ZrnyT7uA+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRstjhsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C9C4CEF1;
	Mon, 24 Nov 2025 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004686;
	bh=9m9TQsG9+Hk0oAvU5vJSsjOrOc7n1UeV4A/Pio4Ff1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRstjhsg0t9O0XinRIvlT8OrwauSUSnCn/Su1vMihjTvQJB6Gvzzmlz7ONaCn17DQ
	 K9kRVmGs/QXNn0RyLMZTvGb3fg9PiYqxZAT3ehZ6Ty+Q7UBm8q+LIDqpQlnU6FrMwF
	 pzMIwp78k8kwOYqIFNtQkDG7XHxP5CcIDmq0q/2DBEOcYjCZjyFKeWE5O/dh5jADQg
	 uLTjssB7vD8LVumluDm+8lH5saYAYO3BsboqHYFwNq3hT05zZgxe7AHREyn7GK9jnL
	 mUj37DZl/kwJy49R3rhNFuGwHVosbe3e2JG1q15mbMGOfoKCAZS1q/pfcpqBtghrGg
	 e/C7fTpSpsNiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: Fix proto fallback detection with BPF
Date: Mon, 24 Nov 2025 12:18:02 -0500
Message-ID: <20251124171802.4158681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112444-entangled-winking-ac86@gregkh>
References: <2025112444-entangled-winking-ac86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f ]

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
[ applied fix to mptcp_is_tcpsk() instead of mptcp_fallback_tcp_ops() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea715a1282425..9d5981e5754b7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -79,8 +79,9 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	unsigned short family = READ_ONCE(sk->sk_family);
 
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
+	if (unlikely(family == AF_INET)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
 		 * not an mptcp one.
@@ -91,7 +92,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
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


