Return-Path: <stable+bounces-211876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFVaNxHyeGmGuAEAu9opvQ
	(envelope-from <stable+bounces-211876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:12:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF8984A6
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4A6F3003D29
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F963624CE;
	Tue, 27 Jan 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVNTsa+j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC403361DB2
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533923; cv=pass; b=VU2Syzja7OKtXOgfpvUNlGlVyh8rHpbAEFvSMneuROIYRou9ND5TbUCraDjQbtYUyGeEH3MQ0Nqp+D7NDao4zBSw/ZS02Cijui9JXNgvKqekLocHYQ+Dv7J3t6GiVOKT4JRk4uwgOtP3OPLhHteEriFWLBsp7clqKeuFrEil1kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533923; c=relaxed/simple;
	bh=E0/EY/wCsfRofMkmZb5IBr5r7f6H2H99eEShTlICQoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6Esx07EePTf48e83m7UqqxosMiG267YaQpdBRX434xGm9Lsls5IcOic4icNR+iyagzST+oTP/cLtyPN//D/LyxlWC26eHoHYPA0+44lyOclOk6tkstcXrv+nANPKAgH1jVsl4EGp/oH31hDO5CgXWJLkv+rKRtnMVJqN6u7OZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVNTsa+j; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f39438187so3133500b3a.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 09:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769533922; cv=none;
        d=google.com; s=arc-20240605;
        b=IG0cEFyTUfw4u3ADjr/MdfachKERSOi++UBe7Dr95eBKRmmRsEWwXBBZffGqYy6J1O
         wrt0zZi3xtPiZBQJctdIweWgRx5a/3TSbGB0EYgk2rc/qaypV4jRIOSxO1zY0xr79ws2
         BbNIE+NZgqHDGmDA81jswRyXnmyHxQBNzWHYAzItjVkGsC6O6MPcZtRTo9YlUDvuqIgi
         tISUynt9FxvrY6V1/FOuA4OdKTOh6Qy4nH3SSNR32a6h9Z7qw/pNy1qfkNl5xyhE31Pi
         5yBCZAyh08REvXRLQbFGYP6E4gZO3y1xnM2mxbBNtXtU8tjArffACWAonbn7NSt3qBFu
         7Fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWDzP4mkLQ1ulBPy51W87C755ddqOQIkzh/iDHK6onA=;
        fh=5QPU8ecmn8PrMRqEGAkUQn5pt/v5ZqsoD9dN3c6CMrU=;
        b=ONROIyF8bkInEw5H8OSdwhAneh1Hb2T5f6HFi8afjznvIsdtZpCMUEs6BYfdehir9K
         8SkYL/lBieVh8Iw6/9tOtoKYya2JqKKEnribEFWwrbOOS9MTJfzQFZu54B+gFA1m/sxI
         HdCzELBgQqdNws3VC+QoodMgEx6bda9OJeYBCBladxlQowAVWuZeKAxuYG5kGp5ddkqD
         nNo1MuFbvV5jQNbOx5iQy3B8hFYeLdu2ddssI78wqIf/LaDbtfyylVbcW1oqGCfSxtxx
         +/WjkEDyM8acMp0GO48TWpkvgM7Yn1OHGv7JINyFlaRrpoTzXSXmNa/U4VE9R8yupXLC
         FAwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769533922; x=1770138722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWDzP4mkLQ1ulBPy51W87C755ddqOQIkzh/iDHK6onA=;
        b=mVNTsa+j5H7Qo//3PdaVNe6snufo4yFIBfwj2vZ80Zo7BJ3n6KpINvLlUSTviEf35m
         2SKVBbPBhqbkUJ5Be52xHH9Zf/O4xvL7N0BdzosxEb74SA6RU96+V2C6H5ImEaW0Q1QG
         CvDtXTkQP6ktSZTWDWfrGVn78owx1FTibyouSCv9sm2cc855x5897k8IAg9yPNBBGX01
         bStJhC9b7ZMta/IS17qckITW+aNNGplZwEJC87HLSL1UQ+QLilZCNEEmBr3tYxDInvyq
         vpIi/D2YvWJy6B4U7oVjqZ7AlboLMNQ/guegUKbaeBDUWA7bwK3VbDOTCgSabtc4aZfp
         NTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769533922; x=1770138722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWDzP4mkLQ1ulBPy51W87C755ddqOQIkzh/iDHK6onA=;
        b=FazNqrRFPzoW2QaBI+qtTdfjFyAeD9f6M2eBC49Lx7dUxW7JY5arRgXcYoQcevcYFJ
         MPICR8yorikfAiWJwZxnYyY2iUTIlPwmF4Gf3b8Ss4au+PNqUqs8PavRLI931a6OQDFY
         nI08UPiYaOKaMHQF3oOtAxm5WATzlBouX6UhNS/uyAxhhBmxpqy4eLiSWgPUClgPS1ld
         orCy9KTgXIhGFgHKQkBHB/Jq+qZH4uKyE9FnHLMvXW/NUdMa3TVykrCltQ1UnhzozYdR
         kaldlc79Ma4JtDl+oBqLTcuCjanYLDaiHUJW7CJURHlFVHflsu4qwOd/P3bDbHwmh9vr
         L0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaZtgP/7prpC5RPtxPClQaEaq4ZaqPbfI+ib2DGEDmYVJ4SMWN3BofEiq2T7ekA4TnStftYLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqTA7gP92wu62+AwGckiSEPfJ8t9rDwOaQbGocfVD/0ECrQJH
	dNlA56oiCiW11XrFIahTjS49kjY3F0Juv1tPUgEt4V3iQbX+MY7f/4UOQ1kpuobskAqvevUbIQW
	FBNfoeWQCRO5J0phUhvav2ULzSarzgig=
X-Gm-Gg: AZuq6aKkxjtbW8/Xscq9eXlbNlgpd4b56Ue+60dWc00xCUUZ8M/3WmIw3RZBHBCdWpQ
	Qvx8dNEUgKWQv0+qaChPqHpW1DJpBSvjj4g1txLDT5POUnxup9IOPs9SetjuG8474VCTYojHVCt
	IxYlWEGJd4gegsVlw6gLKJ+VVpKnoSjac23xR6tS3UwZsUTSyXLDOvtN7F+aD9h1tqJ9M4voAiQ
	Hky1vOeuz1YoaRYX8WBdFgNIlmn3I/qbv4iKmo31yKSukMC0LOwE4fVqCO1sz8MTD6oiYP8z7hg
	zFHYX1EcKrAvtm0BwTzqM9runlc=
X-Received: by 2002:a17:90a:dfc4:b0:349:19a8:e00e with SMTP id
 98e67ed59e1d1-353fed87ceemr1905930a91.31.1769533921681; Tue, 27 Jan 2026
 09:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127165024.46156-1-bjsaikiran@gmail.com> <20260127165024.46156-3-bjsaikiran@gmail.com>
 <aXjwtBey0MRP0c7f@kekkonen.localdomain>
In-Reply-To: <aXjwtBey0MRP0c7f@kekkonen.localdomain>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Tue, 27 Jan 2026 22:41:50 +0530
X-Gm-Features: AZwV_QhXHv0HRAZ8fc4I6TjcuswHud0C8BIlldD1DM83yGQfaZABLWpvFBgKEZ4
Message-ID: <CAAFDt1vJtJc+C_J9Gv3SYjs_2zWFXsWqwq29=ig1o2_kSkjwLg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: ov02c10: Correct power-on sequence and timing
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org, 
	bod@kernel.org, vladimir.zapolskiy@linaro.org, hansg@kernel.org, 
	mchehab@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211876-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 88FF8984A6
X-Rspamd-Action: no action

Hi Sakari,

Thanks for the review.

On Tue, 27 Jan 2026 at 19:07, Sakari Ailus <sakari.ailus@linux.intel.com> w=
rote:
> > +     /* Assert reset for 5ms to ensure sensor is in reset state */
> > +     if (ov02c10->reset) {
> > +             gpiod_set_value_cansleep(ov02c10->reset, 1);
> Is this needed? Isn't XSHUTDOWN already asserted here?

You are correct that "power_off()" asserts the reset line. However,
Hans de Goede (Cc'd) suggested explicitly asserting it here to strictly
enforce the datasheet's T1 timing requirement (Reset low > 5ms) during
the power-on sequence. This ensures the sensor is in a known clean state
before power rails are enabled, even if the prior state was inconsistent.

> > +             usleep_range(5000, 6000);
> > +     }

> > -             usleep_range(5000, 5100);
> > +             usleep_range(5000, 5500);
> According to the datasheet you seem to need 8192 XVCLK cycles after
> deasserting XSHUTDOWN before proceeding with I2C access.

The 5ms delay covers this requirement with a safe margin.
With a standard XVCLK of 19.2 MHz (or even 9.6 MHz), 8192 cycles
takes approximately 0.4ms to 0.8ms.

The 5ms delay (usleep_range 5000-5500) ensures we are well beyond the
8192 cycle requirement for any supported clock frequency.

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 10:37=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> HI Saikiran,
>
> On Tue, Jan 27, 2026 at 10:20:24PM +0530, Saikiran wrote:
> > The previous power-on sequence did not strictly follow the hardware tim=
ing
> > requirements (T1), potentially leading to initialization failures on so=
me
> > platforms.
> >
> > Update the sequence to match the datasheet and maintainer recommendatio=
ns:
> > 1. Assert XSHUTDOWN (reset) for 5ms (T1 >=3D 5ms) before enabling power
> >    resources.
> > 2. Enable clock and regulators in the standard order.
> > 3. De-assert XSHUTDOWN.
> > 4. Wait 5ms (T2 >=3D 5ms) for sensor boot before I2C access (using a wi=
der
> >    range for timer coalescing).
> >
> > This ensures the sensor enters a clean state during cold boot.
> >
> > Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
> > Fixes: 44f8901 ("media: i2c: add OmniVision OV02C10 sensor driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> > ---
> >  drivers/media/i2c/ov02c10.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> > index fa7cc48b769a..3bfbd0deb126 100644
> > --- a/drivers/media/i2c/ov02c10.c
> > +++ b/drivers/media/i2c/ov02c10.c
> > @@ -676,6 +676,12 @@ static int ov02c10_power_on(struct device *dev)
> >       struct ov02c10 *ov02c10 =3D to_ov02c10(sd);
> >       int ret;
> >
> > +     /* Assert reset for 5ms to ensure sensor is in reset state */
> > +     if (ov02c10->reset) {
> > +             gpiod_set_value_cansleep(ov02c10->reset, 1);
>
> Is this needed? Isn't XSHUTDOWN already asserted here?
>
> > +             usleep_range(5000, 6000);
> > +     }
> > +
> >       ret =3D clk_prepare_enable(ov02c10->img_clk);
> >       if (ret < 0) {
> >               dev_err(dev, "failed to enable imaging clock: %d", ret);
> > @@ -691,10 +697,8 @@ static int ov02c10_power_on(struct device *dev)
> >       }
> >
> >       if (ov02c10->reset) {
> > -             /* Assert reset for at least 2ms on back to back off-on *=
/
> > -             usleep_range(2000, 2200);
> >               gpiod_set_value_cansleep(ov02c10->reset, 0);
> > -             usleep_range(5000, 5100);
> > +             usleep_range(5000, 5500);
>
> According to the datasheet you seem to need 8192 XVCLK cycles after
> deasserting XSHUTDOWN before proceeding with I=E6=B6=8E access.
>
> >       }
> >
> >       return 0;
>
> --
> Regards,
>
> Sakari Ailus

