Return-Path: <stable+bounces-66305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30A94DB8A
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2E1C20CDA
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5414D2A8;
	Sat, 10 Aug 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B+qIo6I3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BH9CrZL5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAA14C5B3;
	Sat, 10 Aug 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279521; cv=none; b=m7j3JOYqzIZqr2DR4EsaJ8pP8QiYQDcCB6qRgiLFLG8sJagJBmCzkwqhw/zBW1ODimcJXXWnKfJBfKaR9u7ZySR6veo015d6pDC0/bvlzfNp27Cp3OQBZB2SmJfGKnkDZdFzcZC0HsF10z8Uxxhxsxca5mEOuUB4VQ0dmzl/z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279521; c=relaxed/simple;
	bh=SuPUJenUXnr0BMBShF0UHK3iUChHp7wzXRULMT/jlwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NZDHV7WGGbhnSpQDTOVE2E4qyTLtN5SpgFOU9B2ofK6Hq8OqvhKaLUr24eW3CEqDAcuaCAqEc/ZlwTeb3YaVFCtWuBSHRH3+zhOoeyxnvUJh9eA3LU6kNiDU9KGZMHkhVQjgg5sumn7Oh+d6ppN0MlfXmo5DbD2+GpYkl33QyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B+qIo6I3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BH9CrZL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Aug 2024 08:45:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723279518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy/kMvBkr+hruugCsGp0VY/ojuxjrCUy6tkeoB7pQRs=;
	b=B+qIo6I3700aFsGolfbe/1FF3oO8FXKqNyqUbL9/CBF4IqoaqdHztQWuDriWy3HOH+6Jqn
	NVIaxWrhb7pkUtIgcLctinjiY9qJY+9vIkNXPk4FjrvXNhCjcxC/d9XwLjpe9qjQi3Q7E3
	c+wqETP4d/4vgH/l++P9H51MmOeKtDMw2kIBTWSOIXAJ2W7jJ2x4p0N6rda6ZDbVf44Tsi
	RkXXWYYg7qANRxHoeaIKMCPwFOEvFogAKrnzouHRV2gFPLGg2qob3ruFV7C5Q0Xqtf4anU
	PqVVoxOiYxqxqSdM74KdEPciwX4reSC7+TqOPlU+n5HvKL941vPbIUXDYA559Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723279518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy/kMvBkr+hruugCsGp0VY/ojuxjrCUy6tkeoB7pQRs=;
	b=BH9CrZL5HaC44KvXVJlLeC2kwiqitthUvihhKfJwdHIp1WrkpOy9k7uIV3vs38vj0iv8XR
	TKp4t5jNwgildvDw==
From: "tip-bot2 for Radhey Shyam Pandey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/xilinx: Fix shift out of bounds
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <1723186944-3571957-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1723186944-3571957-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172327951777.2215.8494612611829907133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d73f0f49daa84176c3beee1606e73c7ffb6af8b2
Gitweb:        https://git.kernel.org/tip/d73f0f49daa84176c3beee1606e73c7ffb6af8b2
Author:        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
AuthorDate:    Fri, 09 Aug 2024 12:32:24 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Aug 2024 10:39:24 +02:00

irqchip/xilinx: Fix shift out of bounds

The device tree property 'xlnx,kind-of-intr' is sanity checked that the
bitmask contains only set bits which are in the range of the number of
interrupts supported by the controller.

The check is done by shifting the mask right by the number of supported
interrupts and checking the result for zero.

The data type of the mask is u32 and the number of supported interrupts is
up to 32. In case of 32 interrupts the shift is out of bounds, resulting in
a mismatch warning. The out of bounds condition is also reported by UBSAN:

  UBSAN: shift-out-of-bounds in irq-xilinx-intc.c:332:22
  shift exponent 32 is too large for 32-bit type 'unsigned int'

Fix it by promoting the mask to u64 for the test.

Fixes: d50466c90724 ("microblaze: intc: Refactor DT sanity check")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/1723186944-3571957-1-git-send-email-radhey.shyam.pandey@amd.com
---
 drivers/irqchip/irq-xilinx-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 238d3d3..7e08714 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -189,7 +189,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",

