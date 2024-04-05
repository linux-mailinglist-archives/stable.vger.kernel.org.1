Return-Path: <stable+bounces-36110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30801899EF0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54BF283EDE
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2C16DEAC;
	Fri,  5 Apr 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A52J5aeL"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF73EA90
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325888; cv=none; b=nqduEEQRaH8qlpMH0hek8dt1VpeR+9FlQPL7/rqEiVcA8B6pxFbN18UPKzTuU8tPQuIS2dbwqVRiOo0/H2xiysFEuWzw0xUBsWH7+o9EKx0kS8hZrMm+aBcMEhjC/92mLqAftyJcSiF0isyVjm/DywaiN7Ll1kXKgeQXBaUUXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325888; c=relaxed/simple;
	bh=OXX41wSwYE2b/lwwE57x3gKNo138SmdBbhDnx+ha1cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inmzc0YwKIHP41urKg5huGvKmMkeoLqdEqDxzLUbG2kMdj8pb5DVe5IS3FTTxJOkyifLrfsrKw5sZ3PtJjMuHCfJaaGzlYn9q+Go0GLzxhHcmSnRkn4CwXkSJ6UXmx5bIzjTeFmyn873MB64TkKv2CVObDAWp0JCQm9D2TD6/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A52J5aeL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 336F040E0202;
	Fri,  5 Apr 2024 14:04:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zot1K3Rq854B; Fri,  5 Apr 2024 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712325877; bh=8v6hp7GeZ6nWysdj4uCojOU6+IbLArVAaqpSuC4j7wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A52J5aeL4AVksLupaAc/SjWCzuBNbAkZkm5YVaEjEWFyn7EJIlNQs5rnWR0IL+z1v
	 bYWhA5NiukFXbLgMV+znJlWCqN6V916togPUyPlMzcW+Oa41gEnbom50syFw8VavIA
	 yfI3y/Kp9ukssP+EfjdU5AewevKgHYoM7U2GQ/DDKiI+M/0R7n9e2rqs+BfcdATj0P
	 ltFLWx0Q+k7X7kX4XXhN2aLt4Uk0PPSq8GLTxVRDrrJwb8slzxNNRNh05+0/T1Bip9
	 hCxx1CCaU4e/KU3xySd70l1LWysLJvZXpt3PYvhA5OkSKsCJtsakCa3AMr/5on8Bod
	 /P3ti3+g1wWjt76EUNF71NTajmXiVX2DS8JzLtuuplKisJxER/pZov1GHxQiwjxzdK
	 FbHGNX/WBqB8lg3ru3U5Ej1PRpzRw3rvtFjzDTIns4ra157d4QY4cewQjfcZrU/+Za
	 h6zg2QHfozP0DYcv4HfxEfjSeZEuDmHE70B22fW456UJNC4IZeHTstJMd5LaeKbdCZ
	 zotpWmvWIy2GS0AduHgM1rjcwXjH6hG5KHrM/3tiZcSjfgFUvNs7payWwFKlEgEBg6
	 Kzh4JFv2d+FtlHYSencJ8aMUPR2mk79aQIiBBCZFLySjZM5Q0a1SUg2pw87h8NoR7I
	 a6tB652aRT7KgG+SKLj8ynFE=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C450B40E0177;
	Fri,  5 Apr 2024 14:04:33 +0000 (UTC)
Date: Fri, 5 Apr 2024 16:04:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/bugs: Fix the SRSO mitigation on Zen3/4
Message-ID: <20240405140432.GAZhAE8CuUO6vwOyKK@fat_crate.local>
References: <2024033031-efficient-gallows-6872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033031-efficient-gallows-6872@gregkh>

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
index f3f6c28e5818..5414e6764e5a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -155,11 +155,20 @@
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
@@ -176,9 +185,8 @@
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
index 6f5321b36dbb..8acafe60220a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -249,9 +249,7 @@ SYM_CODE_START(srso_return_thunk)
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

