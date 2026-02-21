Return-Path: <stable+bounces-217648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HPo6LvIBmmmnXwMAu9opvQ
	(envelope-from <stable+bounces-217648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:05:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326316D9D7
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5183A302F733
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0968200110;
	Sat, 21 Feb 2026 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EdeceEfM"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2F6FC5
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700718; cv=none; b=d3gH7yJ+ubh/rdoyEGLSVU5PmPjd6BzyxP8PKXm/3lPZ8tzWUcqJwG9vbsQeQciAz13TnV5X1QR2uaM4p5A3Yq2lgcxQdPvL0cqoKJ0HhC9CbZmFxQiQNBXoZ4UIslIq6iSYP12V9AR0wm30TeKu+SrqKtf68chUcSIVAfC5dSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700718; c=relaxed/simple;
	bh=gKuYwENYrceJVeDntO1G4tFGAIwXGxYQRoFfN+PoFfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRVHdOCVEbwYHHfTyLTJ4onWGQYYHqIDAX+fRfB6NT2ntR5YYnIxgHGHuRS1tCvwigNf3DonswOfsNvsy2Jp4JWMMX0TlGHgbo0mzWqnH8LQkz+TlfaiT1ClA7VyiOkAkwtGjVzHcleZkIgdjN+Zj5rOIPoAPJCecmKUaMs9tlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EdeceEfM; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771700713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yLDQ4G+6GFW4iU0X3Mnjq0LBajt/MPm52sZH7eipsqY=;
	b=EdeceEfMPT/HNqUYPO72We4yfdggi2cTnMn+D9wm8fmzCRykKB02TV1XcWa1PEM8cZ0qGc
	/dQT1pGeA/XzITZ3FExKB89rkc5WM+q1A9D3ZEtpAi2UhafgqS30Eq2OetAXTFGFZxncvu
	mxyxvvVZ9zb4B4VlTCxK7hF1BaZCI0E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lothar Rubusch <l.rubusch@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linusw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
Date: Sat, 21 Feb 2026 20:04:25 +0100
Message-ID: <20260221190424.85984-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217648-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 1326316D9D7
X-Rspamd-Action: no action

Do not return early from atmel_sha204a_remove() when the device is busy.
Instead, flush the I2C workqueue before teardown to prevent a potential
UAF if a queued callback runs while the device is being removed.

Also ensure sysfs entries are removed and ->hwrng.priv is freed, to
prevent a memory leak during removal. Change the log level from emerg
to warn because the system is still usable.

Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.
---
 drivers/crypto/atmel-sha204a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0fcf4a39de27..3afad915aae3 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -190,10 +190,10 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv = i2c_get_clientdata(client);
 
-	if (atomic_read(&i2c_priv->tfm_count)) {
-		dev_emerg(&client->dev, "Device is busy, will remove it anyhow\n");
-		return;
-	}
+	if (atomic_read(&i2c_priv->tfm_count))
+		dev_warn(&client->dev, "Device is busy, will remove it anyhow\n");
+
+	atmel_i2c_flush_queue();
 
 	sysfs_remove_group(&client->dev.kobj, &atmel_sha204a_groups);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


