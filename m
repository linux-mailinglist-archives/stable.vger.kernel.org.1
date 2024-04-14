Return-Path: <stable+bounces-36601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCC89C093
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69782812F3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6916F53D;
	Mon,  8 Apr 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vz3tqR4e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB12E62C;
	Mon,  8 Apr 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581803; cv=none; b=kM6C1Mrg4qqZk9yPAjX8sdRkRbc1MupbuVzzvUCahvL+vF4KwPwANGkKUeEUlnRaZBxXikIgQbL+zdM9pmdo7G1gu2EAY6CJLWkbjah4tqMHY2+o2bb6/1MYGuvczwDBcBMY3wMfszJe7bdUZSTjJ8fLwiW/OzJ31/E/0Mb7FVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581803; c=relaxed/simple;
	bh=astHKp+inOEyjDnfLJl/vMayBoDIT+KuXKJJvLZ9ffM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxgTITQ4SQIr3j1dlN1ggVrSLj4Dcvv8mCcWfKk8b5eU0HLfEKGWJ/mzUSi2GFyXEqzdm5Wkiexcyqouv5Suembp/tWljKWkthcTuWfd6tP7ffktaLlpZ7c2GlRfRv90p3IZYVlDgbY2QUZADYamYfjA8oBrQlDfGj6+y7m12Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vz3tqR4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E46C433C7;
	Mon,  8 Apr 2024 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581803;
	bh=astHKp+inOEyjDnfLJl/vMayBoDIT+KuXKJJvLZ9ffM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vz3tqR4e5w2xqddVAwwh7F6Ig3KsBqRbjeR80sdcS56QGWAVp2wTY8l/Azl15n/O1
	 3bSRTfyvATlOi+O6hTQLT+fYVn2Q4WblZ5a1wHh9E+k6v82k7nPU/+l0IRlACmgy7P
	 U5vIdmYM6FAEKU3inH2LUOqp5I2kXSHkzjutJxqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	stable@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 053/138] x86/bugs: Fix the SRSO mitigation on Zen3/4
Date: Mon,  8 Apr 2024 14:57:47 +0200
Message-ID: <20240408125257.875945330@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm-prototypes.h |    1 +
 arch/x86/include/asm/nospec-branch.h  |   20 ++++++++++++++------
 arch/x86/lib/retpoline.S              |    4 +---
 3 files changed, 16 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
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
 



