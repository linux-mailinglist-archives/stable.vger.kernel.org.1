Return-Path: <stable+bounces-197662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5FC94B19
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 04:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BA345F62
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D575233D85;
	Sun, 30 Nov 2025 03:23:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A8189906
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764473006; cv=none; b=LJEqFVxQane9rdDsMM/iRYMhg0gAd28wX6eTX7/mFE5wZyDTOlcvpQRf5ozVr9n6VU7bUaSEh1B+UXGburHj5SgIA7TQFUsRFgZJp+k5SoCPCnrFTgj+uuEsgtq5RuFS5NPVn3y6kCTF0v+qHnnMEHq/eeH+6lrITebYKzfJwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764473006; c=relaxed/simple;
	bh=kd3WM7du0C6ez4kq47Lda47fdq2kXHgfWAlqm2mufdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLD5pZzMkh9Vez7hMQ5P850GatplRgLKkQqq5798e0CaB4bQAGxF4MWxkKAeS6epP1Os/7VN3DxQJo4dO2bPdokzjORzgZizs7nHTymeqPdFdpooDroZTlU1uTeerMOo2jsCp0H4EHQD3qXwH6/o+3q7ErWYWXIEnsw3ykeNYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 9C7FE8B2A3B; Sun, 30 Nov 2025 11:23:16 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org,
	mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1.y v1 2/2] net,mptcp: fix proto fallback detection with BPF
Date: Sun, 30 Nov 2025 11:23:03 +0800
Message-ID: <20251130032303.324510-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130032303.324510-1-jiayuan.chen@linux.dev>
References: <20251130032303.324510-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Additionally, this also prevents a PANIC from occurring:

result from ./scripts/decode_stacktrace.sh:
------------[ cut here ]------------

BUG: kernel NULL pointer dereference, address: 00000000000004bb
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 400 Comm: test_progs Not tainted 6.1.0+ #16
RIP: 0010:mptcp_stream_accept (./include/linux/list.h:88 net/mptcp/protocol.c:3719)

RSP: 0018:ffffc90000ef3cf0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880089dcc58
RDX: 0000000000000003 RSI: 0000002c000000b0 RDI: 0000000000000000
RBP: ffffc90000ef3d38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880089dc600
R13: ffff88800b859e00 R14: ffff88800638c680 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000004bb CR3: 000000000b8e8006 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
? apparmor_socket_accept (security/apparmor/lsm.c:966)
do_accept (net/socket.c:1856)
__sys_accept4 (net/socket.c:1897 net/socket.c:1927)
__x64_sys_accept (net/socket.c:1941)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)

Fixes: d2f77c53342e ("mptcp: check for plain TCP sock at accept time")
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1dbc62537259..13e3510e6c8f 100644
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
2.43.0


