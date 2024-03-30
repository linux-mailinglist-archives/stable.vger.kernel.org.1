Return-Path: <stable+bounces-33816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BFC892A1B
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DBCB214BE
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DB125B4;
	Sat, 30 Mar 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4syUAB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD11724
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792008; cv=none; b=ZeBJa/WFYWG31fgf2ynS0CFj5+ZnRYAeJg39/54kyr1lqa2qMTD0ZTcUBSf1tiTzbUZ0yAZx/d8XxTvIGRg6iB1fHBGO/rnraVINPUP0KSsMRj3r3M7kUV9OvA/+yY4jI4veZ03Pb+wNywTaKDSuzBbKtJ6XQ8OVPsz9MG6e5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792008; c=relaxed/simple;
	bh=/TV+oPYyI0wtTtfJ22Dc01Qr9PdSnlAAd4umu4ArvuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L6PS7ZE5PtwaT36eKbPhd1L03Yzws1M1Zf2JFe2no3ZcW+NmMXxKB0Z5+KYxXcCr8F/GMBAjLBRJ4V1wbvPA1piG1+bMVu/9uDrg+2vfwnogi7EnGa85tq2yBZ49DtE8xPsSLITD2uTfyWTFhJd7h/Tq/9ZFMzJHg25E6+/KTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4syUAB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B21BC433C7;
	Sat, 30 Mar 2024 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711792008;
	bh=/TV+oPYyI0wtTtfJ22Dc01Qr9PdSnlAAd4umu4ArvuU=;
	h=Subject:To:Cc:From:Date:From;
	b=B4syUAB4bDkhKovRIfcU2ZvdlYi5Tx9SgWZTO8D16zjYZyF33NwWyPbz/HlpkzGVL
	 dIDG6xpNGqwH56/lgEcgwp8R/NoEG66XFYW3/O1VmgPHYEhbJDeMOAMAWqRJDigAYF
	 uFy33Ox6wHg3IuiGQsTMWJGOQtn/BmWcS/W79fqI=
Subject: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4" failed to apply to 5.10-stable tree
To: bp@alien8.de,mingo@kernel.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:46:32 +0100
Message-ID: <2024033032-confess-monument-a6db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4535e1a4174c4111d92c5a9a21e542d232e0fcaa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033032-confess-monument-a6db@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4535e1a4174c4111d92c5a9a21e542d232e0fcaa Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 28 Mar 2024 13:59:05 +0100
Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4

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

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 076bf8dee702..25466c4d2134 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -14,6 +14,7 @@
 #include <asm/asm.h>
 #include <asm/fred.h>
 #include <asm/gsseg.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index fc3a8a3c7ffe..170c89ed22fc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -262,11 +262,20 @@
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
 #if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -282,8 +291,8 @@
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
 #if defined(CONFIG_MITIGATION_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+	CALL_UNTRAIN_RET
+	ALTERNATIVE_2 "",						\
 		      "call entry_ibpb", \ibpb_feature,			\
 		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
@@ -342,6 +351,8 @@ extern void retbleed_return_thunk(void);
 static inline void retbleed_return_thunk(void) {}
 #endif
 
+extern void srso_alias_untrain_ret(void);
+
 #ifdef CONFIG_MITIGATION_SRSO
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 721b528da9ac..02cde194a99e 100644
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
 #else /* !CONFIG_MITIGATION_SRSO */
+/* Dummy for the alternative in CALL_UNTRAIN_RET. */
+SYM_CODE_START(srso_alias_untrain_ret)
+	RET
+SYM_FUNC_END(srso_alias_untrain_ret)
 #define JMP_SRSO_UNTRAIN_RET "ud2"
-#define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
 #endif /* CONFIG_MITIGATION_SRSO */
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
@@ -319,9 +322,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
-		      JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO,		\
-		      JMP_SRSO_ALIAS_UNTRAIN_RET, X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE JMP_RETBLEED_UNTRAIN_RET, JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 


