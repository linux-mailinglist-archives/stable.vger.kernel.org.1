Return-Path: <stable+bounces-156283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF13AE4EEC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9ECF3BEB9B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3121CA07;
	Mon, 23 Jun 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLe8Saio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE570838;
	Mon, 23 Jun 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713034; cv=none; b=TkvIvGU9nWDrPzzSWbzuiu+CI8vYAy0TwsjdZYRRB/Ho6M8CNGLnt8fI90pndGhmxU9aIcqngPc3YMwM1zy8Rrf3lcLH/XQDWHZV5doGGW/g16tJV5ocOrumGcsvM1Uv3AFSPrfq8qDx/vXk7hYf7K1pmoQHKeodW9u0Xbq7OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713034; c=relaxed/simple;
	bh=7MJYK6nR+STF7NhJhFBiImhH/xH+dtYFiLwfvklo6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0qVgoh/ZUej+B2zOwLylsVx7o1zVAsZQ0xN10w/SdBq4cYbCzMZy4LpK1EJFrMc/PNMgQMTyjoKT7x3Xg09FXXftT15jShvLTOk7yaNiMQzV+yU007FVZXYjH2HR/KFahsCrMHEkEy4wqJEYk51J/c43YYbbg1R4N27SedcJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLe8Saio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FC4C4CEEA;
	Mon, 23 Jun 2025 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713034;
	bh=7MJYK6nR+STF7NhJhFBiImhH/xH+dtYFiLwfvklo6BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLe8SaiorGnf83AgzN2/ZAJV7jtpbndzzdgZkxxrQeFVFDFpuK3TAgPx6ujFr6O64
	 d6EnOEI9eStprL3rhYut0kGkW7M1WQoMh0GMSk1ZL36FPUxevWU6orEtbVn2s3192r
	 B3/QkrPTBrsiCLipJOVDB5DgQYtytFVnTDlj6cFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/508] bpf, sockmap: Avoid using sk_socket after free when sending
Date: Mon, 23 Jun 2025 15:02:19 +0200
Message-ID: <20250623130647.571005433@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 8259eb0e06d8f64c700f5fbdb28a5c18e10de291 ]

The sk->sk_socket is not locked or referenced in backlog thread, and
during the call to skb_send_sock(), there is a race condition with
the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
will be affected.

Race conditions:
'''
CPU0                               CPU1

backlog::skb_send_sock
  sendmsg_unlocked
    sock_sendmsg
      sock_sendmsg_nosec
                                   close(fd):
                                     ...
                                     ops->release() -> sock_map_close()
                                     sk_socket->ops = NULL
                                     free(socket)
      sock->ops->sendmsg
            ^
            panic here
'''

The ref of psock become 0 after sock_map_close() executed.
'''
void sock_map_close()
{
    ...
    if (likely(psock)) {
    ...
    // !! here we remove psock and the ref of psock become 0
    sock_map_remove_links(sk, psock)
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        goto no_psock; <=== Control jumps here via goto
        ...
        cancel_delayed_work_sync(&psock->work); <=== not executed
        sk_psock_put(sk, psock);
        ...
}
'''

Based on the fact that we already wait for the workqueue to finish in
sock_map_close() if psock is held, we simply increase the psock
reference count to avoid race conditions.

With this patch, if the backlog thread is running, sock_map_close() will
wait for the backlog thread to complete and cancel all pending work.

If no backlog running, any pending work that hasn't started by then will
fail when invoked by sk_psock_get(), as the psock reference count have
been zeroed, and sk_psock_drop() will cancel all jobs via
cancel_delayed_work_sync().

In summary, we require synchronization to coordinate the backlog thread
and close() thread.

The panic I catched:
'''
Workqueue: events sk_psock_backlog
RIP: 0010:sock_sendmsg+0x21d/0x440
RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
...
Call Trace:
 <TASK>
 ? die_addr+0x40/0xa0
 ? exc_general_protection+0x14c/0x230
 ? asm_exc_general_protection+0x26/0x30
 ? sock_sendmsg+0x21d/0x440
 ? sock_sendmsg+0x3e0/0x440
 ? __pfx_sock_sendmsg+0x10/0x10
 __skb_send_sock+0x543/0xb70
 sk_psock_backlog+0x247/0xb80
...
'''

Fixes: 4b4647add7d3 ("sock_map: avoid race between sock_map_close and sk_psock_put")
Reported-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20250516141713.291150-1-jiayuan.chen@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0613f9a2543bb..e5ba57a5db126 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -654,6 +654,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* Increment the psock refcnt to synchronize with close(fd) path in
+	 * sock_map_close(), ensuring we wait for backlog thread completion
+	 * before sk_socket freed. If refcnt increment fails, it indicates
+	 * sock_map_close() completed with sk_socket potentially already freed.
+	 */
+	if (!sk_psock_get(psock->sk))
+		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
@@ -705,6 +712,7 @@ static void sk_psock_backlog(struct work_struct *work)
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
+	sk_psock_put(psock->sk, psock);
 }
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
-- 
2.39.5




