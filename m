Return-Path: <stable+bounces-7165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230081713B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B189C1C2344F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F9101D4;
	Mon, 18 Dec 2023 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hK6cuilt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92616129EC8;
	Mon, 18 Dec 2023 13:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CD8C433C8;
	Mon, 18 Dec 2023 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907736;
	bh=Ivvs0CKuuVlvh/mF5UFrBT9TOnGVDOVMYX+wssODKRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK6cuiltfT40SRGewhAeft1ZxfsQVZYkzMgSCrtYJSZL6RUqXxwucdjjcfzZYMs3f
	 WMUVyKaJa4nnBhF+KYxhr5fTOrgUEp+narzVJoqgiEmaxTDkTID6IX7itY431/Q0uz
	 5UWKkx4hgx06zfsB3UnTToSmduLxZyER71sqzxCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <v4bel@theori.io>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/106] net/rose: Fix Use-After-Free in rose_ioctl
Date: Mon, 18 Dec 2023 14:50:41 +0100
Message-ID: <20231218135056.096490912@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit 810c38a369a0a0ce625b5c12169abce1dd9ccd53 ]

Because rose_ioctl() accesses sk->sk_receive_queue
without holding a sk->sk_receive_queue.lock, it can
cause a race with rose_accept().
A use-after-free for skb occurs with the following flow.
```
rose_ioctl() -> skb_peek()
rose_accept() -> skb_dequeue() -> kfree_skb()
```
Add sk->sk_receive_queue.lock to rose_ioctl() to fix this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Link: https://lore.kernel.org/r/20231209100538.GA407321@v4bel-B760M-AORUS-ELITE-AX
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rose/af_rose.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index ca2b17f32670d..674937284b8d2 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1315,9 +1315,11 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case TIOCINQ: {
 		struct sk_buff *skb;
 		long amount = 0L;
-		/* These two are safe on a single CPU system as only user tasks fiddle here */
+
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
-- 
2.43.0




