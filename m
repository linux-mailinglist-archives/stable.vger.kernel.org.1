Return-Path: <stable+bounces-192833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47885C43B97
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4A8188945A
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37028489E;
	Sun,  9 Nov 2025 10:20:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196DA221299;
	Sun,  9 Nov 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683644; cv=none; b=XpbW+3cqsd/9hC7H//kTpADqEoCy9o/iiGRLmHJLfnC3iwyIxBjZvCpZG92kZuz0KJiLdi5HQONv4SyvYTm9FWGIcMdGVsAGA/SfZa8Ip//YWi0s/CmWIQlW0XZJoEdKfI4TNv4kCHiCQnmiCE/YKWOR7PWs5KHa9vIqAe72Ymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683644; c=relaxed/simple;
	bh=SEopC2/3odri8g9wb1KBvHrgrUFJUmIYYhOYzFwgBvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu6OwqJA4zg1We9oluN+K1DJbJT0C8C/8GZ6/Cr9IjEhdX80F/cxG8Ah4F745qEh3Z4CyPotarxQenNwSEFDV+Yi++PznM+lhPC8xXph53Fv9u8H/yRnru2t+n6rxPrnomoE9u/xYp/2p2M0RSsFVax2doGF78ixqlFBcqILcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d47Jy2P0lz9sSH;
	Sun,  9 Nov 2025 10:48:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4g6UDkaIzWZF; Sun,  9 Nov 2025 10:48:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d47Jy1C6Vz9sS7;
	Sun,  9 Nov 2025 10:48:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 180918B764;
	Sun,  9 Nov 2025 10:48:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kQzC0qppv8Je; Sun,  9 Nov 2025 10:48:17 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F75F8B763;
	Sun,  9 Nov 2025 10:48:17 +0100 (CET)
Message-ID: <a7d9feaa-3a52-4c72-be56-6757e75af2ac@csgroup.eu>
Date: Sun, 9 Nov 2025 10:48:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Use relocated font data pointer for
 btext_drawchar()
To: Finn Thain <fthain@linux-m68k.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Cedar Maxwell <cedarmaxwell@mac.com>, Stan Johnson <userm57@yahoo.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <d941a3221695e836963c8f9cb5fbb61e202bad0c.1762648546.git.fthain@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <d941a3221695e836963c8f9cb5fbb61e202bad0c.1762648546.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/11/2025 à 01:35, Finn Thain a écrit :
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Since Linux v6.7, booting using BootX on an Old World PowerMac produces
> an early crash. Stan Johnson writes, "the symptoms are that the screen
> goes blank and the backlight stays on, and the system freezes (Linux
> doesn't boot)."
> Further testing revealed that the failure can be avoided by disabling
> CONFIG_BOOTX_TEXT. Bisection revealed that the regression was caused by
> a patch which replaced the static btext font data with const data in a
> different compilation unit. To fix this, access the font data at its
> relocated address.

You can explain that characters start being displayed by bootx_init() 
which is call very early in the boot before kernel text is relocated to 
its final location. During that period, data is addressed with an offset 
which is added to the Global Offset Table (GOT) entries at the start of 
bootx_init() by fonction reloc_got2(). But the pointers that are located 
inside a structure are not referenced in the GOT and are therefore not 
updated by reloc_got2(). It is therefore needed to apply the offset 
manually by using PTRRELOC() macro.

> 
> Cc: Cedar Maxwell <cedarmaxwell@mac.com>
> Cc: Stan Johnson <userm57@yahoo.com>
> Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: stable@vger.kernel.org
> Link: https://lists.debian.org/debian-powerpc/2025/10/msg00111.html
> Link: https://lore.kernel.org/linuxppc-dev/d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com/
> Reported-by: Cedar Maxwell <cedarmaxwell@mac.com>
> Closes: https://lists.debian.org/debian-powerpc/2025/09/msg00031.html
> Bisected-by: Stan Johnson <userm57@yahoo.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 0ebc7feae79a ("powerpc: Use shared font data")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> 
> ---
> 
> Christophe, as you're the author of this patch, this submission will
> probably need your sign-off.

I only suggested it, you authored the patch. Add me as:

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> 
> ---
>   arch/powerpc/kernel/btext.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
> index 7f63f1cdc6c3..ca00c4824e31 100644
> --- a/arch/powerpc/kernel/btext.c
> +++ b/arch/powerpc/kernel/btext.c
> @@ -20,6 +20,7 @@
>   #include <asm/io.h>
>   #include <asm/processor.h>
>   #include <asm/udbg.h>
> +#include <asm/setup.h>
>   
>   #define NO_SCROLL
>   
> @@ -463,7 +464,7 @@ static noinline void draw_byte(unsigned char c, long locX, long locY)
>   {
>   	unsigned char *base	= calc_base(locX << 3, locY << 4);
>   	unsigned int font_index = c * 16;
> -	const unsigned char *font	= font_sun_8x16.data + font_index;
> +	const unsigned char *font = PTRRELOC(font_sun_8x16.data) + font_index;
>   	int rb			= dispDeviceRowBytes;
>   
>   	rmci_maybe_on();


