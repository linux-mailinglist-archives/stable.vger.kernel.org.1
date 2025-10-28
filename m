Return-Path: <stable+bounces-191500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5AC154E4
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB34C50800F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0533CEAC;
	Tue, 28 Oct 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKpHJDLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15E33A026
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663513; cv=none; b=SeXhPszhsLBnVUiqMW1OLSsH1FJ1WTiGwf0/m2B/cQPVPuwtz5pvjTIgJjxNv7VZrJJFiNEJX4rmeqS0sm2G9PoCcU0GWq04/M563drOP634B26RpdeN0ACeyabVn/5Ek+unz2obrzJbSnBWwpsAC4HvFqdmxR62t+lBJ/G4lLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663513; c=relaxed/simple;
	bh=fgrnGbqm4nMPYm0YFueCTLn38xVSXMpZjjfyexFg4zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpFoUXze/EXiElJD/SmRL3s5LEBUA1a/isqsIcdO14RyE1Rx03SVoABKGXXMt5v/ksPLajuSC3LUN1Yl8bLA6OJxhifGBrgfwpeVHFOd2ogH9TClRYMjc3hBVPaLMJcFNaNjiwgEmGFo7/2rSTANj+9pLP4/WMJmbrfBu6evsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKpHJDLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C974C4CEFD
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761663512;
	bh=fgrnGbqm4nMPYm0YFueCTLn38xVSXMpZjjfyexFg4zU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fKpHJDLw+LdcON/i87zMt8WeFuLsLOkXCh8EaH+KceiRe9xB3NmNNEipNh06u89Qy
	 AbqjbUQwBsH4cwpPlCHdRBkk9PFn/7DfhwH4wDXKj9w6C1tZEt3y3ZUiJWCH/WFiNw
	 wuRNVHBpYpGjfgPS0713G9KL2KmLK817qGbDZUlo8sOcLtxCp2aLJQGxChIquDiQcy
	 fj2U9lW2HSHWHA2eEH71FCQ37XgLZAwhPofn7BzXS5LFcnE+bQasacaEn/LkVXHexC
	 GPwoVTWQz66mefaw9y9zjwlCNXEP4ixcVgZvMvMMxqtbsTY46dce7rKzABe6widukp
	 ht3DHx+N8Nl9w==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27ee41e074dso63769495ad.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 07:58:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuN7ATwrVHDgEsK7JU3z9hBRobjoySu3jkE9N+lptlxNxxt+VwlkUtzbbDLqNp334BUCn5IuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u/+692wVB+XyjL38blerX0wJsYWrnjUJKZzrl3T0Sf1iKgE7
	s9Ik8qJpBVX8pANJhc8MRVqbUkwbIpPBrEZ2c1jlbt24X7MkCscqdL5mHkCOWZ+QnGzyfZevxup
	OQ65DoSf9Kd4x2GtRNl/KHJECy4ytlQ==
X-Google-Smtp-Source: AGHT+IHme6RPgheMLj6a7fR8+m2u2gZ6x3MVu+ulovS2o0skDQiD/daH6FArZWmguxDIJ5KfNDpOra+vAhdzzjURlKs=
X-Received: by 2002:a17:902:dac4:b0:294:63ea:b570 with SMTP id
 d9443c01a7336-294cb65f622mr46857375ad.48.1761663512099; Tue, 28 Oct 2025
 07:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006093937.27869-1-johan@kernel.org>
In-Reply-To: <20251006093937.27869-1-johan@kernel.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 28 Oct 2025 14:58:18 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9rf948byRD3_cCeXREeLt2jXHL2CZPAEUUvAVgJc3dBA@mail.gmail.com>
X-Gm-Features: AWmQ_bnhgsaxyx7-K3gUASFOVVQcGX3sTjPCy2q_RVuuZkcZXgMfDZNuqSDRMTE
Message-ID: <CAAOTY_9rf948byRD3_cCeXREeLt2jXHL2CZPAEUUvAVgJc3dBA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: fix device use-after-free on unbind
To: Johan Hovold <johan@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	Ma Ke <make24@iscas.ac.cn>, Sjoerd Simons <sjoerd@collabora.com>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johan Hovold <johan@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> A recent change fixed device reference leaks when looking up drm
> platform device driver data during bind() but failed to remove a partial
> fix which had been added by commit 80805b62ea5b ("drm/mediatek: Fix
> kobject put for component sub-drivers").
>
> This results in a reference imbalance on component bind() failures and
> on unbind() which could lead to a user-after-free.
>
> Make sure to only drop the references after retrieving the driver data
> by effectively reverting the previous partial fix.
>
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks=
 in mtk_drm_get_all_drm_priv")
> Reported-by: Sjoerd Simons <sjoerd@collabora.com>
> Link: https://lore.kernel.org/r/20251003-mtk-drm-refcount-v1-1-3b3f2813b0=
db@collabora.com
> Cc: stable@vger.kernel.org
> Cc: Ma Ke <make24@iscas.ac.cn>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 384b0510272c..a94c51a83261 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -686,10 +686,6 @@ static int mtk_drm_bind(struct device *dev)
>         for (i =3D 0; i < private->data->mmsys_dev_num; i++)
>                 private->all_drm_private[i]->drm =3D NULL;
>  err_put_dev:
> -       for (i =3D 0; i < private->data->mmsys_dev_num; i++) {
> -               /* For device_find_child in mtk_drm_get_all_priv() */
> -               put_device(private->all_drm_private[i]->dev);
> -       }
>         put_device(private->mutex_dev);
>         return ret;
>  }
> @@ -697,18 +693,12 @@ static int mtk_drm_bind(struct device *dev)
>  static void mtk_drm_unbind(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
> -       int i;
>
>         /* for multi mmsys dev, unregister drm dev in mmsys master */
>         if (private->drm_master) {
>                 drm_dev_unregister(private->drm);
>                 mtk_drm_kms_deinit(private->drm);
>                 drm_dev_put(private->drm);
> -
> -               for (i =3D 0; i < private->data->mmsys_dev_num; i++) {
> -                       /* For device_find_child in mtk_drm_get_all_priv(=
) */
> -                       put_device(private->all_drm_private[i]->dev);
> -               }
>                 put_device(private->mutex_dev);
>         }
>         private->mtk_drm_bound =3D false;
> --
> 2.49.1
>

