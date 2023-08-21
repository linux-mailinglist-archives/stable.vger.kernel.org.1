Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB9A7832C0
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHUUG2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjHUUG1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D51A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17BD064952
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0A5C433C7;
        Mon, 21 Aug 2023 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648385;
        bh=6th6LfthIn3IlT5iCdpNktpEtzyPbwTmBGzjyMyhn18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkvDwEbdUytxtZdNOCI0KP4XnOuXK0KBoEnLn43+OaETov6Uew1kfir5ok6zhwsw1
         i0SIK3Q4fZU83VE+36W4h3ddzas2p6y1H4RZc2C1aSpFVov4fsScZNtDBYQpUIZjNS
         S8sFQ7AqOzK3ifTEcLIwLtSpFeAoBc1qmzubpb2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>,
        stable@kernel.org
Subject: [PATCH 6.4 127/234] x86/CPU/AMD: Fix the DIV(0) initial fix attempt
Date:   Mon, 21 Aug 2023 21:41:30 +0200
Message-ID: <20230821194134.453983732@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Borislav Petkov (AMD) <bp@alien8.de>

commit f58d6fbcb7c848b7f2469be339bc571f2e9d245b upstream.

Initially, it was thought that doing an innocuous division in the #DE
handler would take care to prevent any leaking of old data from the
divider but by the time the fault is raised, the speculation has already
advanced too far and such data could already have been used by younger
operations.

Therefore, do the innocuous division on every exit to userspace so that
userspace doesn't see any potentially old data from integer divisions in
kernel space.

Do the same before VMRUN too, to protect host data from leaking into the
guest too.

Fixes: 77245f1c3c64 ("x86/CPU/AMD: Do not leak quotient data after a division by 0")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230811213824.10025-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/entry-common.h |    1 +
 arch/x86/kernel/cpu/amd.c           |    1 +
 arch/x86/kernel/traps.c             |    2 --
 arch/x86/kvm/svm/svm.c              |    2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -92,6 +92,7 @@ static inline void arch_exit_to_user_mod
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	mds_user_clear_cpu_buffers();
+	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1329,3 +1329,4 @@ void noinstr amd_clear_divider(void)
 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
 		     :: "a" (0), "d" (0), "r" (1));
 }
+EXPORT_SYMBOL_GPL(amd_clear_divider);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -206,8 +206,6 @@ DEFINE_IDTENTRY(exc_divide_error)
 {
 	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
-
-	amd_clear_divider();
 }
 
 DEFINE_IDTENTRY(exc_overflow)
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4034,6 +4034,8 @@ static noinstr void svm_vcpu_enter_exit(
 
 	guest_state_enter_irqoff();
 
+	amd_clear_divider();
+
 	if (sev_es_guest(vcpu->kvm))
 		__svm_sev_es_vcpu_run(svm, spec_ctrl_intercepted);
 	else


