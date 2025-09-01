Return-Path: <stable+bounces-176806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0DB3DCF8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33CA7A1EAB
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E412FE56D;
	Mon,  1 Sep 2025 08:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45572FB99B;
	Mon,  1 Sep 2025 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716537; cv=none; b=NWKZ+ZAW11YgGOhwn2l6O0V+nwvjSUt1+GihtanbrRH/TOhxbE2nF1zwERFsqKLdvQuciWcgpQ/kr4+X4rXLP4/YueZpwyO0prJoCOnDVr2VhxM+0jQqB6DjSbnD7csE2CiFrfxTOoF/f/hQSOpoXaqPC1/6f/JnzVtiWboZMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716537; c=relaxed/simple;
	bh=8MZNME6CUICip8YLriqh73EGkN+aVtZ5jOj2xggld9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5SCuS2D3hEd/l7wZCexH9umwawxjAXRga3SB7rJuLwy5gFMSKPwld1JM8SBah66bmnzj6V6k+hsBhQNWOKdkCScb+U8ubPwqsWJ/8I4lb4JVfCJZ0NTJiyuBYkXkzobmUFVyG4ZTpSaw+Q8LymEuNUiP5jnvDflKh1TlBQZ87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-523264ecab8so1373478137.2;
        Mon, 01 Sep 2025 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716534; x=1757321334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06Sj7xDyFNchhNG4bIMKlTkghy/c7Pe7YTc3T5dsw5o=;
        b=WVQQ3lc8zJPPPyy2NlorQVG61HloSG5ye0vy0UFHz8lcEwEDNHpZdNqAdi+66mvpX+
         w/yQXxU8NCpwqfyP6CEG8tBpkjOGFClV4x9dQ7Oi0bID+kttYRV1FcrrnS3F5/Ui1k2+
         hfqf8MwwrgOX+HiiSFD0Y72aPrhOvKVixadsFU45BabSIG6igNULELjpD+q3keak9Yag
         LCTB9cD+adKZyQQO1o6ym98zQn7I6OzFO2QeFMSnLx0To8ZTkzp8XJloHv77fpPAQhm3
         2uBXoYGJIDklC2ZHFwcPn01tpWp2cfL6HkZIlRlAy9MMiA1GkhQIvCPT5FJtDg2iXUs9
         aw2A==
X-Forwarded-Encrypted: i=1; AJvYcCWK7rCJMFlIE3P38rzQpbe40rZyj3Dr55jK86GSFHAlXeRmuFEkba6BfLAXLOgmmJOHJtqoUUODzgaI2WY=@vger.kernel.org, AJvYcCXtwf/gavrTDR3jShQfYn5FS8eVcbP9V/j5/Y84QHeJOF518Bv+0+MgYZNIsXkWjp7cq5ds9YK+@vger.kernel.org
X-Gm-Message-State: AOJu0YwbC5mnDtLMZeKzxFyZw+yi8GgXu+G7hX5+Ajjje2Cir2M9W7H4
	HmRlX0asR7SYvgSQKOP0ZDvR7WUmC+RsCvdm9+C+s+HtjP6a030y/46izVBABYE7
X-Gm-Gg: ASbGncvddAyPCwZK4vy9RYn4odPRdXuzA0zS+DEn8ufS1S3ZwN8bA7bnpbL5mClaZDS
	uOKRcq+COOTx/vwWs9Tz4WQ8FFgVQa76BhnHMXV77eAKq8AUM+WAl7K0chvbMLdS9Omf6ZHwJmR
	/I68GjvqNtYYGzKRJ/8jAAudqYyGDwiRhNZjvFpNM7wDpMjJNd62P7WaJjlQj4N7yLygvxpXPa3
	mZl2NRURXMgFvpvlJ20fm0FDhNWLqKFLtCTqI7IsdXhDY9+utz6Heiri/ZX2A2by3/S2A1LibSu
	pDyjdSXRuMQTj8TxxJPB0UV/tfj3rCUlz2Qnq3DXa4yHqSsHwYc6HBjFcoG1tMuQeAte3GF2cYE
	9zwdJp5XUim2GmX+TDQQ2IujMb+3MGyCBtgLSS+A0EgRCO78gBGYzsgJB/51G6NbRFaAT/Pw=
X-Google-Smtp-Source: AGHT+IEOCgWGLP4sjICEfqdw0ujKRIpJg3pSeRWeRRH0PN6TMJRAZ8urdVTRfJF2bFHmCn9j0j6oPw==
X-Received: by 2002:a05:6102:d90:b0:521:760c:7aa5 with SMTP id ada2fe7eead31-52b1c14162fmr1363766137.33.1756716534386;
        Mon, 01 Sep 2025 01:48:54 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943ba52cb1sm3503112241.11.2025.09.01.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:48:54 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-529858dc690so871132137.0;
        Mon, 01 Sep 2025 01:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6XrA+5UAhUKIwomGfVkH8IbhW4GMF8R0iSKmu+ioI3f7CsiRfntYVqC118gyIYWeXEnRXTqp1@vger.kernel.org, AJvYcCVwjCRyBFb8H0HiusGKvXKMIyEUVnDU4hHSSde0zBl8PtiVhstTd2u0pdxkOMSZQIWa6NjU/KJB28DYirU=@vger.kernel.org
X-Received: by 2002:a05:6102:41a6:b0:521:ed06:1fd2 with SMTP id
 ada2fe7eead31-52b1b2ee877mr1843595137.16.1756716533551; Mon, 01 Sep 2025
 01:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev> <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev> <20250825130715.3a1141ed@pumpkin>
In-Reply-To: <20250825130715.3a1141ed@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 10:48:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXg=0Q9e1O6W0Gp+fPoP8-5VQ-2fGGg54w=seaqF9H8PQ@mail.gmail.com>
X-Gm-Features: Ac12FXwFWUyxJ4HiRdR2QeiyJ2opGZhBZBrlHhDkBBM4NfQKlaUcE6HKYkXz9Yk
Message-ID: <CAMuHMdXg=0Q9e1O6W0Gp+fPoP8-5VQ-2fGGg54w=seaqF9H8PQ@mail.gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: David Laight <david.laight.linux@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, Finn Thain <fthain@linux-m68k.org>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org, 
	oak@helsinkinet.fi, peterz@infradead.org, stable@vger.kernel.org, 
	will@kernel.org, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Mon, 25 Aug 2025 at 14:07, David Laight <david.laight.linux@gmail.com> wrote:
> On Mon, 25 Aug 2025 15:46:42 +0800
> Lance Yang <lance.yang@linux.dev> wrote:
> > On 2025/8/25 14:17, Finn Thain wrote:
> > > On Mon, 25 Aug 2025, Lance Yang wrote:
> > >> What if we squash the runtime check fix into your patch?
> > >
> > > Did my patch not solve the problem?
> >
> > Hmm... it should solve the problem for natural alignment, which is a
> > critical fix.
> >
> > But it cannot solve the problem of forced misalignment from drivers using
> > #pragma pack(1). The runtime warning will still trigger in those cases.
> >
> > I built a simple test module on a kernel with your patch applied:
> >
> > ```
> > #include <linux/module.h>
> > #include <linux/init.h>
> >
> > struct __attribute__((packed)) test_container {
> >      char padding[49];
> >      struct mutex io_lock;
> > };
> >
> > static int __init alignment_init(void)
> > {
> >      struct test_container cont;
> >      pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
>
> Doesn't that give a compilation warning from 'taking the address of a packed member'?
> Ignore that at your peril.
>
> More problematic is that, IIRC, m68k kmalloc() allocates 16bit aligned memory.
> This has broken other things in the past.

Really? AFAIK it always returns memory that is at least aligned to the
cache line size (i.e. 16 bytes on m68k). So perhaps you are confusing
"16bit" with "16byte"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

