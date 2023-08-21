Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5A782E10
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjHUQQn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjHUQQn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E1DB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE9561324
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C125C433C8;
        Mon, 21 Aug 2023 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692634600;
        bh=rxK+oIigHCcrBj4avOVgFYMRSL9PRW36OOJSt4f+SdI=;
        h=Subject:To:Cc:From:Date:From;
        b=QNHx9LuXf5cC5xYT+0blbwIxJc9M4KDe9wT5nLRfIxAan8QsxHI2SaPI7O4qho5xn
         9g/Xkga3cK6w9jLYmBcgZoMCTfRlAjJzfpLkd7F7HhdXpR30HXLuX8ThFQkxjZz62J
         kLPiJWkuyev/kpi+lukvaMw26uXLwQ9PRpxemso8=
Subject: FAILED: patch "[PATCH] x86/cpu/kvm: Provide UNTRAIN_RET_VM" failed to apply to 5.10-stable tree
To:     peterz@infradead.org, bp@alien8.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 18:16:28 +0200
Message-ID: <2023082127-unvalued-sanitary-c79f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 864bcaa38ee44ec6c0e43f79c2d2997b977e26b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082127-unvalued-sanitary-c79f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

864bcaa38ee4 ("x86/cpu/kvm: Provide UNTRAIN_RET_VM")
d893832d0e1e ("x86/srso: Add IBPB on VMEXIT")
233d6f68b98d ("x86/srso: Add IBPB")
fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
941d77c77339 ("Merge tag 'x86_cpu_for_v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 864bcaa38ee44ec6c0e43f79c2d2997b977e26b2 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Aug 2023 13:44:35 +0200
Subject: [PATCH] x86/cpu/kvm: Provide UNTRAIN_RET_VM

Similar to how it doesn't make sense to have UNTRAIN_RET have two
untrain calls, it also doesn't make sense for VMEXIT to have an extra
IBPB call.

This cures VMEXIT doing potentially unret+IBPB or double IBPB.
Also, the (SEV) VMEXIT case seems to have been overlooked.

Redefine the meaning of the synthetic IBPB flags to:

 - ENTRY_IBPB     -- issue IBPB on entry  (was: entry + VMEXIT)
 - IBPB_ON_VMEXIT -- issue IBPB on VMEXIT

And have 'retbleed=ibpb' set *BOTH* feature flags to ensure it retains
the previous behaviour and issues IBPB on entry+VMEXIT.

The new 'srso=ibpb_vmexit' option only sets IBPB_ON_VMEXIT.

Create UNTRAIN_RET_VM specifically for the VMEXIT case, and have that
check IBPB_ON_VMEXIT.

All this avoids having the VMEXIT case having to check both ENTRY_IBPB
and IBPB_ON_VMEXIT and simplifies the alternatives.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121149.109557833@infradead.org

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5285c8e93dff..c55cc243592e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -299,6 +299,17 @@
 #endif
 .endm
 
+.macro UNTRAIN_RET_VM
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
+	VALIDATE_UNRET_END
+	ALTERNATIVE_3 "",						\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
+		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CALL_DEPTH_TRACKING)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6f3e19527286..9026e3fe9f6c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1054,6 +1054,7 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 		mitigate_smt = true;
 		break;
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 265452fc9ebe..ef2ebabb059c 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -222,10 +222,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * because interrupt handlers won't sanitize 'ret' if the return is
 	 * from the kernel.
 	 */
-	UNTRAIN_RET
-
-	/* SRSO */
-	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT
+	UNTRAIN_RET_VM
 
 	/*
 	 * Clear all general purpose registers except RSP and RAX to prevent
@@ -362,7 +359,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 * because interrupt handlers won't sanitize RET if the return is
 	 * from the kernel.
 	 */
-	UNTRAIN_RET
+	UNTRAIN_RET_VM
 
 	/* "Pop" @spec_ctrl_intercepted.  */
 	pop %_ASM_BX

