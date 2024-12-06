Return-Path: <stable+bounces-98873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C89E61A7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929C91885270
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9A10E0;
	Fri,  6 Dec 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YydW9UJQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219A634
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443537; cv=none; b=Jlf4Nnhf5MMvJMGfs2Yyk5Qf2ctS7bv/TPpver4r5erwHgilwrAayvBsIgjOcNU/no0mCzbkPEvY5HOZTA0aNkQZ06QuND53MHuV3MaxTppDAU8CCVda1NJV5zbBOgDS9dVVc3r3XUIoRwh1RouEHD4Mv5PJhNu6UaGF9aYdFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443537; c=relaxed/simple;
	bh=irTCkX6At0E1tiMfR3zLyBQHCK3QY/or93wCzKF8HFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKZrux+/3/lBA/u0o4hhzwtGo9ae5u2CWI7DBLWN4y2aAropVXPV1rbtewOszIw8vXa8pZzmMd9Iz4s7EmeXJlZyNSBC4LySXJeOQPpi3OVObjKInBDTT1WADPR3Bd7vXlR9l2cskT+bdaUrOEC5ITyBfFNwRmFD2XsUqRtJEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YydW9UJQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso25393551fa.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443533; x=1734048333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOo5o1IkcWYIYeHg+0oB2U3HqNWFzIG3pPjklrK0UCc=;
        b=YydW9UJQUok3OsZUG8TYn0P+98Oy/yqSCgKc6/P/6wMLek1XPmiCA3gscbHbG4Jb1h
         oDGuA4nY73W0sOUI6sghJWrx7eNXQIw6W7G/gC3slVx0T0Hdiu3NXq/tAd2BMqbs8CFW
         wGyGfR/dj7sWkQtZUIPhnlp7+myj4sxzdYA+RTh29mvtXGETt5ZGMBfJG+qGbOP4YAM/
         +dXl9TGopIRMEDcb0XiQBhaKSrjKIdGMdgP7FXxPlBcAAT5pClzgpLQS4d+JW60V4NPa
         cdrAVWjbYe3YWKgByaEGEwgEwKqA85qz6j+tfJQ3BqmYy4Q6N1O3QATvvLftH2OyY4K0
         pJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443533; x=1734048333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOo5o1IkcWYIYeHg+0oB2U3HqNWFzIG3pPjklrK0UCc=;
        b=qfngTkqmkRWZNoMc1TgmLsFWxc4F1c/QRhhj1m06L/IYX319uj65QXR9nXFxY5KqZW
         PctTUxIDgepBBFIeiodGdilh7tIpXPj1fQguYpAPbpmUjQZG1lIg6qG1aldQJ3lObDj3
         SZAeBUKyQwY+D8nePhrdBYvaffTHjQrOQiLa5XDou6prAE5h1m6UyfLuSX2AkkWyuKRo
         vTccVWdKCAspSlOoeA8ZNR1gc7xIwcpXk7kBml/DbwaTrfG7YQIGgXxdq9e7mx7fdlsP
         nOT4hEIfYAcEjB4KeWiCLtF1TIZUFc55j66tKjNHJxPzCI2AlJcDdAcIbDikDH42aYaC
         eK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVvBrNCoI2wWSR5Sdf/RjAmtBaOi2PS3dGuYyGk4SBXNkwXMQJlpLRn97Qh39V1TjwEUYFrt1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxZqReNQfQZV2ZynPJZ2NMYmSgyf/JM4ajq2/fQyYKH/73SGX
	vVur44eB/+yPRV3PwGvPX/XCnkntN2/0UmwtDise5ykI9E2zArvqTf8p71TwjnBH7QA/wf2UUj3
	Cju8Z3tBxGPZ/skdRKKg+A/1A83GJAzbS0sd3
X-Gm-Gg: ASbGnctBude3AJkpM81bYhfflh+AuK7Gv+IzjPF3NJohUUBUJoWeEMdvOWRMzV2dpXc
	3yc6RaB8GVf311oJtVly2b5aJxpLGxA==
X-Google-Smtp-Source: AGHT+IGyZ/TZMqzTp8+it+xJqPWDkQKwRdqrGP6nkAD/oOmQhsRauaZCXRwfpEP8IRWA2Z0RTrR2gBDTeLWDpYubwUw=
X-Received: by 2002:a05:6512:1189:b0:53e:18ac:b1fe with SMTP id
 2adb3069b0e04-53e2b6ba9abmr349123e87.1.1733443532699; Thu, 05 Dec 2024
 16:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221859.2248634-1-sashal@kernel.org> <20241204221859.2248634-4-sashal@kernel.org>
In-Reply-To: <20241204221859.2248634-4-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:55 -0800
Message-ID: <CAGETcx-u9BuPLiJ+Hn_29xmR_W3d7jC=uPFsw70eC65CZ_9UtQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 4/8] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, sumit.garg@linaro.org, ricardo@marliere.net, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:30=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) wit=
h backlight-lcd0
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@=
notapiano/
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index f5741b45ca077..951170e1d5d14 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -287,7 +287,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>         aux_ep->dev.parent =3D aux->dev;
>         aux_ep->dev.bus =3D &dp_aux_bus_type;
>         aux_ep->dev.type =3D &dp_aux_device_type_type;
> -       aux_ep->dev.of_node =3D of_node_get(np);
> +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
>         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
>
>         ret =3D device_register(&aux_ep->dev);
> --
> 2.43.0
>

