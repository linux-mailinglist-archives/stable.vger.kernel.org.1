Return-Path: <stable+bounces-227196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MFqFV1Mu2kOigIAu9opvQ
	(envelope-from <stable+bounces-227196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10B92C446A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F1FE3020528
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062FE2701C4;
	Thu, 19 Mar 2026 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oljyQmP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1026E710
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882458; cv=none; b=IrPsoRSBXVFPNlCR1kU4Y+uy/zxX2rtGtlk6daAeFsKoR8mk8b8FhkL2IJhVdUu9021jbRw5a7rZkuKR3HyaFLDcJtS7AwdA3YSLbxVi30PDWnek6rgHzgr3fUSIXloM5aIHNrsPx9iqZz+XssJa1yPSEZah6NbuCbzPu/aqShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882458; c=relaxed/simple;
	bh=j4GUmavjeBIGpWI6Er6A10xpjjAYoRzcKHmQ3mSVWos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUxKn0/+yJJFCh1EruPPbXd49PO0pbaGtUBC+4aIKD4f7/CJo7RxusML7jYzgiiVBl6OhAH0IQM16kjfV78UcpnHCV12DdpkW1A61GlYTxTdpog9Ok2T6KZmHn+QtVEqjQ0xLZg1/dfENWUNbroaEkS1jZhkGjLA4nPcXycu5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oljyQmP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA648C19421;
	Thu, 19 Mar 2026 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882458;
	bh=j4GUmavjeBIGpWI6Er6A10xpjjAYoRzcKHmQ3mSVWos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oljyQmP3VFfoEZueDQ5aFtLHpw7GibNN7o5FP1v8/3Fs/xZGUmtnCplyCUG/yh66J
	 HeQ3EgSgfc2VC15YY3PsndPjYErUSqnqsHfx/RkYl/Ce5ADkU+tPT3DqKfRaQ1Vw1f
	 k8Wiq15xEtR80LcZQwHvUnMJeMo819URLD2fE55bBiMiERs8tLMu80hnfwSvirRZRR
	 KnjCeq1+G+2h9my0t1L/2Bg0UfaeU0EikLZCkWME/C5SoIxGZNQzvyzyNcEXLeQ7ow
	 REWynIvPUUmAVRfj3xr+vnfZ5VCDcM1PoS01GcLBGZAr0mjoes2JqHG90yqQ6TNsJT
	 0sQ/uXhxQph3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: atmel-sha204a - Fix OOM ->tfm_count leak
Date: Wed, 18 Mar 2026 21:07:36 -0400
Message-ID: <20260319010736.1868348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031701-bootleg-debating-39be@gregkh>
References: <2026031701-bootleg-debating-39be@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227196-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,apana.org.au:email]
X-Rspamd-Queue-Id: E10B92C446A
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
index 5bc809146ffea..67fd084a2b971 100644
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


