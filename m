Return-Path: <stable+bounces-196696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A2C80B67
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1776A4E425C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69317BEBF;
	Mon, 24 Nov 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKwS3mdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C316A395
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990569; cv=none; b=KUPYKv/MmG43e7S817QCM+P32OVfvcwEy3taPHEwY1LofGiPjOgu4PR8fcLSIsmzDuZcKZdwEA5QPOFlXLfp0ifTw8eVBiqN51+hPkmdiYcMyzmWEbCOA0TTEFAkNgy2kuNsguIDCgOQygjQ7tAOiWCr4HWem4qySxesVSEWXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990569; c=relaxed/simple;
	bh=4737uVsb58dhxWv9nLOnC0/R+ARhvPfa5/3k0nQCxNs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pRqBrUcfLRwuDMNRmCTajtHIX6YdbAjuVT3/dXxCL7D/wfBGsPKNDXUGFzOLRQjZ3C2aaDkygEBC4GSw5MzXI/fi2up/WZVJhIGCouEMEP3aIp6BQhdX9X/N6Ckp+ZVcxSp0UxbDTXyxMz+/V1JY+qXahrJALWORGCYS0Ccr9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKwS3mdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F49C116C6;
	Mon, 24 Nov 2025 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990567;
	bh=4737uVsb58dhxWv9nLOnC0/R+ARhvPfa5/3k0nQCxNs=;
	h=Subject:To:Cc:From:Date:From;
	b=VKwS3mdYg8Xg9H971PgSvBcc1wQfqNsC7v7n6h4QsROu+RZIchpayZLtcogV0Uk0f
	 PUTt2Z5qx4izPPfkx8b2jY0ui3xo4j0dictoYcdi7nzcaiQM1nTs6/sRJ1dNMpX8BU
	 FGDgj8lB9NtRhqmUR8vJ+gbTi0JMEPnW6m9Crf/g=
Subject: FAILED: patch "[PATCH] mptcp: Fix proto fallback detection with BPF" failed to apply to 6.1-stable tree
To: jiayuan.chen@linux.dev,jakub@cloudflare.com,martin.lau@kernel.org,matttbe@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:22:44 +0100
Message-ID: <2025112444-entangled-winking-ac86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c77b3b79a92e3345aa1ee296180d1af4e7031f8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112444-entangled-winking-ac86@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c77b3b79a92e3345aa1ee296180d1af4e7031f8f Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Tue, 11 Nov 2025 14:02:51 +0800
Subject: [PATCH] mptcp: Fix proto fallback detection with BPF

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d6b8de35c44..90b4aeca2596 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -61,11 +61,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
+	unsigned short family = READ_ONCE(sk->sk_family);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_prot == &tcpv6_prot)
+	if (family == AF_INET6)
 		return &inet6_stream_ops;
 #endif
-	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	WARN_ON_ONCE(family != AF_INET);
 	return &inet_stream_ops;
 }
 


