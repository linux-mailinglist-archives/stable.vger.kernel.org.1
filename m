Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919F473B410
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFWJru (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjFWJrt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29DF184
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ACFF619C2
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B2C433C0;
        Fri, 23 Jun 2023 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687513667;
        bh=Ctelx0HW0l4HuctC56Dqr5ghdLWCeDf/Aj52LbiXiHk=;
        h=Subject:To:Cc:From:Date:From;
        b=Sd+r/JJZajcOIyzWWyjLBLjHmQHTwBQ01p756BFmFoYC0uIa7IK2oT+TXmjz1Olm6
         R9QFWh0eaA5ZggQa8kcw/IYF3bAr9BtpQS3R4OuirE5eq0foQbr+lUeBHa0LkzFl0S
         VvESGXnJFvmDOJdq+cOkxxHhPkBgidHghmSEsyRk=
Subject: FAILED: patch "[PATCH] powerpc/64s/radix: Fix exit lazy tlb mm switch with irqs" failed to apply to 5.10-stable tree
To:     npiggin@gmail.com, mpe@ellerman.id.au, sachinp@linux.ibm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:47:36 +0200
Message-ID: <2023062336-ivy-sweep-e805@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dfaed3e1fa7099de8de4e89cbe7eb9c1bca27dfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062336-ivy-sweep-e805@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dfaed3e1fa7099de8de4e89cbe7eb9c1bca27dfe Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 7 Jun 2023 10:56:00 +1000
Subject: [PATCH] powerpc/64s/radix: Fix exit lazy tlb mm switch with irqs
 enabled

Switching mm and tinkering with current->active_mm should be done with
irqs disabled. There is a path where exit_lazy_flush_tlb can be called
with irqs enabled:

    exit_lazy_flush_tlb
    flush_type_needed
    __flush_all_mm
    tlb_finish_mmu
    exit_mmap

Which results in the switching being done with irqs enabled, which is
incorrect.

Fixes: a665eec0a22e ("powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm")
Cc: stable@vger.kernel.org # v5.10+
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lore.kernel.org/linuxppc-dev/A9A5D83D-BA70-47A4-BCB4-30C1AE19BC22@linux.ibm.com/
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230607005601.583293-1-npiggin@gmail.com

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index ce804b7bf84e..0bd4866d9824 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -795,12 +795,20 @@ void exit_lazy_flush_tlb(struct mm_struct *mm, bool always_flush)
 		goto out;
 
 	if (current->active_mm == mm) {
+		unsigned long flags;
+
 		WARN_ON_ONCE(current->mm != NULL);
-		/* Is a kernel thread and is using mm as the lazy tlb */
+		/*
+		 * It is a kernel thread and is using mm as the lazy tlb, so
+		 * switch it to init_mm. This is not always called from IPI
+		 * (e.g., flush_type_needed), so must disable irqs.
+		 */
+		local_irq_save(flags);
 		mmgrab_lazy_tlb(&init_mm);
 		current->active_mm = &init_mm;
 		switch_mm_irqs_off(mm, &init_mm, current);
 		mmdrop_lazy_tlb(mm);
+		local_irq_restore(flags);
 	}
 
 	/*

