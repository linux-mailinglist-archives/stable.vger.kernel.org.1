Return-Path: <stable+bounces-253718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOCmFekdEGrqTgYAu9opvQ
	(envelope-from <stable+bounces-253718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:12:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE15B0ECC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 355AE301A7D2
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B73BADB7;
	Fri, 22 May 2026 09:11:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5223BE627
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441112; cv=none; b=a9QFaKT2/8OjgX1cRtgchtdMUSXVczIJZQYKPcSRwX8f7vCaPMyziyqztGZaJxTbp2QeEeGiZtM8gMq3FcbEuCx7S5mveJCAtLwqcP8CIToLzbUORMlMBO+eP+wSO8sscHMGEvxbXsZ5MRj25zjXhF4RAwFM0nLiM2ya8NpBvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441112; c=relaxed/simple;
	bh=tAi5UeQ8Wn/ZsGeuB5ybx0KShfl8F3H/Z/vQg1bKe9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL1+AOV0G9IIIVU+p70pVtz8itLTf6Rom9k6mHnef4tf38KswejZWafyBUdfBmSMPur5oiCmYVZeqKZ6H6vM8UXgHdLBzwGDYWNRlNH53owmh+yOLmZxTXx/9ygrEsq06wT0S9HaVuX4FLAgzNXP5z/jITeygcxtRfEc4XUjM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-57747a2bf20so2140889e0c.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441101; x=1780045901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euPMq2UyJF5E3NPJ82QmWExcUbi1ANEh3LXTW7bdXbw=;
        b=dziYJC4kirhMNflXQweilP+wVZ/4FeTeFCp0TRwZ+lFJFTTS+HuSY61r5dEkoNOElF
         rBccQDobj+dD5tSuOvDtJKGqxNtl9jFej2QPqD2YsVqC8Cg/nsO/rGcA0a0sAVgDLVUb
         9hnms3aLzhOjR9PnamDJ/nI19bIPQzRs5AcGejDsKz6pGat3hrzeZ/MaDJQ8LP7gpuzu
         8HAcow945qaYWrcDFhdOLMh293KtzXk8YSowJ8qmOXRAR0j4Hh6QYLC4s+LjGvslD79U
         v5Txy1HjaYw0hChu4mSknj4BSveG+/miGpLgorFT7bm5fFUzvqSopCUR/pM3cMp6VyEF
         GxAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+328oCNMiogYprwKeMrC2lenuXRVzhjB33sxKPSZt7/+fGv6EggEh900Erext1D6getP4ydok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jzPPJpfxP0qP80iGOo1dJD+2YUYcTD20Znk8QmxcgGaWKNpG
	HY68Mu4BqSjvsAwBGZ7q3WbfzrJvxNXPt1EhISOXpQ2MRqSBEFizGn9FFs+OaAJN
X-Gm-Gg: Acq92OFn6Lt9fnpzpr88Iw+Nc+Mt2sUFC295AvNDjVIeSfL3w7iGgshrcja8O1bSHaX
	Snbpmpi7bKRdx6OlsPsCtQZTNvqO9KLq6PqVM0ZampNF4RPwJnlV7UrNd6mNZwoiVlNNNIb60df
	9MNQefs141eCTrlKz1SsBdHbCDGU1G/DKQ5m3s3wJV1zm1OtHnP/EqrAVWS8il7+JjY8yoSc3RI
	+Gx5XkYwqAbIgWHHcN6XIlGJASuESaecV+yWmXKNwARUkaTPm2DtrmCnz9/c1384fLhSjZrLQ7k
	rD29eRDTxot7RCngWy/HXGrYxanKO8BydjY6b7uQIP0798WhcsMszfir+a3XsX3emiBK1KsYIbD
	K/IZNUSRrNeKp6aL7NN/jzEaGP05uP2ObNvpP/9Va8IRRSvEKsx0sL/WgiUV+7EtnCMTwzzcgJ0
	5E3gqtT8qwKPXk/nutsJT0fB8IJrCnTUX3d3K+U6y2t7/ue1j2sych4MSDKh/p
X-Received: by 2002:a05:6122:4d89:b0:572:36f3:e792 with SMTP id 71dfb90a1353d-5866403bae1mr1210501e0c.14.1779441100842;
        Fri, 22 May 2026 02:11:40 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f23eea07sm1438243e0c.4.2026.05.22.02.11.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:11:40 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso2337426241.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ805y2gJWhlQbcuDC/6IJxL+PUCnsoj5wZTtcKLYgNMKaUnp40pF1Ct4CtNXTbz/1S4ZKf8h3c=@vger.kernel.org
X-Received: by 2002:a05:6102:f93:b0:660:e01d:d684 with SMTP id
 ada2fe7eead31-67c7e1209e2mr1145939137.3.1779441100124; Fri, 22 May 2026
 02:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515124008.2947838-1-claudiu.beznea@kernel.org> <20260515124008.2947838-2-claudiu.beznea@kernel.org>
In-Reply-To: <20260515124008.2947838-2-claudiu.beznea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 11:11:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVK7Wu=Lv1Qhu0+CMCQSXv6Lj6BoTdzVoW1K5Z=kgecag@mail.gmail.com>
X-Gm-Features: AVHnY4Iw_vr8Guqtk2YAOmBMghsTC9zOxmpEROEYDnyaYtfvfPRQWvVAvaAm2po
Message-ID: <CAMuHMdVK7Wu=Lv1Qhu0+CMCQSXv6Lj6BoTdzVoW1K5Z=kgecag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: linusw@kernel.org, brgl@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com, 
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253718-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: 16FE15B0ECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,

On Fri, 15 May 2026 at 14:40, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The pinctrl and GPIO core code make exceptions for the -ENOTSUPP error
> code. One such example is gpio_set_config_with_argument_optional(), which
> returns success when gpio_set_config_with_argument() returns -ENOTSUPP, but
> reports failure for all other error codes.
>
> Returning -EOPNOTSUPP from the pinctrl driver on the unsupported pinctrl
> operation may lead to boot failures when pinctrl drivers implements
> struct gpio_chip::set_config, the system uses GPIO hogs, and the
> struct gpio_chip::set_config implementation returns -EOPNOTSUPP for the
> unsupported operations.
>
> Return -ENOTSUPP for the unsupported pinctrl operation.
>
> Fixes: 560c633d378a ("pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks")
> Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v7.2.

I guess drivers/pinctrl/renesas/pinctrl-rzv2m.c needs a similar patch?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

