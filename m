Return-Path: <stable+bounces-78544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE998C0A9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D801F22CE5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCDE1C6F73;
	Tue,  1 Oct 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPfqZogS"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974519C54A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794203; cv=none; b=HYcI1hL9af8t+jldqR5HUho9fAHBlAJTGFLBZNlbstaheOIdQXSIj5DlILIOSwhw1gHHjJEGj9bAdMPWL4cneg4Dwel5LmHHkuJygIAplixS8D+tP6emankNNDdcgf5UQ7up1Gzk2dqiZBmQO5ojvlc8KV1m4xnBkrsanEZI+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794203; c=relaxed/simple;
	bh=OkoWoXr9GihVOSM9RyliUrxqUfrBVQJ/Y9UwEmJggr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Atcv7udCFYKg97QbBfDVjQoofEeWgOX1hq9TKqXxqXcHsadDRVQbfWOu9/8RSr56OYnx8Hf/jrAtvGs8zEQHibzRQVWvIM7znB1cavoVz7mVhVc4qU8DDtxeRHaeVWgt7MbOXf2BMOLLueEkFgXZo/m38LFAB5kEiUGQbKW3fLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPfqZogS; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727794199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHXCPtY/j/HUn+MGyzq96HZ8OKvdaBJBou0BuHk2log=;
	b=FPfqZogSyZZj6I/8uEpCAEZ71z9mmPRv/RUoCsBDlZb5xF6TmcdwmMS4qODxiSpLj1NJ6w
	M3GvONbAjOymbRbMbNLlxnICVGDnMT4B/x3rNEo6uTcm96YlsVIXw+dLb+hSHXD9ZW+hcV
	eZG0OyD+GWcsuK9lKJxPCxMUFCsOiDs=
From: Sean Anderson <sean.anderson@linux.dev>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.10.y] PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler
Date: Tue,  1 Oct 2024 10:49:28 -0400
Message-Id: <20241001144929.1098696-1-sean.anderson@linux.dev>
In-Reply-To: <2024100153-unpaired-charity-9b6f@gregkh>
References: <2024100153-unpaired-charity-9b6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 0199d2f2bd8cd97b310f7ed82a067247d7456029 upstream.

MSGF_LEG_MASK is laid out with INTA in bit 0, INTB in bit 1, INTC in bit 2,
and INTD in bit 3. Hardware IRQ numbers start at 0, and we register
PCI_NUM_INTX IRQs. So to enable INTA (aka hwirq 0) we should set bit 0.
Remove the subtraction of one.

This bug would cause INTx interrupts not to be delivered, as enabling INTB
would actually enable INTA, and enabling INTA wouldn't enable anything at
all. It is likely that this got overlooked for so long since most PCIe
hardware uses MSIs. This fixes the following UBSAN error:

  UBSAN: shift-out-of-bounds in ../drivers/pci/controller/pcie-xilinx-nwl.c:389:11
  shift exponent 18446744073709551615 is too large for 32-bit type 'int'
  CPU: 1 PID: 61 Comm: kworker/u10:1 Not tainted 6.6.20+ #268
  Hardware name: xlnx,zynqmp (DT)
  Workqueue: events_unbound deferred_probe_work_func
  Call trace:
  dump_backtrace (arch/arm64/kernel/stacktrace.c:235)
  show_stack (arch/arm64/kernel/stacktrace.c:242)
  dump_stack_lvl (lib/dump_stack.c:107)
  dump_stack (lib/dump_stack.c:114)
  __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:218 lib/ubsan.c:387)
  nwl_unmask_leg_irq (drivers/pci/controller/pcie-xilinx-nwl.c:389 (discriminator 1))
  irq_enable (kernel/irq/internals.h:234 kernel/irq/chip.c:170 kernel/irq/chip.c:439 kernel/irq/chip.c:432 kernel/irq/chip.c:345)
  __irq_startup (kernel/irq/internals.h:239 kernel/irq/chip.c:180 kernel/irq/chip.c:250)
  irq_startup (kernel/irq/chip.c:270)
  __setup_irq (kernel/irq/manage.c:1800)
  request_threaded_irq (kernel/irq/manage.c:2206)
  pcie_pme_probe (include/linux/interrupt.h:168 drivers/pci/pcie/pme.c:348)

Fixes: 9a181e1093af ("PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts")
Link: https://lore.kernel.org/r/20240531161337.864994-3-sean.anderson@linux.dev
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
[ adjusted to apply to v5.10 ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/controller/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 2a9fe7c3aef9..72ecbc1ea4fe 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -388,7 +388,7 @@ static void nwl_mask_leg_irq(struct irq_data *data)
 	u32 val;
 
 	pcie = irq_desc_get_chip_data(desc);
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
@@ -404,7 +404,7 @@ static void nwl_unmask_leg_irq(struct irq_data *data)
 	u32 val;
 
 	pcie = irq_desc_get_chip_data(desc);
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
-- 
2.35.1.1320.gc452695387.dirty


