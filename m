Return-Path: <stable+bounces-50026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2E900F58
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 05:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F56728336F
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76FD53E;
	Sat,  8 Jun 2024 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1UyVIOS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFA20EB
	for <stable@vger.kernel.org>; Sat,  8 Jun 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717817750; cv=none; b=jPFKwuPA3Z4a8ixouQcWqiYX3/AHjgBR1e0ETAeDd/tFjl0wdric4uFgm5LsGTbgMEQ10GGTJ3dwc2EPoXfemitIOCoCUczz4xDFNh6qff883Dheue8wV99/NlF7HWinxAbGu7KKy8Y7Z5N148yeqB5sLX+jsdqFuSMPLTuGrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717817750; c=relaxed/simple;
	bh=j4kcRsRoaYXagcVlc4aj3RqjZAlFJGNpamEnNXIfhXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8yPimK7w7v/RUwcAxJ5/grNqu9tf+UpxHQrYhTjtFZiSmznGvWPjGQZO7/XnEkfHIg6yUcR+oG/h1M/5YzoHjPnlSgHNe8E3UG/F8VvvtRTaHIywYZUk4n6Au+Uc42YmhQf2Jm6h5u3nKkXN6gbEn3R3zSNcdotmosJjup6tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J1UyVIOS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-250ac3acc6dso1349264fac.2
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717817748; x=1718422548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KltA1s7VUNRTd1PbGmK6izLRZPTrGICXXbndgUz/sSI=;
        b=J1UyVIOSSWwXKghk0pgTpLd2QNJdK/H3TjoaxbhFwWqedjm48Kk4JZ0XICvGsYuJJC
         Lu9J0rgq577Gow367bMbHnOHWfJhLEi6D2zSBe8CJfIuNiAkrQBAYMYvAhow0Vjvs3Nb
         4E7dnfMFkSW6rg35gKhJmF/hE1fh8BTgYEDwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717817748; x=1718422548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KltA1s7VUNRTd1PbGmK6izLRZPTrGICXXbndgUz/sSI=;
        b=cpIk26tn4Pxga4nGRqHRLIRhqF/ykI1CfGqma50AxU1/+TUyeqdh4NU0ZwN0Gz24OA
         Oi24swyf9ASdzQP8xuYSgfeZauK3b2CgtS+DAiTeKv+qrVNu1gV+7RCJEe9XNfiu7EVt
         rzw0RIa4JngQqGXUolNoqfbMW+xsxv0rAaJV8ddwHVa0z2sNikVIOZF5N5/QShi9vcMO
         EkFsSKYOVZgcmPoxBP1htZakYwCRGTPTlrfG4pOV6C1UW1L7F2USfYdp4YwluMtA69vC
         Tpp50tMYNKls1wp1GRrbHw10nrK62x/1rSfRP+H09dXVvOcRJ28IV9AWeR8EVMOjNJB1
         X2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKjWgVD64nwPCiy39y7iKVAqz6A/h3qlVR2BjVQynkEQv9qMOSIkHAkev21+9MOqPnA30sY1lfZND9D2Ac+osyqejqSX0
X-Gm-Message-State: AOJu0Yw2MmYqQVQPK4wDucoHuyHCgcfkZeMa+srBrNaFebe+eqmzIm8B
	/v28yhTP1w/7IvlFICIjg7UM9M3DsPLn/fGEZaptnWVWYQ6vskXpTwyRZ7ism/Aa3rn0oZjG1GM
	RDBcOPDFDb2iglkHR/ShsGOjwWMVKBH+JRzlf
X-Google-Smtp-Source: AGHT+IHe7gxzs1S7pNTTl7STORIz+GRGHc0QiiXOdUo7yjJfr589hzZyCwwwlTqDVLMo3BR50OLM0QbpBVL2TtpA0Kc=
X-Received: by 2002:a05:6870:b507:b0:254:8c7b:889e with SMTP id
 586e51a60fabf-2548c7b8d0cmr1716996fac.16.1717817747891; Fri, 07 Jun 2024
 20:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607203543.2151433-1-jeffxu@google.com> <ERhTlU0qgh7_BDdbPy2XWV0pYgJkVYImFQZVPIfvx9F9uyhfaopo8FMZa8WZ9Txx1bzq8qEez4QQ8sOQIwKeQEdn1rym1JgDmvG3zOKdpeQ=@protonmail.com>
In-Reply-To: <ERhTlU0qgh7_BDdbPy2XWV0pYgJkVYImFQZVPIfvx9F9uyhfaopo8FMZa8WZ9Txx1bzq8qEez4QQ8sOQIwKeQEdn1rym1JgDmvG3zOKdpeQ=@protonmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 7 Jun 2024 20:35:36 -0700
Message-ID: <CABi2SkV9fnVjscLzKwa6FxNzfYU64ibGQxi7VWVEaGr-3gXfOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, 
	dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, 
	jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resent, (previous email is not plain text)

Hi

On Fri, Jun 7, 2024 at 2:41=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@prot=
onmail.com> wrote:
>
> Hi
>
>
> 2024. j=C3=BAnius 7., p=C3=A9ntek 22:35 keltez=C3=A9ssel, jeffxu@chromium=
.org <jeffxu@chromium.org> =C3=ADrta:
>
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
> > didn't have proper documentation. This led to a lot of confusion,
> > especially about whether or not memfd created with the MFD_NOEXEC_SEAL
> > flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
> > MFD_ALLOW_SEALING to be sealable, so it's a fair question.
> >
> > As one might have noticed, unlike other flags in memfd_create,
> > MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
> > is to make it easier to use memfd in the most common way, which is
> > NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
> > vm.noexec to help existing applications move to a more secure way of
> > using memfd.
> >
> > Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
> > MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
> > Those are based on the viewpoint that each flag is an atomic unit,
> > which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
> > designed with the intent of promoting the most secure method of using
> > memfd, therefore a combination of multiple functionalities into one
> > bit.
> >
> > Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
> > year, and multiple applications and distributions have backported and
> > utilized it. Altering ABI now presents a degree of risk and may lead
> > to disruption.
>
> I feel compelled to mention again that based on my investigation the risk=
 is
> minimal. Not to mention that it can easily be reverted if need be.
>
The risk is not zero. If we changed the ABI it would be propagated to
early kernel stable versions. Various Linux distributions also
backported the patch to earlier kernels such as 5.4. If it needs a
revert, then everyone has to do it again.

> In my view, it is better to fix the inconsistency than to document it. I =
would
> argue that "`MFD_ALLOW_SEALING` is needed to enable sealing except that X=
YZ"
> is unintuitive and confusing for a non-significant amount of people.
>
I understand,  documentation helps resolve the confusion, the next
step  is to  update the man page for memfd.

Thanks
-Jeff

