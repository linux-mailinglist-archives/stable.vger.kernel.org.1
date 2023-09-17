Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0047A39EE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjIQT4T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbjIQT4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324DEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A30FC433C8;
        Sun, 17 Sep 2023 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980559;
        bh=qxLrSLDlJZfoxdtXjBYxj+k4090HCFnNSeHQODBvEWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XthQswGu0Z5KGqZ1wrWI89zjevzfsHHskLtc98UDz2hJszeYBQlly+2t3y1s/VgUI
         2wVHWymjTmIC6BWgIghgAwyx7Bx0ijDIo2flw3VL9evabjNub1UGgJAc7rK8b3++Ig
         zb43oapD2xFEFWLyPci2bQ9fgtcVOTAEAo3rOJRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 226/285] KVM: nSVM: Check instead of asserting on nested TSC scaling support
Date:   Sun, 17 Sep 2023 21:13:46 +0200
Message-ID: <20230917191059.295226908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 7cafe9b8e22bb3d77f130c461aedf6868c4aaf58 upstream.

Check for nested TSC scaling support on nested SVM VMRUN instead of
asserting that TSC scaling is exposed to L1 if L1's MSR_AMD64_TSC_RATIO
has diverged from KVM's default.  Userspace can trigger the WARN at will
by writing the MSR and then updating guest CPUID to hide the feature
(modifying guest CPUID is allowed anytime before KVM_RUN).  E.g. hacking
KVM's state_test selftest to do

		vcpu_set_msr(vcpu, MSR_AMD64_TSC_RATIO, 0);
		vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_TSCRATEMSR);

after restoring state in a new VM+vCPU yields an endless supply of:

  ------------[ cut here ]------------
  WARNING: CPU: 164 PID: 62565 at arch/x86/kvm/svm/nested.c:699
           nested_vmcb02_prepare_control+0x3d6/0x3f0 [kvm_amd]
  Call Trace:
   <TASK>
   enter_svm_guest_mode+0x114/0x560 [kvm_amd]
   nested_svm_vmrun+0x260/0x330 [kvm_amd]
   vmrun_interception+0x29/0x30 [kvm_amd]
   svm_invoke_exit_handler+0x35/0x100 [kvm_amd]
   svm_handle_exit+0xe7/0x180 [kvm_amd]
   kvm_arch_vcpu_ioctl_run+0x1eab/0x2570 [kvm]
   kvm_vcpu_ioctl+0x4c9/0x5b0 [kvm]
   __se_sys_ioctl+0x7a/0xc0
   __x64_sys_ioctl+0x21/0x30
   do_syscall_64+0x41/0x90
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x45ca1b

Note, the nested #VMEXIT path has the same flaw, but needs a different
fix and will be handled separately.

Fixes: 5228eb96a487 ("KVM: x86: nSVM: implement nested TSC scaling")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230729011608.1065019-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -695,10 +695,9 @@ static void nested_vmcb02_prepare_contro
 
 	vmcb02->control.tsc_offset = vcpu->arch.tsc_offset;
 
-	if (svm->tsc_ratio_msr != kvm_caps.default_tsc_scaling_ratio) {
-		WARN_ON(!svm->tsc_scaling_enabled);
+	if (svm->tsc_scaling_enabled &&
+	    svm->tsc_ratio_msr != kvm_caps.default_tsc_scaling_ratio)
 		nested_svm_update_tsc_ratio_msr(vcpu);
-	}
 
 	vmcb02->control.int_ctl             =
 		(svm->nested.ctl.int_ctl & int_ctl_vmcb12_bits) |


