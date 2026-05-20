Return-Path: <stable+bounces-250314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOhrCjLmDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF330592838
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6924230BC1BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823893191D0;
	Wed, 20 May 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iEbByfTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110636D9E7;
	Wed, 20 May 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295089; cv=none; b=RSVAZhL1LYYv/li5mWM9HRvBUePegff+7Y460Byqjb2yUfR/XCF1Wg3z8XJDz26IKJmS/8lnLMC4I055VbJNiJhUbbhkTEIjopcjTua9TeZji2Fza4eHneV2Lfwqwbdp57RRHThO1m2JO+2iFo0oEHiu4HqLwl8PyArvaSt+080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295089; c=relaxed/simple;
	bh=xSYmPeu40OgATJE8bMk+WhvjI/1fSR742VSJ05frBYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcigVScRx8Dl+RC8q/qksn18PoCg78ARV7bLC7QczYfwpCJBaBuzhq8hxHxZS92S6yEn8LdOYheCHaeMCyF0+sVzPNRc6CYCaPAqPc8jODUPfgbAu6iaKV8yYf0XMy+It7anrTba+BGVuXfJkXTkY39isjwmzi2ify3HQhYBeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iEbByfTt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8771F000E9;
	Wed, 20 May 2026 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295087;
	bh=8iDQx6cGHgr7POun8H1fIsCCiQu4+wAkz5GWSqi1Mdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iEbByfTtLxDP6EqVV4ftoPsxhFR/5/yq2vPi/W+2HsGKxgfb5Ce07Yfw/U8L+9m4g
	 MiO7eleh6g4lL96Glmi7KAsYPHMuAoM6jAh98TAWVvgh8/e8kLpa1aNrdw/+VqAyF3
	 NrEuKKN1wFtBQupJGuN2cavcr59h/ZFHr4ESObME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0285/1146] crypto: inside-secure/eip93 - register hash before authenc algorithms
Date: Wed, 20 May 2026 18:08:55 +0200
Message-ID: <20260520162154.666461599@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250314-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wp.pl,gondor.apana.org.au,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,wp.pl:email,apana.org.au:email]
X-Rspamd-Queue-Id: CF330592838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 5377032914b29b4643adece0ff1dfc67e36700f4 ]

Register hash before hmac and authenc algorithms. This will ensure
selftests pass at startup. Previously, selftests failed on the
crypto_alloc_ahash() function since the associated algorithm was
not yet registered.

Fixes following error:
...
[   18.375811] alg: self-tests for authenc(hmac(sha1),cbc(aes)) using authenc(hmac(sha1-eip93),cbc(aes-eip93)) failed (rc=-2)
[   18.382140] alg: self-tests for authenc(hmac(sha224),rfc3686(ctr(aes))) using authenc(hmac(sha224-eip93),rfc3686(ctr(aes-eip93))) failed (rc=-2)
[   18.395029] alg: aead: authenc(hmac(sha256-eip93),cbc(des-eip93)) setkey failed on test vector 0; expected_error=0, actual_error=-2, flags=0x1
[   18.409734] alg: aead: authenc(hmac(md5-eip93),cbc(des3_ede-eip93)) setkey failed on test vector 0; expected_error=0, actual_error=-2, flags=0x1
...

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/inside-secure/eip93/eip93-main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index b7fd9795062d4..76858bb4fcc22 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -36,6 +36,14 @@ static struct eip93_alg_template *eip93_algs[] = {
 	&eip93_alg_cbc_aes,
 	&eip93_alg_ctr_aes,
 	&eip93_alg_rfc3686_aes,
+	&eip93_alg_md5,
+	&eip93_alg_sha1,
+	&eip93_alg_sha224,
+	&eip93_alg_sha256,
+	&eip93_alg_hmac_md5,
+	&eip93_alg_hmac_sha1,
+	&eip93_alg_hmac_sha224,
+	&eip93_alg_hmac_sha256,
 	&eip93_alg_authenc_hmac_md5_cbc_des,
 	&eip93_alg_authenc_hmac_sha1_cbc_des,
 	&eip93_alg_authenc_hmac_sha224_cbc_des,
@@ -52,14 +60,6 @@ static struct eip93_alg_template *eip93_algs[] = {
 	&eip93_alg_authenc_hmac_sha1_rfc3686_aes,
 	&eip93_alg_authenc_hmac_sha224_rfc3686_aes,
 	&eip93_alg_authenc_hmac_sha256_rfc3686_aes,
-	&eip93_alg_md5,
-	&eip93_alg_sha1,
-	&eip93_alg_sha224,
-	&eip93_alg_sha256,
-	&eip93_alg_hmac_md5,
-	&eip93_alg_hmac_sha1,
-	&eip93_alg_hmac_sha224,
-	&eip93_alg_hmac_sha256,
 };
 
 inline void eip93_irq_disable(struct eip93_device *eip93, u32 mask)
-- 
2.53.0




