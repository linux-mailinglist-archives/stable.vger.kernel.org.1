Return-Path: <stable+bounces-41498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887128B3229
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492AA281880
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389A113C8F0;
	Fri, 26 Apr 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HeNgMy2e"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9113C8F4
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119571; cv=none; b=EdoaQKD+WbsbXoIOEwCyBQNYCF361nMIkhDxlqUj4owicsyoFGYJEJY25I7N1UtCzlQxnWS0gzs3c4uRhH9kxZJFcuJSr8AWNL/mhdNqmdABZ11Zz/IxNzNHiXqPF3nDULNFdLhWt9sgE06x6DbqWQD3Z37pnbeW7voJk9KdA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119571; c=relaxed/simple;
	bh=g2ptlNEGOqFTjLQCVUzdfm91hafdN8NQDpmWgp96AiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHdx/CWJk0mrca+aRkMzsRCh6RdFFZOZ8hNuaC65y9FjSDXDdvkhI+8WlZUdfytz2E84rYAtDXqZwerEgY1xoVcgjw1L2cV02K0T6Jb4Eb6yAV5Z3C8UTk1WGUVFCpxoUdo0v+iS/u8jGjuYAXz0ZoaCZ9t7JhohXHDSubm5Jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HeNgMy2e; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36b1774e453so6338925ab.1
        for <stable@vger.kernel.org>; Fri, 26 Apr 2024 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714119568; x=1714724368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVTNWL0BuMu8uA8a1pgzyKd4N6HpuLQOL7QqW6GZ6D0=;
        b=HeNgMy2einfYEALcQ4Tz0c5tvx7JhZDFFDF5VIO5EBGxQmUvNBdXj9F/f84P2Y8W0e
         CySZXG2yXMQ2LKbZmL+8JXdemv1JPfS45c5bx/QBDoJUnKAmTFsT+QEFNeE6U11XK3yx
         8V9LO3sdEYRvYLjP1nhncGrfjgpSzDtd1gOOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119568; x=1714724368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVTNWL0BuMu8uA8a1pgzyKd4N6HpuLQOL7QqW6GZ6D0=;
        b=rC/VpPCrcQNux+nTGXYkXG6DtDt6BYslk4BDwwsOy89fReh655Z+5mu+YLITL+OWpz
         M8wgaV3b+v8chb/arPnqkzhPEgCbwzSdNcSEEsE3xbDIHtpdpFqBkrDoQhP6Jl3/wQD5
         MZhsu0ydjAFNK2evZStoH4lrK15XILZocnFFxpNdgKCJSXNzerLfVlEwjUzqicP2gFUi
         PQycU5hrMt52fKS2X1YJ+48iSlOuRbeVCiaV3XOAPSRNH3MvUy5eonp4+zKC418kV0ax
         YjKTIMREysKgKHmL0NpBldUxX14aJlnqGh8h4Xtdf/BrcwLsZg/AOL85oz4MY0KdIIYv
         KQaw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbFvZIorNUnWeDogIfc4JLzncR6LHaRR4jPbqdK9HriyqbH+ZUt6sBxYioUhnRXQes0UNYz0ZG3JTXzw4L56cfntHYV/H
X-Gm-Message-State: AOJu0YwqY16bl3FD+SCT5CGSKDNEe3Y/ZHGQt4BcrcAqm5BPk7pk4kok
	lGX0VwmzAJwcCIoxJ17mCtdHfQzisSltJiL0XuXHE8wZ2LInSUuuLkNjHm5k/mB+7wVPk9Af65+
	2ctHxBoSfSyTv0YmFPr3klS/hHxihu9OPKNBg
X-Google-Smtp-Source: AGHT+IH66STbBXSU8C3ldVui5J0UyWaCbJ6riDX7win3IEC0TBhjCR4f79MirfLPReAHHSS0djaP5B3ccQpC2bLbfX4=
X-Received: by 2002:a92:cda6:0:b0:36b:85e:7cdb with SMTP id
 g6-20020a92cda6000000b0036b085e7cdbmr2283627ild.28.1714119568457; Fri, 26 Apr
 2024 01:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425200700.24403-1-ian.forbes@broadcom.com>
In-Reply-To: <20240425200700.24403-1-ian.forbes@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Fri, 26 Apr 2024 11:19:17 +0300
Message-ID: <CAKLwHdXmzEcHUDqCoK_6eMP8WFJm4ZQA8k3F4EW-_Ci11gfeuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix Legacy Display Unit
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	zack.rusin@broadcom.com, maaz.mombasawala@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

On Thu, Apr 25, 2024 at 11:07=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.co=
m> wrote:
>
> Legacy DU was broken by the referenced fixes commit because the placement
> and the busy_placement no longer pointed to the same object. This was lat=
er
> fixed indirectly by commit a78a8da51b36c7a0c0c16233f91d60aac03a5a49
> ("drm/ttm: replace busy placement with flags v6") in v6.9.
>
> Fixes: 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> Cc: <stable@vger.kernel.org> # v6.4+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 2bfac3aad7b7..98e73eb0ccf1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -204,6 +204,7 @@ int vmw_bo_pin_in_start_of_vram(struct vmw_private *d=
ev_priv,
>                              VMW_BO_DOMAIN_VRAM,
>                              VMW_BO_DOMAIN_VRAM);
>         buf->places[0].lpfn =3D PFN_UP(bo->resource->size);
> +       buf->busy_places[0].lpfn =3D PFN_UP(bo->resource->size);
>         ret =3D ttm_bo_validate(bo, &buf->placement, &ctx);
>
>         /* For some reason we didn't end up at the start of vram */
> --
> 2.34.1
>

