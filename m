Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AD7ED693
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbjKOWCV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbjKOWCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA94C19D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D21CC433C7;
        Wed, 15 Nov 2023 22:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085736;
        bh=/Y2SjszDClT8V9dVMMQMiNVW1QQ3AT59EAJENRsrFkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9EiRHjsFQ5vGAz9psGMTYRbZ1+ZkNtUGMt7X90Z2chQth25njMQeR+v7fjVKMIgv
         gd2T5kO2U56twoLPbDG/GUC7i9RM26rz5T+0Cz2fIrJlIVNk9okvxpK8Lv9v2jlJ4Y
         6+VmixAwUHMG6sh6ZpVXqjsqlTk6qf/15uHS6Qqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/119] genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()
Date:   Wed, 15 Nov 2023 16:59:52 -0500
Message-ID: <20231115220132.688761195@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit a0b0bad10587ae2948a7c36ca4ffc206007fbcf3 ]

When a CPU is about to be offlined, x86 validates that all active
interrupts which are targeted to this CPU can be migrated to the remaining
online CPUs. If not, the offline operation is aborted.

The validation uses irq_matrix_allocated() to retrieve the number of
vectors which are allocated on the outgoing CPU. The returned number of
allocated vectors includes also vectors which are associated to managed
interrupts.

That's overaccounting because managed interrupts are:

  - not migrated when the affinity mask of the interrupt targets only
    the outgoing CPU

  - migrated to another CPU, but in that case the vector is already
    pre-allocated on the potential target CPUs and must not be taken into
    account.

As a consequence the check whether the remaining online CPUs have enough
capacity for migrating the allocated vectors from the outgoing CPU might
fail incorrectly.

Let irq_matrix_allocated() return only the number of allocated non-managed
interrupts to make this validation check correct.

[ tglx: Amend changelog and fixup kernel-doc comment ]

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231020072522.557846-1-yu.c.chen@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/matrix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 8e586858bcf41..d25edbb87119f 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
 
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on the local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-- 
2.42.0



