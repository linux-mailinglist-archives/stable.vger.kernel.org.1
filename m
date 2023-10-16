Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817187CA27C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJPIun (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjJPIum (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:50:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CCAE3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:50:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EC2C433C9;
        Mon, 16 Oct 2023 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446239;
        bh=JSrck4Jqxtt5CH5buV8+NW3BTHpcb3W+dpESBzwdVlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft/yq3P0xzx44QrjmrVyhKlDRNCWPQQNcaVrkcDt9lPJkvJYUxrRTQQai3ZbGBt0K
         5seGOs5wl029B9CZ7Qj6QQNF7isUhnInfXOza29cuaTZiNpOqVCEmyPaEP68U3RMzA
         KUfp/UKZ/7B1WMLDswBF2u89Ozc1B8Zlte4vDOec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanjinjie@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.15 096/102] arm64: armv8_deprecated move emulation functions
Date:   Mon, 16 Oct 2023 10:41:35 +0200
Message-ID: <20231016083956.256593417@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 25eeac0cfe7c97ade1be07340e11e7143aab57a6 upstream.

Subsequent patches will rework the logic in armv8_deprecated.c.

In preparation for subsequent changes, this patch moves the emulation
logic earlier in the file, and moves the infrastructure later in the
file. This will make subsequent diffs simpler and easier to read.

This is purely a move. There should be no functional change as a result
of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-8-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/armv8_deprecated.c |  394 +++++++++++++++++------------------
 1 file changed, 197 insertions(+), 197 deletions(-)

--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -52,203 +52,6 @@ struct insn_emulation {
 	int max;
 };
 
-static LIST_HEAD(insn_emulation);
-static int nr_insn_emulated __initdata;
-static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
-static DEFINE_MUTEX(insn_emulation_mutex);
-
-static void register_emulation_hooks(struct insn_emulation *insn)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!insn->hooks);
-
-	for (hook = insn->hooks; hook->instr_mask; hook++)
-		register_undef_hook(hook);
-
-	pr_notice("Registered %s emulation handler\n", insn->name);
-}
-
-static void remove_emulation_hooks(struct insn_emulation *insn)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!insn->hooks);
-
-	for (hook = insn->hooks; hook->instr_mask; hook++)
-		unregister_undef_hook(hook);
-
-	pr_notice("Removed %s emulation handler\n", insn->name);
-}
-
-static void enable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->set_hw_mode)
-		insn->set_hw_mode(true);
-}
-
-static void disable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->set_hw_mode)
-		insn->set_hw_mode(false);
-}
-
-/* Run set_hw_mode(mode) on all active CPUs */
-static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
-{
-	if (!insn->set_hw_mode)
-		return -EINVAL;
-	if (enable)
-		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
-	else
-		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
-	return 0;
-}
-
-/*
- * Run set_hw_mode for all insns on a starting CPU.
- * Returns:
- *  0 		- If all the hooks ran successfully.
- * -EINVAL	- At least one hook is not supported by the CPU.
- */
-static int run_all_insn_set_hw_mode(unsigned int cpu)
-{
-	int rc = 0;
-	unsigned long flags;
-	struct insn_emulation *insn;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		bool enable = (insn->current_mode == INSN_HW);
-		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
-			pr_warn("CPU[%u] cannot support the emulation of %s",
-				cpu, insn->name);
-			rc = -EINVAL;
-		}
-	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-	return rc;
-}
-
-static int update_insn_emulation_mode(struct insn_emulation *insn,
-				       enum insn_emulation_mode prev)
-{
-	int ret = 0;
-
-	switch (prev) {
-	case INSN_UNDEF: /* Nothing to be done */
-		break;
-	case INSN_EMULATE:
-		remove_emulation_hooks(insn);
-		break;
-	case INSN_HW:
-		if (!run_all_cpu_set_hw_mode(insn, false))
-			pr_notice("Disabled %s support\n", insn->name);
-		break;
-	}
-
-	switch (insn->current_mode) {
-	case INSN_UNDEF:
-		break;
-	case INSN_EMULATE:
-		register_emulation_hooks(insn);
-		break;
-	case INSN_HW:
-		ret = run_all_cpu_set_hw_mode(insn, true);
-		if (!ret)
-			pr_notice("Enabled %s support\n", insn->name);
-		break;
-	}
-
-	return ret;
-}
-
-static void __init register_insn_emulation(struct insn_emulation *insn)
-{
-	unsigned long flags;
-
-	insn->min = INSN_UNDEF;
-
-	switch (insn->status) {
-	case INSN_DEPRECATED:
-		insn->current_mode = INSN_EMULATE;
-		/* Disable the HW mode if it was turned on at early boot time */
-		run_all_cpu_set_hw_mode(insn, false);
-		insn->max = INSN_HW;
-		break;
-	case INSN_OBSOLETE:
-		insn->current_mode = INSN_UNDEF;
-		insn->max = INSN_EMULATE;
-		break;
-	}
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_add(&insn->node, &insn_emulation);
-	nr_insn_emulated++;
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	/* Register any handlers if required */
-	update_insn_emulation_mode(insn, INSN_UNDEF);
-}
-
-static int emulation_proc_handler(struct ctl_table *table, int write,
-				  void *buffer, size_t *lenp,
-				  loff_t *ppos)
-{
-	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
-
-	mutex_lock(&insn_emulation_mutex);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write || prev_mode == insn->current_mode)
-		goto ret;
-
-	ret = update_insn_emulation_mode(insn, prev_mode);
-	if (ret) {
-		/* Mode change failed, revert to previous mode. */
-		insn->current_mode = prev_mode;
-		update_insn_emulation_mode(insn, INSN_UNDEF);
-	}
-ret:
-	mutex_unlock(&insn_emulation_mutex);
-	return ret;
-}
-
-static void __init register_insn_emulation_sysctl(void)
-{
-	unsigned long flags;
-	int i = 0;
-	struct insn_emulation *insn;
-	struct ctl_table *insns_sysctl, *sysctl;
-
-	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
-			       GFP_KERNEL);
-	if (!insns_sysctl)
-		return;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		sysctl = &insns_sysctl[i];
-
-		sysctl->mode = 0644;
-		sysctl->maxlen = sizeof(int);
-
-		sysctl->procname = insn->name;
-		sysctl->data = &insn->current_mode;
-		sysctl->extra1 = &insn->min;
-		sysctl->extra2 = &insn->max;
-		sysctl->proc_handler = emulation_proc_handler;
-		i++;
-	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	register_sysctl("abi", insns_sysctl);
-}
-
 /*
  *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
  *  store-exclusive.
@@ -608,6 +411,203 @@ static struct insn_emulation insn_setend
 	.set_hw_mode = setend_set_hw_mode,
 };
 
+static LIST_HEAD(insn_emulation);
+static int nr_insn_emulated __initdata;
+static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
+static DEFINE_MUTEX(insn_emulation_mutex);
+
+static void register_emulation_hooks(struct insn_emulation *insn)
+{
+	struct undef_hook *hook;
+
+	BUG_ON(!insn->hooks);
+
+	for (hook = insn->hooks; hook->instr_mask; hook++)
+		register_undef_hook(hook);
+
+	pr_notice("Registered %s emulation handler\n", insn->name);
+}
+
+static void remove_emulation_hooks(struct insn_emulation *insn)
+{
+	struct undef_hook *hook;
+
+	BUG_ON(!insn->hooks);
+
+	for (hook = insn->hooks; hook->instr_mask; hook++)
+		unregister_undef_hook(hook);
+
+	pr_notice("Removed %s emulation handler\n", insn->name);
+}
+
+static void enable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(true);
+}
+
+static void disable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(false);
+}
+
+/* Run set_hw_mode(mode) on all active CPUs */
+static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
+{
+	if (!insn->set_hw_mode)
+		return -EINVAL;
+	if (enable)
+		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
+	else
+		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
+	return 0;
+}
+
+/*
+ * Run set_hw_mode for all insns on a starting CPU.
+ * Returns:
+ *  0 		- If all the hooks ran successfully.
+ * -EINVAL	- At least one hook is not supported by the CPU.
+ */
+static int run_all_insn_set_hw_mode(unsigned int cpu)
+{
+	int rc = 0;
+	unsigned long flags;
+	struct insn_emulation *insn;
+
+	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
+	list_for_each_entry(insn, &insn_emulation, node) {
+		bool enable = (insn->current_mode == INSN_HW);
+		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
+			pr_warn("CPU[%u] cannot support the emulation of %s",
+				cpu, insn->name);
+			rc = -EINVAL;
+		}
+	}
+	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
+	return rc;
+}
+
+static int update_insn_emulation_mode(struct insn_emulation *insn,
+				       enum insn_emulation_mode prev)
+{
+	int ret = 0;
+
+	switch (prev) {
+	case INSN_UNDEF: /* Nothing to be done */
+		break;
+	case INSN_EMULATE:
+		remove_emulation_hooks(insn);
+		break;
+	case INSN_HW:
+		if (!run_all_cpu_set_hw_mode(insn, false))
+			pr_notice("Disabled %s support\n", insn->name);
+		break;
+	}
+
+	switch (insn->current_mode) {
+	case INSN_UNDEF:
+		break;
+	case INSN_EMULATE:
+		register_emulation_hooks(insn);
+		break;
+	case INSN_HW:
+		ret = run_all_cpu_set_hw_mode(insn, true);
+		if (!ret)
+			pr_notice("Enabled %s support\n", insn->name);
+		break;
+	}
+
+	return ret;
+}
+
+static void __init register_insn_emulation(struct insn_emulation *insn)
+{
+	unsigned long flags;
+
+	insn->min = INSN_UNDEF;
+
+	switch (insn->status) {
+	case INSN_DEPRECATED:
+		insn->current_mode = INSN_EMULATE;
+		/* Disable the HW mode if it was turned on at early boot time */
+		run_all_cpu_set_hw_mode(insn, false);
+		insn->max = INSN_HW;
+		break;
+	case INSN_OBSOLETE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_EMULATE;
+		break;
+	}
+
+	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
+	list_add(&insn->node, &insn_emulation);
+	nr_insn_emulated++;
+	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
+
+	/* Register any handlers if required */
+	update_insn_emulation_mode(insn, INSN_UNDEF);
+}
+
+static int emulation_proc_handler(struct ctl_table *table, int write,
+				  void *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	int ret = 0;
+	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
+	enum insn_emulation_mode prev_mode = insn->current_mode;
+
+	mutex_lock(&insn_emulation_mutex);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write || prev_mode == insn->current_mode)
+		goto ret;
+
+	ret = update_insn_emulation_mode(insn, prev_mode);
+	if (ret) {
+		/* Mode change failed, revert to previous mode. */
+		insn->current_mode = prev_mode;
+		update_insn_emulation_mode(insn, INSN_UNDEF);
+	}
+ret:
+	mutex_unlock(&insn_emulation_mutex);
+	return ret;
+}
+
+static void __init register_insn_emulation_sysctl(void)
+{
+	unsigned long flags;
+	int i = 0;
+	struct insn_emulation *insn;
+	struct ctl_table *insns_sysctl, *sysctl;
+
+	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
+			       GFP_KERNEL);
+	if (!insns_sysctl)
+		return;
+
+	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
+	list_for_each_entry(insn, &insn_emulation, node) {
+		sysctl = &insns_sysctl[i];
+
+		sysctl->mode = 0644;
+		sysctl->maxlen = sizeof(int);
+
+		sysctl->procname = insn->name;
+		sysctl->data = &insn->current_mode;
+		sysctl->extra1 = &insn->min;
+		sysctl->extra2 = &insn->max;
+		sysctl->proc_handler = emulation_proc_handler;
+		i++;
+	}
+	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
+
+	register_sysctl("abi", insns_sysctl);
+}
+
 /*
  * Invoked as core_initcall, which guarantees that the instruction
  * emulation is ready for userspace.


