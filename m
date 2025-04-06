Return-Path: <stable+bounces-128419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56763A7CE6D
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B97188B0A1
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040134A24;
	Sun,  6 Apr 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGMy/FCn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GcNYhRKp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABD1B0402;
	Sun,  6 Apr 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743949203; cv=none; b=hB3GGOQAgY/Ytqd3vxaLx7Ta+XyE0A43l7LpxaKP4uSl1JrHz/Wqvu6LXIAH8v01hd0CrKAnaWs+DO5yduDaB8dh9uj4tWXimO3KmGuneiYvrVK64ElaseMuPEitPpS80dhcw3NlnzzhoNYfyit1M8KexPqBvpsZ+7arPIJJQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743949203; c=relaxed/simple;
	bh=ouYSKiwv5pkbXXL7kItO0s9jx0AOASDid2C4y2oKWx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgao+yQCWab9Vq7COoW7EaFgjPFMKkeRuBjjKjBZntWW8IMlUH3qL5Wf/jhtYl1m8B2Xe3LJ/yJZhD+FM7uMAMe5nadC9mwnJ8wjqTfLsWmkxT9/UpBmqYcRo6C7IBH2AUosQ/CHcar4DncDwBMOctFOPxugo9kWhngs/f5K0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hGMy/FCn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GcNYhRKp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743949200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBjodAAYjNvGECjfmVtJ7LaNCbPB+/3rXU7eTDnsHJY=;
	b=hGMy/FCnWBhPc6XmZiylitTrbaU9ffZNpWPWc6LP7zsmGNKnIcGDSNZw+jBDjCDdBu6/Nu
	10DB//q+9RKQha8aozgoq+qJkqjyTpeEjT8znbkOdX5GqXD93Sf/e+i4DkjRYniwk0xztQ
	cFyLAioTScCWVVbVpRstZ2JfYpsbKsfl1HByoBrakfsm2sUqYmRbKi1XmjQh7DNmjRJ6tf
	rQ03Gref/Vzl4qASf5vyEcbOFW84UsMGH2OiiVWWwLKuZEPgbENNFUEHUNkFGzAToUItYf
	yQHj4Uuw6qAbYVGGxa/WLIFcL/3Esgv6/zTvSVfYJ+BNuBLxhUs2Y5og6legHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743949200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBjodAAYjNvGECjfmVtJ7LaNCbPB+/3rXU7eTDnsHJY=;
	b=GcNYhRKp4MCpon64pdPWvl+DniOevLz5nTr+2/PAlQ+hf63cp9d2OpW3dcfzhc1Mg2wHuv
	TcaEn4Min69Sd+Dw==
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, Yinbo Zhu
 <zhuyinbo@loongson.cn>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <CAAhV-H6r_iiKauPB=7eWhyTetvsTvxt5O9HtmmKb72y62yvXnA@mail.gmail.com>
References: <20250402092500.514305-1-chenhuacai@loongson.cn>
 <87jz81uty3.ffs@tglx>
 <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
 <87bjt9wq3b.ffs@tglx>
 <CAAhV-H6r_iiKauPB=7eWhyTetvsTvxt5O9HtmmKb72y62yvXnA@mail.gmail.com>
Date: Sun, 06 Apr 2025 16:19:59 +0200
Message-ID: <875xjhwewg.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06 2025 at 20:46, Huacai Chen wrote:
> On Sun, Apr 6, 2025 at 6:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> On Sun, Apr 06 2025 at 17:46, Huacai Chen wrote:
>> > On Thu, Apr 3, 2025 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
>> >> But it won't trigger on both. So no, you cannot claim that this fixes
>> >> anything.
>> > Yes, it won't trigger on both (not perfect), but it allows drivers
>> > that request "both" work (better than fail to request), and there are
>>
>> By some definition of 'work'. There is probably a good technical reason
>> why those drivers expect EDGE_BOTH to work correctly and otherwise fail
>> to load.
> The real problem we encounter is the MMC driver. In
> drivers/mmc/core/slot-gpio.c there is
> devm_request_threaded_irq(host->parent, irq,
>                         NULL, ctx->cd_gpio_isr,
>                         IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
>                         ctx->cd_label, host);
>
> "IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING" is an alias of
> "IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING", and
> "IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING" is
> "IRQ_TYPE_EDGE_BOTH".

I know that.

> Except MMC, "grep IRQ_TYPE_EDGE_BOTH drivers" can give some more examples.

Sure, but you still do not explain why this works even when the driver
is obviously depending on EDGE_BOTH. If it does not then the driver is
bogus.

Looking at it, there is obviously a reason for this particular driver to
request BOTH. Why?

This is the card change detection and it uses a GPIO. Insert raises one
edge and remove the opposite one.

Which means whatever edge you chose randomly the detection will only
work in one direction. Please don't tell me that this is correct by any
meaning of correct. It's not.=20

The driver is perfectly fine, when the request fails. It then does the
obvious right thing to poll the card detection pin.

So your change makes it worse as it screws up the detection mechanism.

What are you actually making "work"?

Thanks,

        tglx

