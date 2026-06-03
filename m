Return-Path: <stable+bounces-259989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/e7KabhH2rurgAAu9opvQ
	(envelope-from <stable+bounces-259989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:11:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B310F6358DD
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=OzPeuMXl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259989-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259989-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E93300F16D
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716FA407CFC;
	Wed,  3 Jun 2026 08:10:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867E403EA0;
	Wed,  3 Jun 2026 08:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474200; cv=none; b=t40eRMO58GrGV4y7zIAExj4wf6p2kUpPhAKixD6UNI1/ErkB6xLeq0RnACYKekO8ACtAosPxQWPL6+XuaQ5EMnwfjk6Ey3UZVLWHxouCuTdYwLuHZPnlI9dlEVLnqBy/XunH/KtGMg4UXkmSJsa3sTT9pq11U6aHJAO4yOgr2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474200; c=relaxed/simple;
	bh=trhe3JQRuZD6Z2eqR2dt5x0aSlZ4iceV6hLNqZtc3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VikB5+JtpfaIXj27HDPj+JteJq3QBVhbFljVUXt7hTgvAp6GGRpGeqxxo+0N4FJmMpsXBmR4kZJBhW4ErlQ9ti1bU58x0niIlb5yM5HHnMSaH/AJdwuLupAMXl7YkeOZTdrDP7T5R6VS7ejUAJFOhsXonBzMCPwtn7PJc45HnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OzPeuMXl; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cp
	9RRL9kcLgzNgDIMzSk2IWxzcSq68texAEeDTI94JI=; b=OzPeuMXlE+fbxjOXcC
	i8EQtfvAb33WiPleJOaerKFhnM4n9245Vp9kFzG1md/d+PTgJ3Wok0CO0Hz6DcaK
	gvhSaa8qF4zpd99yEGym/8z+C+EHdrN4T/6yOf5PuZqfplNSBEKoK4ISV5W/+Od9
	0z0ZpLc6gZd2bNwqMa+zjfa0k=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXPyQp4R9qrA3TBA--.7184S2;
	Wed, 03 Jun 2026 16:09:13 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Prathamesh Shete <pshete@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meng Li <Meng.Li@windriver.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
Date: Wed,  3 Jun 2026 16:09:12 +0800
Message-ID: <20260603080912.2022575-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.44.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXPyQp4R9qrA3TBA--.7184S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wry5KFyruF1fAFWkWr13XFb_yoWxGFWUpa
	y5KF4F9w4UJFWfua15ua10vF13CF18X3yxGrW3Aas3G3yUKrn09FnxXFyYqF48ArZakF45
	A3yvyryUKw4UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRT89AUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5grkUGof4Sr8aAAA3y
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linuxfoundation.org,windriver.com,linaro.org,163.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259989-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pshete@nvidia.com,m:treding@nvidia.com,m:petlozup@nvidia.com,m:jonathanh@nvidia.com,m:gregkh@linuxfoundation.org,m:Meng.Li@windriver.com,m:ulf.hansson@linaro.org,m:rob_garcia@163.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B310F6358DD

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
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/soc/tegra/pmc.c | 104 ++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1306e3b8b5c0..4cb47c29dc6b 100644
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
@@ -467,6 +468,10 @@ struct tegra_pmc {
 	unsigned long *wake_sw_status_map;
 	unsigned long *wake_cntrl_level_map;
 	struct syscore_ops syscore;
+
+	/* Pending wake IRQ processing */
+	struct irq_work wake_work;
+	u32 *wake_status;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1940,6 +1945,50 @@ static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
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
@@ -1958,6 +2007,18 @@ static int tegra_pmc_init(struct tegra_pmc *pmc)
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
@@ -3156,47 +3217,30 @@ static void wke_clear_wake_status(struct tegra_pmc *pmc)
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
 static void tegra186_pmc_wake_syscore_resume(void)
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
 
 static int tegra186_pmc_wake_syscore_suspend(void)
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
2.44.3


