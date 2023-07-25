Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC176167F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjGYLju (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjGYLjr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7A19BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700DD6169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F094C433C7;
        Tue, 25 Jul 2023 11:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285185;
        bh=5BrznzGhnrBVpE7x8nBDWPFGkMXS6gt2jkqV5yEw3Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzAOu39LX7QF2hrKXilEeVS1ZkhqJu6GpjAurGA6jMDK/VWqQN5Xb5xSwuNkCEo1W
         PEvE53Pji38l/2+O1SolptimMr2RjcOxcJz3JtvGrcVdZJzSz4A/vMqJqyLKrRuGLl
         QdVP2dSeZR1if92scp/AMCZ7i+dH1zTcnROM83Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/313] crypto: skcipher - remove crypto_has_ablkcipher()
Date:   Tue, 25 Jul 2023 12:44:27 +0200
Message-ID: <20230725104525.956502242@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit cec0cb8a28f9060367099beeafd0dbdb76fdfae2 ]

crypto_has_ablkcipher() has no users, and it does the same thing as
crypto_has_skcipher() anyway.  So remove it.  This also removes the last
user of crypto_skcipher_type() and crypto_skcipher_mask(), so remove
those too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: efbc7764c444 ("crypto: marvell/cesa - Fix type mismatch warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/crypto/api-skcipher.rst |  2 +-
 include/linux/crypto.h                | 31 ---------------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/Documentation/crypto/api-skcipher.rst b/Documentation/crypto/api-skcipher.rst
index 20ba08dddf2ec..55e0851f6fed9 100644
--- a/Documentation/crypto/api-skcipher.rst
+++ b/Documentation/crypto/api-skcipher.rst
@@ -41,7 +41,7 @@ Asynchronous Block Cipher API - Deprecated
    :doc: Asynchronous Block Cipher API
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_free_ablkcipher crypto_has_ablkcipher crypto_ablkcipher_ivsize crypto_ablkcipher_blocksize crypto_ablkcipher_setkey crypto_ablkcipher_reqtfm crypto_ablkcipher_encrypt crypto_ablkcipher_decrypt
+   :functions: crypto_free_ablkcipher crypto_ablkcipher_ivsize crypto_ablkcipher_blocksize crypto_ablkcipher_setkey crypto_ablkcipher_reqtfm crypto_ablkcipher_encrypt crypto_ablkcipher_decrypt
 
 Asynchronous Cipher Request Handle - Deprecated
 -----------------------------------------------
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 0c720a2982ae4..019ddf7596534 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -903,20 +903,6 @@ static inline struct crypto_ablkcipher *__crypto_ablkcipher_cast(
 	return (struct crypto_ablkcipher *)tfm;
 }
 
-static inline u32 crypto_skcipher_type(u32 type)
-{
-	type &= ~CRYPTO_ALG_TYPE_MASK;
-	type |= CRYPTO_ALG_TYPE_BLKCIPHER;
-	return type;
-}
-
-static inline u32 crypto_skcipher_mask(u32 mask)
-{
-	mask &= ~CRYPTO_ALG_TYPE_MASK;
-	mask |= CRYPTO_ALG_TYPE_BLKCIPHER_MASK;
-	return mask;
-}
-
 /**
  * DOC: Asynchronous Block Cipher API
  *
@@ -962,23 +948,6 @@ static inline void crypto_free_ablkcipher(struct crypto_ablkcipher *tfm)
 	crypto_free_tfm(crypto_ablkcipher_tfm(tfm));
 }
 
-/**
- * crypto_has_ablkcipher() - Search for the availability of an ablkcipher.
- * @alg_name: is the cra_name / name or cra_driver_name / driver name of the
- *	      ablkcipher
- * @type: specifies the type of the cipher
- * @mask: specifies the mask for the cipher
- *
- * Return: true when the ablkcipher is known to the kernel crypto API; false
- *	   otherwise
- */
-static inline int crypto_has_ablkcipher(const char *alg_name, u32 type,
-					u32 mask)
-{
-	return crypto_has_alg(alg_name, crypto_skcipher_type(type),
-			      crypto_skcipher_mask(mask));
-}
-
 static inline struct ablkcipher_tfm *crypto_ablkcipher_crt(
 	struct crypto_ablkcipher *tfm)
 {
-- 
2.39.2



