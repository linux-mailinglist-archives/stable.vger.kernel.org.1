Return-Path: <stable+bounces-151449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC6ACE255
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA8160F6B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246D1DFE12;
	Wed,  4 Jun 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="rlUTbXSG"
X-Original-To: stable@vger.kernel.org
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D81DDA0C;
	Wed,  4 Jun 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055210; cv=none; b=SH+CjLmiUmVfJnH+bl0OBdY5Ht0BTZu75+CoDOD2Jj94x7XnQuQPMysgzGQV2Gtpvk7njDEA8CP7BRXekcOU5NDuLnHqnnddrLUqrELHttvQVNmTlP40BaxBF6SWsYFuPD05bMdSg80ChTfYOq41M/ESX2YD4+697UX9SwuUvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055210; c=relaxed/simple;
	bh=Z2ajJa3jqcL9eosQXVw90LfEQcomAMUhBxXUYrZ+pRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfM97pUOMpZsoK5yRpjk6S7yliI3b5FHcXgdAeTT7Gvkqq/y+MCxdv+93QMqia7dDqI4n/ifPl/+CR+jYJsxzz76rRn+6VhKTNThFFR7ghBP+EKUF2DAWoWlJq8spzQTy2gNEYyCiSxSUhDi4hDTlMLemeOuKOWAG6luz0kh9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=rlUTbXSG; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1749055199; bh=Z2ajJa3jqcL9eosQXVw90LfEQcomAMUhBxXUYrZ+pRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rlUTbXSG4Q/CMfpm3kh5zEqXZbLVZFgjlx2DWFw2onvZNU5gbu41LEbtC4VnOTn/y
	 kLz/mGTdxNxZlQl3yv3Pe48fI4iYGObu/WyNUS7VimW/Ed0KUPpfGilhq4T7SNi1pA
	 oTvT52PIUJE7uWqYRUPn507LoQsVo7AtsfHH/InA=
Received: from [IPV6:240e:b8f:949a:9000:aa4b:215a:c634:4370] (unknown [IPv6:240e:b8f:949a:9000:aa4b:215a:c634:4370])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EFA376011F;
	Thu,  5 Jun 2025 00:39:58 +0800 (CST)
Message-ID: <edca541e-a2a7-4c26-bea7-15fd0b25597b@xen0n.name>
Date: Thu, 5 Jun 2025 00:39:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall
 wrappers
To: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
References: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
 <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/25 22:05, Huacai Chen wrote:
> On Tue, Jun 3, 2025 at 7:49 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
>>
>> The syscall wrappers use the "a0" register for two different register
>> variables, both the first argument and the return value. The "ret"
>> variable is used as both input and output while the argument register is
>> only used as input. Clang treats the conflicting input parameters as
>> undefined behaviour and optimizes away the argument assignment.
>>
>> The code seems to work by chance for the most part today but that may
>> change in the future. Specifically clock_gettime_fallback() fails with
>> clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.
>>
>> Switch the "ret" register variable to a pure output, similar to the other
>> architectures' vDSO code. This works in both clang and GCC.
> Hmmm, at first the constraint is "=r", during the progress of
> upstream, Xuerui suggested me to use "+r" instead [1].
> [1]  https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-c059c41814cf@xen0n.name/

Oops, I've already completely forgotten! That said...

I didn't notice back then, that `ret` and the first parameter actually 
shared the same manually allocated register, so I replied as if the two 
shared one variable. If it were me to write the original code, I would 
re-used `ret` for arg0 (with a comment explaining the a0 situation) so 
that "+r" could be properly used there without UB.

As for the current situation -- both this patch's approach or my 
alternative above are OK to me. Feel free to take either; and have my 
R-b tag if you send a v2.

Reviewed-by: WANG Xuerui <git@xen0n.name>

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

