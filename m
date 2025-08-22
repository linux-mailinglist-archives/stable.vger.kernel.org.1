Return-Path: <stable+bounces-172245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC73B30C2D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD46E1CE5C78
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D865265629;
	Fri, 22 Aug 2025 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTLa9rd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AA263F54
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831984; cv=none; b=ckqW6fXZiNGQ7drvkgcUyQRa0/MI8DGMeIqKWp7qH3vT32iU3Rb79k1TDWt4npyL4KjdBbC8vojdhc58obfZ5DjG+MBPIy5zfR57zRQKhNkuvJZE5cWbB2L2VSHFZTrUXlUrQ6KeTSa9G36xFqK4V7vUELW2V31zqMrLHOTHYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831984; c=relaxed/simple;
	bh=j6oqfswsGNjd+nQOBzOQ2wVQeEMeOpBW8I1PWWunFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s84goRydkXMMvGXv1lWNdUfm4noOkTfA/ON8OqRMMKp+5lJ9wUE0xNxd+5HkhP0heWNAcqyByL8bNlsh+Gz8/JD6u1CWsg3u5EKUzhrJmU1AGdBtXkeu7oV7KFJA97EBYal1WXzR3Ob0BeEpQwPUl5GWicZG5nC9CaZJJ8ZtVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTLa9rd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A705C4CEEB;
	Fri, 22 Aug 2025 03:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831984;
	bh=j6oqfswsGNjd+nQOBzOQ2wVQeEMeOpBW8I1PWWunFP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTLa9rd66aUN1ivbXJciSZvmQab1MicIajC/9oPDubF38lnoVPhvhWshSpP8u3tMI
	 qPGQ9+PAv9S3I+rlXh686OY4ZhiIusuSqSg/DBQFuknVWSA6+fZPCkJ9RBVTsoaW6J
	 X82fi8Fu2NSSqDCuxcxt237Ss0Ob8GzVoSqKTamuFR0t1AI93diT/E6vUbFRgxh/EA
	 RENFeZ5QMr1WN8AIAkuss6vZrh0RdQAjwRAQFZKbF3tiCo3OaMnB7Gg00IfGMisgFQ
	 ft7dloaWFEpM4WB8hB9WKq46IymnZoUdqySeBPB/hKRAGCqNEpsQUdn4p4pxWRmMH6
	 SVD2uqHpdZSqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] crypto: x86/aegis - Fix sleeping when disallowed on PREEMPT_RT
Date: Thu, 21 Aug 2025 23:06:17 -0400
Message-ID: <20250822030617.1053172-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822030617.1053172-1-sashal@kernel.org>
References: <2025082102-shrug-unused-8ce2@gregkh>
 <20250822030617.1053172-1-sashal@kernel.org>
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


