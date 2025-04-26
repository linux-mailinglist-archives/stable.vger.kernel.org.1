Return-Path: <stable+bounces-136744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E77A9D953
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE5466B64
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D924C66F;
	Sat, 26 Apr 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zeK7mJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLdT5WYn"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8115574E;
	Sat, 26 Apr 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745655799; cv=none; b=Zx//5TWAEMd5gR84sswiCaIPj5XyNnfaAw7N1vS0kIETrcsaqPtikSvzXmRX0nmpLYcI8Oto7yTQxuNOBCV9TBZWALwT5LdQLJeo0zQ+B8t70THaDiYOlJQhyBn6qZHEY2POqF2rZ2K3WVhnV+MKXmgVjvo3JGt+CGU2wU5RjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745655799; c=relaxed/simple;
	bh=T/0xTqND7PjkXvzjFIewwatpFzxkpl5LjaRGjg/Ft2M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XFIeCnRO5DXRtgOzHu2Itz5iN1K+9P99jjRqwBhOeUVh7+IKuwNaa29WmNwFmOqa285uzL26w8FWLJRjNlhnlKCJeOXUmlTSb150/Oo7BpQpsxvF/RYQlgRzAv6zeJlZ3XJsdxXCRTxyub3hE0rWMCwKDj1DDdijnQdlwxq9xR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zeK7mJo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLdT5WYn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Apr 2025 08:23:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745655789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RtykLyqSPHAkwQ6ztUn4+zSx9nu7whQ+1FHXMP8EBzw=;
	b=3zeK7mJozIYwyEnFeOZTQfO8qJPxevDiJo5cBah0a6hr8S+xq+hZ/qRhVTBQkTyn9kKoIm
	g9IeibbUfPwdokmiLmP0yiYLqIIHcAj6GETipOTZLsNXDbhAR0rAIwOs6GGgv2O04bZD2b
	cN0Uz7MNUzRFmP0KfXnz4sTdDazCWs2hKxbWD6noPGFyg/bBJfrL4YDV4hrWhEI4H+tKfB
	NbAZ/S5UKnOkf/q91u8tZJPaVXLV6dpT0Nc3wWwOBAjv3em+fjzHmDn2bqbhXilutuwSzD
	QzFfvNaFmAEW/LEFGxE5M3bTbq90hLwcLm1vXaCVm2m/9Gq+DNKaPyXyt7mAuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745655789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RtykLyqSPHAkwQ6ztUn4+zSx9nu7whQ+1FHXMP8EBzw=;
	b=uLdT5WYn7IIMK9xcm8rI0egTtl9QAa36osfAKRjfhFT3HqGl7QoomJvLUep4hRSwGKoCtc
	mQUjvrs/VCiQeVDw==
From: "tip-bot2 for Suzuki K Poulose" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v2m: Prevent use after free of
 gicv2m_get_fwnode()
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174565578285.31282.8068570844383766961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3318dc299b072a0511d6dfd8367f3304fb6d9827
Gitweb:        https://git.kernel.org/tip/3318dc299b072a0511d6dfd8367f3304fb6d9827
Author:        Suzuki K Poulose <suzuki.poulose@arm.com>
AuthorDate:    Tue, 22 Apr 2025 17:16:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 26 Apr 2025 10:17:24 +02:00

irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

With ACPI in place, gicv2m_get_fwnode() is registered with the pci
subsystem as pci_msi_get_fwnode_cb(), which may get invoked at runtime
during a PCI host bridge probe. But, the call back is wrongly marked as
__init, causing it to be freed, while being registered with the PCI
subsystem and could trigger:

 Unable to handle kernel paging request at virtual address ffff8000816c0400
  gicv2m_get_fwnode+0x0/0x58 (P)
  pci_set_bus_msi_domain+0x74/0x88
  pci_register_host_bridge+0x194/0x548

This is easily reproducible on a Juno board with ACPI boot.

Retain the function for later use.

Fixes: 0644b3daca28 ("irqchip/gic-v2m: acpi: Introducing GICv2m ACPI support")
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c698948..dc98c39 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
 
-static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
 

