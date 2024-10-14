Return-Path: <stable+bounces-85059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50699D47E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E50D1C22A01
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F4C1AB536;
	Mon, 14 Oct 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/fEKjQN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177928FC
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922810; cv=none; b=cNdYSnIJZmJjvd7YQz1T2yDI+m7H82H41Z/5tSY5GqFX/nmLVTFAounnzU/yWl65AoRCSMpbzn2D6dcUYWaLm1DPi4CzG74FdFkJ5qbssO04Nggrev7Ytt/bIow+AuCp+S6pixNYFA7lCmHUSXmXzpLA6YSFaNX374Wo8/dUu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922810; c=relaxed/simple;
	bh=cnkk0jBQCIdhAHHY7uktG29SBgaIiHS/HfWw5BiHsLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKhH2wpl229SUNGYWxKLioAFxJz+rvlXSdmE3q2AC1e3pbJSY7ljIwx3OoWIGNA5L+rTozOOLdxbyu/wtAXp2Zm9+GwOZab5sPsuMJtr1Y6qDV7wUjk80GUUFngROJoo0P8Upo90LoT6xe+1Zlf91P8mOm4I8HicTMujTKXs678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I/fEKjQN; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2888bcc0f15so141733fac.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728922808; x=1729527608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOWl8zauDOD9X9+IpvQQTtv98Lz1FGoaHRyM1DNz/0Q=;
        b=I/fEKjQNNmq59y24PKujeOfYehV6bz0IWIBxUHupHCFrLmyaSg/mYr3PugXT6RJMjv
         sFyrgHOC/Maejp04EnWqyg5G7JyEuNb5rd37aEtWgvILvLRCTBbeOY0+JQooQ4WOi0kg
         zy9w1oIzqFO8vajn+7ZYGiJ6U46NKP8chQX0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922808; x=1729527608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOWl8zauDOD9X9+IpvQQTtv98Lz1FGoaHRyM1DNz/0Q=;
        b=PrvHre5MmJE2DEwYm/8aLhChCth9bl8v9qC1kCjiGVHqlPO9jt438I0RqvHZxY+RW5
         CvvMPMY+MiQXxvByFSABySLce1Ljg7Dk3GE87bOVg9XheZk+Z/Mps1C33XpD0WpNS87E
         HfgddHFIbLdIw9oMq2UiXna0HakmRYyq5h/RfGwEsfdMQtEju7zlGXJrOOH4rUX6Rsh4
         q3JiBuWZwc77GxwQOVQnx55J1Fe82CU3QPmou/wYVvbntAzpBSEpglbJrma4lerkBkEh
         1JaQcGkEoaQRmYl/LhCE6iWZors79jBo9+5lJjBF5RYZbQPlVnr/ms3ayK23RaBicWKm
         pU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6pYtUHBLAQbUPPFDaNX6dGVlF5w7tXN4H35pModnUIiefF+U25Z49jt5R574aL3nEwSj5Wi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rYyBuNzRgRAig8BTOJ1DOpxnqUbPN3wouYJMLOqJlhQdhrcO
	mqEdU0a4UWoV6qQ9ymFpXyMGJbXEOwrK+3XPpQc5MzIRAIC59s2QM2pT3gwQcYsf910YK6C1KnV
	hXEUH2dAp6jHjfFeAs3lPHZZltU08Q1mA5JtI
X-Google-Smtp-Source: AGHT+IG7AMNvNQELWWZhN6Kz1sVU8ANAASSrc+lFo7h5x9H17buezPZAIxz39jet4jzjfW0wRay6jcahDpfTZ3GW8b0=
X-Received: by 2002:a05:6871:721:b0:27c:a414:baab with SMTP id
 586e51a60fabf-2886d9f5aa5mr2105733fac.0.1728922807999; Mon, 14 Oct 2024
 09:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh> <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
 <2024101437-taco-confusion-379f@gregkh>
In-Reply-To: <2024101437-taco-confusion-379f@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 14 Oct 2024 09:19:55 -0700
Message-ID: <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>
Subject: Re: backport mseal and mseal_test to 6.10
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> > On Sun, Oct 13, 2024 at 10:54=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > > Hi Greg,
> > > >
> > > > How are you?
> > > >
> > > > What is the process to backport Pedro's recent mseal fixes to 6.10 =
?
> > >
> > > Please read:
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rule=
s.html
> > > for how all of this works :)
> > >
> > > > Specifically those 5 commits:
> > > >
> > > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > > >     selftests/mm: add mseal test for no-discard madvise
> > > >
> > > > 4d1b3416659be70a2251b494e85e25978de06519
> > > >     mm: move can_modify_vma to mm/vma.h
> > > >
> > > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > > >
> > > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > > >       mseal: replace can_modify_mm_madv with a vma variant
> > > >
> > > > f28bdd1b17ec187eaa34845814afaaff99832762
> > > >    selftests/mm: add more mseal traversal tests
> > > >
> > > > There will be merge conflicts, I  can backport them to 5.10 and tes=
t
> > > > to help the backporting process.
> > >
> > > 5.10 or 6.10?
> > >
> > 6.10.
> >
> > > And why 6.10?  If you look at the front page of kernel.org you will s=
ee
> > > that 6.10 is now end-of-life, so why does that kernel matter to you
> > > anymore?
> > >
> > OK, I didn't know that. Less work is nice :-)
>
> So, now that you don't care about 6.10.y, what about 6.11.y?  Are any of
> these actually bugfixes that people need?
>
Oh, yes. It would be great to backport those 5 mentioned to 6.11.y.
I don't know what will be the lifetime of 6.11.y, but keeping mseal's
semantics consistent across releases is important.

Thanks
-Jeff

> thanks,
>
> greg k-h

