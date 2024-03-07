Return-Path: <stable+bounces-27091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116608753C9
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2B71F23C38
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C512D765;
	Thu,  7 Mar 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT5Fv8y1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18E1EEEA
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827337; cv=none; b=uIA0eAiZGMIlxfQcKgAtTwfAnw85pbrl66GI8lzJh51HbrdT/7k+eohrwrfaT/hCWuEsCwJNJZq3+LSVw6QHsbXZoNJ0aZD6Z8RUYikpHlBmXJcpNM8NPfC/OnKcyx5NF7dB4M2QvH7TfEiBL2Z4daUFAg4G3ZPkj2STzOzj7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827337; c=relaxed/simple;
	bh=1loEKb5ElTzqia1SThsslt6J7tbaglMc0a5d86yh8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeOKz+EsT2sPqxny4xDWdPMFMsEyh8uUk5ZSbAsEbKUxb6ngYje3ZvekY2Z481jCcU5xz6fr+/S/jpldpDecgvmt8uSGH4q5qa3daOUioaJMN8m2YtK0Mpl8CY9AYx9PiDIDDNR1x7Q5gURihBwUO4PjtSJnWoS7XDsDFjVyluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT5Fv8y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A4C433C7;
	Thu,  7 Mar 2024 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827337;
	bh=1loEKb5ElTzqia1SThsslt6J7tbaglMc0a5d86yh8Cw=;
	h=From:To:Cc:Subject:Date:From;
	b=FT5Fv8y1+bDkF81RKUPRQ+Wbb+RKD0OgG/NUT+ImjhU8i/7SAhhz0O1+W/+pMv1Wm
	 cKW7BzTHBdgjodlMXYO22pVkwLkGRfFY565oHHl32giSU6t4LzNm6uAsFXPcxE5xiS
	 CmEuLf/gwHf5v4D7tZWruN6NTv2wU0SwzUsPKolsfwmTzPuu3W1EdFunTroDKCfin+
	 5eQovCBhR1f7uCEgxE8BkP0ZKQqNGC/z9BBwG3UmhSRNiIms4L7tevx+/gZCMC97O0
	 PzNvisfvfrj6EfqUAhcUL8YvTS9t7ykSPgFcPN92jWpZTxmxKX/U94MY6prtOVSjDD
	 LpcTve5B4X0Cw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 1/1] tls: fix race between tx work scheduling and socket close
Date: Thu,  7 Mar 2024 16:02:08 +0000
Message-ID: <20240307160208.915314-1-lee@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb ]

Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
may exit as soon as the async crypto handler calls complete().
Reorder scheduling the work before calling complete().
This seems more logical in the first place, as it's
the inverse order of what the submitting thread will do.

Reported-by: valis <sec@valis.email>
Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 6db22d6c7a6dc914b12c0469b94eb639b6a8a146)
[Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/tls/tls_sw.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 910da98d6bfb3..58d9b5c06cf89 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -440,7 +440,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 	int pending;
 
 	rec = container_of(aead_req, struct tls_rec, aead_req);
@@ -472,8 +471,12 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 		/* If received record is at head of tx_list, schedule tx */
 		first_rec = list_first_entry(&ctx->tx_list,
 					     struct tls_rec, list);
-		if (rec == first_rec)
-			ready = true;
+		if (rec == first_rec) {
+			/* Schedule the transmission */
+			if (!test_and_set_bit(BIT_TX_SCHEDULED,
+					      &ctx->tx_bitmask))
+				schedule_delayed_work(&ctx->tx_work.work, 1);
+		}
 	}
 
 	spin_lock_bh(&ctx->encrypt_compl_lock);
@@ -482,13 +485,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	if (!pending && ctx->async_notify)
 		complete(&ctx->async_wait.completion);
 	spin_unlock_bh(&ctx->encrypt_compl_lock);
-
-	if (!ready)
-		return;
-
-	/* Schedule the transmission */
-	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
-		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
 static int tls_do_encryption(struct sock *sk,
-- 
2.44.0.278.ge034bb2e1d-goog


