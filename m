Return-Path: <stable+bounces-81701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4B9948E1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C1F1C2034E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C611DED64;
	Tue,  8 Oct 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNmnr5fz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681371DED55;
	Tue,  8 Oct 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389845; cv=none; b=ABXJ/54W2/id/8nWuaghWhLgSJfx7ohTJ51pNpphvXuJSNZbG7K8uCybzIfwwMHpktQCfukpye4ZamEFQd2s/5gTTHLVMDEamg8O75w/Ca+YUGeQpKciNELsfUmdH3dDUBnzbhkc+wuLe/5wb663zrk5oNrqWEk5LuFmIYEEVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389845; c=relaxed/simple;
	bh=7ltnt/ZZdMhKP3RuecdaCbsNSB0GBsFLoEqSwcpZe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnN4iBj8d5z5NOXmUW8UnSrPlcD6Rp+RLPcPbOD4Z4TbMBS7HoPhDHoqzdkoLP4WIRZXRDbtLqWSp1PdaQXdBw4QykGJRw9pT/4fgwXkcHTW/KjOW+wAi7aFb21T6HyBQRIzx27kh8b9ru3nBxSL/lLghLno+g38t/y5DvK7M/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNmnr5fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E294BC4CEC7;
	Tue,  8 Oct 2024 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389845;
	bh=7ltnt/ZZdMhKP3RuecdaCbsNSB0GBsFLoEqSwcpZe0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNmnr5fz456NVtE8eqJpR26dY5CF46vJV8R51LHh4SQj9/pASKuQJ/h56Huwjy/ta
	 uGx0bFR6wG9oUEXyQkDy16gWHxVYl73zn+mZJ5SKcd+kmMJH1fRnf+J/urjAIuTLu5
	 y77+kzw6pMCQhhHus0YZJJwV2GQkXXK+Llqduqy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 113/482] crypto: simd - Do not call crypto_alloc_tfm during registration
Date: Tue,  8 Oct 2024 14:02:56 +0200
Message-ID: <20241008115652.755167274@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 3c44d31cb34ce4eb8311a2e73634d57702948230 ]

Algorithm registration is usually carried out during module init,
where as little work as possible should be carried out.  The SIMD
code violated this rule by allocating a tfm, this then triggers a
full test of the algorithm which may dead-lock in certain cases.

SIMD is only allocating the tfm to get at the alg object, which is
in fact already available as it is what we are registering.  Use
that directly and remove the crypto_alloc_tfm call.

Also remove some obsolete and unused SIMD API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/aes-ce-glue.c     |  2 +-
 arch/arm/crypto/aes-neonbs-glue.c |  2 +-
 crypto/simd.c                     | 76 ++++++-------------------------
 include/crypto/internal/simd.h    | 12 +----
 4 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index b668c97663ec0..f5b66f4cf45d9 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -711,7 +711,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/arch/arm/crypto/aes-neonbs-glue.c b/arch/arm/crypto/aes-neonbs-glue.c
index f00f042ef3570..0ca94b90bc4ec 100644
--- a/arch/arm/crypto/aes-neonbs-glue.c
+++ b/arch/arm/crypto/aes-neonbs-glue.c
@@ -539,7 +539,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/crypto/simd.c b/crypto/simd.c
index edaa479a1ec5e..d109866641a26 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -136,27 +136,19 @@ static int simd_skcipher_init(struct crypto_skcipher *tfm)
 	return 0;
 }
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename)
 {
 	struct simd_skcipher_alg *salg;
-	struct crypto_skcipher *tfm;
-	struct skcipher_alg *ialg;
 	struct skcipher_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_skcipher(basename, CRYPTO_ALG_INTERNAL,
-				    CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_skcipher_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -195,30 +187,16 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_skcipher(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(simd_skcipher_create_compat);
 
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_skcipher_create_compat(algname, drvname, basename);
-}
-EXPORT_SYMBOL_GPL(simd_skcipher_create);
-
 void simd_skcipher_free(struct simd_skcipher_alg *salg)
 {
 	crypto_unregister_skcipher(&salg->alg);
@@ -246,7 +224,7 @@ int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
@@ -383,27 +361,19 @@ static int simd_aead_init(struct crypto_aead *tfm)
 	return 0;
 }
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename)
+static struct simd_aead_alg *simd_aead_create_compat(struct aead_alg *ialg,
+						     const char *algname,
+						     const char *drvname,
+						     const char *basename)
 {
 	struct simd_aead_alg *salg;
-	struct crypto_aead *tfm;
-	struct aead_alg *ialg;
 	struct aead_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_aead(basename, CRYPTO_ALG_INTERNAL,
-				CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_aead_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -442,36 +412,20 @@ struct simd_aead_alg *simd_aead_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_aead(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
-}
-EXPORT_SYMBOL_GPL(simd_aead_create_compat);
-
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_aead_create_compat(algname, drvname, basename);
+	goto out;
 }
-EXPORT_SYMBOL_GPL(simd_aead_create);
 
-void simd_aead_free(struct simd_aead_alg *salg)
+static void simd_aead_free(struct simd_aead_alg *salg)
 {
 	crypto_unregister_aead(&salg->alg);
 	kfree(salg);
 }
-EXPORT_SYMBOL_GPL(simd_aead_free);
 
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs)
@@ -493,7 +447,7 @@ int simd_register_aeads_compat(struct aead_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_aead_create_compat(algname, drvname, basename);
+		simd = simd_aead_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
diff --git a/include/crypto/internal/simd.h b/include/crypto/internal/simd.h
index d2316242a9884..be97b97a75dd2 100644
--- a/include/crypto/internal/simd.h
+++ b/include/crypto/internal/simd.h
@@ -14,11 +14,10 @@
 struct simd_skcipher_alg;
 struct skcipher_alg;
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename);
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename);
 void simd_skcipher_free(struct simd_skcipher_alg *alg);
 
 int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
@@ -32,13 +31,6 @@ void simd_unregister_skciphers(struct skcipher_alg *algs, int count,
 struct simd_aead_alg;
 struct aead_alg;
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename);
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename);
-void simd_aead_free(struct simd_aead_alg *alg);
-
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs);
 
-- 
2.43.0




