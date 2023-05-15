Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21294703AB3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244860AbjEORyS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjEORx7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3516931
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F217062F79
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05FAC433D2;
        Mon, 15 May 2023 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173119;
        bh=rQ3FrYk+oa260UtBvkt/WLPMa0huM27LPJHj4RefhsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUJCYE/pDk2u85OwxLJW2QnzB9xtWQ/fT4h4VfXX15MS0HD/Uw19QWVJafI4Z8cdm
         R//iGB0wV62qrOUyy0oeU8u4ZPARvO7gykjJBDu7IhY9H+TAjnhBWSZZDOqcjeTiW1
         GYX6jp7n4DhLMvzhK3FePBUkJbVDZU0fXCA133DI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH 5.10 373/381] KVM: x86: Remove obsolete disabling of page faults in kvm_arch_vcpu_put()
Date:   Mon, 15 May 2023 18:30:24 +0200
Message-Id: <20230515161753.799005679@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rishabh Bhatnagar <risbhat@amazon.com>

From: Sean Christopherson <seanjc@google.com>

commit 19979fba9bfaeab427a8e106d915f0627c952828 upstream.

Remove the disabling of page faults across kvm_steal_time_set_preempted()
as KVM now accesses the steal time struct (shared with the guest) via a
cached mapping (see commit b043138246a4, "x86/KVM: Make sure
KVM_VCPU_FLUSH_TLB flag is not missed".)  The cache lookup is flagged as
atomic, thus it would be a bug if KVM tried to resolve a new pfn, i.e.
we want the splat that would be reached via might_fault().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210123000334.3123628-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4143,22 +4143,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 		vcpu->arch.preempted_in_kernel = !kvm_x86_ops.get_cpl(vcpu);
 
 	/*
-	 * Disable page faults because we're in atomic context here.
-	 * kvm_write_guest_offset_cached() would call might_fault()
-	 * that relies on pagefault_disable() to tell if there's a
-	 * bug. NOTE: the write to guest memory may not go through if
-	 * during postcopy live migration or if there's heavy guest
-	 * paging.
-	 */
-	pagefault_disable();
-	/*
 	 * kvm_memslots() will be called by
 	 * kvm_write_guest_offset_cached() so take the srcu lock.
 	 */
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	kvm_steal_time_set_preempted(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
-	pagefault_enable();
 	kvm_x86_ops.vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*


