Return-Path: <stable+bounces-119860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF9EA488FC
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D099F1884DCA
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CB26E96B;
	Thu, 27 Feb 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2TxopmCH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4226E956
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684430; cv=none; b=YkOG1AH4JJYnuFZdg8qDDJ5IOZ1ceIXxhjmD1DpesuAS0L5wRWYkpLmPck4D/AYVmIIK9Zfnw7qHeuXvlJYJS3waU4Shl2lhT6tgp/+rjj9Fwqjn4C1XoLIiyYUkcInrxR1opPDpV9yTqSZxL+s3Z8WnmaD7khbEOPBPlAsHIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684430; c=relaxed/simple;
	bh=d1Qxg472CkVrkJspIto61QqE2XsIjtKw5J3xPkJikcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQkvF9/37XkMyOgQknNt9Md6SofqYb32jBi5AnBAxIXr/Bm6f9kXV/OQTGxubSVdrlnxSz3+btfrc2ZsK+DzCmIjZn2i84jnOcFG01azn4mRpNn5SMb6wPpvoVM3I7+V7EBNzBZLBkPQKdd+bPAT+gtcm97VaQ18ovbSHhj5Lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2TxopmCH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-544043a21eeso1158e87.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684426; x=1741289226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=2TxopmCHJ9v8GWtr7FbdgnCMwGCilGeXlaG2avMM5+IrJNSNvvm8qp3GPFvmuxHPgO
         3/5I9UwOcaZdAj3dk0Uf3zb/+Ic8uWgzcNlgFhC1VOSP3VIrAUg1iKv/FJCoGwu9EcNY
         Mx/4Rrho733WrpUPTjlyv1Quuiz5VnLvLDxH12MEWOmbP6+qVRmKU6X2ejaqm1ipsQ1c
         3FXOQAUB0Each3LKu+MIxxicGkug6g4D98UQsVowTq9LzUXuGzw/0SxwC+AQVRtGM9oH
         4lnA0Q5SbXQc8OF/fFq+PJSOemiixhP8UbbrlD5WpHQA4BQM31ZErsHW2HCdmpXWxnjm
         xFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684426; x=1741289226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=pEjOi580H7ewp+rHxS1iAjYqdXayzyGVskoanzAuMIgNwLyX40qExout6Vs5quXbTL
         QxDTMiOc4r0pEN2MFbCmagaj6Aj7DgSECOu8+aeyzSs5gx3bQP/pvJoZk/ZjT2/VEGe6
         9nXIUbiHLzA4CJeUR+MK+iUu0J8blWEE68zyESawXnl072UyG/yCAEkMT0syk/AiFMPw
         EXxag15np6IRSk/ZIXwbivekstKaoy7XMw4irh4797UdX8NXZeYSE/0xuES+dQl4JrXb
         cItOk26mJmXSUhQ0tEhZqYQ4o0mdLjXEmFJF5d9Ifkp6ZReNCIr/4fMR1go7SF6OJBlB
         mxIw==
X-Forwarded-Encrypted: i=1; AJvYcCUATaux698aPD05yabDJsqruU+gN8suuMAUfrW7pAfP0k2xYHyQJwltpe9dLNOBGX9tSRYDWIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZu2ruxGvSN9FfSIFcP3/a8VL7mdx6GZ4C6mYckEPbx+Yt2Zhd
	+EHmCinyYEW1QdlNbQJwvS3j3/lxV/U1m34LSiqxVtBKXsXGwlh9euqZnfoLeq0oZP3T4nYTDJ+
	tFa1sfWs+ZfhEczN3QUHO9n6jR5YMpS3L/m39
X-Gm-Gg: ASbGnculwd11ISR9I0scIqyQzNJLz7C/NhLWoSD4JbpU/FepPvCpPHxj5kx0lHvltHF
	Wq+3oCnlTQhRl7Wgopwg/sx0Jdmo1PHAZh6dNtAeFUBk1P+7EyKCkDhBJb45mImgbxB5ATbzflz
	kg/jvVpyajGZiwPY1E+Tn8ri84Z+OEB1C8DK50WQVv
X-Google-Smtp-Source: AGHT+IEdSIwybUjSkkV5vNkBMcDTqOmFlDjP0ogUFLrcyG7hy/eEgdi+TbKAXYt1FUTQRVem2blej27QUoMzQ6ig7ik=
X-Received: by 2002:a05:6512:3a84:b0:543:cf0c:ed14 with SMTP id
 2adb3069b0e04-5494debd8fdmr16005e87.5.1740684425486; Thu, 27 Feb 2025
 11:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-3-vannapurve@google.com> <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
In-Reply-To: <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 27 Feb 2025 11:26:53 -0800
X-Gm-Features: AQ5f1JpNkvOxWDJlk_d64tma-tOWc1scSvqjWSXHu6nUjd70ID7CCmOSArfFMN8
Message-ID: <CAGtprH8mxENaH-Y0=b0kKJio=EG0OKt_qeguRBJECagXL4poPA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com, 
	seanjc@google.com, kai.huang@intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, afranji@google.com, kees@kernel.org, jikos@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:49=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Tue, Feb 25, 2025 at 12:47:03AM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #=
VE
> > handler will enable interrupts before TDCALL is routed to hypervisor
> > leading to missed wakeup events.
> >
> > Current TDX spec doesn't expose interruptibility state information to
> > allow #VE handler to selectively enable interrupts. To bypass this
> > issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
> > followed by explicit interrupt flag update.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from executing HLT instruction in STI-shado=
w.
> > But it missed the paravirt routine which can be reached like this as an
> > example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> I would rather use paravirt spinlock example. It is less controversial.
> I still see no point in ACPI cpuidle be a thing in TDX guests.
>

I will modify the description to include a paravirt spinlock example.

> >
> > To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
> > dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
> > routines with TDX-safe versions that execute direct TDCALL and needed
> > interrupt flag updates. Executing direct TDCALL brings in additional
> > benefit of avoiding HLT related #VEs altogether.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

