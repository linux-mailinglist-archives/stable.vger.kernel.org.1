Return-Path: <stable+bounces-41486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890498B2DFD
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 02:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F88C1F2236B
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9A394;
	Fri, 26 Apr 2024 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VuPVdX9T"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B223D2
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091180; cv=none; b=YWuuI/EKf3UbEmlCCtdkSYdDF9D0AUWKTl4DYmsQoOVroCvcGAPd1MXzqFsjQ37lWxZko9hzpWjSICO5PZp1z/aS/IWcW9BbIRHUwyoZ9o43fifwUsun5qz0Vv1jKkd3f9xV+GzkqeWFyaGMZur4fwRl4J31RgWmGarhGnvMWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091180; c=relaxed/simple;
	bh=ha9w9kkghxLNIRAwzEk1CzDUNXfaiUTorg8cK13wf7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNK46njBDCq3K56pb6ERpQSMVcn21x1GI2NpV+Nd+Q7/UAnn7zMsK5BAnwLSlD1d+go7TpQuitcBiRjJt1jUhV39ewra4ACjKzhY7/C9QEuyl99VZ00qoytKa0RZ2+idho/vUUPe8ArQV9y1I5P1fpOCI4QUKgdgAbCeAcUYEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VuPVdX9T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-615019cd427so13853717b3.3
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714091178; x=1714695978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gLDDz9kHojOBTxe6bjGKOCEMWiVncximTkDuPbQk1s=;
        b=VuPVdX9T+/q2Ir495eMj3byDlMYB8OCTRM4M3pg0Mx6RG8gTVuHJxkgjeWyVhU5eiw
         0uYeFoVC289/7Gz+yS9SZba1d9+ZzSZ3XtlENSDLWmIsxAOXNZ6QqcWwsw1un/ohyN1B
         B5qANWKZtVGfrvZO9i3EmnSfUcGILPyqBsilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091178; x=1714695978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gLDDz9kHojOBTxe6bjGKOCEMWiVncximTkDuPbQk1s=;
        b=jvEZdwAe56l+fulUVXqyWrUAhMYDO1A3W1ywal1ZpNchsnUKqtqPCRC6Q3pXyGBctc
         rcfrVSJ0m6IxfSgamQu0pWn6pVtW3j2CXdwgmaMXyXFyL6aIdmYceEhPCU/119wtbHG1
         B2KVtT5Qp4BcAOD99I9fl9CzPTKhuPeQwsQZsYwm5eC5Wcwt7hDvdbhphZMAaeAXT7Eo
         CmyW52cI6rUplQFkFYHnDlpQpdoTidhSMUGnZNkfSGnF/ui1xHomKAMaD7cZWPtMu5JA
         4ur1oNVIP1/RO1APRDdbZCVSnEgOuPbmx1R8tUqPxJOgoF6l8cWNeo7lL8qW3QNw4E5o
         J6TA==
X-Forwarded-Encrypted: i=1; AJvYcCVKQyVKWixBM6FFDqxs13I4+z5T74/Suy5fg2S4tBehAK9tEwLjbZDV1Swey0ZbcwWE26GV/hJca+Bse2jLXdRP9rdiJpc0
X-Gm-Message-State: AOJu0YwZqZ/oHRrYQMEOJMlUntmWnPK5mVbHL1vjEnm2qPFoeX4z51YW
	ydiNSfCtIzdOjVZrWWDZ7FZ5/fLJ2NNJHcWKqp3i30Zqhjjr/JDw4KkqntWfB+mTa+AtxhqzwDh
	fE9rXwiMGVYiq+QM3vQJHPPvLpB/do+KeYf3c
X-Google-Smtp-Source: AGHT+IGwMaQUYW9Qv1c3OVtpCl65/4lstbZl43wEeWu3OnGJg5CBIEd0KD/um1P+8JdzIj9pkBSJrwvVKQJyNOOpOFI=
X-Received: by 2002:a05:690c:6184:b0:61b:12:a587 with SMTP id
 hj4-20020a05690c618400b0061b0012a587mr1446577ywb.3.1714091178137; Thu, 25 Apr
 2024 17:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425200700.24403-1-ian.forbes@broadcom.com>
In-Reply-To: <20240425200700.24403-1-ian.forbes@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 25 Apr 2024 20:26:07 -0400
Message-ID: <CABQX2QOeMqWWYarm=SPmudSDpiCQn97nO6GnS6-Fs8gPRNwm3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix Legacy Display Unit
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	martin.krastev@broadcom.com, maaz.mombasawala@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 4:07=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
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

Looks great. I'll push it through drm-misc-fixes.
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

