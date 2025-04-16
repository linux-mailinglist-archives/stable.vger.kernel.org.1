Return-Path: <stable+bounces-132819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D742CA8AE25
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 04:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEE3B4DBD
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81C1DD0F6;
	Wed, 16 Apr 2025 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3I3WgAG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D11B81C1
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770337; cv=none; b=aW0MbtVPMOZfUKiiqgMQfp6q8BSTbNetfnnCGUv2lAY0gMohJm+Rhm91pUMJwtQEBjWtjLWiaFvD8vtGeSpr6BmMxnRFFj5orwGyJBNdHORUb5amURBdeEjOx9HZoW4O7RVMLAEv7Y1u3pEpQxNFxeRDml4LvRlAOXb0cfx4Er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770337; c=relaxed/simple;
	bh=Fq60TVjg8hdz7OzAED/AfXd7INuQmua9Mckrs6NN3VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7mOe8fRBfbRwmD0jNbIexz2cjORqVJqM1fc6EagbCxLGEIbbsezCxX4GSM0Lv0/+1bfh5voDqLl+wWe3bU8WGb2wrG+gN5pbqSVa0u4g4kcjC9bSbBBHzSiSQ6kHSw/Ck1zlqStDQKj47JQ1pVeovbxcjTj+I+3euWBxadLc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3I3WgAG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2242ac37caeso58775ad.1
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 19:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744770335; x=1745375135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6R1dE+WfBiT5qGwENgdRrornJr/YiHxdg8wrTb8+t8=;
        b=T3I3WgAGYwOhU36RsbtEhTkG8s0pFN5qElw0CKSLXP7YLRx5sHTKnkycYlaP28M4wG
         os2f8SzLupd6ErZuMdodEuyHhjvJHec2lwFO/ubQZbXVS5tquRMAZYgL7fvj3/AS3zmq
         WOFbhvfEWr9YBWDkbYrCwm1Gq1AFzu0lvX3GwvYYYgRjA2efa28SasFmJezoXAl/JOHS
         jjkaIt5iS2ogSnB+ygjype2opR+ebsIsASRkYIYuB54o3aGhJ2jXKDn/lnZpwp6rLioB
         NwnTRokpLGYtK2XqSAC/D57cxDBPVWV8N5csaklNhu5WoCzFQYcOhZaFktrKMGpZpifB
         p61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744770335; x=1745375135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6R1dE+WfBiT5qGwENgdRrornJr/YiHxdg8wrTb8+t8=;
        b=bO1JCDfmcBaufO7OXlqKBkAK3scH783PggR1WjNg96O91rZmx8MARHQwhT2mlf2G2o
         tsVFH0sVtmDIbHuQTL+hex66nALClbrBtFQ1L89NNsXREHoMJePN5Gpxtp9EBgGTRb0n
         Nkk/ttIvxsSs5uEiWMlAgVppnEHnASaE/y27DNc/B/t7OWsGjGZYIa1mrqUo0X6qvCLF
         6p6fRTlT2T1QNdyGKWO13hvPvXTI8PvjjXH53yXe5ms6igl8zI7MRTRglC6EKn0lPlSa
         ZiwCKgDuXGoGnLrYwjeFaHTuWVvbbcg9KTKRpFmxEStBQwiQ5Bv85XwWQZJJC5KVPera
         Aaeg==
X-Gm-Message-State: AOJu0Yw6RI/jZozeN5XrkQEWLip40NK0qmknVY+9WgmcA88vHD3+3H89
	U1LRGI9TaT21qA7QU89iZTGfNHNUIi20DQuHMBpUfuMVQ7IsmHxARDqRIvIkj7hLuJwPQHGmo6y
	vTfgaYY6Nv0byRsJbjJsFsqYJHZWGx+4f2IiW
X-Gm-Gg: ASbGnctzQ8KPP4BZk5YoA001yt7wjo/XQ2qRGnppgA2nxMe4ZZWvSDuTOFFzDXKnQq8
	5Cx/SwfTcekSQY/nVHoG2FJW2P/ku5A8NhOPcv5nvNSIgTNVJ+BF/aIgTSh71ZmgF1qfZYxoiUE
	vAkv+jj5Ij/Q0QgelSrW6Vrnbo1epTqFv4gjfYrsukKAvM4iOgAPMJ2DI=
X-Google-Smtp-Source: AGHT+IG9RiKIlFiaf5R//EGgfl+L5t1otqcCAe6fn0MT3S3JpXCs/7FHbJfIZvFN/RP5dz9VHtsw0EA1mQA/tyEw6vE=
X-Received: by 2002:a17:903:1aa6:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22c353bac4cmr171545ad.0.1744770334611; Tue, 15 Apr 2025
 19:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-stable_fixup-v1-1-0bea1b5f583c@ciq.com>
In-Reply-To: <20250415-stable_fixup-v1-1-0bea1b5f583c@ciq.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 15 Apr 2025 19:25:22 -0700
X-Gm-Features: ATxdqUFoeX6dUsNwNufCHKFr6Tl2La5AmtfAgoT41BdEM1trNaeFr3d_M47Tirc
Message-ID: <CAGtprH-iO-Bk3bsqMCkdRp4xOQWzHsOVY7DDNyxh3u6AmhMBFg@mail.gmail.com>
Subject: Re: [PATCH REGRESSION-FIX] x86/paravirt: Move halt paravirt calls
 under CONFIG_PARAVIRT
To: bmastbergen@ciq.com
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, regressions@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Ryan Afranji <afranji@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> ...
> 6.12.23 fails to build with the following error if CONFIG_XEN_PV is
> not set:
>
> arch/x86/coco/tdx/tdx.c: In function =E2=80=98tdx_early_init=E2=80=99:
> arch/x86/coco/tdx/tdx.c:1080:19: error: =E2=80=98struct pv_irq_ops=E2=80=
=99 has no member
> named =E2=80=98safe_halt=E2=80=99
>  1080 |         pv_ops.irq.safe_halt =3D tdx_safe_halt;
>       |                   ^
> arch/x86/coco/tdx/tdx.c:1081:19: error: =E2=80=98struct pv_irq_ops=E2=80=
=99 has no member
> named =E2=80=98halt=E2=80=99
>  1081 |         pv_ops.irq.halt =3D tdx_halt;
>       |                   ^
>
> This is because XEN_PV selects PARAVIRT_XXL, and 'safe_halt' and
> 'halt' are only defined for pv_irq_ops if PARAVIRT_XXL is defined.
>
> The build breakage was introduced in 6.12.23 by stable commit
> 805e3ce5e0e3 which is a backport of 9f98a4f4e721 ("x86/tdx: Fix
> arch_safe_halt() execution for TDX VMs").
>
> Consider picking up upstream commit 22cc5ca5de52 ("x86/paravirt:
> Move halt paravirt calls under CONFIG_PARAVIRT") for stable 6.12.y
> which fixes the build regression by moving 'safe_halt' and 'halt'
> out from under the PARAVIRT_XXL config.
>
> This patch is 22cc5ca5de52 backported to 6.12.23.  There were a
> couple of merge conflicts due to the missing upstream commits below:
>

Thanks Brett for looking into this. I have posted a similar patch [1]
and I see that the issue you reported is also being discussed already
[2].

[1] https://lore.kernel.org/stable/20250408132341.4175633-1-vannapurve@goog=
le.com/
[2] https://lore.kernel.org/stable/20250410180423.GA3430900@ax162/

