Return-Path: <stable+bounces-27088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494158753C3
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0504A283272
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD212EBE0;
	Thu,  7 Mar 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiFbd+xV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F3161
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827182; cv=none; b=uPkEdCAz8y5BIS2Vp9hI7BtA9O4EH84tZxTAY9464oBaIbgoM7XCDHX0qpYZpsOreXcFPObfvcP2Gg5f9icSEP9VbItsvOW0qQGso6sBrMnT42831eoKsJPC7zv0IDrFjHKTctYWztQUBFbPEhJs7NsEQHjpFSKBQIszdHFRrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827182; c=relaxed/simple;
	bh=SDI+fszKa5yk9LUR6z4VECcvNkyE2uzS6173PUd4V7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TN9A64+WK/53J3in7bbeVX9NNoDHTai1uJul7e7CR9woDMwHXYVw1Wt5ryW41ZvgtATkx9Nd8yg/wlrJ1pt1TWgKFlki1UMWZWcrz2uaU3xVnNIKYwkz4GgN+jT5Ke04D6x2j1IgudXVnBzLVKT02pPcjvsnvEio5CCR72c7GAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiFbd+xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F44C433F1;
	Thu,  7 Mar 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827182;
	bh=SDI+fszKa5yk9LUR6z4VECcvNkyE2uzS6173PUd4V7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=aiFbd+xVc2OcgbasavyxHXJqGmmZL/Sb9hIfSPWzWnowXARiAcN4p0v2qnYO35aiy
	 unQlA7GLhq/w6zckOY1GDUK7zRcN8C+cgHyRtLInotbasizPluauIHPR+CjZAHmztV
	 QQUxbTys0C0/+5IWxVAVioKuLSFWKYIzYGpM8HK4LDMc+cHSardI416NBSVjzasTMG
	 9Zwg/tT6Mny6niI8znpwqdFmBhyoEYR9pJ+lYEQj1DOVEgsI7VzmTHSWQELMg9/Yfu
	 hFJYtVTOrOp9iN3FySP5FuK2xE7Fdi2/PiT82wJuQaQXzFHUv6nOg36w7EB57SIc5Z
	 Kh5yBFIn/3Ynw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and socket close
Date: Thu,  7 Mar 2024 15:59:29 +0000
Message-ID: <20240307155930.913525-1-lee@kernel.org>
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
index 2bd27b77769cb..d53587ff9ddea 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -449,7 +449,6 @@ static void tls_encrypt_done(crypto_completion_data_t *data, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 	struct sock *sk;
 
 	rec = container_of(aead_req, struct tls_rec, aead_req);
@@ -486,19 +485,16 @@ static void tls_encrypt_done(crypto_completion_data_t *data, int err)
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
 
 	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-
-	if (!ready)
-		return;
-
-	/* Schedule the transmission */
-	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
-		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
-- 
2.44.0.278.ge034bb2e1d-goog


