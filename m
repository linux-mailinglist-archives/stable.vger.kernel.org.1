Return-Path: <stable+bounces-39936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D124B8A5574
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6B281B68
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1374E11;
	Mon, 15 Apr 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMfioUGT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA691D52B;
	Mon, 15 Apr 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192263; cv=none; b=kBnnMlvFZ4jGefu5QN9+aCDpOSgdWzBd9jqsKs7UFw5UibDdAJoXTxhkjOVLrhW+ZCyGbRMan6gMm9k/8QahxgElZP7w9OQpl78nFWwvRFTLdSfUV26S8QdU+KIW8t/W1io7lFyoOsVp5Z83Mxjnfe1+urJa4l3zW06sNjq93EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192263; c=relaxed/simple;
	bh=oQyH2OUG3zCpg5aP9ovha8r5OwqFI68xiVCx9oAVziI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWDAywhtHKLaalnEILJ9OayBd0blhcnohP9aDG4uhlo7Q8G+XnKdUPIVFlfjnTHfaziKN+LXIlx0wkKJ4Dx+yXwn5rGxncVQzc9tgaCutMwQrUmRyDPcqUCljhh5yysUz3gYpcqKJxXK7shU2Le68BMPasXzv/8jbyKEQizmeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMfioUGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96217C113CC;
	Mon, 15 Apr 2024 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192263;
	bh=oQyH2OUG3zCpg5aP9ovha8r5OwqFI68xiVCx9oAVziI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMfioUGTL13aEEwyqKTK14lo/laoMb3sz6sGTioYnccYsSLlZDyxxxO1n0pZXssXr
	 uJLKqpGFJTvcvetnd+iSI2FwORXNJ6BPPaBue4GFxlWl6vnnhibyImd4312++vSb3+
	 N4NPUmOC4jh7dQ/00xqR8aZRlrCURsTi8y6pzCnQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 13/45] af_unix: Clear stale u->oob_skb.
Date: Mon, 15 Apr 2024 16:21:20 +0200
Message-ID: <20240415141942.640243981@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit b46f4eaa4f0ec38909fb0072eea3aeddb32f954e ]

syzkaller started to report deadlock of unix_gc_lock after commit
4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
it just uncovers the bug that has been there since commit 314001f0bf92
("af_unix: Add OOB support").

The repro basically does the following.

  from socket import *
  from array import array

  c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  c1.sendmsg([b'a'], [(SOL_SOCKET, SCM_RIGHTS, array("i", [c2.fileno()]))], MSG_OOB)
  c2.recv(1)  # blocked as no normal data in recv queue

  c2.close()  # done async and unblock recv()
  c1.close()  # done async and trigger GC

A socket sends its file descriptor to itself as OOB data and tries to
receive normal data, but finally recv() fails due to async close().

The problem here is wrong handling of OOB skb in manage_oob().  When
recvmsg() is called without MSG_OOB, manage_oob() is called to check
if the peeked skb is OOB skb.  In such a case, manage_oob() pops it
out of the receive queue but does not clear unix_sock(sk)->oob_skb.
This is wrong in terms of uAPI.

Let's say we send "hello" with MSG_OOB, and "world" without MSG_OOB.
The 'o' is handled as OOB data.  When recv() is called twice without
MSG_OOB, the OOB data should be lost.

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM, 0)
  >>> c1.send(b'hello', MSG_OOB)  # 'o' is OOB data
  5
  >>> c1.send(b'world')
  5
  >>> c2.recv(5)  # OOB data is not received
  b'hell'
  >>> c2.recv(5)  # OOB date is skipped
  b'world'
  >>> c2.recv(5, MSG_OOB)  # This should return an error
  b'o'

In the same situation, TCP actually returns -EINVAL for the last
recv().

Also, if we do not clear unix_sk(sk)->oob_skb, unix_poll() always set
EPOLLPRI even though the data has passed through by previous recv().

To avoid these issues, we must clear unix_sk(sk)->oob_skb when dequeuing
it from recv queue.

The reason why the old GC did not trigger the deadlock is because the
old GC relied on the receive queue to detect the loop.

When it is triggered, the socket with OOB data is marked as GC candidate
because file refcount == inflight count (1).  However, after traversing
all inflight sockets, the socket still has a positive inflight count (1),
thus the socket is excluded from candidates.  Then, the old GC lose the
chance to garbage-collect the socket.

With the old GC, the repro continues to create true garbage that will
never be freed nor detected by kmemleak as it's linked to the global
inflight list.  That's why we couldn't even notice the issue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240405221057.2406-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 265dc665c92a2..27a88a738793f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2567,7 +2567,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				}
 			} else if (!(flags & MSG_PEEK)) {
 				skb_unlink(skb, &sk->sk_receive_queue);
-				consume_skb(skb);
+				WRITE_ONCE(u->oob_skb, NULL);
+				if (!WARN_ON_ONCE(skb_unref(skb)))
+					kfree_skb(skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
-- 
2.43.0




