Return-Path: <stable+bounces-36072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F043899A63
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248D41F2375F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9F16133E;
	Fri,  5 Apr 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jiqb+tZb"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2E16132C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311840; cv=none; b=fYNPsqEa9pQCKWXPNVmmOsy14Bi2Hq1SuO6TEUNYkcjhlAtvHG2CRo4rsS9786uxm2Ma8UYks0wq0XrF+XXm7WaY6wnyUoBGq/BuJo4UmsPGAq04UEvnGD41sZxIeIHj+lRd2MnTIwzOVDwc38TR0kRWCpNOxfNOU5oZnIMnsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311840; c=relaxed/simple;
	bh=LSDtuax6GtNPj8vjUbJJw44dOpxyvwzev4MAToVXUaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPhhQpCJzaIgPizhzDS2fSiv7DRcrYD6GMiCITnzZmRjYn+VrZNlMBD72x4Y8loColt/8ZhQt2Mmh7CMzisMMV5S0auzy7xW4/Ywn8mo3dDP0/x78X50ON0S7On0EfPqMJeQfKtVHutnuCQbt7mNdlJwo9mAEsMtXuRluN61+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jiqb+tZb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99ED940E019C;
	Fri,  5 Apr 2024 10:10:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vqogxd5tcmk1; Fri,  5 Apr 2024 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712311832; bh=p45BVQrEBw28XyjFwYzVAhEiXV2bbJ/WkMdVI3nURrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiqb+tZbtinb5eCZlbQch1YIZoefcyf46noxlQ5ZUmZY0os+pMWt2GFFOb8i9XflD
	 ZZjUZxsA41PMLO2aA3nWhm+byxyThNqVTffv46W6Id+PfXSXLfhrkik0XPF8mNYy+w
	 H8mZCA55oDN66a46B66G/o1uupWUgvs8O24zJQKgvRpQhM78s8Dium/zj2nvf412Vs
	 E3UgauA+XqWU6KOX6Q6SbvmEvIVHwlYVVBAkUv5kHeN4Jk2RD2NZPlL6c5Yzx/KvwP
	 ypBhfslRNpYH/r2CQlAae00V1YPAIzLM3G8qtkNXXVRzA+1M5kxRDdjj9nfpen4FJe
	 uKWrO8hZ3Y6BQWIDH6/mUoyFHsHz5Kq+LU3kLiugWTa3i1EfFwNupgYtKhGZD9B6qA
	 86rki+kz1YmmOX9F2OgQyxpqXO7W+xRHzibjg48q9A/OfHfakeF7kZk5/5+zUZPy1g
	 wh1DS+nArblF+h8TaxQmf/UOvF+KDTOLmlL62lsn48/OszaLbT6zZeaWwKOnkiPGfd
	 +Kch86ckSWSOzvr9wxxd7ZRPPT3bGO6TcfEwJ/xJ/41KezreoJjrtnqTn3Gzb40FgZ
	 +exB+2qErGH3Z/UT47Q/HY8TCSWlmD0lfwIKCzcwR+xqzkhJPhmFo+Yct+U05eWvge
	 BX/BZXrrt8JY/4uzn8cPtKMQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D55840E0202;
	Fri,  5 Apr 2024 10:10:28 +0000 (UTC)
Date: Fri, 5 Apr 2024 12:10:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/bugs: Fix the SRSO mitigation on Zen3/4
Message-ID: <20240405101027.GBZg_OE-NuHjov71pA@fat_crate.local>
References: <2024033030-steam-implosion-5c12@gregkh>
 <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 28 Mar 2024 13:59:05 +0100

Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.

The original version of the mitigation would patch in the calls to the
untraining routines directly.  That is, the alternative() in UNTRAIN_RET
will patch in the CALL to srso_alias_untrain_ret() directly.

However, even if commit e7c25c441e9e ("x86/cpu: Cleanup the untrain
mess") meant well in trying to clean up the situation, due to micro-
architectural reasons, the untraining routine srso_alias_untrain_ret()
must be the target of a CALL instruction and not of a JMP instruction as
it is done now.

Reshuffle the alternative macros to accomplish that.

Fixes: e7c25c441e9e ("x86/cpu: Cleanup the untrain mess")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/asm-prototypes.h |  1 +
 arch/x86/include/asm/nospec-branch.h  | 20 ++++++++++++++------
 arch/x86/lib/retpoline.S              |  4 +---
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de627c60..5cdccea45554 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8f6f17a8617b..47e4e06a47d7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -167,11 +167,20 @@
 .Lskip_rsb_\@:
 .endm
 
+/*
+ * The CALL to srso_alias_untrain_ret() must be patched in directly at
+ * the spot where untraining must be done, ie., srso_alias_untrain_ret()
+ * must be the target of a CALL instruction instead of indirectly
+ * jumping to a wrapper which then calls it. Therefore, this macro is
+ * called outside of __UNTRAIN_RET below, for the time being, before the
+ * kernel can support nested alternatives with arbitrary nesting.
+ */
+.macro CALL_UNTRAIN_RET
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -188,9 +197,8 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
-	ALTERNATIVE_2 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
+	CALL_UNTRAIN_RET
+	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
 .endm
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 65c5c44f006b..24c850e1e239 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -252,9 +252,7 @@ SYM_CODE_START(srso_return_thunk)
 SYM_CODE_END(srso_return_thunk)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE "jmp retbleed_untrain_ret", "jmp srso_untrain_ret", X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

