Return-Path: <stable+bounces-159161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DDAF0157
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BB7443992
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBA1DD88F;
	Tue,  1 Jul 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGnWbaW4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DD27E058
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389692; cv=none; b=TN5aNlGY0npBpqtD7Em+cmgSJ25ycG+bnI3BS+GWdEd7DEkyVhp1lwHPTbxLuzxJcQ2TRagruLx5isapoRaMp0hq3n4thNhERA+fWMdJN83k2lzpGxrpywj+Wytj5po6OMp/MTCqRwingg7xwdEYblDJPyJyNnVqvmAFkIICweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389692; c=relaxed/simple;
	bh=Lyu8162aPlGdHqm8MMUtnBXbj7A8z2I/1kHmieIdhe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVR3T4zSeXJjQeb3hpiVHZDzRRqmd3iRsKvhXL9HGYltLkXlYx52C59cuMIx01QdO39vWY/6ApRkkRnNzXagH/XIAEtomsoanK3D4/8p3g2lHpaEFG5kXHBdkT1eiYlNVGgc85Qj02LHCgeedwn7Y5Lr9ZQ1l68DwKa4E4yNp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGnWbaW4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso59263451fa.3
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389688; x=1751994488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/oHeZZJmEJ3y7HUiY87UCgnZNS6QyZh5Cbvr7xE/rQ=;
        b=dGnWbaW4zm6SouWhnHJXSbrzKCWWGBsjmMugw2e5+Eqp8zI9I+k2unqRQt+yQWzfsw
         dbgC9TSRubIsRD+UCkWTc9ULz6rTq7EvxaaxqRzwOB+dfeW4atL9NkvkKtR3hYfSmmpY
         tKSbSd0Ir0ZjpjNCRz/mABZCUO8w0I7uGQFzk+LERC2gZj5Kpvy403Kr8mnk9/bs+Db1
         YJeiSmNdfwGnQwhMEnhP5Pt87zJwuMnB9XP2SM+Zno10HQeNcypuwqzDRee0UWgyAR5x
         fHZbCKdkO8d9dQ9uX1Zr8kkPoVdvnD+XrqfWVMO1vgviz+HQJiV5VtB88q7SRn2CxgCs
         HVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389688; x=1751994488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/oHeZZJmEJ3y7HUiY87UCgnZNS6QyZh5Cbvr7xE/rQ=;
        b=YkHRtaSGW2YhiCbpL6G0gEJUYKKbpl8bjElmOibFSkVJ2P1FWoWqenGHGolGI4T+3Y
         Jzi4cxFG2q+XOGBWvC1sWx7n03zDrjCPybQ5GH5Ha58q0KUivL/2ulHeMl/ZfFL6wJSk
         40WlAZU3PPuY/gjQ/3pEI3i1f8GyqHuKfwHTcF749FXyYF6+tAss2QCebczUaUe0uL+F
         SWlAQ71CUZ/5XtKhUxmr6Celh27Uck3PHT8jiAiTChDn/okEVFuDTYsdt57Aq5zRfXDP
         FaajJATfMOf3BwOb3EFWUShETlQqwUVorPiwJtK8/P5h3hgQFL3lghTx1WOiLed57ELZ
         XHGw==
X-Gm-Message-State: AOJu0Yx/vy+7xvecs/n2yrYaCI0oSv6ROhn4iQiXNzh7xnM51RqIk7d4
	mxGIJxP1jCR69Y0SV+nZMDpJ/TBePVPPX9OhRUtWCmesy5/mYa997UYRdYvRg7WBhf2gCsOJd0X
	0SS4v2Rs4xJY5jYbY4r7d7vNXOt9Jei0=
X-Gm-Gg: ASbGncselPl7JesZTE4mOBqpjiAntanZxt+gJDul8NJs39iMrP/BjxB9mXpIe/5oFl/
	D5e14+HpvwmvLFnq5SjpzqlNeHayNkYpBKZtVUhy5ePsgLu1tvNHO2XmHMmP63WyZPQW5XhaGV2
	ZI+mTjPIRNa0504PqZPJq56QSMz/p3Utr3ggAlKQB3VPA=
X-Google-Smtp-Source: AGHT+IFDcrq99l7HlyKWB1faKIkaQ1PDP98axqJweblaWyxilVNxqkAj6/VOBrFhVh+9rRTrmMQ2to6liKTFqiYp4cs=
X-Received: by 2002:a2e:a013:0:b0:32c:a097:41bb with SMTP id
 38308e7fff4ca-32cdc4410a7mr32879921fa.5.1751389688165; Tue, 01 Jul 2025
 10:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701141026.6133a3aa@ncopa-desktop>
In-Reply-To: <20250701141026.6133a3aa@ncopa-desktop>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Tue, 1 Jul 2025 19:07:32 +0200
X-Gm-Features: Ac12FXwrtprVZYhiM1ym_K2LaLIEoBM9Qx0NTEAIAXP5_AbBQn0By7Xgq-OkN00
Message-ID: <CAA76j90io241-a+2SDLfAMHY2ro4x-Bstw4AxKDOU_izW9goYg@mail.gmail.com>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Achill Gilgenast <fossdd@pwned.life>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

 Thanks for pointing that out. I was not aware of it.

On Tue, 1 Jul 2025 at 14:10, Natanael Copa <ncopa@alpinelinux.org> wrote:
>
> Hi!
>
> I bumped into a build regression when building Alpine Linux kernel 6.12.35 on x86_64:
>
> In file included from ../arch/x86/tools/insn_decoder_test.c:13:
> ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No such file or directory
>    21 | #include <execinfo.h>
>       |          ^~~~~~~~~~~~
> compilation terminated.
>
> The 6.12.34 kernel built just fine.
>
> I bisected it to:
>
> commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
> Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
> Date:   Sun Mar 2 23:15:18 2025 +0100
>
>     Kunit to check the longest symbol length
>
>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
>
> which has this hunk:
>
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> index 472540aeabc2..6c2986d2ad11 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -10,6 +10,7 @@
>  #include <assert.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <linux/kallsyms.h>
>
>  #define unlikely(cond) (cond)
>
> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>         }
>  }
>
> -#define BUFSIZE 256
> +#define BUFSIZE (256 + KSYM_NAME_LEN)
>
>  int main(int argc, char **argv)
>  {
>
> It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
> Unfortunately it also introduced the include of execinfo.h, which does
> not exist on musl libc.
>
> This has previously been reported to and tried fixed:
> https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/#t
>
> Would it be an idea to revert commit b8abcba6e4ae til we have a proper
> solution for this?
>
> Thanks!
>
> -nc

