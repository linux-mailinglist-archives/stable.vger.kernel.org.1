Return-Path: <stable+bounces-241650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FnPHAOx8GkfXQEAu9opvQ
	(envelope-from <stable+bounces-241650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:07:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A0F485822
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2368530BCEED
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AF43C067;
	Tue, 28 Apr 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhNYgt0B"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C74402BBE
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380874; cv=pass; b=LrTkcdsyzmozJWonsehW1irq5D0PlUrlHnsyHM6R3zYmcPqWiePbPsV0ZOJzLGPZL7Dp0uxNjifU01KkK/45IBi3WKcAJMqsdh4GVWfDCl6FzYSbKIxdTGv8VNOzYVy0APa5XGTyPXtN+VvL+aS64VbFl7H3yR+hbeZuR4M59WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380874; c=relaxed/simple;
	bh=dN5yRIDHypYcmAgsa0nk3b8/VmYxtGD2QVKCaTBwFOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4z/wH1wD+5FknAU7nQZgvP+emeOL+p0mxiCcPl0gJzPRIbgp2BDMBbHLIJnCPJWAGG89vCvJ+a2RWXHQvkxKefZlFNgWvjf7oMF9TMy1JXZBOXPOKF41+LcA3SofJuD8cePG5CA3qh25SkYPYo00vPQQ6N9D2eax8btoQ5+OcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhNYgt0B; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso1090256166b.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 05:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777380867; cv=none;
        d=google.com; s=arc-20240605;
        b=BYlSLYYHzHab4RDN9VMTFqWkIkdnLc54SEPTH7A+XGfJAD0N60p6HFhZmgn1bw3VvL
         CJn4U4hv0O3oimho6aN97r6e3xtYCBLuAYrgsi0vGygnYrT6gPDtK9fz0HYZ2/8RZbn+
         wdj9vs84TJy7zQxa+X5Jz3oYsRLPMops7ZEWNzKc2uLU+71wkcvrxzAY/BFvy4OnLgg0
         MVfGeSbX7crDTepJOBA4Vcl74ZNJUYKkgtgTDtMKiqiE4oRAfUlNm55hYa8Ff3n9EbLm
         USEToACLtV8SszPrSMfQkhaDO1QPqNYNL+tJapAFX07NTVLi4p8b9/OKKplVNpzaRkHX
         /7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Ob2gAneCOHStuVYkJxgCRh61YpGSxKMP4iu4y7dYyY=;
        fh=dg3BJu/pkRN5LuwV2Pu1DBmFHVtJiox2eZThKiSpAr0=;
        b=Jj2HJoKQO8LjwdrwNk/Bld0Y0+DeLS0U0piecb0hD4a1tn4VVEgPuXflOjgqh8eLXG
         stIPbrn9O3NardX7UDvR2lthAza158cvVB5wUukcMomeDRXs+PNTmGSoL79E+z06r7W6
         X3SYwdHZU54fo2NAZmWioFx3GHZZpZ3qt4m7+tjyp9VQbsDfOL3UUctVUZFH0Y5QHJ8Y
         /fHVK+RCwRP7LNqvEsil5YVZlIb4iXfIQJufC7NP5jfSJqGg595FSY/Ntpjlk9dWLUOK
         JfswW0t2ny/YquW2buh/V0K6NRhs6Nj2b3Jgn4V4IGUJUQKYGhyI9+LqF22951S5dDOe
         6guA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380867; x=1777985667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ob2gAneCOHStuVYkJxgCRh61YpGSxKMP4iu4y7dYyY=;
        b=nhNYgt0B9e/tReLmpUZpwvhvL+UKHO0sJ6RQbd4MVsPPtGdBkaXYQf6GJpTVuHfuFV
         TleZqPeX5teHVGob6Y7AiuystOXkXESRwAhVKG12TneImJ6AH9GJcHXJ3XKiWm37GGf/
         +QCs+d7VOV2psAWkMSb6geSHx7IoiZV1Ywv6ruh1Sk6AV5R4YMexHnU7cPbpvqQPbTy+
         8nP4KHESaa6Hc1/WLLh5xFYtZb/OsvBzUyg0QNZFAYNucul325GeWQWS9qsvlrD4XOxW
         WlI0P+o0Dwzo3vjldknlztRd33iJ8zyQTJ7w4d0GIEVTu9g2uFM/LolAA1GsBn3u5et5
         SH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380867; x=1777985667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Ob2gAneCOHStuVYkJxgCRh61YpGSxKMP4iu4y7dYyY=;
        b=efVbTOh86W5tsf6I6pixGLYzKWt3W1CBvXTITJUYN2F7ehPGfRAjI6k9XkrMqED1A8
         oUcRlc6dMfvwkh62r2irJ9vmnU0Mg7lzZGas+mhY/0U36BPfWm0Nh6sc7CKm73O0iRZJ
         dp0xUY4kx9Y67/boYktqrV7+7plbCg2qzKJoj6KzFWLP2Y5EG1fDVGPltfuN0mVvhqQS
         +t7aF9iwczual6jGfoUBh0HARPANDRTYgNXzPqF2S/DlT10MZrk/qhhsBeFcPiAEdgHn
         1wZ4mRDMWzrcpGZKNCVjtBzqTT0pa9v0uz0riM/cEAl0G5J6RZCMLzv7AN5blNT8Mgj8
         cC0g==
X-Forwarded-Encrypted: i=1; AFNElJ8saQ4FdD+EGMQM60op90Bi8ZtF9B+ywy8dIXEQR7x4fPixm1QXlZ0Qs+HwW8ReZb3OGYNARgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDm0Z7vBY31mLOkgtWAyiwCn2qlRD1RwsktvGum+o7PGCmWx+
	bHxVTLKXcf58eZa1OlbhLogYHaL6dcHLKh140oN0KdppJxZS8owwaXd4PPuYYtYuloI2SumLV7C
	BhbGRvc+aiK3rEAKh/3iYa1NPHaamdlY=
X-Gm-Gg: AeBDiet5saeoDanKIO13vywQfYKVOI2fTv404g4RmnyPnEdWNAydCz5RrDgxGpWr+ba
	zz7L6oFspltuS/uNRkq6A0cwWRygABuek3KSUaZs2xp4uhXem4i3IUe6vVG4eYHKXNEalrzj7jG
	Na8exLOI78z0v+z2OCBCzseI2gmfXR1BW21iVJNceRmDPev0lusp0l+ElmdPlP37rPkwOAKR+cF
	E5qExrqTxf2U4xKYWBBzcmGU8Fh1hESVc2mAAtCxCqhbLCyn3eudIu56WEt/HDkRY4Me5uQRAIr
	OJ4Z797dMBxfuMKXI4i9N1VGcV+7TFHpNNtD6KnZSLCVruNt3BPvgp5p2hApQj2yUZ2RA5aAPXa
	PRvxuY2sVKv2ETLM3KA==
X-Received: by 2002:a17:907:d113:b0:bab:30cb:a0fe with SMTP id
 a640c23a62f3a-bb804a2f1aamr176597266b.37.1777380866520; Tue, 28 Apr 2026
 05:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
 <CAHp75VdMEXag0oeRd620YJn5TpgqGy4YProDcR7EZE__cwwC2g@mail.gmail.com>
 <d4d340ad-d181-4892-8f70-9b71f2cbef83@gmail.com> <2cd5d716-1e42-46c7-abbd-8d2022b9fab6@gmail.com>
In-Reply-To: <2cd5d716-1e42-46c7-abbd-8d2022b9fab6@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 Apr 2026 15:53:49 +0300
X-Gm-Features: AVHnY4IqvitqV7WabTwVjpYe5lALZOGeWuap8fS_lfHowA0OqA_gEJ51qyxAs_8
Message-ID: <CAHp75VccmALMWpuvR9SNbHtZNqygFai-qr=XkNy03vud-3Sfug@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
To: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?= <cassiogabrielcontato@gmail.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
	Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hansg@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5A0F485822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241650-lists,stable=lfdr.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 3:13=E2=80=AFPM C=C3=A1ssio Gabriel Monteiro Pires
<cassiogabrielcontato@gmail.com> wrote:
> On 4/28/26 07:28, C=C3=A1ssio Gabriel Monteiro Pires wrote:
> > On 4/28/26 03:55, Andy Shevchenko wrote:
> >>
> >> There are 6 drivers that do the same, why is only this one special?
> >> Have you checked the flow on the error path of the caller of this
> >> `platform_clock_control()`? Maybe there it calls with the opposite
> >> event to shut the clock down?
> >>
> >> TL;DR: If it's a real issue, it has to be fixed for all affected drive=
rs.
> >
> > Yes, I'm going to check the other drivers.
>
> I checked the other platform_clock_control() users under
> sound/soc/intel/boards/.
>
> The same bug pattern exists when the ON path does:
>
>         clk_prepare_enable()
>         <fallible codec PLL/sysclk setup>
>         return error without clk_disable_unprepare()
>
> The affected drivers are bytcr_rt5640, bytcr_rt5651, cht_bsw_rt5672 and
> bytcr_wm5102. The first three were already fixed by a02496a29463,
> b022e5c142ef and dced5a373a96. This patch fixes the remaining one.

Thanks for confirming, I based my previous reply(ies) on v7.0 kernel,
it's good that many of the issues were fixed already.

> The other two MCLK platform_clock_control() users, cht_bsw_rt5645 and
> cht_bsw_max98090_ti, only enable MCLK in the ON path and do not perform a
> later fallible codec-clock setup in that same path, so I do not see the
> same leak there.

> I also checked the DAPM event path; failed widget callbacks are logged,
> but there is no opposite-event rollback guarantee that would balance the
> clock enable from the failed callback.

Thanks, this is useful information!

--=20
With Best Regards,
Andy Shevchenko

