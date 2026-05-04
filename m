Return-Path: <stable+bounces-243295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKlZGx6o+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A954BE8C9
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C317302343A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC83DF008;
	Mon,  4 May 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sK3++jTE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDF3DEAED;
	Mon,  4 May 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903519; cv=none; b=WTn5DAB15t7fLuINBP/Ankz+6GRVrqsUelUBidK5uBocThH59E04aQR9mbqLwZXtBKyIeaPKdkin9IxuucjO3xvJg5O+i4XfXgEFLe2v3RvvjcSHoyH9Rga+Qn4xqyN6Rs01ysKPuKGap9zCgU8k4xdE0WzBIli2sp3xSONcVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903519; c=relaxed/simple;
	bh=7trNfyD70CuJx484GCYfG1OH2o3+J3sV290ddleRuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKeD2N/xOhHCxVPoEDC2oDHKiOED4pXwDSurpkua9NKgpXC15ZZxob0M0W4yPj9o9l0l9c5s6bXluW9kGf5WqDJ+jDET9pHusgH3NQN9GQs2CE6VWHQft3vpCbguv488SbhhrACkyvF5ov4rzSb1GL4ETb0zQlsaDCkv1m14lX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sK3++jTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932EEC2BCB8;
	Mon,  4 May 2026 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903518;
	bh=7trNfyD70CuJx484GCYfG1OH2o3+J3sV290ddleRuyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sK3++jTEmEax0fc85gC+HnuuO57kX1P7NXH4+cv8l/5EAQH645VMdHjuNxZrjzn5r
	 21b4w4MER40Bi9QEu/MxoDL8gAyxUfzAcik1MZeveuUjG2gPJ+VfgCNEyVsQHbGa73
	 ryJu6lrZSVZDeTRlVJ8mX64GNDsjUJCg1co9fQwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7.0 265/307] crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
Date: Mon,  4 May 2026 15:52:30 +0200
Message-ID: <20260504135152.782439077@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25A954BE8C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243295-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit bab1adf3b87e4bfac92c4f5963c63db434d561c1 upstream.

Unregister the hwrng to prevent new ->read() calls and flush the Atmel
I2C workqueue before teardown to prevent a potential UAF if a queued
callback runs while the device is being removed.

Drop the early return to ensure sysfs entries are removed and
->hwrng.priv is freed, preventing a memory leak.

Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-sha204a.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -194,10 +194,8 @@ static void atmel_sha204a_remove(struct
 {
 	struct atmel_i2c_client_priv *i2c_priv = i2c_get_clientdata(client);
 
-	if (atomic_read(&i2c_priv->tfm_count)) {
-		dev_emerg(&client->dev, "Device is busy, will remove it anyhow\n");
-		return;
-	}
+	devm_hwrng_unregister(&client->dev, &i2c_priv->hwrng);
+	atmel_i2c_flush_queue();
 
 	sysfs_remove_group(&client->dev.kobj, &atmel_sha204a_groups);
 



