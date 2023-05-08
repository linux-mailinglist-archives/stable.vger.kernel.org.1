Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144306FAD20
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjEHLbj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjEHLau (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E73DCBE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4A6303A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E207C433EF;
        Mon,  8 May 2023 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545447;
        bh=7eJ6RynYXoGMDrQEV17kvE+5JvouaG9AX+g9R/kH2fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kv7l5U+EXtfswo3NIwdRTgSVAd3hqQY9TY0rZj4UvB6HEC3yzulaFlJRUtsxrgVJ7
         oTxcVGUMUlQ2o7GdvCMiUQyBYMW9G8YO95js74pCr06xZSJnLOH5Z4GjNFV6tdMnKL
         4giFunQFPCggUpg9k5IU9+7fPiDLejIUfFANVeB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mathias Krause <minipli@grsecurity.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15 043/371] KVM: nVMX: Emulate NOPs in L2, and PAUSE if its not intercepted
Date:   Mon,  8 May 2023 11:44:04 +0200
Message-Id: <20230508094813.777055406@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 4984563823f0034d3533854c1b50e729f5191089 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/vmx.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7493,6 +7493,21 @@ static int vmx_check_intercept(struct kv
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


