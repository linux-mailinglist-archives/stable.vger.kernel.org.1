Return-Path: <stable+bounces-112236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D5A27A92
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2347A2246
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3D218AA0;
	Tue,  4 Feb 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+1lP/Dq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714B21639B
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695143; cv=none; b=eRo87XGy2i6V21y+saaTlB6/p+fCVUZ9bkhnMByZcwinNLITKpNaQkaUUnvd0RJgt5iRPXPPIc/7nJIRfNu/5STJAC8Ch29vH2A06iZXvwv/JYLP4O14iNN99gtC9BSl7sqNkqhcN9rUlFxfxZ10zGEItASdv8UoMod1o9lINwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695143; c=relaxed/simple;
	bh=zbnqzd6XkDlUkXnIqmyVov9gz3edxYuX6M0f9ImDYJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxKRBuqtAHOazCzMZP+o0RgwZuutPlMCXu/5OgOFwymImIZ8LtTXOB07R+mt5nL7iEG8hhBPwczunNqWbvf/MKwQibxPzDzkjVDYR5/nkTg3MBDs3f4OQfWqZS3t4JwUq5cVYRIl9zVbWowgP35DboM7BHdQEmBz87SuNgfLNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+1lP/Dq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a2264e1so9790e87.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738695139; x=1739299939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFpEwLn/dC0QDTCh8cN9pGGSIe7PpPg7IM5j/w3xtPA=;
        b=L+1lP/Dqgfi/1BA4EVgkoSTQHzoNMHodR9L5BSEumc0AEWVmlYqlFk+3QbzAmWK92t
         5EomEepL36rH6K+px6RNJ5CGZVQ7cdJrBVEbmBb8Z/gQocQQx5XbUCdjJL81B/lJ4KQ5
         0DzM0f6s1soLdp8oNhI1rpsLKodEzf0owv9GkcrvE8vKIwz0nnwrq+gNRNiq26nGo4kK
         2pQR+DgAdRWh2MCMoejKUhFjruem9pI9JsotOLFGZncO/NAzQHPsYV8owM0AtvYNSA+Z
         S9gCSsGLzxBCP9EHQZu9yZPmE4Wy7t27TBrcdhn9YX4xqs+PBxsYyBDWCovj+Sdj61su
         PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695139; x=1739299939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFpEwLn/dC0QDTCh8cN9pGGSIe7PpPg7IM5j/w3xtPA=;
        b=ev2dWnn5R1cnH3ku7Yad7PuZkzIYi7nftRWD6H+a4sWMPpAXLBh0w3UrQFv6svVgnn
         +GzXrqUC/gZYJoNPf8q4E/zhdyCrdaXAlo/STjWsyoqivzRbL0lw1lnJ9pkjkWS7pP/n
         Yp4J2gCKoqzaIb4KUek42Ec2Uliz1fotK+65pkgEJzZMPPGofQOePjQa+5NnXZRctrTW
         IS1aiqzMYU69O6kXD7/7zOivMODpIWU3uT9HKqPUg/AZ+U7BcNgqqOQRUENfMvTo3Umi
         wW2zELy0rvzjQInzVmvBbP+5BmOJadJLP6xVwARm8O2X/Pxjzak3SABuUjAKprR+mcpa
         pumw==
X-Forwarded-Encrypted: i=1; AJvYcCW3jxQcwS25v4ltdHYqQ7OJYigCVEihnERe9nktufs6aFIKc1MnvzTYTDBeLnmkjYKRWSnWI30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UAfveG/Uj18X4VM1VbXUmBhBl/BhtuWs+u2IqieyMIbErJ94
	EZzu6VykysKVqEKv/kxnC/0SXAu5qRAdrzA4eqaLEv/14plVRkfPkXO1Jhu4G3zr4A3IiktfBvp
	8L3u3FP8hTRmRGy80WL/xUU1XCLB40pAvUcYB
X-Gm-Gg: ASbGncvuMp1LnkRIHPj4MP5yU459QJFbbJFnu8SyFRrGN+zEI5exMpdZoQ2zn4SLsjA
	vOL7gs1q9eGG8+AKzaXDmd8e57yxAfTQjyo0rck21xQfUSLU79ovJ/tAJdXmRxlHE9ESDKE6RR2
	MVRcsC/31MECVAQfLYrkFygje6d5iH
X-Google-Smtp-Source: AGHT+IGa5r4vzVW+ObuRphdYnQxEuke4nepjoCC+Mwq/AxH5MPhY3uiQh6F6cWhaR3TVphiWxYmTKZAgQ7JaxJnMyh4=
X-Received: by 2002:a05:6512:2398:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-54400bd9244mr277014e87.3.1738695139002; Tue, 04 Feb 2025
 10:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129232525.3519586-1-vannapurve@google.com> <054b7cab-4507-48f8-9c0a-d400779f226f@intel.com>
In-Reply-To: <054b7cab-4507-48f8-9c0a-d400779f226f@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 4 Feb 2025 10:52:07 -0800
X-Gm-Features: AWEUYZnozqobmK0OI4oKOR1_hLIJMHKZjhXau6ZWzoBrfPmSooIgx3fqTA3GJVk
Message-ID: <CAGtprH9r159qjAU8E2MHMAhKGjJmh8JTuJMqq345v4Bqzc-m9Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	kirill@shutemov.name, dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:32=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> I think this is the right fix for _now_. In practice, Vishal's problem
> only occurs on CONFIG_PARAVIRT_XXL systems. His proposed fix here does
> not make TDX depend on CONFIG_PARAVIRT_XXL, it just provides an extra
> override when TDX and CONFIG_PARAVIRT_XXL collide.
>
> This seems like a reasonable compromise that avoids entangling
> PARAVIRT_XXL and TDX _too_ much and also avoids reinventing a hunk of
> PARAVIRT_XXL just to fix this bug.
To ensure that we spend a bit more time here, would folks be ok with
making TDX depend on CONFIG_PARAVIRT_XXL as a stopgap until we have
the long term proposal Dave mentioned below to cleanly separate
"pv_ops.irq.safe_halt()" from paravirt infra?

>
> Long-term, I think it would be nice to move pv_ops.irq.safe_halt() away
> from being a paravirt thing and move it over to a plain static_call().
>
> Then, TDX can get rid of this hunk:
>
>                 pr_info("using TDX aware idle routine\n");
>                 static_call_update(x86_idle, tdx_safe_halt);
>
> and move back to default_idle() which could look like this:
>
>  void __cpuidle default_idle(void)
>  {
> -        raw_safe_halt();
> +        static_call(x86_safe_halt)();
>          raw_local_irq_disable();
>  }
>
> If 'x86_safe_halt' was the only route in the kernel to call 'sti;hlt'
> then we can know with pretty high confidence if TDX or Xen code sets
> their own 'x86_safe_halt' that they won't run into more bugs like this on=
e.
>
> On to the patch itself...
>
> On 1/29/25 15:25, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via tdvmcall. This process renders HLT instruction
> > execution inatomic, so any preceding instructions like STI/MOV SS will
> > end up enabling interrupts before the HLT instruction is routed to the
> > hypervisor. This creates scenarios where interrupts could land during
> > HLT instruction emulation without aborting halt operation leading to
> > idefinite halt wait times.
>
> Vishal! I'm noticing spelling issues right up front and center here,
> just like in v1. I think I asked nicely last time if you could start
> spell checking your changelogs before posting v2. Any chance you could
> actually put some spell checking in place before v3?

Yeah, will do. I incorrectly thought that codespell runs by default
with checkpatch.pl.

>
> So, the x86 STI-shadow mechanism has left a trail of tears. We don't
> want to explain the whole sordid tale here, but I don't feel like
> talking about the "what" (atomic vs. inatomic execution) without
> explaining "why" is really sufficient to explain the problem at hand.
>
> Sean had a pretty concise description in here that I liked:
>
>         https://lore.kernel.org/all/Z5l6L3Hen9_Y3SGC@google.com/
>
> But the net result is that it is currently unsafe for TDX guests to use
> the "sti;hlt" sequence. It's really important to say *that* somewhere.
>
Ack.

> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
> > upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
> > it didn't cover pv_native_safe_halt() which can be invoked using
> > raw_safe_halt() from call sites like acpi_safe_halt().
>
> Does this convey the same thing?
>
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> prevented the idle routines from using "sti;hlt". But it missed the
> paravirt routine. That can be reached like this, for example:
>
>         acpi_safe_halt() =3D>
>         raw_safe_halt()  =3D>
>         arch_safe_halt() =3D>
>         irq.safe_halt()  =3D>
>         pv_native_safe_halt()
>
> I also dislike the "upgrade" nomenclature. It's not really an "upgrade".
Ack.
>
> ...
> > @@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
> >  {
> >       const bool irq_disabled =3D irqs_disabled();
> >
> > +     if (!irq_disabled) {
> > +             WARN_ONCE(1, "HLT instruction emulation unsafe with irqs =
enabled\n");
> > +             return -EIO;
> > +     }
>
> The warning is fine, but I do think it should be separated from the bug f=
ix.
>
> >
> > -void __cpuidle tdx_safe_halt(void)
> > +void __cpuidle tdx_idle(void)
> >  {
> >       const bool irq_disabled =3D false;
> >
> > @@ -397,6 +403,12 @@ void __cpuidle tdx_safe_halt(void)
> >               WARN_ONCE(1, "HLT instruction emulation failed\n");
> >  }
> >
> > +static void __cpuidle tdx_safe_halt(void)
> > +{
> > +     tdx_idle();
> > +     raw_local_irq_enable();
> > +}
>
> The naming here is a bit wonky. Think of how the call chain will look:
>
>         irq.safe_halt() =3D>
>         tdx_safe_halt() =3D>
>         tdx_idle()      =3D>
>         __halt()
>
> See how it's doing a more and more TDX-specific halt operation? Isn't
> the "idle" call right in the middle confusing?
Makes sense.

>
> >  static int read_msr(struct pt_regs *regs, struct ve_info *ve)
> >  {
> >       struct tdx_module_args args =3D {
> > @@ -1083,6 +1095,15 @@ void __init tdx_early_init(void)
> >       x86_platform.guest.enc_kexec_begin           =3D tdx_kexec_begin;
> >       x86_platform.guest.enc_kexec_finish          =3D tdx_kexec_finish=
;
> >
> > +#ifdef CONFIG_PARAVIRT_XXL
> > +     /*
> > +      * halt instruction execution is not atomic for TDX VMs as it gen=
erates
> > +      * #VEs, so otherwise "safe" halt invocations which cause interru=
pts to
> > +      * get enabled right after halt instruction don't work for TDX VM=
s.
> > +      */
> > +     pv_ops.irq.safe_halt =3D tdx_safe_halt;
> > +#endif
>
> Just like the changelog, it's hard to write a good comment without going
> into the horrors of the STI-shadow. But I think this is a bit more to
> the point:
>
>         /*
>          * Avoid the literal hlt instruction in TDX guests. hlt will
>          * induce a #VE in the STI-shadow which will enable interrupts
>          * in a place where they are not wanted.
>          */
>
>

Ack, will take care of these comments in v3.

