Return-Path: <stable+bounces-54840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC7912D55
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 20:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526871C25A07
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9D17B50A;
	Fri, 21 Jun 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dz70knYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v74VARbF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140E17B4F1;
	Fri, 21 Jun 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995221; cv=none; b=rAmaBs4WAhFB1YIPnVWwigHpl7lTBeel5rFMcuhtffj/w7rJXlIKCa2q0YmFXui/7xnDMNsVdeanA0mcGIFYLzdQ9Ok7hGbVGIzD67w+nZU/0QDcmS/LlPjeMP7LdghfoZ3C/CVrtGbhpIXbShzjV4O/rEc1rWWv2JqbMILVUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995221; c=relaxed/simple;
	bh=kVkfeZyHUj69SoWVDqqVjTUP9SejBG/wsfbPMuTeoeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNI9AbiAzkN7KuUkmy3jFlR7qtzbslIXwzBxUWzfXFqAzx4pQAIT0eyqax9MqJtF+mw8GkxoxSjC7bbV7NwgCCKHETRt44Ja1bT0aJh8luwQ/5aCxb5q0/q6hWr3rp6PrhefX3d9a+Z6MI3vD3RIkZcGuYvz6/IwCjNberJ8b8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dz70knYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v74VARbF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718995218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8oL0HVT+pepGRoZ/t/HRR9+/cVmQREcSm1WoUChEDM=;
	b=dz70knYH5ZZh+XdoBqh2v3zLwuSZDvomDJEPzqJfK1q13ts4l+ofk4kmLVJplmXM8fCedu
	FuzAqg5F3Fo5dtQsHbfy559XvEB1+6dndfpoz9JILCMirWmRAQgk/dUHP5VyIibAmF+e06
	ebBYe1FwuPpxoyjReb1ebs0FqqlGsX4w3LuEYxqvI+y15sYrjxT8KyfMYdnqDwy51fPxX9
	B5XNj5ykhMyC/6fyt8J6yNI2Af2VbN9KGLMI1eESgKOqod8YRgjk30uqG1yUvvJp2MoC66
	c7BNW587ksNiYAxKoYLbSToqxAsxFqPVvqUmsiL1mjVLphXEU4Zcc3ZOwQZs5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718995218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8oL0HVT+pepGRoZ/t/HRR9+/cVmQREcSm1WoUChEDM=;
	b=v74VARbFXunQIVQadu4FBPBTChxVuZG4e6v+KDHBqvcte0bHRZ29hNzgUWw9sx9tApYIC2
	S8nenCY1VG8zGbAw==
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Xuefeng Li
 <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>,
 stable@vger.kernel.org, Tianli Xiong <xiongtianli@loongson.cn>
Subject: Re: [PATCH] irqchip/loongson-liointc: Set different ISRs for
 different cores
In-Reply-To: <20240612070106.2060334-1-chenhuacai@loongson.cn>
References: <20240612070106.2060334-1-chenhuacai@loongson.cn>
Date: Fri, 21 Jun 2024 20:40:17 +0200
Message-ID: <87y16ym966.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 12 2024 at 15:01, Huacai Chen wrote:
> In the liointc hardware, there are different ISRs for different cores.

I have no idea what ISR means in that context. Can you please spell it
out with proper words so that people not familiar with the details can
understand it?

> We always use core#0's ISR before but has no problem, it is because the
> interrupts are routed to core#0 by default. If we change the routing,
> we should set correct ISRs for different cores.

We do nothing. The code does.

See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tianli Xiong <xiongtianli@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

This Signed-off-by chain is wrong. If Tianli is the author then this
needs a From: Tianli in the changelog. If you developed it together then
this lacks a Co-developed-by tag.

See Documentation/process/

Thanks,

        tglx

