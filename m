Return-Path: <stable+bounces-195017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D361C65FE6
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 431273529BC
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FE2C027A;
	Mon, 17 Nov 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+6qZtYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20E3002AE
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408323; cv=none; b=qLpnH2lP+D5xaFKCy/vvdEuyUg7AtU5V0bmwFZoFLz/Oqo2e2NjZVDLiVDDP3xzEzEsvVuJalSHZhDIZ7/6Plg0m7LrPxKF2rs3MYtR833XKjbHQMiExfOej9nHrHeMI/SQ8O8H5IvGDiKKjmk/1PqQ/OifTtiCeG7rMJuNDpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408323; c=relaxed/simple;
	bh=byaAuzRhnwOM/SStP273n9k657IgFhbcRUyjz1C9Q74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPnzmcVtwJ04UrymL0EwgSHoOrq6ozE44vgRgZvVzaVDyx9Qa1o5lCI/LlDmpPzhhgUzUo7hfDlKPLSXrv/XOrDgMIsOMwsmTlp3sxCWhCvRD3xEnkjlbbQehpHB/naemX2QIzoFHTFxKn1citguGMEP67cByMNiYHmfy5z4R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+6qZtYK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b99c2a5208so372630b3a.3
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763408321; x=1764013121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWBlv27Dksc7HrBPUdOReRPEGAb8gw0+ItSWLw68B88=;
        b=X+6qZtYKUgZDBqA04Yc3+ZuFjIIHnqb5NkRPDbngWdO7GG2ps7qMf3FNCJgKywoJsq
         F29ZWAaJxKvweO1eEGjYuzfbvLodKZt2rMo+xl4qsSxBIQbZvLwYOyTocP8vQSIzWPa9
         Z9PpQRUD6zbQQ1kwxAi9y04eZqzh4GZ0Vy676aMZ0r3FntGMvdCex5NBUk8Eoe3h0rBG
         tc+cx+JTg8e8a5XGyOMrd+IxtwmbwVr/ehdkFXFGL8AoqCkBFvEnBGK2RxG/Ov0gmIGt
         WLnWtxhplcgcDpWgaL46zjJnwU7DO+GoftOuH6rQ4rZAWsXbCNueHeJ27Sgr+FcyCHwV
         wNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408321; x=1764013121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWBlv27Dksc7HrBPUdOReRPEGAb8gw0+ItSWLw68B88=;
        b=AHg9jjn736OUXTrDPDF/Ew/kteUTqebW+kD3OGR9+xlfnipyKft5wccsn3FV52CzTD
         5czD0M66sXXF+S63ecR3VBu8kS3rlHtzsT3lcMHBQi05SxrtaI0Q06E2vHIaqlstFi0z
         cUykYLDHmrRaDgxHcnJ/oIKyFvPXyvIytcGNOoOXrw2cvHrcvnaM5M/ePClnzRKFvGwu
         IH/XuopEC7eYgWDjOf4Adnrsn3qwIqv5PS6ZFF3ftgcyU2PFhHLXcooBU2aeKF3TB98+
         tLvVGaL0NZrSyNK9AUesdGT2+sUoO6e72K8XgMnwA724UgOw7FXzRZMzPOBIAlpB7qPt
         bjiw==
X-Forwarded-Encrypted: i=1; AJvYcCUtE6XfNOPZSDpwyJSAUjdwxMyqNpaEU9WP1xGoXp//2HbCYcf7l2UoV9XV/Wj/9J0wYrLCvso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfoiR2JNDKn3aR9yhdngv8Zd+7ZUnJvVlo1p/UCY+WGhz2irZ
	KqfmD/xoMCCouvd0V/9BBUhVcUS5a+Pw9PiMwVn7HsfWUlWEJlcPNNz+aArdH8YIP2majziN+3S
	LQ12gqdBeHdFofyuTpB9rvg0z707oSkA=
X-Gm-Gg: ASbGncvD1EMLrBNWEdVDLiFr+U/uZuY1xEoad2JWk7iHxsZI50k3BiNCbPVXvGeYvNs
	dppXUROfhpbIbwcoz79h+HrR07251OnkFFgxvhIfPqBie0yLJ/TIcquRGCuf7tPjgYYcd0/mAiT
	FNyG7/DzTDZU9B3tnXbbpVkyrmqDQ3/ADRuwhnyJPNW740fmmbxVIKrJxQA0ze6TcwlC3tdQEjF
	HeQn8y0cBe9NGpxjKfpkuL22bmz+asndbRcIDG5RCruIiJBYmwc5QndqQkhdQwhVrBlLck=
X-Google-Smtp-Source: AGHT+IFw+WamDCBwcmKs7ViNx4T5bwc4cNYCwwbn0Jd4DLeSo+2vCqUcd6+HDDs1xhn8kHeO7snA1pVYk6/KGV9gIic=
X-Received: by 2002:a05:7022:6186:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-11b4941c45dmr4967156c88.5.1763408321331; Mon, 17 Nov 2025
 11:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116173321.4831-1-rbmccav@gmail.com>
In-Reply-To: <20251116173321.4831-1-rbmccav@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Nov 2025 14:38:29 -0500
X-Gm-Features: AWmQ_blHHYc5TZLAOrneOd3RNEx5Qsw9cHSZhuvgZck70-WcLnivbQRg6pgFYMI
Message-ID: <CADnq5_P8z9C8e6kZLOyzTAxrhj97-ujm2bVWXij9PnrJTBwHdA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: delete radeon_fence_process in is_signaled,
 no deadlock
To: Robert McClinton <rbmccav@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Mon, Nov 17, 2025 at 3:42=E2=80=AFAM Robert McClinton <rbmccav@gmail.com=
> wrote:
>
> Delete the attempt to progress the queue when checking if fence is
> signaled. This avoids deadlock.
>
> dma-fence_ops::signaled can be called with the fence lock in unknown
> state. For radeon, the fence lock is also the wait queue lock. This can
> cause a self deadlock when signaled() tries to make forward progress on
> the wait queue. But advancing the queue is unneeded because incorrectly
> returning false from signaled() is perfectly acceptable.
>
> Link: https://github.com/brave/brave-browser/issues/49182
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4641
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Robert McClinton <rbmccav@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_fence.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/rade=
on/radeon_fence.c
> index 5b5b54e876d4..167d6f122b8e 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,13 +360,6 @@ static bool radeon_fence_is_signaled(struct dma_fenc=
e *f)
>         if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
>                 return true;
>
> -       if (down_read_trylock(&rdev->exclusive_lock)) {
> -               radeon_fence_process(rdev, ring);
> -               up_read(&rdev->exclusive_lock);
> -
> -               if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D s=
eq)
> -                       return true;
> -       }
>         return false;
>  }
>
> --
> 2.51.2
>

