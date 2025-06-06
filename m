Return-Path: <stable+bounces-151622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B7AD0413
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8627E189B0E3
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F81487F4;
	Fri,  6 Jun 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o0fVCAu7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbV78xv/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C4273F9;
	Fri,  6 Jun 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220354; cv=none; b=XITcVk0APsgNr2EY22pg3/K42fQFv7r2NAnTRACrCFE/+bQU651WDc9b11rGW/Z0tq8pNxyDrfVxzufUJftgcPF60jTF2XjP0w5NAKJmAv4nZGfhpILpAKezVw+jNkOWBEvnZlCaUKmeEjDU5fbtW13yW0a1ksbLcVd/Ndca5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220354; c=relaxed/simple;
	bh=Ff2Rp9j4NBOeFLfF7FQWEUQ0tr2Bnpij9zj/xPBTNaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL1EUA66U84dPvTR/mCuXd9xeD+FM3J8llcmJohRXv7lEEoM/yUwBZYc0+M8YQLabK1zyUSb9gFuvAGIzY2l4Z+DZuunWPMcUestpqlfbKnd/AEdVsYER7/mmIbWTjkOLIXdJpqnm6spSnV6mL7idw/WBfxBnX4wZgYabp2E3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o0fVCAu7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbV78xv/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 6 Jun 2025 16:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749220345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjFrt4G8uoAeo7Wa/PFQ8eoCWB5B9E9DVZkb9jkc44U=;
	b=o0fVCAu7QHaCC7m+aB1357sY8hTqaVddVEsjvNxq2YCRN7IWa5hVgN3ajW4tPiQNRuYT+1
	s7h5+i0YPfc0SicEvzeos7MWGePfmIYdNzGXkX0NKXQObSNXrVZ2bint6wj+V0+w0pi385
	gs6dxYnWWte5O6sNYpapjsTiRLiPDbn+Y9MUyyV8zmtvnNhogEO5kd2aUNDiIXAy7JvG2y
	rmR8Gw9HE5QNnki9r5jbSw24qnymr1LEqersbR6zOdIehouBlFzIFg7OxxIdT99OIqBCCw
	TL+hYant5VfUAunO3s3S3vVkTgTJQB5DAxQFY8cqvOJvIum1pJg6EwSwBD+FQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749220345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjFrt4G8uoAeo7Wa/PFQ8eoCWB5B9E9DVZkb9jkc44U=;
	b=QbV78xv/UgaUJYdxqb3ih1uUXimLlSIT3Q/ugAXxiSE4y7abG8hTr3te1RU6pK0DH4wRHo
	BYh0Rgm5ZZBLiFBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again
Message-ID: <20250606162758-f8393c93-0510-4d95-a5f8-caaf065b227a@linutronix.de>
References: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>
 <aEL5SIIMxmnrzbDA@yury>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEL5SIIMxmnrzbDA@yury>

On Fri, Jun 06, 2025 at 10:20:56AM -0400, Yury Norov wrote:
> On Fri, Jun 06, 2025 at 10:23:57AM +0200, Thomas Weiﬂschuh wrote:
> > Commit 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > did not take in account that the usage of BITS_PER_LONG in __GENMASK() was
> > changed to __BITS_PER_LONG for UAPI-safety in
> > commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
> > BITS_PER_LONG can not be used in UAPI headers as it derives from the kernel
> > configuration and not from the current compiler invocation.
> > When building compat userspace code or a compat vDSO its value will be
> > incorrect.
> > 
> > Switch back to __BITS_PER_LONG.
> > 
> > Fixes: 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Thanks Thomas. I applied it in bitmap-for-next. Is that issue critical
> enough for you to send a pull request in -rc2?

I have some patches that depend on it. These will probably end up in linux-next
soonish and would then break there.

So having it in -rc2 would be nice.


Thanks

