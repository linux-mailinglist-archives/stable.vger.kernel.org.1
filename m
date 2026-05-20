Return-Path: <stable+bounces-253402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKn3GJ8wDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722159BC13
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF6B43035337
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8AA3438A3;
	Wed, 20 May 2026 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjZptnA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA12C11CF;
	Wed, 20 May 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314716; cv=none; b=u8TishljjPIZ6MzId1SmFGADfU5mjj0CsvO2ZEruQOZHwhTmdZJ7q328STfW+7ySjrBCfbiFk5HunAV3oUVIFVpXnEE6Apm/ljGx4dx7dslIt7QDX4CWkAJ7mx1qk6Dj/NyIGWpRX29aK726tduKmAnTlop5BlCgwzvT3AYtTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314716; c=relaxed/simple;
	bh=E7xfMtcSd732QE5ywnqmiYLayCoQaITmMAbE0+Ia9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtJuryvKIbNs/HgDVsXb9C1lzJgpFyb4N6nS4HMg0JchvRIAdBPFMWgvvqzZFuRuXntNE5MEJlHwm3CIB6JXOrdkFeXziGl4daU0tkSnvzV4d1LpH0b8L6Fjm3gonLQd1oBOEpWIWBTCL1EudSkhTYNxJFO0mFbwYBH08KMK920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjZptnA2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C55E1F000E9;
	Wed, 20 May 2026 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779314714;
	bh=oq9Mw1eKArGqNiiPPS6OfCCiC3moAy62JaIiwg4FYGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OjZptnA2p7MwDsZqUia/e0Ldxb0S2eKL9tftaz8UoeriRZQwV8nzWf9ZZHU31Bbrm
	 dDsE6mDoprCn0JRJNfP/RDiJfxuReIOKBtU8RbzZa7CC1l8Rqi7TwfISLPCxHe/YEY
	 wu8E93XzdOT6Qdi8vXnEW8QNo+wHKmFWpcEkvTHbx2MqTYS4k+hPq3pBsVEeJI6/gO
	 CrKed2ZivtRm2CNqxHAXm8HpuldELoc6BLy7pl7XieADC4PADe7ByAxR4GHZ0rLkqo
	 VoJP3o+1I8KmcIEe1pMrmQPn/We54ZFzaq6sCW0SjJTShFB0QTv5uZ6JYfslnrjNtA
	 OMOks5OTaTomQ==
Message-ID: <9344c408-af6a-4ca7-b481-1c26c9491b64@kernel.org>
Date: Thu, 21 May 2026 00:05:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
To: David Laight <david.laight.linux@gmail.com>
Cc: Mingcong Bai <jeffbai@aosc.io>, linux-kernel@vger.kernel.org,
 Xi Ruoyao <xry111@xry111.site>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20260517041423.71243-1-jeffbai@aosc.io>
 <20260517145421.2d1ac77c@pumpkin>
 <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
 <20260520194301.06d96a5f@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260520194301.06d96a5f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,xry111.site,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,aosc.io:email,outlook.com:url,gnu.org:url]
X-Rspamd-Queue-Id: 0722159BC13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 20/05/2026 à 20:43, David Laight a écrit :
> On Wed, 20 May 2026 15:14:40 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> Le 17/05/2026 à 15:54, David Laight a écrit :
>>> On Sun, 17 May 2026 12:14:21 +0800
>>> Mingcong Bai <jeffbai@aosc.io> wrote:
>>>    
>>>> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
>>>> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
>>>> warnings:
>>>>
>>>>     ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
>>>>        59 | #if __BYTE_ORDER == __BIG_ENDIAN
>>>>           |
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C3ed26b8c3d6449fdc29608deb69fac66%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639148994069314641%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FfFnXxMPXXxoOMM8fYU4df5gMjk3B2dPgQsjwUagaNA%3D&reserved=0
>>>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>>>> ---
>>>>    arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
>>>> index 8b957aabb826d..db8525605c026 100644
>>>> --- a/arch/powerpc/include/asm/sfp-machine.h
>>>> +++ b/arch/powerpc/include/asm/sfp-machine.h
>>>> @@ -319,10 +319,12 @@
>>>>    #define abort()								\
>>>>    	return 0
>>>>    
>>>> -#ifdef __BIG_ENDIAN
>>>> +#ifdef __BIG_ENDIAN__
>>>>    #define __BYTE_ORDER __BIG_ENDIAN
>>>> +#define __LITTLE_ENDIAN 0
>>>>    #else
>>>>    #define __BYTE_ORDER __LITTLE_ENDIAN
>>>> +#define __BIG_ENDIAN 0
>>>>    #endif
>>>
>>> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or 4321.
>>> (apart from pdp11's 2143).
>>
>> That's the case, in include/linux/kconfig.h we have:
>>
>> #ifdef CONFIG_CPU_BIG_ENDIAN
>> #define __BIG_ENDIAN 4321
>> #else
>> #define __LITTLE_ENDIAN 1234
>> #endif
>>
>> But as far as I understand the problem is that math-emu expects
>> __BIG_ENDIAN to be defined at all time as it has tests like:
>>
>> #if __BYTE_ORDER == __BIG_ENDIAN
> 
> The gcc docs have (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fcpp%2FCommon-Predefined-Macros.html&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C3ed26b8c3d6449fdc29608deb69fac66%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639148994069350793%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=D0BlZT73XnqHXHN2ukPFFUQw5lCCwaKfkmp6vMHz0Gk%3D&reserved=0):
>       
> __BYTE_ORDER__
> __ORDER_LITTLE_ENDIAN__
> __ORDER_BIG_ENDIAN__
> __ORDER_PDP_ENDIAN__
> 
>      __BYTE_ORDER__ is defined to one of the values __ORDER_LITTLE_ENDIAN__, __ORDER_BIG_ENDIAN__, or __ORDER_PDP_ENDIAN__ to reflect the layout of multi-byte and multi-word quantities in memory. If __BYTE_ORDER__ is equal to __ORDER_LITTLE_ENDIAN__ or __ORDER_BIG_ENDIAN__, then multi-byte and multi-word quantities are laid out identically: the byte (word) at the lowest address is the least significant or most significant byte (word) of the quantity, respectively. If __BYTE_ORDER__ is equal to __ORDER_PDP_ENDIAN__, then bytes in 16-bit words are laid out in a little-endian fashion, whereas the 16-bit subwords of a 32-bit quantity are laid out in big-endian fashion.
> 
>      You should use these macros for testing like this:
> 
>      /* Test for a little-endian machine */
>      #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> 
> The doc doesn't mention the value, but __ORDER_BIG_ENDIAN__ is 4321 (decimal).
> 
> So the math-emu code is neither following gcc's rules or the kernel ones.
> 
> Your change will break anything that currently does:
> #ifdef __BIG_ENDIAN
> 
> Any change would have to be limited to code that is implementing math-emu.

asm/sfp-machine.h is only included by math-emu it seems, so the change 
should be safe.

Apparently math-emu predates git history, not sure where it comes from.

Christophe

