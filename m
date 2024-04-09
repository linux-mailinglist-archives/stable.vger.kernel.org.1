Return-Path: <stable+bounces-37882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D689DE88
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC01C2084B
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02770130A4F;
	Tue,  9 Apr 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DlX5x66o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F759130A6F
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675545; cv=none; b=k837cy6GCDOw53qNcLjTJ/H9m8E7Dx8o4w66+YaQ52S8zgo4pUOlwu/DRKrHKezWNUls7k0MDKAx9Pk/ZG5GxNQsRznS4/0WzCpBlLViMaz3tBAGI4j4LQGJ0bAOTKPFqPqN5MrHbfLfLogNWECdavBfNzlv0n3HcBfam2/Hlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675545; c=relaxed/simple;
	bh=2yOosKCd1oezWyRCcfAahdXsM8b0FYSs24dKvuMAck0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBvrF9hR3U7odjWdquyoR36ZbT3xYsacXgi01PJJAyyDDy9eRaV5+D02BwK2BA4cGs+8s8OyaAtmi9ALhTmnSR9cV7qxjJaf0zLdWDE+9oH283hDMkrJGpjnwPLF7j3r6bwMs1MNPQq/Zz6MxX0Kugw4QEtdx2YIzzb758AgScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DlX5x66o; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea128e4079so1791134a34.3
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712675543; x=1713280343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkgbrKSauyCf/3PInxYz8jAVnMgt0m3ACMNsW0viOZ8=;
        b=DlX5x66oKjbBSrYCn4dVvTTUVYsTRa5jzGZu54IgEqdUtfC3ISxZamguzuhPItXZme
         sUP5AboucHYIS+7gnwpvHopSeL6XXTlRP7Q0A3kMMxVcylfvC1dz1/MK7t73etyl7RJb
         L+pjoRwoD7Jbocs2XoHcIGNDTjBur1xHuNAug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675543; x=1713280343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkgbrKSauyCf/3PInxYz8jAVnMgt0m3ACMNsW0viOZ8=;
        b=oEKuxJNuYY0/de/XPIKBKWWOPQCsa3xxNGtgeSYBeR4adlbHHtMmUknMhuB1yBapmu
         eQxpYaFAGLFACsOiRTBDNRRzooaSJB+nl2gw3RtIEHk1vtLJDgTGOizbo4wLsBQw1ygo
         XK59Id7gbiNI74n3/n6wasg+wFxHYm0yxmPSg1B4nY+vEFJyVJ8XOIcnVGEGol45LAod
         CdiSq50cEJFdV/btOtFU3mPTeERqSwgXBAWbwP55Wh5UpoC/EAnfx7fkC9QsShZqffo4
         Vam8CBVdgXO+HY6EFXJcj26gubTBR5kQO7IgPxoZhZWobtgCpHTfMRx35zecGQJOSH4i
         68oA==
X-Forwarded-Encrypted: i=1; AJvYcCVB87bV9iwvHZfmKfyklu64qWxaro9LRwcuIAn61EPpHpKlVbkvbYSkaagT/vUS7yUusgClAj2XijlIpBIOpBnK0yyJO4RL
X-Gm-Message-State: AOJu0YzLzIsdDV/cq8oSGYTVPshRSDAef+tOt1wMLuVSQtbsb3FnruHb
	ZCtY8mhPPh5PIH6DSrS9m2gnMaRaVR6Y6PikpPsz9vNgUyz0HBerUmhBHnQa49BkFjkBy7vL8yv
	qeJDtPVfDXRdZ0lWbortPy+cS6nBbwgi9CZ1a
X-Google-Smtp-Source: AGHT+IECKU1EPnNzb6lDQEeMoJ4Wz9rQUce2PyviuJOfmoaRaDNhK6tPPDrV21C7KSRv5dYJyZugNQnzC08W1FGtU3M=
X-Received: by 2002:a05:6808:219:b0:3c5:f87b:684 with SMTP id
 l25-20020a056808021900b003c5f87b0684mr4495529oie.15.1712675543217; Tue, 09
 Apr 2024 08:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402232813.2670131-1-zack.rusin@broadcom.com> <20240402232813.2670131-5-zack.rusin@broadcom.com>
In-Reply-To: <20240402232813.2670131-5-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Tue, 9 Apr 2024 18:12:11 +0300
Message-ID: <CAKLwHdVWS4sVQuoi7MUzZVMQiGniOkAfApbWj__TjL9EJqi4EQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/vmwgfx: Fix crtc's atomic check conditional
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:28=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
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

LGTM!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

