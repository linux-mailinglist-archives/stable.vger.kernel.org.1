Return-Path: <stable+bounces-144556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9BAB9146
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 23:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796851BC1144
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15129B8CA;
	Thu, 15 May 2025 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+6nMkEf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13229B79F;
	Thu, 15 May 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343572; cv=none; b=GhMUR//l2zYw3998G5z4uDWsakAgrkBbKaFHbMLrUFcQ3rIyGp3QPoFM3XbWGyfFlL1QUyru2eNw9df01QGkbptRunUoF0bkMcmxQyU7bqOWAM/mZqzVpGFf7Pc8uj/DjdFvhI8vSLhxL0sPJOWaI5bF9KE2gfrl1+kL2vLIa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343572; c=relaxed/simple;
	bh=q3PDrZM6G8zDDRhj4QwvJtG8rSqiKqS/I3flXIXrZeU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riXmeNEbzADRhWQ8fE1Nju9DWtcMUczRsE/Hn59g526yPPRjlbDOCMarotghDWf8SKezLVrvC0pZnukGRvzvMF10XrD4tVUyol4PIRJTxCt9WcK1k6FRrNqdEGZ+xLU3yhY/3zEJAHNLg1egcdA6Ha59OB5aLZsgee5HJq7jaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+6nMkEf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b933f214so915869f8f.0;
        Thu, 15 May 2025 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343569; x=1747948369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=opuvm8FKWBIYNRf90PxXi7sMcW0qx9YAX9FlKAsACPA=;
        b=F+6nMkEfOeVKIEfWFWzsSAyNOLPH2amXneoP/icZ/EbVRUCme1GMOwZ9KvNLr4Bhj5
         8/NF4m+wWTYk/7cDuO8EUEpWsMDqUv3j2/hPTGP4yEvyRYIMY14Fv7vmHxfgnBuS9qn7
         HaXOk1Bm8b2DlFs/xLJ6/Vv9Q5443jmOL+JI+0f1PxTAadvTakvPVOLVvPOUiP5Wy6eV
         bgjikKyM5tB/qIg99AKkXGQTVKrAx684BNFaF2xeffa6Erh1QoCdjhi9Ze/RxvXgmnDZ
         vFYA77xU/ijNPy3pT3IQUg1JvT4w3iHTUnMWD2i5AXN4TDJ4GzkzyULkjFQ47mccOX3D
         eh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343569; x=1747948369;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opuvm8FKWBIYNRf90PxXi7sMcW0qx9YAX9FlKAsACPA=;
        b=JtFUVsh1QRlCW32Qu9ENZ9KA8U8qNL8siq+cJ4hfkYHq3DMI2u/sEUt/TY2029azl0
         OiYM9kTptoyM2mNTLY0VTEn4mC9P9wxDruKigZ0IZT7aJ2paZi8FIWR3a5NIDzF28lt5
         5Qs/W7fRs1gSRsYZTHl5vyizO4Jo+sHkPUl0TicDJLQrfSYVbJPtHMugwS0Gyc3EQGK6
         IZnuVQl1+do2ESITYUN9M4hyeyTQonoSqDSAjgTKxIc62C4gAa3FzDFLaU9Y3Zo8IvCV
         6yrLP0uipKICuj8RS3L6mB4J5rNCvw1j1TDx54Qhq1m1wjDiw+DDkf8hQuIJKwYMpOls
         yYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0xPimJXvZsFqKaBIc/AwnyiFTUyFOw4s+YaJUh2w/152ZQZNNFur6WX8QL+vUDjgYebXJPi7YgCNgU04=@vger.kernel.org, AJvYcCUXu6DL0q/H//BaV3BnLxvfeXuZDRThSruCAxmH1pi67/GEd6GD+fsse+KpRl5wwWnVXAz+bcgN@vger.kernel.org, AJvYcCWYzzXJt0JdldMtoShEQG9XNGAPCLWF90KJ2l9a5550pEAYuOfdB/kXG5QX7Q4zrWImAA/WXFFc7tyDOeI8gz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgFik2ET216dOpRMKunfAG3BftN7GdMkMbIe/zQKa1GLUVx/O
	DACxnqA1023iuQ1NjUNJL5DDakhuM0CEfskQmqeZDVD5NNUqXMwvoXx1emUUBuWPOlWPQ1lf1nj
	ZcIRZgXKsaZvLxTDf1epk99GwLTlmstU=
X-Gm-Gg: ASbGnctQxtDJel2k53CGujOnUM3y7W+yHr0X2iP7jYFkMKUhvinCfPpXpcy4xxONnOh
	yrN7ZfYO6++GExptyzIrMPLlfXOjpMgUV9atCeQdEkKb8Jx3BOuOuzv7keygU5Gzy54qEroNVPa
	2jozMjtrlQzf/9KX2p7Cb7wcEl21hQbNyC9g==
X-Google-Smtp-Source: AGHT+IEYoK6f7wP0SPm/gfKqdWjWZ4HX90FKs87O0UBgxajWhbvIOpj9PHkIZ8r7babBAps9G/Ln4njRTceq0nIyQp0=
X-Received: by 2002:a5d:5c84:0:b0:3a2:12a:e637 with SMTP id
 ffacd0b85a97d-3a35c8542a6mr1195017f8f.56.1747343568560; Thu, 15 May 2025
 14:12:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 14:12:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 14:12:48 -0700
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <097a4926cebc9030469d42cc7a3392b39dfd703d.camel@nvidia.com>
References: <097a4926cebc9030469d42cc7a3392b39dfd703d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 14:12:48 -0700
X-Gm-Features: AX0GCFslEILHetAnpjY2QFEJ9SocrJkFvcA9OUfU-AXwwAPQyRsjmsYuQT8ABk4
Message-ID: <CABeNrKVfCHww2k_W-0s4GQE=2bA+wjje=FEH=gL8FhNbFB1tOw@mail.gmail.com>
Subject: Re: [PATCH 1/5] objtool/rust: add one more `noreturn` Rust function
 for Rust 1.87.0
To: ttabi@nvidia.com
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, apopple@nvidia.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	gary@garyguo.net, jhubbard@nvidia.com, joelagnelf@nvidia.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	patches@lists.linux.dev, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 19:06:10 +0000, Timur Tabi <ttabi@nvidia.com> wrote:
> On Thu, 2025-05-15 at 09:18 -0700, Josh Poimboeuf wrote:
> > > Since I build with LLVM=1, I'm assuming the answer is 18.1.3
> >
> > I'm not able to recreate, can you run with OBJTOOL_VERBOSE=1 and paste
> > the output?
>
> You probably can't repro because it includes code that hasn't been merged upstream yet.  Try this:
>
> https://github.com/ttabi/linux/commits/alex
>
>   CHK     kernel/kheaders_data.tar.xz
> drivers/gpu/nova-core/nova_core.o: warning: objtool:
> _RNvXsa_NtCs8S3917Wilyo_9nova_core5vbiosNtB5_14PciAtBiosImageINtNtCsgK88DPai1lC_4core7convert7TryFro
> mNtB5_13BiosImageBaseE8try_from() falls through to next function

...

> 011b     634b:	e8 00 00 00 00       	call   6350 <.Ltmp38>	634c:
> R_X86_64_PLT32
> _RNvNtNtCsgK88DPai1lC_4core5slice5index26slice_start_index_len_fail-0x4

Yup, that's an unrecognized noreturn function.

src/core/slice/index.rs:
> #[cfg_attr(not(feature = "panic_immediate_abort"), inline(never), cold)]
> #[cfg_attr(feature = "panic_immediate_abort", inline)]
> #[track_caller]
> #[rustc_const_unstable(feature = "const_slice_index", issue = "none")]
> const fn slice_start_index_len_fail(index: usize, len: usize) -> ! {
>     // SAFETY: we are just panicking here
>     unsafe {
>         const_eval_select(
>             (index, len),
>             slice_start_index_len_fail_ct,
>             slice_start_index_len_fail_rt,
>         )
>     }
> }
>
> // FIXME const-hack
> #[inline]
> #[track_caller]
> fn slice_start_index_len_fail_rt(index: usize, len: usize) -> ! {
>     panic!("range start index {index} out of range for slice of length {len}");
> }

The return is at offset 0093 (x62c3) with a jump to __x86_return_thunk.

