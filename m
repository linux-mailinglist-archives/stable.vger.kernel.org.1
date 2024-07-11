Return-Path: <stable+bounces-59135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371ED92EB9F
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB581C22B86
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FCB16C687;
	Thu, 11 Jul 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm8Srm4/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545616B74B
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711596; cv=none; b=hCTUXKKrtsKmpnIoD/DhMMBuXATWJCmNzPPQXxvYgQlMTKUOwlvlujbElxhbdTWcG85/vhNY/5BNLn9OEajXPejMmY6mQogk7WOAZBJAtBNltfK4BObZLsIQr3iuAXnj2YmEqYsfkK7xCHdgWc5CSOfcQyMSADtdCaIbHfjCPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711596; c=relaxed/simple;
	bh=Z2UifNQfHSWQactTbUxwngct7Jif7447IF3QEfZiqWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoqvDrBe2CdfBJBm6v9PXAZe5vPNjivfBe4oXlkiG3gMj1rPSK5z0tnK1vIB/JGWLDrjQocheEooCYlMyNdPeySc8EAZdiDA+qYVieo+gQkWTelD0l6jrTJWwzNgQDZz3qMcRnBemyUDRRIUPhenQlZlTUQd1CmQNWic0hL4eVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dm8Srm4/; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e057c25dd34so915015276.2
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720711594; x=1721316394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2UifNQfHSWQactTbUxwngct7Jif7447IF3QEfZiqWY=;
        b=Dm8Srm4/3k2UEj5Pe02DINegUCr/eEMDoyOSMG572SioW6VYEAA61+e4tg7qSzJ8T9
         3WosFTFlDbR7kcJpU9fWeQkF1fp0ZLmES/wvMHwlJ/1qMvcD9Rj9kl5/AvLCRr4HGrRG
         PKAH9K+Gl0eOJRtCu5LqaBUDhTZQrE1JvU0CwV5gR9igIt4+PHxXjRhHH2SGYHmeXC/z
         7ZlXe6ryKVE7KMWV8BjpOg7EdvyGFVIRl7L45yFW1in2aTvJYDmcpQr8Bxpf1pUUOGgj
         yRvBruI118fAdQXPMKcmpJD657fFU66S30CGsHjHZrY/LOIDLoKP2tsLK4P5IRgUyMyV
         1Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720711594; x=1721316394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2UifNQfHSWQactTbUxwngct7Jif7447IF3QEfZiqWY=;
        b=Vlp86QimkWlKZvShK88glqYNWMuKwTd7k5SbKqubVcNZ6UD9qTAOFw6MLw1DW8PCko
         zOPCZ6lw9+NU9ls59ojCr4mVDQJPrvF3GNN7x2RXgGr1GS96rDUp3NZFjcBd1yfqZXyD
         VNQelEj54LEvQAtRerj7OOHR7w7L18PI+NfW+qUG2JgVeSxtywGhz9G+pvXMNLz4oygr
         J+sInj/oq3glz6hUUYkYQHmJ2c/rspgGP+zfk6GR/SjhTiPzEzV32h0AEeaqvvFOcEjj
         wVYqELR2FsjFnwyNq1mbzGHsMYIkXtQXPYAWvEfdEmaBljjvPn8MuBlA1EwQNvxa43RG
         3hxg==
X-Forwarded-Encrypted: i=1; AJvYcCVfk20pnOOOyeUM68Zk1nDSs1jkv91sQhYi496Awpd2fjO+hAOSpkwoeTey/mVQhrbS0abu/BBmidzLk3n+k7x28vFyPK6l
X-Gm-Message-State: AOJu0YymjLq1RBYEvgGRl+Jz403THNy0UhGmrSUTUvT42p80Lx+BsfDB
	VkoTxW/MV9dS+zq1rwHjKkww1qXmL/6fVnwo7ou34YYG7lBYQ3HOt8VpCEXThRTO27d8lE6rEO5
	U7SSSX2wfUVapH/MLN2QNZzvMSY/bQa01gU6WpA==
X-Google-Smtp-Source: AGHT+IHRSvRxtciU4D9HXYrANT6oCsSmGR5hfnzw9CYJVDrCkRv/UkJgcHyyeRSNtmZhuOvpcZVYT0H141BgwBp64+o=
X-Received: by 2002:a25:d852:0:b0:dfb:61e:3ee0 with SMTP id
 3f1490d57ef6-e041b034870mr9885394276.10.1720711593970; Thu, 11 Jul 2024
 08:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7> <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com> <20240711131637.opzrayksfadimgq4@vireshk-i7>
In-Reply-To: <20240711131637.opzrayksfadimgq4@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 17:25:57 +0200
Message-ID: <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 15:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-07-24, 13:05, Ulf Hansson wrote:
> > On Thu, 11 Jul 2024 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 11 Jul 2024 at 05:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 10-07-24, 15:51, Ulf Hansson wrote:
> > > > > I think this should work, but in this case we seem to need a similar
> > > > > thing for dev_pm_opp_set_rate().
> > > >
> > > > We don't go to that path for genpd's I recall. Do we ? For genpd's,
> > > > since there is no freq, we always call _set_opp().
> > >
> > > You are right! Although, maybe it's still preferred to do it in
> > > _set_opp() as it looks like the code would be more consistent? No?
>
> Since the function already accepted a flag, it was very easier to just reuse it
> without.
>
> > No matter how we do this, we end up enforcing OPPs for genpds.
> >
> > It means that we may be requesting the same performance-level that we
> > have already requested for the device. Of course genpd manages this,
> > but it just seems a bit in-efficient to mee. Or maybe this isn't a big
> > deal as consumer drivers should end up doing this anyway?
>
> Normally I won't expect a consumer driver to do this check and so was the
> opp core handling that. But for genpd's we need to make this inefficient to not
> miss a vote.
>
> The problem is at another level though. Normally for any other device, like CPU,
> there is one vote for the entire range of devices supported by the OPP table.
> For example all CPUs of a cluster will share an OPP table (and they do dvfs
> together), and you call set_opp() for any of the CPU, we will go and change the
> OPP. There is no per-device vote.
>
> This whole design is broken in case of genpd, since you are expecting a separate
> vote per device. Ideally, each device should have had its own copy of the OPP
> table, but it is messy in case of genpd and to make it all work nicely, we may
> have to choose this inefficient way of doing it :(

Right, I get your point.

Although, it seems to me that just limiting required-opps to
performance-levels, could avoid us from having to enforce the OPPs for
genpd. In other words, doing something along the lines of $subject
patch should work fine.

In fact, it looks to me that the required-opps handling for the
*single* PM domain case, is already limited to solely
performance-levels (opp-level), as there are no required_devs being
assigned for it. Or did I get that wrong?

Kind regards
Uffe

