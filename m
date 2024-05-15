Return-Path: <stable+bounces-45138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD98C627A
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E721C218C6
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADD4CB55;
	Wed, 15 May 2024 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhTz1fI0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6541A81
	for <stable@vger.kernel.org>; Wed, 15 May 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760224; cv=none; b=Zy3vhJyF6p938XxO3bNu+M61XMiJdb/QhD98+tFz50md2orQ1rWDSscSRfaOIObz/ZxAKHfrPiAg3lsvgETlq95GZFs09UPYEv+Uo4Yi78KZuLNjLt9aCj/7TLKYgqTGS6cBFWt/WsifA6gVyzHtW4165FPojOSMJDCBx132ZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760224; c=relaxed/simple;
	bh=YAY3WnMSPrspD7n/S6OWGOkJB9FqofY7+vWeAU7VWpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stsaf8Zo+RMAC6SSLOxYuktuofBT7a1+9eDFfAQpgDOLGkUiTD3zNKhhMDpbU58lRCFU5o+RyXuteteLmfFkdOFxqUv85YbiKsEoa57CFm2Et9LJFeZPQx/+/e/m1YiGEAcPCTBUDU1btkWH8kCy7agWxbYWq3cuyo7++R1YP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhTz1fI0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e52181c228so52383521fa.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715760220; x=1716365020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmEl2KEXeaBN1EGAGSPW7ss7NylLt6nkqDQwGPAEkwU=;
        b=UhTz1fI0JaqLf3XidpOTUf7wtaRfCWf8Gzr2WhOUBq8mqE3OuWoKYlgkOLPF2fAZm3
         TacM336wngf55f9nQU502X9nrOgw+ULXHmVvtaC3VqQWfqEFNw8X3wggmDQbiplBA9w6
         xZRGd3aRn02MQkgaCrNgxEDCS1B4D5Md5hn/ZTbFFanW3Q/t1KJEcWS4UYf5udaHXUQx
         G3jmR7KNIHF5m7ztPGcd/NwyQXP1bx2PhQ3LpjUVxNNPmeasGI8ZF9NLOwphSj88VRxC
         bMEbr/kNEK7tGBxgxtDT4xLpQ55T0vE3TAW9zF6jMFmeKJAyOKTZic6J6EGQUQI314oG
         dIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715760220; x=1716365020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmEl2KEXeaBN1EGAGSPW7ss7NylLt6nkqDQwGPAEkwU=;
        b=gaVUqUIkfbovUOO0+8VS4S4cUmBkbwqAyn52izPYIk0g6mpY5xmbNBx9RjpMfbmZOs
         MUpnN6Kr5j5ftS4E3txcyCkPEi0BcUju3jxShFBJtRnJ5L6ucb8s2G5qhQk0jaWqK6qb
         gEDD4aPGX9lm6N37+9ZdBbOotQwQYmsuWN3kSUP6FcVgBij+PWHMGxJJxWoK2qCvoHtK
         w8v2DTTdPQnuk85RJA36wcA8t0BXdQ+FJumXWR/Bvx8PeoyAiOJ/bphAESvuKn7QiJK1
         uVshU0XavtUjTpvlwjj7IaCjANhqU76rpiJlnxNLjs0jDXvfCuhg5x23py2Bwiv+hZhH
         V5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDUOKSw6C/cuaxUDI1TNPS+AjIi8J0SEET7c+SETT7cASy4jDLHXRPJ3DwqRYHfVJ9tOgY+TOWUXFxH7FamlqHnPySsXCx
X-Gm-Message-State: AOJu0YxfUlEJcSG/n0xQ1QsGotV65K6eVpif0IkobIDCdzRLAOHC91vk
	I8E6txBA6Xs877wFLATzRVo5jYvoIrWzOMDGz0pvn8WIMLYejerMEU7AnDEJO7jyvtdjM40CPWt
	rG5YyIR0BqJHE2Te/UlB4BzdizYc35CBLF4Y=
X-Google-Smtp-Source: AGHT+IGiKr2GaMVaho7yu7qKKk7Ni01CD2xlytbygEyEJL5DkBN74vUiHeRTPmT3jpZCjLgZsEbqGFDpX0OuMm57eJk=
X-Received: by 2002:a2e:8187:0:b0:2de:d4ef:af19 with SMTP id
 38308e7fff4ca-2e51fd4306dmr101481181fa.10.1715760220334; Wed, 15 May 2024
 01:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514083920.3369074-1-ubizjak@gmail.com> <2024051540-tranquil-stoppable-30ff@gregkh>
In-Reply-To: <2024051540-tranquil-stoppable-30ff@gregkh>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 15 May 2024 10:03:28 +0200
Message-ID: <CAFULd4an2qYe3L-yrfnmf3F1AZPciNemjdMEorO2BLHJX72uXg@mail.gmail.com>
Subject: Re: [PATCH] x86/percpu: Use __force to cast from __percpu address space
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 14, 2024 at 10:39:18AM +0200, Uros Bizjak wrote:
> > commit a55c1fdad5f61b4bfe42319694b23671a758cb28 upstream.
> >
> > Fix Sparse warning when casting from __percpu address space by using
> > __force in the cast. x86 named address spaces are not considered to
> > be subspaces of the generic (flat) address space, so explicit casts
> > are required to convert pointers between these address spaces and the
> > generic address space (the application should cast to uintptr_t and
> > apply the segment base offset). The cast to uintptr_t removes
> > __percpu address space tag and Sparse reports:
> >
> >   warning: cast removes address space '__percpu' of expression
> >
> > Use __force to inform Sparse that the cast is intentional.
>
> Why is a fix for sparse required for stable kernels?

Named address spaces is a new feature in the 6.8 kernel. When someone
compiles this version with Sparse (and certain sparse parameters), it
will spew many sparse warnings. We have fixed this in the tip tree
(so, the fix will be in v6.9), but the tip tree diverted from the
mainline in this area, so it was not possible to fix the issue in 6.8
via "urgent" tip branches.

I thought that the fix falls into "some =E2=80=9Coh, that=E2=80=99s not goo=
d=E2=80=9D issue"
category (due to many sparse warnings). Also, the fix is
straightforward with a low possibility of breaking something.

> > The patch deviates from upstream commit due to the unification of
> > arch_raw_cpu_ptr() defines in the commit:
> >
> >   4e5b0e8003df ("x86/percpu: Unify arch_raw_cpu_ptr() defines").
> >
> > Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier=
")
> > Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=
=3DaunFieVqZg3mt14A@mail.gmail.com/
> > Cc: stable@vger.kernel.org # v6.8
> > Link: https://lore.kernel.org/r/20240402175058.52649-1-ubizjak@gmail.co=
m
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/include/asm/percpu.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> And also, what kernel version(s) is this for?

As instructed in the "Procedure for submitting patches to the -stable
tree", it is stated at:

Cc: stable@vger.kernel.org # v6.8

>
> I don't see this in any released kernels yet either, is that
> intentional?

The original fix was committed to the current mainline and will be in
v6.9, but please also see the above reasoning. However, it is your
call, so if you think that this issue is not problematic for a stable
kernel, it's also OK with me.

Thanks,
Uros.

