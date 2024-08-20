Return-Path: <stable+bounces-69733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA49958AC7
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C467284F02
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2845191F7B;
	Tue, 20 Aug 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRrcgFek";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6MrGbcf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31B6088F;
	Tue, 20 Aug 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166738; cv=none; b=kwthyiK+rwhMdh22PM/Rjbqldk2yvGab3kbUxgjeph8QJTvCuRQX17kBkIHq44fY83A1T+CrJ4gLT6r7/lIwBjpaTyD/hvJ3swAV6CANoIjYZDfEGr4jAmTwrCVN0RgZ+Z1PP4rofLW/YU/VQ+VXEkrZJZQcWakV/iQaWVDKuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166738; c=relaxed/simple;
	bh=FhagCugxyffpHVTVwvsh1BtJGvW1RGFCc+TAY1sxRB0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YZuqfJw5eMmSqtUCDxjuysiGG4rTaVvaDXNp3ABcliGXFx7QsmJDvt+tnHc+T74na+YqnWDCiBQPoMjCWPAgrBkEtmP2vF29667him+OXZ6+sqmO5LsTktCiuLL3DmweADOQF6yjVFM01hlDqsqM2gEX1H8mC7ab87r3/mRfukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRrcgFek; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6MrGbcf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724166735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0Smyy/OmXK0JngAPePRZVnbcldBdBviQ0czHDUyHQ=;
	b=wRrcgFekRjfFQDFxvYps+MmqJpeDoPKSRNMESgFYYSfqLPaYZRf5skDaoU8b0gmWikXbFb
	PkDG7KqGRYizO4Eh+eSqnjSY9XMGl9N3yg3PguHHN40LpQ31pQrgyQmew294DUSWQd2Wzx
	ZGw0yK7dxfa2JxMf+5i37tmCwLZg3YjrNEtQs7PZKH2mNc+YgsyUEJ0qC/kEH3eI2/HWpP
	pZC6QNL2Yr3XYKd/NIFWZ80+rsir6A0h4NkGNsBMXGOnOKx5wxiIVHPtjadEKBSweZgTvl
	jTa3KxbrN0gLDaHcC9AwCwNBQZR69pwciSjSfL7GgEnMlnjQpMW76+HfNxW/qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724166735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti0Smyy/OmXK0JngAPePRZVnbcldBdBviQ0czHDUyHQ=;
	b=i6MrGbcfmJkersUuSKvL8n/vU6xXFHJTzcLHcMBCNSiyiWIEGfcq8aXOYj5oKsg3z8dF87
	mHwx167RfdSQtICw==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Anup Patel <anup@brainfault.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
References: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416673470.2215.10498834230452989571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     efe81b7bdf7d882d0ce3d183f1571321046da8f1
Gitweb:        https://git.kernel.org/tip/efe81b7bdf7d882d0ce3d183f1571321046da8f1
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Tue, 20 Aug 2024 11:42:40 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 17:05:32 +02:00

irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()

The devm_platform_ioremap_resource() function doesn't return NULL, it
returns error pointers.  Fix the error handling to match.

Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct-mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain

---
 drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 28dd175..981fad6 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
 
 	/* Map the MMIO registers */
 	regs = devm_platform_ioremap_resource(pdev, 0);
-	if (!regs) {
+	if (IS_ERR(regs)) {
 		dev_err(dev, "failed map MMIO registers\n");
-		return -ENOMEM;
+		return PTR_ERR(regs);
 	}
 
 	/*

