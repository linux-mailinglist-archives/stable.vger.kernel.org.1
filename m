Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BA7C9AB1
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOSSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:18:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797CAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:18:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1F6C433C7;
        Sun, 15 Oct 2023 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393890;
        bh=Zpfs4hyp+Qeq7M+HefqaZ96zP/JZKaIJYrL9wfudYtU=;
        h=Subject:To:Cc:From:Date:From;
        b=ytqcHKWHXIOMtZspBFKutbFpjPXpPzamqrg5f4bDXeysd0O0nGXxFjyjZEDchjCWc
         bQ3SfuFJKubdAb17ySYvk5sBY7wv4rORk+GvcQSr4eGJTX6dyBoxyFYKPr/vXXDgy6
         xL/Vyyu1Kkdx21IMkg/JLqeSisSKs16UZgJ4XNsw=
Subject: FAILED: patch "[PATCH] x86/alternatives: Disable KASAN in apply_alternatives()" failed to apply to 6.1-stable tree
To:     kirill.shutemov@linux.intel.com, fei.yang@intel.com,
        mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:17:47 +0200
Message-ID: <2023101547-captivate-regress-4cb0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d35652a5fc9944784f6f50a5c979518ff8dacf61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101547-captivate-regress-4cb0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d35652a5fc99 ("x86/alternatives: Disable KASAN in apply_alternatives()")
6becb5026b81 ("x86/alternative: Make debug-alternative selective")
ac0ee0a9560c ("x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions")
5d1dd961e743 ("x86/alternatives: Add alt_instr.flags")
931ab63664f0 ("x86/ibt: Implement FineIBT")
b341b20d648b ("x86: Add prefix symbols for function padding")
3b6c1747da48 ("x86/retpoline: Add SKL retthunk retpolines")
52354973573c ("x86/asm: Provide ALTERNATIVE_3")
eaf44c816ed8 ("x86/modules: Add call patching")
e81dc127ef69 ("x86/callthunks: Add call patching for call depth tracking")
80e4c1cd42ff ("x86/retbleed: Add X86_FEATURE_CALL_DEPTH")
bea75b33895f ("x86/Kconfig: Introduce function padding")
8f7c0d8b23c3 ("x86/Kconfig: Add CONFIG_CALL_THUNKS")
8eb5d34e77c6 ("x86/asm: Differentiate between code and function alignment")
d49a0626216b ("arch: Introduce CONFIG_FUNCTION_ALIGNMENT")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d35652a5fc9944784f6f50a5c979518ff8dacf61 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 12 Oct 2023 13:04:24 +0300
Subject: [PATCH] x86/alternatives: Disable KASAN in apply_alternatives()

Fei has reported that KASAN triggers during apply_alternatives() on
a 5-level paging machine:

	BUG: KASAN: out-of-bounds in rcu_is_watching()
	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
	...
	__asan_load4()
	rcu_is_watching()
	trace_hardirqs_on()
	text_poke_early()
	apply_alternatives()
	...

On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
gets patched. It includes KASAN code, where KASAN_SHADOW_START depends on
__VIRTUAL_MASK_SHIFT, which is defined with cpu_feature_enabled().

KASAN gets confused when apply_alternatives() patches the
KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
static, by replacing __VIRTUAL_MASK_SHIFT with 56, works around the issue.

Fix it for real by disabling KASAN while the kernel is patching alternatives.

[ mingo: updated the changelog ]

Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
Reported-by: Fei Yang <fei.yang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231012100424.1456-1-kirill.shutemov@linux.intel.com

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 517ee01503be..73be3931e4f0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 static inline bool is_jcc32(struct insn *insn)

