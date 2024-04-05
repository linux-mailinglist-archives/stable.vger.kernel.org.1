Return-Path: <stable+bounces-36151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B489A486
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5F0B23965
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504C1607AF;
	Fri,  5 Apr 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bxBJJN1O"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585F172794
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343756; cv=none; b=I88NMvOyFrR+tITeAk8aA3krGiUF4fdcfrRXhVVpoUIJ1r6IIWq0M4QgjQLHXaxLmh8BaWIfyrjtqv/7g88lVeaw75CRpqznkGzOehaTxQFWcz3YB6acfdo84/gJ6tSaV4GaTsC9TW2r5z5MrtpUCC1Cu+AvhuF4r7H5pdbxfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343756; c=relaxed/simple;
	bh=mDcjI/D7KGhfWVDc8ESGO7+wqabJ1W1wj+ZXAv8ENtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTzp1BZfjDOkMK9nqSj5muIuHZC27SXbaEhZokhTTF7/tdpfi6W+pVHX5mibUk0bHNGQuIBVN9p8cvZefQR6Ao3H9+DxRBnc8cy4RIIDqeYW84rYwWHbC1FuQV1gxHO5XT7JjmfMdJycPQg3lSfmXNFmYech1mFM6hWvEgWGizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bxBJJN1O; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6156483284fso27632887b3.0
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712343754; x=1712948554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+9F5O8eIKV+7UGcG+VUym1A0vGBsTshQ13opkTXvdA=;
        b=bxBJJN1OjWvX6vawNsIVkyQgLrokI2vAIMpCzs8hwsolzTlUi3UQx7D6pcNu0yYP9D
         RTVjduziMf4bI0umPD7UC9M2ETVGtYgdwBws2/+to7R9ZrnjG9OXByg3rWIK/2XJpipN
         UsQ3JLA2qLkFEbxClpvhNkcyVvTyL6aWEw7yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343754; x=1712948554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+9F5O8eIKV+7UGcG+VUym1A0vGBsTshQ13opkTXvdA=;
        b=hjuRZp0z4J8z8+HxX0WFu/60JN3XDGWKDnqWwDLG+MqYOS0Mwoy056K4SjthQsnctQ
         P16zi/e3hQ82dIZ0IxHDB9xxYWf7zUvcLvAVHGnFl8WielzHgeFExLzr/RGK5G1UvMZI
         4g3NJYYA5axkYK9AmRKHFB6J2faFVj7seJNJI13VsmAeaxauXj3YmaHYz9cpKOuSyKTI
         MBDh6llUEkqYXHQwdhWqkxeuVGsRhI2TWrfPxjVqI44myU9T5h37mU3Vczs73WGhV9hF
         DRUJth5ac6lJI5gC9k9oKPvMI+pVc+GpOfUDslNVdYodnoDEfHB3lMe66s9wCmpD6GtO
         n/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH2fVrhXPhPRHDJBwBcj37GHH5QfIGtZv07aoWVCSJJ/aIx7HrPhCXLye4QqlgE3nTlkziUU7zniwPl4jjxf1IKwmnKAdT
X-Gm-Message-State: AOJu0YymBm4M39VntxVbrXIswX3VfZNePi21dbddj48QDyS1CgWyI8Y6
	3j4YXUkgLmjpJjUGi/v/9sEEqNLG0CLnp5ZT3BauiM7RlYVHPE/2jxSdyYF585hbsXs3JYb6aY0
	kfn82lMhQslfQ2mrlbA3aexLiKkv4IyQSHsHx
X-Google-Smtp-Source: AGHT+IGD1q3YYuPont2fXr2FhDUReli6hVBqnrTA5X+DWnj57jYGh6Kk36EUxXxCC2IMV/sycWLTuEazqirLbZUNX3c=
X-Received: by 2002:a81:5c87:0:b0:615:184d:275 with SMTP id
 q129-20020a815c87000000b00615184d0275mr1889977ywb.47.1712343754017; Fri, 05
 Apr 2024 12:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402232813.2670131-1-zack.rusin@broadcom.com> <20240402232813.2670131-5-zack.rusin@broadcom.com>
In-Reply-To: <20240402232813.2670131-5-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Fri, 5 Apr 2024 14:02:25 -0500
Message-ID: <CAO6MGti8duxr3AqWnRCuv2igR=PN4NxoaGnErPxr5hpZzLctEw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/vmwgfx: Fix crtc's atomic check conditional
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Makes sense.

Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>

On Tue, Apr 2, 2024 at 6:28=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> The conditional was supposed to prevent enabling of a crtc state
> without a set primary plane. Accidently it also prevented disabling
> crtc state with a set primary plane. Neither is correct.
>
> Fix the conditional and just driver-warn when a crtc state has been
> enabled without a primary plane which will help debug broken userspace.
>
> Fixes IGT's kms_atomic_interruptible and kms_atomic_transition tests.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 06ec41909e31 ("drm/vmwgfx: Add and connect CRTC helper functions")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.12+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index e33e5993d8fc..13b2820cae51 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -931,6 +931,7 @@ int vmw_du_cursor_plane_atomic_check(struct drm_plane=
 *plane,
>  int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
>                              struct drm_atomic_state *state)
>  {
> +       struct vmw_private *vmw =3D vmw_priv(crtc->dev);
>         struct drm_crtc_state *new_state =3D drm_atomic_get_new_crtc_stat=
e(state,
>                                                                          =
crtc);
>         struct vmw_display_unit *du =3D vmw_crtc_to_du(new_state->crtc);
> @@ -938,9 +939,13 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
>         bool has_primary =3D new_state->plane_mask &
>                            drm_plane_mask(crtc->primary);
>
> -       /* We always want to have an active plane with an active CRTC */
> -       if (has_primary !=3D new_state->enable)
> -               return -EINVAL;
> +       /*
> +        * This is fine in general, but broken userspace might expect
> +        * some actual rendering so give a clue as why it's blank.
> +        */
> +       if (new_state->enable && !has_primary)
> +               drm_dbg_driver(&vmw->drm,
> +                              "CRTC without a primary plane will be blan=
k.\n");
>
>
>         if (new_state->connector_mask !=3D connector_mask &&
> --
> 2.40.1
>

