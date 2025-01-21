Return-Path: <stable+bounces-110048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F179A185A1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907E03AC22F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1431BCA0E;
	Tue, 21 Jan 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChGRWyO3"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26263192B84
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737487644; cv=none; b=rd0tWRy/5ypwfCKGqpFL3DdM6sCr8dAacYHWKUq8cV70vtbUdFYmjb4gHR0UvJBQd5lNvCBY3uz+34nMYcVhO2w6ZWlgj+S6EV9MtGWVPP4eO3mA6gJQ8Cc9e+eRqin1u6WyrfNWAmfj8tIjI8FRXrER3/lR+6GsH/CnKVe+0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737487644; c=relaxed/simple;
	bh=hFfFdjjpF4++JUqLnRNV4qBt05TlBtC6E5bQhrfzMjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZS7FEyosZlWQOQXN/Pp1s38uvTHmekUGz8DFJHagl4pp+swJelCs/Ir7BdroLtEjLp2+2O5roosmkpoLS8ull0X836bwayZ8abgRw11xjTHQngwk1UUO8PqaeDdCyL3K9WgOGLlgAGoIjsRtlTnEsXhj2uO2D4YD4OhwiEr5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChGRWyO3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1bdc02e-fd8c-4018-b6ae-01c1f5e74a2c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737487634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgE/jprC2tr/0w7GSTIuDQiAw0VoiL+b67zdp70RXpg=;
	b=ChGRWyO3YcBP3WnfcbyLZZvnALBxlmM4kPd8Xz6g1/3GbFbJGEf3Wi+24uJfdjZugbca6B
	hviTToJG7Vo5a3JiIchcVI1qoktgNumHBpYZCY5GSQrdjfV1u1PDiqBv6aFqWWbF4diLs1
	EoCBwwHB+D18n0WwJbkTHOVkFJslrxw=
Date: Tue, 21 Jan 2025 14:27:10 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] gpio: xilinx: Convert gpio_lock to raw spinlock
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <2025012027-shaft-catalyst-2d69@gregkh>
 <20250121184148.3378693-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250121184148.3378693-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/21/25 13:41, Sean Anderson wrote:
> [ Upstream commit c17ff476f53afb30f90bb3c2af77de069c81a622 ]

Whoops, wrong upstream commit

> 
> irq_chip functions may be called in raw spinlock context. Therefore, we
> must also use a raw spinlock for our own internal locking.
> 
> This fixes the following lockdep splat:
> 
> [    5.349336] =============================
> [    5.353349] [ BUG: Invalid wait context ]
> [    5.357361] 6.13.0-rc5+ #69 Tainted: G        W
> [    5.363031] -----------------------------
> [    5.367045] kworker/u17:1/44 is trying to lock:
> [    5.371587] ffffff88018b02c0 (&chip->gpio_lock){....}-{3:3}, at: xgpio_irq_unmask (drivers/gpio/gpio-xilinx.c:433 (discriminator 8))
> [    5.380079] other info that might help us debug this:
> [    5.385138] context-{5:5}
> [    5.387762] 5 locks held by kworker/u17:1/44:
> [    5.392123] #0: ffffff8800014958 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3204)
> [    5.402260] #1: ffffffc082fcbdd8 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3205)
> [    5.411528] #2: ffffff880172c900 (&dev->mutex){....}-{4:4}, at: __device_attach (drivers/base/dd.c:1006)
> [    5.419929] #3: ffffff88039c8268 (request_class#2){+.+.}-{4:4}, at: __setup_irq (kernel/irq/internals.h:156 kernel/irq/manage.c:1596)
> [    5.428331] #4: ffffff88039c80c8 (lock_class#2){....}-{2:2}, at: __setup_irq (kernel/irq/manage.c:1614)
> [    5.436472] stack backtrace:
> [    5.439359] CPU: 2 UID: 0 PID: 44 Comm: kworker/u17:1 Tainted: G        W          6.13.0-rc5+ #69
> [    5.448690] Tainted: [W]=WARN
> [    5.451656] Hardware name: xlnx,zynqmp (DT)
> [    5.455845] Workqueue: events_unbound deferred_probe_work_func
> [    5.461699] Call trace:
> [    5.464147] show_stack+0x18/0x24 C
> [    5.467821] dump_stack_lvl (lib/dump_stack.c:123)
> [    5.471501] dump_stack (lib/dump_stack.c:130)
> [    5.474824] __lock_acquire (kernel/locking/lockdep.c:4828 kernel/locking/lockdep.c:4898 kernel/locking/lockdep.c:5176)
> [    5.478758] lock_acquire (arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [    5.482429] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [    5.486797] xgpio_irq_unmask (drivers/gpio/gpio-xilinx.c:433 (discriminator 8))
> [    5.490737] irq_enable (kernel/irq/internals.h:236 kernel/irq/chip.c:170 kernel/irq/chip.c:439 kernel/irq/chip.c:432 kernel/irq/chip.c:345)
> [    5.494060] __irq_startup (kernel/irq/internals.h:241 kernel/irq/chip.c:180 kernel/irq/chip.c:250)
> [    5.497645] irq_startup (kernel/irq/chip.c:270)
> [    5.501143] __setup_irq (kernel/irq/manage.c:1807)
> [    5.504728] request_threaded_irq (kernel/irq/manage.c:2208)
> 
> Fixes: a32c7caea292 ("gpio: gpio-xilinx: Add interrupt support")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250110163354.2012654-1-sean.anderson@linux.dev
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [ resolved conflicts ]
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>  drivers/gpio/gpio-xilinx.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 2fc6b6ff7f16..58cbf763ee21 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -66,7 +66,7 @@ struct xgpio_instance {
>  	DECLARE_BITMAP(state, 64);
>  	DECLARE_BITMAP(last_irq_read, 64);
>  	DECLARE_BITMAP(dir, 64);
> -	spinlock_t gpio_lock;	/* For serializing operations */
> +	raw_spinlock_t gpio_lock;	/* For serializing operations */
>  	int irq;
>  	struct irq_chip irqchip;
>  	DECLARE_BITMAP(enable, 64);
> @@ -181,14 +181,14 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>  	struct xgpio_instance *chip = gpiochip_get_data(gc);
>  	int bit = xgpio_to_bit(chip, gpio);
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	/* Write to GPIO signal and set its direction to output */
>  	__assign_bit(bit, chip->state, val);
>  
>  	xgpio_write_ch(chip, XGPIO_DATA_OFFSET, bit, chip->state);
>  
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  }
>  
>  /**
> @@ -212,7 +212,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
>  	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	bitmap_replace(state, chip->state, hw_bits, hw_mask, 64);
>  
> @@ -220,7 +220,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  
>  	bitmap_copy(chip->state, state, 64);
>  
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  }
>  
>  /**
> @@ -238,13 +238,13 @@ static int xgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  	struct xgpio_instance *chip = gpiochip_get_data(gc);
>  	int bit = xgpio_to_bit(chip, gpio);
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	/* Set the GPIO bit in shadow register and set direction as input */
>  	__set_bit(bit, chip->dir);
>  	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
>  
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  
>  	return 0;
>  }
> @@ -267,7 +267,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  	struct xgpio_instance *chip = gpiochip_get_data(gc);
>  	int bit = xgpio_to_bit(chip, gpio);
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	/* Write state of GPIO signal */
>  	__assign_bit(bit, chip->state, val);
> @@ -277,7 +277,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  	__clear_bit(bit, chip->dir);
>  	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
>  
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  
>  	return 0;
>  }
> @@ -405,7 +405,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
>  	int bit = xgpio_to_bit(chip, irq_offset);
>  	u32 mask = BIT(bit / 32), temp;
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	__clear_bit(bit, chip->enable);
>  
> @@ -415,7 +415,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
>  		temp &= ~mask;
>  		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
>  	}
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  }
>  
>  /**
> @@ -431,7 +431,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
>  	u32 old_enable = xgpio_get_value32(chip->enable, bit);
>  	u32 mask = BIT(bit / 32), val;
>  
> -	spin_lock_irqsave(&chip->gpio_lock, flags);
> +	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
>  
>  	__set_bit(bit, chip->enable);
>  
> @@ -450,7 +450,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
>  		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, val);
>  	}
>  
> -	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
>  }
>  
>  /**
> @@ -515,7 +515,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
>  
>  	chained_irq_enter(irqchip, desc);
>  
> -	spin_lock(&chip->gpio_lock);
> +	raw_spin_lock(&chip->gpio_lock);
>  
>  	xgpio_read_ch_all(chip, XGPIO_DATA_OFFSET, all);
>  
> @@ -532,7 +532,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
>  	bitmap_copy(chip->last_irq_read, all, 64);
>  	bitmap_or(all, rising, falling, 64);
>  
> -	spin_unlock(&chip->gpio_lock);
> +	raw_spin_unlock(&chip->gpio_lock);
>  
>  	dev_dbg(gc->parent, "IRQ rising %*pb falling %*pb\n", 64, rising, 64, falling);
>  
> @@ -623,7 +623,7 @@ static int xgpio_probe(struct platform_device *pdev)
>  	bitmap_set(chip->hw_map,  0, width[0]);
>  	bitmap_set(chip->hw_map, 32, width[1]);
>  
> -	spin_lock_init(&chip->gpio_lock);
> +	raw_spin_lock_init(&chip->gpio_lock);
>  
>  	chip->gc.base = -1;
>  	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);


