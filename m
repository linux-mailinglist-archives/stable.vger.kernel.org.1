Return-Path: <stable+bounces-241534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOBDEa6L8GkRUwEAu9opvQ
	(envelope-from <stable+bounces-241534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:27:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7648297B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C45A301E182
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689C3E5594;
	Tue, 28 Apr 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pX/HKCiZ"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CB3E0C5A
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371330; cv=none; b=dk5pH4ik0SNP8zjl8YprPb2PbOhywW3ll/ZN04jTOVH8mNTwzmMJSu6nQpiffV8hp7jI1ss9SVD8A0WVchzgCBEuwYuL/RIMFf6K7NtKt8rmYuYfcQU20xpJvSs97bAwjNTWKTmC1bWGAXKoh3G9J6efFodacbgilUgubq2VlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371330; c=relaxed/simple;
	bh=j1nd45mg4g3EXUjYAzfoYk5UWhyibVn267xhc4o9T+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcA0McnBhH5aWAfq3x58s6LJpWvmQbT/sqpLuRpD26FegY7v4YxR3tFPtDGMPzWfu4+8SrJo38Z6T2DEMIXeefpqhcwl2TCEg+ET6esu/isJ43iUBpJtUAA8WIO/DpGmRMAXGbSQ5Iof+SdCGPuxkKaTdKpYEQnYekFu0ObctR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pX/HKCiZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777371326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xcy635DpKKoCVUN6XKiv2266UoWMk9NqTJ3mH2R1Q9g=;
	b=pX/HKCiZvez7ezlxL+P09TKTq1bX23uyrhEP1GTt7e4+HtRS4vGbYfkhGlMpyn9E9YXADJ
	ZlmVYW3uP/7V0fXEqXjzrMYSFt4JA4B8ERzYvVMVky2oY6jGEEwsokJ4oQTlD17TE6ydOP
	dIisVQTOwHm6EoYRaL8f4SBby9PNP8c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A
Date: Tue, 28 Apr 2026 12:14:32 +0200
Message-ID: <20260428101430.514838-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3773; i=thorsten.blum@linux.dev; h=from:subject; bh=j1nd45mg4g3EXUjYAzfoYk5UWhyibVn267xhc4o9T+8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkfOtpmOE333BNo027uvc7sukDnxj2T3k90Xs8dYXPtS 6HjpPVHO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi714y/I+3mbHCaWF3Q+oM h2bRG7OeuDiv83qfkHNfMsGxbNOL+MMM/11+ufdujdnVN7dsI+fXI0rRodPVbru/f2N7wO3a5st yt1gB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E2D7648297B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241534-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,metzdowd.com:url,microchip.com:url]

Commit 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to
lowest possible") reduced the hwrng quality to 1 based on a review by
Bill Cox [1]. However, despite its title, the review only tested the
ATSHA204, not the ATSHA204A.

In the same thread, Atmel engineer Landon Cox wrote "this behavior has
been eliminated entirely"[2] in the ATSHA204A and "this problem does not
affect the ATECC108 or the ATECC108A (or the ATSHA204A)"[3].

According to the official ATSHA204A datasheet [4], the device contains a
high-quality hardware RNG that combines its output with an internal seed
value stored in EEPROM or SRAM to generate random numbers. The device
also implements all security functions using SHA-256, and the driver
uses the chip's Random command in seed-update mode.

Keep 'quality = 1' for ATSHA204, but drop the explicit hwrng quality
reduction for ATSHA204A and fall back to the hwrng core default.

[1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
[2] https://www.metzdowd.com/pipermail/cryptography/2014-December/023852.html
[3] https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html
[4] https://ww1.microchip.com/downloads/en/DeviceDoc/ATSHA204A-Data-Sheet-40002025A.pdf

Fixes: 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to lowest possible")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Drop the enum and dereference match data if needed as suggested by Ard
- Keep the review comment
- v1: https://lore.kernel.org/lkml/20260427124030.315590-3-thorsten.blum@linux.dev/
---
 drivers/crypto/atmel-sha204a.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index dbb39ed0cea1..a8c1b00b12f5 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -19,6 +19,12 @@
 #include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
+/*
+ * According to review by Bill Cox [1], the ATSHA204 has very low entropy.
+ * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+ */
+static const unsigned short atsha204_quality = 1;
+
 static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
 				   void *areq, int status)
 {
@@ -158,6 +164,7 @@ static const struct attribute_group atmel_sha204a_groups = {
 static int atmel_sha204a_probe(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
+	const unsigned short *quality;
 	int ret;
 
 	ret = atmel_i2c_probe(client);
@@ -171,11 +178,9 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
 
-	/*
-	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
-	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
-	 */
-	i2c_priv->hwrng.quality = 1;
+	quality = i2c_get_match_data(client);
+	if (quality)
+		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
@@ -203,14 +208,14 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
-	{ .compatible = "atmel,atsha204", },
+	{ .compatible = "atmel,atsha204", .data = &atsha204_quality },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204" },
+	{ "atsha204", (kernel_ulong_t)&atsha204_quality },
 	{ "atsha204a" },
 	{ /* sentinel */ }
 };

