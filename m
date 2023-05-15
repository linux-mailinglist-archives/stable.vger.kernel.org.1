Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC7703AB2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbjEORyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbjEORxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA3D876
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8354362F89
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79704C433D2;
        Mon, 15 May 2023 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173110;
        bh=H0/+acFd4wWRVtbAscMFTADxS4Pl2ZMRjmkmrAp6JdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idRZroqMjP/v4jvo0ctvzC/EmdQnzpWaKe0Sw03I1vEX00IoIR9e9Z3O51miUxPSF
         tQFDuQI6IxoIXeGbVqmRc526VGsozZviA67XjZEb4InTtZRlCLcdGC6cl5FTUyD/9D
         9bczj1u+DRHe/RzN40pq+9qU54fQTmTLhLBkCPfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 370/381] KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior
Date:   Mon, 15 May 2023 18:30:21 +0200
Message-Id: <20230515161753.644175020@linuxfoundation.org>
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

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit af3511ff7fa2107d6410831f3d71030f5e8d2b25 upstream.

In record_steal_time(), st->preempted is read twice, and
trace_kvm_pv_tlb_flush() might output result inconsistent if
kvm_vcpu_flush_tlb_guest() see a different st->preempted later.

It is a very trivial problem and hardly has actual harm and can be
avoided by reseting and reading st->preempted in atomic way via xchg().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Message-Id: <20210531174628.10265-1-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3041,9 +3041,11 @@ static void record_steal_time(struct kvm
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
+		u8 st_preempted = xchg(&st->preempted, 0);
+
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
-				       st->preempted & KVM_VCPU_FLUSH_TLB);
-		if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
+				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_vcpu_flush_tlb_guest(vcpu);
 	} else {
 		st->preempted = 0;


