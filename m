Return-Path: <stable+bounces-196772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F5C81E15
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C3348815
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87B233149;
	Mon, 24 Nov 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otyv2CZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD45231829
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005069; cv=none; b=VElowrpbmucifACcgMQQD/Mv7xwWc70R2HYnYCNUbB7lV2FhYWixKcAKlmASk8a8B/TWreUEu5duzc6qGFQrxiNhN05bb1LjmxQ+2Z4/swIN0eYtfUooKkQsAq76q0z6hZ6mhDVS+tn53wtlhJfSExJTS1BS0zpLwj5yenhaaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005069; c=relaxed/simple;
	bh=tPkTnfZS7Hac+82FJ0OmB6lJ7pbjCvYwz8Sld7pxtrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JulK1kQzSu1Ain9uUKUX0oc1E+liCqPIzEuyAOCyyZDGVCbnMEOkTlX99/zty3divnoFOxWcAWk2aR64WgVEUPQvJHFyymRmhLjlVDdVbPu5I7RcZZI7S5X1U62VLelRB+nB07mYEDZpc1V4YaEK5BelOQDesQC+Qhj+KljssAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otyv2CZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC85C4CEF1;
	Mon, 24 Nov 2025 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764005068;
	bh=tPkTnfZS7Hac+82FJ0OmB6lJ7pbjCvYwz8Sld7pxtrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otyv2CZxMWZnCeAWgiF1chR6EJULysOJmuSJCLrM63V7LgDXfMZxLsz9VNPC1tpzK
	 ufhJW9GVpyertmjq6hY6R7aLK82JkM1XXS9k0GP3NzuMAfiYkyzOxnxiWS+df/YEHi
	 LmNjM5VokIB0yLEPsG2t6Jr1RD5TnTitSk5PPy0vYr1q06P70bl+2y9pbJGxJoaFbc
	 Hujx2rYqcBBhGI51zK9nG9HC2vbSxzVAUGBC4Jr7A/KrA3f2cfwSP/KRpIl7xTMyA8
	 Q7ddCnz/GX93jZiLB6FXpe4XgPlE2+o0OruofqsareVcMXrda4SnYNzWxYTckuZ85j
	 GpvPb6YCJj7Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: Fix proto fallback detection with BPF
Date: Mon, 24 Nov 2025 12:24:26 -0500
Message-ID: <20251124172426.4160679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112449-untaxed-cola-39b4@gregkh>
References: <2025112449-untaxed-cola-39b4@gregkh>
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
index 490fd8b188894..f758fde0565a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -77,8 +77,9 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	unsigned short family = READ_ONCE(sk->sk_family);
 
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
+	if (unlikely(family == AF_INET)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
 		 * not an mptcp one.
@@ -89,7 +90,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
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


