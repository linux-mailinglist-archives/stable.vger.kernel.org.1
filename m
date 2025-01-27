Return-Path: <stable+bounces-110851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEDAA1D489
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADE03A78D9
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39831FCCF3;
	Mon, 27 Jan 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wh70ZcK9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ryfxDeDy"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5125A63A;
	Mon, 27 Jan 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973835; cv=none; b=sCpuHgIs/4IqseHHvuXJ8cKm5qCTDvQ1XEEn+e9778dMatNbPL2RYBUu64vk0rv7nZAMZoKVCw56VWHJmEIo7FL8BkBjowcnpn49gm61uU+mjFCtd6lxWG59WEjq+/2z7SxA7r1G0oNCgTyf72xXrkRHi2a+00/jrVi272BayJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973835; c=relaxed/simple;
	bh=rFh4F968f/v/kArYJfML5kuBR1gx+LmYfebyJBX080U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0+7+kFOTOrl/QIROorBbTNFTn7Xsoo/OAyw0xILrgsHzbXxzpcjDmyB+cwL+2IYB9RwhryaKff3xZH4EJoa4RpvZMW8gxK+Qxrjwv1LMm11fbzUghVd48aQyPzI9CAvxPeV0pX/l25HU0P19odN/P7Xk1U2NTaD/M7gROuNuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wh70ZcK9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ryfxDeDy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737973832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoTJIxjM/g1WxUH67XffHodkk6JcBynnDz8cI4nr0gk=;
	b=Wh70ZcK9IRdaDAMlsqNO9xBeJYA54wYNkoo+R83Svmce05g5PUsT0PiDGjy1V5FrEEaU7t
	ZnLZvfW8y80xLjgXKIry5yKYcjUCGWxiXiVFtoaCoKxZVfrBr62ftYsmPTgguT6lxxGXrW
	aP5B7B+px4R6a1GnfMv2i9V3NdZcW6cKXtiHkv03EgE04Hy5eJZS2LiEomXcya9xzwhdvt
	uPnjemOY18dXufCDUZP71yCuiOgALlgtu+3zAzrxkgf2WI8oYio5WmSYZUS+EwTixHkinm
	nOlIeIHm11iaoPpx7XqjgdjQbqp3g/6HtLzzjIyqiiGnEvN/gtb+dJHzRWmAdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737973832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoTJIxjM/g1WxUH67XffHodkk6JcBynnDz8cI4nr0gk=;
	b=ryfxDeDynswhIXKIl4gjBhNKbRi9mbPiNQmj0zvSIqXe9mm3CvJ2nYif1Hb28BCLIUDP2u
	5m+ZUL6jkphOIhBw==
To: Stefan Eichenberger <eichest@gmail.com>, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 shivamurthy.shastri@linutronix.de, anna-maria@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/irq-mvebu-icu: Fix access to msi_data from
 irq_domain
In-Reply-To: <20250124085140.44792-1-eichest@gmail.com>
References: <20250124085140.44792-1-eichest@gmail.com>
Date: Mon, 27 Jan 2025 11:30:32 +0100
Message-ID: <87sep48s6v.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 24 2025 at 09:50, Stefan Eichenberger wrote:
> Previously, we incorrectly cast irq_domain->host_data directly to

Previously 'we' do nothing. The current implementation casts inconrrectly.

> mvebu_icu_msi_data. However, host_data actually stores a structure of
> type msi_domain_info.
>
> This incorrect assumption caused issues such as the thermal sensors of
> the CP110 platform malfunctioning. Specifically, the translation of the
> SEI interrupt to IRQ_TYPE_EDGE_RISING failed, preventing proper
> interrupt handling. The following error was observed:
> genirq: Setting trigger mode 4 for irq 85 failed (irq_chip_set_type_parent+0x0/0x34)
> armada_thermal f2400000.system-controller:thermal-sensor@70: Cannot request threaded IRQ 85
>
> This commit resolves the issue by first casting host_data to

This commit is equally wrong as 'This patch'. See Documentation/process/

> msi_domain_info and then accessing the mvebu_icu_msi_data through
> msi_domain_info->chip_data.

I fixed it up for you.

Thanks,

        tglx

