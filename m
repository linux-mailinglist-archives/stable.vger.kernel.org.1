Return-Path: <stable+bounces-16072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A35283EC7E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D622F1C2162B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1901D6A7;
	Sat, 27 Jan 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JJtuL0AN"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085C1EB21
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349391; cv=none; b=R9qvbTa0vzEr8qiJol2tWrFwTF24vejdELOr7p9ZNIc8ZB2JOLM7B+51X/f+KX1StMmiJXjm0f+Hpxpmk7+pN5FrvhCizzM0MtLOPGbCDPNGAtPwBPJyBSZ0SqVUNcLGGC8SQ8zUWImKr74pGOO/MzPsr1Mr603sO0I8bebri/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349391; c=relaxed/simple;
	bh=Oie2+TfF1yYK2CkmkR/XaDqVOaLL7JcTG6rPC0MooKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+a54j3H5N3mX1ZJJ/XAb1lVWbLnovfYd7q8X0JfLrDkALZQV3bliXiPTMxqIxo5yjgdlL0Q6xCvr1QD9hibIiGFgyVfH1EzT6U1Y9WUEsYoXPb5f918sbqRli6hClz7vJxGqs0TmHnv0sDsQLZzq7fhTMcRoVRt6SlEdncXxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JJtuL0AN; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bfd526514bso11993539f.0
        for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706349388; x=1706954188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gALc3iFTz0zaU6GiwjaH5CXFj7sL0Sl/fQeT+WtwOLs=;
        b=JJtuL0ANHHEzyMFO2Ep4D0ajRRdW4YH8gNxbkOS9HtuyDf0U4dImgArINLwtr87P4n
         6K2kIqzT6LYx8Zfh8mSq80sFcMhU5Jzls/BGaoMg+6Z68dONpShdI7QADBYO7s3bv6tH
         B0ZHiB/cVIULMZQgxrbt8QftTgyL1uEdcD710=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706349388; x=1706954188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gALc3iFTz0zaU6GiwjaH5CXFj7sL0Sl/fQeT+WtwOLs=;
        b=WhjE932zFzmBus667Oa/i9WkiV0yR2/kGTLyDO8RQ7bf9nHNkzqQa716yQd/sP281R
         nXK2d6eB0n9mpOhmUTgYaaA+faQfyAHY+ZyXA+PQVDqamvo4HsA51ZW5no0a4jssRC/p
         VSmTdASqhEoUposMlR2uE2Y/14RR//hy6pP8fXMbuBp7DqauaIVUJNTQjMN3PXt5BVuU
         R2PBzj9jDa1Y25qRAB+UxsWV+oPKI4MWLCS19+P7/SMO/XDmxYffZQQiY8R81O1xPklN
         hr+jbsn2z851cxcSjKShh+CvZLOKcObr9fCOnmyzlcZL6TnJM+jOS0/g1QxVe7pkWAF+
         xHWg==
X-Gm-Message-State: AOJu0YydHcFeCz+Z6Njy8JIFXhvI/5PNFMjsFjg2JWsmijTDQbzTLmJb
	K2BO/VcCozz4zZNtj1oFhNbAKtlvQ6D1q/TL3sk/XH4ZM/hrNBoLTv55W/gC8F5GyyMmXCbOuwk
	F9fj/ZIhg8S70Wa6yTTXAM08V/uBUFahONT+A
X-Google-Smtp-Source: AGHT+IHbc2akVZAWdd8uY23TsD67K0/Ci1UiRhdeUK37XtFLfwjInBi5Im/KjkUx3UPvjKwEzAoXNl2yuoCQoKBDmQM=
X-Received: by 2002:a05:6e02:1e0b:b0:35f:bea3:bd00 with SMTP id
 g11-20020a056e021e0b00b0035fbea3bd00mr2533508ila.14.1706349388466; Sat, 27
 Jan 2024 01:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126200804.732454-1-zack.rusin@broadcom.com> <20240126200804.732454-6-zack.rusin@broadcom.com>
In-Reply-To: <20240126200804.732454-6-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Sat, 27 Jan 2024 11:56:17 +0200
Message-ID: <CAKLwHdW=fYgkU5kq=v7DBuMyxVwXZF7oTuA3D1VBZ=w3OHPpfQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/vmwgfx: Fix the lifetime of the bo cursor memory
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:08=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> The cleanup can be dispatched while the atomic update is still active,
> which means that the memory acquired in the atomic update needs to
> not be invalidated by the cleanup. The buffer objects in vmw_plane_state
> instead of using the builtin map_and_cache were trying to handle
> the lifetime of the mapped memory themselves, leading to crashes.
>
> Use the map_and_cache instead of trying to manage the lifetime of the
> buffer objects held by the vmw_plane_state.
>
> Fixes kernel oops'es in IGT's kms_cursor_legacy forked-bo.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: bb6780aa5a1d ("drm/vmwgfx: Diff cursors when using cmds")
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index e2bfaf4522a6..cd4925346ed4 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -185,13 +185,12 @@ static u32 vmw_du_cursor_mob_size(u32 w, u32 h)
>   */
>  static u32 *vmw_du_cursor_plane_acquire_image(struct vmw_plane_state *vp=
s)
>  {
> -       bool is_iomem;
>         if (vps->surf) {
>                 if (vps->surf_mapped)
>                         return vmw_bo_map_and_cache(vps->surf->res.guest_=
memory_bo);
>                 return vps->surf->snooper.image;
>         } else if (vps->bo)
> -               return ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem);
> +               return vmw_bo_map_and_cache(vps->bo);
>         return NULL;
>  }
>
> @@ -653,22 +652,12 @@ vmw_du_cursor_plane_cleanup_fb(struct drm_plane *pl=
ane,
>  {
>         struct vmw_cursor_plane *vcp =3D vmw_plane_to_vcp(plane);
>         struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(old_state)=
;
> -       bool is_iomem;
>
>         if (vps->surf_mapped) {
>                 vmw_bo_unmap(vps->surf->res.guest_memory_bo);
>                 vps->surf_mapped =3D false;
>         }
>
> -       if (vps->bo && ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem)) {
> -               const int ret =3D ttm_bo_reserve(&vps->bo->tbo, true, fal=
se, NULL);
> -
> -               if (likely(ret =3D=3D 0)) {
> -                       ttm_bo_kunmap(&vps->bo->map);
> -                       ttm_bo_unreserve(&vps->bo->tbo);
> -               }
> -       }
> -
>         vmw_du_cursor_plane_unmap_cm(vps);
>         vmw_du_put_cursor_mob(vcp, vps);
>
> --
> 2.40.1
>

LGTM!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

