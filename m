Return-Path: <stable+bounces-172256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACECB30C7F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01D21C2850A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F80728A72F;
	Fri, 22 Aug 2025 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFtd0ndx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78B22578A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833067; cv=none; b=VIMazvZ2Hy8+9z4mEIpebrh+jTlpUZqI3daTm7YcVe2njQi0nn/CoMdDSTWkniAd+C0JmkAYBGC1VL/d5YcF9eu6qXYgy0/ADlcd+WMz51Agdt22zwXo0KZSiMXMw05ZlwuDdEtSkPq0wWkb4tsKSrB7+snsVzYZHDerk9qtlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833067; c=relaxed/simple;
	bh=j6oqfswsGNjd+nQOBzOQ2wVQeEMeOpBW8I1PWWunFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gweVTtJkaqaXCq1AOCtSSa89IR9Vpz7SnuJ0U1Ysy2bnK7FIArdmxsId6R6nvMlC+XRPDzDvL8p4j8I8FsD89l3b40FlZRzvKDGWbULidu6hum2ISoV4OOnPia2mSHJjWup0Obs6ozwkOqStEbEW79/hB+u/KRTKXa/uCg82Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFtd0ndx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045ACC116B1;
	Fri, 22 Aug 2025 03:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833066;
	bh=j6oqfswsGNjd+nQOBzOQ2wVQeEMeOpBW8I1PWWunFP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFtd0ndxTW0DC64yzVPTfNTWSimG6uC4kY1jKsXSnG4miFZVekAXcED+feuiRklkY
	 rLhfPBwLbgkTSvWJ35S5pSybN0f2IrburnHEa3AKXrfIG22oP/Uc1aUUsXk1rQoFWx
	 nh3N56cMU2HL75Yqk6Q0hl07zdIzwpd0z4WU9DcQXWCpneXpPqj+I1GlTw6/i53QhG
	 O9dH02mGFd4MlCN4kv3isUQES91WLSrI5zuqcPp/8j8XORSXQT7NjcqCd8KQ57ZIr7
	 DW5xuHasEdDvnfLNovmgAbx+CKRQdM2kTKReUu+0VebHdLrxckbW5y9wvo5+fVgVMD
	 zMFGRE7vkqA4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] crypto: x86/aegis - Fix sleeping when disallowed on PREEMPT_RT
Date: Thu, 21 Aug 2025 23:24:21 -0400
Message-ID: <20250822032421.1059778-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822032421.1059778-1-sashal@kernel.org>
References: <2025082103-division-stoning-2306@gregkh>
 <20250822032421.1059778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit c7f49dadfcdf27e1f747442e874e9baa52ab7674 ]

skcipher_walk_done() can call kfree(), which takes a spinlock, which
makes it incorrect to call while preemption is disabled on PREEMPT_RT.
Therefore, end the kernel-mode FPU section before calling
skcipher_walk_done(), and restart it afterwards.

Moreover, pass atomic=false to skcipher_walk_aead_encrypt() instead of
atomic=true.  The point of atomic=true was to make skcipher_walk_done()
safe to call while in a kernel-mode FPU section, but that does not
actually work.  So just use the usual atomic=false.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-glue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index e7a28ccf273b..de0aab6997d4 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -123,7 +123,9 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 					   walk->dst.virt.addr,
 					   round_down(walk->nbytes,
 						      AEGIS128_BLOCK_SIZE));
+		kernel_fpu_end();
 		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+		kernel_fpu_begin();
 	}
 
 	if (walk->nbytes) {
@@ -135,7 +137,9 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 			aegis128_aesni_dec_tail(state, walk->src.virt.addr,
 						walk->dst.virt.addr,
 						walk->nbytes);
+		kernel_fpu_end();
 		skcipher_walk_done(walk, 0);
+		kernel_fpu_begin();
 	}
 }
 
@@ -180,9 +184,9 @@ crypto_aegis128_aesni_crypt(struct aead_request *req,
 	struct aegis_state state;
 
 	if (enc)
-		skcipher_walk_aead_encrypt(&walk, req, true);
+		skcipher_walk_aead_encrypt(&walk, req, false);
 	else
-		skcipher_walk_aead_decrypt(&walk, req, true);
+		skcipher_walk_aead_decrypt(&walk, req, false);
 
 	kernel_fpu_begin();
 
-- 
2.50.1


