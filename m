Return-Path: <stable+bounces-7123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9470C817108
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA0E1C23D22
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9294C1D12F;
	Mon, 18 Dec 2023 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyn/1b7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594891D14F;
	Mon, 18 Dec 2023 13:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAE3C433C8;
	Mon, 18 Dec 2023 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907624;
	bh=4Pf9/NDpUXQXOlOD2mPL0naLtHx+vnm4nYMmUTFOqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yyn/1b7wjoOK0iSSzBke7X6aamBClczWh4canuTMqz6KcZVs7YBhgoatZoFDpoJiW
	 w8zsiQQIJsJu7XqpgxUyA7sENo0+hwe32EmFOY7o/yGgxMWIS5oIyvgXSRx4Su1jLr
	 pZuTmspNkVVdlBk2RCQzX4S+OY4hOMZpq14Xd918=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <v4bel@theori.io>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/36] atm: Fix Use-After-Free in do_vcc_ioctl
Date: Mon, 18 Dec 2023 14:51:16 +0100
Message-ID: <20231218135042.122542421@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135041.876499958@linuxfoundation.org>
References: <20231218135041.876499958@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit 24e90b9e34f9e039f56b5f25f6e6eb92cdd8f4b3 ]

Because do_vcc_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with vcc_recvmsg().
A use-after-free for skb occurs with the following flow.
```
do_vcc_ioctl() -> skb_peek()
vcc_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
```
Add sk->sk_receive_queue.lock to do_vcc_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Link: https://lore.kernel.org/r/20231209094210.GA403126@v4bel-B760M-AORUS-ELITE-AX
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 2ff0e5e470e3d..38f7f164e4848 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -71,14 +71,17 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ:
 	{
 		struct sk_buff *skb;
+		int amount;
 
 		if (sock->state != SS_CONNECTED) {
 			error = -EINVAL;
 			goto done;
 		}
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
-		error = put_user(skb ? skb->len : 0,
-				 (int __user *)argp) ? -EFAULT : 0;
+		amount = skb ? skb->len : 0;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
+		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
 		goto done;
 	}
 	case SIOCGSTAMP: /* borrowed from IP */
-- 
2.43.0




