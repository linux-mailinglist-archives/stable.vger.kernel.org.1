Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370E703ADB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbjEOR4N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbjEORzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:55:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E530E0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5FA62F4F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0409C433D2;
        Mon, 15 May 2023 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173122;
        bh=0VpwqI+4BzTNpddx710URyG3UVcR0gewcp7j1IM5LNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D01IoQQ5+5dsFo0DNmP+tSLhbkLx66g5TxZQMmgJaOzW55z0cht7MlQYRbKjKGc3l
         4wds3LFSg9KqixOwdSsSPjxl2mI0nByYvqsoNcg57nyXbIhRksnVaIeEyhbr/E/Ej3
         3K49zDUJJgR7779oHW/D+GhVgPjAe6mdmIPSFG+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH 5.10 374/381] KVM: x86: do not set st->preempted when going back to user space
Date:   Mon, 15 May 2023 18:30:25 +0200
Message-Id: <20230515161753.838989822@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Rishabh Bhatnagar <risbhat@amazon.com>

From: Paolo Bonzini <pbonzini@redhat.com>

commit 54aa83c90198e68eee8b0850c749bc70efb548da upstream.

Similar to the Xen path, only change the vCPU's reported state if the vCPU
was actually preempted.  The reason for KVM's behavior is that for example
optimistic spinning might not be a good idea if the guest is doing repeated
exits to userspace; however, it is confusing and unlikely to make a difference,
because well-tuned guests will hardly ever exit KVM_RUN in the first place.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[risbhat@amazon.com: Don't check for xen msr as support is not available
and skip the SEV-ES condition]
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4139,16 +4139,18 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 {
 	int idx;
 
-	if (vcpu->preempted)
+	if (vcpu->preempted) {
 		vcpu->arch.preempted_in_kernel = !kvm_x86_ops.get_cpl(vcpu);
 
-	/*
-	 * kvm_memslots() will be called by
-	 * kvm_write_guest_offset_cached() so take the srcu lock.
-	 */
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	kvm_steal_time_set_preempted(vcpu);
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		/*
+		 * Take the srcu lock as memslots will be accessed to check the gfn
+		 * cache generation against the memslots generation.
+		 */
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		kvm_steal_time_set_preempted(vcpu);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	}
+
 	kvm_x86_ops.vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*


