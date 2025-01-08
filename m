Return-Path: <stable+bounces-108021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943ABA061BF
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEBE3A148C
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2911FECAD;
	Wed,  8 Jan 2025 16:23:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052915350B;
	Wed,  8 Jan 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353438; cv=none; b=mtiwYPHZKDJenJaGeFQMGIsUj61cZHniYoe4HNN9BBJpmZAblcKW4SK1mpNtcxPTlwHkaHnANywYbUOStwa3toRk0wPwcSEWTCN/H1/pF3TIHHALqopJXIa1GerPpTFuFqgPZMpFgHLFtc2mRhk+RTtcl3jlzNaUWoscJZw/H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353438; c=relaxed/simple;
	bh=6CJG+MljdJ4odyTsRX1HY7g1SI8IaFyVX5WxqVxooCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUGe//0HuTMBFdY4mV7pWsUqGxHUOEt9DiBuulOAkkzOkg5vhNlaPQsbkcL7sEalv+dO2l2yzaYad1rj7DXFrPLAemy61OxQgh72V/scdFFSYV+aZjGn5IG/SeRXTLmBU7S8PC0fhXUD7OG24hOu292tEdqaJjcbLlFX05yVO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so2709907241.2;
        Wed, 08 Jan 2025 08:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353434; x=1736958234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWaN/8ptyC2cYFUazZR9DiU44cT/Ebl32OM7k/AY7UI=;
        b=YAp2KUn60xUP5ZAzMOQKeRQkNS8YG3Lwistz+yvab4MWvICoHlVYc1amGDiye22jxc
         KLYGbDLCR6p+QzvQZC1dScR1oHk2vhxu1IF2BC3XpLMwB2vDUaRfepcAZtTO6UXM/Xy9
         pID2uPxyVAuFxlE3LPSc+3T5inofPmKU4wLp0GQeb6JCtCv4RrA35bjy+7eBuG71kBud
         YuvLJkpfTkdcSY18f0EMFKOgM57w4glKXwfOYXTirMDWsvWlHf7qYqqI3609RFe4hb3q
         lyMSStCM62D8APJ0jixxQEbvp+mFAIYlJN5n+cRZeAtK7CzG1R9NoeOkPROqtbBw9lOu
         Bmmw==
X-Forwarded-Encrypted: i=1; AJvYcCUlOlqI8oIVJ8T82MgYbEanolx5LBIfIzHImNOARtCKdqm9fCHGNG60gDUpQLwVzlv6wgh2Lr0jid/5bw==@vger.kernel.org, AJvYcCWSJKxIe/5PPQG4hXidVVukR5/W0nh+Tt2PjxjUN3TRg2ia1EKP/Ogoqf0p3kjlfXH9V/T1tdWI8SwpMt1e@vger.kernel.org, AJvYcCX6DzM+4cQetaXJRPQpPGBEmeCKHLHAqE6vpUpji1zdLd2bAQPb8UZLFhWz8JbejMreqp2NQVME@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9B2yeusvlSqgugCpqi23z27a4vY81N7rkGiLuWU/vUS1Ysn9F
	inzuzo+yVw40ZN9w6US+11Qt48qnG1QkTPGLAh6gyxBPYc787oWiDEc79aL0
X-Gm-Gg: ASbGnctFHdpviGwF1M8kVxbH85fYc3Sa8zHMJsSMcZpcdAvSvJLjd9rnOjKoFzeWfCt
	KAWn/CQBq2lAwHRHY+7sGYkvPkB69z8p9qzZgPx0GVg2Hs1c7j4EdrJao/y10Y9Z4AJ4BuL2Zw2
	KaE8Alelop5C0a/bkTrYphzilt3nGyo78Ti7Bs+/m8TFyj8mlEsaN7TGXhQfWJ3OYD6WiZzOcN5
	snpB7K6QaI6qATEiub5pfKh8lPCM6QropVo0xWspzRaliMj3PcdGBunKMF7LA0N1cpbgWUkTUzF
	a6EE3jc7vBq5svoWx94=
X-Google-Smtp-Source: AGHT+IEy48mJ4pMCjbpKOgZWV7I89kka6CYye04//JHMwhB0svU5BEFnzu9iNCwuTJEF6j9kWroDFg==
X-Received: by 2002:a05:6122:2a04:b0:518:778b:70a1 with SMTP id 71dfb90a1353d-51c6c50f8e0mr2018297e0c.7.1736353434101;
        Wed, 08 Jan 2025 08:23:54 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68cd97bcsm5025471e0c.33.2025.01.08.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:23:53 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afdd15db60so3576137.1;
        Wed, 08 Jan 2025 08:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkqA98eGIN4PW0aljbe7O4u3pbxCJQCV023YyaL/iTlmP0XMtuXllUrqhHjgDRCeKmlCap9O52@vger.kernel.org, AJvYcCV9M8etpoCWl6xaD1XgSDEcHnABeBDsUhUe47BcVliDbuXC3+dZw9ldcLV35MROlY8BIwDSGiBkZrekUA==@vger.kernel.org, AJvYcCXd4iYthQRTsrTOjPpRypIhjzugzkUNvjYN2JKjv/OtVv4KeEgMChAfMDgh4Yf9Q6txaSiVCg6UMPOL2tiY@vger.kernel.org
X-Received: by 2002:a05:6102:26d4:b0:4b2:5d63:ff72 with SMTP id
 ada2fe7eead31-4b3d0fc1ca8mr2837377137.13.1736353432987; Wed, 08 Jan 2025
 08:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107095912.130530-1-tzimmermann@suse.de>
In-Reply-To: <20250107095912.130530-1-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 17:23:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKNq2PAef0tF_AJv7zgmXQpPgYs5Rwokjo=1M+2n2EBQ@mail.gmail.com>
X-Gm-Features: AbW1kvZp0cV5Of05CmFxR0NTT0IyghMVuM7nBAA7tF5qwUX0JfhnOOwbtasx9h8
Message-ID: <CAMuHMdXKNq2PAef0tF_AJv7zgmXQpPgYs5Rwokjo=1M+2n2EBQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix VGA I/O defines
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Jan 7, 2025 at 10:59=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Including m86k's <asm/raw_io.h> in vga.h on nommu platforms results
> in conflicting defines with io_no.h for various I/O macros from the
> __raw_read and __raw_write families. An example error is
>
>    In file included from arch/m68k/include/asm/vga.h:12,
>                  from include/video/vga.h:22,
>                  from include/linux/vgaarb.h:34,
>                  from drivers/video/aperture.c:12:
> >> arch/m68k/include/asm/raw_io.h:39: warning: "__raw_readb" redefined
>       39 | #define __raw_readb in_8
>          |
>    In file included from arch/m68k/include/asm/io.h:6,
>                     from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/m68k/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:11,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/trace_recursion.h:5,
>                     from include/linux/ftrace.h:10,
>                     from include/linux/kprobes.h:28,
>                     from include/linux/kgdb.h:19,
>                     from include/linux/fb.h:6,
>                     from drivers/video/aperture.c:5:
>    arch/m68k/include/asm/io_no.h:16: note: this is the location of the pr=
evious definition
>       16 | #define __raw_readb(addr) \
>          |
>
> Include <asm/io.h>, which avoid raw_io.h on nommu platforms. Also change
> the defined values of some of the read/write symbols in vga.h to
> __raw_read/__raw_write as the raw_in/raw_out symbols are not generally
> available.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501071629.DNEswlm8-lkp@i=
ntel.com/
> Fixes: 5c3f968712ce ("m68k/video: Create <asm/vga.h>")
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Helge Deller <deller@gmx.de>
> Cc: <stable@vger.kernel.org> # v3.5+

Thanks for your patch!

> --- a/arch/m68k/include/asm/vga.h
> +++ b/arch/m68k/include/asm/vga.h
> @@ -9,7 +9,7 @@
>   */
>  #ifndef CONFIG_PCI
>
> -#include <asm/raw_io.h>
> +#include <asm/io.h>

It definitely makes sense to include <asm/io.h> instead of
<asm/raw_io.h> in this file.

>  #include <asm/kmap.h>
>
>  /*
> @@ -29,9 +29,9 @@
>  #define inw_p(port)            0
>  #define outb_p(port, val)      do { } while (0)
>  #define outw(port, val)                do { } while (0)
> -#define readb                  raw_inb
> -#define writeb                 raw_outb
> -#define writew                 raw_outw
> +#define readb                  __raw_readb
> +#define writeb                 __raw_writeb
> +#define writew                 __raw_writew

OK

>
>  #endif /* CONFIG_PCI */
>  #endif /* _ASM_M68K_VGA_H */

I gave it a try on various configs, and inspected the impact
(none, except for killing the warnings), so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.14.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

