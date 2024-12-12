Return-Path: <stable+bounces-102064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE029EF0B6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589A41898D6C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF2225A44;
	Thu, 12 Dec 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vARGfodC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24936225412;
	Thu, 12 Dec 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019832; cv=none; b=bko3zq6qi1PN8yZjtyvI+WMM7OssNx/aJz5jCYNvEZMNm9bfrMJSg9TQVmsHcwKC8FO+g8sUzp6znFkAEWa05dLrTd84EejOLsKdGo9IDd3XLwdJzTEGahzOBPoftxwx/tjWeyeoFBBwO2D9Qqvodo2BKngsER3GygFHIinjHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019832; c=relaxed/simple;
	bh=IfAh3poKpaSP0opTUnEN6ZIOD1rMsN6jVm0E02gv7xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxHIsfj0W72BcB5RUn3qWbNFEP5p0PMsKxOMCFVBNRpo89rEuVJKbAYiAGrBAWglnGD5OUJPR4G8bMKT+PrlFVMCxx7Tr+e/U59W1vxsDcgBvBEfxUPzU7aMreFS6Sv6HZNpucCseFq1DwkGSwuQXdYPABPCgIqMNZt+/ooQrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vARGfodC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F522C4CECE;
	Thu, 12 Dec 2024 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019832;
	bh=IfAh3poKpaSP0opTUnEN6ZIOD1rMsN6jVm0E02gv7xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vARGfodCc2gWyKxvenliQijZwdhK8SXi4dlU62eboilvlz5s06M4/8OKJSLKuFzB5
	 0b0QdATwNdI14JGTM2rplW4/Sc7EVrZHJoP2SNZrSoFoxzmLowGSfZ4RV2MYowecbp
	 UyIVQxYZZN0xE/cPDWBIkra/S2aFWaDaXQL3Rb5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	David Wei <dw@davidwei.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 309/772] s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()
Date: Thu, 12 Dec 2024 15:54:14 +0100
Message-ID: <20241212144402.668401559@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Sidraya Jayagond <sidraya@linux.ibm.com>

[ Upstream commit ebaf81317e42aa990ad20b113cfe3a7b20d4e937 ]

Passing MSG_PEEK flag to skb_recv_datagram() increments skb refcount
(skb->users) and iucv_sock_recvmsg() does not decrement skb refcount
at exit.
This results in skb memory leak in skb_queue_purge() and WARN_ON in
iucv_sock_destruct() during socket close. To fix this decrease
skb refcount by one if MSG_PEEK is set in order to prevent memory
leak and WARN_ON.

WARNING: CPU: 2 PID: 6292 at net/iucv/af_iucv.c:286 iucv_sock_destruct+0x144/0x1a0 [af_iucv]
CPU: 2 PID: 6292 Comm: afiucv_test_msg Kdump: loaded Tainted: G        W          6.10.0-rc7 #1
Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
Call Trace:
        [<001587c682c4aa98>] iucv_sock_destruct+0x148/0x1a0 [af_iucv]
        [<001587c682c4a9d0>] iucv_sock_destruct+0x80/0x1a0 [af_iucv]
        [<001587c704117a32>] __sk_destruct+0x52/0x550
        [<001587c704104a54>] __sock_release+0xa4/0x230
        [<001587c704104c0c>] sock_close+0x2c/0x40
        [<001587c702c5f5a8>] __fput+0x2e8/0x970
        [<001587c7024148c4>] task_work_run+0x1c4/0x2c0
        [<001587c7023b0716>] do_exit+0x996/0x1050
        [<001587c7023b13aa>] do_group_exit+0x13a/0x360
        [<001587c7023b1626>] __s390x_sys_exit_group+0x56/0x60
        [<001587c7022bccca>] do_syscall+0x27a/0x380
        [<001587c7049a6a0c>] __do_syscall+0x9c/0x160
        [<001587c7049ce8a8>] system_call+0x70/0x98
        Last Breaking-Event-Address:
        [<001587c682c4a9d4>] iucv_sock_destruct+0x84/0x1a0 [af_iucv]

Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: David Wei <dw@davidwei.uk>
Link: https://patch.msgid.link/20241119152219.3712168-1-wintera@linux.ibm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/af_iucv.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 815b1df0b2d19..0f660b1d3bd51 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1238,7 +1238,9 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		return -EOPNOTSUPP;
 
 	/* receive/dequeue next skb:
-	 * the function understands MSG_PEEK and, thus, does not dequeue skb */
+	 * the function understands MSG_PEEK and, thus, does not dequeue skb
+	 * only refcount is increased.
+	 */
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
@@ -1254,9 +1256,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	cskb = skb;
 	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
-		if (!(flags & MSG_PEEK))
-			skb_queue_head(&sk->sk_receive_queue, skb);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_out;
 	}
 
 	/* SOCK_SEQPACKET: set MSG_TRUNC if recv buf size is too small */
@@ -1273,11 +1274,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	err = put_cmsg(msg, SOL_IUCV, SCM_IUCV_TRGCLS,
 		       sizeof(IUCV_SKB_CB(skb)->class),
 		       (void *)&IUCV_SKB_CB(skb)->class);
-	if (err) {
-		if (!(flags & MSG_PEEK))
-			skb_queue_head(&sk->sk_receive_queue, skb);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
 	/* Mark read part of skb as used */
 	if (!(flags & MSG_PEEK)) {
@@ -1333,8 +1331,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	/* SOCK_SEQPACKET: return real length if MSG_TRUNC is set */
 	if (sk->sk_type == SOCK_SEQPACKET && (flags & MSG_TRUNC))
 		copied = rlen;
+	if (flags & MSG_PEEK)
+		skb_unref(skb);
 
 	return copied;
+
+err_out:
+	if (!(flags & MSG_PEEK))
+		skb_queue_head(&sk->sk_receive_queue, skb);
+	else
+		skb_unref(skb);
+
+	return err;
 }
 
 static inline __poll_t iucv_accept_poll(struct sock *parent)
-- 
2.43.0




