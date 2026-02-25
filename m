Return-Path: <stable+bounces-218150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCFLAUtRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984C18EF85
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5425313C42B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FA21D596;
	Wed, 25 Feb 2026 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnQ3LgIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71656242D9B;
	Wed, 25 Feb 2026 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982933; cv=none; b=huU035hTZMPCDJJvltbRVdwsd1bRVcCrFmc8tGLQcY6UTFZ6JZdGIWo3gL09s6vbqgDjv4UJMiR9EkKhkLYsz9G8/m+7h6fH5rzTGJC0E0OPACf7YO+65XkB8iKMBPt1Dlp6rI40NVSpf+j+knufriHjdxApapaEu5EZdcC8vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982933; c=relaxed/simple;
	bh=1W+MqzRI8ybmeMOw7Sov/ZkMhiAXWTipZRIT71ZhNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5RYyO2H+S4xZZJD7kd0oFE3/fFftAuV7PXY722uZE4QD93NUZ7Q2e7u5YuAP4VeQ9c5HfL3T7v3lvpiIBT9QOO97jkJhWZlGSCLn7C6m46YWs+XegXaDIrUZejHExjXWVGLF75rIqZi5Mvm3rPtaMoex3YGtG27kHYD9oIdfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnQ3LgIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF7C116D0;
	Wed, 25 Feb 2026 01:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982933;
	bh=1W+MqzRI8ybmeMOw7Sov/ZkMhiAXWTipZRIT71ZhNeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnQ3LgIcX4Ajpy6o9xPAadcMulN7A0ilgEncx3Rtm1uB/VmBpWSg85i5Hpwv0V8gt
	 rUJLfC+ekFTW4mRcZTs6b5TcuHmFhFpOOo42/Jg5wjjiJ1YIVzFLMjZOevyap+SBP0
	 yo/Iw9DXqMBC8ycZVwFb3DonybE9kwsZVHCiY3Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 110/781] crypto: inside-secure/eip93 - unregister only available algorithm
Date: Tue, 24 Feb 2026 17:13:39 -0800
Message-ID: <20260225012402.379732058@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218150-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wp.pl,kernel.org,gondor.apana.org.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7984C18EF85
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 0ceeadc7b53a041d89d5843f6bf0ccb7c98b0b4f ]

EIP93 has an options register. This register indicates which crypto
algorithms are implemented in silicon. Supported algorithms are
registered on this basis. Unregister algorithms on the same basis.
Currently, all algorithms are unregistered, even those not supported
by HW. This results in panic on platforms that don't have all options
implemented in silicon.

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Acked-by: Antoine Tenart <atenart@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/inside-secure/eip93/eip93-main.c   | 92 +++++++++++--------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index 3cdc3308dcac8..b7fd9795062d4 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -77,11 +77,44 @@ inline void eip93_irq_clear(struct eip93_device *eip93, u32 mask)
 	__raw_writel(mask, eip93->base + EIP93_REG_INT_CLR);
 }
 
-static void eip93_unregister_algs(unsigned int i)
+static int eip93_algo_is_supported(u32 alg_flags, u32 supported_algo_flags)
+{
+	if ((IS_DES(alg_flags) || IS_3DES(alg_flags)) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_TDES))
+		return 0;
+
+	if (IS_AES(alg_flags) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_AES))
+		return 0;
+
+	if (IS_HASH_MD5(alg_flags) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_MD5))
+		return 0;
+
+	if (IS_HASH_SHA1(alg_flags) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_SHA_1))
+		return 0;
+
+	if (IS_HASH_SHA224(alg_flags) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_SHA_224))
+		return 0;
+
+	if (IS_HASH_SHA256(alg_flags) &&
+	    !(supported_algo_flags & EIP93_PE_OPTION_SHA_256))
+		return 0;
+
+	return 1;
+}
+
+static void eip93_unregister_algs(u32 supported_algo_flags, unsigned int i)
 {
 	unsigned int j;
 
 	for (j = 0; j < i; j++) {
+		if (!eip93_algo_is_supported(eip93_algs[j]->flags,
+					     supported_algo_flags))
+			continue;
+
 		switch (eip93_algs[j]->type) {
 		case EIP93_ALG_TYPE_SKCIPHER:
 			crypto_unregister_skcipher(&eip93_algs[j]->alg.skcipher);
@@ -106,49 +139,27 @@ static int eip93_register_algs(struct eip93_device *eip93, u32 supported_algo_fl
 
 		eip93_algs[i]->eip93 = eip93;
 
-		if ((IS_DES(alg_flags) || IS_3DES(alg_flags)) &&
-		    !(supported_algo_flags & EIP93_PE_OPTION_TDES))
+		if (!eip93_algo_is_supported(alg_flags, supported_algo_flags))
 			continue;
 
-		if (IS_AES(alg_flags)) {
-			if (!(supported_algo_flags & EIP93_PE_OPTION_AES))
-				continue;
+		if (IS_AES(alg_flags) && !IS_HMAC(alg_flags)) {
+			if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY128)
+				eip93_algs[i]->alg.skcipher.max_keysize =
+					AES_KEYSIZE_128;
 
-			if (!IS_HMAC(alg_flags)) {
-				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY128)
-					eip93_algs[i]->alg.skcipher.max_keysize =
-						AES_KEYSIZE_128;
+			if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY192)
+				eip93_algs[i]->alg.skcipher.max_keysize =
+					AES_KEYSIZE_192;
 
-				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY192)
-					eip93_algs[i]->alg.skcipher.max_keysize =
-						AES_KEYSIZE_192;
+			if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY256)
+				eip93_algs[i]->alg.skcipher.max_keysize =
+					AES_KEYSIZE_256;
 
-				if (supported_algo_flags & EIP93_PE_OPTION_AES_KEY256)
-					eip93_algs[i]->alg.skcipher.max_keysize =
-						AES_KEYSIZE_256;
-
-				if (IS_RFC3686(alg_flags))
-					eip93_algs[i]->alg.skcipher.max_keysize +=
-						CTR_RFC3686_NONCE_SIZE;
-			}
+			if (IS_RFC3686(alg_flags))
+				eip93_algs[i]->alg.skcipher.max_keysize +=
+					CTR_RFC3686_NONCE_SIZE;
 		}
 
-		if (IS_HASH_MD5(alg_flags) &&
-		    !(supported_algo_flags & EIP93_PE_OPTION_MD5))
-			continue;
-
-		if (IS_HASH_SHA1(alg_flags) &&
-		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_1))
-			continue;
-
-		if (IS_HASH_SHA224(alg_flags) &&
-		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_224))
-			continue;
-
-		if (IS_HASH_SHA256(alg_flags) &&
-		    !(supported_algo_flags & EIP93_PE_OPTION_SHA_256))
-			continue;
-
 		switch (eip93_algs[i]->type) {
 		case EIP93_ALG_TYPE_SKCIPHER:
 			ret = crypto_register_skcipher(&eip93_algs[i]->alg.skcipher);
@@ -167,7 +178,7 @@ static int eip93_register_algs(struct eip93_device *eip93, u32 supported_algo_fl
 	return 0;
 
 fail:
-	eip93_unregister_algs(i);
+	eip93_unregister_algs(supported_algo_flags, i);
 
 	return ret;
 }
@@ -469,8 +480,11 @@ static int eip93_crypto_probe(struct platform_device *pdev)
 static void eip93_crypto_remove(struct platform_device *pdev)
 {
 	struct eip93_device *eip93 = platform_get_drvdata(pdev);
+	u32 algo_flags;
+
+	algo_flags = readl(eip93->base + EIP93_REG_PE_OPTION_1);
 
-	eip93_unregister_algs(ARRAY_SIZE(eip93_algs));
+	eip93_unregister_algs(algo_flags, ARRAY_SIZE(eip93_algs));
 	eip93_cleanup(eip93);
 }
 
-- 
2.51.0




