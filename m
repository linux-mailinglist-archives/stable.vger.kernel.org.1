Return-Path: <stable+bounces-15936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A398A83E4CA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA9F1C222BA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD32250EC;
	Fri, 26 Jan 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TflUlOTN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4BB1805E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306947; cv=none; b=QW4aSQAhKjahDU6/Z5JZoqf3NOO0L7HmDjYcGP0PG3Vwn/S6LskRMakF/e+P8uPCoYvk4eS0PzcYWBrTrrKoUE/nV8XvV3Z44CD6Qmi6e9XzmTXzYa8QPKsgkHqyHTvZQOqu39tKyXIHTXw2iy1ess51RAaEJ4cB/MeukahoBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306947; c=relaxed/simple;
	bh=sO2AWpHoBPGTmbHN8BTZyxbNEuCAvBXemH7P4wFdL48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AWr5DXbqKk11Bj5ZxR50d5R9gYdqOlwmQ0trUe4njjSu/Q2O0iizpYPmISfyVa2yjqpOc6hzCcIgLhGGxgI31QZrDlTe866yyR8DRpwQhljJLBdfg95HHiTMLLA/dxWrLMUHO9mwdX6RgB3ftdx46TGxQuYp49Okkk3LjNVbnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TflUlOTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C1DC433C7;
	Fri, 26 Jan 2024 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706306947;
	bh=sO2AWpHoBPGTmbHN8BTZyxbNEuCAvBXemH7P4wFdL48=;
	h=Subject:To:Cc:From:Date:From;
	b=TflUlOTNEo9plv4dQOrtXOEXXrcQuLl7r72nXQRLLzhKDuR8Tc2HSBIXs1zGfxJfE
	 Yu4Ap130qHt6CCqiP3xoUAXNhCRPSGfdq3tsR0OMk/mRtT+0QH+hnoy0PdnKpVTWcV
	 ZcpWDfZhpMkxn78tUTk+L8f0WA0SSSZb9FazOFXM=
Subject: FAILED: patch "[PATCH] crypto: s390/aes - Fix buffer overread in CTR mode" failed to apply to 5.4-stable tree
To: herbert@gondor.apana.org.au,freude@de.ibm.com,guazhang@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:09:06 -0800
Message-ID: <2024012606-embargo-jumble-fa16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d07f951903fa9922c375b8ab1ce81b18a0034e3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012606-embargo-jumble-fa16@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d07f951903fa ("crypto: s390/aes - Fix buffer overread in CTR mode")
6f3196b74d64 ("s390/crypto: Rework on paes implementation")
674f368a952c ("crypto: remove CRYPTO_TFM_RES_BAD_KEY_LEN")
5c925e8b10a5 ("crypto: remove CRYPTO_TFM_RES_BAD_BLOCK_LEN")
f9d89b853ec1 ("crypto: remove unused tfm result flags")
b828f905904c ("crypto: artpec6 - return correct error code for failed setkey()")
bd56cea012fc ("crypto: chelsio - fix writing tfm flags to wrong place")
e8cfed5e4e2b ("crypto: cipher - remove crt_u.cipher (struct cipher_tfm)")
c441a909c686 ("crypto: compress - remove crt_u.compress (struct compress_tfm)")
2edf86414b66 ("crypto: sun4i-ss - hide the Invalid keylen message")
d63007eb954e ("crypto: ablkcipher - remove deprecated and unused ablkcipher support")
7fe948a52287 ("crypto: qat - switch to skcipher API")
373960d794d2 ("crypto: talitos - switch to skcipher API")
ce0183cb6464 ("crypto: rockchip - switch to skcipher API")
23a6564a6b51 ("crypto: niagara2 - switch to skcipher API")
b3cde6bab4e8 ("crypto: picoxcell - switch to skcipher API")
c2609391f95b ("crypto: mediatek - switch to skcipher API")
7cea6d3e01c2 ("crypto: chelsio - switch to skcipher API")
ac0d3d130f90 ("crypto: cavium/cpt - switch to skcipher API")
a9c01cd608c4 ("crypto: bcm-spu - switch to skcipher API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d07f951903fa9922c375b8ab1ce81b18a0034e3b Mon Sep 17 00:00:00 2001
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 28 Nov 2023 14:22:13 +0800
Subject: [PATCH] crypto: s390/aes - Fix buffer overread in CTR mode

When processing the last block, the s390 ctr code will always read
a whole block, even if there isn't a whole block of data left.  Fix
this by using the actual length left and copy it into a buffer first
for processing.

Fixes: 0200f3ecc196 ("crypto: s390 - add System z hardware support for CTR mode")
Cc: <stable@vger.kernel.org>
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewd-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index c773820e4af9..c6fe5405de4a 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -597,7 +597,9 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
-		cpacf_kmctr(sctx->fc, sctx->key, buf, walk.src.virt.addr,
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
+		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
 			    AES_BLOCK_SIZE, walk.iv);
 		memcpy(walk.dst.virt.addr, buf, nbytes);
 		crypto_inc(walk.iv, AES_BLOCK_SIZE);
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 8b541e44151d..55ee5567a5ea 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -693,9 +693,11 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
 		while (1) {
 			if (cpacf_kmctr(ctx->fc, &param, buf,
-					walk.src.virt.addr, AES_BLOCK_SIZE,
+					buf, AES_BLOCK_SIZE,
 					walk.iv) == AES_BLOCK_SIZE)
 				break;
 			if (__paes_convert_key(ctx))


