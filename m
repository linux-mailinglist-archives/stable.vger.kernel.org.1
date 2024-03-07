Return-Path: <stable+bounces-27090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B546C8753C7
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E700F1C22CB3
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BD12F380;
	Thu,  7 Mar 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh86tQZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FF12AACC
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827292; cv=none; b=lldOeJis2TWPV+15NJWGxRoKiYudHddmix4cKKWf/5UP7p7061o4J75TPSrcOmM0UhF0aVohi7hV4edgMl0MnxvnfFJYSLfgfEZILJSMn42wByjTzDH0TIoxn54H+W493/Wo/gmRV6kLghxMQUD2iJrRk7DILgqUIYOTOy9uJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827292; c=relaxed/simple;
	bh=YOzPpMwoSv8pvHXe4H+QzVG2u4UaYCqrBw6pxUbYFEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsLPB/NqvsGS6A3zDytOeZX8Uw9rk/1Ac1Vwa+zhuMAbL570himaXwiUroE/5KJKGMm7xSMRwqI+RPjMP8E8ciCqFQDkV5+jrONktRMRynDXbqrHo70EZI5uG6zV61HM0IkZOcLeeSx3/Pwn7jGn0SH2gid5nnHvsZrJ9g6QomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh86tQZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11160C433C7;
	Thu,  7 Mar 2024 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827291;
	bh=YOzPpMwoSv8pvHXe4H+QzVG2u4UaYCqrBw6pxUbYFEM=;
	h=From:To:Cc:Subject:Date:From;
	b=hh86tQZOGZuDyx+/jGTUbUkRICOApUBA7oWQZlOcytfr12Qh5En2dMxoijmrT/77e
	 OuM7QKV0/SXndlJwUXiYNAotWzRC66NFdYdwdni4afDVRxDztbEmmW+Ua1ifnIHcw+
	 9cApa0VkZe3wloFiiX/xLtU1Jf3LeELJ/x0zttGN0We/oXUycCAkVcPbKCSmVuZ29t
	 1W3lQKBCeJ/HHyZnpf/vyihmF4kkbil8i9OEpLHO8uqmW6Vz/MusomePCf7hwgPUrZ
	 yWX40/4x7DxYdV1B3Lp9FcY2zux28C/e+7wLx0rcAQTR7kQQ5nFRIljkfhvktgAqI0
	 bkR52S/Hq3PRw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 1/1] tls: fix race between tx work scheduling and socket close
Date: Thu,  7 Mar 2024 16:01:21 +0000
Message-ID: <20240307160121.914736-1-lee@kernel.org>
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
index 46f1c19f7c60b..25a408206b3e0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -443,7 +443,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 	int pending;
 
 	rec = container_of(aead_req, struct tls_rec, aead_req);
@@ -475,8 +474,12 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
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
@@ -485,13 +488,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
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


