Return-Path: <stable+bounces-98875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B99E61AD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710831885396
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ABAA55;
	Fri,  6 Dec 2024 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3c+eLsS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877515C0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443576; cv=none; b=engtUYjpqc//qJJrkV9vSpTSwHTtOs+zGBNvrf2cJvpJ00S+9ItM4yNQIULq3HJl3d+amoGRY+VXEVEd5xF4+8yT2Tp/cbpwGIDRnVfRKRo8nIsxumJrEB7iME6mNCYmcl54+yWrunXZ1Wnch/QmNI4l0olTrMsHwjp/WQefrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443576; c=relaxed/simple;
	bh=+zZb25sMPo1UW2p0NvN0+h1r64JQsSf3ZFc+L3R3AC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiMaEKFPs1B5+OHKG0WctiPfGItbLSeSVc17h9ZZixF8WfpZs7KJjHeRd+Ph1kuigW3ip1YHiGFhORBjZXO10F4rVxeL6PQj9MGpPNNzJk5zslCeyQ8Xs0HFBcf+WfNsP/WxhMBOQ+2WZwsGHUJOHwj7WWlDsfZdZeHIbTvi1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3c+eLsS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3001d009633so13753461fa.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443573; x=1734048373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3TPBP6t+GJK9sLABw7iuDGZ/6x8FUIQxd10a+gfRfo=;
        b=L3c+eLsSY1u+Kl7uqpIoECXQaxp9MP07TBJ0zS9a/R1Z2oAz4NPlQEv7GSkTHYH0FD
         VehO/QDdf1bpPaBM6qTtJbPCK0T0HlLVcW4IMge829LN3Xen7YYkrCZBQxi6EwiPm0oE
         FliNukaTj+YJ5JXknqMjE0g8R4iEUMXHcKn+W9J+KOyao6Vix/804uuYvbxOD8jPOy/8
         MnzWxe6aCg2h7HnmUsh/OXtX9d0WAeomS8X9QyxYGdbjGn2geZ6pKCcOezeKfC2AHm4U
         aKju48/lR6VcBHNOfOiJxJ9l5lpiN+t4tm+kuRxFzv4bydvh06t3mPkB9fOhVaA0kzrf
         ISmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443573; x=1734048373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3TPBP6t+GJK9sLABw7iuDGZ/6x8FUIQxd10a+gfRfo=;
        b=cIXflOEf2Pj3LsFOvN0wsT8YAMGl6lENTI+2Qn0owQdIi2CbWutFPdWAgV8A/sVxwx
         p4Nd9PvCYudNyrDngxeYMqBpohR2UCBmplcK2u3ilGWFNNSUDtYaQWWl+A4NRZ0zZnOl
         IYcjBnNVKErZo0p7tz6OIqDn/ITrB70/tqmexKRx2mbq6cbT3q16oX8Il0f638zDNPMp
         mgasYLZiMy3ekDRJTXYo4wrLhujeZPoUkTZnHYER4CNCqYpgodkwo/ys1sEgS5ynVGb7
         dZVfLOXNBfMvT5UdAyWD87kxs73Hs9Py2U+clU0V78eq7qCo+9jaAC8iY/v0Abgn+Hth
         +2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVbztMr5qmNiVCo85igNmZ2Ce/kMog8uHAHgILb3T5475OtG1yODVQaMGmoCT3AAwWxzXpl9X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2jw0B2oI0os4CKbnxtUF4NP1nt0hwNb4TrcqrtXzPj6T+xsN
	AqPjs/hIIGbJGD5FXsZdhbkr1IR3yeTvEodoECZmUwm2m79k6Cc/OhE9P8CIBiO/NyH3sKSIUc+
	GxvNIFwOUMcsHzlhM6QJyC4JQjGrdegfYWmf7
X-Gm-Gg: ASbGncvokgcGM0WkLUwtIo/9a3tXKd6sQ91v3ke7gO8hmknGGS7NYt6Kuf5eBow9/3k
	mvWvyfzikt6VqoRyQ+uazfOHxdb0KYA==
X-Google-Smtp-Source: AGHT+IENUCJT3jmuSq+uuBSoJsgvgSBDBHg4ob0uMlJQb0PpgFG3hX9cyDh1XGO4hDnpY6OiQOw6us+nrtPgXeARTyM=
X-Received: by 2002:a05:6512:104e:b0:53e:2116:fd2f with SMTP id
 2adb3069b0e04-53e2c2ba477mr238894e87.24.1733443573131; Thu, 05 Dec 2024
 16:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221820.2248367-1-sashal@kernel.org> <20241204221820.2248367-4-sashal@kernel.org>
In-Reply-To: <20241204221820.2248367-4-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:05:35 -0800
Message-ID: <CAGETcx9RpUz0hR-X+rO6yKRxOmrMLveU7EMSACF49kMTMqdaRg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 04/10] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, sumit.garg@linaro.org, 
	ricardo@marliere.net, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index 8a165be1a8214..d15c0f184983b 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
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

