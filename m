Return-Path: <stable+bounces-33848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33933892DA7
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF1C1F2184A
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4FB3307B;
	Sat, 30 Mar 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JNfAX9Xn"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115A1E890
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838453; cv=none; b=SlLXIMISwsqZ9vghmQuNw6loHfOrab6SiYBQONSXWU9RyjB8tr89rPf8YXjQW3TdeGPTgooyOHGFM+XERzpPmkQVI5cT8P5rFY8jJ7YY0Mtv/RxDivZK9JfmOzoiaJH7Ne6KrPyAQYOdX88ZULmCa2CYlhzibBmoKz5KaTE8QUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838453; c=relaxed/simple;
	bh=RD58ODV6ydLQvVpKuLGh6RYqTnVVsZpg/pvZh1vHvzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boQmgSV1WH2492zkWLncO+Icj4RmEaW2SW4bTKbuqV8NxyKAzkv+ab8MiEcPVPjKkS3B6byJjRd+eTjswlqldBx8uuR0rwBGDUjpmb3hNYahrI4rFZZGuXTiU9WqxcVTvvAl9QVzOG64WIdtoc/cWqPNggoI+P9alx4ib0Y2PMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JNfAX9Xn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CEC5C40E02A2;
	Sat, 30 Mar 2024 22:40:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BpazlgPCakML; Sat, 30 Mar 2024 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711838436; bh=dztjA23bFHiUQWqGdpRJU+t9HZpMqyyBttrvu7aHD1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNfAX9XnHLa86B+CNT8AfIcgEyZDV6tGlSWzaMCT6t3rkDoPggYjApJLXm+PIFsgf
	 FW4OSa4nwPvz6nLi3A+zKVkAI6gyxCqe26C1E8OwYcBjMrldDjD6hWghk9GUzcIAg1
	 pr0R399tW+SCQBKkt4jBBYaiyuIivSVNtSPx56fx2Gc5c10r6sHZ0sQu1GMHFARs3o
	 r4xYia5zeXeX9kVnFLNme0tuGHY6TwqUqcCxDncAVM8RjVBBpHT30eSd7vRQEQPVuA
	 9ognXNxr8EA42OQ5uvuuUd+I+rgkF+RSE918v/Ler7jQF8UvvFedBa/+rU0n2P2HVe
	 tjjQeSoe1BfQ3MBu4B5B/02ZLMGmhE+htfIhY1Ptfr4him+DziXAMfVVe5qLEdPr22
	 Sg9zsni8UHLLLXcJ8uYXUiEFjVlIukmMFWIFmKSbAp3p8tsBVA2nwSsqLkKcXB+QDc
	 f/lXGOS5Hs47pxBRfEcpcFXj5slC4aZcHZ3VWPfNa0NhTlBhvzsRf+Uwq75C3Xc/jq
	 BUWfrssmUpnwI0Dr1aMeV830Dq61SyBp54NgH2g1Fs2x/xVpUpBRkEOquzdJLEg4sa
	 hdFgLj/UjqIkcjbbxzk2U6O26bDL+zCS1hCUdX8FqlMCsPalGJu7AOcEU3RaJrbmFf
	 jjy+5wxICmoSjfNPGPLASr70=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A505C40E016B;
	Sat, 30 Mar 2024 22:40:32 +0000 (UTC)
Date: Sat, 30 Mar 2024 23:40:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.8-stable tree
Message-ID: <20240330224026.GAZgiU2jlEEovxGO2y@fat_crate.local>
References: <2024033027-tapered-curly-3516@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033027-tapered-curly-3516@gregkh>

On Sat, Mar 30, 2024 at 10:46:27AM +0100, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here it is:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 28 Mar 2024 13:59:05 +0100
Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4

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
 arch/x86/include/asm/nospec-branch.h  | 21 ++++++++++++++++-----
 arch/x86/lib/retpoline.S              | 11 ++++++-----
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..0e82074517f6 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -13,6 +13,7 @@
 #include <asm/preempt.h>
 #include <asm/asm.h>
 #include <asm/gsseg.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2aa52cab1e46..93c3e28dd8e0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,11 +271,20 @@
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
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -291,8 +300,8 @@
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
 #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+	CALL_UNTRAIN_RET
+	ALTERNATIVE_2 "",						\
 		      "call entry_ibpb", \ibpb_feature,			\
 		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
@@ -351,6 +360,8 @@ extern void retbleed_return_thunk(void);
 static inline void retbleed_return_thunk(void) {}
 #endif
 
+extern void srso_alias_untrain_ret(void);
+
 #ifdef CONFIG_CPU_SRSO
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b2589877d06..1e59367b4681 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -163,6 +163,7 @@ SYM_CODE_START_NOALIGN(srso_alias_untrain_ret)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 	.popsection
 
 	.pushsection .text..__x86.rethunk_safe
@@ -224,10 +225,12 @@ SYM_CODE_START(srso_return_thunk)
 SYM_CODE_END(srso_return_thunk)
 
 #define JMP_SRSO_UNTRAIN_RET "jmp srso_untrain_ret"
-#define JMP_SRSO_ALIAS_UNTRAIN_RET "jmp srso_alias_untrain_ret"
 #else /* !CONFIG_CPU_SRSO */
 #define JMP_SRSO_UNTRAIN_RET "ud2"
-#define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
+/* Dummy for the alternative in CALL_UNTRAIN_RET. */
+SYM_CODE_START(srso_alias_untrain_ret)
+	RET
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif /* CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
@@ -319,9 +322,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
-		      JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO,		\
-		      JMP_SRSO_ALIAS_UNTRAIN_RET, X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE JMP_RETBLEED_UNTRAIN_RET, JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

