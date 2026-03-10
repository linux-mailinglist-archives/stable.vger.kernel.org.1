Return-Path: <stable+bounces-224189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBWnCX7/r2mdeQIAu9opvQ
	(envelope-from <stable+bounces-224189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:24:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7924A9B9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07717305050D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1A738759A;
	Tue, 10 Mar 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZkXesl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AB3806B8;
	Tue, 10 Mar 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141645; cv=none; b=q+pv3b4NGOCLfQBVs6/BmX6RYnLSqO9t33h1ON7l3NSS/XwGIl9fXr5EfIre9UoNe2NUdK4j03hfyhfd0nb1KLWZRRCTv9nsgayWdlL2jC8hBX42crA7l1zRTwuuWMpWcL5eSjtIVczWu2BhXPuDIMaqe9UNRuqo5SO7JO7fmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141645; c=relaxed/simple;
	bh=BE74fN+FOZjaIuv2qKIDv1miYH6l402vrszMo7RQBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjUCDyshg2MvIMj0GUBzLRTWFjHJ72P5zU502yQIeGuQSbJ+qV2a0B4m9R8Ze1hc8LfKv+MPI90XD5MR0ya/yilCdIynC6sZKVtZPdiYEuJrfn3dxUDCoklEnOAGJ6dk7h3l6b1Wa2/AeylFZKJyzkvyB00JD8AbtxEOB9mdcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZkXesl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D55C2BC86;
	Tue, 10 Mar 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141644;
	bh=BE74fN+FOZjaIuv2qKIDv1miYH6l402vrszMo7RQBwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZkXesl1ja1FDX1eAlXkpbssTPBsf6zupNdA1weA/B1s9TbbWQ1vN1WICiuTqY8Vq
	 Y13BhTgd13lumTj0g4Y6nu9/nBrwurXPmm8rS4oMxSp4rx+JvPTZ/OPdhN4C7JJTYb
	 5dwvq7MdpbZjQt6JpqKRbhSuJjRpuWcDakYRdOWBgTCHzX5pDjVrmmAe5FYgo+YrOk
	 zLElCrnIKd3RomZId42KBrbbAFGbinRlMS/knV0M0KjO0Y1uWoRUBWuzWpnlnWPkOI
	 eGEleAn8MApbwsdk29fpz7HoogOwrA/8nynWsgNl5hNY8CbNjROSI308kVA/ucVVBJ
	 xBPlOTQD29vTg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 010/314] irqchip/sifive-plic: Fix frozen interrupt due to affinity setting
Date: Tue, 10 Mar 2026 07:14:29 -0400
Message-ID: <c000bf2f372f224d9d181945838ec4a15537c6bb.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AC7924A9B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224189-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit 1072020685f4b81f6efad3b412cdae0bd62bb043 ]

PLIC ignores interrupt completion message for disabled interrupt, explained
by the specification:

    The PLIC signals it has completed executing an interrupt handler by
    writing the interrupt ID it received from the claim to the
    claim/complete register. The PLIC does not check whether the completion
    ID is the same as the last claim ID for that target. If the completion
    ID does not match an interrupt source that is currently enabled for
    the target, the completion is silently ignored.

This caused problems in the past, because an interrupt can be disabled
while still being handled and plic_irq_eoi() had no effect. That was fixed
by checking if the interrupt is disabled, and if so enable it, before
sending the completion message. That check is done with irqd_irq_disabled().

However, that is not sufficient because the enable bit for the handling
hart can be zero despite irqd_irq_disabled(d) being false. This can happen
when affinity setting is changed while a hart is still handling the
interrupt.

This problem is easily reproducible by dumping a large file to uart (which
generates lots of interrupts) and at the same time keep changing the uart
interrupt's affinity setting. The uart port becomes frozen almost
instantaneously.

Fix this by checking PLIC's enable bit instead of irqd_irq_disabled().

Fixes: cc9f04f9a84f ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260212114125.3148067-1-namcao@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-sifive-plic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc1481..0799c15c745d4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -154,8 +154,13 @@ static void plic_irq_disable(struct irq_data *d)
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	u32 __iomem *reg;
+	bool enabled;
+
+	reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
+	enabled = readl(reg) & BIT(d->hwirq % 32);
 
-	if (unlikely(irqd_irq_disabled(d))) {
+	if (unlikely(!enabled)) {
 		plic_toggle(handler, d->hwirq, 1);
 		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 		plic_toggle(handler, d->hwirq, 0);
-- 
2.51.0


