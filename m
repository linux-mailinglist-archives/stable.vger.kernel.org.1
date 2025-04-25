Return-Path: <stable+bounces-136713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B4A9CBF7
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E421BA83BA
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DE2522B5;
	Fri, 25 Apr 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSIB+P22"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B81607AC;
	Fri, 25 Apr 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592433; cv=none; b=HpCfKkdEBltF8SyTNrKr8dCZ5uEFWToQQyrhKwTx1io1+EcU6A3CPET6lf5YRQOoGu1IfRALrHeSXgRx2Su5D5I0Clv8lCuR4SeSRoree37l0cikgvKcQm+efuFeHNOUHESpVCB9ru9C7QgYlxfELbIZcN1U6KIJ/Cm7qS/0TTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592433; c=relaxed/simple;
	bh=LER9aU+L0aeoLrB3bj1csguH/ZwflKpZIZu3s7LPh+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4bFff7mTTOfxFgFpBf57q1i8fofOD5cZbgRG/cE08jKCBuHrafbpth6Qkc12rusQCvUB8EkQNpyZv+7jqv/7DuvMhXGyerrMKA2KWW/gyuZHEXwex+rngKnZKMAimikxtHoYKy0L/R8B9xZoCAjXJm5zpi+VVavu200XWbevVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSIB+P22; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769b16d4fbso15330721cf.2;
        Fri, 25 Apr 2025 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745592429; x=1746197229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vQ3ECSy7kq++7n9LdZsctmJdxrSk1yP0N+IbR2cYEw=;
        b=XSIB+P2272sx59mwGrBV4q8mItNAUWHOyDqez9YDzyyfsGb2DOUzBkWvnlZMi5rOUh
         ZcG1mRv6DkJvdp2oZWxldbiY4T1ktmu9BW2l7f9QL+5fJcfx5qDZgTHcaMmx4z93PuWU
         iZNe27njzlUuosbMshEApJpYVPtx78tyO5bFgG4C5ZWFLZqpIsLZ5OZ5TCMj7JhC7vh5
         DaA1Rxar8BRH7mWWfifJJ12g0mMnlsHCFcYVlyLp1Km9efazdrTctQxFPBJTh9SWbRqa
         R+H43h5Bn20nOtsaGjQe/W6pE8e/T+OSzlKeCIkkS27N1+I1W6W7zE5n+Ct7GP3F9p8V
         BE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745592429; x=1746197229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vQ3ECSy7kq++7n9LdZsctmJdxrSk1yP0N+IbR2cYEw=;
        b=lxPZPEbEydvcvV5z1q7S3iCJ21KNEBUAtedZee1fJHldA/jjBueJdnkk5AGp/4drUo
         eNA8AoIyk3tv2GQNWLG3Aq9x4P9K0NQ9WNKLDvuzvIN6AEuyHYhhwhC1wmtkRiN5DV4+
         fvjPxHI7YNRxa0czUL/XDLi3MvaLJJaYmQvZkI7bQGWPRI/uamGVYCduvgAVIV8S0yNX
         +CbX0j8btnvMkERVNjHPkfUCvfX14uS6d52LvWFSnJrAM5071U1FT//yqdutU/FqBDAC
         v+5wuLkrMYQ2AR4ieVqvTF4Ga8F2khw/MRDEPOgJL93hfUWy8LCCC/8uV1n09QBmY5vG
         jdWg==
X-Forwarded-Encrypted: i=1; AJvYcCU8qY2AQ9yQY36jb9tT5LYIhOi2NiRO2/wdBiOu/vrdN/nVQWjCgdFeh3ol877UM02PIht15DK4h+NjKso=@vger.kernel.org, AJvYcCV9ellItojGU85HMgTRSoroP/UkywMLQIVxQFLpP38M6EwLnpNgh8T3UnOVv388JeDmOhSahRUS@vger.kernel.org, AJvYcCXmhigCO7MiOsUCi6bA89fpJ90JTyy6EdW/l9j1QF8TuTSdNM3omGcUOQDAi90EBoKBOoiwZbiBmAhP@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJkWKpbOsxwsmDKjsJX/2cTcNIMfMioa1HCfbYu6x6+Fx9OCd
	Ff66V9d+W89xYcpPCexYFtZY4g/cV3W1M8jVNDXuEU5zA4rv9RIaIPfKchEq5osMJn0yb2ZK6r7
	j8LIbYp4xMwSyZ2hdEs1TXDgdANw=
X-Gm-Gg: ASbGncsQ9bhXapXWoGz04u+9pFUpPkJzzCucvTzvbj7r+VAFGi+7c4EtSc2X98oqT2t
	Uy3iZVv6oDy0oDa9KLdmNHlKGK07dYDBjmArAvC2W/9yGBxUHG3d5dGQ7XPcJ2BFqmUdgXNUaDq
	Cv5QyDJHcOfqYIb3IS8fH+rsoarpYfdC8xELi85EElj2SKYxngbE86Q5R6GgITgCSz
X-Google-Smtp-Source: AGHT+IHdyaZUkjx2wLyQvz4EyKo0TT9LnRXvma57qycBPjr9Qe5W18EFaKNddII2vuw42lPtPbimo+O1vIN0gI8NBpY=
X-Received: by 2002:a05:622a:30c:b0:476:90ea:8ee4 with SMTP id
 d75a77b69052e-4801e3f7027mr45924211cf.32.1745592428986; Fri, 25 Apr 2025
 07:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-uhci-clock-optional-v1-1-a1d462592f29@gmail.com> <2025042549-comma-whoever-ffe7@gregkh>
In-Reply-To: <2025042549-comma-whoever-ffe7@gregkh>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 25 Apr 2025 18:47:20 +0400
X-Gm-Features: ATxdqUGwH3DNr9STx1xUjKlf5u6ZwPeMTDrUv9cMSBaOb0zfPHoNmV5rMIxw104
Message-ID: <CABjd4Yxmk9qLekptHjN3pO7rn8kJ=rtNRBSMJCCU8rafROsq6g@mail.gmail.com>
Subject: Re: [PATCH] usb: uhci-platform: Make the clock really optional
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 6:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 25, 2025 at 06:11:11PM +0400, Alexey Charkov wrote:
> > Device tree bindings state that the clock is optional for UHCI platform
> > controllers, and some existing device trees don't provide those - such
> > as those for VIA/WonderMedia devices.
> >
> > The driver however fails to probe now if no clock is provided, because
> > devm_clk_get returns an error pointer in such case.
> >
> > Switch to devm_clk_get_optional instead, so that it could probe again
> > on those platforms where no clocks are given.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 26c502701c52 ("usb: uhci: Add clk support to uhci-platform")
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  drivers/usb/host/uhci-platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-p=
latform.c
> > index a7c934404ebc7ed74f64265fafa7830809979ba5..62318291f5664c9ec94f245=
35c71d962e28354f3 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -121,7 +121,7 @@ static int uhci_hcd_platform_probe(struct platform_=
device *pdev)
> >       }
> >
> >       /* Get and enable clock if any specified */
> > -     uhci->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     uhci->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
>
> Why does this need to go to all stable trees all of a sudden?  This has
> been "broken" for years, what changed recently to cause this to show up?

Users who suffer from nonfunctional built-in keyboards on WM8650 and
WM8850 based laptops complain. It used to work on even older kernels,
but not on current ones. What changed is that I found the time to
investigate :)

The way 26c502701c52 ("usb: uhci: Add clk support to uhci-platform")
described the change implies that "optional" was the intended behavior
from the outset, so I believe it deserves a backport. Don't know if
the age of a regression prevents it from being considered a regression
or not.

Best regards,
Alexey

