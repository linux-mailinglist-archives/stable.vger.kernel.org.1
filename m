Return-Path: <stable+bounces-62614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2893FF8D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428621C22441
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17818C358;
	Mon, 29 Jul 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQngmwtR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E951891AA
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285072; cv=none; b=JHtGxdAXT6+9jWpuR6aKb2+TLaORogNfYT1GtfafhwSb24UPkVwGXKON0k5X/7Wl8+SUdGESTVWeJtYmDnK+k2N/6IkB1V3bHzS1rCUj95IOxGwwpsA1Sqoy1aTdgqgGm4RORbCa08T4qLxIcLOksKdUAxxHcUosXrPit3kseRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285072; c=relaxed/simple;
	bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpsbnBjUoalWRAfwA0OOfBPUX5r5YEgrXMr6uBUzATZIYaD83LDEX0ZcXzFRlrdI/flVWkpLlTUT343DntGdbUDxg1l4gvE5oCGSmwpfkb0lVCtMNgFfrDkao90BNZTgDGPdmZ9rjnFI67bM2snv8CrfMCsyaanMaScbs7NNkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQngmwtR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-664ccd158b0so24531097b3.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722285068; x=1722889868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
        b=KQngmwtRP5cPVG0MyedAHOP6kErCF9qnqQXLqr0rhQR4m72Sc4+f3Fa0g/AzKqqqFN
         5wlO2pgjZjFdrEUTls+fT8doj63YCLamJPcVK3t5IIhdSlYP4zgBilApoCj3eAuxdYwh
         hykS4C/9NCIRFmTg8hXUvM0LvYECA3k5rAkDBRZe+4hhslzNyY+u+xGagzbrcCxNIxmu
         Npmw0WmgIa/yBuzm87mpqvULt4Gje1ZuqkW1zqvnWVT9hc4yVt8jr/4DTZh+oTAf0PPN
         UMJFUkhza3ntX3rgNGu8BdKa3JgkazK+gThFhVOQoMJgra4FuA0lD8oOOqtsZtisX6oT
         1NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285068; x=1722889868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
        b=DUDnNBSEfUzHsswI7P+VHmngu7sGCPZqcyf1rXcVzy4By1E76QPPZvXX1x4WBBjAdi
         0E5H/ovYeRUn1pWb9AmPXIYfPxGB8drm4pP+RbnmnjI4Znp2vUeb8ctUshqccVF0apEN
         LE8ch5Iy2m1rRZQN7NVPc4pqJBU0bRwUF1IDOTfw1d72RdCS74ctfgnuv+tz9jOe8qdQ
         f3PSa1sgeiHJ98cldsqnVMJbqv41s5R4XggE7SInWfpyQSYchlYbsnfNXnDxynGIuDTS
         8VaO6yx0jhYa89c9sKuq+e+fXttnhkn9izK5YyKKgbkzi+KwCyvCIJX5q0sUNo0C/aP7
         E5JA==
X-Forwarded-Encrypted: i=1; AJvYcCXdJWRDxrEPpF3pOmETPupZYc7IIbtZ77sz9MNQ6WEwK4lCdJpVD1iDJyLYDfKtyUHLXvrRQtHnN0bmyhvI8S0t/Zob4W2Z
X-Gm-Message-State: AOJu0YxCMRSVoyatTqS3tFDPr4LYGX/sIDLPNfY/dJLDugto9XZZnl7/
	KEeI6kY7K7lYWdBb2u5FoUGWy0QOkFOw62UpaZh2HRyjI6Q8GgHhjVfvMmCYUdvpnQr3rotbH39
	6z1p1lCaVHwjHN04XishFm430cL2Nm9vqZqfTng==
X-Google-Smtp-Source: AGHT+IE6PA+41Auz36YFIeCSe3gwULhATNq0ZrmnNpIMKRjzsevvjklMTd8qJRePRRiUM6vSVA+XVdVmqlOtJX4UP9w=
X-Received: by 2002:a05:6902:c09:b0:e0b:3c55:747d with SMTP id
 3f1490d57ef6-e0b545af5f2mr9330015276.37.1722285068532; Mon, 29 Jul 2024
 13:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7> <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7> <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
 <20240725112519.d6ec7obtclsf3ace@vireshk-i7> <CAPDyKFqTtqYEFfaHq-jbxnp5gD7qm9TbLrah=k=VD2TRArvU8A@mail.gmail.com>
 <20240729060550.crgrmbnlv66645w2@vireshk-i7>
In-Reply-To: <20240729060550.crgrmbnlv66645w2@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Jul 2024 22:30:31 +0200
Message-ID: <CAPDyKFosi4dhf36iNaNgGN6RHLDunL1nEwD+A_aW2khxER59nQ@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 08:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-07-24, 22:05, Ulf Hansson wrote:
> > > > > I think that design is rather correct, just like other frameworks. Just that we
> > > > > need to do only set-level for genpds and nothing else. That will have exactly
> > > > > the same behavior that you want.
> > > >
> > > > I don't quite understand what you are proposing. Do you want to add a
> > > > separate path for opp-levels?
> > >
> > > Not separate paths, but ignore clk/regulator changes if the table belongs to a
> > > genpd.
> > >
> > > > The problem with that would be that platforms (Tegra at least) are
> > > > already using a combination of opp-level and clocks.
> > >
> > > If they are using both for a genpd's OPP table (and changes are made for both
> > > opp-level and clock by the OPP core), then it should already be wrong, isn't it?
> >
> > They are changing the clock through the device's OPP table and the
> > level (performance-state) via genpd's table (using required OPPs).
> > This works fine as of today.
>
> There is a problem here I guess then. Lets say there are two devices A and B,
> that depend on a genpd.
>
> A requests required OPP 5 (level 5, clk 1.4 GHz), followed by
> B requests required OPP 3 (level 3, clk 1 GHz).
>
> After this level will be configured to 5 and clk to 1 GHz I think.

The level would be 5, as the aggregated votes in genpd would be
correct in this case.

In regards to the clocks, I assume this is handled correctly too, as
the clocks are per device clocks that don't belong to the genpd.

>
> > It's working today for *opp-level* only, because of the commit above.
> > That's correct.
>
> Good.
>
> > My point is that calling dev_pm_opp_set_opp() recursively from
> > _set_required_opps() doesn't make sense for the single PM domain case,
> > as we can't assign a required-dev for it. This leads to an
> > inconsistent behaviour when managing the required-OPPs.
>
> We won't be calling that because of the above patch. In case of a single dev,
> the required device isn't set and so we will never end up calling
> dev_pm_opp_set_opp() for a single genpd case.

That's right, but why do we want to call dev_pm_opp_set_opp() for the
multiple PM domain case then? It makes the behaviour inconsistent.

Kind regards
Uffe

