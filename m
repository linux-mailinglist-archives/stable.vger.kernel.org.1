Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A957A39F0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbjIQT4U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbjIQT4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48846EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8016EC433C8;
        Sun, 17 Sep 2023 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980562;
        bh=9G/c5uriNx52j+t/HkMalgzRkIpBJGPfCrvY+blpJr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJ/3S0UC+ZZQ3VmL58pIB1zxv7ISl33JotQ3JVy6oxjiCK7gGP6EYbWNCYUccor3S
         OuhGKVKGKPtdNCVJoEkub8myQBsuKQD9ZxSzTEzSk/2mP2hTIiH6TtVbSv9aXiK2/y
         uZWgpIz8Ez+gg4HFiF0v6hRe+7gQVcwqE0PSK5wI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 227/285] KVM: nSVM: Load L1s TSC multiplier based on L1 state, not L2 state
Date:   Sun, 17 Sep 2023 21:13:47 +0200
Message-ID: <20230917191059.322570745@linuxfoundation.org>
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

commit 0c94e2468491cbf0754f49a5136ab51294a96b69 upstream.

When emulating nested VM-Exit, load L1's TSC multiplier if L1's desired
ratio doesn't match the current ratio, not if the ratio L1 is using for
L2 diverges from the default.  Functionally, the end result is the same
as KVM will run L2 with L1's multiplier if L2's multiplier is the default,
i.e. checking that L1's multiplier is loaded is equivalent to checking if
L2 has a non-default multiplier.

However, the assertion that TSC scaling is exposed to L1 is flawed, as
userspace can trigger the WARN at will by writing the MSR and then
updating guest CPUID to hide the feature (modifying guest CPUID is
allowed anytime before KVM_RUN).  E.g. hacking KVM's state_test
selftest to do

                vcpu_set_msr(vcpu, MSR_AMD64_TSC_RATIO, 0);
                vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_TSCRATEMSR);

after restoring state in a new VM+vCPU yields an endless supply of:

  ------------[ cut here ]------------
  WARNING: CPU: 10 PID: 206939 at arch/x86/kvm/svm/nested.c:1105
           nested_svm_vmexit+0x6af/0x720 [kvm_amd]
  Call Trace:
   nested_svm_exit_handled+0x102/0x1f0 [kvm_amd]
   svm_handle_exit+0xb9/0x180 [kvm_amd]
   kvm_arch_vcpu_ioctl_run+0x1eab/0x2570 [kvm]
   kvm_vcpu_ioctl+0x4c9/0x5b0 [kvm]
   ? trace_hardirqs_off+0x4d/0xa0
   __se_sys_ioctl+0x7a/0xc0
   __x64_sys_ioctl+0x21/0x30
   do_syscall_64+0x41/0x90
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

Unlike the nested VMRUN path, hoisting the svm->tsc_scaling_enabled check
into the if-statement is wrong as KVM needs to ensure L1's multiplier is
loaded in the above scenario.   Alternatively, the WARN_ON() could simply
be deleted, but that would make KVM's behavior even more subtle, e.g. it's
not immediately obvious why it's safe to write MSR_AMD64_TSC_RATIO when
checking only tsc_ratio_msr.

Fixes: 5228eb96a487 ("KVM: x86: nSVM: implement nested TSC scaling")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230729011608.1065019-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1100,8 +1100,8 @@ int nested_svm_vmexit(struct vcpu_svm *s
 		vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
 	}
 
-	if (svm->tsc_ratio_msr != kvm_caps.default_tsc_scaling_ratio) {
-		WARN_ON(!svm->tsc_scaling_enabled);
+	if (kvm_caps.has_tsc_control &&
+	    vcpu->arch.tsc_scaling_ratio != vcpu->arch.l1_tsc_scaling_ratio) {
 		vcpu->arch.tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 		__svm_write_tsc_multiplier(vcpu->arch.tsc_scaling_ratio);
 	}


