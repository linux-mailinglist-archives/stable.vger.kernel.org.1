Return-Path: <stable+bounces-110063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACAA185F6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071563A1572
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89861F4725;
	Tue, 21 Jan 2025 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glQlnJGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881861A2550
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490116; cv=none; b=VaWGd4mzFuRqHfhSPryNZwD5M+A7IqDJe3xpiupht0Bocs7Zg339+dliXiFJv0tOC6uMiIL7lNBo9UXf9IBr2+iMzJrqo7oPF2jd099mT5efzqB4PYGWh/QoOEEG4tbvtt2vNYuJWFZD27laImadkvxrDfQGQgG7Vjm6Kui1da8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490116; c=relaxed/simple;
	bh=2ozRUKxYtDqMRoGknG55dc79sbT2VbdW99CaswczXK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTCDTlscKmqhAtZL+QOqRtmp05v8cb7qeBj0LEfADRFr9sJXhs84PiSkJwXPDvFrBfhXT5XALpjBK9YdNt26FP50bIf+TEx11H0ei+jzWoSYvYjtU1WP4Cgw+nUZ61viezo4SRMrs4Y26Eqnm4+wxG4PqIW2bXYZ3AXJ5LcuZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glQlnJGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828D3C4CEDF;
	Tue, 21 Jan 2025 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737490116;
	bh=2ozRUKxYtDqMRoGknG55dc79sbT2VbdW99CaswczXK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glQlnJGMd5sM/abaB/9G1vDy4gf4J66/Vz/qWL54DWxisoPrTaLaLtuHKXxIDQuyZ
	 suFug48ovjYsgOmC2xQxGmWLrPC3h/VNU3CTTKLbWYKm2HYVQfBEEDukxHbKu522E7
	 mJ02RiYaTULU+oiB5++t5/UOfSjFNNGQpQXCRSB5kLsUWB7IERfIF//IU1DwVSHuzX
	 IpUtcc3ApTtBAzZXmRwviiRDq9PBhJh1jAIDs3faqeLNkzDfI7wuOoG38b+P0qI9qt
	 TgZS1jD+AIui5dNq9DaaUSJc4mJPmbKT7lf2IQjButjU/132ASmllA9eJxR1tpFUEj
	 EEIXrJOgdFNgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] gpio: xilinx: Convert gpio_lock to raw spinlock
Date: Tue, 21 Jan 2025 15:08:34 -0500
Message-Id: <20250121150444-679d58b2f8a11294@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250121193205.3386351-1-sean.anderson@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9860370c2172704b6b4f0075a0c2a29fd84af96a


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9860370c21727 ! 1:  849f99ff428f2 gpio: xilinx: Convert gpio_lock to raw spinlock
    @@ Metadata
      ## Commit message ##
         gpio: xilinx: Convert gpio_lock to raw spinlock
     
    +    [ Upstream commit 9860370c2172704b6b4f0075a0c2a29fd84af96a ]
    +
         irq_chip functions may be called in raw spinlock context. Therefore, we
         must also use a raw spinlock for our own internal locking.
     
    @@ Commit message
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250110163354.2012654-1-sean.anderson@linux.dev
         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    +    [ resolved conflicts ]
    +    Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
     
      ## drivers/gpio/gpio-xilinx.c ##
     @@ drivers/gpio/gpio-xilinx.c: struct xgpio_instance {
    @@ drivers/gpio/gpio-xilinx.c: struct xgpio_instance {
     -	spinlock_t gpio_lock;	/* For serializing operations */
     +	raw_spinlock_t gpio_lock;	/* For serializing operations */
      	int irq;
    + 	struct irq_chip irqchip;
      	DECLARE_BITMAP(enable, 64);
    - 	DECLARE_BITMAP(rising_edge, 64);
     @@ drivers/gpio/gpio-xilinx.c: static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
      	struct xgpio_instance *chip = gpiochip_get_data(gc);
      	int bit = xgpio_to_bit(chip, gpio);
    @@ drivers/gpio/gpio-xilinx.c: static void xgpio_irq_mask(struct irq_data *irq_data
      	}
     -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
     +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
    - 
    - 	gpiochip_disable_irq(&chip->gc, irq_offset);
      }
    -@@ drivers/gpio/gpio-xilinx.c: static void xgpio_irq_unmask(struct irq_data *irq_data)
      
    - 	gpiochip_enable_irq(&chip->gc, irq_offset);
    + /**
    +@@ drivers/gpio/gpio-xilinx.c: static void xgpio_irq_unmask(struct irq_data *irq_data)
    + 	u32 old_enable = xgpio_get_value32(chip->enable, bit);
    + 	u32 mask = BIT(bit / 32), val;
      
     -	spin_lock_irqsave(&chip->gpio_lock, flags);
     +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

