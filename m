Return-Path: <stable+bounces-37861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8589D89A
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 13:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66311286319
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600F128826;
	Tue,  9 Apr 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g0qO9pre"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231642053
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663822; cv=none; b=lBB5XT6fW2Vdanlxvn9AkYI1erN3pwk1fUIsvDpVUyiSfAtBj37SmejFj7HI9vjOJY/Qz8LaOc587uWAweAu4jVTtiCICHzRLxg1bv/dW5dCfCCpET58uTbKTF5VTiZFqI3aute/ndiTvgLnBvv3wyHBF5NkEeAqt78orZM7bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663822; c=relaxed/simple;
	bh=BMyHz9lMrtU6g3gre9pjiuAZXWqRIYfT4Q9Rp6YAScY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwhZR4GqsV6P1KFjD7C0xDsu47cZ44g9NP2oLyZDFXuT8+eEmTgNQ1iBPRqPBOHyD10LJOqaMQcWnOVaiQUXz8znlSeogTXwvB25GhirzB+56AMT+7S9iupahnQ78uVTsxqKd6hwtuBjS+0jIQZgOG1YAR9By10Giqlim3HUeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g0qO9pre; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6230233f9so14337539f.2
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712663819; x=1713268619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+sFwXoYlvmaRLKdHU2OL3LD5t7Xm+RlcJkwNqyQM6E=;
        b=g0qO9premgqK6R0qnTuI9RdQt9qP2azANWBEDCwS0u9UpYkwQk4rJTEfPSu/ZlJeEJ
         g23+0c4eo8fEizeqtyg2ahIw6ReO/T2Gk6PPCGmvd+9EXhI029RPGul6/+SxO+aBC5wJ
         lUC/hHqiIXpnxm7xax/C52iPBV0MJZMViSGN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712663819; x=1713268619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+sFwXoYlvmaRLKdHU2OL3LD5t7Xm+RlcJkwNqyQM6E=;
        b=fxJDyyfVBMOdpzPU5Jhnv1Q0PgqcNqoNpx01lFY+uXLzFVO3e9gRGZ/CKhfiJDZdB6
         QxMm/9nwnCeq4TmWE340K0qppa7y6+btubXpZlehgHLCsB8y+o3BWGhQwoOy0qeQSQc9
         6X9hQqCxF7E/25aVqMj4A7OrYkgFrLSxQQ7PXumX6RQC/V/YawV/b/chcCfVwK0se8Lt
         OwqKNXhOKocApKr2DtQeZfZ7uaRtKNgLK+disJ+LBiwMUxkpbzzxP8xe8XkUkWGYVfPb
         lCDBpD9FmXhgdPYwPsVbFRA1WTCaeiuq/DScvfPOX28VK7jlETD4QfXRoiN0K6Z7lTuw
         kcuA==
X-Forwarded-Encrypted: i=1; AJvYcCWVNyJ8JTvdS/UtRjNBLjPtmRF7FvoMVppvdmPbvTHB5uj8xUceW23RlbhXimKjsNOdPuzTjCmobpa8dZu5ojTy/gsZl+Bv
X-Gm-Message-State: AOJu0Yx4adY36Y0f96mIrWs3kMRfBdShvUKarfSR4OjDUwmaKMjiA2k+
	NjRYXXaXN2IXSCnvqOBF49mxuFDqbYiYmaH+swVRiyMRaASoqg+6msQVUjWXek+UTS9hjIvXoAJ
	0Xaen0oinliMWyXkWQOb4eP9TD6KEYyi3+aFs
X-Google-Smtp-Source: AGHT+IFvIS8zDpgMDAGoXg7iiAGympjAvHb7hn6f+MJNaHDU7uc/jMvy5XAao/Ems5jMBEJEP23RHiuUh6azxOBbuXc=
X-Received: by 2002:a05:6602:c8c:b0:7d5:efd9:3c87 with SMTP id
 fp12-20020a0566020c8c00b007d5efd93c87mr4700135iob.5.1712663819589; Tue, 09
 Apr 2024 04:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408022802.358641-1-zack.rusin@broadcom.com>
In-Reply-To: <20240408022802.358641-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Tue, 9 Apr 2024 14:56:48 +0300
Message-ID: <CAKLwHdU8cv8sBQN0PYG-2w7RnE0CF_AyGnZEV+kJFOABoUb_UA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Enable DMA mappings with SEV
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, Ye Li <ye.li@broadcom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:28=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> Enable DMA mappings in vmwgfx after TTM has been fixed in commit
> 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for page-based iome=
m")
>
> This enables full guest-backed memory support and in particular allows
> usage of screen targets as the presentation mechanism.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Reported-by: Ye Li <ye.li@broadcom.com>
> Tested-by: Ye Li <ye.li@broadcom.com>
> Fixes: 3b0d6458c705 ("drm/vmwgfx: Refuse DMA operation when SEV encryptio=
n is active")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.6+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 41ad13e45554..bdad93864b98 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -667,11 +667,12 @@ static int vmw_dma_select_mode(struct vmw_private *=
dev_priv)
>                 [vmw_dma_map_populate] =3D "Caching DMA mappings.",
>                 [vmw_dma_map_bind] =3D "Giving up DMA mappings early."};
>
> -       /* TTM currently doesn't fully support SEV encryption. */
> -       if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -               return -EINVAL;
> -
> -       if (vmw_force_coherent)
> +       /*
> +        * When running with SEV we always want dma mappings, because
> +        * otherwise ttm tt pool pages will bounce through swiotlb runnin=
g
> +        * out of available space.
> +        */
> +       if (vmw_force_coherent || cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>                 dev_priv->map_mode =3D vmw_dma_alloc_coherent;
>         else if (vmw_restrict_iommu)
>                 dev_priv->map_mode =3D vmw_dma_map_bind;
> --
> 2.40.1


LGTM!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

