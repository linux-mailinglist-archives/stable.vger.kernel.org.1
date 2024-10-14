Return-Path: <stable+bounces-83974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C2899CD74
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B47D1F237C1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940EC2BCF5;
	Mon, 14 Oct 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IPgVu126"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D22200CB;
	Mon, 14 Oct 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916372; cv=none; b=iCJ8Qri1VQPFuJzcQCwoJ49R2i/69mBk2ZiV58NVcrW0RLELHQY+hGXu7DOShK/NQ0+JpBRja7q2pFS/kiIC8FxQ1X1ZImAG82we0QYwYl8SmLjdWHcFNdwVCbe+jYQ59rG7R5zMx467Enf6bwTC738V8/YKJBn7FkW21587kBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916372; c=relaxed/simple;
	bh=JXUN2uEj8Rr0KLgrwde07BB8zoz9qY/+KUEindsIji8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVgKFp6X0WONdTYMSq10aGewy71wH/5HXDsgyob0yYPIFgQ1DoLO5sVBTRqzMooFVrM9SUNPPKf7LpRCPvVkZnbIWUfTWiWM8AJr0gnHFi7lgGgzE3g5FC9UKtYiVRMOXwg74kPoX8tohyu3tTLqW33s0FMmBizBf/xlfSYFcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IPgVu126; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B51C4CEC7;
	Mon, 14 Oct 2024 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916372;
	bh=JXUN2uEj8Rr0KLgrwde07BB8zoz9qY/+KUEindsIji8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPgVu12601S2D/7iaPrvU6zXLP4xJZXhNEbaZNphTyIloE/BQ3VMqkOzvYyhIj0//
	 8rrFxLboC0pfAxPvvIOBHIaxylFjqz9sEYyDBl4nNOIgmv4uUvWdt6bLW/qmUZz7tq
	 3gfX8GQSAzt+74gM0h+nvgvNunbzXdQg66WV9t3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 133/214] sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start
Date: Mon, 14 Oct 2024 16:19:56 +0200
Message-ID: <20241014141050.183178083@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 4d5c70e6155d5eae198bade4afeab3c1b15073b6 ]

If hashing fails in sctp_listen_start(), the socket remains in the
LISTENING state, even though it was not added to the hash table.
This can lead to a scenario where a socket appears to be listening
without actually being accessible.

This patch ensures that if the hashing operation fails, the sk_state
is set back to CLOSED before returning an error.

Note that there is no need to undo the autobind operation if hashing
fails, as the bind port can still be used for next listen() call on
the same socket.

Fixes: 76c6d988aeb3 ("sctp: add sock_reuseport for the sock in __sctp_hash_endpoint")
Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 078bcb3858c79..36ee34f483d70 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8531,6 +8531,7 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	struct sctp_endpoint *ep = sp->ep;
 	struct crypto_shash *tfm = NULL;
 	char alg[32];
+	int err;
 
 	/* Allocate HMAC for generating cookie. */
 	if (!sp->hmac && sp->sctp_hmac_alg) {
@@ -8558,18 +8559,25 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	inet_sk_set_state(sk, SCTP_SS_LISTENING);
 	if (!ep->base.bind_addr.port) {
 		if (sctp_autobind(sk)) {
-			inet_sk_set_state(sk, SCTP_SS_CLOSED);
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto err;
 		}
 	} else {
 		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
-			inet_sk_set_state(sk, SCTP_SS_CLOSED);
-			return -EADDRINUSE;
+			err = -EADDRINUSE;
+			goto err;
 		}
 	}
 
 	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
-	return sctp_hash_endpoint(ep);
+	err = sctp_hash_endpoint(ep);
+	if (err)
+		goto err;
+
+	return 0;
+err:
+	inet_sk_set_state(sk, SCTP_SS_CLOSED);
+	return err;
 }
 
 /*
-- 
2.43.0




