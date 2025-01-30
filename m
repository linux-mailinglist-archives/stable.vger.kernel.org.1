Return-Path: <stable+bounces-111722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64891A232C3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BB6166D56
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F71EEA4A;
	Thu, 30 Jan 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jwi/IqET"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A861E9B01
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257892; cv=none; b=j+lzLm4RkvcniSd8bb0tXHDhpSD7eXNLVRuRPAENP4GaGASuL+qbWygcP4znWiKtgzCCyLilO7QbcTSGrjigHw45PA106rfLwXZSRoriE9ZJ4KrxeIVLsZFAAuHPxrfSjecpg7mszc+SLSm06QvmZESZ6O6p4Q9HSOJkPWzE8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257892; c=relaxed/simple;
	bh=16Rtl0kPvK8LvctNGEQQq5RSVYBc2bMyshwhKZStO/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dykJcJale/A+F7mzurbTvJe840MetnnbhZKZLqkUYP7Rr6u4lHEpi4Z9LHIkT6HePEMeuf0yaniDz5PNVscboSyWdj4cJLVj7DvWQkCxxnN3/jwIh5RXMAjMYujrKci4TrXmmYWjHqNchntA8rEfwcNv+kKGOKE8Q3QS2r6/w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jwi/IqET; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401af8544bso6050e87.1
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738257889; x=1738862689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytbv10R47zKrtdNtXLC6q54yc2GgqTDFS/Rjg6hjIts=;
        b=Jwi/IqETMnCiLr0NDUqHTNw1P2jMRuhfnnvXEXojyyU16Gj0OTAp0pYLYdUSZihTnF
         LlNSGqR/HTdibvsnMOEUER8nD9rpzbyWUjhVWOJW3zII3ANSulp8KwY15MxV1ujE4O3T
         pUKFPs+OTWWWItG84nZ3xkzupx2YsmE5rXvMWNloOIK9pkDAWzXsiIhzZNEZxtnDxwMG
         JcpR90mjRyYz31F2xvd77T0Jd3EstYO7tN20IPKyxrosmnB33flDT89qVfYZfngWu4B3
         CWEPMtludWRm+bKVH+ketHOpzFk2NaovGVsDTr0k1p0tei1Y/otg/gpR0LsyFEneg84K
         x+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257889; x=1738862689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytbv10R47zKrtdNtXLC6q54yc2GgqTDFS/Rjg6hjIts=;
        b=DG6xV63UM8GS3nSh505vGRynpnUOr8DtTX3UIpswK30A+F7/o0CdcrSmZ1gHpfrBPs
         xnp2AFn1igdKC5lJYXHMOJS7Vubtj7U9I73kHF5AZ3H61+YJgGTlp7/9OYLI2CsCwtNw
         lNNMZzjoeDtxzbEcgcMmhXuR+iIFHIVKfQ0e+rSrh2mj1j5zbo5WAwctLideSZ/vyFWU
         qm72mKcQedeP32VVgkqk5qDPx9lJT8LtO2F6KFMyxmPapfgBmQR1n61MNz6SPGZUp9HK
         qogKDSSdzdUqHnCq9WIU6bcbIVh+BEmsl1ZHx+zfAnMBrct+ANJPj5XNJKMc44tYjf23
         RfHw==
X-Forwarded-Encrypted: i=1; AJvYcCVxEomm86oIAYKKWiUe1R0nxCUWVzlkOw1wH9vOd1FVx2tvaoosjQKMgmRr1RGiBmcnRWtpotY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHupvMJiuGN5880BbJ378O1ZE4+zSXzrctz/Ifu1JIPnJxpEnO
	EF3bhnzQlVlQs7mYB2gdHPwmQdOM/3SnXSjiF/wOr/O7epsU+JZtCStdLBJsXFdNhPEmekVt+FL
	MwO8xhg9MfuJCwkM0eX7OUvhhT148QFcHZ3uy
X-Gm-Gg: ASbGnct1WaRNc57LXYIqN3RElKsI/Hwy4SPCbxK8wc0zh3WmNwqtJYi9PkKkklkvqcS
	EcqSztFT3BWtXcOYdVXbDTjehhadejTQvJmIOt+C2qJvH5cKZYrcNKtDnS/kLq+SgYh8MeG3av0
	RFYNYBUfKLOpTRnbp2J9DJh9vGSFYX
X-Google-Smtp-Source: AGHT+IHGXjIuGHyYvinkolLHPrB3xKTIatYLtgB6dOgTWRUiuCvNPBN2nPJMZxKUNI9gZitDAU+5h28oeYpNufGjIpI=
X-Received: by 2002:a05:6512:3c82:b0:542:9910:b298 with SMTP id
 2adb3069b0e04-543eb8e03e7mr233434e87.7.1738257888583; Thu, 30 Jan 2025
 09:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129232525.3519586-1-vannapurve@google.com> <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
In-Reply-To: <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 30 Jan 2025 09:24:37 -0800
X-Gm-Features: AWEUYZkAZWEN20O-bM6sJUmh4IpRXLFoLT5nGRGgfa0BYJKZf8LxMQCmXFRJV9E
Message-ID: <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 1:28=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, Jan 29, 2025 at 11:25:25PM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via tdvmcall. This process renders HLT instruction
> > execution inatomic, so any preceding instructions like STI/MOV SS will
> > end up enabling interrupts before the HLT instruction is routed to the
> > hypervisor. This creates scenarios where interrupts could land during
> > HLT instruction emulation without aborting halt operation leading to
> > idefinite halt wait times.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
> > upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
> > it didn't cover pv_native_safe_halt() which can be invoked using
> > raw_safe_halt() from call sites like acpi_safe_halt().
> >
> > raw_safe_halt() also returns with interrupts enabled so upgrade
> > tdx_safe_halt() to enable interrupts by default and ensure that paravir=
t
> > safe_halt() executions invoke tdx_safe_halt(). Earlier x86_idle() is no=
w
> > handled via tdx_idle() which simply invokes tdvmcall while preserving
> > irq state.
> >
> > To avoid future call sites which cause HLT instruction emulation with
> > irqs enabled, add a warn and fail the HLT instruction emulation.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> > Changes since V1:
> > 1) Addressed comments from Dave H
> >    - Comment regarding adding a check for TDX VMs in halt path is not
> >      resolved in v2, would like feedback around better place to do so,
> >      maybe in pv_native_safe_halt (?).
> > 2) Added a new version of tdx_safe_halt() that will enable interrupts.
> > 3) Previous tdx_safe_halt() implementation is moved to newly introduced
> > tdx_idle().
> >
> > V1: https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/T/
> >
> >  arch/x86/coco/tdx/tdx.c    | 23 ++++++++++++++++++++++-
> >  arch/x86/include/asm/tdx.h |  2 +-
> >  arch/x86/kernel/process.c  |  2 +-
> >  3 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 0d9b090b4880..cc2a637dca15 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -14,6 +14,7 @@
> >  #include <asm/ia32.h>
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > +#include <asm/paravirt_types.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/set_memory.h>
> >  #include <asm/traps.h>
> > @@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
> >  {
> >       const bool irq_disabled =3D irqs_disabled();
> >
> > +     if (!irq_disabled) {
> > +             WARN_ONCE(1, "HLT instruction emulation unsafe with irqs =
enabled\n");
> > +             return -EIO;
> > +     }
> > +
>
> I think it is worth to putting this into a separate patch and not
> backport. The rest of the patch is bugfix and this doesn't belong.
>
> Otherwise, looks good to me:
>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.i=
ntel.com>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Thanks Kirill for the review.

Thinking more about this fix, now I am wondering why the efforts [1]
to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Currently
proposed fix is incomplete as it would not handle scenarios where
CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] and
requiring CONFIG_PARAVIRT for TDX VMs. WDYT?

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.ku=
ppuswamy@linux.intel.com/

