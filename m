Return-Path: <stable+bounces-124857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF05A67F01
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD71898F5B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226B2066D4;
	Tue, 18 Mar 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piSHUsvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066F2063C6
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334115; cv=none; b=FTDnndsDfSwN7S7qlOwowGpuH43SbOPz0d+PH2AbKMGDXC9bAMJODP0iR4IjnYL38m28x3CJHWvDKliZLlEPYNWWiqzy5uordoiIWmDVderiWx0lWf0cLPraf0Z6Xl3wwG/cTS5x4rCvLZda5rtTy1tbNaBY2vx4BYVW53bUgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334115; c=relaxed/simple;
	bh=H257vBUGFgZallMqQK8Sv95gmOBmQfu53ct0C021Sc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFpfrbSgCXcHUJeHksxXbTMYAJCaFEc8qqjE1Xq7+Ogw2JyL5w8e3EWlBLoYv1LPX6ElLJ46HwA5yHMZduDJEpcA9geR0M6071gZ6MWSF8LUFo4VGC3Nv91InGmFxCxOtjrxul2GDgTRJPc6oBUa+HcFsfoKrHZsAaHCb8buFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piSHUsvM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso3881a12.0
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334111; x=1742938911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huRWnbUSFIOrYn2QxkW4BG9y2bRatI4h8QE+NxAGfCE=;
        b=piSHUsvM5H/mSHb8x1PkAH9/jM3Jcioj5pb8vT3Bo9r7dypkEGJtpFMieOXKtTesM8
         A53HXrxO21yJ5vxX/XAOh7hcV1h/4esABT2nwcvr2JZJgck46HHkdqdp5QjTvrIC6Zgd
         vCC1mOcWa2+oolmd3750k1s5PYSuBShXbB61OCL+1gpOERzR0CGWBitv+nrtwPH0a8NF
         zJU5BdiHdKOSXCtq3FVPlQ1kS7nm/GY+uJtgV3sCEX1LqVwMWuU6hX1bAr5xpaZVEaBk
         I/NzrTiB75q4Q5E3JmJ1/JCp7U2hdEEhiWeg7FgY3kkRx4R8GEVPQqXrMV6cm02dpre8
         nUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334111; x=1742938911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huRWnbUSFIOrYn2QxkW4BG9y2bRatI4h8QE+NxAGfCE=;
        b=kKnwug9bxRFx5Or0dSCi5tqbaVbkBPjctNVsI6wAnYudzWI+WevuWCo+yg+ZBFA8hV
         O5okwldxSOuEf46lUmy0oI8AbuQNGQtiijGtyrXZtg8aIikjmReFDtAN1XnFz4PEQprK
         2/KCFs2F1O3bpk1P2IY5wPIV+NMprWRaHRlN+Wc317CGikuOB0Ui4oF7iMUHM0cAPLvc
         iEaJeo5CA6Rv4497g4c2+NOYwRnbz8eosTFMl9sDok4/0iH+6ni1MXArK47rnX9qT8cD
         pKsp0vMziyBM0u4z5l+EkiKVy6M6GqR4GCzhK0YEu+WCNwL7hiH5w6RasyyUXb4R7okJ
         vAkA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TGO9kJGqTE2ZcD+ahCF+VUnEuK9WcqJf8n+IuqAl9xIIQxrTuxBhm3dG4WTQM7kki2f/3Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPpIb9gPwzVov/oF6x2ocGumM/2qs9UlxL50d59IKoQXAZqSf
	q8cb7DsutLl9aOVRezFs1tNmWYF6lI9vF+/Mdsds9UYazMYvICL9LJVRN3b/5Q4EGTNiJWtbYd6
	iENxwCLPbMgWE7hVEmkepPhFAAtIMLyUtnJBk
X-Gm-Gg: ASbGnct1fLHnL9cnwfwVfWXhJpca5WFB0xA0TouFoBt5ndT1ImOoIrTRs9tlm5gzqT3
	yKA/g8X+YhZgVaHxdWgnUAJAiWaHgIuBsKrhn4LS0fpXE2HH2fOIr6Tl6Ga3yCcw7kRdigWlh+o
	0Nb+6RIX69FpaXFcRsTlBNjf/QSWex8lLvPo1U/ArhwnapVCGQyWlyjow=
X-Google-Smtp-Source: AGHT+IEE7SnidIPRfD/tsQUEwB4S5fYvYHXaK7pjnnRSY2/bfQtUnICoMM+NMzU+Q4G5iu99RUJkJd34epkaV7xV8uM=
X-Received: by 2002:a05:6402:2072:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5eb81ca377cmr5954a12.7.1742334110577; Tue, 18 Mar 2025 14:41:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308023314.3981455-1-pcc@google.com> <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
In-Reply-To: <Z88jbhobIz2yWBbJ@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 18 Mar 2025 14:41:39 -0700
X-Gm-Features: AQ5f1JoCSww36ZPRvbJPagyRsMZce1-_UGQToveMTebIsOSwVuNrh895PUcBWPA
Message-ID: <CAMn1gO6Zy1W0M_JsHcX6pcOp8cb7=uWUScf3WGxKTRm=AjXKKA@mail.gmail.com>
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:37=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > this is incompatible with MTE which will fault on a partially invalid
> > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > bug for now by disabling the optimizations if the kernel is built
> > > with HW tag-based KASAN and consider improvements for followup change=
s.
> >
> > Why is faulting on a partially invalid read a problem? It's still
> > invalid, so ... it should fault, yes? What am I missing?
>
> read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> beyond the end of string. The has_zero() function is then used to check
> where the string ends. For this uses, I think we can go with
> load_unaligned_zeropad() which handles a potential fault and pads the
> rest with zeroes.

Agreed, strscpy() should be using load_unaligned_zeropad() if
available. We can also disable the code that checks for page
boundaries if load_unaligned_zeropad() is available.

The only other use of read_word_at_a_time() is the one in
dentry_string_cmp(). At the time that I sent the patch I hadn't
noticed the comment in dentry_string_cmp() stating that its argument
to read_word_at_a_time() is aligned. Since calling
read_word_at_a_time() is fine if the pointer is aligned but partially
invalid (not possible with MTE but it is possible with SW KASAN which
uses a 1:1 shadow mapping), I left this user as-is. In other words, I
didn't make read_word_at_a_time() arch-specific as in Vincenzo's
series.

I sent a v2 with my patch to switch strscpy() over to using
load_unaligned_zeropad() if available, as well as the patch adding
tests from Vincenzo's series (which had some issues that I fixed).

Peter

> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4=
bf98ada827fdf755548
> > > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  fs/dcache.c  | 2 +-
> > >  lib/string.c | 3 ++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > Why are DCACHE_WORD_ACCESS and HAVE_EFFICIENT_UNALIGNED_ACCESS separate
> > things? I can see at least one place where it's directly tied:
> >
> > arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNA=
LIGNED_ACCESS
>
> DCACHE_WORD_ACCESS requires load_unaligned_zeropad() which handles the
> faults. For some reason, read_word_at_a_time() doesn't expect to fault
> and it is only used with HAVE_EFFICIENT_UNALIGNED_ACCESS. I guess arm32
> only enabled load_unaligned_zeropad() on hardware that supports
> efficient unaligned accesses (v6 onwards), hence the dependency.
>
> > Would it make sense to sort this out so that KASAN_HW_TAGS can be taken
> > into account at the Kconfig level instead?
>
> I don't think we should play with config options but rather sort out the
> fault path (load_unaligned_zeropad) or disable MTE temporarily. I'd go
> with the former as long as read_word_at_a_time() is only used for
> strings in conjunction with has_zero(). I haven't checked.
>
> --
> Catalin

