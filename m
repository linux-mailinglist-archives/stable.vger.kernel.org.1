Return-Path: <stable+bounces-47694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC8B8D48E9
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01E61C2233E
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1D1534ED;
	Thu, 30 May 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b="DsWAWnaw"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691318396D;
	Thu, 30 May 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062614; cv=none; b=FXVENgJTu+RCQvxI4qudR4+XqX4QjnZrfUEiE6eJa5Flgy7zABN583oMIWZqXPOFYPqLnvH/qTvaFzjA6suWAAUvujWNM9mJy/eFha1ZYgVbA2aUv9PTENhv1gMSMY4YpUxZc9KM5jK0yeQt+oKx+/5dbzx+ns5KcxUBaXizSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062614; c=relaxed/simple;
	bh=rJtFgvYvWHNW5N6glbUkLYI5JWdxEzVApMNTJ75qYmA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gZjbDB0HyMmTIIVqH/ozQO05CzCMIxjIcm7fRX3HfoIdACYWPMsQobFPkpgrJLNxQw/1y/gb0fj414Ue7k2vQH1+gt4VxjVGOXdcSRMRYVih1xpAkVrU6rtX2+004zDT/IYavCgD36BT4mYTiJpVc+FXNSuYvzeCZnj/crztLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de; spf=pass smtp.mailfrom=heusipp.de; dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b=DsWAWnaw; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusipp.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusipp.de;
	s=s1-ionos; t=1717062591; x=1717667391; i=osmanx@heusipp.de;
	bh=dj5x0qPMNpYiNhks6W9RvrhVYROulCGUJxQMpvNOkNs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DsWAWnawpvwiMyCOqTAItI7GtFwqyNDy4GwntZWFxFwXywNlBLEEhWiSVre564e7
	 7xlqXEp7GJgoe9mHOvz6JkAMNhB+/qJ28vJ+CnWpB2CSOituZySJQckp+IYr6a/3T
	 ez0v+6qQRYCjA8xNNXoL76Gezl+YzLWbLmOgsL5QPw2o0k9eqn+VjP9b46xqxk6+E
	 sTFbPmlroJN56zMWydKlDnbHUR7I4dTPJp3+I3/ScWSV7EeeN6iSUdpfOxz8TUXAq
	 s4ZVoyXnHfvw7Ic1dNecIb/J5+0UeoqRMBdXLzHYpCtxKK36aAg6WGzM+zAb4GLCG
	 lo6VK3pF6lSzI7bO+w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.90] ([91.62.108.110]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZCSn-1rzfzS1xhZ-00U3br; Thu, 30 May 2024 11:49:51 +0200
Message-ID: <bd00b65f-d0ab-415a-ad5c-41bcb079ecc1@heusipp.de>
Date: Thu, 30 May 2024 11:47:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>
Subject: Re: [PATCH] x86/cpu: Provide default cache line size if not
 enumerated
To: dave.hansen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com, bp@alien8.de,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
References: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
Content-Language: en-US
In-Reply-To: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3To5N+GG4wJb7wdsTpIkMtlrr02CcHhd4jpviP6AdZr7mLuhgV
 3GPf9v3Jn5LxO8uVsP15HupU39HtBEJ3QdH8edSnkMxreYwjSHnoOyEDC2mk0YC/fJihSRN
 lX1wRUfOPhl1ZaGm6y9YlBpYL5vSO7gSPwlPUpBg8bjsXeK1ji25YXd82wQCUnB0eUheL6U
 UgMT2bw0I5CCP0a+XP6wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A21ACE0awT8=;+WxS8Gk3pzlSMgHqO4tQHxZW+Pk
 irbpDGyh4mYLDGiUedcSzbYQsw8QIZgITR8uJROlefgFowpsZnRH2PsizspdupUk0dvodFceC
 fcacXVEBM+hm+ewRZbtIvIReL0lvWyF1efaPRLI/bVY1edUhR7WxbzqNZhbN5SbLGOOW7WVgq
 G/KqOY+UllmBXsCo2yW4MJrZdDm9gB2qSffRLtEL0OpEK81lkb08qlbjfNyefOG4gZRP31LTb
 sLVn8PnsTeseZBbddDkgW5UH+8VpSv258HLJ4ePsUlJWXT5xyqqjT6lqlNJBTNRbvU91sS8Zi
 7oHzgTtvBo8YPt0+aPfQq//wjP+Jt7ZtPNqWjzyw8x6xcioGknw3iTljOZWKzMUHnopYWFX1B
 Nx+bQDuOTcBgJf8T2ME1B7AZ5qQM0Ykw1Od3vFl9Bn6NeCQJF577JUv/AHKQvskqjlP+krTuq
 EaRDoDVbCGPoCE+zsXhtVYTfYDJUkOz+LmSJ2lEu06se26LGxgZDSt5Ha7/O06/+gMPQPe57z
 hcyx3sTNYB+SfRYW6/ah4xgE1b/HE9xJIkCF60w++kt/jLPRBwje+Leykwd205yBzX84CNCu7
 v7q5FNauVlWZ4h2/cIa3ANFh5KYtNPxivrdkzTsffdhjm9A6FWbI7UlH6X5g5F+ZQoowHv2gS
 PbNMTpEm5LAE3LtxioQfKsbeEhco97Uee2OxfsFi3/8UZ32wN1ypuGjjNi4y7g9aKxY1YGXpS
 vDfQ0NpSJtTJV0/S4vBTTDuNQwbLHbWLgkYMEcwDe6bBIkONrI2uF8=


Hello!

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
> will end up reporting cache_line_size()=3D=3D0 and bad things happen.
> Fill in a default on those to avoid the problem.
>
> Long Story:
>
> The kernel dies a horrible death if c->x86_cache_alignment (aka.
> cache_line_size() is 0.  Normally, this value is populated from
> c->x86_clflush_size.
>
> Right now the code is set up to get c->x86_clflush_size from two
> places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
> have leaf 0x80000008 (or CPUID at all) just get some sane defaults
> from the kernel in get_cpu_address_sizes().
>
> The vast majority of CPUs that have leaf 0x80000008 also get
> ->x86_clflush_size from CPUID.  But there are oddballs.
>
> Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
> CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:
>
> 	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
> 	if (cap0 & (1<<19))
> 		c->x86_clflush_size =3D ((misc >> 8) & 0xff) * 8;
>
> So they: land in get_cpu_address_sizes(), set vp_bits_from_cpuid=3D0 and
> never fill in c->x86_clflush_size, assign c->x86_cache_alignment, and
> hilarity ensues in code like:
>
>         buffer =3D kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
>                          GFP_KERNEL);
>
> To fix this, always provide a sane value for ->x86_clflush_size.
>
> Big thanks to Andy Shevchenko for finding and reporting this and also
> providing a first pass at a fix. But his fix was only partial and only
> worked on the Quark CPUs.  It would not, for instance, have worked on
> the QEMU config.
>
> 1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/Genuin=
eIntel/GenuineIntel0000590_Clanton_03_CPUID.txt
> 2. You can also get this behavior if you use "-cpu 486,+clzero"
>    in QEMU.

Tested-by: J=C3=B6rn Heusipp <osmanx@heusipp.de>

See
https://lore.kernel.org/lkml/5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusipp.=
de/


Best regards,
J=C3=B6rn

