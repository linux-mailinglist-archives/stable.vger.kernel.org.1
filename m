Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91726F8F5C
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjEFGln (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjEFGlj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A49EFD
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6801C61777
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A72C433D2;
        Sat,  6 May 2023 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355296;
        bh=4AYT0fLs7pGLgvjmfWain4t3hgGrlMMfxrtbd7helgQ=;
        h=Subject:To:Cc:From:Date:From;
        b=rYP6kuS4Xsxz12P6uXzMm5CG4pvkQfDqg2gt08hl9MdCmZwCoL2ucBhAChyN6J6a2
         ahE8HBQF7dXIcLaQjpEAhpqGwZ5rvvpNmrXzKlxHTs9YnIW7mlK2cfYrYga7MidlPu
         SsOLc+48GdufTJovUrPKtVvjOkxlRgaoKVf90kts=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not" failed to apply to 4.14-stable tree
To:     seanjc@google.com, minipli@grsecurity.net, pbonzini@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:31:35 +0900
Message-ID: <2023050635-saggy-margarita-f21b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 4984563823f0034d3533854c1b50e729f5191089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050635-saggy-margarita-f21b@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4984563823f0034d3533854c1b50e729f5191089 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 4 Apr 2023 17:23:59 -0700
Subject: [PATCH] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not
 intercepted

Extend VMX's nested intercept logic for emulated instructions to handle
"pause" interception, in quotes because KVM's emulator doesn't filter out
NOPs when checking for nested intercepts.  Failure to allow emulation of
NOPs results in KVM injecting a #UD into L2 on any NOP that collides with
the emulator's definition of PAUSE, i.e. on all single-byte NOPs.

For PAUSE itself, honor L1's PAUSE-exiting control, but ignore PLE to
avoid unnecessarily injecting a #UD into L2.  Per the SDM, the first
execution of PAUSE after VM-Entry is treated as the beginning of a new
loop, i.e. will never trigger a PLE VM-Exit, and so L1 can't expect any
given execution of PAUSE to deterministically exit.

  ... the processor considers this execution to be the first execution of
  PAUSE in a loop. (It also does so for the first execution of PAUSE at
  CPL 0 after VM entry.)

All that said, the PLE side of things is currently a moot point, as KVM
doesn't expose PLE to L1.

Note, vmx_check_intercept() is still wildly broken when L1 wants to
intercept an instruction, as KVM injects a #UD instead of synthesizing a
nested VM-Exit.  That issue extends far beyond NOP/PAUSE and needs far
more effort to fix, i.e. is a problem for the future.

Fixes: 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
Cc: Mathias Krause <minipli@grsecurity.net>
Cc: stable@vger.kernel.org
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20230405002359.418138-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d7bf14abdba1..e06fcd6144b0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7935,6 +7935,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 		break;
 
+	case x86_intercept_pause:
+		/*
+		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
+		 * with vanilla NOPs in the emulator.  Apply the interception
+		 * check only to actual PAUSE instructions.  Don't check
+		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
+		 * exit, i.e. KVM is within its rights to allow L2 to execute
+		 * the PAUSE.
+		 */
+		if ((info->rep_prefix != REPE_PREFIX) ||
+		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
+			return X86EMUL_CONTINUE;
+
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;

