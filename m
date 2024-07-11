Return-Path: <stable+bounces-59138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8C92EC3A
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192441F22781
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2316C6B7;
	Thu, 11 Jul 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTrhPskK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F616B392
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713854; cv=none; b=YrH8/hs4Czbbnto+K6UYfuoExgJJg5uq0CDNnPpWeuQYT3r1Pg9z5qVKgskmN9+OkcDcoIQQdfU17K77E7eUn++Exa5T5FP/BZzsNZnF1c4/P6tm9KqYETVw5NyYUUv+epan4jnJD1yDpthCfNyoHIEag+g2z1WtvonfyNZ6YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713854; c=relaxed/simple;
	bh=UlomuCi2jufaKAgRER7mFTLXjMfqKIuCEo1u/GmUxXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCW3EUOOJrtaWLjc/dAzdRfasrphUG0KgBRIHfSD3evG4S3oKWuBoKyolZ4lSNnJJI3YW2cyL0NU1U29umFXpT9ylQncIJV3cVjTYFP0zCafpDzIhMKxC0E0mC1Vr9a9hHn74rqEhN08USCeSsN0AdGWuKjrPnL+VhfMsC6bLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTrhPskK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25957dfd971so534655fac.0
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713852; x=1721318652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=YTrhPskKSSzbEcmULdSbVD7301IETT7/a2O7cpB4J+LEu75veXBb3eR9Wyir1nlfLk
         XC3SPDhsTXl2zxX1cdAhdfex6J5CmJcB0vSv2Y309yIYLeuV5ozUmmTt5yKLQgMr9HdN
         r7xkQg9u4UIlbuQzIuh6yrH3sB1arBzd2rSBCe4bHmLPeb8x/3egyF+nwnUGY5bP2seA
         PhrUmyOdGgMc9F6OnUiGH+Xpq0m3YdLhx6Gz4VRQnNt0L9JSZCGcWMiklKiBKHagpTxZ
         z2hkoon+BVh3sYPAwhwzGVhQgnPrxGrhC88pHKtS2+iQ4wLofH6unjXmS5ea6cXpyHoc
         op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713852; x=1721318652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=msyhkqT0DgXSsbqbF98cVdoY/8NExTKEYwf4oujyYORxxrzlS7BxEdLDne9/y8LHOm
         giKYL4opWTv2Y172zmldwFdLTWP9nSPZQQ3ab7ePKWaSjL7r3xrEl58J1/5Cd52IDAaw
         ptlqqwi677vmLqocyN2hTRfxgg5wBq2gm8V/MDM/7agohuFGljDDx7yJzWrWON2YXgSv
         U+3s5bPJrONSBrDNjI1NDYiwz33RXVHk36znQfsLrjg0go4TumOuuAh/vodUCkAGzjNW
         HQQdynZpFN5LdYe4UrCnAijho8uCBh8lZr657F2uN/DQK5Fwu36XuhdZFPGQkpDehf1M
         y77w==
X-Forwarded-Encrypted: i=1; AJvYcCXW4Q7t6Nsv4iP4xiNXLw4RIAQziBoofPxr5nTQvSueRG/dRtAKs5qWkB+M+FRyVpxFsDcMdN6wrDRG9dMtQHIBctOIaLyI
X-Gm-Message-State: AOJu0Yxwq3+i8vBgZDztr9oQYjf0PNzUUis8E42Naf1wQTjwY94q/mOr
	09jBYKpRsxLMJ5NOuNO010C8o7BQxZQzS3DalZlxPMCrn3wzxNCIINXjar2BlH8WCh79Z8AzkRc
	4ZQ3giYddnZ/a2EEjEfhkA/CtjNxr6+TnVV81MQ==
X-Google-Smtp-Source: AGHT+IHuIlKldLtTOQoLFnrewN3z8O8n69aqt+rXEcv+GsAIFjWQw6LCkcziQCx6eaN3xVdkr1up+9hn6/jeaKsoh+A=
X-Received: by 2002:a05:6870:9727:b0:25e:1817:e4ac with SMTP id
 586e51a60fabf-25eaec16f18mr7346929fac.42.1720713852312; Thu, 11 Jul 2024
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com> <20240711081838.47256-2-bastien.curutchet@bootlin.com>
In-Reply-To: <20240711081838.47256-2-bastien.curutchet@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:36 +0200
Message-ID: <CAPDyKFqzR4VJUHW5EHf7-vzZ=TNPDAngFYQfksduqgcx1qEAkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: davinci_mmc: Prevent transmitted data size from
 exceeding sgm's length
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Christopher Cordahi <christophercordahi@nanometrics.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:18, Bastien Curutchet
<bastien.curutchet@bootlin.com> wrote:
>
> No check is done on the size of the data to be transmiited. This causes
> a kernel panic when this size exceeds the sg_miter's length.
>
> Limit the number of transmitted bytes to sgm->length.
>
> Cc: stable@vger.kernel.org
> Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index d7427894e0bc..c302eb380e42 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -224,6 +224,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>         }
>         p = sgm->addr;
>
> +       if (n > sgm->length)
> +               n = sgm->length;
> +
>         /* NOTE:  we never transfer more than rw_threshold bytes
>          * to/from the fifo here; there's no I/O overlap.
>          * This also assumes that access width( i.e. ACCWD) is 4 bytes
> --
> 2.45.0
>

