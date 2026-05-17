Return-Path: <stable+bounces-249118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mApTMsHsCWpCvQQAu9opvQ
	(envelope-from <stable+bounces-249118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:28:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69719562427
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589E0301F9EC
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAF3BB138;
	Sun, 17 May 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rXy10ZkO"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29529D291
	for <stable@vger.kernel.org>; Sun, 17 May 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035299; cv=none; b=ILVcufWwozeff4vjOc3MTlJVmRDu0UqK0q8HBwdjwROFHCyJ6ig5Y70ggCpgyQAbLOf8dWiVm6uo07Yi7cVyzKONeTQAqYoxd2MVNXPNXj/nYBXuF5v5fDEvK3FmtqoOVnoT52Q+qR2+Xp57SR+lUYhNnY41fvCWpev1nIbcuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035299; c=relaxed/simple;
	bh=edBBxxv1poLSjMB8ohIHerWYeMF+vu/6TSkucKR5d08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iB0Bf6jbBSX3WctD/DvCu4mC2na1BfGv6ez43eqeNUtZWu32VUgaMl5Tce5ZqmP2LcTOh3V+peVOgMMPpcli2S7SSXHg1wzbaiunn+BFjmn1FcPH8i9qnl0Y8N0cpJyg521zNoQOk47RBg/fOe5Y3UT+RhsZV8UvWumYGDSLFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rXy10ZkO; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779035285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OwzbtTTYqiL4pShWiGkQxPeTW1obh95IMjB2QL15Rp8=;
	b=rXy10ZkOEqCQDYX2v8Vi3hfLe+jx5GNQok4yZq5qUYzdaeep1y4+Q7Ep9NGDf/bArE32ce
	G2CAhgid36ysZoaD6yqSOrtT7vKyZrCkFnCW9Gc6ouu7LEv7yu5kvQrC14DuH4gbtWpxcv
	XUX1NMWAuzRTsfkJClUhs7bjH5gfigc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lothar Rubusch <l.rubusch@gmail.com>
Cc: stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-sha204a - fail on hwrng registration error in probe path
Date: Sun, 17 May 2026 18:27:40 +0200
Message-ID: <20260517162740.1250-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=thorsten.blum@linux.dev; h=from:subject; bh=edBBxxv1poLSjMB8ohIHerWYeMF+vu/6TSkucKR5d08=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmcb2rUm7NZGP7IlMtLr1APUWjtXP1c6NmBjnqx8zz5E zZ3rcnrKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIk4T2dkuMFke3GuyFuBVvew dtH9z7VfLg8Sjb4nJXKpY3LUF/OGNwx/hVWXbenaNdtQ/uzsyH96vVPevG4ICGk/4OB+3VYuXDm YAQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 69719562427
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-249118-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

Commit 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
overwrote the hwrng registration return value when creating the sysfs
group, which allowed atmel_sha204a_probe() to succeed even if
devm_hwrng_register() failed.

Return immediately when devm_hwrng_register() fails, and report both
hwrng and sysfs registration errors with dev_err(). Adjust the sysfs
error log message for consistency.

Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-sha204a.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 37538b0fd7c2..12eb85b57380 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -183,12 +183,14 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
-	if (ret)
-		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
+	if (ret) {
+		dev_err(&client->dev, "failed to register RNG (%d)\n", ret);
+		return ret;
+	}
 
 	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
 	if (ret) {
-		dev_err(&client->dev, "failed to register sysfs entry\n");
+		dev_err(&client->dev, "failed to create sysfs group (%d)\n", ret);
 		return ret;
 	}
 

