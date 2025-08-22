Return-Path: <stable+bounces-172259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75106B30C87
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B653A7E30
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E828AAF9;
	Fri, 22 Aug 2025 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHmZ6r68"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26128AAEE
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833070; cv=none; b=cQwz76H+ynb+uwB0vmX67kj17qbwR/3/ypTgichuaoCaK9hgu5rTl+XE0pRmmtbsRPmn7+jDPVYAISwEpGungZJe/Yd9Yn59dJ9PZIs0m0Q9z9MTJ5oxTR6bjvc5jANMZSlki8BN/x4mCTBIxcf2ac8wS5qKjmTAu19wdenOYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833070; c=relaxed/simple;
	bh=eeYpP3tLhXnld+89n18vgwj30KA7YHjcFhJCcYIFPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO+c0W7azRX9FaO5guYsi6ukAsdfFg7BvQUV0e4S1jn8KLG5QJhqjfmyf4nMsjm3vLHyxvs/Qqjf78cYqA3/ZXbLxYKBhc5iGq2WVqge9eBzvJuXPzXvPqe9r0U/ttqNadoP2d5hJdEm+F2Vplhf0SObR3mYJG9zKPW4D9nRywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHmZ6r68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16817C4CEEB;
	Fri, 22 Aug 2025 03:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833070;
	bh=eeYpP3tLhXnld+89n18vgwj30KA7YHjcFhJCcYIFPXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHmZ6r68G/hfp41F1imaIIzqORnoCEpyF6kMTfTZLyrxArOX/1SSyco6jEPJ9qtIH
	 qBtty+/7ksdOimsh4u2tlJcRLHs+jZeJSITzbzHeh/+zl61XveX3xCUJYVUP61z3sY
	 NF1RziQ/P/0+jrsqcI02WtPvZ7Z+pw58Or/9yrk6J40DpEYkLNl94Drn9PLdA9uaOI
	 nhPGrTDFU+gY9lZAElFaBs/9IjS7S/UaNY6fLfNKA2L6QY9sFq4lV4klcbr5xlbxdQ
	 QR5afuEP7hV5q33OlCfoTtnxBdKPg8IhklrseAHIq7nfwmGdgzOXr8g4Ttr2NJIVbd
	 t0uPA4jsVgePA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] crypto: x86/aegis128 - improve assembly function prototypes
Date: Thu, 21 Aug 2025 23:24:23 -0400
Message-ID: <20250822032426.1059866-3-sashal@kernel.org>
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

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 8da94b300f67240fbd8880d918200aa9046fc398 ]

Adjust the prototypes of the AEGIS assembly functions:

- Use proper types instead of 'void *', when applicable.

- Move the length parameter to after the buffers it describes rather
  than before, to match the usual convention.  Also shorten its name to
  just len (which is the name used in the assembly code).

- Declare register aliases at the beginning of each function rather than
  once per file.  This was necessary because len was moved, but also it
  allows adding some aliases where raw registers were used before.

- Put assoclen and cryptlen in the correct order when declaring the
  finalization function in the .c file.

- Remove the unnecessary "crypto_" prefix.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 3d9eb180fbe8 ("crypto: x86/aegis - Add missing error checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S  | 105 ++++++++++++++++----------
 arch/x86/crypto/aegis128-aesni-glue.c |  92 +++++++++++-----------
 2 files changed, 112 insertions(+), 85 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 639ba6f31a90..6520d0ed9814 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -19,11 +19,6 @@
 #define T0	%xmm6
 #define T1	%xmm7
 
-#define STATEP	%rdi
-#define LEN	%esi
-#define SRC	%rdx
-#define DST	%rcx
-
 .section .rodata.cst16.aegis128_const, "aM", @progbits, 32
 .align 16
 .Laegis128_const_0:
@@ -72,6 +67,8 @@
  *   %r9
  */
 SYM_FUNC_START_LOCAL(__load_partial)
+	.set LEN, %ecx
+	.set SRC, %rsi
 	xor %r9d, %r9d
 	pxor MSG, MSG
 
@@ -138,6 +135,8 @@ SYM_FUNC_END(__load_partial)
  *   %r10
  */
 SYM_FUNC_START_LOCAL(__store_partial)
+	.set LEN, %ecx
+	.set DST, %rdx
 	mov LEN, %r8d
 	mov DST, %r9
 
@@ -184,16 +183,21 @@ SYM_FUNC_START_LOCAL(__store_partial)
 SYM_FUNC_END(__store_partial)
 
 /*
- * void crypto_aegis128_aesni_init(void *state, const void *key, const void *iv);
+ * void aegis128_aesni_init(struct aegis_state *state,
+ *			    const struct aegis_block *key,
+ *			    const u8 iv[AEGIS128_NONCE_SIZE]);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_init)
+SYM_FUNC_START(aegis128_aesni_init)
+	.set STATEP, %rdi
+	.set KEYP, %rsi
+	.set IVP, %rdx
 	FRAME_BEGIN
 
 	/* load IV: */
-	movdqu (%rdx), T1
+	movdqu (IVP), T1
 
 	/* load key: */
-	movdqa (%rsi), KEY
+	movdqa (KEYP), KEY
 	pxor KEY, T1
 	movdqa T1, STATE0
 	movdqa KEY, STATE3
@@ -226,13 +230,16 @@ SYM_FUNC_START(crypto_aegis128_aesni_init)
 
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_init)
+SYM_FUNC_END(aegis128_aesni_init)
 
 /*
- * void crypto_aegis128_aesni_ad(void *state, unsigned int length,
- *                               const void *data);
+ * void aegis128_aesni_ad(struct aegis_state *state, const u8 *data,
+ *			  unsigned int len);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_ad)
+SYM_FUNC_START(aegis128_aesni_ad)
+	.set STATEP, %rdi
+	.set SRC, %rsi
+	.set LEN, %edx
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -378,7 +385,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_ad)
 .Lad_out:
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_ad)
+SYM_FUNC_END(aegis128_aesni_ad)
 
 .macro encrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -399,10 +406,14 @@ SYM_FUNC_END(crypto_aegis128_aesni_ad)
 .endm
 
 /*
- * void crypto_aegis128_aesni_enc(void *state, unsigned int length,
- *                                const void *src, void *dst);
+ * void aegis128_aesni_enc(struct aegis_state *state, const u8 *src, u8 *dst,
+ *			   unsigned int len);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_enc)
+SYM_FUNC_START(aegis128_aesni_enc)
+	.set STATEP, %rdi
+	.set SRC, %rsi
+	.set DST, %rdx
+	.set LEN, %ecx
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -493,13 +504,17 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc)
 .Lenc_out:
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_enc)
+SYM_FUNC_END(aegis128_aesni_enc)
 
 /*
- * void crypto_aegis128_aesni_enc_tail(void *state, unsigned int length,
- *                                     const void *src, void *dst);
+ * void aegis128_aesni_enc_tail(struct aegis_state *state, const u8 *src,
+ *				u8 *dst, unsigned int len);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_START(aegis128_aesni_enc_tail)
+	.set STATEP, %rdi
+	.set SRC, %rsi
+	.set DST, %rdx
+	.set LEN, %ecx
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -533,7 +548,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
 
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_END(aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -553,10 +568,14 @@ SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
 .endm
 
 /*
- * void crypto_aegis128_aesni_dec(void *state, unsigned int length,
- *                                const void *src, void *dst);
+ * void aegis128_aesni_dec(struct aegis_state *state, const u8 *src, u8 *dst,
+ *			   unsigned int len);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_dec)
+SYM_FUNC_START(aegis128_aesni_dec)
+	.set STATEP, %rdi
+	.set SRC, %rsi
+	.set DST, %rdx
+	.set LEN, %ecx
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -647,13 +666,17 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec)
 .Ldec_out:
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_dec)
+SYM_FUNC_END(aegis128_aesni_dec)
 
 /*
- * void crypto_aegis128_aesni_dec_tail(void *state, unsigned int length,
- *                                     const void *src, void *dst);
+ * void aegis128_aesni_dec_tail(struct aegis_state *state, const u8 *src,
+ *				u8 *dst, unsigned int len);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_START(aegis128_aesni_dec_tail)
+	.set STATEP, %rdi
+	.set SRC, %rsi
+	.set DST, %rdx
+	.set LEN, %ecx
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -697,14 +720,18 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_END(aegis128_aesni_dec_tail)
 
 /*
- * void crypto_aegis128_aesni_final(void *state, void *tag_xor,
- *                                  unsigned int assoclen,
- *                                  unsigned int cryptlen);
+ * void aegis128_aesni_final(struct aegis_state *state,
+ *			     struct aegis_block *tag_xor,
+ *			     unsigned int assoclen, unsigned int cryptlen);
  */
-SYM_FUNC_START(crypto_aegis128_aesni_final)
+SYM_FUNC_START(aegis128_aesni_final)
+	.set STATEP, %rdi
+	.set TAG_XOR, %rsi
+	.set ASSOCLEN, %edx
+	.set CRYPTLEN, %ecx
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -715,8 +742,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 	movdqu 0x40(STATEP), STATE4
 
 	/* prepare length block: */
-	movd %edx, MSG
-	pinsrd $2, %ecx, MSG
+	movd ASSOCLEN, MSG
+	pinsrd $2, CRYPTLEN, MSG
 	psllq $3, MSG /* multiply by 8 (to get bit count) */
 
 	pxor STATE3, MSG
@@ -731,7 +758,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 	aegis128_update; pxor MSG, STATE3
 
 	/* xor tag: */
-	movdqu (%rsi), MSG
+	movdqu (TAG_XOR), MSG
 
 	pxor STATE0, MSG
 	pxor STATE1, MSG
@@ -739,8 +766,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 	pxor STATE3, MSG
 	pxor STATE4, MSG
 
-	movdqu MSG, (%rsi)
+	movdqu MSG, (TAG_XOR)
 
 	FRAME_END
 	RET
-SYM_FUNC_END(crypto_aegis128_aesni_final)
+SYM_FUNC_END(aegis128_aesni_final)
diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 9b52451f6fee..e7a28ccf273b 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -23,27 +23,6 @@
 #define AEGIS128_MIN_AUTH_SIZE 8
 #define AEGIS128_MAX_AUTH_SIZE 16
 
-asmlinkage void crypto_aegis128_aesni_init(void *state, void *key, void *iv);
-
-asmlinkage void crypto_aegis128_aesni_ad(
-		void *state, unsigned int length, const void *data);
-
-asmlinkage void crypto_aegis128_aesni_enc(
-		void *state, unsigned int length, const void *src, void *dst);
-
-asmlinkage void crypto_aegis128_aesni_dec(
-		void *state, unsigned int length, const void *src, void *dst);
-
-asmlinkage void crypto_aegis128_aesni_enc_tail(
-		void *state, unsigned int length, const void *src, void *dst);
-
-asmlinkage void crypto_aegis128_aesni_dec_tail(
-		void *state, unsigned int length, const void *src, void *dst);
-
-asmlinkage void crypto_aegis128_aesni_final(
-		void *state, void *tag_xor, unsigned int cryptlen,
-		unsigned int assoclen);
-
 struct aegis_block {
 	u8 bytes[AEGIS128_BLOCK_SIZE] __aligned(AEGIS128_BLOCK_ALIGN);
 };
@@ -56,6 +35,32 @@ struct aegis_ctx {
 	struct aegis_block key;
 };
 
+asmlinkage void aegis128_aesni_init(struct aegis_state *state,
+				    const struct aegis_block *key,
+				    const u8 iv[AEGIS128_NONCE_SIZE]);
+
+asmlinkage void aegis128_aesni_ad(struct aegis_state *state, const u8 *data,
+				  unsigned int len);
+
+asmlinkage void aegis128_aesni_enc(struct aegis_state *state, const u8 *src,
+				   u8 *dst, unsigned int len);
+
+asmlinkage void aegis128_aesni_dec(struct aegis_state *state, const u8 *src,
+				   u8 *dst, unsigned int len);
+
+asmlinkage void aegis128_aesni_enc_tail(struct aegis_state *state,
+					const u8 *src, u8 *dst,
+					unsigned int len);
+
+asmlinkage void aegis128_aesni_dec_tail(struct aegis_state *state,
+					const u8 *src, u8 *dst,
+					unsigned int len);
+
+asmlinkage void aegis128_aesni_final(struct aegis_state *state,
+				     struct aegis_block *tag_xor,
+				     unsigned int assoclen,
+				     unsigned int cryptlen);
+
 static void crypto_aegis128_aesni_process_ad(
 		struct aegis_state *state, struct scatterlist *sg_src,
 		unsigned int assoclen)
@@ -75,15 +80,14 @@ static void crypto_aegis128_aesni_process_ad(
 			if (pos > 0) {
 				unsigned int fill = AEGIS128_BLOCK_SIZE - pos;
 				memcpy(buf.bytes + pos, src, fill);
-				crypto_aegis128_aesni_ad(state,
-							 AEGIS128_BLOCK_SIZE,
-							 buf.bytes);
+				aegis128_aesni_ad(state, buf.bytes,
+						  AEGIS128_BLOCK_SIZE);
 				pos = 0;
 				left -= fill;
 				src += fill;
 			}
 
-			crypto_aegis128_aesni_ad(state, left, src);
+			aegis128_aesni_ad(state, src, left);
 
 			src += left & ~(AEGIS128_BLOCK_SIZE - 1);
 			left &= AEGIS128_BLOCK_SIZE - 1;
@@ -100,7 +104,7 @@ static void crypto_aegis128_aesni_process_ad(
 
 	if (pos > 0) {
 		memset(buf.bytes + pos, 0, AEGIS128_BLOCK_SIZE - pos);
-		crypto_aegis128_aesni_ad(state, AEGIS128_BLOCK_SIZE, buf.bytes);
+		aegis128_aesni_ad(state, buf.bytes, AEGIS128_BLOCK_SIZE);
 	}
 }
 
@@ -110,31 +114,27 @@ crypto_aegis128_aesni_process_crypt(struct aegis_state *state,
 {
 	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
 		if (enc)
-			crypto_aegis128_aesni_enc(
-					state,
-					round_down(walk->nbytes,
-						   AEGIS128_BLOCK_SIZE),
-					walk->src.virt.addr,
-					walk->dst.virt.addr);
+			aegis128_aesni_enc(state, walk->src.virt.addr,
+					   walk->dst.virt.addr,
+					   round_down(walk->nbytes,
+						      AEGIS128_BLOCK_SIZE));
 		else
-			crypto_aegis128_aesni_dec(
-					state,
-					round_down(walk->nbytes,
-						   AEGIS128_BLOCK_SIZE),
-					walk->src.virt.addr,
-					walk->dst.virt.addr);
+			aegis128_aesni_dec(state, walk->src.virt.addr,
+					   walk->dst.virt.addr,
+					   round_down(walk->nbytes,
+						      AEGIS128_BLOCK_SIZE));
 		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
 	}
 
 	if (walk->nbytes) {
 		if (enc)
-			crypto_aegis128_aesni_enc_tail(state, walk->nbytes,
-						       walk->src.virt.addr,
-						       walk->dst.virt.addr);
+			aegis128_aesni_enc_tail(state, walk->src.virt.addr,
+						walk->dst.virt.addr,
+						walk->nbytes);
 		else
-			crypto_aegis128_aesni_dec_tail(state, walk->nbytes,
-						       walk->src.virt.addr,
-						       walk->dst.virt.addr);
+			aegis128_aesni_dec_tail(state, walk->src.virt.addr,
+						walk->dst.virt.addr,
+						walk->nbytes);
 		skcipher_walk_done(walk, 0);
 	}
 }
@@ -186,10 +186,10 @@ crypto_aegis128_aesni_crypt(struct aead_request *req,
 
 	kernel_fpu_begin();
 
-	crypto_aegis128_aesni_init(&state, ctx->key.bytes, req->iv);
+	aegis128_aesni_init(&state, &ctx->key, req->iv);
 	crypto_aegis128_aesni_process_ad(&state, req->src, req->assoclen);
 	crypto_aegis128_aesni_process_crypt(&state, &walk, enc);
-	crypto_aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
+	aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();
 }
-- 
2.50.1


