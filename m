Return-Path: <stable+bounces-91818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB189C0729
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022B41F22E7A
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E720FA9A;
	Thu,  7 Nov 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLRNk7Rt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2611DEFDC
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985742; cv=none; b=LO49mtmP7m0mzfU2Gxwiv+9CQy3Exy4+vilYaDQ7crqWm/VvuATo5MtcPJGrtkXlKPXEeFUZbVxj2t8qCiclws0gcC4PpIWaDmtXjtgCSslzyrrDJIwPpr2d2B9oPMscreEuJcUMQYDTfjJR6vFCh+B1Jh4IAwlSEie8F+m8dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985742; c=relaxed/simple;
	bh=tafXy6T8mvGXw1f1p//OoV2OKeMhQpmhKK+Y05sbk70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAljgNuGRiiYT5bo7guOvWBF+GhTYYaaVzhuPIcdbzKJitWZXIwMTpWCrnBmRi2LvrJgx+FVyBeR6I3iy72PmXoZNj2sd9UvAUcj7Mbr2xtlU4r0C4WY8ENMtROCV/1PcTCtX+Dd6RWzauba4s26BI9QyMMapFYsfJ/yxtD3nZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLRNk7Rt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f84907caso902752e87.3
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 05:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730985739; x=1731590539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O78jUSo2VAB2jjaBqcpu1sFn5+Qacu329/7bBRcH7BY=;
        b=FLRNk7RtRik1FSeRpfxV5jPbKsShu0GFrIE/FKEo6HUKyFcYKNmMYTPLYN5V80wO2p
         vBCXF5Fta7yIQ6aUv2VEHYsyGwOepiaW3LsleMNmQfOFde5gbo9uZBj3UUnaPN6svRk7
         eVtg6gpODJOcCjIl3IWX+6+LSiGGdheSY8yFtoSiFpGPb0AnjqgeCrSIf5XDNyegsnjy
         qgqHL3vW0Z7YxpoKzguUW1xZDfFVboF62QoOOpZjmJITr9F7MNmWqXPitvBZlwl8Ha5O
         EH/fpKbfNJK2JMHnRFfWCO4S8XXhGqOH7FEzRjbQy4JRRI48MFNPa8n7G0CPeLURnF9h
         N+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985739; x=1731590539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O78jUSo2VAB2jjaBqcpu1sFn5+Qacu329/7bBRcH7BY=;
        b=RpNTEC/LKZyx9JLuAdLK+eZEJjcSErOg63qT63kv3cO9nfcyL8Usr/Wwxx0RNJ6+kV
         pXJ3tP54psLaKoK4435qD9fYz3C5rcCtBVdLMtuHIKJwHWOs0KK8QvUbBlBY9ipZIThT
         q6/h9p4BU0NeS5z8vsDiigM1IrX64biYvTqNedV8SXDQjlmvsAtb2KgbsgSqoagXtI5+
         aRztZRSJcMtonhLecd0WxpO0rGbEsaZp7CzVRF0vv1OutPAb+Bnl5JWx4FRaHpCKmsEu
         2wchZH1k2Uk5cbTy3U1Ftp/Ol/BRAUrhqegGc99gg5TT7+YXk8/UGizpOnVyNKtEBmTV
         9X4w==
X-Forwarded-Encrypted: i=1; AJvYcCUWq6zkqCi9AM0NdGnJk+W2NYPfCs0Q0ougMWtTzxbD+RntD70WUg8wVL7JeNZD4iF/NILfuP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/0e5oONhUyJMjtkrwoRldk1Hghslpxg0ehA9ElDJFvi69UEn
	6rKKTRM5OxsQN2+80aR2Yi1YKNiNOeJ+szv8HDknc68B0cNlwuZjPgZ1Gs+KnJQ=
X-Google-Smtp-Source: AGHT+IE7iCnTN6cJcxYydY0LNjIyPayqcFupD1/fQ2SNQljIoWv7ce8HamPJfCQEBawmCBwWNzoUXQ==
X-Received: by 2002:a05:6512:3981:b0:539:eb2f:a026 with SMTP id 2adb3069b0e04-53b34921a44mr22822155e87.33.1730985739182;
        Thu, 07 Nov 2024 05:22:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82686327sm215610e87.102.2024.11.07.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:22:17 -0800 (PST)
Date: Thu, 7 Nov 2024 15:22:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
Message-ID: <ql6hftuo7udkqachofws6lcpwx7sbjakonoehm7zsh43kqndsf@rwmiwqngldn2>
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
 <b2yvyaycylsxo2bmynlrqp3pzhge2tjvtvzhmpvon2lzyx3bb4@747g3erapcro>
 <81d6a054-e02a-7c98-0479-0e17076fabd7@quicinc.com>
 <ndlf4bsijb723cctkvd7hkwmo7plbzr3q2dhqc3tpyujbfcr3z@g4rvg5p7vhfs>
 <975f4ecd-2029-469a-8ecf-fbd6397547d4@linaro.org>
 <57544d01-a7c6-1ea6-d408-ffe1678e0b5e@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57544d01-a7c6-1ea6-d408-ffe1678e0b5e@quicinc.com>

On Thu, Nov 07, 2024 at 06:32:33PM +0530, Vikash Garodia wrote:
> 
> On 11/7/2024 5:37 PM, Bryan O'Donoghue wrote:
> > On 07/11/2024 10:41, Dmitry Baryshkov wrote:
> >>> init_codecs() parses the payload received from firmware and . I don't think we
> >>> can control this part when we have something like this from a malicious firmware
> >>> payload
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> ...
> >>> Limiting it to second iteration would restrict the functionality when property
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED is sent for supported number of codecs.
> >> If you can have a malicious firmware (which is owned and signed by
> >> Qualcomm / OEM), then you have to be careful and skip duplicates. So
> >> instead of just adding new cap to core->caps, you have to go through
> >> that array, check that you are not adding a duplicate (and report a
> >> [Firmware Bug] for duplicates), check that there is an empty slot, etc.
> >>
> >> Just ignoring the "extra" entries is not enough.
> Thinking of something like this
> 
> for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
>     if (core->codecs_count >= MAX_CODEC_NUM)
>         return;
>     cap = &caps[core->codecs_count++];
>     if (cap->codec == BIT(bit)) --> each code would have unique bitfield
>         return;

This won't work and it's pretty obvious why.

> > +1
> > 
> > This is a more rational argument. If you get a second message, you should surely
> > reinit the whole array i.e. update the array with the new list, as opposed to
> > throwing away the second message because it over-indexes your local storage..
> That would be incorrect to overwrite the array with new list, whenever new
> payload is received.

I'd say, don't overwrite the array. Instead the driver should extend it
with the new information.

> 
> Regards,
> Vikash

-- 
With best wishes
Dmitry

