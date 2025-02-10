Return-Path: <stable+bounces-114628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D5A2F087
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C1B1889DDF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F547222566;
	Mon, 10 Feb 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IPK4ZQzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40318230987
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199483; cv=none; b=CuF4u28M8D15hmpZVJNnvfbKPxhjNs2Y8NBIZikQ5DwuAwzZbE+U2/7K16kXI0/XT65wB2tdP3pBwyUZTKC7V1YQ6xSYg7zqPe1WZ5cdxrStYelt+vtx9/NFhDaWW5jIpU7SGDhYRuQdFdDFsoundmZq/d7A//7jxphznPf3CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199483; c=relaxed/simple;
	bh=Hva31U3ZUnI0nw0nlA7tC/FhvxBug9s8i2vhxf3XxBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GRf6p758MbM/D3BM0wuKWpEDT21l669+EAMWtME8a00IwuAvT4OtIwczXVc5ZjY2WLCzOXXnLD4I91sMctaFJR1w3n1sKlT3UsdI2dtaRQwi4+zCrYjf+f17Kj1LYw5OLILeitJOD9enQTkl4t5hVcWiEXbIWlH+jaDGs8B9SwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IPK4ZQzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B86FC4CED1;
	Mon, 10 Feb 2025 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199482;
	bh=Hva31U3ZUnI0nw0nlA7tC/FhvxBug9s8i2vhxf3XxBM=;
	h=Subject:To:Cc:From:Date:From;
	b=IPK4ZQziXMDIlT+xf+dlG6JnlkhcQQKfy9JCanTIeJo/tpCYRw/Kre+gcdIG/CIu7
	 vtC1QKzTCJePSOTbBOHRKxoACdQiiMiTJqGRev/HZnXVd6kRuLpRyTo2h719Ril3qx
	 C8/33ibNR+7Q04yxgzYUmKZtMUNnAPz3/ztFOEFA=
Subject: FAILED: patch "[PATCH] crypto: qce - fix priority to be less than ARMv8 CE" failed to apply to 5.10-stable tree
To: ebiggers@google.com,ardb@kernel.org,bartosz.golaszewski@linaro.org,brgl@bgdev.pl,herbert@gondor.apana.org.au,neil.armstrong@linaro.org,thara.gopinath@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:57:59 +0100
Message-ID: <2025021059-drinking-september-98ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 49b9258b05b97c6464e1964b6a2fddb3ddb65d17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021059-drinking-september-98ee@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49b9258b05b97c6464e1964b6a2fddb3ddb65d17 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Tue, 3 Dec 2024 10:05:53 -0800
Subject: [PATCH] crypto: qce - fix priority to be less than ARMv8 CE

As QCE is an order of magnitude slower than the ARMv8 Crypto Extensions
on the CPU, and is also less well tested, give it a lower priority.
Previously the QCE SHA algorithms had higher priority than the ARMv8 CE
equivalents, and the ciphers such as AES-XTS had the same priority which
meant the QCE versions were chosen if they happened to be loaded later.

Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Cc: stable@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 7d811728f047..97b56e92ea33 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -786,7 +786,7 @@ static int qce_aead_register_one(const struct qce_aead_def *def, struct qce_devi
 	alg->init			= qce_aead_init;
 	alg->exit			= qce_aead_exit;
 
-	alg->base.cra_priority		= 300;
+	alg->base.cra_priority		= 275;
 	alg->base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_ALLOCATES_MEMORY |
 					  CRYPTO_ALG_KERN_DRIVER_ONLY |
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 916908c04b63..c4ddc3b265ee 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -482,7 +482,7 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 
 	base = &alg->halg.base;
 	base->cra_blocksize = def->blocksize;
-	base->cra_priority = 300;
+	base->cra_priority = 175;
 	base->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 	base->cra_ctxsize = sizeof(struct qce_sha_ctx);
 	base->cra_alignmask = 0;
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 5b493fdc1e74..ffb334eb5b34 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -461,7 +461,7 @@ static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
 	alg->encrypt			= qce_skcipher_encrypt;
 	alg->decrypt			= qce_skcipher_decrypt;
 
-	alg->base.cra_priority		= 300;
+	alg->base.cra_priority		= 275;
 	alg->base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_ALLOCATES_MEMORY |
 					  CRYPTO_ALG_KERN_DRIVER_ONLY;


