Return-Path: <stable+bounces-96073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EF9E0731
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03CA171544
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8D205E36;
	Mon,  2 Dec 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPAYUAj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFD205E25
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151831; cv=none; b=FqWdR1ElN76vcbS89Myn33PQXOTAXXE7GfDUeAQesX0yTGR85+J2hb4GbPYSTDZZgsyjUnJB/wMmMd/dW5KusnU5flETVtCg/XTOuijsh5ePSaJ4rx7RpFQjz6eqYOBCJanJ7FiLQxxE42lpwSl7Q/5mjnlthF6jsINGC7ANDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151831; c=relaxed/simple;
	bh=+PMtu0MM0I5/rIlBn6MetpnXspi4vkXtt18xPN6qmac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sPMzVONUkaQJ7iohcKOo6OL2o7UjD43AZEvSBuyhCTUtaV2y7cxPn1F1UrfCO0RWj+0jt4I82b5JCZBhzWELYDclx2Gfn+LWtfXusgygVdGo1IaER4JadvOfCVNPptmr/6Mg8YmmhFGP6HnC9NyLYK2kXUDLdWlilo1JAirPwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPAYUAj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4013BC4CED6;
	Mon,  2 Dec 2024 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151830;
	bh=+PMtu0MM0I5/rIlBn6MetpnXspi4vkXtt18xPN6qmac=;
	h=Subject:To:Cc:From:Date:From;
	b=fPAYUAj78nCm4QnMLdARwVG/H3JMerj/n2st0o6AXF77yntsY0tVb9MERDKd3IWMS
	 27yoUyvkQ2vJrOBrtuqnBM/dSgpK4KA+RBpZ8jnkx7yTHt9Xy9sZHMPTlvSmMx+mCW
	 +0AAAFFu/4QTdZ/h8xulfiY26prdFgL720h1f3C8=
Subject: FAILED: patch "[PATCH] crypto: x86/aegis128 - access 32-bit arguments as 32-bit" failed to apply to 4.19-stable tree
To: ebiggers@google.com,herbert@gondor.apana.org.au,omosnace@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:03:39 +0100
Message-ID: <2024120239-stung-preteen-1a68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3b2f2d22fb424e9bebda4dbf6676cbfc7f9f62cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120239-stung-preteen-1a68@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b2f2d22fb424e9bebda4dbf6676cbfc7f9f62cd Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Wed, 16 Oct 2024 17:00:42 -0700
Subject: [PATCH] crypto: x86/aegis128 - access 32-bit arguments as 32-bit

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

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index ad7f4c891625..2de859173940 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -21,7 +21,7 @@
 #define T1	%xmm7
 
 #define STATEP	%rdi
-#define LEN	%rsi
+#define LEN	%esi
 #define SRC	%rdx
 #define DST	%rcx
 
@@ -76,32 +76,32 @@ SYM_FUNC_START_LOCAL(__load_partial)
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
@@ -111,11 +111,11 @@ SYM_FUNC_START_LOCAL(__load_partial)
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
@@ -139,7 +139,7 @@ SYM_FUNC_END(__load_partial)
  *   %r10
  */
 SYM_FUNC_START_LOCAL(__store_partial)
-	mov LEN, %r8
+	mov LEN, %r8d
 	mov DST, %r9
 
 	movq T0, %r10
@@ -677,7 +677,7 @@ SYM_TYPED_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	call __store_partial
 
 	/* mask with byte count: */
-	movq LEN, T0
+	movd LEN, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
@@ -702,7 +702,8 @@ SYM_FUNC_END(crypto_aegis128_aesni_dec_tail)
 
 /*
  * void crypto_aegis128_aesni_final(void *state, void *tag_xor,
- *                                  u64 assoclen, u64 cryptlen);
+ *                                  unsigned int assoclen,
+ *                                  unsigned int cryptlen);
  */
 SYM_FUNC_START(crypto_aegis128_aesni_final)
 	FRAME_BEGIN
@@ -715,8 +716,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 	movdqu 0x40(STATEP), STATE4
 
 	/* prepare length block: */
-	movq %rdx, MSG
-	movq %rcx, T0
+	movd %edx, MSG
+	movd %ecx, T0
 	pslldq $8, T0
 	pxor T0, MSG
 	psllq $3, MSG /* multiply by 8 (to get bit count) */


