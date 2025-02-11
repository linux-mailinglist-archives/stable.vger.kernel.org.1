Return-Path: <stable+bounces-114970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F469A3199F
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 00:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053907A2C0A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 23:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9DA263887;
	Tue, 11 Feb 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7TnGWFI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5A1F8917
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317054; cv=none; b=uvG7R7d+xKhDD187Q+R45HXk9YKbZbKWk5RxyYvmGIT64fXRw3ng+eS9s7pCfy3VO4FnyELC2QgU93Ch20j/WIS4ImqQ/tN2uhdRltfhwUKHqHXhW00S5UIn7ZwJntUMUZE3Rw3+dOTW6NV/cTmgrcaKuL7z/MZIejUYyCUNObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317054; c=relaxed/simple;
	bh=GutEcZz61gwify1yCL/KrmgOIzRRqXpILaGYVs/GWDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzWGT5NJAWUzQmZKblqdQLUqiWO6lVDYs7qQs2p8yPMrnPBnZxuOpjDBTtJ6UuQXOzCePCifz144vBWd8fGl7fwsrfKdOHM8T6hPx5evv0NNRiEJ6OwUBn8Uv2Qopq5nNt509oxcNCDr1+XLqnGS1qck0qNeQiRqHJ5kskROkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7TnGWFI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5440f27da4fso3162e87.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739317050; x=1739921850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSbvnItNGBxBKAvRaSMscNhWBRYdPAos9+Z7zPAciRI=;
        b=t7TnGWFIsKD9+cVu+60fmwiER5C1RhRvkaZTXuXTWThSfLEGq5qUR1DbWezDV15rKK
         i/aHa6G0NphexjSj/yumK2LvzGNPA/UbQHLB76WJeOrIADvZtnXzEduQ3HaIJSl4wfoT
         QF/SIsrZ+MfZ9M9VWkGosuzPsAM+bb/UUaOSQKlkApjOIFz7S4ZCBAN1Lusj82sDz/ry
         DWgHOs9Shc71O+4QeF+DZ+5ahmk4a+MZP1SulGYgr5MKnYrSWZo+/n9UsIam7T3xEe6a
         aJ53JBryVHXe7JjGRCj4GdEuRYqghlsLM8qTgqEo0eXBp1nFTn/ALipsbDTDBZxXM7T9
         IocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739317050; x=1739921850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSbvnItNGBxBKAvRaSMscNhWBRYdPAos9+Z7zPAciRI=;
        b=UeLku8slb5Ol228WRwzpInBZZ+uIIzUUO0cf13G6X1fu//4IMiH8e97t3YDYukKJmC
         KJiIUAoWb93XAtpqR8JcgMqaaobM6Thr/5VmtC55RtKq3AfXOmazant0TiuwubbZtVYx
         2q/52CuBHNAdX2AD38x6PV4uoyCS64TPUodaALUy7KNu7Yn04+9HArwVsqG4hzMll587
         +nT9V5RnNsw22u8LRl94659K4eqA+ui7CrXRQjmlhz7EAOzH7XbufY9zQlrgPO2Vo9BE
         iHAIhxJaVVYpIcUDDBfZP6OACOHPdXvWpmlyE1yIAcb5HzbJtZxGyP5xs7EnvFuwbXdi
         2CLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCs5yLrbsndLS/UkCIVJSoD4magdpSzlHwSyKvsXC9Sbhl09KOuQXp714JMFnmcAjQYzuhn7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/l1haeVRt4u5WgM0waECwgqdLrR/mOJmF81aUyDwhWoD78Aa
	KPHL2FJC97qU1bo4FyFoxNffAT//apJAVfr1A3bFDaXqSv0c54zzSfLWTf5IPS/XZmcbINXbJnP
	Qm3fr4jsmaD6sxypeZbRMXWpHLqN2aJPBR5Ge
X-Gm-Gg: ASbGnctoRHh7HBX/nPVY5IUx5n7O0AtO5HWHEP0t5/TZEla/Yu2hWLBqt64ZXb1jb0E
	/KMw/thwyLoCTCvtkKIDzQZn2MWCpO5zIsz7SdGm81hFCQRHlLjGezTIHntyeSp+3qquKdHIFqr
	LvvznPft/OJk6+1Ox3Rd7Ms9QHuEK6xg==
X-Google-Smtp-Source: AGHT+IFwqfZpukbm59rOXt6h263eOHCDjc136zYAOcXQHTigPOGAqt3tg2yJH93apvYN9rjDIs6HzHeYOQ9BeM6qfi4=
X-Received: by 2002:a05:6512:3d90:b0:545:34e:16c0 with SMTP id
 2adb3069b0e04-54518de9606mr38355e87.5.1739317050020; Tue, 11 Feb 2025
 15:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206222714.1079059-1-vannapurve@google.com> <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury>
In-Reply-To: <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 11 Feb 2025 15:37:17 -0800
X-Gm-Features: AWEUYZl70YOalrJ-dWWuIpBvrvuQpb_FScJ4zAQWzJRP5MMlca2CNQsA8FuLHfY
Message-ID: <CAGtprH9yekaDTCn0P83k221sW2DoXL5AwKLmD54Pv=PmUPU6Aw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	kirill@shutemov.name, dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Feb 06, 2025 at 10:27:12PM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events. So "sti;hlt" sequence needs =
to
> > be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from using "sti;hlt". But it missed the
> > paravirt routine which can be reached like this as an example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
> >
> > Modify tdx_safe_halt() to implement the sequence "TDCALL;
> > raw_local_irq_enable()" and invoke tdx_halt() from idle routine which j=
ust
> > executes TDCALL without changing state of interrupts.
> >
> > If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
> > executed from TDX VMs via paths like:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >       native_safe_halt()
> > There is a long term plan to fix these paths by carving out
> > irq.safe_halt() outside paravirt framework.
>
> I don't think it is acceptable to keep !PARAVIRT_XXL (read no-Xen) config
> broken.
>
> We need either move irq.safe_halt() out of PARAVIRT_XXL now or make
> non-paravirt arch_safe_halt() to use TDCALL. Or if we don't care about
> performance of !PARAVIRT_XXL config, special-case HLT in
> exc_virtualization_exception().

I will post v4 with the patch [1] move safe_halt/halt out of
PARAVIRT_XXL included as the next step.

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.ku=
ppuswamy@linux.intel.com/

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

