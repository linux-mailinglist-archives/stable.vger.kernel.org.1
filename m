Return-Path: <stable+bounces-220170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPrlBXYvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CB1C57C9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB0DD310B8FA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69D4A2E2F;
	Sat, 28 Feb 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDwFFHae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4E4A2E26;
	Sat, 28 Feb 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300078; cv=none; b=EZaySM8++9aOyTjJgjHkb5yKuWojL32CNUOBCMzldHGHJInsp/IzVyRVNldRWwyNzSqyWJFE2sA8qLl3Z11KDZUtmLT4lCTMazh584+x5xvMal5BuLZSUy9c0sPKrbIxrzj/I7f70IfI9AUVMJ0JoMswTFgSpaCfZz0r/YdzQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300078; c=relaxed/simple;
	bh=2uN9iCK6tuGK6dMbwblD+HHT/IcSCyQZCs/7NUou670=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceGb9k8ImgBJhE9jeNwCUvYB8uBFM/Wj/fdYatpV4T/7t+MLCFQsVNAlJw1IA7jA1EHs6dQp72K2m03f7JnD/cCbLmC0vB45vai7Sklr3k93xIDfWzZrTBfJIPWCXVZ7EGCgfm63ObtQcEgyBM0FAYqEF6gqMJpIbwU3kYHST9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDwFFHae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492C0C2BC87;
	Sat, 28 Feb 2026 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300078;
	bh=2uN9iCK6tuGK6dMbwblD+HHT/IcSCyQZCs/7NUou670=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDwFFHaeyTgR78skJnEtFUt55xNJKhECYypVk6I3cpS54qdS+tDS4m1ImTnSdFA8p
	 /gICFvkIsThIDE5IhBUIPrie4rbQANYqEPId2C2FXF4HCgCDIITfCHumbJmhlCPrmE
	 7vw577AVVzmOzUUY6oA1HCMGum+9XZilo4ECBaXmTxxFhCdJmnHrqYVuyqolayPgAe
	 41uPphZx91+kamA8Lv3McSz1szjxwkYm8geWNSRy/pUp1OXKUsSs6IpWEKNmnhtEl5
	 KrnPRJr5MAznHrEdF0g9FjTBYwaKy/B1GH3mvYxrqSXwYY64MXgs72Ad9lWrOZ67e2
	 v1hsPpXgaZtVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Cyan Yang <cyan.yang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Nutty Liu <liujingqi@lanxincomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 092/844] irqchip/riscv-imsic: Add a CPU pm notifier to restore the IMSIC on exit
Date: Sat, 28 Feb 2026 12:20:05 -0500
Message-ID: <20260228173244.1509663-93-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 909CB1C57C9
X-Rspamd-Action: no action

From: Nick Hu <nick.hu@sifive.com>

[ Upstream commit f48b4bd0915bf61ac12b8c65c7939ebd03bc8abf ]

The IMSIC might be reset when the system enters a low power state, but on
exit nothing restores the registers, which prevents interrupt delivery.

Solve this by registering a CPU power management notifier, which restores
the IMSIC on exit.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Link: https://patch.msgid.link/20251202-preserve-aplic-imsic-v3-1-1844fbf1fe92@sifive.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 39 ++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 6bac67cc0b6d9..ba903fa689bd5 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -123,14 +124,8 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int imsic_starting_cpu(unsigned int cpu)
+static void imsic_hw_states_init(void)
 {
-	/* Mark per-CPU IMSIC state as online */
-	imsic_state_online();
-
-	/* Enable per-CPU parent interrupt */
-	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
-
 	/* Setup IPIs */
 	imsic_ipi_starting_cpu();
 
@@ -142,6 +137,18 @@ static int imsic_starting_cpu(unsigned int cpu)
 
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Mark per-CPU IMSIC state as online */
+	imsic_state_online();
+
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
+
+	/* Initialize the IMSIC registers to enable the interrupt delivery */
+	imsic_hw_states_init();
 
 	return 0;
 }
@@ -157,6 +164,22 @@ static int imsic_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int imsic_pm_notifier(struct notifier_block *self, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_EXIT:
+		/* Initialize the IMSIC registers to enable the interrupt delivery */
+		imsic_hw_states_init();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imsic_pm_notifier_block = {
+	.notifier_call = imsic_pm_notifier,
+};
+
 static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 {
 	struct irq_domain *domain;
@@ -194,7 +217,7 @@ static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:starting",
 			  imsic_starting_cpu, imsic_dying_cpu);
 
-	return 0;
+	return cpu_pm_register_notifier(&imsic_pm_notifier_block);
 }
 
 static int __init imsic_early_dt_init(struct device_node *node, struct device_node *parent)
-- 
2.51.0


