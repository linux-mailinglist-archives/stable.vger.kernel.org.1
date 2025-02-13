Return-Path: <stable+bounces-116270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F1A347EE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B09189167E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7F70805;
	Thu, 13 Feb 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUGyE1vK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D5199934;
	Thu, 13 Feb 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460906; cv=none; b=EeOUdLt3Cue5PFFeKFhjE1uYT0egHNfocBiBDR/hl69X6yWFfOPPLxip686wgpJUFdmjLWNufAg3AAdZZidcGnsuOstYImFyRogPyp9s0bl/sMGjwJ4bhaLjUY3C9N+47au5bXOi8Iu66N7p3ZSTQdk4dFPnZq/6UB6/KeP7eGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460906; c=relaxed/simple;
	bh=EOVzI3obJX675i6Kg5SLf3RKOwg//OOP/RVigKno0C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MngNqfnGYLTTKne1XupINpwgLZ42ROMi4MY+5Nird42Kzy5q9pLU1Ar1SiCEQMgxdgLB8pZKayMEUCF0cmQktcFM9foAStXtX0i03ltEH8nn1oHVOfV3Feha4k1y2asT0V8hrh2nnxfJvbHZz/JPqYX8GUuMXVIpdPNvPOkNN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUGyE1vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841ABC4CED1;
	Thu, 13 Feb 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460906;
	bh=EOVzI3obJX675i6Kg5SLf3RKOwg//OOP/RVigKno0C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUGyE1vKLhRnn30My+/NBgfjCFPrSV414YBAV6k+X1niSZOxIQwhd38p1oUxO9ehJ
	 smvaWRhaSfoU8ExmFlFMGpH/uTObYjvHN9eUZxjtEX8bKkhdnCCEKh9gej+hZ/x5Az
	 kfnSbvGV9BnL7sOIN/pNK3FzBfyddFdWzXr5QrtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.6 239/273] irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured so
Date: Thu, 13 Feb 2025 15:30:11 +0100
Message-ID: <20250213142416.879133677@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Chan <towinchenmi@gmail.com>

commit 698244bbb3bfd32ddf9a0b70a12b1c7d69056497 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-apple-aic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -563,7 +563,8 @@ static void __exception_irq_entry aic_ha
 						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
-	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
 		int irq;
 		if (cpumask_test_cpu(smp_processor_id(),
 				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))



