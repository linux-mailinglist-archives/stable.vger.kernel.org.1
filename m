Return-Path: <stable+bounces-147993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB8AC702D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303911BC3D36
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067A1B6D06;
	Wed, 28 May 2025 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h664fmxM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289628DB7F
	for <stable@vger.kernel.org>; Wed, 28 May 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454754; cv=none; b=IrRQr7RUbOrB5XvubEPZkle+R21OjQfReAuat5lokktc++iEGIiYDREg6w2IPP0dFbaoq/pGnUQJeX74BZImLB6lKG8Qj4UI5rMqs/1PpELn4GbFVTmwvuqIvLa4VQ+F1/VB5jIX09lXsdBp6vmfekycoDbecai8DpTmskW+feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454754; c=relaxed/simple;
	bh=vWV6pFxU84IGZGUoXRovBE8SqKnsLvakTEWtNwoyHmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx4ZLYFjwTLCnOv7L53QT5w2pXqIj35t68EEdsiO9t5ZwiGWT6PNY2G48TeBMM4/HCQqTOem1SomeuUZHSEXdvxh1e/oEsH14L9fJPau8TmHD+Kr+0phiG8lyfRIqsiHJ46ceEqOi2SYcj4bsvTBOreVA2/aIm0eIr5e4VL2TVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h664fmxM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso403511fa.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748454751; x=1749059551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppv3VDPBQkSzYVgwGTOT8u09rusvnRbmtGkE8XpfbQA=;
        b=h664fmxML/rnN9PVJU6Mx+8YdHURscNotVbGAAVwKh72b63SVrpoPvyELITGYcRv6a
         L1qyR8YvIppT8Mx9GY6wgPgCD+rIKVG9O17utqGMP29AHGKqG6oXFoe5sAKs9jTv5ja+
         0HFgVTGKlUVSBV5bB4+X7oPLEu4yR6AAN53cj3BReMByRwruuXd8B4Ce2wj8KSFTeazu
         O4Q6y7EzR7E/LQ5vWrbb1WuoFnirEfpM/EH/3N0j4Gdj0t3liwzht/HyrkKNSJXNMEgg
         Cftp4d1Z7WX1xbzwm2+9R+yJGvsMenPiLvO0P/kBtOG9oKBAC8JdVfoa7rRExUlKzjB2
         yiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748454751; x=1749059551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppv3VDPBQkSzYVgwGTOT8u09rusvnRbmtGkE8XpfbQA=;
        b=jf8w4c0iL/pJl6XQahC6Bu7YhU0kkgJW7PBNoBuJNI6AqZ41WYMsILbdezoWhPLRfE
         WDqO3k4K+GvF67xGB8RLoCYsQv7uwXJlnnvLkf6QP4a3sblMbDwC1MvUqty3ML6cZ8It
         yOaSak3MYO2/7RJf+vMYGAeU62JmqpIl3AXig22cmp4nObpAZllbs4/Bm3EcGPXQ2xq6
         +O7Sjp4s5DNMRawW2EBAA0Hs7C6B67n9DetGLbzrD3DV6W1trSp3i+CfArzYWDpuwnxe
         IyJscx8zsd6lkbCPmyLzFTgQlGv+4e/1paCBgbUfJruhmIFA2J/MrKZPdztWzayXOq1d
         GRbA==
X-Gm-Message-State: AOJu0Yx5thAGMfo7XCRjAH9ERgG5r8LjH3nvF+nuo/i+3Ptpbnm+DPct
	ncBiwDuPF9yp0k1tG6x0jCbbuU3XTvzplBG6VRsStvbtu7forh9DDPPO8Zj6BuT2jbgURKupEm1
	lT83ZWBCnbDn6+yncNGh4TXIo6a+5oxsV
X-Gm-Gg: ASbGncvJwRag4rAb/pulNp6vyvwj9tmtaVeJf+62VYCr8zdsrF/OUMYZmJLDiO7ldM0
	geBSYSWKjTTfQPasw1o3esWYqOYsWSuFynZG4tMAQDM2CnlwDYi3p4PQwceiitSxDWFwgaciO6r
	lrVWkB9lp2RDFLnOOMgXo8STJY594G2SRQ9O36IS76b6vnYG4=
X-Google-Smtp-Source: AGHT+IG5KLdfR+fEOhbik8NTuMW2Ep+S2YOtM3aD25vx0ZaGUqb9CFH02FVAX/Xop5uw6u7nS5/j+BbuqTJo+yqRm44=
X-Received: by 2002:a05:651c:242:b0:32a:81a2:8aa3 with SMTP id
 38308e7fff4ca-32a81a298bbmr3089821fa.23.1748454750453; Wed, 28 May 2025
 10:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162513.035720581@linuxfoundation.org> <20250527162530.470565771@linuxfoundation.org>
In-Reply-To: <20250527162530.470565771@linuxfoundation.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 28 May 2025 13:52:16 -0400
X-Gm-Features: AX0GCFusT9QM7HoblA1N2WamyQAgGgwUNJQRzcqUgne__EWwKhBrhNsGvTNbRNY
Message-ID: <CAMzpN2hwSXUybfvcas2X5213V=Ow+nqGqqurC_tjfCdb44aFfg@mail.gmail.com>
Subject: Re: [PATCH 6.14 426/783] x86/boot: Disable stack protector for early
 boot code
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.14-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Brian Gerst <brgerst@gmail.com>
>
> [ Upstream commit a9a76b38aaf577887103e3ebb41d70e6aa5a4b19 ]
>
> On 64-bit, this will prevent crashes when the canary access is changed
> from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
> the identity-mapped early boot code will target the wrong address with
> zero-based percpu.  KASLR could then shift that address to an unmapped
> page causing a crash on boot.
>
> This early boot code runs well before user-space is active and does not
> need stack protector enabled.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kernel/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index b43eb7e384eba..84cfa179802c3 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o                          :=
=3D n
>  KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
>  KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
>
> +CFLAGS_head32.o :=3D -fno-stack-protector
> +CFLAGS_head64.o :=3D -fno-stack-protector
>  CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
>
>  obj-y                  +=3D head_$(BITS).o
> --
> 2.39.5
>
>
>

This doesn't need to be backported.  It's harmless, but not necessary
without the rest of the stack protector changes.


Brian Gerst

