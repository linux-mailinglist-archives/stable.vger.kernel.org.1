Return-Path: <stable+bounces-83390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE899933D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B31B29EE9
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D921CFEDD;
	Thu, 10 Oct 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TwbsnM3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53CC1CBEAB
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589944; cv=none; b=dVz3Sn0mgdVAMCv+efCo/Mp33HJVoVhik+cxkF6NOxwkbtyp7Ku15IEhqPDAoNA4VxnuF9P8wQTloDbn9K6SPQfRhUbwzsLtw7He5dgJt/NWCCJWRg3B3PetMyubvxht1Ahfnv8gaEADZbbJYtRwCvWn8x9wdof36gScuWObQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589944; c=relaxed/simple;
	bh=k1T3SKLXk4xT1EZ+pJJHSjTwS1Rlz/OMeCunvBztblY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHLzW70+LuDMSM0yPeD5A3OuOPXrbaIIX2ykCnoneQRlqzH3C9VnXYU5bokoO63D5ZY69Eo57yTpMsbi1TDdNJujnjiPBqeyIIq2PZZthSqoRnI855IU/69hFoRj8E2VlBWQNpHhtCqQUyotKnTUIE0WttUSFWxlD8ulyWnp3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TwbsnM3o; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1365753276.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728589941; x=1729194741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0yQGGhTqw9cUKWuDIB0GQqeru7Zb3BCIasRnoNpl7I=;
        b=TwbsnM3oGC7matx0Kou9G0z6/L+iRPdDNLmve9ls1XPWl/SidF5b7YB+ea7XqONzKW
         faUjXLJDXysJVZsc+F/qfxL+CU+7obwwxU6k3hiObXBU8eFtsrlT6Ea30NdNhuPDNK1j
         xgS5oE7LnZdkysXUlQzfE+b3mbWavdHxgtHtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589941; x=1729194741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0yQGGhTqw9cUKWuDIB0GQqeru7Zb3BCIasRnoNpl7I=;
        b=OpqpSOPx+SHPr4gC45VhICeM0GeYdtPnLE+n4hU6/G/YfAaG2GWS+SFLtE+lFLOCfj
         +Lbu3q4RRcT25DeB2Ph2rics8GSSLhqBN598WSFVq708EOE2GwBVWALjgREp8IvYyhGL
         l88bI4Xr2GDNUk66YDoTSa33MJmV+Ht2Vjqk5QAcew7POqzO56b0cxacF4pa50V5A65K
         p8oMknwD/4P2vkt89+VMRHGqZS43H0AT0Ls9fY9PL+ljjn26EJ/tsnOxgKlIq+RWTsuR
         Xg+bCdBGzkEE664J6Rl2+iYlhvvgD/vQMG7Mq6hCgtkuumnKqEfzDAOxijdFpRdYsyPW
         EMVw==
X-Forwarded-Encrypted: i=1; AJvYcCX3w4TEgjD+0qTtpnFH+ck43hr04XhG4Dc2KP3cOGKw+mHb6/jLXAF4wdLJB4fHHr8liIRLXT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YZeEySjm/mhLFWsg890z0mwVesD0SrP6PamidokK92PNqqG4
	eRkPz2409o1UPOr46EMHWosSdH8ASCXRBHprQxzTLhTmAdxMn2aSTSSrJsaR5Aa2Y5XaT8M8b8r
	8oEqFo7hFgG7VjjOK6jUBCWEPFODkKNGMniBH
X-Google-Smtp-Source: AGHT+IFWC5y7eMICyQT90+3RF+9SJuIQFBfyId6svCfqtZ8VV8P2OhLGTFKN0YGn+Iylgx5+atjoJZzkAL3VP4f/CE0=
X-Received: by 2002:a05:6902:1589:b0:e28:30f5:f33 with SMTP id
 3f1490d57ef6-e2919dadd2amr106480276.28.1728589940760; Thu, 10 Oct 2024
 12:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122429.1981822-1-kniv@yandex-team.ru>
In-Reply-To: <20241002122429.1981822-1-kniv@yandex-team.ru>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 10 Oct 2024 15:52:10 -0400
Message-ID: <CABQX2QNVpaTqBDzBnwDgW=2fi4QxeywXZRsbhywLkph3JgAmjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Handle surface check failure correctly
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, lvc-project@linuxtesting.org, 
	bcm-kernel-feedback-list@broadcom.com, Sinclair Yeh <syeh@vmware.com>, 
	Thomas Hellstrom <thellstrom@vmware.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:26=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.ru=
> wrote:
>
> Currently if condition (!bo and !vmw_kms_srf_ok()) was met
> we go to err_out with ret =3D=3D 0.
> err_out dereferences vfb if ret =3D=3D 0, but in our case vfb is still NU=
LL.
>
> Fix this by assigning sensible error to ret.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE
>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Cc: stable@vger.kernel.org
> Fixes: 810b3e1683d0 ("drm/vmwgfx: Support topology greater than texture s=
ize")
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 288ed0bb75cb..752510a11e1b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1539,6 +1539,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(st=
ruct drm_device *dev,
>                 DRM_ERROR("Surface size cannot exceed %dx%d\n",
>                         dev_priv->texture_max_width,
>                         dev_priv->texture_max_height);
> +               ret =3D -EINVAL;
>                 goto err_out;
>         }
>
> --
> 2.34.1
>

Thank you. I pushed it to drm-misc-fixes.

z

