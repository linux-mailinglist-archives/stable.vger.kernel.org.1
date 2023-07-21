Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B875D2F2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjGUTFc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGUTFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6930D6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A4161D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EAAC433C8;
        Fri, 21 Jul 2023 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966329;
        bh=q5UAS5Nui34djyXulS6JauA8VFifRPbLLFsoRAI07qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krnB15g4aKN/HmuSw6flpE4i4kRV0dW0ArIDgxn6RZsPz7NYhTFJ1wNT/noudRnex
         J7hXii7XeI38uv9qLyGCS0Iir2eGSAKpE93hMtAuHoLATnHvNrMS6cPoQ87B/yXr9V
         A23zWACr/7odvFRvaXH617F9W6fHVw1ZkaCM3UlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pierre Morel <pmorel@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 305/532] KVM: s390/diag: fix racy access of physical cpu number in diag 9c handler
Date:   Fri, 21 Jul 2023 18:03:29 +0200
Message-ID: <20230721160630.959287825@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit 0bc380beb78aa352eadbc21d934dd9606fcee808 ]

We do check for target CPU == -1, but this might change at the time we
are going to use it. Hold the physical target CPU in a local variable to
avoid out-of-bound accesses to the cpu arrays.

Cc: Pierre Morel <pmorel@linux.ibm.com>
Fixes: 87e28a15c42c ("KVM: s390: diag9c (directed yield) forwarding")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/diag.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 807fa9da1e721..3c65b8258ae67 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -166,6 +166,7 @@ static int diag9c_forwarding_overrun(void)
 static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *tcpu;
+	int tcpu_cpu;
 	int tid;
 
 	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
@@ -181,14 +182,15 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 		goto no_yield;
 
 	/* target guest VCPU already running */
-	if (READ_ONCE(tcpu->cpu) >= 0) {
+	tcpu_cpu = READ_ONCE(tcpu->cpu);
+	if (tcpu_cpu >= 0) {
 		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
 			goto no_yield;
 
 		/* target host CPU already running */
-		if (!vcpu_is_preempted(tcpu->cpu))
+		if (!vcpu_is_preempted(tcpu_cpu))
 			goto no_yield;
-		smp_yield_cpu(tcpu->cpu);
+		smp_yield_cpu(tcpu_cpu);
 		VCPU_EVENT(vcpu, 5,
 			   "diag time slice end directed to %d: yield forwarded",
 			   tid);
-- 
2.39.2



