Return-Path: <stable+bounces-244247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtaI+ou+mnIKgMAu9opvQ
	(envelope-from <stable+bounces-244247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA66B4D25F5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6303301A90F
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A54BC00B;
	Tue,  5 May 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UTaqYCiy"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C14B8DE0;
	Tue,  5 May 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003648; cv=none; b=JPfUtT/HXry4GgupNeGnYUijpNQQ//6Hv4v5FFe9wKmYCjLCbUOlFeW0ByP1rwiAyAYDwKak+qCz/XkmeBl66wJyXrhufCkRRqI7oU1OgVt/WMKCdFbcpBH30gDoBg1aPtiGxxVGdL3Cs+MMakafBsorcOa/zC/f4SyO7Y4mEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003648; c=relaxed/simple;
	bh=zQ7n1cO+oe/QJS0vhjvTNm0Pm5Gg9UkZrj6GnHdOReI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHS8NToayGrrXVBAXFaTbsZuK4D8RrvvTUHlMZvlLsGK5F4ScmVIkxjwZ3HGlqhK0BDZ7lyg3NHOfH4SjweRsld9DvQBYEkTxvKJ9XrXSBY+ee42ZYWGE0tRgyZH9NwqGUCeZPKBzD0zlLlfqCIuRLktohpofXzu3r5VynwLKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UTaqYCiy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AC5941A352C;
	Tue,  5 May 2026 17:54:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 824146053C;
	Tue,  5 May 2026 17:54:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5320711AD0415;
	Tue,  5 May 2026 19:54:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778003643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yneBkbWvWU9ZpczZXjNql/bZTuQXaRLrSJZVfJv7sVA=;
	b=UTaqYCiybGh1vUYAVZnt7pesqB1W6QvWbF3s53Yp4GGw889aaRyGRU+sSD4KMh8n0MN9fu
	ETi3BwW2Zawj/z8mJJkSuRxgUwV7Di5Xh5QTxp9/l2Wy+Y2jJ/XJu+PwVIb4MnWcnd+kXg
	B1t9bt0Z26D5v4ofTYVoPW0VnF530M8imKyKUzaH8s8cPccANeRj/YHKiS+bSEUTlMGEoD
	4+gPpJs2Vhi5pQwzcVv5Ffw0g7AtxxsFbhhTQiJ8fxPdUsPKhKmvDeeNHlWJKWGQgLycZZ
	LawAeUEnrkXy9WhV/1fZm7J1KsvI3DwVDBwD3SeIO+YluWbf+1uLAF5HvN3Tag==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 05 May 2026 19:53:11 +0200
Subject: [PATCH v2 10/12] crypto: talitos/hash - remove useless wrapper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-10-5818064bd190@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778003630; l=1260;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=zQ7n1cO+oe/QJS0vhjvTNm0Pm5Gg9UkZrj6GnHdOReI=;
 b=5LA7OBr7bX3QfavYJV5Bu/5zadOvVRh/LtZz79KRoE4IcNWKAqQQzgizxX0ki6QC8+2BRmcfg
 uXt6dqUxlmAAjTsIUSce25G+Cptn/9lvq9ZZ0B7IJDuCdRf6uKQq9dB
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: BA66B4D25F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244247-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

ahash_process_req() was a wrapper used in commit 655ef638a2bc ("crypto:
talitos - fix SEC1 32k ahash request limitation"). Rename

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4fad4e862405..10181f5ee0ec 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2020,7 +2020,7 @@ static int ahash_process_req_prepare(struct ahash_request *areq,
 	return 0;
 }
 
-static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes)
+static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
@@ -2104,11 +2104,6 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	return ret;
 }
 
-static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
-{
-	return ahash_process_req_one(areq, nbytes);
-}
-
 static int ahash_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);

-- 
2.53.0


