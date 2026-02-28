Return-Path: <stable+bounces-220197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFIdIowuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03E91C568A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF143309435B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7C4CA272;
	Sat, 28 Feb 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6EXlkrS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD84CA26C;
	Sat, 28 Feb 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300103; cv=none; b=R8lqTqqjemAd3gwi0FQlxu2+PbRumx3Gv5k1RmfZXSJXiALuOjV4eBExgfhdg3xxOjB4ZmEmaENNhzGzGpUwWamOIL6v9IXkvU3S8cBRWg7HsMT3DN+KnHUsxDFK4RtqIZw7oGZ9rBDmFo4twI0Lo71l9ZRgEDclG/lykxo4GT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300103; c=relaxed/simple;
	bh=dvot2Tw321UuMNMxBvyf4qtctaikUI3kLXxgzVKFsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpHb0TknkezWjA7KAhpO6HEAWhMowjhKDdv5gmgyY7/8aeJX4JqoMD5KASuhtJ315hbwXHw0Jot/tgtgkmW4uLdvo9zUzBEaOT03xoB+X0swlbNPxZ3+aK6W0f0BcXOG7mFLRLQ0PdkizYvh2tNrc3lqaGnPxBm5k+0vdHzm0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6EXlkrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B191DC19423;
	Sat, 28 Feb 2026 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300103;
	bh=dvot2Tw321UuMNMxBvyf4qtctaikUI3kLXxgzVKFsSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6EXlkrSuRu90vCVmRAw75wSxNo65c7G1UyvBw85Kpr6Iaj+1k1FRa0XxaAlGuqmS
	 mnLcjfXb+p33pjG5AiT/3JrXu2F0fkl3r/1KX33DGgTHhPV3IJcufm5P6MbT5fGH/+
	 A+MqfU72kbKWQ4GHuoFNVm3mGgUowOtp4eL3EzBRBJrzdfaIDwNgrFEESMlm/dHqWi
	 nd+DZqiJGFD2xbLhxTU/butwWOlUh7jOXJqg3dQ0w4Z0xh/cpgsmKeb+Pf1gxX2kYB
	 2MeJQrvxDqaoLXo6958XYp5J2tLbyKHeA1N3DvAHkbZlEqaw7rv6jutG70wyWTRvzl
	 xgrCRxiq8hzDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prathamesh Shete <pshete@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 119/844] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
Date: Sat, 28 Feb 2026 12:20:32 -0500
Message-ID: <20260228173244.1509663-120-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220197-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A03E91C568A
X-Rspamd-Action: no action

From: Prathamesh Shete <pshete@nvidia.com>

[ Upstream commit e6d96073af681780820c94079b978474a8a44413 ]

Currently, when resuming from system suspend on Tegra platforms,
the following warning is observed:

WARNING: CPU: 0 PID: 14459 at kernel/irq/irqdesc.c:666
Call trace:
 handle_irq_desc+0x20/0x58 (P)
 tegra186_pmc_wake_syscore_resume+0xe4/0x15c
 syscore_resume+0x3c/0xb8
 suspend_devices_and_enter+0x510/0x540
 pm_suspend+0x16c/0x1d8

The warning occurs because generic_handle_irq() is being called from
a non-interrupt context which is considered as unsafe.

Fix this warning by deferring generic_handle_irq() call to an IRQ work
which gets executed in hard IRQ context where generic_handle_irq()
can be called safely.

When PREEMPT_RT kernels are used, regular IRQ work (initialized with
init_irq_work) is deferred to run in per-CPU kthreads in preemptible
context rather than hard IRQ context. Hence, use the IRQ_WORK_INIT_HARD
variant so that with PREEMPT_RT kernels, the IRQ work is processed in
hardirq context instead of being deferred to a thread which is required
for calling generic_handle_irq().

On non-PREEMPT_RT kernels, both init_irq_work() and IRQ_WORK_INIT_HARD()
execute in IRQ context, so this change has no functional impact for
standard kernel configurations.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
[treding@nvidia.com: miscellaneous cleanups]
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/pmc.c | 104 ++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f3760a3b3026d..407fa840814c3 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
+#include <linux/irq_work.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
@@ -468,6 +469,10 @@ struct tegra_pmc {
 	unsigned long *wake_sw_status_map;
 	unsigned long *wake_cntrl_level_map;
 	struct syscore syscore;
+
+	/* Pending wake IRQ processing */
+	struct irq_work wake_work;
+	u32 *wake_status;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1905,6 +1910,50 @@ static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
 	return 0;
 }
 
+/* translate sc7 wake sources back into IRQs to catch edge triggered wakeups */
+static void tegra186_pmc_wake_handler(struct irq_work *work)
+{
+	struct tegra_pmc *pmc = container_of(work, struct tegra_pmc, wake_work);
+	unsigned int i, wake;
+
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
+		unsigned long status = pmc->wake_status[i];
+
+		for_each_set_bit(wake, &status, 32) {
+			irq_hw_number_t hwirq = wake + (i * 32);
+			struct irq_desc *desc;
+			unsigned int irq;
+
+			irq = irq_find_mapping(pmc->domain, hwirq);
+			if (!irq) {
+				dev_warn(pmc->dev,
+					 "No IRQ found for WAKE#%lu!\n",
+					 hwirq);
+				continue;
+			}
+
+			dev_dbg(pmc->dev,
+				"Resume caused by WAKE#%lu mapped to IRQ#%u\n",
+				hwirq, irq);
+
+			desc = irq_to_desc(irq);
+			if (!desc) {
+				dev_warn(pmc->dev,
+					 "No descriptor found for IRQ#%u\n",
+					 irq);
+				continue;
+			}
+
+			if (!desc->action || !desc->action->name)
+				continue;
+
+			generic_handle_irq(irq);
+		}
+
+		pmc->wake_status[i] = 0;
+	}
+}
+
 static int tegra_pmc_init(struct tegra_pmc *pmc)
 {
 	if (pmc->soc->max_wake_events > 0) {
@@ -1923,6 +1972,18 @@ static int tegra_pmc_init(struct tegra_pmc *pmc)
 		pmc->wake_cntrl_level_map = bitmap_zalloc(pmc->soc->max_wake_events, GFP_KERNEL);
 		if (!pmc->wake_cntrl_level_map)
 			return -ENOMEM;
+
+		pmc->wake_status = kcalloc(pmc->soc->max_wake_vectors, sizeof(u32), GFP_KERNEL);
+		if (!pmc->wake_status)
+			return -ENOMEM;
+
+		/*
+		 * Initialize IRQ work for processing wake IRQs. Must use
+		 * HARD_IRQ variant to run in hard IRQ context on PREEMPT_RT
+		 * because we call generic_handle_irq() which requires hard
+		 * IRQ context.
+		 */
+		pmc->wake_work = IRQ_WORK_INIT_HARD(tegra186_pmc_wake_handler);
 	}
 
 	if (pmc->soc->init)
@@ -3129,47 +3190,30 @@ static void wke_clear_wake_status(struct tegra_pmc *pmc)
 	}
 }
 
-/* translate sc7 wake sources back into IRQs to catch edge triggered wakeups */
-static void tegra186_pmc_process_wake_events(struct tegra_pmc *pmc, unsigned int index,
-					     unsigned long status)
-{
-	unsigned int wake;
-
-	dev_dbg(pmc->dev, "Wake[%d:%d]  status=%#lx\n", (index * 32) + 31, index * 32, status);
-
-	for_each_set_bit(wake, &status, 32) {
-		irq_hw_number_t hwirq = wake + 32 * index;
-		struct irq_desc *desc;
-		unsigned int irq;
-
-		irq = irq_find_mapping(pmc->domain, hwirq);
-
-		desc = irq_to_desc(irq);
-		if (!desc || !desc->action || !desc->action->name) {
-			dev_dbg(pmc->dev, "Resume caused by WAKE%ld, IRQ %d\n", hwirq, irq);
-			continue;
-		}
-
-		dev_dbg(pmc->dev, "Resume caused by WAKE%ld, %s\n", hwirq, desc->action->name);
-		generic_handle_irq(irq);
-	}
-}
-
 static void tegra186_pmc_wake_syscore_resume(void *data)
 {
-	u32 status, mask;
 	unsigned int i;
+	u32 mask;
 
 	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
 		mask = readl(pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(i));
-		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i)) & mask;
-
-		tegra186_pmc_process_wake_events(pmc, i, status);
+		pmc->wake_status[i] = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i)) & mask;
 	}
+
+	/* Schedule IRQ work to process wake IRQs (if any) */
+	irq_work_queue(&pmc->wake_work);
 }
 
 static int tegra186_pmc_wake_syscore_suspend(void *data)
 {
+	unsigned int i;
+
+	/* Check if there are unhandled wake IRQs */
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++)
+		if (pmc->wake_status[i])
+			dev_warn(pmc->dev,
+				 "Unhandled wake IRQs pending vector[%u]: 0x%x\n",
+				 i, pmc->wake_status[i]);
 	wke_read_sw_wake_status(pmc);
 
 	/* flip the wakeup trigger for dual-edge triggered pads
-- 
2.51.0


