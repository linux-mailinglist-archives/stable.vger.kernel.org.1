Return-Path: <stable+bounces-81129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521F9910C5
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11441F22850
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD44231CAD;
	Fri,  4 Oct 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF56HjWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C675231C85
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074697; cv=none; b=tcbhTicukJL0HqKYUOXFL6R5z1R1ICSIKnK/971VD4zw5Tvbb1yX0oUsmyZyUIQVm+VSimgPQbSq5C1ScE/LMMkHXyPTjuMM6657IObEGQnNRp5Fq+UYj75pHpPLjsXKwnksAnXf81GDRDoYgPT8Dvq5HzdeCAnDaaBieyukHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074697; c=relaxed/simple;
	bh=lM9ivVNV/pAJhu6PYLlXVTQBZ7r1kZH+BXULxm/v5fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agxO8hUcX9e+2v7YZn585bW3KbpM7UJDic45asAY2VObR0HljoDc8Clb8KBG6tymg1RAKr3nvsc3/qoHGI8EtrUI4cvxFLYCJnhiEkPEYC4n2iWYh0rHau7V64QbiorL5MNgcihwhFU5cjURzb4HS7ZsBeDKP/c4Q/MTa/2rs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF56HjWR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c3d8105646so173937a12.2
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728074695; x=1728679495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33TPDIOKl+txl2LnPlTEazOV/nJSKgZka2Iw9bNVWBs=;
        b=cF56HjWRBJPgN+bezYXYiL8QdCtR+mtn1U/1cHD4ik4LEy1E7Q+FulmQ+s3qa9fxGu
         IT4UU0P9gC3QU5NCYGp3NEdcEHrxpIj2tYvcKTR7jz1PsqlqQAzv4fiFcj6Vlahr2TRW
         MPhEc66oBXuVhCtRqV9i3yCjEN7YwxDCp1KVd1SyJAQBz4w7g5kXQfIFTNEfZXwavJxx
         nAO0SQ3SKoJevbcox/5Br4XVRYv4A7YmsPRAMJ+EYq+14HFmpyFxH+I1hN9aTGPTxuPh
         8apZHKSIzon5nlt9XXSGjt+bsNvOuw2O11wHSwKPnLNNStyyJ6TGmUkoVWmyOGxrlTTF
         Fwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728074695; x=1728679495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33TPDIOKl+txl2LnPlTEazOV/nJSKgZka2Iw9bNVWBs=;
        b=b9S0l8xGlecSmwGTTMv+RbRtcSF8WviNJGMrublNlfg6ALpzPiLQLgDS8KFxydiO7Z
         HQulxYHH47b5dQY5Est0xvzr7QPDphR1ofAFRzKW5jVLiNpWxZZJGGRy3DlQs67e0+ua
         ypA4pP5NKeRgHm5HDVeCdnQBnB2feq2zHLfSuSScxykiF7IyqvYsYza8qRh5Vj7Gy2qN
         HFppWh/dCewlPYBe2iTK8qzI6QvRAkz1C06aCjOeA7YCvy/LtImzOy2W3K0GeaL0te2o
         tQ1FC1O0pboVorwFgi/BtdE666ZJ98tXMjsu6UsCMYe1v+ysR26EiZCJsJ39Cml5Oo7+
         ckaw==
X-Forwarded-Encrypted: i=1; AJvYcCUJaxA3M8i+IyZfEDbh09WbXy4Fs4ptPg81/veWykyiqHnW3Yy0f26K53/80k5yuOqCGHjHqWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSLxHoj+mudqmqHHLay5jtgIM6Tb/85ZKt5cYJNP4ga5akScq
	OgQ3JtAiWLsbQsX+6+omcUZBmAefmjbp5IDRrpWP1kXUDfx1mU/UZ56Zvg2VEbfegT8PozErM0r
	I+i0z//4fRDgbRq/6ekZyrVtU3SQ=
X-Google-Smtp-Source: AGHT+IEHwUdnPaDidhuyWbFnP6/MmldWv4Pb2bXbtceDlIC3yMyVKW1y4Mv9PQw2Wz0i29ACYQpuXfTFTpH8SkkcJQY=
X-Received: by 2002:a17:90b:3bc3:b0:2e0:876c:8cbe with SMTP id
 98e67ed59e1d1-2e1e6369885mr1877844a91.7.1728074695350; Fri, 04 Oct 2024
 13:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004203350.201294-1-hamza.mahfooz@amd.com>
In-Reply-To: <20241004203350.201294-1-hamza.mahfooz@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 16:44:43 -0400
Message-ID: <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Roman Li <roman.li@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> Since, two suspend-resume cycles are required to enter hibernate and,
> since we only need to enable idle optimizations in the first cycle
> (which is pretty much equivalent to s2idle). We can check in_s0ix, to
> prevent the system from entering idle optimizations before it actually
> enters hibernate (from display's perspective).
>
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4651b884d8d9..546a168a2fbf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_=
block)
>
>         hpd_rx_irq_work_suspend(dm);
>
> -       if (adev->dm.dc->caps.ips_support)
> -               dc_allow_idle_optimizations(adev->dm.dc, true);
> -
>         dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> +
> +       if (dm->dc->caps.ips_support && adev->in_s0ix)
> +               dc_allow_idle_optimizations(dm->dc, true);
> +

Is the ordering change with respect to dc_set_power_state() intended?

Alex

>         dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POW=
ER_STATE_D3);
>
>         return 0;
> --
> 2.46.0
>

