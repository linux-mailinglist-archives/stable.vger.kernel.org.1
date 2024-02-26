Return-Path: <stable+bounces-23717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC68679CE
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE34128EF3E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12F1369B9;
	Mon, 26 Feb 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zo8GnIBm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9qzAfDA7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8712FF76
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959830; cv=none; b=nONBeYZbHaJN4q0MLGAQ8GlhCUxzsFsEeOK05pXjE6ARZ+srGHXjEzlcLq/aHGI2PXGIeeLvWz+R/0IphNABG/QoxX1hXrZpGheSzkgXpfeR1zNNy3YqoNuNr5KjwpPC4ICe+VZ3+GYbT4WcKQ/apXQ0urm8jxfU6P/aXKbIW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959830; c=relaxed/simple;
	bh=bFiRvSqI79dr8UML85xQ5TUoN9Nl3VEzJu7t8Aj1j48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SWCCDFNtiaO1gdzY0PTyZlc+0DqAhDn3q1QMIqoPHsbFvEVayMYm2h2VY4RGhkCQp1Tg2VEWmUMaackVySlb8M55HurG+RybjvpQRkIWNn8/ZtEP5WptNoPKPrwm+U9YsO3mUk2F+M5Subf5rVZGGJ7uF9CT2QvoVMxUB6DTYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zo8GnIBm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9qzAfDA7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708959826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adgPOP5opoCsXQA5vvJQMdh0DK4NK4c/OLbz9zs6OHg=;
	b=Zo8GnIBmXcx+9/R5fbwkuDmEcCdtj9PWhU/CDHS+xZdaVsi5G+UHsyJF2q3Jgj9PoTQTzY
	WCe2B4XJ5gYYEtTFabxlWqU+XPfGC1XVAhzlsmLQPAx3e75kBEmjT/3zesKyYcdJza/EU4
	aUZTfbi+OVVdIDaXBtS2HNKY6w1uW+awk1/HyIkcEWMTN6hRUPR6PIGmiBIh9P3po/DYqG
	sUYSos4AtBseXV+nbxoN5ISk/CSgwEAOYU2msonLbLVwzJE0AGQs95MTzbHFqDKWCfrADx
	yBeDAFJ/dB9TuvL40K/5BP8UpZszuVqVZI5w7QAqfcV3JtDBHp1ZyCuEKPbYxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708959826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adgPOP5opoCsXQA5vvJQMdh0DK4NK4c/OLbz9zs6OHg=;
	b=9qzAfDA7B8yu5L241F+Wl8w3uaaln2UyxMRbdYpp1yxH9oOvpJeEeSkU9ZJ722jz3/1H7U
	wASlcDtcK6EqgFCQ==
To: gregkh@linuxfoundation.org, vidyas@nvidia.com, sdonthineni@nvidia.com
Cc: stable@vger.kernel.org
Subject: [PATCH linux-4.19.y] PCI/MSI: Prevent MSI hardware interrupt number
 truncation
In-Reply-To: <2024022609-womanless-imprison-678c@gregkh>
References: <2024022609-womanless-imprison-678c@gregkh>
Date: Mon, 26 Feb 2024 16:03:46 +0100
Message-ID: <8734tfb73h.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Vidya Sagar <vidyas@nvidia.com>

Commit db744ddd59be798c2627efbfc71f707f5a935a40 upstream.

While calculating the hardware interrupt number for a MSI interrupt, the
higher bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI
domain number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting in
same hardware interrupt number for devices 0019:00:00.0 and 0039:00:00.0.

To address this cast the PCI domain number to 'irq_hw_number_t' before left
shifting it to calculate the hardware interrupt number.

Please note that this fixes the issue only on 64-bit systems and doesn't
change the behavior for 32-bit systems i.e. the 32-bit systems continue to
have the issue. Since the issue surfaces only if there are too many PCIe
controllers in the system which usually is the case in modern server
systems and they don't tend to run 32-bit kernels.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ tglx: Backport to linux-4.19.y ]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115135649.708536-1-vidyas@nvidia.com
---
 drivers/pci/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1311,7 +1311,7 @@ static irq_hw_number_t pci_msi_domain_ca
 
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)

