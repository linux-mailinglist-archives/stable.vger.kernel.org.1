Return-Path: <stable+bounces-194612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40218C52207
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846B83A34B8
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300831355E;
	Wed, 12 Nov 2025 11:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A63002BD;
	Wed, 12 Nov 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948237; cv=none; b=gbHx4gCmB62evSFkHLdJ49/0YP0uj/bP6wpoJFPrUM4WZgE1uZuIaJi3aR6C63g6atwRCinSgPO29UScTKeLZkrhQGGQyt9Dy4VZoHT/ETOU2hE2SuBTJtXtY56OoorEokB2vH40ijUg4YAdRV8U2cDS+2G6BG9RGMDzQCH2gUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948237; c=relaxed/simple;
	bh=qSCucWz0mJH+OSEXRQGAbcPDqAqiHV5POeA8Wi4KgUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn23VcwYF7Ke8oToDabCZ4WAouS7kumKGPqHUUBK5p9XNAxOg4nPI+o1M6tk0U1wXNWkkB9weW8dmWwhjmXqKgZYms684XD1FvaNS+fbHibcslHduZYITvOWxeTt+hnUOFn07dHeE45nnLCYK01EP78KRL4L0k2Pzm6eagdEE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d61cs3rYsz9sSq;
	Wed, 12 Nov 2025 12:38:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id voSrOTdFTJ_x; Wed, 12 Nov 2025 12:38:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d61cs2xwkz9sSj;
	Wed, 12 Nov 2025 12:38:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 50FA38B76E;
	Wed, 12 Nov 2025 12:38:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WkvsJ7_-3Y7V; Wed, 12 Nov 2025 12:38:37 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD9A08B764;
	Wed, 12 Nov 2025 12:38:36 +0100 (CET)
Message-ID: <697723f8-ab0b-4cc4-9e83-ea710f62951a@csgroup.eu>
Date: Wed, 12 Nov 2025 12:38:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer
 used for bootx_printf()
To: Finn Thain <fthain@linux-m68k.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Cedar Maxwell <cedarmaxwell@mac.com>, Stan Johnson <userm57@yahoo.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/11/2025 à 00:30, Finn Thain a écrit :
> Since Linux v6.7, booting using BootX on an Old World PowerMac produces
> an early crash. Stan Johnson writes, "the symptoms are that the screen
> goes blank and the backlight stays on, and the system freezes (Linux
> doesn't boot)."
> 
> Further testing revealed that the failure can be avoided by disabling
> CONFIG_BOOTX_TEXT. Bisection revealed that the regression was caused by
> a change to the font bitmap pointer that's used when btext_init() begins
> painting characters on the display, early in the boot process.
> 
> Christophe Leroy explains, "before kernel text is relocated to its final
> location ... data is addressed with an offset which is added to the
> Global Offset Table (GOT) entries at the start of bootx_init()
> by function reloc_got2(). But the pointers that are located inside a
> structure are not referenced in the GOT and are therefore not updated by
> reloc_got2(). It is therefore needed to apply the offset manually by using
> PTRRELOC() macro."
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
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> Changed since v1:
>   - Improved commit log entry to better explain the need for PTRRELOC().
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


