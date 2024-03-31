Return-Path: <stable+bounces-33856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8A893122
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 11:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36DC282553
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BD75813;
	Sun, 31 Mar 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iOz/yCL3"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D96E5EC
	for <stable@vger.kernel.org>; Sun, 31 Mar 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711878606; cv=none; b=pCZTyh6udbhXMs/oQNEwG6W45T5QzAZM5yFxQLsK+8SbZh4xHfZ1+WvlvpTDpHgX/WVRxPzCta0jcyeb5M53J5zr8JGDtQBu7aRqpoFxoenh3nvepK8vPssT/RsOojT/hxvo0W6J98idbURfa08assHvaiNHENByL9fCIjsdFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711878606; c=relaxed/simple;
	bh=v/kYyW5B0I+tK6FKx47Ir6n8mNx4uNvYUk4EpbNAvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvUA+UxFq+HP6IPLbGSPtEq0GEMoL5h/hu/FOAd5X1nlSWuyPGnswuC/lw6cDLMKlgHP6mmyBSSbB+lVoWzr3xD6LFzLNvCKjGoaU5k8sQV0TE6+lctuFTpOsrEHn+1MHMdXE34XrttFGvjcJyaPgztU1d8OeOAZ4Rh/8TUSWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iOz/yCL3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E98FB40E0202;
	Sun, 31 Mar 2024 09:50:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kKsWiWnNu8uR; Sun, 31 Mar 2024 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711878596; bh=sL0WebPVUTugmZNUIW5zQVQjtBn5I20S6+WY1HwJOrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOz/yCL3cn3IF9jM7P1ScfTqIWqvPlY6Bp6YiLkXjrtRt/qgS5WCfHUm//2qDtdqw
	 CjNf7fEAN/h17jGmcaY8ZrtXV85iD0TQeK+8ZxgFzor1LUCNv5AENrFQA+MKHc0pUs
	 KvJPE51XBrgzsZG9iexvfIFCGZywyYKp4Hrtt+NImGNVFVahF9pd2IxvJKjbu2ygxk
	 3DFEQ/COWSfAhAp23PKXUcB+VkCdzH0ddB6g4AhNkSrvM47qmueL0OdSK13RRw5egW
	 yl/LmgDVJta0QDBgz81Sq9GEHbwHZ0UMb8tcjGbzX/KU8+ReXORg0hqqv1mFJGkejk
	 RnClI9nIZKVrynCPn+nAkfmOU2/hFl/abFcEgRQOd/xFB3YHn1Xn8KGRSx7whMDd2z
	 4FJMoRp0yhNHnXam5QbQJADLDk9Nu2zF91d6riCEFL3S38pnkEt/PdAvy+DQ91fhHG
	 M40tDdCesm+6lDxuLid1bH3COYqxLmQsSmP5JjKouRy/9VusR0SNNXbWY17qRmOzJ2
	 5vbDrQcSERPZjWt6wR64gGzAp/A7CHt29EWwLI9/Y4gVxWqBNMtXZoXzpQ0EuXrqLK
	 S9UzKhVjWA/fd4LS2ovik2Tz/8cCdkS1erOQgI686zV3XWIY0pcmQlanpQcUUj2SbF
	 5hvZ80ehbKe6tvFel0GJ08UY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FFD940E016B;
	Sun, 31 Mar 2024 09:49:52 +0000 (UTC)
Date: Sun, 31 Mar 2024 11:49:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.7-stable tree
Message-ID: <20240331094945.GAZgkxuZYOCg8jwh82@fat_crate.local>
References: <2024033028-lumpiness-pouch-475f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033028-lumpiness-pouch-475f@gregkh>

On Sat, Mar 30, 2024 at 10:46:28AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.7-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

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
index d15b35815eba..4e33cc834bf8 100644
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

