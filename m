Return-Path: <stable+bounces-119417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46644A42DA6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 21:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DE17176A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74203219301;
	Mon, 24 Feb 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMvGOanm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B241DF982
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428679; cv=none; b=ZP0aozth4Y5CxMOiCnCcW3y7+LVOMdSkqIeKnfc7mfWgOgjvekfVr37rxkAEFspRpVvG3+sW4rOsxelANsnTDlQaKad9oQ4Xu/uAk7phvZFWD8qfeAKcDXghFn5nfEgwm5MKK7GEQYH2VSuj/TLZfYFcIyzvyFS2EpYCtQXnxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428679; c=relaxed/simple;
	bh=ypqH+5QGTDNfOqNKjYd3vvQwL54Eq5RFiIToo7bR2YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXR7vY6pyZ04JHWbn4iRpC5rAV9dY2rAr8eEnsJahvRqVoNNFgA6Mdujhui8qSySwRQNrzqbah8qcnBTXPlcQCLcKw1lbnkRQYhIFsVl3tEMhYL/zxfRz6RPIRcOSXCGMpJHnvV4fw0WPKTRAGA2GU6GyjYGwJFkZL0Kmh6hq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMvGOanm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb90f68f8cso923621366b.3
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740428675; x=1741033475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vf44wp5rUx2plsgf9kIwGx5RAV0vlFapN+QJVR6hqw=;
        b=hMvGOanmOPR9Z5hcLaN6ylih4Z0EdTILrlvMCgIufMI0krDGJAz4l1z2LljA+yRiS/
         PtW1EUTTCFyIS0Uou+bzV228AsCHDeKnpWbjRXg5wZS/6su+GebY58BJERT3iNvvsUL9
         PGb75hINF9xOsuXFyLjd1sZgDPk6/zhzbCKXe1wRtW14lV68hXyx76dWSsG7AGXdu3/8
         8srZa+LR+Z9NArSuMyvdy1OZ6BHRjZRonLhOlJHGw/2Dbpp3ERG9kVFjBfvhYjwJHDiL
         mV8aFvaXHk5Edv5U0l969d1iJJAiqJ7SqaObvNxBEw5FuNYa8gi1KYHWTroAbPhpXjTV
         KeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428675; x=1741033475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vf44wp5rUx2plsgf9kIwGx5RAV0vlFapN+QJVR6hqw=;
        b=rXjR4RJlE+2Ah+HnE6MdkAj3A/Ac4NVhqGtkPKFj1ePRYJ2uZ+LbuFVUtY5yVSkGSr
         Gy8dSKFg1sU9H8A/QOMeE83auYFt4tbkuGCWWfmdTJpgtdDIi7dr6FHzxsXXVoQnpZOC
         Gu9NdGEOhYuNtPh4giGDRbVyASpQTGexGcqvX0WO7iQerDrnWjGEKlaF5zhFi8DVZBcJ
         YE4fIwuZ2UZcwXAindigaErOXoObFTJ7mpSp0VYK5Bqn55s3kUzT1BKXhmmuKISQd3et
         uRLpdGKhNB9Cgp6grOokr9rG6/SsFMHsX2hmV2hKxX+Mb/I8Bettm26fkkk+32ZVaOB6
         pJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKeXAs+nDGxovjagW7bMJ9RJ3mNov2GWbCqQbUMhLoOle+1GpdVnFNzrV/H2rsqzLQnqC5+BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+YkPY3bCGT4/gNFCQn1ECTFwMvxAi956sF+dinBfng5cM1PL
	kp2uEisUwxLT1x7rAMWPXLlFKY+jAQ0DP1Rqf8dMPO/2QvgAaLopT3n+uvSDGS4=
X-Gm-Gg: ASbGncuDUcymCzyRnQDTjcQOTBG34M8DsRu0Ig3Pu+AswUP7OTB+jEB+noTIGajHpj/
	s9YTxQFjjVIbnYOdazySiTbow/hhzV0OqeCct3Axw7k6YKRnhzFsq+hUATuvQAINBDXV34TKV4Q
	BBMMOmr/526BAFPVQlOnkLlp+z3KebMXPjJ8EFn8/mTpJtjPsFacQFUYDlpfg4f8uHhVnOS+i29
	JKa82bpDiRjXLsj+1E991tTysIRwgBZ82/h9rMveJf78QiAgz/fl0Th7yzUuS9AhFLiwBNDtJ9N
	/xe0C5TUwNTm276qX+Obow0=
X-Google-Smtp-Source: AGHT+IGwiPwIN0XhI1Zo3GSHaxpag8+kqp/EE/AF2y5r293/STs9ynOR6hcLSqodraUt3gaPlnqpOA==
X-Received: by 2002:a17:906:32d7:b0:ab7:a5f2:ed22 with SMTP id a640c23a62f3a-abed0c745c4mr63280866b.1.1740428675303;
        Mon, 24 Feb 2025 12:24:35 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2053ec9sm16198466b.137.2025.02.24.12.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:24:34 -0800 (PST)
Date: Mon, 24 Feb 2025 22:24:33 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Kamal Wadhwa <quic_kamalw@quicinc.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
Message-ID: <Z7zVgeM+7P7SLWIu@linaro.org>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>

On 25-02-21 00:35:08, Sebastian Reichel wrote:
> Hello Abel,
> 
> On Thu, Feb 20, 2025 at 12:31:00PM +0200, Abel Vesa wrote:
> > Currently, for the high resolution PWMs, the resolution, clock,
> > pre-divider and exponent are being selected based on period. Basically,
> > the implementation loops over each one of these and tries to find the
> > closest (higher) period based on the following formula:
> > 
> >                           period * refclk
> > prediv_exp = log2 -------------------------------------
> >                     NSEC_PER_SEC * pre_div * resolution
> > 
> > Since the resolution is power of 2, the actual period resulting is
> > usually higher than what the resolution allows. That's why the duty
> > cycle requested needs to be capped to the maximum value allowed by the
> > resolution (known as PWM size).
> > 
> > Here is an example of how this can happen:
> > 
> > For a requested period of 5000000, the best clock is 19.2MHz, the best
> > prediv is 5, the best exponent is 6 and the best resolution is 256.
> > 
> > Then, the pwm value is determined based on requested period and duty
> > cycle, best prediv, best exponent and best clock, using the following
> > formula:
> > 
> >                             duty * refclk
> > pwm_value = ----------------------------------------------
> >                 NSEC_PER_SEC * prediv * (1 << prediv_exp)
> > 
> > So in this specific scenario:
> > 
> > (5000000 * 19200000) / (1000000000 * 5 * (1 << 64)) = 300
> > 
> > With a resolution of 8 bits, this pwm value obviously goes over.
> > 
> > Therefore, the max pwm value allowed needs to be 255.
> > 
> > If not, the PMIC internal logic will only value that is under the set PWM
> > size, resulting in a wrapped around PWM value.
> > 
> > This has been observed on Lenovo Thinkpad T14s Gen6 (LCD panel version)
> > which uses one of the PMK8550 to control the LCD backlight.
> > 
> > Fix the value of the PWM by capping to a max based on the chosen
> > resolution (PWM size).
> > 
> > Cc: stable@vger.kernel.org    # 6.4
> > Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Note: This fix is blocking backlight support on Lenovo Thinkpad T14s
> > Gen6 (LCD version), for which I have patches ready to send once this
> > patch is agreed on (review) and merged.
> > ---
> 
> Do you know if the pwm duty cycle to pwm value calculation is
> correct otherwise?

Sorry for the late reply.

Here is my understanding of the calculation of the pwm value currently
implemented.

First, find the best pre_div, refclk, resolution and prediv_exp by looping
through all refclk, resolution and prediv possible values, for the
following formula:

                         period * refclk
prediv_exp = log2 -------------------------------------
                    NSEC_PER_SEC * pre_div * (1 << resolution)


So in DT we set the period to 50000000. For this, as I mentioned in the
commit message the best refclk is 19.2MHz, the best prediv is 5, the best
exponent is 6 and the best resolution is 255.

So if you use these to compute the period following this formula:


                NSEC_PER_SEC * prediv * (1 << resolution)
best_period = -------------------------------------------
                             refclk

So in our case:

(1000000000 * 5 * (1 << 8) * (1 << 6)) / 19200000 = 4266666.6666...

So here is where the things go wrong. Bjorn helped me figure this out today
(off-list). Basically, the pwm framework will allow values up to 5000000,
as specified in the DT, but for then pwm value will go over 255
when computing the actual pwm value by the following formula:

                            duty * refclk
pwm_value = ----------------------------------------------
                NSEC_PER_SEC * prediv * (1 << prediv_exp)


So here is how the value 300 is reached (I messed up this next formula in
the commit message):

(5000000 * 19200000) / (1000000000 * 5 * (1 << 8)) = 300

But if we were to use the best_period determined:

(4266666 * 19200000) / (1000000000 * 5 * (1 << 8)) = 255

So I guess the process of determining the best parameters is correct.
What I think is missing is we need to divide the requested period (5000000)
to the resolution (255) and make sure the duty cycle is a multiple of the
result.

Something like this:

step = period / (1 << resolution)

So: 

5000000 / ((1 << 8) - 1) = 19607

and then:

pwm_value = duty / step;

Hope this makes sense.

Will try this out and respin the patch.

> 
> I'm asking because the max value is only used for capping, so with
> this patch the maximum brightness will be reached at around 80% duty
> cycle (i.e. when the wrap over happens without this patch).
> 
> Locally I'm currently remapping the duty cycle range to the PWM
> value range, which means the display brightness increases
> step-by-step until reaching 100% "duty cycle":
> 
> 		val = (duty * 255) / chan->period;
> 		chan->pwm_value = min(val, 255);
> 
> But for the backlight control the absolute numbers do not really
> matter and I have zero knowledge about the chip. So it might be
> that the controller really can only go up to ~80% duty cycle at
> these settings?
> 
> Greetings,
> 
> -- Sebastian
> 
> >  drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> > index f3c9ef2bfa572f9ee86c8b8aa37deb8231965490..146cd9b447787bf170310321e939022dfb176e9f 100644
> > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > @@ -529,7 +529,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
> >  	unsigned int clk_rate;
> >  
> >  	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
> > -		max = LPG_RESOLUTION_15BIT - 1;
> > +		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
> >  		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
> >  	} else {
> >  		max = LPG_RESOLUTION_9BIT - 1;
> > 
> > ---
> > base-commit: 50a0c754714aa3ea0b0e62f3765eb666a1579f24
> > change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
> > 
> > Best regards,
> > -- 
> > Abel Vesa <abel.vesa@linaro.org>
> > 



