Return-Path: <stable+bounces-183240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7CBB75BE
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9600346939
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1178285CBB;
	Fri,  3 Oct 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="TSsxDRvA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61691D5CE0
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506292; cv=none; b=junXKICI2AB6Fp4QFd6bodYBfamybnfAZgJCQlZP7fRMghdyJKOCceyJu74vo8OYzPhQAqsPmdeQRI+e+HQFDc/vRSgIXgd/7JTwKq8ELBv/V3l/y6/bWu89bVSLg1WJhrujHQRVsaKmY5rO+SgO8Stfs+ASNzGv/b5OBFCDCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506292; c=relaxed/simple;
	bh=Zb7fyuiXcHrGNivhEDyxDjANeqiLLU7pVIdpqSK1jd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7z2KlT/MMSmUkZFo5Y89LKezteGp1Nexv15hc4qdn4I7GEfik6x49zqOphy02AihHUN6ONijURLAV5K0f/ad0m5chkaLIK1JnoG06gzepJnv9bEoeW0EL1to8egXRa82OEGKzbuitsRFOehLQwHQXPpC/ZYZHtsiNcU2SmnNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=TSsxDRvA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4dca66a31f7so33052131cf.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759506289; x=1760111089; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcjsGAtJBDRTbKSc6ZGZGbuEJNUcV2kb0nQ6sHCx+Sk=;
        b=TSsxDRvAuFSugPPdWQiHQaOCyxapN1gxma2art4K8NNb0r5gI0PLUKeeBmNEC/g29X
         P+qL7o+/23b6lFo90qqvTgrvZI2ynRhn4sl5kRW289vD14gXXCa+MO+tLzdfLALabkFq
         JE4eRsY5LTMnzLTBNDy136JyrfsVl4k3K2kNSDiYwVYyUXwJfi5wE8rtNW/E1tuptsWm
         nZzDfDha+02v1UaUfcI65QGkFLc+QQQ4/sgatX4OoMXDmgCDQENc+LRPZfaMBMvMqn6W
         FzO7KyE1n/tPeMwA6TE+3bBpIcbE5UOcV1Epgxc4dmPgsDYMwXHUVBum+C2sWYwC8TEv
         J+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506289; x=1760111089;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcjsGAtJBDRTbKSc6ZGZGbuEJNUcV2kb0nQ6sHCx+Sk=;
        b=lqHQZ3lccQFjwEkw3OOupa2puYZQ6vq0xni+37MGFRjZO7Ygc2rNh6y3sp6ZSUCAnO
         KXYQzghwU1Q53aZUirndnWhQlELLd4jEGfxKTnOVbO7dlrDD2SSSyMZTOyW3L4HljXu6
         gn/fAIiIufFEIphdQxRo2Ku1TdmUl1D2a7gzvDX1brrvlmnttk+4WGFa0c0JDbsCmUqs
         ITAHKI0jWLPz87vBzd9XcO28pGm03QhhHp7msLw9eHzA2XYYwPZVnZltiB8N2QqmrZZa
         xBy+eLIMYLbI6VOxwFl/GKfwld0wb5Es/Ovwixz6vQ/C2Jat6dtSczBcePLL9HnHk452
         tdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+RCHpxgFVQa9cxk26T7pcpi7oG/mPpVsyfVlUFfZ2NgvEtMzHh4SOsICIqYqfKR11Sj/qNGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUc0supPZWPD0pUSMurTi9MSpb2dM9W7nwPk0Cz9GZhiaMUG34
	9PwXNHQ0HWfW9HzFrL+hR1fuqhOetb4HruoIXFE5ZX9pN2hO7WdeJjk9SkxALf/Crus=
X-Gm-Gg: ASbGncszq97exAhWKPnKbLsRI00NMSGc8szv5FKJybPyAuxz72Y9DQdSsPpt4sHhlft
	vw61fm26r7P8vyMSpx++wnqDPm1ojoUhO3hkzKm/luSFuFXyMwaxkMW9BuTvPFYC2SXmq8wnEtW
	BZsAHemjShVgemD1X8tDzj5qrZbmzE/0u2ctoI5sz23RbJ6BzO93YkzwGFueAHFBcdx/AEvSkZP
	q8zskghAF6gq5ynjjU58wwdy+VEcoRpgub/roeK4thom+2d2S5aeeScf/lxAxs9XNwY9PadHJsE
	cQBOFBpW1KEZwh4RSQ0hAWEEfNteDBsstmVzNPDp26M64uSUeOLG+PnefgkShLyPO6pTY7nTD92
	uUzofiUicnAf6ULRIlzVGMS0aIlS/mm6vVYUraIZgMdbSOZjGdVO1hxtN36uif3hEsH9XF1PNgk
	k5Yg==
X-Google-Smtp-Source: AGHT+IG3nggyzp6rBeV7O8SFngJ0q7vh9MKYuGI8B+E0xgcql9QjTelcIZpNtFB3s282izeII55ing==
X-Received: by 2002:a05:622a:343:b0:4b5:e9e3:3c90 with SMTP id d75a77b69052e-4e576a5d586mr46819141cf.9.1759506287912;
        Fri, 03 Oct 2025 08:44:47 -0700 (PDT)
Received: from [192.168.42.140] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55aa44901sm41212601cf.18.2025.10.03.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:44:47 -0700 (PDT)
Message-ID: <e22a74d0298d7318c59841f706f6f731c77241db.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: mtk-mdp: Fix some issues in mtk_mdp_core.c
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <haoxiang_li2024@163.com>, minghsiu.tsai@mediatek.com, 
	houlong.wei@mediatek.com, andrew-ct.chen@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hans.verkuil@cisco.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Fri, 03 Oct 2025 11:44:45 -0400
In-Reply-To: <20250917094045.28789-1-haoxiang_li2024@163.com>
References: <20250917094045.28789-1-haoxiang_li2024@163.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jvh4cueVjwyOExiJXg2C"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-jvh4cueVjwyOExiJXg2C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


Le mercredi 17 septembre 2025 =C3=A0 17:40 +0800, Haoxiang Li a =C3=A9crit=
=C2=A0:
> Add check for the return value of vpu_get_plat_device() to prevent null
> pointer dereference. And vpu_get_plat_device() increases the reference
> count of the returned platform device. Add platform_device_put() to
> prevent reference leak. Also add platform_device_put() in mtk_mdp_remove(=
).

I think we should improve the subject a little. What about ?

  media: mtk-mdp: Fix error handling in probe function


Nicolas

>=20
> Add mtk_mdp_unregister_m2m_device() on the error handling path.
>=20
> Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add check for vpu_get_plat_device()
> - Add platform_device_put() in mtk_mdp_remove()
> - Add mtk_mdp_unregister_m2m_device() on the error handling path.
> - Modify the patch title and description. I think you are right.
> =C2=A0 Thanks, CJ!
> ---
> =C2=A0.../media/platform/mediatek/mdp/mtk_mdp_core.c=C2=A0 | 17 +++++++++=
++++++--
> =C2=A01 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> index 80fdc6ff57e0..8432833814f3 100644
> --- a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> +++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> @@ -194,11 +194,17 @@ static int mtk_mdp_probe(struct platform_device *pd=
ev)
> =C2=A0	}
> =C2=A0
> =C2=A0	mdp->vpu_dev =3D vpu_get_plat_device(pdev);
> +	if (!mdp->vpu_dev) {
> +		dev_err(&pdev->dev, "Failed to get vpu device\n");
> +		ret =3D -ENODEV;
> +		goto err_vpu_get_dev;
> +	}
> +
> =C2=A0	ret =3D vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, m=
dp,
> =C2=A0				=C2=A0 VPU_RST_MDP);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&pdev->dev, "Failed to register reset handler\n");
> -		goto err_m2m_register;
> +		goto err_reg_handler;
> =C2=A0	}
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, mdp);
> @@ -206,7 +212,7 @@ static int mtk_mdp_probe(struct platform_device *pdev=
)
> =C2=A0	ret =3D vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(3=
2));
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
> -		goto err_m2m_register;
> +		goto err_reg_handler;
> =C2=A0	}
> =C2=A0
> =C2=A0	pm_runtime_enable(dev);
> @@ -214,6 +220,12 @@ static int mtk_mdp_probe(struct platform_device *pde=
v)
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> +err_reg_handler:
> +	platform_device_put(mdp->vpu_dev);
> +
> +err_vpu_get_dev:
> +	mtk_mdp_unregister_m2m_device(mdp);
> +
> =C2=A0err_m2m_register:
> =C2=A0	v4l2_device_unregister(&mdp->v4l2_dev);
> =C2=A0
> @@ -242,6 +254,7 @@ static void mtk_mdp_remove(struct platform_device *pd=
ev)
> =C2=A0
> =C2=A0	pm_runtime_disable(&pdev->dev);
> =C2=A0	vb2_dma_contig_clear_max_seg_size(&pdev->dev);
> +	platform_device_put(mdp->vpu_dev);
> =C2=A0	mtk_mdp_unregister_m2m_device(mdp);
> =C2=A0	v4l2_device_unregister(&mdp->v4l2_dev);
> =C2=A0

--=-jvh4cueVjwyOExiJXg2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaN/vbQAKCRDZQZRRKWBy
9KWiAP0QJQMSss66nBhuvWdyP3z+yb6Q5jk6MMuOVBfPG9I+XgEAlm/xzfuJ8BPA
DxlLGE1JMwN8N8zLQzYhKhp61WB8XwQ=
=RvA4
-----END PGP SIGNATURE-----

--=-jvh4cueVjwyOExiJXg2C--

