Return-Path: <stable+bounces-172250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E635B30C40
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E1B17C8CA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A65266EF1;
	Fri, 22 Aug 2025 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDxg3S84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB5266584
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831998; cv=none; b=dB5gV0/f4FlJrOXG11LdjIVtmyCNL9suaEQd8oUoaJQBt5mzik7a5P/fpn+YTkEkFxgGupYK0QPqM9FOqOTUyU2MljkTiarF1xqJtS71scfzrQOF1odiPR5xAo/EYTVd11pvJoN0vMDnmKfgKm3O5/C81Qp/RILe7/Xfgr8sWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831998; c=relaxed/simple;
	bh=OJiQVymaBOn4NLqSpGUW79Xi+FBsaE5QcITsG19yNEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3o10nGDRUBITCIj1KLefMjFk3nQJ+CbM4Kh/7+fLHUlNTzoOYUtyHYX7UUQtTGYRJQKppOxNl9CkXRG90k8FXDTKYG+cG+9OeD4zNvdnN3KotgKQAAvRLV5baaoQjmsGuUG8A1oIyLxjwFwJ/LssYvquxh2H5Fi6oll6qZNKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDxg3S84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62642C113D0;
	Fri, 22 Aug 2025 03:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831996;
	bh=OJiQVymaBOn4NLqSpGUW79Xi+FBsaE5QcITsG19yNEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDxg3S84yj8VFL8X4TajFDM+dF8psJLUaWrsSY6n9xaRao00w1CilCEaThVMFMwJO
	 HcLJQsUHRZ9JuEfJVEy8RecomQhc1MC3vzbjLhMQBtSFNbqqOlK66Lq3LOW1MZm/uE
	 Yi4+1DJTbFDDihiKJCE/ZWgyuDZPboGL0bet6mL6+/rWH2vkCtyGJtDHWLDzXfdZ+W
	 /x/fLDBfzYUrEmjkGMCfQi4ZjuoZa98vDwU0TIlA5ns0zm3umn/mysBoS/mdZEeMrx
	 FGxk8PEv6ok1lpxTWFM4GMKZG84EuaAn+5+yaLJsxdP/CPZIdIaIA6s9Se0jm4yBpX
	 w6WlU/3l5/QFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] crypto: x86/aegis - Fix sleeping when disallowed on PREEMPT_RT
Date: Thu, 21 Aug 2025 23:06:31 -0400
Message-ID: <20250822030632.1053504-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822030632.1053504-1-sashal@kernel.org>
References: <2025082114-proofs-slideshow-5515@gregkh>
 <20250822030632.1053504-1-sashal@kernel.org>
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


