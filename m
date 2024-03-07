Return-Path: <stable+bounces-27089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E668753C6
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953A4B232A4
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C612F586;
	Thu,  7 Mar 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyXBG4sq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246511E49E
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827249; cv=none; b=uED4V7ywMxiws8oKlub2//ZXEhHbXa7DENMFZEt1Lf9ezkseQfh9ZVZgoBDzgG37sv/bpQwU3ziMXljkv023UofzIG0Vss0ZYs3Nu0RVtIHjL9Z1lyk5/NcFg2ukhz99105NkX/kzA/AnJ7FCTGiuCe9TR8Zx792BUv/3PKOgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827249; c=relaxed/simple;
	bh=shL9O+E9tOG/7YC9mofpzwab/u4LjycmiWuSRtuBpCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScwgZanGR3poSyVDIlLKawKPP6qEx11BxkYmvsHc/CdEJV6AhGWAGGCk8wQE4Ee3YgvJ46wV9ruNd4TJQIuGsHWvlaXwUJWrwXeKf6ZwHSu1Ry+d+HMfm2xKUsE7IS3AxvA6sYB6ZsBT0ql5EiGytXXUqP0rZj05QM1hryljEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyXBG4sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D529FC433C7;
	Thu,  7 Mar 2024 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827248;
	bh=shL9O+E9tOG/7YC9mofpzwab/u4LjycmiWuSRtuBpCo=;
	h=From:To:Cc:Subject:Date:From;
	b=EyXBG4sq+oD3asrz72qGL3N/IPkrAQoaCRJ2JBOehBS4T0LhL+2SaHBeyfgmzdlid
	 hmScMaRWHkzqqkxI6idQBFpBHCOd+MWKYGDCRAtPZPJRtrLCtSEyPSimRTC0fc5tfg
	 VIir8p2A12AQDNDIPObqPe7MCbYyN0zzcU/q8SaNXjgpqoXMurxJ3qyWB/pD4Mmzwx
	 XrcNLJU5SbpT60jqQbYN+BeCgB0fLLjhYZlnK3aIX6x2Ia2bSmv8/zVdGMJb3rr6N+
	 aqT3+Tuj8Lj+JHzXJgJAuqrRwG6nalA1laofCH/JDVE3DPPmuZOjSJ27QcejTJgzO+
	 nGMyd3u2iPYoQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 1/1] tls: fix race between tx work scheduling and socket close
Date: Thu,  7 Mar 2024 16:00:42 +0000
Message-ID: <20240307160042.914233-1-lee@kernel.org>
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
index fc55b65695e5c..e51dc9d02b4e7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -448,7 +448,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 	int pending;
 
 	rec = container_of(aead_req, struct tls_rec, aead_req);
@@ -480,8 +479,12 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
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
@@ -490,13 +493,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
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


