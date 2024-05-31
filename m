Return-Path: <stable+bounces-47780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9968D6041
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76A91F245FA
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F055156F5D;
	Fri, 31 May 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/XEjAfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKsOzkUr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EEB156F40;
	Fri, 31 May 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153635; cv=none; b=GECmuWadJGgAdwIg47L+bVI2m7vRe3DzaP8xQ6T/JrYr+vFxyaVDEnrVcP7V4ok+ZToCAaBfiT0hwRgDub8XHSPDzKV8nBI7YTbTaFJCZCRua+LGMHoLXg6V9VFeJEwqEbDHzQw70Ati14Qz/NTn7NBmItk0owrFq5r7+Trmbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153635; c=relaxed/simple;
	bh=6BdJBfJi3/hKy025d+ICYZ25W57C7s5dGvKI2oY6Bi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0UAbSXZ69BIsr3zkEg09BRzK9t/YU4RF+219Xax6uTBKBm5Q4bZjqfarjSWDzLxNZb2jZHQ0BO3sF1iQh6FednJu/E12alyiacz9CrDVAvifltCiT6TWAVpyKbi4fS0x/4xlL1POFpNztYcjGuCr8ytnoYJW8l3sTWuiwyzS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/XEjAfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKsOzkUr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717153632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FD0fGIRiutsDCzqA9Wo0A4UkGRJFH8vm9F7UrtzuEDQ=;
	b=W/XEjAfRDrDL/9o3/dStC9ktRMG1+Zp1J8nqufGvrnn/3GqqM3DbSwxSmW7b9KAqi+ihxY
	jiji14vA0nYwaeGOZR642YylvcczGxzuxSiQFXfeDD4leatfvkh6i+o4JqRBri/rnBoNNC
	TnaI4Llv0bMFLGHvC54PPcQoC140j7VE/7i/jzRTBhrOD4K3tFnunPQMWhWxMBmfsh8Zcd
	qRC26tb6/1YwN5PDSSaXherqT6PW1c9INK1dJw0byW7Z+D1Pm1ylqIDqqP19c3262OKV7o
	kpE6htXDLuC5/kSUEVVqUWdtUYcEEnN6WIq/9eRc/bbTXIbFXELZM22Q7mTfcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717153632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FD0fGIRiutsDCzqA9Wo0A4UkGRJFH8vm9F7UrtzuEDQ=;
	b=hKsOzkUrC3wOQHxuCr3fJAcwdxVwHVXS/T3VKo0fb6TpheOdVxRdQayDghPW/v2e6SGZgV
	ohGPgsx3X9ktiKCQ==
To: Christian Heusel <christian@heusel.eu>
Cc: Peter Schneider <pschneider1968@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
Date: Fri, 31 May 2024 13:06:50 +0200
Message-ID: <87wmna6y0l.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 31 2024 at 10:16, Christian Heusel wrote:
> On 24/05/31 10:13AM, Christian Heusel wrote:
> [    0.046127] TSC deadline timer available
> [    0.046129] CPU topo: Max. logical packages:   1
> [    0.046129] CPU topo: Max. logical dies:       1
> [    0.046129] CPU topo: Max. dies per package:   1
> [    0.046131] CPU topo: Max. threads per core:   2
> [    0.046132] CPU topo: Num. cores per package:    10
> [    0.046132] CPU topo: Num. threads per package:  12
> [    0.046132] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs

This looks correct.

> [    0.117308] smpboot: x86: Booting SMP configuration:
> [    0.117308] .... node  #0, CPUs:        #2  #4  #5  #6  #7  #8  #9 #10 #11
> [    0.009676] [Firmware Bug]: CPU4: Topology domain 1 shift 7 != 6

So this means that the E-Cores have a different topology information for
the CORE shift value than the P-Cores which is definitely wrong.

Let's see what cpuid -r reports.

Thanks,

        tglx



