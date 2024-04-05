Return-Path: <stable+bounces-36155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0589A5BC
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41C21C20E97
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB30172BCE;
	Fri,  5 Apr 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMBmIVhs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A521327FD
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349587; cv=none; b=BEDOS686JDkZwbJYgwVEPAQdwGCOgeRJh+71gZju4ukKPwTmcaygX4biivY3aLsg0aJiSr9ECZx6qAAei0fx4ySJ2I/9FHoluByqjBp8zGc/TdsaxcGaMkVFSDGg2sDvkGafZidAPimCQislU4377pFZ3Nyi8EP38zzU8sN6wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349587; c=relaxed/simple;
	bh=uBhBS0owbOH8q75Bsi/MEJG4WnLcbooElg/VsjMfWN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/Hhptc1GNUuQjwZ9GBJrjgQdw3tGVkYEEIRIs95knCxyRwaAdITt2U3DvXlNpQud+JoHtHh1DP5TKk+O/C/qBxxHm7CEhId/bvKXDVaaCCrqTzaOXc6+4myb4qPfh0K6hDPnjg5jg47OgcBsAIRbuenZ4kb22EL62yYw96UeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cMBmIVhs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso2467598276.3
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712349584; x=1712954384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBhBS0owbOH8q75Bsi/MEJG4WnLcbooElg/VsjMfWN4=;
        b=cMBmIVhsJaWwJ24Obv/IX2fiSfqCYRntPrN8abLyusvXUbGPCn6RMEOhprBAyr0iU1
         wgOWJnkhSXS5lO3vxEvPYnSqt6Ls3yIC8crQaMH1GlTf7n2rcXXw2t4CBhQeaYYumeeK
         L8XGYEs/5F6GUByPc3GhV7lwgsKgWRKoUATM1f9gvLruLz4HLcBN/7tH/lbcHoBr1E92
         hNWbFxCC9N8on0MXpqlIoKmlRCukJ/Jy7TAqjf0qGXx+0iFucUnNamB2w792dNQSCvgs
         m4ThIEHXwPRwyHhj0M/aQKk/IWImjssE08/8TlKfH7OthKgq+EyN0T4Mt5YJj3F9gjvO
         5zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349584; x=1712954384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBhBS0owbOH8q75Bsi/MEJG4WnLcbooElg/VsjMfWN4=;
        b=xDKaAvqz6mkqJOdgve/3nVWiqjSmhkfhigYGVTSubv/hj7xZgWSzBK9lYSL2LtcsSq
         s+dfWtYfGm69HprQo5py2mra9C4b1jjEN/15F79aH3Ojz1j3ylHUPo6991bPry0BEWtJ
         9of1zDTfgBH3j+VKljb8lKfw22mlVTmRMzNgPiUzKGTaKXpE2ww1Mre4+GPPuTEQiajR
         mITr6KtLCO5IRNO30FNheYdQpDtLJI5zmc3Hte/PQHO2pp39Uzq7rm+2/vLSjGuUeAbs
         ahHPHU8umbB8KDkTepFP5J2Y2aX9mjniAz5rsYKdHMQoySg0kHbol6pzdvu1I5H9AmBh
         xvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwX3YR1WoIevYA+cD16UUaKJs3UWmvas/6SZhiAE22vZGJ2eTpLR+ztqoWLp8ZsJ5nBJyzRZCEGpN9Y1AKEiaH0M/uaa2h
X-Gm-Message-State: AOJu0Yz+AT2jy0NxXqAlJqwT+zCP3W/LfnQWFqE785trwNn9jS1rhXd3
	4E0PBATzgzxIALNYJ2ewdwQVMd7KSXhzeFiAzoxdbIKbmWTNzzoMT+auOaVJJKVnJSVBC0WfE/o
	Eew0UlX/GU8JEx8d9lNSiUkq7fyFE1IxXeZxBCng7e02wbHqI
X-Google-Smtp-Source: AGHT+IG8FM1KA6lXL1vVbGQ17xaHBcl33s1MYUN/yvSZWpowmG7hxpDvUXJlCdtYdFehQzhGV4tC6L96Rq2A1pVTl48=
X-Received: by 2002:a25:6806:0:b0:dcc:943a:b99f with SMTP id
 d6-20020a256806000000b00dcc943ab99fmr2206544ybc.46.1712349584584; Fri, 05 Apr
 2024 13:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
 <20240404203336.10454-2-ville.syrjala@linux.intel.com> <jeg4se3nkphfpgovaidzu5bspjhyasafplmyktjo6pwzlvpj5s@cmjtomlj4had>
 <ZhBOLh8jk8uN-g1v@intel.com>
In-Reply-To: <ZhBOLh8jk8uN-g1v@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 23:39:33 +0300
Message-ID: <CAA8EJpoOzKPh1wFfgQy8bZN_jfsrgAcrxM1x1pEFbAwcY9zBUw@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/client: Fully protect modes[] with dev->mode_config.mutex
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 at 22:17, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Apr 05, 2024 at 06:24:01AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Apr 04, 2024 at 11:33:25PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > >
> > > The modes[] array contains pointers to modes on the connectors'
> > > mode lists, which are protected by dev->mode_config.mutex.
> > > Thus we need to extend modes[] the same protection or by the
> > > time we use it the elements may already be pointing to
> > > freed/reused memory.
> > >
> > > Cc: stable@vger.kernel.org
> > > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10583
> > > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > I tried looking for the proper Fixes tag, but it looks like it might be
> > something like 386516744ba4 ("drm/fb: fix fbdev object model + cleanup =
properly.")
>
> The history is rather messy. I think it was originally completely
> lockless and broken, and got fixed piecemeal later in these:
> commit 7394371d8569 ("drm: Take lock around probes for drm_fb_helper_hotp=
lug_event")
> commit 966a6a13c666 ("drm: Hold mode_config.lock to prevent hotplug whils=
t setting up crtcs")
>
> commit e13a05831050 ("drm/fb-helper: Stop using mode_config.mutex for int=
ernals")
> looks to me like where the race might have been re-introduced.
> But didn't do a thorough analysis so not 100% sure. It's all
> rather ancient history by now so a Fixes tag doesn't seem all
> that useful anyway.

Well, you have added stable to cc list, so you expect to have this
patch backported. Then it should either have a kernel version as a
'starting' point or a Fixes tag to assist the sable team.



--=20
With best wishes
Dmitry

