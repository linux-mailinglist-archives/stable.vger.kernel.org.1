Return-Path: <stable+bounces-47723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EA8D4EB0
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8982E285F22
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B917F51A;
	Thu, 30 May 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b="BxbK3YbP"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0917F512;
	Thu, 30 May 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081686; cv=none; b=IaIym56QcwgHEQ/mUewLhjoS3EzOar/bmWGu5bPvCZZAPlfrJ1JvRzI/9++vHueOeDDwPrdcfFNPbevzEa3ofuFIUBoGprAn2dGP9Gbn8C/GrGTDXPLjDNSXFf5ZZ/n3YNFlFDk43YsqVBybVCaqg0hMkF3j/Vgw375YZmchaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081686; c=relaxed/simple;
	bh=Pa11LFth+eQqOgfbTEnTARtXJJKp/bt6Wv/siUFKtvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsEOLmH8wVvzxZJfauTd90Lo9aRRjNUj0hLLfQxRMv4Logr7jKoGObqN6C0xMWAC16yRp8lFDwQPU65TqnE7IWBbjDNbFpI94wFWpj3I2TkMFnea1VeaSJ944+cT8HjEYRsy9Gh2Z3MvAWM68qRelFvEG34viWBzIIvzA0rKPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de; spf=pass smtp.mailfrom=heusipp.de; dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b=BxbK3YbP; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusipp.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusipp.de;
	s=s1-ionos; t=1717081650; x=1717686450; i=osmanx@heusipp.de;
	bh=mb7kXFpGBX4A0/kwGZN2V0UfuyCQlIq7DVikbtlTwbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BxbK3YbPIyUu1oVthVFlag/Cd2h1e9uIHPNrRO64XdJ4LhSLOY+0fg64L8Vl3nj5
	 PaPmKIBuD1oPAFurXWwVNBJkuIqpxjLJB+Mi18GaXjpmWBJ04ESbD+9lRXbCMGRu5
	 80z+5t/JANmSbFDkquBFCdcq8RFk8LQ+b/r56tTkEjfUuhvZDI3EgtkQiAWVhboqs
	 PdfOkL7PXwew820CAyG+KffL57UVYWTDKok6hPM8/qmrtjK/FOxABX46+InOmYhEP
	 nXgv7orVt/DQ9w6jchonwPYm6y+HSPol5PXiEpDEbh7betUEq7CDGpzKl/PyopcSp
	 O5XHfPklJZEgvlGBbQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.90] ([91.62.108.110]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N95Nf-1saZ8f16rH-0165Mf; Thu, 30 May 2024 17:07:30 +0200
Message-ID: <f12ab64f-fd59-491e-a44a-6ae570a81ada@heusipp.de>
Date: Thu, 30 May 2024 17:05:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/cpu: Provide default cache line size if not
 enumerated
To: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Adam Dunlap <acdunlap@google.com>
References: <171707898810.10875.17950546903678321366.tip-bot2@tip-bot2>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>
In-Reply-To: <171707898810.10875.17950546903678321366.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vlq/kQBJmGV/Zq/rjceQiQLnB4prXqvO9CRK6z4mBb2ruI3cLXf
 1D6CF9K9PwqSFnwEquSusjOYdFSTznUhvQ/1ghcKdaeLl4Qrk6QGsxtoPdP+KLEStCZG/5q
 YPYzEtJGIl4e9Mao3U73/0xx+brLWiUAjtcd9eMyUxdKzvd+1d1rH2XOsobWcR9nrgCWLAe
 b3UwVfEwES+cetFdyMevw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bHyNZgwEtmQ=;ry7j9VPvrIDQ6l4YE8cO0qjgyHI
 1S7/s7sGiYENwZb401zw2Nsig162np+buJUBUNvQN2QoRdZcD0/QW2uj8ujdUpB0BOt+3qhvS
 ZCl0oPHW6UyBsA1vsvgqPrh31Y7NrpwmCHDqs9TFOkeNEIxelbLw93oaTMjGlUqUJe/h9eiCY
 wui3O/svluhwOafr1ln3bLyX86U9QjAH6WaB7DSpAGYYRqDX8WTYL9XEQ0sqskXgmxMUOav5d
 kw/YSBfDxlmhrHtmeEc0jxuGvPHMVq5jz6e5K+1macrr9dLvZfwp1hM61l0/KiJa7U/OOWBcB
 dtmzdN+iWaI6ksL9FCs+H8dD0yuils1EQ95Bh3JAImlV7c5rY8c08AyqHjY8yOWQKdkMD7NR7
 d5hY4IaEd0blkLMjEuV4Rzmprz0tSeUt+0pHIWKwOydqPurtdSqsn0hgQ7QOKi3pq598OsCKt
 4Q+yudpBUNG0wqzR0jPlOv+oSNgFRxtGtU5SrEJzuZn5pc9sRZkyOyyvBcUmeeyOjBVuxUwzY
 bUtcaRcy3F4+JTN/TOanST5+w+fq0GFZZHIUpYYlMV3yP8dC09QynEyk1i+4BJCTeaSK95mr1
 mL31lP/8BdQXEjRF4RfFI1HEc/HqlHDlX/st6W7HOAvqpQydYKXhUnpegXvlNCxJYgKPSCmSn
 6XWfwvdT5oLvrrN2/qOl16Rfr8SvX/2X5z0d7kObQfgJQcFIqUWQCe3fKf8P6AFeWzRk9Wr7q
 3PPeNVDF9wjYv63laKapQcfoY7ipu1Nw5Ru/QJhb0EWZ3u+JlAZLmo=


Hello Dave!

On 30/05/2024 16:23, tip-bot2 for Dave Hansen wrote:
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     b9210e56d71d9deb1ad692e405f6b2394f7baa4d
> Gitweb:        https://git.kernel.org/tip/b9210e56d71d9deb1ad692e405f6b2=
394f7baa4d
> Author:        Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate:    Fri, 17 May 2024 13:05:34 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Thu, 30 May 2024 07:14:27 -07:00

> Tested-by: J=C3=B6rn Heusipp <osmanx@heusipp.de>

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2b170da..373b16b 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1070,6 +1070,10 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
>   			    cpu_has(c, X86_FEATURE_PSE36))
>   				c->x86_phys_bits =3D 36;
>   		}
> +
> +		/* Provide a sane default if not enumerated: */
> +		if (!c->x86_clflush_size)
> +			c->x86_clflush_size =3D 32;
>   	} else {
>   		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
>

That honestly looks like a mis-merge to me. This is not what I did test.
x86_clflush_size needs to get set in the top-level else branch in which
it is not already set. commit 95bfb35269b2e85cff0dd2c957b2d42ebf95ae5f
had switched the if branches around.

Best regards,
J=C3=B6rn

