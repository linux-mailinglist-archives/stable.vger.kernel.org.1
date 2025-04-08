Return-Path: <stable+bounces-131652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B2A80B9F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4783F4C6232
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F327C158;
	Tue,  8 Apr 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw65lc2a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46527C151
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116973; cv=none; b=PVUsjkBvqNZloAGb9b+Z4YzG2obAhXJ0ujLLdSKr0KLA6nBT3CoATiDSqirdy9lqD06xw7ZBq9TRzlrNrTY38/FN7GycHjiYgKGIHjp+9vkOqx9hZ6Yu+j75xeRTaHqiSsYIWTYwCQ2guSTqQcYji3seIOEzia0xYTZUQxEgCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116973; c=relaxed/simple;
	bh=adZcLq55jVTFstm2wiUyPAojCL69dADb1wgZoxsdoWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYnfQVRx497exeGEjhT+z6GXO3Xyfzq62DJGlTVYhiv0fAHek62JDlnW51nW9WyaDUr1PntM/2lb5Y/+yznzZVVWNQHcifAZ27EpnwCh8dy6Ze1OIAxNEq6mENZvvITcPjvsOqkzwSzTcqOBJu80RYgrOiX9kio6q/b/dSsT2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nw65lc2a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso170305ad.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744116971; x=1744721771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG/xhtnV6ZnPncZ3zkgyPrvXLOKL/ebp3OOD18MDPvE=;
        b=nw65lc2aZ8E1yUZRHDWFD0r9nmuZ1Cxie+4XwigtathSPaaS/EVwD7o5MQB2W7BXts
         OlDV2p/ID002M5rOrIWn3S8kF44oYm16PSU5YP1SLVyuephXRL0MJhdL0EG+Y7omgWMR
         OBzsfy8P6xSQsDT/vjhPevHG+/t6W/J7gC3Se5ohRyEuH02xIJa5XXF2ZdeRIT9+vLZb
         t27gWur/oV2gq/1XEPGoEbY2tYwUtzViLkDZIRm1zoI0wtvxNZ6uPkdM9g7Nj7bY5C/8
         BIXJEs8qIv2MoztVeNR1aFRXTYB5tlfmUyyCt0ZZozkqHwhX6pHW+UCNIGogAESiN7t/
         +toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744116971; x=1744721771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG/xhtnV6ZnPncZ3zkgyPrvXLOKL/ebp3OOD18MDPvE=;
        b=P7CTJrqVVbAS6yqxr633G6C54gFMu2ZCQw3bpwgJDa9rlTxQ8NkHu2GnSL6Q3FHqV/
         wn5Cxti37kOlo+TZCqYVEgXb0uisqEqIvWE741hMFgMa6+hnKyZpl/y7MnFkYxVPgZ4i
         1Iw+UOLC0yfPfD81aoujsdchTNYtfIBrSuxm7/kjr5IEOlf3iS60FUfaEJ/CNDkFTSjz
         Qd3lS5U/bRDgy5BBth5J4TYVrsKhyeN5ZFOx1SeSXJZyab5Hv0xU3HxJx45xRtYSKaIY
         rsMlyMcX2I5NJcg1wsISVO19xxr10KNjc6y+17t4Rkgnom1wqz+eOVtTtC5FpT9iLWEN
         zqQQ==
X-Gm-Message-State: AOJu0YwDN8GMk+vQk0HIG0lu2TjW0RE6KGM33KkpQenkMNgLpq0npXb1
	Wmc6thFBlmXv6omPK7WwoeyRHg66eQqsaLUzY10GVGKrQphrHHnojGJpun2/YNHI2KFC6puUG8s
	7IcgnPxI3+Czg1ehJ7rr3Bw/aH7E3nrHEP38O
X-Gm-Gg: ASbGncs+VgHBuGRIIHCtLaM0xhbmj8UWeU/dQNLGBHoNnDrInXdRW+Dv2N5GColqyWj
	I6q6N/glyrrMy4rkacoIbeEuCzbPDNChNGy7yTaFPunDoyxWxqZ1l+5l7QrGsb07iK6wsMQHXEW
	6bltHuQYQzKnlMv1mlQfo7PPY7aaKE5Mae8B0Zwl82iJkWcDCnBogcmMypXFoA28tn1iHGCQ==
X-Google-Smtp-Source: AGHT+IFyamF8RcqpJvT2dSEWif+d5rOCh4OSVEjZqb+pQd2Q0cuRNjgqKpf6zhLQZxEF5YWTjhukqOAdH4NUN/9xXZw=
X-Received: by 2002:a17:902:ce01:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22ab6e6223emr2928445ad.0.1744116970209; Tue, 08 Apr 2025
 05:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104851.256868745@linuxfoundation.org> <20250408104902.301772019@linuxfoundation.org>
In-Reply-To: <20250408104902.301772019@linuxfoundation.org>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Apr 2025 05:55:57 -0700
X-Gm-Features: ATxdqUFOuhmpGo_chEBVF0UBujpRLi9z7SKanq8MnuNt1HRJ4w5pBBd_ytweB1Q
Message-ID: <CAGtprH_Sm7ycECq_p+Qz3tMK0y10qenJ=DFiw-kKNn3d9YwPaQ@mail.gmail.com>
Subject: Re: [PATCH 6.13 444/499] x86/tdx: Fix arch_safe_halt() execution for
 TDX VMs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Ryan Afranji <afranji@google.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.13-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Vishal Annapurve <vannapurve@google.com>
>
> commit 9f98a4f4e7216dbe366010b4cdcab6b220f229c4 upstream.
>
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #VE
> handler will enable interrupts before TDCALL is routed to hypervisor
> leading to missed wakeup events, as current TDX spec doesn't expose
> interruptibility state information to allow #VE handler to selectively
> enable interrupts.
>
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> prevented the idle routines from executing HLT instruction in STI-shadow.
> But it missed the paravirt routine which can be reached via this path
> as an example:
>
>         kvm_wait()       =3D>
>         safe_halt()      =3D>
>         raw_safe_halt()  =3D>
>         arch_safe_halt() =3D>
>         irq.safe_halt()  =3D>
>         pv_native_safe_halt()
>
> To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
> dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
> routines with TDX-safe versions that execute direct TDCALL and needed
> interrupt flag updates. Executing direct TDCALL brings in additional
> benefit of avoiding HLT related #VEs altogether.
>
> As tested by Ryan Afranji:
>
>   "Tested with the specjbb2015 benchmark. It has heavy lock contention wh=
ich leads
>    to many halt calls. TDX VMs suffered a poor score before this patchset=
.
>
>    Verified the major performance improvement with this patchset applied.=
"
>
> Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Ryan Afranji <afranji@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250228014416.3925664-3-vannapurve@googl=
e.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/Kconfig           |    1 +
>  arch/x86/coco/tdx/tdx.c    |   26 +++++++++++++++++++++++++-
>  arch/x86/include/asm/tdx.h |    4 ++--
>  arch/x86/kernel/process.c  |    2 +-
>  4 files changed, 29 insertions(+), 4 deletions(-)
>

Hi Greg,

This patch depends on commit 22cc5ca5de52 ("x86/paravirt: Move halt
paravirt calls under CONFIG_PARAVIRT"). I will respond to the other
thread with a patch for commit 22cc5ca5de52 after resolving conflicts.

Regards,
Vishal

