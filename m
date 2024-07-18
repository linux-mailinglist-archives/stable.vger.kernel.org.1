Return-Path: <stable+bounces-60565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29426934FD9
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52531F21218
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1614430A;
	Thu, 18 Jul 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icqp/Iyh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981412C474;
	Thu, 18 Jul 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316140; cv=none; b=aIpQxN9ZZpwSizE7yLouLdIOz7SFwomOAR8EBW2M+F30FFNYONamr4LRfaN2zKb9xqI8Oej05Ax345rE5v5EAXOdpGRvQBQpJi0zF87TAoVt9dswUf1+A7xqwy22KcICHB4ntoPLZY885FGdDOuL1iMgK1Kkiv1oyxNAdykU+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316140; c=relaxed/simple;
	bh=4lViKQDcMUuTapEpF71jKFarDXy3YYlrOWSUcoL487M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqpCeWyLNt3CPVu+SfvG+HGdgko8h/dAHyv5bWClykyn3hPjX1GfklKz9B1ayMbwVeWTkfN88ACk/Pw+gGy6m+XzYoDuH6iRWPH9EMiSsPhiZoSEWLM8wgFcqX7pAEUGOWt9muFN9hfe7BdDx/5dIvOwpTuXCTmb8A+7+qFdO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icqp/Iyh; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7037c464792so477966a34.2;
        Thu, 18 Jul 2024 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721316138; x=1721920938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQJnSHtMQef7mtUVuS0yssb981i3hZaGT8EB0Q1Pc4E=;
        b=Icqp/IyhzQZwGpHCFB6coEatGpGZNIUXsDYZqJZlyy5GBXjtE7dSj+bI4QLFbnLE/C
         Coh9TQygsEGBJijIH3bdetssKoVyttYtZi0l1S+b3iJwcz2rUOgA+OiphjRGbvX6FEPN
         HBO3yYvohM0ItwRvYyqbzASqDe1mlgiAxMPqBxyDyFwQD/01HII2/g3MGU2TfHhfylSZ
         +i9vYtEpOZ+rwamsCGaxdGObDMHBatQqCyjU6coQ2Itwgs0kBunMUVD6abt3NQUw2L44
         Cx66EaVugZMAjYaIReRaQtzaOaRfbnjm0YaPckcYy/n25riJo2hzXDwo6//bwdpUOdt1
         aTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316138; x=1721920938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQJnSHtMQef7mtUVuS0yssb981i3hZaGT8EB0Q1Pc4E=;
        b=ctrsWulzqxf2RFaqg8MMN33DoUac/S2hhTq9jZOwLFZ7PNL2FcKzoYVNtE6rG4yoIH
         WW/qPvNakwYMgP9I++z0fbX0DHBDnibQ0x5wIklBJXwaVXY96qd+uuc/Rw2oe1gD+dzE
         BU+Odmf8by7waY71054+mal8fvfK+LVtWF7awdjG3BVqpkhkWSEt2Gfc5WgZPb3VFZtd
         nlieA/m83oOZDqlRSo8tEXMHFp8QQEOpSM14oDprlorg02d0jXOK1MwK4MOVWdb0bdHs
         mDLR73omjiDpF2WUclxiQWSxgKC/Z338DZCH0aH0B1WdEG11yfeYzyq+XqoDoky6WicJ
         DfgA==
X-Forwarded-Encrypted: i=1; AJvYcCUoqwPQjHCvDfVIZHEMxlyNSUksI8IMmrbDQ/iIsJPJ4JpYFYyEWPsm4Io+oZKaixhE+OTmbAYuqoUEtgEN+WxgrZS2BpyXv6egpGM87C80jBN+V2nN0RFmgwOaRue2FaKyWJuX
X-Gm-Message-State: AOJu0YzVGDZZnvKpZp9yWe4i9TVDUeIFvQCZdPfXoHJX3N/5e0WbXpN2
	WR9SprOTmL1K2c8nW1HUt+Rx+adaqXr5UHL6HykpkeMjUxm4+B8N5OI9mFaE3wICn7SHvXdsWBR
	W810l2gD+QETW+e5xGuZp+XLDFb8=
X-Google-Smtp-Source: AGHT+IEiIcjze2sqfT1hps5RiIp13M1xmJPESEzqUtct0AXla+FiYHuqmHRs8F5ZJiFygKOSV/25hAiBvLnBodoW7Ms=
X-Received: by 2002:a05:6830:908:b0:708:c1e7:912a with SMTP id
 46e09a7af769-708e37889b9mr5937867a34.8.1721316138141; Thu, 18 Jul 2024
 08:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718141735.884347-1-make24@iscas.ac.cn>
In-Reply-To: <20240718141735.884347-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jul 2024 11:22:06 -0400
Message-ID: <CADnq5_MiT9BOdo4cxi=MWABu4u5qTtNvziUbOXsUrEqeUhWPZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix uninitialized variable warnings
To: Ma Ke <make24@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, lijo.lazar@amd.com, asad.kamal@amd.com, 
	le.ma@amd.com, kenneth.feng@amd.com, evan.quan@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jul 18, 2024 at 10:17=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> Return 0 to avoid returning an uninitialized variable r.
>
> Cc: stable@vger.kernel.org
> Fixes: 230dd6bb6117 ("drm/amd/amdgpu: implement mode2 reset on smu_v13_0_=
10")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added Cc stable line.
> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/=
amd/amdgpu/smu_v13_0_10.c
> index 04c797d54511..0af648931df5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -91,7 +91,7 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_=
device *adev)
>                 adev->ip_blocks[i].status.hw =3D false;
>         }
>
> -       return r;
> +       return 0;
>  }
>
>  static int
> --
> 2.25.1
>

