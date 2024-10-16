Return-Path: <stable+bounces-86485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D059A0849
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8D51C224C1
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1A207209;
	Wed, 16 Oct 2024 11:26:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA13206066;
	Wed, 16 Oct 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077997; cv=none; b=Xh1/d1b2XUIzG0F8f8lfWqROzHOX1ln85aO5PMC75oJaf66naTqW7ifgjRktlncB0thE59iylRIkchiZxhONAYGPVZyNKDXD4YIITi1rtxbTpY+s7IiUjqGukttg+uYfxcgcb2814GXWeWDyE5ywrPS1J+fkoexCEGpAY0y+Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077997; c=relaxed/simple;
	bh=xP2ktAcfFQ/wdOmDftyeYQc/PCd0CuJ9pfF+bw2S034=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoNsWzeO5X82uLN8G2pQD60E2cTV72sZWMBaxlT+8Q3ehx13baXm1vgJXJQ94Tidax04TY0sZ+DOUs94di+DZoqGgiZXFKG6V0W35zn1n6ZzA3m8QDg5ScsBrn4oAiaovB1URje1/ZrL/vsK3zOqc+pN9F6Ta/7KnOnNrnoi9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B55BF40004;
	Wed, 16 Oct 2024 11:26:24 +0000 (UTC)
Message-ID: <3fe1e610-c863-4fbf-85cb-6e83ba7684af@ghiti.fr>
Date: Wed, 16 Oct 2024 13:26:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
Content-Language: en-US
To: Jessica Clarke <jrtc27@jrtc27.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jason Montleon <jmontleo@redhat.com>,
 stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
 <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 16/10/2024 00:04, Jessica Clarke wrote:
> On 9 Oct 2024, at 08:27, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> Early code designates the code executed when the MMU is not yet enabled,
>> and this comes with some limitations (see
>> Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
>>
>> FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
>> as reported in [1].
>>
>> Reported-by: Jason Montleon <jmontleo@redhat.com>
>> Closes: https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com/ [1]
>> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
>> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Is the problem in [1] not just that the early boot path uses memcpy on
> the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer from
> the compiler’s perspective? If so, it would seem better to use
> unsafe_memcpy for that one call site rather than use the big
> __NO_FORTIFY hammer, surely?


Not sure why fortify complains here, and I have just seen that I forgot 
to cc Kees (done now).


>
> Presumably the non-early path is just as bad to the compiler, but works
> because patch_text_nosync isn’t instrumented, so that would just align
> the two.
>
> Getting the implementation to not be silent on failure during early
> boot would also be a good idea, but it’s surely better to have
> FORTIFY_SOURCE enabled with no output for positives than disable the
> checking in the first place and risk uncaught corruption.


I'm not sure to follow: you propose to use unsafe_memcpy() instead of 
disabling fortify entirely, so we would not get any warning in case of 
failure anyway right? Or do you propose to modify the fortify code to 
somehow print a warning? If the latter, it's hard this soon in the boot 
process (where the mmu is disabled) to make sure that the printing 
warning path does not try to access any virtual address (which is why 
the boot failed in the first place) but maybe Kees has an idea.

And I believe that enabling fortify and using the unsafe_*() variants is 
error-prone since we'd have to make sure that all the "fortified" 
functions used in that code use the unsafe_*() variants.

So to me, it's way easier in terms of maintenance to just disabling fortify.

Thanks,

Alex


> Jess
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

