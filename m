Return-Path: <stable+bounces-152255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95DAD2E7E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A7E1713A1
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2727AC3D;
	Tue, 10 Jun 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVX88lGZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZy3ZD5E"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231114685;
	Tue, 10 Jun 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539992; cv=none; b=nXUAgzb3bAUp9vC9TyoyhbkAooHbjsUB+lAM2gN24MQrwAkEuFV9U0advZT0SMvDwW9/WenW87qbqWirnNc7pP9Ni1g5C8aNXrQwklOCBT4L89xU/yjzQzVNWw2Jgdt1VLZxsRlzCIQO6OEToisj03t7haqdNsRBFR8+kjMN9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539992; c=relaxed/simple;
	bh=ItcQtJolu+J789jhe4umM4IrWwdgR2F4NRZEe+mXbfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8/CxbbI8hHilNHYEkMmGr+vFyxAGh1CIGMzOV4JkyMAjxxRBeuOf7R2xhka0yhki5Yuv5W7ZPeRqnUVWCo289Btcft34WzYsBNlXQ+zUAjqhW46kGRJvCeQlRPZjj/64PlMI8O6O52Dtn5UrI28kgJytS+abjWa1AGyYdf1Qww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVX88lGZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZy3ZD5E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 09:19:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749539989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP7spxVH7sLmjym4ThWhMog4sWfbU7quRM39gydlBGY=;
	b=vVX88lGZ1h1PQ7EVgLSMjk5n2YsjdgSA87I9b2L/+Epdg75LMWJmrbES7JsGslfCNoxA3f
	ASnhi/MzuLMw7G94d8iY42b9utKwY130oo625hqoXBTQjw+gIfRSeTN9B0feuKHFld82yo
	GWJKJjeBaH4Dx0b6QVmB4K6Spu8wFD2DD1W0XOrCeM2NWB4k/D2DNSM3n0Z9r+/ScNA6/z
	Yqlued7ZJ4QO22GlvO5GmjNaWSabKNkK7VdKADCtndZe9rIN9q+a2eHsRu0TwFbi33TYOJ
	Zl86DTeY32kTD9X6AnI3ZrRKEBQ4F7qTSHWCzxZZZHTiwjMIw3Rm4uqiTSbJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749539989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP7spxVH7sLmjym4ThWhMog4sWfbU7quRM39gydlBGY=;
	b=DZy3ZD5ExOnp9B9x3Irzzy1QzB7VBtwWAN2Jp5lnlF+2AaCcfD0ve40urbBx93IFqfUgJt
	FQaZ3fx22S+1nAAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again
Message-ID: <20250610091238-51888002-5c91-4716-b3bc-f6bd28cbee61@linutronix.de>
References: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>
 <aEL5SIIMxmnrzbDA@yury>
 <20250606162758-f8393c93-0510-4d95-a5f8-caaf065b227a@linutronix.de>
 <aEaRpf_sHip9wH3G@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEaRpf_sHip9wH3G@vaxr-BM6660-BM6360>

Hi I Hsin Cheng,

On Mon, Jun 09, 2025 at 03:47:49PM +0800, I Hsin Cheng wrote:
> On Fri, Jun 06, 2025 at 04:32:22PM +0200, Thomas Weiﬂschuh wrote:
> > On Fri, Jun 06, 2025 at 10:20:56AM -0400, Yury Norov wrote:
> > > On Fri, Jun 06, 2025 at 10:23:57AM +0200, Thomas Weiﬂschuh wrote:
> > > > Commit 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > > did not take in account that the usage of BITS_PER_LONG in __GENMASK() was
> > > > changed to __BITS_PER_LONG for UAPI-safety in
> > > > commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
> > > > BITS_PER_LONG can not be used in UAPI headers as it derives from the kernel
> > > > configuration and not from the current compiler invocation.
> > > > When building compat userspace code or a compat vDSO its value will be
> > > > incorrect.
> > > > 
> > > > Switch back to __BITS_PER_LONG.
> > > > 
> > > > Fixes: 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > Thanks Thomas. I applied it in bitmap-for-next. Is that issue critical
> > > enough for you to send a pull request in -rc2?
> > 
> > I have some patches that depend on it. These will probably end up in linux-next
> > soonish and would then break there.
> > 
> > So having it in -rc2 would be nice.
> 
> Thanks for pointing out the problem, may I ask in what config would
> cause "BITS_PER_LONG" to work incorrectly ?

In my specific usecase it was when building the powerpc compat vDSO.
For an easy reproducer use:

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801a97ef..948619848a3b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -16,6 +16,9 @@
 # define VDSO_DELTA_MASK(vd)   (vd->mask)
 #endif
 
+_Static_assert(__BITS_PER_LONG == sizeof(long) * 8);
+_Static_assert(BITS_PER_LONG == sizeof(long) * 8);
+
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
 static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u64 delta)
 {

> I would love to test the difference between them and see what I can get,
> thanks.

Looking at this again, the UAPI headers don't even define BITS_PER_LONG.
The vDSO just incorrectly ends up also using the regular kernel headers.


Thomas

