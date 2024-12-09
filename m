Return-Path: <stable+bounces-100265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25B9EA17E
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9EA282980
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B919D891;
	Mon,  9 Dec 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJSeYi95"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602519ABD4
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781357; cv=none; b=u4W9KUjj5ByrAmEdPEEDeaWkY93nUEKXCcGmmtTVSQDgVudGBYfizARz0d2hI055Jd/qRUtpmxfBoeybo3O+qEXC46N0DzjvsAZDmQTMGtw08Yp4dQ0kG6U6jnA5P5ygGAtnUc1tJdmP8zmnFDNG8aQW/m0X9D2O0aoRZpslJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781357; c=relaxed/simple;
	bh=H//sO90IePyj3LC7n1tebDQzStvpmLDabpAGP4caztc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d52IZr+MZR6qahRW/Q0ItdFfPb5OZVnfeyZNyjlxYjoBoos8eLWz+d1tDenBbl8clyb4NcEb0NXfp3+hkoqGPgzvsWtIGaX6iMRk6iU2j5gfTFaqRbkd8thidyDgu+FEY/uAFghGxX7dLsbGks6ZbWu8dggI5h1UHUcTTOIl8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJSeYi95; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3983426f80so3901997276.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733781354; x=1734386154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ0wYKLSFnZmfke+PxuCGZUvLY7DaqGxl2qtoRDQQAM=;
        b=xJSeYi95xjtZCgX4UnqTNqCkvg7gldvA4rHRvLh8G63oRPpd9Pb379Z4sM8TQYNeyP
         Sc7MMCjxVUsdL+Mr7H9OOrmSOHa66FuEmprDR68P/3fwiODt67SZNttmXXDtb3nffzNq
         ODeoazeYMb5eSTmX3lRkChtGNlKc7ZZ5naDwYpC1igqxA1IdPN0fSjZiCtlcpo25tGPM
         smPD+En/w7+QulfTadnKG0yXv6rdcDZKPGMwnRb3iaF5yDBQfU7+Qf2r26ORpTEL+HBI
         QgH04r2xhW2O3toZ0OfPEVEgJJYi9I5YQ6NpOGEMRYFn622F2yQZqohebcDMDYxZHbjY
         AXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733781354; x=1734386154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ0wYKLSFnZmfke+PxuCGZUvLY7DaqGxl2qtoRDQQAM=;
        b=VlMg8CCXkzdZVaYr5C6QQcLttS5DdH2edpIeY8sWDLpHyK+o/58ENM1gZNBeb1Heis
         5AULric8oBybN9lgwM6Iqb5lcVqYZ/Sk52UUNjEg3gBuEoVhr1HaOA5Nxc7tTuHn+oAa
         Xow7LnBEzENvQF9ySpFL3FtuW0hYjQvhIBqJ0Hdmo/27su8mhFmirYXBt9b/2h4yEL2V
         v2ZcAN7tREj02IlXrL7w3ZQKMbYh7ysEy3oox1Ky2ipwWTQSYgLclv3V+Qq0A8ifGvkV
         QySNaUAU7A6fH0cX8HKPFDIqEmPxp7MEPrh5H9nTN6ARJ0SLpAej0jediUX/fAlKgNI1
         4bag==
X-Forwarded-Encrypted: i=1; AJvYcCX+fSAX/qPRssvjdx6dY4xkH7oTFY/Y2mtNp60RakxUvvPPOoHRVW7I18MAh83JJGq5d2/dBng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+d2rS2KGjEziapez5j4Sej2mQ3n0rb8EX07ZiTY9QmoAmpPX3
	ZMAD8T4coYZe+7KiKX9N9Puflp7+fCn8J3W6+83gD4p8zblnVkqDVkmOIg5aUrbjl/lue+4uTe+
	Yq4Zq6nCtGAKFClfiCAzMFgZHktDnOuMCo4Wrzg==
X-Gm-Gg: ASbGncsskxRKWVGJMWNeTywuQp4UFGwj6OOu3MXd4NRGpsv+grZjnq6diho6NqdoBMy
	cRc1gMIz98AcNLFCgrODm6/LPJW4p0wVfTBg=
X-Google-Smtp-Source: AGHT+IEWq4h4J86uCczjFNZUd/XrORvyK73tLgPy1IFFQ82ttFjoRnsvPNBFy2MX1xtgigmZbA8Wi1/5t50ppT36GSE=
X-Received: by 2002:a05:6902:1203:b0:e39:9a8f:5224 with SMTP id
 3f1490d57ef6-e3a59ac0a06mr1844235276.2.1733781353991; Mon, 09 Dec 2024
 13:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-dpu-fix-wb-v4-1-7fe93059f9e0@linaro.org> <9c42bbb1-bf6c-4323-95f9-0ac9e7426d0c@quicinc.com>
In-Reply-To: <9c42bbb1-bf6c-4323-95f9-0ac9e7426d0c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Dec 2024 23:55:42 +0200
Message-ID: <CAA8EJppMA-AREJata0MWHCDYC-7ra723zhC4Nu_xD59O0mX_Ag@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dpu1: don't choke on disabling the writeback connector
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Leonard Lausen <leonard@lausen.nl>, =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 at 21:54, Abhinav Kumar <quic_abhinavk@quicinc.com> wrot=
e:
>
>
>
> On 12/9/2024 2:04 AM, Dmitry Baryshkov wrote:
> > During suspend/resume process all connectors are explicitly disabled an=
d
> > then reenabled. However resume fails because of the connector_status ch=
eck:
> >
> > [dpu error]connector not connected 3
> > [drm:drm_mode_config_helper_resume [drm_kms_helper]] *ERROR* Failed to =
resume (-22)
> >
> > It doesn't make sense to check for the Writeback connected status (and
> > other drivers don't perform such check), so drop the check.
> >
> > It wasn't a problem before the commit 71174f362d67 ("drm/msm/dpu: move
> > writeback's atomic_check to dpu_writeback.c"), since encoder's
> > atomic_check() is called under a different conditions that the
> > connector's atomic_check() (e.g. it is not called if there is no
> > connected CRTC or if the corresponding connector is not a part of the
> > new state).
> >
> > Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu=
_writeback.c")
> > Cc: stable@vger.kernel.org
> > Reported-by: Leonard Lausen <leonard@lausen.nl>
> > Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
> > Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
> > Reported-by: Gy=C3=B6rgy Kurucz <me@kuruczgy.com>
> > Link: https://lore.kernel.org/all/b70a4d1d-f98f-4169-942c-cb9006a42b40@=
kuruczgy.com/
> > Reported-by: Johan Hovold <johan+linaro@kernel.org>
> > Link: https://lore.kernel.org/all/ZzyYI8KkWK36FfXf@hovoldconsulting.com=
/
> > Tested-by: Gy=C3=B6rgy Kurucz <me@kuruczgy.com>
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Leonard Lausen reported an issue with suspend/resume of the sc7180
> > devices. Fix the WB atomic check, which caused the issue.
> > ---
> > Changes in v4:
> > - Epanded commit message (Johan)
> > - Link to v3: https://lore.kernel.org/r/20241208-dpu-fix-wb-v3-1-a1de69=
ce4a1b@linaro.org
> >
> > Changes in v3:
> > - Rebased on top of msm-fixes
> > - Link to v2: https://lore.kernel.org/r/20240802-dpu-fix-wb-v2-0-7eac9e=
b8e895@linaro.org
> >
> > Changes in v2:
> > - Reworked the writeback to just drop the connector->status check.
> > - Expanded commit message for the debugging patch.
> > - Link to v1: https://lore.kernel.org/r/20240709-dpu-fix-wb-v1-0-448348=
bfd4cb@linaro.org
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gp=
u/drm/msm/disp/dpu1/dpu_writeback.c
> > index 16f144cbc0c986ee266412223d9e605b01f9fb8c..8ff496082902b1ee713e806=
140f39b4730ed256a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > @@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connec=
tor *connector,
> >       if (!conn_state || !conn_state->connector) {
> >               DPU_ERROR("invalid connector state\n");
> >               return -EINVAL;
> > -     } else if (conn_state->connector->status !=3D connector_status_co=
nnected) {
> > -             DPU_ERROR("connector not connected %d\n", conn_state->con=
nector->status);
> > -             return -EINVAL;
> >       }
>
> Can you please explain me about why the status was not already connected?
>
> In all the places I checked (unless I missed something), if the detect()
> callback is not registered, the connector is assumed connected like below=
:
>
> 404     if (funcs->detect_ctx)
> 405             ret =3D funcs->detect_ctx(connector, ctx, force);
> 406     else if (connector->funcs->detect)
> 407             ret =3D connector->funcs->detect(connector, force);
> 408     else
> 409             ret =3D connector_status_connected;
>
> We do not register .detect for WB as WB connector should be always
> connected.
>
> What scenario or use-case is making the connector status to something
> other than connected?
>
> The places which mark the connector as unknown seem to be covered by
> warnings in drm_probe_helper.c but the bug report doesnt seem to be
> hitting those.

Because nobody asks for the getconnector on that connector. For
example,drm_client_for_each_connector_iter() explicitly skips
WRITEBACK connectors. So, drm_client_modeset_probe() also doesn't
request ->fill_modes() on that connector.

I'm almost sure that if somebody runs a `modetest -ac` on the
unpatched kernel after boot, there will be no suspend-related issues.
In fact, I've just checked on RB5.
/sys/class/drm/card0-Writeback-1/status reports 'unknown' before and
'connected' afterwards. You can easily replicate that on your
hardware.

>
> I am wondering if there is some case in fwk resetting this to unknown
> silently (which is incorrect) and perhaps other drivers dont hit this as
> there is a .detect registered which always returns connected and MSM
> should follow that.
>
> 111 static enum drm_connector_status
> 112 komeda_wb_connector_detect(struct drm_connector *connector, bool forc=
e)
> 113 {
> 114     return connector_status_connected;
> 115 }
> 116

No, that won't help. You can add a detect() callback and verify that
simply isn't getting called. It's not resetting the connector->status,
it's nobody setting it for the first time.

> >
> >       crtc =3D conn_state->crtc;
> >
> > ---
> > base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
> > change-id: 20240709-dpu-fix-wb-6cd57e3eb182
> >
> > Best regards,



--=20
With best wishes
Dmitry

