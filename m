Return-Path: <stable+bounces-36112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B16899F6D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38171F268A0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494E16EBE3;
	Fri,  5 Apr 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e0oTdKH8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A11BDDB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326810; cv=none; b=MPyYX55ojioThQWP86J7jzBCo3pZFO6yE597stDaHZTVWC7eTpNcTRXyoLevTmqsaI5g92g6daqC6WSy3C10YiJ8FO/ZOhdn10KxZuWg5hrnG93sn28JYM7i/757Sk+LL2sofhr75bsBwOBbVYU1MuNqpKCin3+ekVaOGrrCs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326810; c=relaxed/simple;
	bh=/K+FjczbmgvZMLysxhfLAc5y5ztxak/kOUfF9Ufcfng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB5KFyW4CsZtEfeYcXIP64oY2ZFFzA65AvwnLRkGv5113HciNA1u4Osl6Ba1jju96Or1kOijSWXMA4csSQrZjWyRP5aLUZ+RzbBEJrW70V+oX6VjzFDTCKO3QTnJq2Ij0mUw9R71Mrp/xv8Gd6AzDPfm04ettC6SbQoayVBK6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e0oTdKH8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4BAB40E022F;
	Fri,  5 Apr 2024 14:20:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c47KsYCCOlA6; Fri,  5 Apr 2024 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712326801; bh=j64T+z7YcVfex+oyV+a3ywHuls6e3IXK3TvXxKmxKSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0oTdKH8Oa9mMxKRBQfGTxa3X1LNP9Dl7KCXlBgNiP/xfARlstY771BE12klXMeHw
	 YvE5SMQgidqIsOgf4pUsblxyO1b0tzc9KofFjGmoAkRw0wGryliDyfdvFOIDK02uAn
	 /Ij+1CJBPfLCiGoWc+Z3RV8ZrmnIZ2ws98CudRCmVC82llpDkD9ptH8/7yh4lbXPnG
	 osKlDCKlvchAiN3IfXi38V5nMo0ylyC5hzjdLWOOL0Q6LEB4+siaTb6EB3Cx2fu0mU
	 jwUycFphcXiAign/VslKIiTzAwet0g5ZcXSDqYmDsRKLX8pQ+Ijll2nOinqm/RK9i8
	 /hLty/wf97wtfTSfZSwbrSCQQutwn8DL5R+Bm+Sn/pYCxoaPDxtiKuBvhsQreIz2kQ
	 3Yz7kCVqYTdSzx8l4SIhHdZCuVEy0JXcud04Zs/L21l4ET9OvnKWaf0jK39Z9VL+YD
	 U3Nl325TU4egjf64aYmZFz0B+Kgojsi2a4iuy8EFBBQC2UPlTOD6JBVjBsrag9ztt4
	 qpEDUBlCJF9uPzYxd/OFDfaMQlLxTijwVqy4c52bDuykHaD+IB08vIhaHxJCRBmQmK
	 jWtNKDDT9RQAsOtgA0v48Tu77Rq/iNjw/UVmFMowa9EEp1cDYmaoaIQNcrZXMK5QRz
	 x6qHZNMQoVUS9m1NAFt/lemo=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44C4240E0177;
	Fri,  5 Apr 2024 14:19:57 +0000 (UTC)
Date: Fri, 5 Apr 2024 16:19:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/bugs: Fix the SRSO mitigation on Zen3/4
Message-ID: <20240405141951.GCZhAIh6sy03J5k6iJ@fat_crate.local>
References: <2024033032-confess-monument-a6db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033032-confess-monument-a6db@gregkh>

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
index 7711ba5342a1..6be8e76ac696 100644
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

