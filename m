Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3276AE17
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjHAJgC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHAJfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D21FC8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D7A61502
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC6FC433C8;
        Tue,  1 Aug 2023 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882432;
        bh=rNu7Y6xHmNS6vIklF4I9duwn2R6fRwl0mCjFqk2cmYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAOX0YkooA9CMTolZMCavSXf+HH88p+2fEVOz5SxPSG1lkkxG9gdpOlqr7M8bnq+v
         eQ5Y91WzCzQebsLev6l4P5WpCo2A8ykBWxQMEkXbcSO+f89U80Q+0/Q41/D0xk/t+U
         o76Tsh+v1fYft5D8NSLWVicDRec+bmdeJLr1xKM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/228] x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory
Date:   Tue,  1 Aug 2023 11:19:21 +0200
Message-ID: <20230801091926.532313240@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

[ Upstream commit 9f9116406120638b4d8db3831ffbc430dd2e1e95 ]

Commit c4e34dd99f2e ("x86: simplify load_unaligned_zeropad()
implementation") changes how exceptions around load_unaligned_zeropad()
handled.  The kernel now uses the fault_address in fixup_exception() to
verify the address calculations for the load_unaligned_zeropad().

It works fine for #PF, but breaks on #VE since no fault address is
passed down to fixup_exception().

Propagating ve_info.gla down to fixup_exception() resolves the issue.

See commit 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad()
page-cross to a shared page") for more context.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Michael Kelley <mikelley@microsoft.com>
Fixes: c4e34dd99f2e ("x86: simplify load_unaligned_zeropad() implementation")
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/traps.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d3fdec706f1d2..c0a5a4f225d9a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -697,9 +697,10 @@ static bool try_fixup_enqcmd_gp(void)
 }
 
 static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
-				    unsigned long error_code, const char *str)
+				    unsigned long error_code, const char *str,
+				    unsigned long address)
 {
-	if (fixup_exception(regs, trapnr, error_code, 0))
+	if (fixup_exception(regs, trapnr, error_code, address))
 		return true;
 
 	current->thread.error_code = error_code;
@@ -759,7 +760,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		goto exit;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
 		goto exit;
 
 	if (error_code)
@@ -1357,17 +1358,20 @@ DEFINE_IDTENTRY(exc_device_not_available)
 
 #define VE_FAULT_STR "VE fault"
 
-static void ve_raise_fault(struct pt_regs *regs, long error_code)
+static void ve_raise_fault(struct pt_regs *regs, long error_code,
+			   unsigned long address)
 {
 	if (user_mode(regs)) {
 		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
 		return;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code,
+				    VE_FAULT_STR, address)) {
 		return;
+	}
 
-	die_addr(VE_FAULT_STR, regs, error_code, 0);
+	die_addr(VE_FAULT_STR, regs, error_code, address);
 }
 
 /*
@@ -1431,7 +1435,7 @@ DEFINE_IDTENTRY(exc_virtualization_exception)
 	 * it successfully, treat it as #GP(0) and handle it.
 	 */
 	if (!tdx_handle_virt_exception(regs, &ve))
-		ve_raise_fault(regs, 0);
+		ve_raise_fault(regs, 0, ve.gla);
 
 	cond_local_irq_disable(regs);
 }
-- 
2.39.2



