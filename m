Return-Path: <stable+bounces-196697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F69C80B8E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1588D3A7F1F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83119F127;
	Mon, 24 Nov 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RS2sTdf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2C19CCF5
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990573; cv=none; b=uGqo4V18W1bxP++cOZsRGUjXZ4WD8KLKWAETHFlSjTK1ZBhIOCEoYzfzDDshBJoyuHQp1XN4RChpPRiAi5dlXNKtby+3YTDiRTZYA7TahVWZFPwQO4lSjM1yYkhRJXTJvru/5EWiXKKE1tlEZAVNBnEK+dgO2R3UVSILFNU2HT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990573; c=relaxed/simple;
	bh=CiRTXQwTs9oHjiJU2N3crHpP/blCtyETm7cGigcRjdE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hcENWgdM9e+WxfafLUWYnLClLqQ3Niniqqv8nck8xzBy4smoXHDT6Pg8UF69ZRBTF/MsxmnI0N9Gn7ZS3wItIMxUMaAL/xP77gC8Nz1AE4xielgkiHN+yRm4X9QvJ835fm7BZtVVRizMcnROuIkgD8wFnXAWbgPnSIAeEBHXfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RS2sTdf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABD1C19421;
	Mon, 24 Nov 2025 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990572;
	bh=CiRTXQwTs9oHjiJU2N3crHpP/blCtyETm7cGigcRjdE=;
	h=Subject:To:Cc:From:Date:From;
	b=RS2sTdf96yIHyODBd/kscLIJVsqEWuRT3dDsMW0rE+efg0ocaG58sQbJgNu8AC39f
	 5j0t5byDcon9PNNLVIAfaqoyFDgIsvQ5Zi0tGK1sjS39iKqGTmk6CmtN8YRjl522OV
	 8hQhRNVJ7NrMDY4o5Bci2KoEnDffr7VsNotcGirE=
Subject: FAILED: patch "[PATCH] mptcp: Fix proto fallback detection with BPF" failed to apply to 5.15-stable tree
To: jiayuan.chen@linux.dev,jakub@cloudflare.com,martin.lau@kernel.org,matttbe@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:22:50 +0100
Message-ID: <2025112449-untaxed-cola-39b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c77b3b79a92e3345aa1ee296180d1af4e7031f8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112449-untaxed-cola-39b4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


