Return-Path: <stable+bounces-98879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7089E61BB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ACB281CB6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEEB10E0;
	Fri,  6 Dec 2024 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3iEbLRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC20A41
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443662; cv=none; b=Pzzmx/fljz/qRwHhhxa3Czxx3S7jvYokr0yKZ/tTby91g6sz0tluveTs2sonx74HB1DovvJOQHKaesjdK5zw3NPt4nPYr7tA+XPowHUbnN5tfd+r73CU6By5KVPVmn4tDucvXbbtHHYPkuAgCr4eWxtH6XcpsSs5v/2XaiwIUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443662; c=relaxed/simple;
	bh=sRUYMy7a+fxU7wrLnRR/ckQwHu4CVg6hbg+4h6c3YbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjtAyLxcJCvcD9KQk+ZITPKMLt2yuFTQLFPrDKM3n51N1nmfzf0FmvOpDPsL7m2jF/YD8FnzRKzqwtSR2Vc4Y0Lkg3tMfM9A919OJ3/bEZHIXdIAGnix4SlGldER8LuMuqHHqrtrG2zP0wrxKZcQcM8AH2iv3LEcVzJGjWmtaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3iEbLRd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df119675dso2026997e87.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443655; x=1734048455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blIrJbErtJBhmg6i7GQdINtKp/1t5xm0HORWyHzR8zA=;
        b=u3iEbLRdSU2l0+qoG0k0F+oggHS6R0qPKmDCfKWBaYqYDUyHfwq9ztVfJnM4Ub8Zfs
         SagocPkEVmK/TXHf+fgEGizuQ4Z/+E+BGv+/AX+sVBCAMqdjv+y73mKcCFQZOGl1S6AE
         TrJDjTvb//n4nV0ZjVx91pFfGXRRwPdOhHr1wqATiCcYcVLEv9DcWTGxxN+nEaLrSIra
         8vUFr+utD2ijN4E08J4ohaF19O4Yv3EY7RnYzqBa9hxDFDrwlC7GIH6kPf+eUgPilDy+
         Rz0/Zzlb68OEMR7VVSeJRh6UNUXOdXVDVI/VquXUTuKAFEbmfoFWHJMML5SkBw0KjaDi
         vjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443655; x=1734048455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blIrJbErtJBhmg6i7GQdINtKp/1t5xm0HORWyHzR8zA=;
        b=YabPGHVWf8T3qI99etYRXJMxh3s8BloGtOM5aV3ITV69L63XxpuarFIf8tG0ZHIy2o
         ydK/9sykbZFdUgfDHaqTYp3H3kJoGS3vj5KNyt6KId+qkekoLKmepTkpM9EDhziNhor1
         zaiUNhgkQFziuX4aeD+4RjNVTR6Gcta/z8EdDFWAjeG7BMmsEWZF56BfmnuIXqNkPKZM
         NK9nwKtk2KUSxaSFPgmClmutQm1vtYlxcSOlGfsKXcG1vsKwgx11pDnZ4h+8q3ItquY7
         2XBd/h94YBvmMtjbiTVqD7CmDEvjDAdajCQB/h1I2aQ75KGd5G8zltWbsyuDurOtIDny
         Vnxg==
X-Forwarded-Encrypted: i=1; AJvYcCXBtLVQYdDcIhiqh8yMRgNue4TZOTQKClYeGcyeBGAKC2bdz+aptxeNp9c//rkc51RCCU2Mu8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhHmfkkcKwpFCaFeQE58+Wx1u+cCYRe6mVl/Efn2qyNyN16fwS
	kgNN6N9cKEt7aXKbLCnIqFLgi6JigVfz4K7VSAMZEcB28ylZxG8t3j6Ifms13fNLTyDZXpUv+Ir
	+9AAUKr1qol5GhXzS8SbZzdwb519tVhiFbdOj
X-Gm-Gg: ASbGncsUFKy06pejEfto06/p1r2Wfh0I4E+iJZp9apbbraq7aCk7QEJamY4ktqb5BcH
	fraVgu2PFeTyWH3tQ0gEzMEmEQ2D+RA==
X-Google-Smtp-Source: AGHT+IGwkB+5shyB5Uw7Uf9fUCWUSk4ghNB6iVijhuSWeVK3ZvAmFf8V/NY25l5TehZEnnHMKB1Y4S3fEVzEwkI2dcY=
X-Received: by 2002:a05:6512:220c:b0:539:e65a:8a71 with SMTP id
 2adb3069b0e04-53e2c2c1873mr420862e87.34.1733443654651; Thu, 05 Dec 2024
 16:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221627.2247598-1-sashal@kernel.org> <20241204221627.2247598-8-sashal@kernel.org>
In-Reply-To: <20241204221627.2247598-8-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:06:58 -0800
Message-ID: <CAGETcx-8nwfbCHN7zG7XuOM+CRevEU6M8fqaw1H4h+yz-H2BoQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 08/15] drm: display: Set fwnode for aux bus devices
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

On Wed, Dec 4, 2024 at 3:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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

I'm okay pulling this into 6.12 as it's recent enough.

-Saravana

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index d810529ebfb6e..ec7eac6b595f7 100644
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

