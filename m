Return-Path: <stable+bounces-56113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15991CB71
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 08:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1172834D4
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591129422;
	Sat, 29 Jun 2024 06:40:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469171FC4;
	Sat, 29 Jun 2024 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719643232; cv=none; b=TaqK50mNFg90w1R6fe0/MjchnG8LDQHJ5TKYgSE45OWe+an55lRUq5evTChPBi2LIJN/mGWjs4zsl7D5t6H2cFJ7DTvTGYpoXdH7c8Hok4ljpuckCDbaGaYmJzk9shsALDxN4HIsNpkXRauau0+n1Pi2zgh6yYMCmForLfnpG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719643232; c=relaxed/simple;
	bh=Cn09Ef8gCqLXly+Rs3FB1Boi9qEevm3VkSEoUZ3h5tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUAZs55Q+p9sOwRjhFsCm5S6Efm9UdN+mKvtk7ikdcDzSFjIGozJp/0C6O55E9BZfH1NP1quHrc68jrCMWYxhFQRCTkOjswa5gySiug5bqFCQr2JpcsIGbsE9dYhYcvIjgw6hC5oqVk4XWjromXUQl74Hm+5gVQgzPWVYrsLcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso1317439e87.1;
        Fri, 28 Jun 2024 23:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719643226; x=1720248026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VvrX6QrJoZbVIAjkNDDZQYHf2ppstlZCyPEGAhFB7E=;
        b=X67D/5/1n5jmf0dQKWFSIvtmw3nppCtZlaBY2vgNoK3xDvsRCBbIauwQN7KPRta5u5
         jW3N34KjqQ+F0AQpPs+aNnd9GTsMfxznVijpAkid1FBKleldOG98kidKCJJ4C+KHKUrr
         ab7b89K7IhQy8hHF9YPnEu5bM1NRCQOkgJI29FSRtxOBPLYm4CwV2iISYiUHuX/S0lHv
         fg5xtKBxQi79tQ71sbAHsgR+LfnOrlXp8K+hIhWTQO/wwi5EDKnMDkyH3NkTRIOAj+qV
         ZRYIUt9tSoc5yQtu+xtSXQXr3MwlbIxbCTuVnb5omoH0W4EJwGDztbmedCEUmfU9H8h+
         wVWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1rvHFvbCZCaSrUVuTiFMfM36PqbHB00LzGpSNaln985WgiSZDEALegE8C4t83kD9t32bOvcnqLDTCkmLDfgSQCSHHR19s/9dJa8Y39jp8sQv7gOu9gZNPOb5yCLnPazj/dVp63ogPRTs36K5VDWISmKcDFGbUxqvnyMPz1osF
X-Gm-Message-State: AOJu0YwagGx5+GbcKgv0SP9pVb7kvVYjs5g1pTlTTc5X9w5c85QDrhN/
	qVulOIdofeeKca+h9MO4+zqfrEVcijTJCbYMN9KncH+KAaoI2RCKPkkPB5wR
X-Google-Smtp-Source: AGHT+IFA7ugnhEf1xJP1uidTDJA7jOk1oGHqKAQ620msPV8LOpgs9etJjcusPNCUBD2oPeIAQBJltg==
X-Received: by 2002:a05:6512:33d2:b0:52c:d5a8:496 with SMTP id 2adb3069b0e04-52e825cb663mr127761e87.22.1719643225834;
        Fri, 28 Jun 2024 23:40:25 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2780asm505088e87.178.2024.06.28.23.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 23:40:25 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso21076501fa.1;
        Fri, 28 Jun 2024 23:40:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCw4DN2qw3Eg08nIlIMw6YRheG4FNQu0Lzl3fMtGthCjfHHpft6K67r7dUeS8n+v3f5RruMRPPtgzwdNi4Rkf1CTdcl9PvRCiSewN0bSr81gC4qq8dE5YGgnTzE4N9pF3/0blChg6+a9t/LRXdiD3PKYSlvJ+zk/nBHrE+EE2d
X-Received: by 2002:a05:651c:21a:b0:2ec:4e05:8d99 with SMTP id
 38308e7fff4ca-2ee5e6c5e60mr958211fa.20.1719643225204; Fri, 28 Jun 2024
 23:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
 <yw1x4j9e62dt.fsf@mansr.com>
In-Reply-To: <yw1x4j9e62dt.fsf@mansr.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 29 Jun 2024 14:40:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67GbUF7S9hKdNb=az0ZsoEU=fXjKzyQvEd+tSHrWf4eCg@mail.gmail.com>
Message-ID: <CAGb2v67GbUF7S9hKdNb=az0ZsoEU=fXjKzyQvEd+tSHrWf4eCg@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw
 without common
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Frank Oltmanns <frank@oltmanns.dev>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"Robert J. Pafford" <pafford.9@buckeyemail.osu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:39=E2=80=AFPM M=C3=A5ns Rullg=C3=A5rd <mans@mansr=
.com> wrote:
>
> Frank Oltmanns <frank@oltmanns.dev> writes:
>
> > In order to set the rate range of a hw sunxi_ccu_probe calls
> > hw_to_ccu_common() assuming all entries in desc->ccu_clks are contained
> > in a ccu_common struct. This assumption is incorrect and, in
> > consequence, causes invalid pointer de-references.
> >
> > Remove the faulty call. Instead, add one more loop that iterates over
> > the ccu_clks and sets the rate range, if required.
> >
> > Fixes: b914ec33b391 ("clk: sunxi-ng: common: Support minimum and maximu=
m rate")
> > Reported-by: Robert J. Pafford <pafford.9@buckeyemail.osu.edu>
> > Closes: https://lore.kernel.org/lkml/DM6PR01MB58047C810DDD5D0AE397CADFF=
7C22@DM6PR01MB5804.prod.exchangelabs.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> > ---
> > Robert, could you please test if this fixes the issue you reported.
> >
> > I'm CC'ing M=C3=A5ns here, because he observed some strange behavior [1=
] with
> > the original patch. Is it possible for you to look into if this patch
> > fixes your issue without the need for the following (seemingly
> > unrelated) patches:
> >       cedb7dd193f6 "drm/sun4i: hdmi: Convert encoder to atomic"
> >       9ca6bc246035 "drm/sun4i: hdmi: Move mode_set into enable"
>
> This does indeed fix it.  6.9 is still broken, though, but that's
> probably for other reasons.

Can I take that as a Tested-by?

> > Thanks,
> >   Frank
> >
> > [1]: https://lore.kernel.org/lkml/yw1xo78z8ez0.fsf@mansr.com/
> > ---
> >  drivers/clk/sunxi-ng/ccu_common.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/c=
cu_common.c
> > index ac0091b4ce24..be375ce0149c 100644
> > --- a/drivers/clk/sunxi-ng/ccu_common.c
> > +++ b/drivers/clk/sunxi-ng/ccu_common.c
> > @@ -132,7 +132,6 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, s=
truct device *dev,
> >
> >       for (i =3D 0; i < desc->hw_clks->num ; i++) {
> >               struct clk_hw *hw =3D desc->hw_clks->hws[i];
> > -             struct ccu_common *common =3D hw_to_ccu_common(hw);
> >               const char *name;
> >
> >               if (!hw)
> > @@ -147,14 +146,21 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu,=
 struct device *dev,
> >                       pr_err("Couldn't register clock %d - %s\n", i, na=
me);
> >                       goto err_clk_unreg;
> >               }
> > +     }
> > +
> > +     for (i =3D 0; i < desc->num_ccu_clks; i++) {
> > +             struct ccu_common *cclk =3D desc->ccu_clks[i];
> > +
> > +             if (!cclk)
> > +                     continue;
> >
> > -             if (common->max_rate)
> > -                     clk_hw_set_rate_range(hw, common->min_rate,
> > -                                           common->max_rate);
> > +             if (cclk->max_rate)
> > +                     clk_hw_set_rate_range(&cclk->hw, cclk->min_rate,
> > +                                           cclk->max_rate);
> >               else
> > -                     WARN(common->min_rate,
> > +                     WARN(cclk->min_rate,
> >                            "No max_rate, ignoring min_rate of clock %d =
- %s\n",
> > -                          i, name);
> > +                          i, clk_hw_get_name(&cclk->hw));
> >       }
> >
> >       ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
> >
> > ---
> > base-commit: 2607133196c35f31892ee199ce7ffa717bea4ad1
> > change-id: 20240622-sunxi-ng_fix_common_probe-5677c3e487fc
> >
> > Best regards,
> > --
> >
> > Frank Oltmanns <frank@oltmanns.dev>
> >
>
> --
> M=C3=A5ns Rullg=C3=A5rd

