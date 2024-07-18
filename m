Return-Path: <stable+bounces-60564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA92934FC7
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1A1C21A2A
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32F143C76;
	Thu, 18 Jul 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR/2+8pd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EE2AF12;
	Thu, 18 Jul 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315914; cv=none; b=TRknHLcmZchoLBt5Dvuy7GW4r4+xTwfTVn9oZW9ShYofExoV9hxLiTGBsWT+zJpVOyhM2B02QzGm0+TIS6MyQfB6aUD3QZR7sTHkgZLVABwD8kQG8p2j0rlyDzK7hbjmjhvdGPnsEPQACr4SKgxpN4iSTnTP3y0l3vA+09xbQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315914; c=relaxed/simple;
	bh=qiIttFgxKf9k60vgK0Y0nm1JJpZgbSi4pucxfXKhRQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNSrJzvrzLtTcjV1RfkIeDF+cA1mn6dSYUYeg7DjP98ZAkR0fcBGYiRVzjRc3GpQVX4koQvonCnk5XfZgq8PvA5nxxOyLoyMeLCRb/PlPCDviaKJr/vRrYwovGGnBviJD+OqStIZH1VCVN2VvhlzPFGwLAUMdd1xTwtAXGrW5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR/2+8pd; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70445bb3811so511398a34.1;
        Thu, 18 Jul 2024 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721315912; x=1721920712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3pgAhn8Hz+xMofFbtGLdx5btdIDRNI5147fpowYYlc=;
        b=YR/2+8pddATLkHFYPQa7f/CHV1n9KlK5eegNlkmvdDvLl55jUKOv7iE4FirGy4x3BG
         dkL5Wn8RIEXMhntZ/SnJTDcH5xid3cWguXaaRZUK9Jhsz588U8riu052ZOmSC+o9Y1r/
         VHU5Cv9Ao9rA6Estca+zWjphJjzR3lPtQDJth3+dsLbmjmNGwYSK5ho3iFuZFNSNsFtp
         oKcThUtf8utSQ/3vVlnH7qMC9uisMdZgbEa1zr5wlfTC9jmUjHcdFJj0CgcXTtKguw1R
         vMUBUnxkN4ZxcZEO+B0Cpe4rEYZP/JxemCBA9+l6oN5jKywd1JHM6D/wm7LnjPq++U4Q
         f6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315912; x=1721920712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3pgAhn8Hz+xMofFbtGLdx5btdIDRNI5147fpowYYlc=;
        b=vT/lL4CTmszkTINwGU/h7S5tw7HnnUpbjLBk9HF14U7KmFLd+74lOoOtovtjjeFYKn
         +FwGAKO3spCnkLWt/0xNpIQw99xhVPMgMVTU9Pm+Twsl8KEa+HApg2gxw9tCQh5o6HcW
         MdlUMvGXOY8fBR8RI/fRFHMlxNES88TDc7w0GxBHNmN8XKDvWne7ZKprBFTGLZvT4A6W
         tuwPb25rlkI6F9JeAvmnYCYSaSC+nlkYkEbboIl0QB0P3+OTJZ9XtKjTOcsa3mBY3hXq
         2BKfE1Ob++iUbQQpdoCuH2HyFGZbasgEWcGmL5PWkkolwYuppnWvv9XeUx3LM+dIozK6
         B3mw==
X-Forwarded-Encrypted: i=1; AJvYcCVfP4HZhOsjV1uTTSxyEF0GwSGaZdtTi234ZUS2K5EJucyG7/9+RRlGs9zjEZchhA0PQloo/jy/8f80xUXQJFUfFIrGYCIbK/QkqeFSniBvV7tS7u7dJFLaFLyq22vuPa/FWeMD
X-Gm-Message-State: AOJu0YwmAOA+RogV1ChuAP0VjMq0HR5N5fNeSBM8O/d2SDv1j+Vgjl8M
	LtKwV5AqkspSj5TMzcQ7kxWfS6FZ3A0yuqk3YRh9+2PHGAkIMCqjgBa43DBeQECSYAzIqWUQg5A
	APTEWkTu3rTlTqVq2gbOO4v1LGnI=
X-Google-Smtp-Source: AGHT+IFOthVJdopFJZrEzMNq3d436b+HpYYgi68VAUJis86seEnZpukZJnPvnMc2OxyBw33I3huvcQ3qV0dx69VJDqo=
X-Received: by 2002:a05:6830:441e:b0:703:5ac3:3e4e with SMTP id
 46e09a7af769-708e3798c15mr5541746a34.7.1721315912272; Thu, 18 Jul 2024
 08:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718141141.872558-1-make24@iscas.ac.cn>
In-Reply-To: <20240718141141.872558-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jul 2024 11:18:18 -0400
Message-ID: <CADnq5_NOBrCQ7vK3WCMJ-0TS+9B5Kq0L0MB4=xriPNXdRLmfhQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: fix a possible null pointer dereference
To: Ma Ke <make24@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com, 
	chenjiahao16@huawei.com, aurabindo.pillai@amd.com, Jammy.Zhou@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Jul 18, 2024 at 10:12=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode(=
)
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_cvt_mode(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - added Cc stable line.
> Changes in v2:
> - modified the patch according to suggestions;
> - added Fixes line.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 9caba10315a8..25b51b600f6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -458,6 +458,9 @@ static void amdgpu_connector_add_common_modes(struct =
drm_encoder *encoder,
>                         continue;
>
>                 mode =3D drm_cvt_mode(dev, common_modes[i].w, common_mode=
s[i].h, 60, false, false, false);
> +               if (!mode)
> +                       return;
> +
>                 drm_mode_probed_add(connector, mode);
>         }
>  }
> --
> 2.25.1
>

