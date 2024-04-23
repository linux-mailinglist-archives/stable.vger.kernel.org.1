Return-Path: <stable+bounces-40962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2508AF9C9
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484171F27C25
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00066146D52;
	Tue, 23 Apr 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ez4mhVMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444E1420BE;
	Tue, 23 Apr 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908583; cv=none; b=H18iJlqDsza0vg9VI4+q+ia0uMh1peu2iM40LGV/rp12m0bKHshjwfkdNwtibBOImFCNsxUV+j8A1SF1d8K3kneJA2hUOZmk/Cm07j3PEDvpxIXH9onP5UQ+GRIPCh7CFRra8rTRgwV+cMdcthixrQ1c/KRahravHJDkYcmPR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908583; c=relaxed/simple;
	bh=HuAvBjnmsFL491rH6v6nu0QyKjvzLdMAyhB7sISQ3MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZq3U3Bj0f2EFX/kr5f3kpE07CegOqAG3P1jdf5f+lqQTpSJazuTWoHWPqizkbe5FQZR/WKY3Ra/IdAMouq7wuVEG8DJ94d35nFrDblHpeIdPvqyYSp4s897ozqOPlHddTadExaBsFCJM5sodLXxGAZfcc+wIHnUNK6d4sSgn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ez4mhVMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC0AC3277B;
	Tue, 23 Apr 2024 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908583;
	bh=HuAvBjnmsFL491rH6v6nu0QyKjvzLdMAyhB7sISQ3MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez4mhVMNedhLlAtzezO4w977DduW90P0o0vMoylknvmYRsYQMEfR2WVWHGnfByLr/
	 PMQu16ppgSvtIgrmsDUwdaqib0TFqk99qFjbS4p5kLlM57uS9pVeubTrbpZbuP2TcH
	 V6bEM+qpS3FlqeDSHgRvpZYg7+9gWFY1qdmD0FIM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/158] af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
Date: Tue, 23 Apr 2024 14:37:56 -0700
Message-ID: <20240423213857.017365087@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 283454c8a123072e5c386a5a2b5fc576aa455b6f ]

When we call recv() for AF_UNIX socket, we first peek one skb and
calls manage_oob() to check if the skb is sent with MSG_OOB.

However, when we fetch the next (and the following) skb, manage_oob()
is not called now, leading a wrong behaviour.

Let's say a socket send()s "hello" with MSG_OOB and the peer tries
to recv() 5 bytes with MSG_PEEK.  Here, we should get only "hell"
without 'o', but actually not:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c2.recv(5, MSG_PEEK)
  b'hello'

The first skb fills 4 bytes, and the next skb is peeked but not
properly checked by manage_oob().

Let's move up the again label to call manage_oob() for evry skb.

With this patch:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c2.recv(5, MSG_PEEK)
  b'hell'

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240410171016.7621-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 918724844231e..1340cb86f104c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2665,6 +2665,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		last = skb = skb_peek(&sk->sk_receive_queue);
 		last_len = last ? last->len : 0;
 
+again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
@@ -2676,7 +2677,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			}
 		}
 #endif
-again:
 		if (skb == NULL) {
 			if (copied >= target)
 				goto unlock;
-- 
2.43.0




