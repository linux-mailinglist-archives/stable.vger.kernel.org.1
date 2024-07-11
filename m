Return-Path: <stable+bounces-59106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE292E65E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DA4283802
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D315EFA4;
	Thu, 11 Jul 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="B06IgxEG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88D15ECE5
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696656; cv=none; b=nRK9uiPAbWXnCxXI7Kyb2hGiT82vtDSgE+hGK8vxq1W0270JmxSVmvy/+zE1sxATprX3GCndO+d0VVmQJVhcH2HzbQ/l6bd3CfD8SKnLf/rxWTcLtZiUQd3lyIJBjLUpmwHbJyZSNeeOVEDz7N4hg1hllyRmwyYdsv2gt408OzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696656; c=relaxed/simple;
	bh=CzNGwp1PuzFuHmmTM7q0S5AokMPLB2jgiNIv2Uzt3HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOf18mpZQ2k3R1Kxhre9pMALROWH5okBuWkNGWqCWMJJ/fzZAcIiuI8URT0PeTKHVlhYf+OUHE4vM9520270JyrpUJxpgCJ08hLhUCYyeF6LuHfCdb/pt03ZWEwiKqVueXtgOi4W17RTHLIKyehhxzg3KmscAmQ1bn6j0IkpbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=B06IgxEG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03c6892e31so723721276.1
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1720696653; x=1721301453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1zmd0HPKxOmhaqEKIrh/TgnCaQO/FR7LQG086botM4=;
        b=B06IgxEGaHfzi3HlWFlv9g57vXPwu7PO/T2aNMA6cbsepEnZuAfEAIOzvtZnJvdCt/
         XNnGy8s8UuR/yvt7ZoRf6Cw7HTKDyyYysmzv+WV6UPtKq727UcZabgYIuyRYFrOcYWvq
         FuC2L3ix56/snYBeWyC9rdKHmSuoOdn3nXcD64EBeZMB6XgOIv/EgFF68UidINIgmm2r
         YGITLZaxPjW5gfS9vHzMjbhe6oreIktcs28ICrLX4FplgIH15sDOr8smYQ3GJAntB+3S
         ALvzcWBBhiuxQOiQyFsWjiIV3fIZfTMvlO1zcUJTdiPX14Nd8WxoQEK2rhJaUcwTWDnU
         t+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696653; x=1721301453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1zmd0HPKxOmhaqEKIrh/TgnCaQO/FR7LQG086botM4=;
        b=BMKwZJTm8o+/+QaslYB3XJ5rgFU4mStfg+4KJhzkqMPDRkkgEWuWYFO3UcWtrXc5bZ
         mpk4/2bbNrCN/D6wdsklGmV87PvOMlLRAi7RbUGR1YQLX1uLnzeZ9H/12+jljn/UtrV9
         4xggoGZYnmu600iEBGODx/HF7QAGNRmfi8JuKAdT49F5reaQ9LYnJpNpTiR+kQyT0TcD
         gL0t/KeGwYNLoNyGZ1YloTaelUEYlFmLm1IONiqJzZgKv2TB2+zbqUpRLrfGSSFVtPGN
         n6u9fBbYGSiPD8Eg2VsYBKHymSjkDUIQIokVfkRm/8e0/u03Y4f+MbV6tKIruIEdCj2s
         Oj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1LxTS9D/gAQ27bsgMFzzzWj5/qrP+lLi2SgEp6xjJofFzpJful7EkNrqYJEPjgayDI6sNNQY3kI3mNxMKPeb+sWT0qckq
X-Gm-Message-State: AOJu0YwlYyhgqNO82kHMoRwBshT6ft4Cf4PK9J5t6pxNr3qBwnPHG5EJ
	u6vfpyGh2B1Gfd7pz4UV6y+748LbVf9xEP5lH8uhw5JU+FfxBk6cdVKSb5AKPzugMFdek7X0dx0
	Gz/J8W6ChWO44NKxb5DN5ipyS8Zhjig7Ajits+A==
X-Google-Smtp-Source: AGHT+IH3tdn0yvOB8pPf7hxX2Siz8NJrmXulk0bwYCb2Ai6XsU4vhUAuro8LrAJOTY2NKs2RmQhZ9xOGyo3pDA1hfng=
X-Received: by 2002:a25:aa30:0:b0:dc7:497e:cddf with SMTP id
 3f1490d57ef6-e041b07d3d5mr8910061276.33.1720696653579; Thu, 11 Jul 2024
 04:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
 <20240711-linux-next-ov5675-v1-2-69e9b6c62c16@linaro.org> <fcd0db64-6104-47a6-a482-6aa3eec702bc@cherry.de>
In-Reply-To: <fcd0db64-6104-47a6-a482-6aa3eec702bc@cherry.de>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 11 Jul 2024 12:17:16 +0100
Message-ID: <CAPY8ntAgjnA2NFRG_qaDnHvzWVX_VJ8ONCVvuJhPQgvSxwD0Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: ov5675: Elongate reset to first transaction
 minimum gap
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
	Jacopo Mondi <jacopo@jmondi.org>, Johan Hovold <johan@kernel.org>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin and Bryan

On Thu, 11 Jul 2024 at 11:40, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Bryan,
>
> On 7/11/24 12:20 PM, Bryan O'Donoghue wrote:
> > The ov5675 specification says that the gap between XSHUTDN deassert and the
> > first I2C transaction should be a minimum of 8192 XVCLK cycles.
> >
> > Right now we use a usleep_rage() that gives a sleep time of between about
> > 430 and 860 microseconds.
> >
> > On the Lenovo X13s we have observed that in about 1/20 cases the current
> > timing is too tight and we start transacting before the ov5675's reset
> > cycle completes, leading to I2C bus transaction failures.
> >
> > The reset racing is sometimes triggered at initial chip probe but, more
> > usually on a subsequent power-off/power-on cycle e.g.
> >
> > [   71.451662] ov5675 24-0010: failed to write reg 0x0103. error = -5
> > [   71.451686] ov5675 24-0010: failed to set plls
> >
> > The current quiescence period we have is too tight, doubling the minimum
> > appears to fix the issue observed on X13s.
> >
> > Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and support runtime PM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > ---
> >   drivers/media/i2c/ov5675.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > index 92bd35133a5d..0498f8f3064d 100644
> > --- a/drivers/media/i2c/ov5675.c
> > +++ b/drivers/media/i2c/ov5675.c
> > @@ -1018,8 +1018,13 @@ static int ov5675_power_on(struct device *dev)
> >
> >       gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
> >
> > -     /* 8192 xvclk cycles prior to the first SCCB transation */
> > -     usleep_range(delay_us, delay_us * 2);
> > +     /* The spec calls for a minimum delay of 8192 XVCLK cycles prior to
> > +      * transacting on the I2C bus, which translates to about 430
> > +      * microseconds at 19.2 MHz.
> > +      * Testing shows the range 8192 - 16384 cycles to be unreliable.
> > +      * Grant a more liberal 2x -3x clock cycle grace time.
> > +      */
> > +     usleep_range(delay_us * 2, delay_us * 3);
> >
>
> Would it make sense to have power_off have the same logic? We do a
> usleep_range of those same values currently, so keeping them in sync
> seems to make sense to me.
>
> Also, I'm wondering if it isn't an issue with the gpio not being high
> right after gpoiod_set_value_cansleep() returns, i.e. the time it
> actually takes for the HW to reach the IO level that means "high" for
> the camera. And that this increased sleep is just a way to mitigate that?
>
> With this patch we essentially postpone the power_on by another 430ms
> making it almost a full second before we can start using the camera.
> That's quite a lot I think? We don't have a usecase right now that
> requires this to be blazing fast (and we anyway would need at the very
> least 430ms), so take this remark as what it is, a remark.

I think you've misread 430 usec as 430 msec.

I was looking at the series and trying to decide whether it's worth
going to the effort of computing the time at all when even on the
slowest 6MHz XVCLK we're sub 1.5ms for the required delay.
At the max XVLCK of 24MHz you could save 1ms. I know of very few use
cases that would suffer for a 1ms delay.

I know we all like to be precise, but it sounds like the precision
actually causes grief in this situation.

  Dave

>
> The change looks fine to me even though it feels like a band-aid patch.
>
> Cheers,
> Quentin
>

