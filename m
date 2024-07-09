Return-Path: <stable+bounces-58443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8AB92B708
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72444B25C3A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0052156F37;
	Tue,  9 Jul 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohXZZ2QQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E413A25F;
	Tue,  9 Jul 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523950; cv=none; b=t7SqZW1XBla/bUMcq3fBTf6AsKjGbAFuOtSBbweXCzLvX2rNuH0ku6/L7Qkm1hpWMpAI6lkHXvVmS6CH+R9hhF2YmH9Je7zPEF3fI24bE/l4AhkuCh2vp62UqOk0bajvBKXKsRkElWCLMhWL1c3SJvXZhOfiLy2ebiONyWQJCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523950; c=relaxed/simple;
	bh=Y7tpYwG//2G6kJlFIdWXPKSzCEyvMP+LRWH367b8yVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWFusBcNIAUq/x+KldeiIci/Pdu+Tct3ifBocxvHNqh3tLAZCEOvZ8PJqbegGk/ItVgryGWPvwFMjDilcf4EL9Jort35jDgNC0P0oMc8Xaz5bd8MFLV2K0BOlTEeSPHdsJ1sYV4oc+CpUYqIJxMMqI+3MBGvzfevw94VEz4FdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohXZZ2QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C89CC3277B;
	Tue,  9 Jul 2024 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523950;
	bh=Y7tpYwG//2G6kJlFIdWXPKSzCEyvMP+LRWH367b8yVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohXZZ2QQvnI2uIYQOe0Wpm7FXklv0rJXeozyS4dfvxLapUOk/RyWSCki/iWzBmLqL
	 35/Jms3erBGdWW1HiHgOiErW4YInMwFEh/f/6jOyK6ucVv+nLUX6+M/FLJgwIJI8Tw
	 x5k7trzMUq9XMPG0KOSgFtJSNhBheNMSoihZ63Oc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hailey Mothershead <hailmo@amazon.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 022/197] crypto: aead,cipher - zeroize key buffer after use
Date: Tue,  9 Jul 2024 13:07:56 +0200
Message-ID: <20240709110709.774636435@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hailey Mothershead <hailmo@amazon.com>

[ Upstream commit 23e4099bdc3c8381992f9eb975c79196d6755210 ]

I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
cryptographic information should be zeroized once they are no longer
needed. Accomplish this by using kfree_sensitive for buffers that
previously held the private key.

Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/aead.c   | 3 +--
 crypto/cipher.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 54906633566a2..5f3c1954d8e5d 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -45,8 +45,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 47c77a3e59783..40cae908788ec 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -34,8 +34,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 
 }
-- 
2.43.0




