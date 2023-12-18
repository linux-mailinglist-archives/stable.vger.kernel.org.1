Return-Path: <stable+bounces-7587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA8817331
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE271C24278
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C653786B;
	Mon, 18 Dec 2023 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9Frqohs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FD1D15F;
	Mon, 18 Dec 2023 14:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB052C433C8;
	Mon, 18 Dec 2023 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908872;
	bh=9pQYsj76zi1/Qelpj7RjHCw1Kxug6L6Ih4KvqBrM1gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9Frqohs1kX8u9BGAAtNoW4BBjMUrHuQ6ILlrL8Hnwivq4zlfmqvI44QWCYZTuK7j
	 p//udyZVonx9P6yMdnigsavS5Giz+Q2bu2RYDXLyF+UdMMz6XeQyuH9TkOkSsXNmLg
	 hmvHJoSlPwlY43oaJNTGwvoz+hBSVvfsFTUE0yxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <v4bel@theori.io>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/83] appletalk: Fix Use-After-Free in atalk_ioctl
Date: Mon, 18 Dec 2023 14:51:57 +0100
Message-ID: <20231218135051.334981275@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit 189ff16722ee36ced4d2a2469d4ab65a8fee4198 ]

Because atalk_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with atalk_recvmsg().
A use-after-free for skb occurs with the following flow.
```
atalk_ioctl() -> skb_peek()
atalk_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
```
Add sk->sk_receive_queue.lock to atalk_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Link: https://lore.kernel.org/r/20231213041056.GA519680@v4bel-B760M-AORUS-ELITE-AX
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/appletalk/ddp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index bf5736c1d4584..8daa3a1bfa4cd 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1812,15 +1812,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
-		/*
-		 * These two are safe on a single CPU system as only
-		 * user tasks fiddle here
-		 */
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+		struct sk_buff *skb;
 		long amount = 0;
 
+		spin_lock_irq(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
 		if (skb)
 			amount = skb->len - sizeof(struct ddpehdr);
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		rc = put_user(amount, (int __user *)argp);
 		break;
 	}
-- 
2.43.0




