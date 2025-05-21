Return-Path: <stable+bounces-145872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027FABF8A0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C270D8C3CA5
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B520C490;
	Wed, 21 May 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdYUU98o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422117E;
	Wed, 21 May 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839158; cv=none; b=TnaxMpxyP/e+jHTlgBqQbC5NwMMPVSHXevTDOPjC+qzg3lEBU/IWLa+2uvpAe5yMUf9l7HEQ1luMc6MO2JrvQ6qmQZhxFyCBeVJpPcYOhwSPyvNZUZMUy4Glv3C1PQUShHY+IYS/sdyfHMDxc58773gru9S56MSaxnSKXY1lZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839158; c=relaxed/simple;
	bh=uHsEqfLjT5KcCIC8/dPxqDz7nX5lorkEZB+yPuJUV5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/xhRgKImEpdvqQNK2W9msmiddji395r5fkctiGT4ifLJ+E1nD10qkhTya2gJq/G0rhmcXd3q+Gxo1pSaHEu57bnR6VbMBaTkIG64b9inXXVqr6dmhq6NyLJDcSoCKcNIuBvEmINniwNElwpYD2sQGTUR6vCBx+0UWnDRLv89w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdYUU98o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC228C4CEE4;
	Wed, 21 May 2025 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839158;
	bh=uHsEqfLjT5KcCIC8/dPxqDz7nX5lorkEZB+yPuJUV5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdYUU98of9Eb/CRP6/rAtcygeVOaRKALw1lGV/2kfZGOv+IMw55sImkdkH94uTNgt
	 jXLqK3gmF2IFdWbNix2QSiarx44h+Wx3dIUeyOyxda0zIshmtnhdo6nAihXSCBozUC
	 r9Y74EP2IDUJK5O8p+5O/VJTN6tBosttEP/Om35NX0HGqNJQQTJswmXEau2QtkjdaL
	 Sl9rlfTkVgmGZJ/ajSGq2LToUYeeVimUPLFlbyL7rCCli3pGy2OPh5xtkcZVEt5pXI
	 xGJp6mDJXT0rtzMX8ou7UlwJcceOTpfxtPMaeU8D1Nm5FR25I+qcme+iMfeGI9HmAe
	 4juvheQZh+brw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 25/26] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Wed, 21 May 2025 14:45:33 +0000
Message-ID: <20250521144803.2050504-26-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 041933a1ec7b4173a8e638cae4f8e394331d7e54 ]

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
(cherry picked from commit 041933a1ec7b4173a8e638cae4f8e394331d7e54)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1f8b8cdfcdc8d..dfe94a90ece40 100644
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
@@ -365,18 +377,11 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 
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
-- 
2.49.0.1112.g889b7c5bd8-goog


