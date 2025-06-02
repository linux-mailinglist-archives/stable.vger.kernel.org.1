Return-Path: <stable+bounces-150588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF0ACB858
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA16F4C1FD6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778317BB6;
	Mon,  2 Jun 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wk6gD0qh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C132C327E;
	Mon,  2 Jun 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877598; cv=none; b=UNccKOhE4AM1+jql5RbgwSxgBjCXE/cLECqK5VYeoI7v3TCYV8GnRUmKSjQcc6v0qnkzHe6hsdV76Ds39nvupt3KoukTp182Cl0v6qHyR9Ct1fMeQB1hD9kwlchBXHPyt5fZkTxSuZnkn1NeqruHk3ED16ybaYIbCxlmV20TFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877598; c=relaxed/simple;
	bh=SClDh4C81VioiLpi0Tfca+okqusZwfTqP6ENjjHad3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h86joDc5OtffSHUcly/TD4AH4xsqzS7pblNKJ7QWiUcYiOzha2pmp54VKrKhivGSrjqala4eHN++1WoYKZxbSOrGuzkZ7MmbHugYAGA8MTQoKzPr6idrnJYdk8bMBjGIDMxeWTmtuafLIRcHBTdJ0X4siHBCiYP8dP0G5TEzHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wk6gD0qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C04C4CEEB;
	Mon,  2 Jun 2025 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877598;
	bh=SClDh4C81VioiLpi0Tfca+okqusZwfTqP6ENjjHad3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wk6gD0qhpnHf5KLNnXRPP0fc5e2wChVf3HrpVwJYGooIJ0bQNy8JIv7mqfjp2hX40
	 f+NqODqDCcMS/XhVoGf3++0iUETt6TWPjFoDPLLA1hy4RbZ5fdmiXj2ukwF2XDeaZe
	 +Fs/gfzC0xMQm6qGFB5UeiqANhjK3b7/6daVvb84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 306/325] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Mon,  2 Jun 2025 15:49:42 +0200
Message-ID: <20250602134332.348327423@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

From: Michal Luczaj <mhal@rbox.co>

commit 041933a1ec7b4173a8e638cae4f8e394331d7e54 upstream.

GC attempts to explicitly drop oob_skb's reference before purging the hit
list.

The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
embryo socket.

The python script below [0] sends a listener's fd to its embryo as OOB
data.  While GC does collect the embryo's queue, it fails to drop the OOB
skb's refcount.  The skb which was in embryo's receive queue stays as
unix_sk(sk)->oob_skb and keeps the listener's refcount [1].

Tell GC to dispose embryo's oob_skb.

[0]:
from array import array
from socket import *

addr = '\x00unix-oob'
lis = socket(AF_UNIX, SOCK_STREAM)
lis.bind(addr)
lis.listen(1)

s = socket(AF_UNIX, SOCK_STREAM)
s.connect(addr)
scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
s.sendmsg([b'x'], [scm], MSG_OOB)
lis.close()

[1]
$ grep unix-oob /proc/net/unix
$ ./unix-oob.py
$ grep unix-oob /proc/net/unix
0000000000000000: 00000002 00000000 00000000 0001 02     0 @unix-oob
0000000000000000: 00000002 00000000 00010000 0001 01  6072 @unix-oob

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/garbage.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -342,6 +342,18 @@ enum unix_recv_queue_lock_class {
 	U_RECVQ_LOCK_EMBRYO,
 };
 
+static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
+{
+	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (u->oob_skb) {
+		WARN_ON_ONCE(skb_unref(u->oob_skb));
+		u->oob_skb = NULL;
+	}
+#endif
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -365,18 +377,11 @@ static void unix_collect_skb(struct list
 
 				/* listener -> embryo order, the inversion never happens. */
 				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
-				skb_queue_splice_init(embryo_queue, hitlist);
+				unix_collect_queue(unix_sk(skb->sk), hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
 		} else {
-			skb_queue_splice_init(queue, hitlist);
-
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-			if (u->oob_skb) {
-				kfree_skb(u->oob_skb);
-				u->oob_skb = NULL;
-			}
-#endif
+			unix_collect_queue(u, hitlist);
 		}
 
 		spin_unlock(&queue->lock);



