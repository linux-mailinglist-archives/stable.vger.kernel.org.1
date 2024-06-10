Return-Path: <stable+bounces-50068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC5901B52
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 08:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6892DB24B49
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A73B29D;
	Mon, 10 Jun 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzxZZ57S"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD1364A4;
	Mon, 10 Jun 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001204; cv=none; b=aSel6FWM09BqQYc0PF3u63TRFyUPwwPSTuziW9NMPPnSobwBkaTQ/TSaujqdcsy5s9n08BfWdiP8g9tjUBsbfKGF/mbyBsP9Ep6aTa8x23wEBDFo/Y94kNeb7HQgptgd17P1WzAluFfQkwgvPM3ZhlD64LEJZXkEPn1nPnx3iUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001204; c=relaxed/simple;
	bh=uLyGZd04XBxnLbXgp3VhdQscMg9GAlkmWTN8arnq1UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7UAg+Kc0zHpoxyo3yomVToSbIVAdgL1kUddTS2wihFlvT5AGuzZrPWICZtXJ0ZaIjjcMBbWsfcOZ+SpsMHguY4JGygFDfrnr35cCL4llaT5buCwbd70LUDG4HWJNXeCvwfaunQ9V7ICYZZPrAR5Zsu0ruUmu+6JhAHMFEiqD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzxZZ57S; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4eb1b9865e4so1334308e0c.1;
        Sun, 09 Jun 2024 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718001202; x=1718606002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoxL7sxR5fVE2wpf25zkRX1keP/l47DLSwfYmo+1E88=;
        b=JzxZZ57SZmLC50L63F2s4UPOj7xYTp8DSsg1mG2j/a3eUT8RT8Um1o9UIK965bI5Wu
         HxY0bEP9f5HKv7oF0eg1qVU8gauAVGHooZGBSC7xUjjoyS7RC+o1Dw4jbHGovfaAlWYW
         pg2FYrUTtfnMIkZwPYD0GDgXC3pNFUh3NonoigEQVyUX3bDz8Fpw3FujOqvEcwjEp580
         tgIx0P6IJ5WWBO4FkrdcPia8pLYOxaVVrNA75dC5aGjS8xdqP0/PSRacV1A9MFumAWFN
         qEV+mUnu0mmyEwV7xky83K8swBfoq+Jz/pHM04L/RG3cCr+V+8vXiXUUFxhX8sXEdLd5
         yP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718001202; x=1718606002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoxL7sxR5fVE2wpf25zkRX1keP/l47DLSwfYmo+1E88=;
        b=Tvu4DyVBz8s6O4UB6/54MBPb+gfDIqi+sKZP81kdNLmaqNF8JUCrByFOd4s9Pi+Qm4
         a+DVFTwuUlndEhOmrIVw217V1MgMhabNmNwKt+wq/uJQcVQWTkIn1BXLrYqClx+0YjkA
         2OTQhokJ5NDhEo5L8jkMBAYCKrpHhltVfEVVWeWZeylIzlCw/ENU2fcr8VSITRsh387P
         WN9ciIwsJ+NueY2wiTn1ViOMpEiDUawzAM0vgUs200A24y5k3HGbKuAoVGoU1k8QTzxs
         UYBzZsuxY+KQAypj6A+UWyjcAATNDW+hdKwhSCH9nG/ZfSyuHjE3lD1pltJkQJULfFxR
         48yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3WYYrnXH4CbApn9okcCPBEITa6SVO2/uADB8tlLiONyNW10NO1eHDyY80WgONQED6n/vrWrbjF1IQaIZ67gEsT+ulOwNW0NRZdvTm5Uy/TumjmKGRhizMhCx6PpoxJOQi5WvHDXNYmgA=
X-Gm-Message-State: AOJu0YyBw6Le5RMMLX5SxfCMwvp1O3/BrWzSvn9si8qrlkaEXOgPjMDW
	cxFwkkv671sBYw5XMmasgTROJ/71+JubLkyQhIHIz1vbUdb+dLAmt0TE+QtbcIPvmRD8k9Totwb
	j3T1of7CPT/yrZe6Tz/3yT47xz6I=
X-Google-Smtp-Source: AGHT+IE6WwuGJf/J6Plpzhz9jA+n7W7A3UHb9PzPwtd8XmJu4EiIUfbwUKnVPUxp+1oRqDCPDYvJIUTzr/73LsCncVM=
X-Received: by 2002:a05:6122:c9:b0:4e4:ea87:ec72 with SMTP id
 71dfb90a1353d-4eb562bbb38mr6632138e0c.11.1718001202243; Sun, 09 Jun 2024
 23:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530100154.317683-1-jani.nikula@intel.com>
In-Reply-To: <20240530100154.317683-1-jani.nikula@intel.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 10 Jun 2024 15:32:45 +0900
Message-ID: <CAAQKjZPWT7=JircaiksP3Wg_1oKRr1xDkznQ1RSoe4jmn12fUw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/exynos/vidi: fix memory leak in .get_modes()
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, sw0312.kim@samsung.com, 
	kyungmin.park@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani Nikula,

The patch(1/4) has been applied to the -fixes branch, and the other
three patches(2/4 ~ 4/4) have been applied to the -next branch.

Thanks,
Inki Dae

2024=EB=85=84 5=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:02, J=
ani Nikula <jani.nikula@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The duplicated EDID is never freed. Fix it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/e=
xynos/exynos_drm_vidi.c
> index fab135308b70..11a720fef32b 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -309,6 +309,7 @@ static int vidi_get_modes(struct drm_connector *conne=
ctor)
>         struct vidi_context *ctx =3D ctx_from_connector(connector);
>         struct edid *edid;
>         int edid_len;
> +       int count;
>
>         /*
>          * the edid data comes from user side and it would be set
> @@ -328,7 +329,11 @@ static int vidi_get_modes(struct drm_connector *conn=
ector)
>
>         drm_connector_update_edid_property(connector, edid);
>
> -       return drm_add_edid_modes(connector, edid);
> +       count =3D drm_add_edid_modes(connector, edid);
> +
> +       kfree(edid);
> +
> +       return count;
>  }
>
>  static const struct drm_connector_helper_funcs vidi_connector_helper_fun=
cs =3D {
> --
> 2.39.2
>
>

