Return-Path: <stable+bounces-136578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C48A9AE32
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044D67AA829
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F61E505;
	Thu, 24 Apr 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qh8hlfNO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnuemMGP"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E77F9;
	Thu, 24 Apr 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499704; cv=none; b=gKtEgkRw0PIqz9/YhBrvrvZ22/jUVsJaMUhkPZKuGqc/k/whsyE1axWBCR749bldwHPQe/hA65vMypqppNJew5WbBk0REmdKEbKNhHArvGnMRadjC7DrLWVk44R9+uRb0m6ti28HNFM2meFBgv78qxYj2wEdWi1ChsxswuXASZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499704; c=relaxed/simple;
	bh=TRjcVnbo9iVwByfN8XX61dcat0VDS8AJSl4mOmCqd8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cVIRsD90mNNR1h5PgH0Phgv5OkuzD/f0XVeoWJQGrQmP93eRcfggvPvzjkvnwBPzQ+FGVPVU6tqKkcnGRFKmxnYt6F+f04hKp1VoacPUZBOep5vZrjebYqrHxm8omDtHG5t9QdaVWlXFrU1dasAG1QxyVbXmAaEXXvgtGmWl/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qh8hlfNO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnuemMGP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 13:01:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745499700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mufq346iA/QgHaWNhMsVwIv5hZEByGrwzYGfPFBTwpI=;
	b=Qh8hlfNO6NOy1bW4ZVV4rI0sPRS5TQLijIoxd9+XXb/lq6axbih0rBTR0AjN1d9FT53GcI
	j6yszvVMx1vkYe7nTeQRiVAL2AtbZfPKt2Zw40vVr/DS759e3x8QopijrAaxxak1bl7yMo
	UPvLHv8d0jdvmeMCm4lUP7yddo5bEdZIgyfezv5IISFNUNcwNBLSLM0IwS3voRLSxkq9bB
	zyU0LnD6BzUNWHoYZPJp2ZNcPZ8sXr/HavGr0brSzrWsGKr+h3xORTmI+J3yvTLjGloUjB
	a7lOI7UeiQSkluOu317dvk0B6gHzkHP5rdIo7rkZRXnB/tuhnXRFtoxVIZ/dLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745499700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mufq346iA/QgHaWNhMsVwIv5hZEByGrwzYGfPFBTwpI=;
	b=MnuemMGP8DTQLYFRRMmYP6Fbk3jAX9IjQA5wEnIEpJrIzocJ1tGoDgk9XRqU7U3eLwAaI1
	p5MZ3kZ+sqX1/KAA==
From: "tip-bot2 for Suzuki K Poulose" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v2m: Prevent use after free of
 gicv2m_get_fwnode()
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174549967937.31282.3096387842170950901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     637cf959dac97d5b7b5ce5e6cd91dd3a2c2fc324
Gitweb:        https://git.kernel.org/tip/637cf959dac97d5b7b5ce5e6cd91dd3a2c2fc324
Author:        Suzuki K Poulose <suzuki.poulose@arm.com>
AuthorDate:    Tue, 22 Apr 2025 17:16:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 14:47:52 +02:00

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
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/all/20250422161616.1584405-1-suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch
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
 

