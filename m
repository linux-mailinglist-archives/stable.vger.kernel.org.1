Return-Path: <stable+bounces-89118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B29B3A86
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E3828303B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04221E00A0;
	Mon, 28 Oct 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ3eH5rt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F01E009C;
	Mon, 28 Oct 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144042; cv=none; b=e4zd3p7mazr6q4uE3oh8XO2TQ7TI/KF5JG7/5ya4cocx4sIuWsBTNkCsV1NLlaE4G5kC+f+XWIr+NyfnORuoBN8SJX1ttkoknwPhsj9LYLKAsH7Re07HOCKtH3xItKTa2mMAPDOSezTrXSEILahUzp1tK/Qi30ey8EHIix73ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144042; c=relaxed/simple;
	bh=vTsHVOS5Z9CU1AwBvLTKf6ZeRz3xBTENRHUHETx7cJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTtLp3oAYQzRsRuhXJ7Cnh1ammH3cCstUFBiBxO5EploWm3JFMPdaPZrxdNY8dxadXX6WB0pN7+rAPURRANNASsMr2W9CYemjIHUWh+IgnfnF6bz653YVEaY4FKds1ON14LaPDktfuT3EFXVHAciGCbLNmePGZZhbSFASyPRjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ3eH5rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7A3C4AF0C;
	Mon, 28 Oct 2024 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730144042;
	bh=vTsHVOS5Z9CU1AwBvLTKf6ZeRz3xBTENRHUHETx7cJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZ3eH5rtK3PUbMGXsSX0Zxcy+FEu3qigPCYy83PEgGfwZZSOypye5VWSiWKUJk/Kg
	 cXK2zf9D0MgBqdb+jkqvdiaaqr8xBLcDtPA6Cg8ur8AALgmHbbZSmYc/8QSKU7Og7Z
	 4o1ZpCG6HcBy2hk4H9BjFdGi5u/gdYKTTrZJ6D3RDPXA5yPw6NagWMuyC7IjrepDDj
	 pWZF0aRpaxAL/YZPvadQJd+ETzks3DfnhjhXFUhimvrMQT6fwdKK62/JRA3RtEQlry
	 prgGzA8Y0oGXrJEXBWNCUB9f0p3debVEgOTbiyLxo6FXv1HAI+v2bnDUmnPuXerEuR
	 trTq5w7S/dOYQ==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4611abb6bd5so29574661cf.1;
        Mon, 28 Oct 2024 12:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN2fmUtGVQjb3y3QAVYCZ++BBqFQqVCtg+/Pdhhkjv+cUuIFX1Y+vXCAWEQU3PPBY1bklZKNZS@vger.kernel.org, AJvYcCVPDaxyGVOzadUIozZtcYDFXWHJQJyYfYjGoNgcKApD9Nuqx73sPpgS9ANjXyAVKYMlbkab71Snd9nicuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkdi4M6/lvcAeuBw5jmFU9isa8gWO0Ut/TRGeT9jRpoagSeH/0
	roKRKQWg/Ld2s6XNus0xeuhnn4D5KF+X8ogp2zHT8bpGuW7UpbmOHxEFfcqBtdvwN5jlYo/RYyb
	b6kaQU2BJ9+Ot0XY0RkB9rSXFv7E=
X-Google-Smtp-Source: AGHT+IFU6B9p3xdVINAW6AIIji5ouYdEh1Y6M2wOheTBhLFw1wNUMqZ4bodSbRZGl281Uh+EwN7UF/yNPgZmGCWe8Ss=
X-Received: by 2002:ac8:7e8b:0:b0:461:2b8b:52db with SMTP id
 d75a77b69052e-4613c19d37amr154363271cf.37.1730144041136; Mon, 28 Oct 2024
 12:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldya4nv0.ffs@tglx> <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com>
 <87a5ep4k0n.ffs@tglx> <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com>
 <877c9t43jw.ffs@tglx> <81afb4bf-084b-e061-8ce4-90b76da16256@w6rz.net> <109afaab-05c0-4228-8ea0-1dc1aabe904f@gmail.com>
In-Reply-To: <109afaab-05c0-4228-8ea0-1dc1aabe904f@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 28 Oct 2024 20:33:50 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNj4d8_Ow1GyA3uX+2f79V8173e9RWfcX6_KjTPfinZCiw@mail.gmail.com>
Message-ID: <CAJ+HfNj4d8_Ow1GyA3uX+2f79V8173e9RWfcX6_KjTPfinZCiw@mail.gmail.com>
Subject: Re: [PATCH] riscv/entry: get correct syscall number from syscall_get_nr()
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Ron Economos <re@w6rz.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Han Gao <gaohan@iscas.ac.cn>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 17:26, Celeste Liu <coelacanthushex@gmail.com> wrote:
>
>
> On 2024-10-28 08:17, Ron Economos wrote:
> > On 10/27/24 2:52 PM, Thomas Gleixner wrote:
> >> On Mon, Oct 28 2024 at 01:01, Celeste Liu wrote:
> >>> On 2024-10-27 23:56, Thomas Gleixner wrote:
> >>>> Equivalently you need to be able to modify orig_a0 for changing arg0,
> >>>> no?
> >>> Ok.
> >>>
> >>> Greg, could you accept a backport a new API parameter for
> >>> PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?
> >> Fix the problem properly and put a proper Fixes tag on it and worry
> >> about the backport later.
> >>
> >> Thanks,
> >>
> >>          tglx
> >>
> > I wouldn't worry about backporting to the 4.19 kernel. It's essentially prehistoric for RISC-V. There's no device tree support for any hardware. Also, 4.19 will be going EOL very soon (December 2024).
>
> Ok, I will work on preparing a new patch to add a new set in
> PTRACE_GETREGSET/PTRACE_SETREGSET.

Thanks for working/finding working on this! Looking forward to the patch!

