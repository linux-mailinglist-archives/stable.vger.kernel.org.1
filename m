Return-Path: <stable+bounces-47879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6868D870E
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 18:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252D5B209A1
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771C134415;
	Mon,  3 Jun 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ioz63HV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkifY63Y"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8534132134;
	Mon,  3 Jun 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431646; cv=none; b=RaWxLxDU8aclGnXX1D7xCiGE+VjoZwPI8cdX0IhtSqpL7eEi9wpr77FWHn/FtMsChzWuw4hfO7ns/ig0/HBw5E65EDpASORhx+Goacij/XZJfno3mSkYm2+ZCqhLHaVcRUiyYkBssJ/UHK9uZAmLzoCwzSQ0Bf/EsKyn8zidGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431646; c=relaxed/simple;
	bh=tAh8BEKe9KGyLkew/OUaE+pHQOosCHCwdAXwE/GUMU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqO1Xjih7fTv8E824/uGhLwOGttOEoJzP3p1jw7yvIDlNUC06JRAkfY9n/a3CtOF/DreDiZIouFdRl2e7hG/+OVcSawdEoAdUuyerOmouCPwkMitTmXXBuTyrggRSwsaCMfpesUzCcxbAQbO4Vx+MHSenDEGc37RUoGwQkXMguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ioz63HV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkifY63Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717431643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9B+7uwm/MkuKDK5YQG4gGBGAExES3AfLJdIdJres/Q=;
	b=4ioz63HVkWP70a4QHN4OIHUu2Ie5KAVQhHVpmIyI6scnRpLDG7rKqdZtcrRv/AYQDlsm0F
	grIY3fqgZHFeyoPcXwstRjcZYyXdMsQHzqEr72yxURbkDwU381cGyESPyzGZIkUz28dmpW
	9RUJLSHq+m8dqnTPA+wviLkcfFXvXQSbjGJBfJFmo15Z0IYhaitiXD0uKzC+lM7eTwgwpB
	nxo4CnNoyGYDJ7jquaNADTZLn8k0M6PWTgnK2qRvZpLttW+sHLCEcyjAvVzEeu6FTSydLu
	tFKID6PJBbJpjWrZIoJ640ZUAhN3ssIbaTlHu7wpNc5LAUCFJwKL1OTtuBZeUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717431643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9B+7uwm/MkuKDK5YQG4gGBGAExES3AfLJdIdJres/Q=;
	b=nkifY63Yem/s1TH/4C8SaefAeBLme2UHLQFDqeVK3hXsXye4FEDoVyUdU4yfyVeBlhmjP8
	GRrjjS+vVsx7XkCQ==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Hagar Hemdan <hagarhem@amazon.com>,
 stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: irq/urgent] irqchip/gic-v3-its: Fix potential race
 condition in its_vlpi_prop_update()
In-Reply-To: <86h6eakoc9.wl-maz@kernel.org>
References: <20240531162144.28650-1-hagarhem@amazon.com>
 <171741750653.10875.4371546608500601999.tip-bot2@tip-bot2>
 <86h6eakoc9.wl-maz@kernel.org>
Date: Mon, 03 Jun 2024 18:20:42 +0200
Message-ID: <875xuq6lr9.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 03 2024 at 17:01, Marc Zyngier wrote:
> On Mon, 03 Jun 2024 13:25:06 +0100,
>> @@ -1992,6 +1970,8 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>>  	if (!is_v4(its_dev->its))
>>  		return -EINVAL;
>>  
>> +	guard(raw_spinlock_irq, &its_dev->event_map.vlpi_lock);
>> +
>
> I don't think this compiles as is, due to the funky syntax required.

Stupid me. I obviously compiled the wrong config to validate...

Fixed now.

