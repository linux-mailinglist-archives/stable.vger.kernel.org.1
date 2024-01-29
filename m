Return-Path: <stable+bounces-17002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C2840F68
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C991C23191
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DB1649C5;
	Mon, 29 Jan 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eiFzEYLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7E1649C3;
	Mon, 29 Jan 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548437; cv=none; b=SAHIsJ37pvG5IygYyz1treLOMnFJ2c8utTyFviDlfI2nrCV1zE43BcBCzkst/d/f2vHNYfTtsaTUeUkbdWY7LGwcSK8GgYXX2F4lTom94akEXr1mqrRqjFZ7w3rMojmqFJIHro9OkYEUnDMUhPRfED2r2lgrdr9Ajkh3FU64yJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548437; c=relaxed/simple;
	bh=cDOK/pmUtlICXxkVCUWcOmewXtZDLl260RCcmOI/2ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD4p72pMFv+I6wqRwt+YK60VH2twZcPrcLaO4HoranEpKJkGx2y2v7ABOl9Ww0oVig6qvPBVlJmyh5q3gU5OJpWadBnRJ4ybb/LGtlBviB2CUhXy0gcz+uFLTgulNPypvJyrwiFDYuZ2Ys/vHYD4A8KfUTNhTAizE4SXPiFJo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eiFzEYLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F410C43390;
	Mon, 29 Jan 2024 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548437;
	bh=cDOK/pmUtlICXxkVCUWcOmewXtZDLl260RCcmOI/2ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiFzEYLf/KolYJMo7Y/g4vlRWMWqX0rWJEbJ9AVG2hCmeh+K6GnuKcV7hasQHZWll
	 8IYNOhyt1oSCs+XsMFL3meAXgTWAtHe3tc31AZWkzLtK6+EdmIl5XUmq1QQGZER0f0
	 M3wPeSTFGPvjQ+7wwegsIBzD5g70EydH/QYREWHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangwu Zhang <guazhang@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Harald Freudenberger <freude@de.ibm.com>
Subject: [PATCH 6.6 042/331] crypto: s390/aes - Fix buffer overread in CTR mode
Date: Mon, 29 Jan 2024 09:01:46 -0800
Message-ID: <20240129170016.171477207@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit d07f951903fa9922c375b8ab1ce81b18a0034e3b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/aes_s390.c  |    4 +++-
 arch/s390/crypto/paes_s390.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -597,7 +597,9 @@ static int ctr_aes_crypt(struct skcipher
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
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -693,9 +693,11 @@ static int ctr_paes_crypt(struct skciphe
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



