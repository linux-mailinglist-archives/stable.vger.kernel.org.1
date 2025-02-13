Return-Path: <stable+bounces-116318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8CA34C05
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1095116B3C6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3862139C4;
	Thu, 13 Feb 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAdcG3d2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06420110B
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468017; cv=none; b=h1nGPTKO8ugWmQgcZgIGnUUbchLnTJ/tw7XpmvUQS5pKilb/jC8Ey5FfqEwri8+jxN6os5/EHBndqlLpQRbtNqcKWN8Dxgqe0zEjJuwfWEuiTdLVTcoXtJ4N+/GyrZu/ipnYBKKFyqFjsbUIcUrUzh4x/i62wZ6dvuC/mFudQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468017; c=relaxed/simple;
	bh=IBE3DqvfPltRFsm3mBAK8i9sdVtPitaS7V/S98s+J1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V85Hmp4ZVQ19nqhG8l5IoDPdbBisrfNtW/ZDBSTdJZ1++8V9oWNm9oTN/+uLfCKN8z3q8r1yHwkRcDTRZqymoJqHnPs5g2UmtgQy7Or/kiJzJ0pHAaS7kcuCgZol36g45SXbw7GevpE/mHBLBsBao0y96yYgFEPkBsBdnk+CcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAdcG3d2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-545092d763cso6738e87.1
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739468013; x=1740072813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGgVrzsAeNL3Ky4gN5+3YPP2m5D+SPcUN3lTNqfCOfc=;
        b=ZAdcG3d2q4EirvAbbptmx24krGguX6P9vGMVWSJsyrWNpWGCepGpiVTMCx9cflDNX1
         BxzYrLkAEfOwBkX30FngzCfzwVqA40ZJ3pez0NH9lY+mhl5xCXWy3e512zpsD1sW1zhK
         Q+CdK78eLODpJXYsqNcS1t7PKCcf4xk0dum6lYg/4EGhEwKYOZzeSisNFdSUv7FHMr6x
         /YN3lSQ37WP4dfdPqnOaEMrFOsRppUeArScX/QQGOcBYbFBYyAQ6p4qKrh1Y9xkbMj/n
         +NuNpZ+ZjAPo7Oze3aIpb6nWLvGtp10ZNdQ5jt4Il/bB+Ths88rd0bTksVvmkproLnLm
         Jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468013; x=1740072813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGgVrzsAeNL3Ky4gN5+3YPP2m5D+SPcUN3lTNqfCOfc=;
        b=iKu3MhNOs5HJ05/yXIPxu2nWYnblwErWdXOT+lFmXxmt681pmSRaPguF/MUpqRsuCr
         24jfVt12N2xBJb3enD/l+O8AYmpUSCy45gcXSLHt18nGr9hvs7CM9K7fR5MxUH0HGDFn
         HoH7dTnZd7jSwPVQD7bC2DMznRz41zuaZjL0+7Y4cx4pj/3a0pRqcWsAG1HyIAVlVcDn
         4K6UUw7/NrtU78YyAzuCro44oIK3bXfVb7fcvzqbVo1tOXcfR/QSc7+YEsARhqg8Zjzp
         l6wgXyDRvJNoYkgHkGY+j/XnnfLdyLQ/w8WhPhrKgWrLiNApN0NANkASQyOACgdYIk/Q
         5nGA==
X-Forwarded-Encrypted: i=1; AJvYcCWjdOaFUwoum4SXEVqANGJpxaOKc9J1eOASrQ1pm/OOP62G8Hf8/R1xLc0O+rDlM+cJ/cti0EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwblNb5vtwj55QUwawR8mBUCI7CPoxcaq74uAlIwt8KpseOqFa
	PIl4ta3yRmPCuUUnBKk1k/DyGTZ7Kyleyym6Fpx+q0HfCxfrGdXzvcNRf5xo7Pxc3De24tQH8D9
	ac1AP6u4ImFBHe8ewzUHPi7neXYiUtQPby4Yd
X-Gm-Gg: ASbGncuyI+faD3mAw3M154cQdnQDORgwG8oPEjhXOTeyNMBxUoX20DPJuJmkdJiL1ru
	XkJXPWsOMplI8st4KqIiBAQfPeb8X9xXQaQ3pQoxRo5cj11FSqkEpzCGTgXu1td/ME4xnebrtFG
	KJ57dICMpzAzVMD3vhtWdSlHAinvcd
X-Google-Smtp-Source: AGHT+IET0OV89iYfpu0mSYog4w1SQPmfp2RBaQSQSyY+Bufo1G9ums2tRHgQYhjw7LlG2MpjYEKfhvU+TU3OvVYN8WM=
X-Received: by 2002:a05:6512:1193:b0:543:e3c3:5a5e with SMTP id
 2adb3069b0e04-5451e020774mr343672e87.4.1739468012362; Thu, 13 Feb 2025
 09:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
 <20250212000747.3403836-3-vannapurve@google.com> <ljdzupgyl2am4qgvirwpdonwuzwjaysemu43icrzxjt5olr3yx@dldbi5tqwhjh>
In-Reply-To: <ljdzupgyl2am4qgvirwpdonwuzwjaysemu43icrzxjt5olr3yx@dldbi5tqwhjh>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 13 Feb 2025 09:33:20 -0800
X-Gm-Features: AWEUYZlhzsA-Sl-KzuUXdz9zcP5QTmYOsipXxAYftqBemHGY7puDNPu9R37JLpc
Message-ID: <CAGtprH9OVVMXLyPnKXZ+K=S7XuPePHLwco0sXV-irGVj-SCbkQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:54=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, Feb 12, 2025 at 12:07:45AM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events. So "sti;hlt" sequence needs =
to
> > be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.
>
> The last sentence is somewhat confusing.
>
> Maybe drop it and add explanation that #VE handler doesn't have info abou=
t
> STI shadow, enables interrupts before TDCALL which can lead to missed
> wakeup events.

Ack, will fix it in the next version.

>
> > @@ -409,6 +410,12 @@ void __cpuidle tdx_safe_halt(void)
> >               WARN_ONCE(1, "HLT instruction emulation failed\n");
> >  }
> >
> > +static void __cpuidle tdx_safe_halt(void)
> > +{
> > +     tdx_halt();
> > +     raw_local_irq_enable();
>
> What is justification for raw_? Why local_irq_enable() is not enough?
>
> To very least, it has to be explained.

Let me replace it with a more suitable arch specific <>_irq_enable()
function in the next version. Intention here is to just enable
interrupts.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

