Return-Path: <stable+bounces-169834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B24B288DC
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 01:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B505AC7487
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6643285CA3;
	Fri, 15 Aug 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXlAoaa6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6826E6FF;
	Fri, 15 Aug 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301177; cv=none; b=uTtJKGrSXYAv7RzQgCD7BwtwFTE0Vle1eRbOdw0kItxKSzXn4JrRFMJOslGqUoIsXLmccAJ3sJcFs40i0M7ZNjvZtt2sgMT2S6UNA/U95SL1nDpY7+veaIUW+r6p4S0PH3duChROibqnXlTQRNIXPo5a5/0jFTF0GYckZLJL7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301177; c=relaxed/simple;
	bh=wwsSHz9qW4HM4CvVm/6W9nFKkjnMGwSQT3gsML0+kno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5Kv+8htSCAFw4ppIkrGjUkygQ1SdRPZuaQaggkdCeLSiHZawsQZXGiULJZearFKhMF4a/fYQMsJ6RJ2VTz9/dRAjyyNkqHg3i9BnUveNcgjyXQRkbsCpihjRlx9jJMFHVku8WKNoEsGlPHr5APZbRJ+SnZf+DwXLHC8N3MhcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXlAoaa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD5EC4CEF5;
	Fri, 15 Aug 2025 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301175;
	bh=wwsSHz9qW4HM4CvVm/6W9nFKkjnMGwSQT3gsML0+kno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fXlAoaa6w8xqcofARSS/N8y05yEbcphTUhiWFoaMVITF4PxyPC6AYCZASz2KFEx8s
	 ZLlYPVHeFJSrwgNX0JP4fE6QdLc89NfU0NWS+ibkoliEcEC0/qxm0jVMd32aVVayq8
	 WXrVqsrk29ADEKvaUuJUSs02DPL80IBbM1K6hG9mfmP8qGrFQGHrQZN33BvFZFEiA1
	 lHLqyyTJqj6GXhbvxpC8xTOlUvrugsnAnxh3b/adhETv08buY733krSHpYLFsZ80Wl
	 H2ITKOpmeIJXOqqlws+6QXeqvN1n/GztLeK9zrIGLZK1xRaP2KpyaDDC+Dgu4NgRYc
	 JYaUjnuUbvlrQ==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174c8e45so2140180a12.2;
        Fri, 15 Aug 2025 16:39:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2OSnrCvwOpuF0a5H4csD8+IuqibLdlZ05ke2kanWLk+/g5SCLeZ76eZR0Dljmmfhusi+rueWGq2y9wrc=@vger.kernel.org, AJvYcCVRwJw3iEYNGBZbl/o74kbgGw5s33KL22kgh0d64Xm7ta+9sY1OocSy2EKzURVDh1TNzuOT33Om@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SZHAaYZ2k3YN30I4eVYlTGHRkiGidmhruWW7pvr/HWDxSxVH
	iLHFIuWxm/XJSYD6skEw1TvKm3bJzRw/iDHNWXYeh8kYqvMgYV8dbfEkWcD8FAA14QVh5PD6Mvc
	vRKgxC46630rA06TKmKTzj37c7fkiyg==
X-Google-Smtp-Source: AGHT+IF3UhjPzI/NY7tWC6HSMCDlAaXInyJ/IGmu2yTEf5VazKwog6umahYLBkhkXktfxZh67B39CKu2Ii3gsJIura0=
X-Received: by 2002:a17:903:b87:b0:240:80f:228e with SMTP id
 d9443c01a7336-2446d93d8dbmr54840315ad.52.1755301174432; Fri, 15 Aug 2025
 16:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812071932.471730-1-make24@iscas.ac.cn>
In-Reply-To: <20250812071932.471730-1-make24@iscas.ac.cn>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sat, 16 Aug 2025 07:40:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_91C=5YDk1qcU3Dir6TqtN17kgjzTzr=XYRNPHGvQwSgA@mail.gmail.com>
X-Gm-Features: Ac12FXzKVkel4FRxgngT7H7BLJAi1wo2-ssfsabNu9COZ3np_6DfRlSEuXQhYKk
Message-ID: <CAAOTY_91C=5YDk1qcU3Dir6TqtN17kgjzTzr=XYRNPHGvQwSgA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv
To: Ma Ke <make24@iscas.ac.cn>
Cc: ck.hu@mediatek.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, simona@ffwll.ch, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, nancy.lin@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ma Ke <make24@iscas.ac.cn> =E6=96=BC 2025=E5=B9=B48=E6=9C=8812=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Using device_find_child() and of_find_device_by_node() to locate
> devices could cause an imbalance in the device's reference count.
> device_find_child() and of_find_device_by_node() both call
> get_device() to increment the reference count of the found device
> before returning the pointer. In mtk_drm_get_all_drm_priv(), these
> references are never released through put_device(), resulting in
> permanent reference count increments. Additionally, the
> for_each_child_of_node() iterator fails to release node references in
> all code paths. This leaks device node references when loop
> termination occurs before reaching MAX_CRTC. These reference count
> leaks may prevent device/node resources from being properly released
> during driver unbind operations.
>
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
>
> Found by code review.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Cc: stable@vger.kernel.org
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi =
mmsys support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added goto labels as suggestions.
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index d5e6bab36414..f8a817689e16 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -387,19 +387,19 @@ static bool mtk_drm_get_all_drm_priv(struct device =
*dev)
>
>                 of_id =3D of_match_node(mtk_drm_of_ids, node);
>                 if (!of_id)
> -                       continue;
> +                       goto next_put_node;
>
>                 pdev =3D of_find_device_by_node(node);
>                 if (!pdev)
> -                       continue;
> +                       goto next_put_node;
>
>                 drm_dev =3D device_find_child(&pdev->dev, NULL, mtk_drm_m=
atch);
>                 if (!drm_dev)
> -                       continue;
> +                       goto next_put_device_pdev_dev;
>
>                 temp_drm_priv =3D dev_get_drvdata(drm_dev);
>                 if (!temp_drm_priv)
> -                       continue;
> +                       goto next_put_device_drm_dev;
>
>                 if (temp_drm_priv->data->main_len)
>                         all_drm_priv[CRTC_MAIN] =3D temp_drm_priv;
> @@ -411,10 +411,17 @@ static bool mtk_drm_get_all_drm_priv(struct device =
*dev)
>                 if (temp_drm_priv->mtk_drm_bound)
>                         cnt++;
>
> -               if (cnt =3D=3D MAX_CRTC) {
> -                       of_node_put(node);
> +next_put_device_drm_dev:
> +               put_device(drm_dev);
> +
> +next_put_device_pdev_dev:
> +               put_device(&pdev->dev);
> +
> +next_put_node:
> +               of_node_put(node);
> +
> +               if (cnt =3D=3D MAX_CRTC)
>                         break;
> -               }
>         }
>
>         if (drm_priv->data->mmsys_dev_num =3D=3D cnt) {
> --
> 2.25.1
>

