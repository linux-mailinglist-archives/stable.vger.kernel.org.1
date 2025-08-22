Return-Path: <stable+bounces-172260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED5B30C88
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA4A246A1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D628AAEE;
	Fri, 22 Aug 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4a9n3sA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5128A3EF
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833072; cv=none; b=URFTDHfFXYPmKbwsNJzS9oZaUnLsjtYf/mMpcVsWPvZeRvKNC3g0XUNM17paH75XuISwkhGhKNwQ9WmD0QFKkVNT3EU1Y/SZJ5xpIQ7fOtGBFoknUf/3ulj+VI9l8tow7r4Vw4mtJjRcYfvj5wg2wb5QAfrLC6bxLCOPUumjxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833072; c=relaxed/simple;
	bh=OJiQVymaBOn4NLqSpGUW79Xi+FBsaE5QcITsG19yNEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ros9yfr1ZXct9A2vd01Jku4YdGogJmF9SIVDNK1low3sV6nVlo9Td7SNk0kpnqrEmkfUzvq8MVqbLrkZ77NlUPw+7u6aMOgd34BBcE0Iid/QFSCKRX3IJl1jkmTGIWVnCAmjqNmZMOJ0wCehrmdUcR844ZevQ/npJOyETEw2HGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4a9n3sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECD3C116D0;
	Fri, 22 Aug 2025 03:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833071;
	bh=OJiQVymaBOn4NLqSpGUW79Xi+FBsaE5QcITsG19yNEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4a9n3sAHLQaJxyoOlysh1OIFm1sLr0J5jwcAL9d9+EzrYRFPLNOrDN9Mcvvl1sr4
	 UuIOcRh7X8CwnM9Kj6aNfGFSXPMahYQBAYX8rKdJUWzf13J93giRHTzXQF6Vy4ep7V
	 HgmGhN8hAorzpF9+NWMeC0y9P0WsyxEzU870dXjkaGPpYKIeaZHnvPN54OC6rppR1F
	 woSNiSmLNIVnhcB3VvoozByCxPG+yQ6OKT4Mcl+cHcpg25t3aLT64PuwlLmQwyLUmw
	 Qd5poJfuT336/QRszU0j2LF72EszoS/8PTEN4qDRi+RNCC6rTXI9RqYI41aXJIgTfh
	 Q+sjyPVSAtZvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] crypto: x86/aegis - Fix sleeping when disallowed on PREEMPT_RT
Date: Thu, 21 Aug 2025 23:24:24 -0400
Message-ID: <20250822032426.1059866-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822032426.1059866-1-sashal@kernel.org>
References: <2025082114-egotistic-train-159d@gregkh>
 <20250822032426.1059866-1-sashal@kernel.org>
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
Stable-dep-of: 3d9eb180fbe8 ("crypto: x86/aegis - Add missing error checks")
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


