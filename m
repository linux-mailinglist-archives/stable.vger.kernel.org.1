Return-Path: <stable+bounces-89417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D31A9B7EC7
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5596328211B
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A91B3725;
	Thu, 31 Oct 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YU8riqJs"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0C1A286D
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389417; cv=none; b=dVb9kEM1E+qLbvWvIloFDcMAdU7nAoyGwhGdJy24zx1YN+VW72/CNfKEgt7Z34gYFhPCQxnBmuRGQOKvXX2bkE/JiQTK1FhxpuFXKZzncL84MHPQHWh8OxAbLNeNgTNuRKlbjuEIxnFsvCg+NVgglGx0Md3kcZK8xStTxRoPsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389417; c=relaxed/simple;
	bh=vfsB3Thfd6DUJWh0LyamNbEnTDENOiTplgjgv49TJj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skO+pa9tMbqraLykQvzwGUdGw2xNBLMwS3LKEkIvVfZNqcchWvoRwnYknEuceLmkj1TY0gBn9Th/brwA/aAZpUSdAltMKOuhFtoRHB+ZnUEsmy+oRr/6i6TWet+hY2IRpPu6ejN5BQof6ato1EPJRf6y8y1Ul50q48CZvTDoY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YU8riqJs; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso235315ab.1
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730389414; x=1730994214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gak7b2hQidOQibyX7hkapEVVPckTY1xPlBaffa3Vjaw=;
        b=YU8riqJsIGgVyBFI3x0wx7nVA9942d3Ih8YZs17FpK6dwSpbIh0bD2G10KZAfwmseA
         5/2EignVAkD+04lSlAuhcmg3cr9hm2hQMWXqpjI49ZcJDc6nhB5HHzWrnQVPOwu2B/3o
         7XB6DH5LlHWDytECvGQdBOlwn0LK706H6/k5Aniy9uygCKAGXu1C7VYTF5vCNz+7DkSj
         cwYeT+iLbXNgGqKXW9xL16iDZzwrdADrENX0ft1pwGm6DV4BGjF5rLAj9ICaWDSAlpqK
         y5uMuBhlq4Y/3rU4Oyvb8B+5EucucdjCkT/otunF6JN78Lc0GM425b97QsgU/+hVoSOn
         buyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389414; x=1730994214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gak7b2hQidOQibyX7hkapEVVPckTY1xPlBaffa3Vjaw=;
        b=Cc0IhOqHjwdgB2nryVbIZQx3zENjoFgI9uN+8zoG9KuYy4wSdvH8lDhkHuh6VC7fHZ
         E4Ibzr+nb+CeONmOa2A6gEm4aa8D+EiaLELl6UGcDe905VAYKqlJcNwc4UTu3Wcb3/kA
         xFCHzdE/Box7FX/eZMkGfp4qa/GtmWPv+RJ3P4c59gD4Dq3rVAvAF6zr/uaY9Mx3bFdx
         Q0McuL0eM9n5r8rbw9sUs1MdKu2mQQVHCI0JI6/LULR2g8fdqI7COaa1wv17eP9wgBD1
         ZubN50eVZTIp1z9ltux3OMVM65qZ6CS4g0Z4ap+QaxyZKzlCY/KEr6vKG4FB7mZKnhjd
         ql9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbru6d/T8jhJDzk0r8ta0cH6/BfQUg5mgyN50xXz7zMNHasWWvRe/JSKvHfBYsirdzplW3hX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkxyhPU8sBmZT01Tu4SeVWh/t6fehW6feTW3G1g08X1QZTZri
	odRya+todDGx5C6BsEahLfYVTx9Uh8eBDGCmPRSTDbx7nhfh6AjGr8KwsuMtu+OxW4+UGQRL03L
	JIJCQyxwTB1eJVfbxiYb4d6r8bXDA9BN31j3WH4vlYRqSsUnLnZK5
X-Gm-Gg: ASbGncvK4rwp7lLBFDuxcrsCLSfaq0Xff2B8X3qmaZ4MYiFBn9yZaQNz1nze/zb2TdZ
	5EDd+WMbuvFiceQXPQ1sGjDy9ub0mb+U=
X-Google-Smtp-Source: AGHT+IFGBxBwu0pfOalxBOWa30kiZgTlDKwbfWjgsTYFAPFbqK7EZY7RwXMvypzXV/9plNHmg5dzWx3tW+rk7khqIv4=
X-Received: by 2002:a05:6e02:1a08:b0:3a3:dab0:2399 with SMTP id
 e9e14a558f8ab-3a6a9414a07mr3022335ab.27.1730389414309; Thu, 31 Oct 2024
 08:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031045602.309600-1-avagin@google.com> <ZyNS9J7TOQ84AkYz@example.org>
In-Reply-To: <ZyNS9J7TOQ84AkYz@example.org>
From: Andrei Vagin <avagin@google.com>
Date: Thu, 31 Oct 2024 08:43:22 -0700
Message-ID: <CAEWA0a7W4u189wViEk2P9ZBgUe7DFGmSA8UKW0gKvCC8_pRiHw@mail.gmail.com>
Subject: Re: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
To: Alexey Gladkov <legion@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:50=E2=80=AFAM Alexey Gladkov <legion@kernel.org> =
wrote:
>
> On Thu, Oct 31, 2024 at 04:56:01AM +0000, Andrei Vagin wrote:
> > The inc_rlimit_get_ucounts() increments the specified rlimit counter an=
d
> > then checks its limit. If the value exceeds the limit, the function
> > returns an error without decrementing the counter.
> >
> > Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> > Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Andrei Vagin <avagin@google.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Alexey Gladkov <legion@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
> >  kernel/ucount.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 8c07714ff27d..16c0ea1cb432 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -328,13 +328,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucoun=
ts, enum rlimit_type type)
> >               if (new !=3D 1)
> >                       continue;
> >               if (!get_ucounts(iter))
> > -                     goto dec_unwind;
> > +                     goto unwind;
> >       }
> >       return ret;
> > -dec_unwind:
> > +unwind:
> >       dec =3D atomic_long_sub_return(1, &iter->rlimit[type]);
> >       WARN_ON_ONCE(dec < 0);
> > -unwind:
> >       do_dec_rlimit_put_ucounts(ucounts, iter, type);
> >       return 0;
> >  }
>
> Agree. The do_dec_rlimit_put_ucounts() decreases rlimit up to iter but
> does not include it.
>
> Except for a small NAK because the patch changes goto for get_ucounts()
> and not for rlimit overflow check.

Do you think it is better to rename the label and use dec_unwind? I don't
think it makes a big difference, but if you think it does, I can send
this version.

BTW, while investigating this, we found another one. Currently,
sigqueue_alloc enforces a counter limit even when override_rlimit is set
to true. This was introduced by commit f3791f4df569ea ("Fix
UCOUNT_RLIMIT_SIGPENDING counter leak"). This change in behavior has
introduced regressions, causing failures in applications that previously
functioned correctly.

For example, if the limit is reached and a process receives a SIGSEGV
signal, sigqueue_alloc fails to allocate the necessary resources for the
signal delivery, preventing the signal from being delivered with
siginfo. This prevents the process from correctly identifying the fault
address and handling the error. From the user-space perspective,
applications are unaware that the limit has been reached and that the
siginfo is effectively 'corrupted'. This can lead to unpredictable
behavior and crashes, as we observed with java applications.

To address this, we think to restore the original logic for
override_rlimit. This will ensure that kernel signals are always
delivered correctly, regardless of the counter limit.  Does this
approach seem reasonable? Do you have any concerns?

Thanks,
Andrei

>
> Acked-by: Alexey Gladkov <legion@kernel.org>
>
> --
> Rgrds, legion
>

