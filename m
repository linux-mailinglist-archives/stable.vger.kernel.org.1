Return-Path: <stable+bounces-28593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C088679B
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 08:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3781B1F22215
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5A12E72;
	Fri, 22 Mar 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wh08Xc6P"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02012E56
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093624; cv=none; b=YLS/mWyWtVtkKDDuf0ci7gXgtaRN/iJ1WQrkwuSRXAs7eMHaUd9EZHr7GREIVnfFfLRcBVhi5WdRFI7FA9iKf6cDMdDLSuoVQ8p3G0sDpLGd1R9cX7KPlSCCJV3vpyrP/RWgBcQUEvYuo07ndr+KG2vgfD7LXRe1SpSCtNK7Ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093624; c=relaxed/simple;
	bh=Yhw03HSz0idnna+yR34xpIkCEZSpOgZ5Sf0IEYITasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erQ43gHqADQFYtKj0c+QxL7ab2ESF0LPU27V2MtqSh7h4x1UdgBGTsv1bXanajCj7GlY25cUqB4SNjm0dfo5rNOsdEF1tXpxuVkTOa1J6RQoZiBgLTkjk43WQZ+cNp+yoY5zhcDahf2TUXAuapbM1JqIFuUM91fGwhGVa0RmTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wh08Xc6P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e10a4083so2046816e87.1
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711093621; x=1711698421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPAa0wf/zbSEHcUANifsWrUgwG+6IErJ7w4tI2+ET3Q=;
        b=wh08Xc6PxaYRBwEUxMN6mhstqUU0qvYsZweCwbjK/MPBu7dlh+sDFexD82/7CXWarZ
         h/Kssvh0q2LaVpyjoYvToROOgB+INHmE0buwXzTq2ik+UmzTwaB/ixirseNFvMuLvvv2
         uJxc9XNVu5N8x+Z0KxGeyBLGvwAcqEQM8sLrRhyDtt0PRVam2LVNhTTyt2f/Yrcpjq88
         NKjswr/46Z/PojMJRVf+x/fa1VanyWfQmArTuvBjeFqzmbS3K1qI13LdyQmquV67TRdS
         pnTj9lrXwTv1bBXId4ZGHAsL88IH/F9pLdZq7+GZHguWtbKvc8Pq4Td/+eT+1QCFCSL9
         fywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093621; x=1711698421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPAa0wf/zbSEHcUANifsWrUgwG+6IErJ7w4tI2+ET3Q=;
        b=Nx5F9bkGIBFMJ+0L1H+zSYkmzfeUn2Hz/IaGGm1mIqu+zuhZDunDRFA1CB9iJ4AtVL
         cTr8vX4eh8GDJbnJtLYOemghW0k03U5Up7DZmuWW9P3CeAyJbkMvWAjmJSYU2HXiQODR
         e00NxnOYwH1ZOqBSHj/DFtH1Wx9A0JG2vi89CFrB4TT/FqZsoWO+88Uex1cPJlxELjqN
         SLSccxs2OyvbIEPL5a0/h58MZMKr7JjbESPbQEr0woY4/Xo/lz5Q6ZeWn7jcwZqbdlOk
         JtDC4PObHs95KQjRSysfOr6EMQvMTuMnW6khAbH32mxcfvv1GzxTSD0UqUkOAvg11x50
         2Evg==
X-Forwarded-Encrypted: i=1; AJvYcCXieQHpVLEclhCBTJB1FTsLMgxLEMSEUQ1zmaS4TBZtKRzLNpB4CPH0+Ne53OO+5JSiWdOUtdaMOSI/VKl4P0mOTDPrTDgz
X-Gm-Message-State: AOJu0YyG8iJIHYdFpL65mYaGYc4j5rNvwACtB5+nUwZN+9bUt0UwbL4C
	A8lIfD0NOOcE8Q/hKH843lfOBGAIW9xUufWvu47vHQuZqyxNC1A6FF2ayWZnkTw2g898W17iGND
	FvWeA+Uyq05Ty92vnoMgddFRB1slJZ75SNGua+A==
X-Google-Smtp-Source: AGHT+IGMlPmh6WdmqSWErCqF67TPp8BSJ8Ax+s3wvqQfGc+YdlHQhOmUL3UDDQEgmrblKQ0L8twrhkOtXf4xDSab2lM=
X-Received: by 2002:a05:6512:747:b0:513:d8e3:fe3d with SMTP id
 c7-20020a056512074700b00513d8e3fe3dmr939101lfs.26.1711093621110; Fri, 22 Mar
 2024 00:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320125945.16985-1-brgl@bgdev.pl> <20240322013034.GA4572@rigel>
In-Reply-To: <20240322013034.GA4572@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Mar 2024 08:46:50 +0100
Message-ID: <CAMRc=MfQnZQU_t9-uDPp18vFikz_9eP6LtnWJYG0+KFgWjBcEg@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: sanitize the label before requesting the interrupt
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:30=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Mar 20, 2024 at 01:59:44PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Let's replace all "/" with "-".
> >
>
> I actually prefer the ":" you originally suggested, as it more clearly
> indicates a tier separation, whereas a hyphen is commonly used for
> multi-word names. And as the hyphen is more commonly used the sanitized
> name is more likely to conflict.
>

Sounds good, will do.
> >
> > +     label =3D make_irq_label(le->label);
> > +     if (!label)
> > +             goto out_free_le;
> > +
>
> Need to set ret =3D -ENOMEM before the goto, else you will return 0.
>

Eek, right, thanks.

Bart

