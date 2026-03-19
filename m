Return-Path: <stable+bounces-227198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN5lLltRu2lMigIAu9opvQ
	(envelope-from <stable+bounces-227198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:28:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332D2C46E2
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7319C309A9B8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4C13959D;
	Thu, 19 Mar 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfiSeFBs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032A270552
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883677; cv=none; b=Nt6sO0rmTl7DP+hbA0xT5cBnLFF6pDZN2tZ6sq8B7LPQjWMueTKcam2sYSwhPepxjLx0ms1ZahZFRddmDKF76D8aCevlUND7w90eqiqDdo7E7CqGK5HtuSBTX/tX2qpFYGVn9HDMYSB2EGCKZDKXDeWTHdY0cEBpxY9l/gWxhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883677; c=relaxed/simple;
	bh=VmTtZYYilYh86wYmGcWEhJpTKQlo66XvXC8y7qFir5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYZpHaIOQ9t9CrGU3nNA5ZiHHzCHVhIPyxgliCbm8ymbT632vsR5KSQJ56a3y+7j5DuJXGmzgR6HOAhlswEg1usqYOW8XkdI9VTX5l9lUi5eEKipyTSIbHz/b3QTWK9lR2t8Q6SFWaYgruAINonnkurMBGBk0mBy3jrzugXbxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfiSeFBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4852C19421;
	Thu, 19 Mar 2026 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883677;
	bh=VmTtZYYilYh86wYmGcWEhJpTKQlo66XvXC8y7qFir5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfiSeFBsbRRuUKOIXbtygkUhikpJ5GhOrk65jAw3zPAxgkeLHqnMH89+kC5I6zA5A
	 vKV/FTYYLVUADiT1W6NhpreMGUpap4EQuN5tI7ojBpSM4qx8DemO5R2pq53acTa2ON
	 pH7BgOO5MEWhWwW888/spKnSp5KMqGVzwuuEaN3ZQEUuXe5hEW1633HDqVGMoVs7Bn
	 1SiE2VSSemHhP9VcQU0R2CJGrYXUcDiw+UqlIp0xGgBuFQPS91879ufxd8P8os9hN9
	 YDdA7IqlsN+PgyV+4N+ozFIthfUeAzqOduSVk6cJmq3mU7Ki0QwrD/Kn7jYp5r7IG6
	 8blSRQBEYesvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: atmel-sha204a - Fix OOM ->tfm_count leak
Date: Wed, 18 Mar 2026 21:27:55 -0400
Message-ID: <20260319012755.1877496-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031702-level-vision-656b@gregkh>
References: <2026031702-level-vision-656b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227198-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,apana.org.au:email]
X-Rspamd-Queue-Id: 1332D2C46E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit d240b079a37e90af03fd7dfec94930eb6c83936e ]

If memory allocation fails, decrement ->tfm_count to avoid blocking
future reads.

Cc: stable@vger.kernel.org
Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ adapted kmalloc_obj() macro to kmalloc(sizeof()) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0ef92109ce22a..64d5ba13f4baf 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -52,9 +52,10 @@ static int atmel_sha204a_rng_read_nonblocking(struct hwrng *rng, void *data,
 		rng->priv = 0;
 	} else {
 		work_data = kmalloc(sizeof(*work_data), GFP_ATOMIC);
-		if (!work_data)
+		if (!work_data) {
+			atomic_dec(&i2c_priv->tfm_count);
 			return -ENOMEM;
-
+		}
 		work_data->ctx = i2c_priv;
 		work_data->client = i2c_priv->client;
 
-- 
2.51.0


