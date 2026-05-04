Return-Path: <stable+bounces-243861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGrlDh6++Glz0QIAu9opvQ
	(envelope-from <stable+bounces-243861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:41:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A54C0D21
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193A73044826
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920603E0C60;
	Mon,  4 May 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hE2n0h+h"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9543E0C40
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909184; cv=none; b=agr54Ge44hkK7ndDvMo932EOuQApzd8k7h1YtFWjgjkSInaQyBAaT4e9Zk5HiYeMhMl9vnyRRqJD+TbYR5nC4Ynt8vAYTlRXVDAhF6KOWRQ4+kE+0Jfi13AXxanqBakjiYGcdpyLILYczeWXzWBRaxIfpHO/5kAAnuvQX+WsyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909184; c=relaxed/simple;
	bh=wXA66UJbIpzCtYdtcAzvfSpEKu6C0MJtApWKi6F4YDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKEyjSOjNOSqNmTy3WDI/uedKn9U9M7H7tSEUb/SJ8kXLNqePE1va3e+uLjFmMRLbzKioUBZyF+0z7Mkw5tVdGni9jyAZZO9MURCXpawOOwL8u5LYTNlo90QQDS77WKo9AjYFg4c/fVMUkHIEKuyrSV7vTLJlnDco+z/c1T69cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hE2n0h+h; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 491284E42BBB;
	Mon,  4 May 2026 15:39:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F7F45FD5F;
	Mon,  4 May 2026 15:39:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77AA611AD2BCD;
	Mon,  4 May 2026 17:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777909180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uvBvHYQc9incdS4pyRWWg39JHb2lfMzCeMd1O03d4MU=;
	b=hE2n0h+h8wPjrWHv0ilOuElgq3KHEGllQ0NiWDSwf7ced0kGiaHaeP65NtB21xt9+ITwSW
	e7iOa91bcUwyjlKsuUJi159XmjoZcRvdRahgPA0ZWxUt/uuVRF5JwycGPDXIdYii7ssFDw
	NQLRVrjC1CgzcXOlS723LFh9X0vyi+DRdASzQfjEORdVXs2u2ayxDQdbb1ammNwFARkQfV
	JMPMJ7dYvAAvK1Prz2oVpEsspm8+pn7v9IWuBK8kzvcZk1AsrUVq0VBdaOx6yyWDzWTHSe
	zA+EuZjaWUzv8OKJVj6dlSgSqACmfIiU9FwTC9xeUXFzLGZ+xsTdICqRMjS1vQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 04 May 2026 17:38:29 +0200
Subject: [PATCH 3/4] crypto: talitos - remove useless wrapper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-3-c97c641976f5@bootlin.com>
References: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com>
In-Reply-To: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909177; l=1332;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=wXA66UJbIpzCtYdtcAzvfSpEKu6C0MJtApWKi6F4YDw=;
 b=8ca7UXY81DLfirE2MjD+496dbqAgpBfv/+Z7OYhyOE5WBf6N5LvBWIr0o+IbYYSW89QlqfNxQ
 OmVT20gym0fD5mhm+Le0WyX5J49pIUQ7hPHZRnDkxR+F/6W+/1v9vMq
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9C5A54C0D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

ahash_process_req() was a wrapper used in commit 655ef638a2bc ("crypto:
talitos - fix SEC1 32k ahash request limitation"). Rename
ahash_process_req_one() to ahash_process_req() and remove the wrapper.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 6ada42d8aa32..8d063ad5639c 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2061,7 +2061,7 @@ static int ahash_process_req_prepare(struct ahash_request *areq,
 	return 0;
 }
 
-static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes)
+static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
@@ -2147,11 +2147,6 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
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


