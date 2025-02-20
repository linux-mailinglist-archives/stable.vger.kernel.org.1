Return-Path: <stable+bounces-118531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED3A3E8EC
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE2019C5B28
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDD267B03;
	Thu, 20 Feb 2025 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MT2iuLyb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8A1E2611
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095478; cv=none; b=i3GoHt6l+76IsA3IO8atq/JBxWbjEOngovFTjMG9+XlUhBezBWE3Op7fnvZGzM9bh2d8obx33ewuxGaUD/brwiDs5/HGK6HbLt7+2lheclsHbbo0YmZKqQLTFU0HCHRsZKTnQ2NEuRi02GlOVGNlzxja9r1YaVklaykZaO8PytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095478; c=relaxed/simple;
	bh=UdWhNOUBSdT4syJ+kosIuq0AfZUSJ0WGNQkI3p+ncvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzqu8CivKkmpc1dkdl3K1R59fKUApnipHd/34knLxXQVmbbucaat1y+DsQKDgQ7QWpsILUB8pI6I6KLbfAM8J03BDEKUWwRi3VR9G6KCkJZZu6Y5+4jdHSKWMl2A1tK5xw48apH/RgHYwl2er/XyAle6+hN6OLePedcsbWbnAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MT2iuLyb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461a3a03bdso1387e87.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740095472; x=1740700272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=MT2iuLybTjyviqAzrvIxqmMiPLvbkXrk4N1oUEoOL+Fyei3TQgLYJ9YqJqRbghecvQ
         phc+E+JImkcDnPP61dOv8zfPAYIjgsb++QvEC9kSkMQeO1cxWoIgSL/oQAmHTNvdfT8X
         TMPYlyCFItXE8+1CLJkZPFOkYXje+KY/FbZJMysx0Y3XuptfO4RfjsPvSIsgqHI45ZUJ
         pCnmZ16xxJqb+MG9BCPeqVNlNqWQC5rxeQOIG26hlaapubtoth6ItPskeeObEYwOaNm2
         Pb/Fs1aPCldgm9kJd1qMd7JZc8lokCYBXn3Eg18Sz204kS689YWr8HeUpd/rSUXPPb54
         NWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095472; x=1740700272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=w8lIGGfd0rYop2bRbd5WRV7AIvpjcU8bKEaQML7KTVL4UYWQTx7s/Jz8BMcw3TlfnV
         g658pRb1TGCJOmnzlRulPzY+z110wdvArGQ0PR9A85HY3ysfhB9yPl+hina49gJs1s7p
         d8qtgvQvvlybMVaciwPl9Sf2xBrJ6iatbWUWlWQwFcII+ZR3Ei4NGmLUWeqHZZRVQhzS
         dkSd2jEqTKC4HoHRhuqdGXpMTf5Y7uke0ScbXLYtradyHZM7TaVESXgf2fPIaEmV//xF
         P8g9LAH96LYiyTtH1W7qNIHAxQABHb7TjOU/Il97O6X32++Pv7NWFVOs0Efx/ljlDgQg
         CZGA==
X-Forwarded-Encrypted: i=1; AJvYcCUiOgT9SsdtPy3qAAcMty5msTPtmsY+104n0j5OgqDtGxaGqj736hPhH/uynU0FEOWGKVUl7ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMm4lZuRt5Bx7pEM99nSRHJMMjN5vT0K0kxA9OweD3N58FjeN
	HFNGdMvLL/X6hcFadOZRxpejyymUy5muA+JwMs72DNttYBiM9TiCFHI2T+xxfnkncmDhKZiuVkQ
	VU8I6PpJEhPCRZ8qs+sb1/0D6jyD1/G2jbhWw
X-Gm-Gg: ASbGncvsha5XmChyASjfKq025H9oL8we5PcbCZ1X5oqI4d8VU1B/UgA4K2ottYAXWNq
	p5kYvu+vilMfV9R23lVzetC4lUzQ9opA7sf+HZenBE1MG37kEVjXrI7yXwRGJ+8g4BTsXllqas8
	jOdWkz+Sma0Cn3Fn6jKdxkE75l8eeD
X-Google-Smtp-Source: AGHT+IHNrahV1BDNb6HGmIpADFoAfSxQLvTQMK+ss0Zxtwi9sdNu6MrrXOWs+BR87xWGqTxyWHbSATFC1ErU9+Atf8g=
X-Received: by 2002:a05:6512:eaa:b0:543:e5ac:8ba9 with SMTP id
 2adb3069b0e04-5483912c478mr118346e87.6.1740095472207; Thu, 20 Feb 2025
 15:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-3-vannapurve@google.com> <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
In-Reply-To: <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:51:00 -0800
X-Gm-Features: AWEUYZnHtnB_aHba-KEBGxrwDPSTc-BtBIYPfsyILXR2O2qhE2mk2NxqrmEtVUY
Message-ID: <CAGtprH_z=4nsDj2GSnCrhwQkKESBqLTcUK3aNZO+2BzMc7P00g@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:00=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events.
>
> This isn't quite true. There's only one paravirt safe_halt() and it
> doesn't do HLT or STI.

pv_native_safe_halt() -> native_safe_halt() -> "sti; hlt".

>
> I think it's more true to say that "safe" halts are entered with IRQs
> disabled. They logically do the halt operation and then enable
> interrupts before returning.
>
> > So "sti;hlt" sequence needs to be replaced for TDX VMs with "TDCALL;
> > *_irq_enable()" to keep interrupts disabled during TDCALL execution.
> But this isn't new. TDX already tried to avoid "sti;hlt". It just
> screwed up the implementation.
>
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from using "sti;hlt". But it missed the
> > paravirt routine which can be reached like this as an example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> This, on the other hand, *is* important.
>
> > Modify tdx_safe_halt() to implement the sequence "TDCALL;
> > raw_local_irq_enable()" and invoke tdx_halt() from idle routine which j=
ust
> > executes TDCALL without toggling interrupt state. Introduce dependency
> > on CONFIG_PARAVIRT and override paravirt halt()/safe_halt() routines fo=
r
> > TDX VMs.
>
> This changelog glosses over one of the key points: Why *MUST* TDX use
> paravirt? It further confuses the reasoning by alluding to the idea that
> "Direct HLT instruction execution ... is routed to hypervisor via TDCALL"=
.
>
> It gives background and a solution, but it's not obvious what the
> problem is or how the solution _fixes_ the problem.
>
> What must TDX now depend on PARAVIRT?
>
> Why not just route the HLT to a TDXCALL via the #VE code?
>
>

Makes sense, I will update the commit message in the next version to
clearly answer these questions and address the above comments.

