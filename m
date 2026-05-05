Return-Path: <stable+bounces-244248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JbOLucu+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC34D25ED
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F8CA30237C4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C624949EC;
	Tue,  5 May 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GTvhD+nW"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775E4B8DFC;
	Tue,  5 May 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003649; cv=none; b=tQVcXnYQytGbwNfeGKvUWpT09Q2SSeAT6hDx8wmOTITujGKDoRqWGCcgF5I4Hn4oPljtI1881rHwB5TnrebRzLIRxKlY3z1RRY8mJpgg0Hq7RkqKgVn3ET/yxhsVlOsUMUNahfrXJLPIw9lJyJ3gPzl9NHYoRKs80qw7vnWWKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003649; c=relaxed/simple;
	bh=rYzBqDMpQHxsfA+dONNoX0tVKVs2dTdmHUIYbbGsfGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X24yNIDWSGg8EzQMhqu54MvTKMDmQOUz7a5ordlXERKCPlHbR1Ch47FdJShJD/yGZ93Hk5SF8/+8W2Ellrk06hGbDaoozbffDoQ9qxjtOR+2I5u004gatXMAMgK5xeOvrsmVEQSGCZxAPDAFVUdLnaR/kqsCoc2FeWyHJu4U9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GTvhD+nW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2A49E4E42BDB;
	Tue,  5 May 2026 17:54:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 011A76053C;
	Tue,  5 May 2026 17:54:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E607311AD0417;
	Tue,  5 May 2026 19:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778003645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JpOpkfzbgqwAqNbf+g4UBbxEQwK3GyfW/y3NthccvTA=;
	b=GTvhD+nWvXY+D8Pe20RP6uwoNQ3N1MClIt5o+lAiT8wN1GDRf7D2L+y1pxOhSd7EtaNDFw
	pvIQxQrYd62ORlpXTDvSlTP1Hct7jIOG5K/i6ox1G90+3qkxmnI03q/4qoOqa2lbN6tQjk
	vm6n9bIG7J64LueGcOLmlAX3djzvNr6aY/27gBbbWPAnMbTrLIto7se5V+YZFoJHltB7Dz
	R5OL10jpQkTe70M3vXVdOIe3h1ViwdINLljC7jkH1R+YjY4AL1y433uFQyHt9gcb8O9c8a
	vvkEajVbXqLeicsl/M7kygBYflrO32B8oIX/KGiBzZfIq6vnzqTHoXpHsPKzgA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 05 May 2026 19:53:12 +0200
Subject: [PATCH v2 11/12] crypto: talitos/hash - fix SEC2 64k - 1 ahash
 request limitation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-11-5818064bd190@bootlin.com>
References: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
In-Reply-To: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778003630; l=3090;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=rYzBqDMpQHxsfA+dONNoX0tVKVs2dTdmHUIYbbGsfGU=;
 b=dE4Y9u/IR78IoslRgljNfHFwadp3kQhXMnJHpTdEtd9+6Zh4LS80/ICeVgQHlF1NIUbKS11yE
 YT5EF05VpaDAhfTtssOdjVYjfqkttVVWavoKaDHgO5U+TKaUgOx/8vk
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5CDC34D25ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244248-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The problem described in commit 655ef638a2bc ("crypto: talitos - fix
SEC1 32k ahash request limitation") also apply for the SEC2 hardware,
but with a limitation of 64k - 1 bytes.

Split ahash_done() into SEC1 and SEC2 paths: SEC1 continues to free the
whole descriptor list at once, while SEC2 now iterates through
descriptors one by one, submitting the next only after the previous
completes, which is required since SEC2 cannot chain descriptors in
hardware.

Cc: stable@vger.kernel.org
Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 50 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 10181f5ee0ec..cdb6823d7038 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1833,18 +1833,51 @@ static void ahash_done(struct device *dev,
 {
 	struct ahash_request *areq = context;
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	bool is_sec1 = has_ftr_sec1(dev_get_drvdata(dev));
+	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct talitos_edesc *edesc, *next;
+	bool is_last;
+
+	if (is_sec1) {
+		is_last = true;
+		ahash_free_desc_list_from(areq,
+					list_first_entry(&req_ctx->desc_list,
+							struct talitos_edesc, node));
+
+		ahash_request_complete(areq, err);
+	} else {
+		edesc = container_of(desc, struct talitos_edesc, desc);
+		is_last = edesc->last;
+		if (!is_last)
+			next = list_next_entry(edesc, node);
 
-	if (!req_ctx->last_request && req_ctx->to_hash_later) {
+		list_del(&edesc->node);
+		common_nonsnoop_hash_unmap(dev, edesc, areq);
+		kfree(edesc);
+
+		if (err)
+			goto out;
+
+		if (!is_last) {
+			err = talitos_submit(dev, ctx->ch, &next->desc,
+					     ahash_done, areq);
+			if (err != -EINPROGRESS)
+				goto out;
+			return;
+		}
+
+out:
+		if (err && !is_last)
+			ahash_free_desc_list_from(areq, next);
+		ahash_request_complete(areq, err);
+	}
+
+	if (!req_ctx->last_request && is_last && req_ctx->to_hash_later) {
 		/* Position any partial block for next update/final/finup */
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
 	}
-
-	ahash_free_desc_list_from(areq,
-				  list_first_entry(&req_ctx->desc_list,
-						   struct talitos_edesc, node));
-
-	ahash_request_complete(areq, err);
 }
 
 /*
@@ -1954,7 +1987,8 @@ static int ahash_process_req_prepare(struct ahash_request *areq,
 {
 	struct talitos_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	size_t desc_max = is_sec1 ? TALITOS1_MAX_DATA_LEN : SIZE_MAX;
+	size_t desc_max = is_sec1 ? TALITOS1_MAX_DATA_LEN :
+				    TALITOS2_MAX_DATA_LEN;
 	struct talitos_edesc *edesc;
 	struct scatterlist tmp[2];
 	size_t to_hash_this_desc;

-- 
2.53.0


