Return-Path: <stable+bounces-144196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC9AB5A81
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BD8864CE2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98271D5CC4;
	Tue, 13 May 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJamcs9+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F971DF990
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154755; cv=none; b=W28s8iDBU7dasCc1RlJwhQ9n8AbRKcyDW68VszV8mRqkeh26FQ/aPW25WdXoGhAqv/5JL7d10SkzYhyHDXyGkOadw41gpEsGEerA2Wm5usxmdSGacyxiVhTSAYHM2vtOtXflif4XTqf5xEpn/uGayzss+00K+eexAmmbBpkyCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154755; c=relaxed/simple;
	bh=Q6eWsYhn2jm+VjkrwXLaqr6cGxYuVH84lYt3k4DAbeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBQ8zTxDPjViery+8OhQGEoCoo6esQ08I/05F8GkM5loU7gB6BsjccvNdhK6W6KE+/jGN0r1/5wXHC7whhYzfAhW5Fv99u0F4x/S6RRIDwgBGkJJegZKk7PxjVNx2aAXoZW7EzstuPDRihAI4SnmrvaQfbtyNKCXRtsYlAjeF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJamcs9+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b229639e3so441409a12.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747154753; x=1747759553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xmLzICloPlzFUsUO7fW760fgd5Mj7zlVU6WQbW8kiA=;
        b=TJamcs9+ZhODnYHtf8hQO5fwPUUPvyqNs09cg/bE3qPYQSqGmVHHX1+DqbQkOhl2di
         lHSdhwqsY01PtXMUrCdM10Qhbw9ni/8i6G5DPUHacpN4hthuW7gx68ZFqEbaIEM6xNXN
         r0IBkFvEqlmbdPUPEqOxZqC3cjoe8wt3E0Bf3c0VXGq1e1dpuD2EmEKRY7T3QN5EhGi8
         8jmLedkYaVZJ30ou8o7BfyT6Zj2y5+y+124bxBxfPfMjDL1UY+l47y9hScraJB2LVnxm
         q1qGv/Gt2lIei+eDMnVkE6W2+ntydSQth63TVKgJpij8wJG9ruh11Qd7rcxzauY3ElT1
         LWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154753; x=1747759553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xmLzICloPlzFUsUO7fW760fgd5Mj7zlVU6WQbW8kiA=;
        b=KggnLsuZuKacWA0OhQ1ujsKFxF4OorD5O3cif7gIcSdegI2RcJ0OSJ39ZwEdYBh1SP
         i1SC/tI7Xg6tbaon5eR1snZxfz5O1F9M30ALtaqFFKWkHoJKgo5mFPaah5qJsGbt51mT
         HNZVhMsAjO20OD8/3q4YDizg/rge4apGu8l+jCo0ZW1yyhFj2RBuw3Ikx08LZqzTfFYr
         jnR0sjK8UbV0BZWNeyyPE+Qx5S7+5jR7tKgXWqRpu+O4dOSlTitHB04fCvH8fBrPpzVc
         VrOpzLwGX4bJzUhxxQdEv6yZ7cxguPx+TMrukLWbHRYqHwXMoAaYHHX4qsnKEK3wys9A
         x06w==
X-Forwarded-Encrypted: i=1; AJvYcCWKT9Mufoa4cRvjsTYLz9c4u0B2hKgQyjyzLxdM1e594DqrLd2pZkmOCef7BLoIS6CtDnnby04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKF4ImiMz+rJyYVr0fd1bj7ETbswGvqfb5/J5zFJYjKNeGJQ6
	/3SnCFpeSFLTZVH+QIGjOjvCh0pwA34AyO0qOakzoS4u5BLWOz6+f/5vSr0Lvlcni7a1A89jYjt
	liOjzLgbwuR926hBB8XfrkkY9VnI=
X-Gm-Gg: ASbGncvHbpCsUlSWw7/7rfWIzXhjOv5c6nHhGGDK2j6I/VyRsu9XHj/3fHWMVgVV6Ak
	rxIP9N8pZq4EwdceBA/qdQQe3YZjeFK3Q6KJtlqxXq8ZF00uZLaTHhK5OLV9y/AoqkEBP8PywUb
	9pDIkGrWjralrfmwLlL4NyX3mw3CaUcr6M
X-Google-Smtp-Source: AGHT+IH7n6I9o6ERN+ZywvsYLTGHp64Jf/JnCGHZALi+g+UJFsAq9iH/ubp+X3mQyCtetxE2VgFXFEaRROJOIkCvcPo=
X-Received: by 2002:a17:903:8c4:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-231980befcemr926815ad.2.1747154752999; Tue, 13 May 2025
 09:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com> <20250513162912.634716-2-David.Wu3@amd.com>
In-Reply-To: <20250513162912.634716-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 12:45:41 -0400
X-Gm-Features: AX0GCFuvIzjgjtA2VvH97wE2rCO3svGieD2ocWRUzBfqriHhNeF-n3HkAfEft6Q
Message-ID: <CADnq5_O2hf53Ky0H_wa+vcb7cecYzw439WTTdZZaTjQQ=DjBRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: read back DB_CTRL register for VCN v4.0.0
 and v5.0.0
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
	alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
	ruijing.dong@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
<David.Wu3@amd.com> wrote:
>
> Similar to the previous changes made for VCN v4.0.5, the addition of
> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> prevent potential race conditions, even though such issues have not
> been observed yet. This change ensures consistency across different
> VCN variants and helps avoid similar issues on newer or closely
> related GPUs. The overhead introduced by this read-back is negligible.
>

Same comment here as on the previous patch.

Alex

> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 8fff470bce87..24d4077254df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1121,6 +1121,8 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst, bool indirect)
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -1282,6 +1284,8 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *v=
inst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 27dcc6f37a73..d873128862e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -793,6 +793,8 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst,
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                 ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>                 VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -925,6 +927,8 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *v=
inst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> --
> 2.49.0
>

