Return-Path: <stable+bounces-227188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zWUgJThGu2n9iAIAu9opvQ
	(envelope-from <stable+bounces-227188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:41:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDD2C423B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFF3D302C336
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADF1FC0EF;
	Thu, 19 Mar 2026 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGtfMuw2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648222B9B7
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880882; cv=none; b=NZjwX+rzmCVku2iwBJ3w9JLwWwyIqNKmo1Z/mpHVCcoqU5in3rXFpPjOubdOii+iSH/MV/EvB5i7Ki1wzmFFKss6j63JEYJgWozXbOQp8mNjufH4ohUxo1ZGPn0PHTKdMBVPckNzFjgVmv5uCr09ELHR+1QZ92Kndx99o0wrORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880882; c=relaxed/simple;
	bh=sh527Hpyi/jRiM4Hl696Zk2bJQ3wV+8CfRmSgxHZr2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJT7dUmHv+jtxL0EIPUyCIHScYFH9f2Y59bxVghUHQvRfJa29sePvj6HTONV6QjuzDo8iWcLqmLyyAjDZe04go7OFDWmFqyJ6HFLt0p5ISPJzlzvscgsiqnEpTMQRxhMX/njnerzB8P16kcsoXb7vaUY44sPoW9Gqak/LsPnL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGtfMuw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7208DC19421;
	Thu, 19 Mar 2026 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773880882;
	bh=sh527Hpyi/jRiM4Hl696Zk2bJQ3wV+8CfRmSgxHZr2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGtfMuw2p81x4ffCotGzN4zVpqlrnhI7SA1sa7ZsjNebYSRUNE3YMvo+JXZzi/IST
	 +N8PcmcUIbVrt13YorPF8FGGxEdlgewF9wJDxzXDxUobN42NZ9+j2zA2CQps3LMREI
	 2l+rGjStAW1vRGojHnEOr9po7IOvde1Drj7P58bWzKrOkK8qNgY/5T+H+mR17Nib04
	 NspKypuffoLNQ9GN6T/k0LoLCE3Ilmc4DbvmojpEPkBT3MTAaR7ftVQB1HLtzp/fVb
	 SUXEEMWD/Zp1s25MO2FC1xn7coK0aSHZ+d0dmtDFDvB6hhHYBBWDZSE6SHAmnO2wbn
	 Kfp0ThHF/z1IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] crypto: atmel-sha204a - Fix OOM ->tfm_count leak
Date: Wed, 18 Mar 2026 20:41:19 -0400
Message-ID: <20260319004119.1852584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031700-bootie-guts-d510@gregkh>
References: <2026031700-bootie-guts-d510@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227188-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01EDD2C423B
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
index 0fcf4a39de279..a12653a658699 100644
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


