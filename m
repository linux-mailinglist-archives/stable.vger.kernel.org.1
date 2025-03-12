Return-Path: <stable+bounces-124145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74AA5DBBD
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6E9188FFAD
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CA23F367;
	Wed, 12 Mar 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfmRQZ/5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80651E8327
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779603; cv=none; b=I1LIRv0sk7M/oIzFGIHYKSxmFmP9I8rcwX90XfOHUUFRS/JEuc65oZZMDC6/n0zEQMgBi6XPI1PdE6fbzr+z15W+RzCQLYPjJTMhlg1L+uT5aUsVvvhFhmk6WDqRHoC9pK8wXIJzd/mWLwXVuf99D/8L5mFAWBo05WnWPRfxbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779603; c=relaxed/simple;
	bh=8UBmSxv1OwD+ioMgQknmsTs5rUzvzJDaMUiBaEWBDEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj38nuP816OqAlDMQokhX6ZJeFRtzSn9nUhJ3IWsrk42nF79MNWbEms/c/Vx1jqfdO2iSDEatWS4y6GxqePQRoBGmXaYsMD0xDypS0jHsMqX67c9LEifZAkeMnD9buBBodg4SgRYd0go3doa3Mle8Of6npvPPbCAj8DGyizhakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qfmRQZ/5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c11ddc865eso1727687fac.3
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779601; x=1742384401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UBmSxv1OwD+ioMgQknmsTs5rUzvzJDaMUiBaEWBDEc=;
        b=qfmRQZ/5UBV03WqOmIPr4g/BqdcgWAxUZii/4TPbDhxFK8APn+iuKm91a7EHZlZtzb
         UznGGWW7D8rcUo6Zd0Knpe+ACi79yILJ1nOQ2iUcXEJ64z7RtvLLpYL3nJ2KxW+W8i32
         cDgLSICNpGpAakpYnhW7PCW3j+WW3P63OcN17PUFFYfF3aGiSoKjRKxB/dsd3EbA/R/R
         S79tOjnt1OqI0pDzGl7gxwZV89TYHteNI5YLjpqtHl2y3hSfnWqQwgyZBgC4LXl5tslP
         p0pqv9VTSJybYL6Grn9c55SJWRsK6ePiKOiCUdTCQddbKtdtpyQhmf0+2+EMDckNAeVM
         ekrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779601; x=1742384401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UBmSxv1OwD+ioMgQknmsTs5rUzvzJDaMUiBaEWBDEc=;
        b=pdGGOz1ZIEe2a2ArKFvIEmEXZBv1Abghnofij3F3qzzE0XlesPlHkDz5uLMaLjHju0
         aEzKuP7JGlUKZKymcKeOdHfy4CQ0mgYCo5IO0lWDCWwe05zgMoKtX7GVEBTSUFsoCc5F
         qN67T5DWzQwyitALqDM0Z+XfiWyblKKFG3oUxfWGZ8PxpVqamHy72huwzCNt4kGVxP/U
         58WIHZ+QTYMSg0W+XnhRWVw6TAPzDdw6K3ib3EtQZsfNYHxEsZjMN/ujdoZah9o+Czeg
         dddoOqz/KGSkjGVwUS7LS9eOHHEFQBpW1M2xjkLUJ11CieCQ0ynS9EC48/n6tMMAcgC/
         RZtw==
X-Forwarded-Encrypted: i=1; AJvYcCXdf6KtstTlT8VRg1A/n6fvkCIajfhZsSW1IIRZbRSOHzl5hobd3Xtj3bFdYvesH8fBMgzEAZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo31I0lb6qzIVOqwwahlAyvjdPq94LDaC8FbDTiEcO1jlr0NVW
	RWoT3Go9bBcZLX7LJmkx5SoVV7YTnjInt8R5Iupo7eVhoQpfUNTFUleu9v/ZZxfgGzySoTufM8d
	GgnpCja9CWBHyoqPnrB84ZTiaEMaI8BlZHMa2XQ==
X-Gm-Gg: ASbGncvLZ3/rMURJz0uR7lhW08Rj97jdFJpa87Uo8azN4QesbyMHwDKtlLGLsS87ZQL
	MSMA5JRodjGAU5uURTkfL9Ul0kF9SzLnGPPO8OdC0FAyRT42zwpec1F9L3brVgFvivlHLq6c2Hx
	iQhUXYjnd57TS61WkRvaGY6dTyAJpC
X-Google-Smtp-Source: AGHT+IEOKr0G9dvkjWIRUB6KSVHU6mQO45AWdp58WuGfhWD50M7ulSEgn1psTWYM0zeljiehFpwBV8RLclSGmbEE8iM=
X-Received: by 2002:a05:6870:6f0e:b0:29e:4578:5f74 with SMTP id
 586e51a60fabf-2c260fd90dfmr11572872fac.4.1741779600961; Wed, 12 Mar 2025
 04:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
 <20250307-pinctrl-fltcon-suspend-v4-3-2d775e486036@linaro.org>
 <59a1a6eb-d719-49bd-a4b5-bfb9c2817f08@kernel.org> <CADrjBPqYoHckqr43y1z8UtthZ9DOG15TJWSv_707Jbyf1yforw@mail.gmail.com>
In-Reply-To: <CADrjBPqYoHckqr43y1z8UtthZ9DOG15TJWSv_707Jbyf1yforw@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Mar 2025 11:39:50 +0000
X-Gm-Features: AQ5f1JormaFnXJuP6e1NiOQZPsn_AaUXUkojjSZ_JcJhsq5FNURWiGRoLSlUVIY
Message-ID: <CADrjBPqSSbt=xM7u12BU2nsF2xvyXe_+bLSCxCPBTfCc07VpuQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, jaewon02.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 12 Mar 2025 at 11:31, Peter Griffin <peter.griffin@linaro.org> wrote:
>
> Hi Krzysztof,
>
> Thanks for the review feedback.
>
> On Tue, 11 Mar 2025 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 07/03/2025 11:29, Peter Griffin wrote:
> > > gs101 differs to other SoCs in that fltcon1 register doesn't
> > > always exist. Additionally the offset of fltcon0 is not fixed
> > > and needs to use the newly added eint_fltcon_offset variable.
> > >
> > > Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configuration")
> > > Cc: stable@vger.kernel.org
> >
> > It looks this depends on previous commit, right?
>
> Yes that's right, it depends on the refactoring in the previous patch.
> To fix the bug (which is an Serror on suspend for gs101), we need the
> dedicated gs101 callback so it can have the knowledge that fltcon1
> doesn't always exist and it's varying offset.

and also dependent on the first patch that adds the eint_fltcon_offset :)

Peter

