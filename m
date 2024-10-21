Return-Path: <stable+bounces-87470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E859A65F7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE733B21E97
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533041F4FDD;
	Mon, 21 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8aHdZbi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097761E47C1;
	Mon, 21 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507700; cv=none; b=HVMKZNVOE3YHMUiI+EGPcgf/FgMCA1Rufiij9tX3WDOMfcjhKnfaggwR2QjPHzIhlWDk8f6eky/+IZXAZVa8wwpif909ZfV2CnUrPUC+DHhQyg+2n6PPL7ELL+AXeyWT5cVxg9DGsdrPdbNvhrngxVRq97AnTb5EOlKUzf4Rw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507700; c=relaxed/simple;
	bh=NVHrzQirNXTACKnWLIa4LlEjR733JC8LqCJGpPtWoPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knDU/eu6owuArRfonB9sXNfD47us8GVDhx+YWhPZ3fHyS1/Pgf6sMJYuDUQof64J6vURv0sw5z7iXVeQPsHWyPHEwRbS05Afje8w5kaxisdoFmA8cdbN5ths6EMUSRMjcqdJWEfppm5ZRaZ6k4uODcqVAuRmdbXAlALvHtounVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8aHdZbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B474C4CEC7;
	Mon, 21 Oct 2024 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507699;
	bh=NVHrzQirNXTACKnWLIa4LlEjR733JC8LqCJGpPtWoPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8aHdZbi5pYxYlgD7NOq9OTFZNYT0eGLJW0mvHYZdnI6wZ4gzKDAeoM3M41d5/VUD
	 WvAWUZIEsqRWN+8AVPRSYJQ6wDeNOFanMDmdVFbvoC0DjUwmYjWr2BS0K2vA7N868m
	 OAl3jonoHHP4jXBbwTf2rhdWs7SQeR7MCFSLdHrU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.15 72/82] pinctrl: ocelot: fix system hang on level based interrupts
Date: Mon, 21 Oct 2024 12:25:53 +0200
Message-ID: <20241021102250.061402380@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Matsievskiy <matsievskiysv@gmail.com>

commit 93b8ddc54507a227087c60a0013ed833b6ae7d3c upstream.

The current implementation only calls chained_irq_enter() and
chained_irq_exit() if it detects pending interrupts.

```
for (i = 0; i < info->stride; i++) {
	uregmap_read(info->map, id_reg + 4 * i, &reg);
	if (!reg)
		continue;

	chained_irq_enter(parent_chip, desc);
```

However, in case of GPIO pin configured in level mode and the parent
controller configured in edge mode, GPIO interrupt might be lowered by the
hardware. In the result, if the interrupt is short enough, the parent
interrupt is still pending while the GPIO interrupt is cleared;
chained_irq_enter() never gets called and the system hangs trying to
service the parent interrupt.

Moving chained_irq_enter() and chained_irq_exit() outside the for loop
ensures that they are called even when GPIO interrupt is lowered by the
hardware.

The similar code with chained_irq_enter() / chained_irq_exit() functions
wrapping interrupt checking loop may be found in many other drivers:
```
grep -r -A 10 chained_irq_enter drivers/pinctrl
```

Cc: stable@vger.kernel.org
Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/20241012105743.12450-2-matsievskiysv@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-ocelot.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1279,21 +1279,21 @@ static void ocelot_irq_handler(struct ir
 	unsigned int reg = 0, irq, i;
 	unsigned long irqs;
 
+	chained_irq_enter(parent_chip, desc);
+
 	for (i = 0; i < info->stride; i++) {
 		regmap_read(info->map, id_reg + 4 * i, &reg);
 		if (!reg)
 			continue;
 
-		chained_irq_enter(parent_chip, desc);
-
 		irqs = reg;
 
 		for_each_set_bit(irq, &irqs,
 				 min(32U, info->desc->npins - 32 * i))
 			generic_handle_domain_irq(chip->irq.domain, irq + 32 * i);
-
-		chained_irq_exit(parent_chip, desc);
 	}
+
+	chained_irq_exit(parent_chip, desc);
 }
 
 static int ocelot_gpiochip_register(struct platform_device *pdev,



