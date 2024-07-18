Return-Path: <stable+bounces-60559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC5934E95
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DB0282FDB
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D413DDCE;
	Thu, 18 Jul 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8L4PziH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A19457;
	Thu, 18 Jul 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310884; cv=none; b=XmUl0tK++G1JBOoDd7XogwxBMURqfawqAaSY9wy7yKgMluTVgn8QmcdjQFNJJQm3MVZkONqLXRnj3/yU+dnXhRtt7Pywo+5jEcl4/j4XCY8FaHIy39TSjLISetsYvniaKTi9EcF7duKmq4u1Tzcl6qc+Ydmfor0JRa7HTSRysQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310884; c=relaxed/simple;
	bh=ZOYEvzhgph1M/BP0ZuDtdq5mjqFGiR8wTi5Zc6s+bHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tExez2QvvvsOLjIxoR4TiEIRRPQQAZWkD0JPrr3ChRe5FEHez5/JMDi1SQ6IXYuoXsurGvzH9OjjhKEU9sfTMjBfNUMgbPe8IOQalug22tibwEC9m3sb+19zJjuxjjVHaKLeRxfH8v40sCsL6joNjWRlb0bJnIQr6N2X5iqF34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8L4PziH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc60c3ead4so6256725ad.0;
        Thu, 18 Jul 2024 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721310882; x=1721915682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zV2MPH5gSmcOC/Ol+e5BTBsjovoDd4as4GAddrNN+Q=;
        b=l8L4PziHRZvHh1DoZCRF1gDOlMutTrXzld89YWqSkhADZvgZ8u2d9WskFIlOdkjYk8
         7S6GxEp5x8OYD+mv88a23A5Y5tkpFqVutYwfFnvSXnr2FpWqn98PqWOhrrSNt2IWe3oT
         K9eDr/BCV4uavSaXldojDwi7ISAjVAsN6QJ0HEpZ8GF6ygnYhDmbEXHSsh0vBKf+xtRe
         vcjKMFqHLcQjNv+ttdt+zBqp5RfBQL/4JsZ2r79slA+dE98IuXhAdhigyeqJzVcWCwe8
         Dpd9NqHkEO7b7uGLPelTHHdRD66noR3sko5qi8sbnOaYRG6D4cvku1ywAiNAndZ4vN6q
         yydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310882; x=1721915682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zV2MPH5gSmcOC/Ol+e5BTBsjovoDd4as4GAddrNN+Q=;
        b=iW1uQw1eFs2WmldPbvs+GWNRYVTQTPxumDqzsNq+lEzlZFzYr71rU/NgwxV12c2ijW
         PqKJ+UvsayzDM7ulquh/FHGb8eJTnmhJKN3AH5LpdZkcaradUrizzzNUpmxy8HKt8Wj6
         aOAyFLFLlQt38g1YFLcIvTp9KwAcc7MxW7YAKlcBOycsqZvcXOdPnuVRR6GCsju6dCgF
         ryibCqbJxrYLvnvSclNkenqmQcauLvMGU3wVC90bZPIfJn0+U9GzyMOxHPq7OJeG59zp
         yCr4Md1W6wmu4JmOCD7mNizYZGbe+8AyPZojszhTb6pZzDsNk9UTBqd+7kgoEtetBPjc
         XeLg==
X-Forwarded-Encrypted: i=1; AJvYcCV75oYs91vqN4xpy5I4l6t8sx+CJytz6TjWZFwNK8tqxbV2wGwL1CWQ9U5ldu/M6PoifGnL/MqSxnFFiR+obR5Dwiv0xOJKiVSxxr3kU356cRiCUhpqEGXxkunPQg1B0kXm5THB
X-Gm-Message-State: AOJu0YxK0I/6Ns+bxAv6IgvusYOzYW8DoCFUv0/y9ynGtpDUhKm9VZuX
	PZLN7ykGzQYiPPmQYlQXAI1jn2mDjmH0Dt73N83qtyytYgAivhVT/D/7VmD3ZUR2f66LiOkLrwT
	FzQoiDWPM3mh6oQZTAZU5aShELsg=
X-Google-Smtp-Source: AGHT+IFI4cYLODpNXKiLgPsSh/NS7hTFY9BWhgG3KU0S/egbzJ01L6bxoqfo3h8scGyT3KhacGUdNeBT9XdG3UGpK6o=
X-Received: by 2002:a17:90a:fe81:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2cb527f5861mr3697496a91.31.1721310881910; Thu, 18 Jul 2024
 06:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718131329.756742-1-make24@iscas.ac.cn>
In-Reply-To: <20240718131329.756742-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jul 2024 09:54:30 -0400
Message-ID: <CADnq5_Mr97=TBi0pO95tVNqMZOja4_CU=JzdmPMjcG+xXad1MA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: fix null pointer dereference in radeon_add_common_modes
To: Ma Ke <make24@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, airlied@linux.ie, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jul 18, 2024 at 9:13=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In radeon_add_common_modes(), the return value of drm_cvt_mode() is
> assigned to mode, which will lead to a possible NULL pointer dereference
> on failure of drm_cvt_mode(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: d50ba256b5f1 ("drm/kms: start adding command line interface using =
fb.")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added a blank line;
> - added Cc line.
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index b84b58926106..37c56c16af8d 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -520,6 +520,9 @@ static void radeon_add_common_modes(struct drm_encode=
r *encoder, struct drm_conn
>                         continue;
>
>                 mode =3D drm_cvt_mode(dev, common_modes[i].w, common_mode=
s[i].h, 60, false, false, false);
> +               if (!mode)
> +                       continue;
> +
>                 drm_mode_probed_add(connector, mode);
>         }
>  }
> --
> 2.25.1
>

