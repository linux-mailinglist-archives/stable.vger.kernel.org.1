Return-Path: <stable+bounces-110885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23AA1DB92
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9613A46ED
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118AC17BEC5;
	Mon, 27 Jan 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wz7Dvq11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0laIihaM"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9851662EF;
	Mon, 27 Jan 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000286; cv=none; b=PTc1V1S89ELb5FFv0FD1wFEG5oIVUgvcLrEmZWinDK8ygZ/O4ojzzu3zYIZfUay0T5GfuCiCwfd0SqCUa8MDeuo8TD+LIG2GGNKE8WaTYf1JbwbuWzQrIXPTYOyL+R6Il87eDAvWIQoFz/778jIjcDZoLrgFCRPrWDDr9VqlTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000286; c=relaxed/simple;
	bh=F5/eH/sB/zUAc0+LEZNk/psVzDvUJbxUOvI3WrPkbdU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f0ZSYeaI/tsfYPyIcaAKSzpxDDgM+QbxbEvIRvstjBD/XV/6uwZR3m/hV8KlOgAsmZSxeMx2JT3Ntx6jh6dBIw4fqt0vRmGx/VYg3+pYNvHmSptwvTs0DAEvorTFMHomYDfNOc1QhlO7CDO5YgDRLSQ5RIFu8Vy653UNAB+4PdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wz7Dvq11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0laIihaM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 17:51:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738000282;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FZCGhjEtezE1T8IEPwIrKHdGMSkmDCOfrW67TgvIQs=;
	b=Wz7Dvq11HeXR2uuU8t269D1omKKnHEonXm4vZw1hcjwS5mkcrpdLQV79esoUFbxKlYZwLq
	g5iJ66PmlcHQdkzF84G+DllnN2kaz1KzMlZulG2VH3wiCAo0HaIPU4g29oQGYZ+NLacse2
	i57DSqoMjjELpkNs3H2iyG8BgP0HNrYUI9HTrANvBbLaQoFUHPbkecL3K+P//7CrLsYVYh
	ycnzBaqf4LfcBXCBM7Odytx6DYfLUHIBpHV5cZLsrHzID2PAwm4zZXyt50/8JyymUHMOq+
	c/2ZNFciBmoEBbbCtyhvT0UAi0MsBusDAvzL8ArmeddwMjkEH5uHMnSumDuWhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738000282;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FZCGhjEtezE1T8IEPwIrKHdGMSkmDCOfrW67TgvIQs=;
	b=0laIihaMwCGWftKFAlXJTdsTqeLa2DlF/ya4yuny07mohu2bv5Uoy8exbc3bVqG9At8UAQ
	wgN2od7Biq6sYtCA==
From: "tip-bot2 for Nick Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/apple-aic: Only handle PMC interrupt as FIQ
 when configured so
Cc: Nick Chan <towinchenmi@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250118163554.16733-1-towinchenmi@gmail.com>
References: <20250118163554.16733-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173800027931.31546.17994232029719156171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     698244bbb3bfd32ddf9a0b70a12b1c7d69056497
Gitweb:        https://git.kernel.org/tip/698244bbb3bfd32ddf9a0b70a12b1c7d69056497
Author:        Nick Chan <towinchenmi@gmail.com>
AuthorDate:    Sun, 19 Jan 2025 00:31:42 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jan 2025 18:39:15 +01:00

irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured so

The CPU PMU in Apple SoCs can be configured to fire its interrupt in one of
several ways, and since Apple A11 one of the methods is FIQ, but the check
of the configuration register fails to test explicitely for FIQ mode. It
tests whether the IMODE bitfield is zero or not and the PMCRO_IACT bit is
set. That results in false positives when the IMODE bitfield is not zero,
but does not have the mode PMCR0_IMODE_FIQ.

Only handle the PMC interrupt as a FIQ when the CPU PMU has been configured
to fire FIQs, i.e. the IMODE bitfield value is PMCR0_IMODE_FIQ and
PMCR0_IACT is set.

Fixes: c7708816c944 ("irqchip/apple-aic: Wire PMU interrupts")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250118163554.16733-1-towinchenmi@gmail.com
---
 drivers/irqchip/irq-apple-aic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index da5250f..2b1684c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -577,7 +577,8 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
-	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
 		int irq;
 		if (cpumask_test_cpu(smp_processor_id(),
 				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))

