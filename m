Return-Path: <stable+bounces-103376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0899EF795
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECAA176F77
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A66215762;
	Thu, 12 Dec 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+l6Ap6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1077211493;
	Thu, 12 Dec 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024381; cv=none; b=Bk7KkHWUCd9AqDCsRd71aATF2Jepa4bWcQ3GuF2hJ3pUAVjzQY2Dy9T4TQ8vIX7HmnvYLZeMKc3sAbVyFGy5JjfWaYgFaM8vqtQn642Y4gI8QNG1y7C5tBDrc1U6kRb5t3C7RBRTdQUkR0HFNn6nnPD300R70i7rrmpPJJee0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024381; c=relaxed/simple;
	bh=QJVG5Q6AY6P47JT+P3GmIu2InHHD4VGtVdFBsQtOejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYt/Y/c0KDfLie5K3q6dN3bvuqi3x5O3RUkKsdlehV+YchfXujfLbK+TjZ1zz6Sx1KllaJMMFFDFdQoGi7g16BQ7JkpeSdqYVGThUG+9UWnzwzRddy3+upkg23NDwwdvT4dn9MXBUgBOBcfRKzvfGX/5qJHn29jC1OeM6+frCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+l6Ap6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56058C4CED0;
	Thu, 12 Dec 2024 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024381;
	bh=QJVG5Q6AY6P47JT+P3GmIu2InHHD4VGtVdFBsQtOejE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+l6Ap6oN8v2qIHLkgC7PJwXZq7GwpfMu6dCOaO5vbgrRCLgMMiJvDIzxwKZOz/jl
	 mrRMalsb3iT/ROyu6CEY08YsTLdsof9DnYKTD7rxhgBdgfsq3IHAgP0vsM1zas3NG2
	 /78BpGnpMW1Y3i8Jj4/lHVAzvpREw+3vl9VrMDeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 250/459] crypto: x86/aegis128 - access 32-bit arguments as 32-bit
Date: Thu, 12 Dec 2024 15:59:48 +0100
Message-ID: <20241212144303.468512767@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 3b2f2d22fb424e9bebda4dbf6676cbfc7f9f62cd upstream.

Fix the AEGIS assembly code to access 'unsigned int' arguments as 32-bit
values instead of 64-bit, since the upper bits of the corresponding
64-bit registers are not guaranteed to be zero.

Note: there haven't been any reports of this bug actually causing
incorrect behavior.  Neither gcc nor clang guarantee zero-extension to
64 bits, but zero-extension is likely to happen in practice because most
instructions that operate on 32-bit registers zero-extend to 64 bits.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: stable@vger.kernel.org
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -20,7 +20,7 @@
 #define T1	%xmm7
 
 #define STATEP	%rdi
-#define LEN	%rsi
+#define LEN	%esi
 #define SRC	%rdx
 #define DST	%rcx
 
@@ -75,32 +75,32 @@ SYM_FUNC_START_LOCAL(__load_partial)
 	xor %r9d, %r9d
 	pxor MSG, MSG
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x1, %r8
 	jz .Lld_partial_1
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x1E, %r8
 	add SRC, %r8
 	mov (%r8), %r9b
 
 .Lld_partial_1:
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x2, %r8
 	jz .Lld_partial_2
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x1C, %r8
 	add SRC, %r8
 	shl $0x10, %r9
 	mov (%r8), %r9w
 
 .Lld_partial_2:
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x4, %r8
 	jz .Lld_partial_4
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x18, %r8
 	add SRC, %r8
 	shl $32, %r9
@@ -110,11 +110,11 @@ SYM_FUNC_START_LOCAL(__load_partial)
 .Lld_partial_4:
 	movq %r9, MSG
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x8, %r8
 	jz .Lld_partial_8
 
-	mov LEN, %r8
+	mov LEN, %r8d
 	and $0x10, %r8
 	add SRC, %r8
 	pslldq $8, MSG
@@ -138,7 +138,7 @@ SYM_FUNC_END(__load_partial)
  *   %r10
  */
 SYM_FUNC_START_LOCAL(__store_partial)
-	mov LEN, %r8
+	mov LEN, %r8d
 	mov DST, %r9
 
 	movq T0, %r10
@@ -676,7 +676,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec
 	call __store_partial
 
 	/* mask with byte count: */
-	movq LEN, T0
+	movd LEN, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
@@ -701,7 +701,8 @@ SYM_FUNC_END(crypto_aegis128_aesni_dec_t
 
 /*
  * void crypto_aegis128_aesni_final(void *state, void *tag_xor,
- *                                  u64 assoclen, u64 cryptlen);
+ *                                  unsigned int assoclen,
+ *                                  unsigned int cryptlen);
  */
 SYM_FUNC_START(crypto_aegis128_aesni_final)
 	FRAME_BEGIN
@@ -714,8 +715,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_fin
 	movdqu 0x40(STATEP), STATE4
 
 	/* prepare length block: */
-	movq %rdx, MSG
-	movq %rcx, T0
+	movd %edx, MSG
+	movd %ecx, T0
 	pslldq $8, T0
 	pxor T0, MSG
 	psllq $3, MSG /* multiply by 8 (to get bit count) */



