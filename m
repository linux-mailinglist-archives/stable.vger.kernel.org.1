Return-Path: <stable+bounces-124792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C99A67271
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 12:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1431889057
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529B207A01;
	Tue, 18 Mar 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1NySPlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CB205507
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296725; cv=none; b=RNnntNtnYH5WV+pPWdMDZDOyxBrHf/Md3MKste9iSmA3OxZaXRbNnzYjfiB0n2l0cFz+mOxcAFEMtfGwYjsZ6Duqwm3LIh+nwt3HF9hPbGkIB6TlwSbZJeOEVvrJXtOvqEs+v/iUqU44BU3F3ZjLcDkghYr9bLjNrX4/0nFUYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296725; c=relaxed/simple;
	bh=ecUjoZ++I58Bl6ZVANbY1i64A6BV21RqFFGqC3bd7wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9BjnswXLRUWVmphOw2KimK0cS6wVc4n/Mh9n0grzaLOq4D/SNwbpvRopKkVIwDgeE2Q1KZSe5OtmtT1+ZK76DUXUul7ZpaNL3CElFQQFhKnyl9KCEcMkGmkojG4NU/R1xnUWfIMOVxuEP5IcFhYEF3OHiVqz9uf/TKnaBZJQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1NySPlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A6AC4AF09
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742296724;
	bh=ecUjoZ++I58Bl6ZVANbY1i64A6BV21RqFFGqC3bd7wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I1NySPlWHKehRUzDSIjsIoUkePG31FfeVqVBGHnsgAhf9tqqeKs7w+YTm8yX8Ht7v
	 XAmZgvC8GfSKzcyqHhBdrrzRLuNH9055qQ77jd8oCyaYWHZUgehO7qiSIdd/EGV8Nw
	 WBJHODyK41XxRmf+i/FtBtJ04mRyEROc96ewem1kfRh8F6K1nANy2BZSHmjbnAzwYi
	 zzIXpbcTrhBGJxL47Af7xMga9h2N9IT4dsQGdfyYbFzpZ1DpSQQvegWanB73nfwM6B
	 qjZ4X9adwp2A6jkjbiwKpf7zsHrx7jCZShnOE9lZeQIkHBtODwZHSTeTnN59iSPHLF
	 fjq9GMKIFeBWQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2aeada833so1071965266b.0
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 04:18:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFWi58//Z/EUq+2xM8HdSzvH3fgZbeMRtkTAsILuYP/CcpyeTOZWsTPQAHkT/9bcx2ZRSJpuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREEdxOoigzM7UdxfmOJ96wE+T9VIHfXQfkdW2+l20cWjz9d+Y
	twmpdVyO7+YdfDkvjENDOQOgm5xDPGZM8k1gMMnJJAB6nSJj1dMaWS4YbE5JX5LFImM4JzkZdYX
	71KMQRQTBT0b2d3c9H80oAmcv3ec=
X-Google-Smtp-Source: AGHT+IHQyWsVDyV7GPIT8mU9qxkU0lWWDxBKairMq2R0LaSoEUAawFYv4bDvE7FKSNEGQdRZ2ZySowa7fV8ZqtWgaT0=
X-Received: by 2002:a17:906:dc8d:b0:ac3:8aa6:c7da with SMTP id
 a640c23a62f3a-ac38f7776abmr302969766b.7.1742296722921; Tue, 18 Mar 2025
 04:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318111611.2161153-1-chenhuacai@loongson.cn>
In-Reply-To: <20250318111611.2161153-1-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Mar 2025 19:18:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6vXc-QkBtbuLN4s8bpHzb6tOHWPdh-6s0xEqTLoNAxjw@mail.gmail.com>
X-Gm-Features: AQ5f1JokISMsMI-FbQL-Nwx2-z750GxhY5y5mhcCTqtJjIYMFlfkoonv8QAEW_E
Message-ID: <CAAhV-H6vXc-QkBtbuLN4s8bpHzb6tOHWPdh-6s0xEqTLoNAxjw@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/display: Protect dml2_create()/dml2_copy()/dml2_create_copy()
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wrong patch number, please ignore this one.

Huacai

On Tue, Mar 18, 2025 at 7:16=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Commit 7da55c27e76749b9 ("drm/amd/display: Remove incorrect FP context
> start") removes the FP context protection of dml2_create(), and it said
> "All the DC_FP_START/END should be used before call anything from DML2".
>
> However, dml2_create()/dml2_copy()/dml2_create_copy() are not protected
> from their callers, causing such errors:
>
>  do_fpu invoked from kernel context![#1]:
>  CPU: 0 UID: 0 PID: 239 Comm: kworker/0:5 Not tainted 6.14.0-rc6+ #1
>  Workqueue: events work_for_cpu_fn
>  pc ffff80000319de80 ra ffff80000319de5c tp 900000010575c000 sp 900000010=
575f840
>  a0 0000000000000000 a1 900000012f210130 a2 900000012f000000 a3 ffff80000=
357e268
>  a4 ffff80000357e260 a5 900000012ea52cf0 a6 0000000400000004 a7 0000012c0=
0001388
>  t0 00001900000015e0 t1 ffff80000379d000 t2 0000000010624dd3 t3 000000640=
0000014
>  t4 00000000000003e8 t5 0000005000000018 t6 0000000000000020 t7 0000000f0=
0000064
>  t8 000000000000002f u0 5f5e9200f8901912 s9 900000012d380010 s0 900000012=
ea51fd8
>  s1 900000012f000000 s2 9000000109296000 s3 0000000000000001 s4 000000000=
0001fd8
>  s5 0000000000000001 s6 ffff800003415000 s7 900000012d390000 s8 ffff80000=
3211f80
>     ra: ffff80000319de5c dml21_apply_soc_bb_overrides+0x3c/0x960 [amdgpu]
>    ERA: ffff80000319de80 dml21_apply_soc_bb_overrides+0x60/0x960 [amdgpu]
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
>   PRMD: 00000004 (PPLV0 +PIE -PWE)
>   EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 000f0000 [FPD] (IS=3D ECode=3D15 EsubCode=3D0)
>   PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
>  Process kworker/0:5 (pid: 239, threadinfo=3D00000000927eadc6, task=3D000=
000008fd31682)
>  Stack : 00040dc000003164 0000000000000001 900000012f210130 900000012eabe=
eb8
>          900000012f000000 ffff80000319fe48 900000012f210000 900000012f210=
130
>          900000012f000000 900000012eabeeb8 0000000000000001 ffff8000031a0=
064
>          900000010575f9f0 900000012f210130 900000012eac0000 900000012ea80=
000
>          900000012f000000 ffff8000031cefc4 900000010575f9f0 ffff800003585=
9c0
>          ffff800003414000 900000010575fa78 900000012f000000 ffff8000031b4=
c50
>          0000000000000000 9000000101c9d700 9000000109c40000 5f5e9200f8901=
912
>          900000012d3c4bd0 900000012d3c5000 ffff8000034aed18 900000012d380=
010
>          900000012d3c4bd0 ffff800003414000 900000012d380000 ffff800002ea4=
9dc
>          0000000000000001 900000012d3c6000 00000000ffffe423 0000000000010=
000
>          ...
>  Call Trace:
>  [<ffff80000319de80>] dml21_apply_soc_bb_overrides+0x60/0x960 [amdgpu]
>  [<ffff80000319fe44>] dml21_init+0xa4/0x280 [amdgpu]
>  [<ffff8000031a0060>] dml21_create+0x40/0x80 [amdgpu]
>  [<ffff8000031cefc0>] dc_state_create+0x100/0x160 [amdgpu]
>  [<ffff8000031b4c4c>] dc_create+0x44c/0x640 [amdgpu]
>  [<ffff800002ea49d8>] amdgpu_dm_init+0x3f8/0x2060 [amdgpu]
>  [<ffff800002ea6658>] dm_hw_init+0x18/0x60 [amdgpu]
>  [<ffff800002b16738>] amdgpu_device_init+0x1938/0x27e0 [amdgpu]
>  [<ffff800002b18e80>] amdgpu_driver_load_kms+0x20/0xa0 [amdgpu]
>  [<ffff800002b0c8f0>] amdgpu_pci_probe+0x1b0/0x580 [amdgpu]
>  [<900000000448eae4>] local_pci_probe+0x44/0xc0
>  [<9000000003b02b18>] work_for_cpu_fn+0x18/0x40
>  [<9000000003b05da0>] process_one_work+0x160/0x300
>  [<9000000003b06718>] worker_thread+0x318/0x440
>  [<9000000003b11b8c>] kthread+0x12c/0x220
>  [<9000000003ac1484>] ret_from_kernel_thread+0x8/0xa4
>
> So protect dml2_create()/dml2_copy()/dml2_create_copy() with DC_FP_START
> and DC_FP_END.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_state.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_state.c
> index 1b2cce127981..6e2cac08002d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -210,17 +210,23 @@ struct dc_state *dc_state_create(struct dc *dc, str=
uct dc_state_create_params *p
>
>  #ifdef CONFIG_DRM_AMD_DC_FP
>         if (dc->debug.using_dml2) {
> +               DC_FP_START();
> +
>                 dml2_opt->use_clock_dc_limits =3D false;
>                 if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2)) {
> +                       DC_FP_END();
>                         dc_state_release(state);
>                         return NULL;
>                 }
>
>                 dml2_opt->use_clock_dc_limits =3D true;
>                 if (!dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_pow=
er_source)) {
> +                       DC_FP_END();
>                         dc_state_release(state);
>                         return NULL;
>                 }
> +
> +               DC_FP_END();
>         }
>  #endif
>
> @@ -240,6 +246,8 @@ void dc_state_copy(struct dc_state *dst_state, struct=
 dc_state *src_state)
>         dc_state_copy_internal(dst_state, src_state);
>
>  #ifdef CONFIG_DRM_AMD_DC_FP
> +       DC_FP_START();
> +
>         dst_state->bw_ctx.dml2 =3D dst_dml2;
>         if (src_state->bw_ctx.dml2)
>                 dml2_copy(dst_state->bw_ctx.dml2, src_state->bw_ctx.dml2)=
;
> @@ -247,6 +255,8 @@ void dc_state_copy(struct dc_state *dst_state, struct=
 dc_state *src_state)
>         dst_state->bw_ctx.dml2_dc_power_source =3D dst_dml2_dc_power_sour=
ce;
>         if (src_state->bw_ctx.dml2_dc_power_source)
>                 dml2_copy(dst_state->bw_ctx.dml2_dc_power_source, src_sta=
te->bw_ctx.dml2_dc_power_source);
> +
> +       DC_FP_END();
>  #endif
>
>         /* context refcount should not be overridden */
> @@ -268,17 +278,23 @@ struct dc_state *dc_state_create_copy(struct dc_sta=
te *src_state)
>         new_state->bw_ctx.dml2 =3D NULL;
>         new_state->bw_ctx.dml2_dc_power_source =3D NULL;
>
> +       DC_FP_START();
> +
>         if (src_state->bw_ctx.dml2 &&
>                         !dml2_create_copy(&new_state->bw_ctx.dml2, src_st=
ate->bw_ctx.dml2)) {
> +               DC_FP_END();
>                 dc_state_release(new_state);
>                 return NULL;
>         }
>
>         if (src_state->bw_ctx.dml2_dc_power_source &&
>                         !dml2_create_copy(&new_state->bw_ctx.dml2_dc_powe=
r_source, src_state->bw_ctx.dml2_dc_power_source)) {
> +               DC_FP_END();
>                 dc_state_release(new_state);
>                 return NULL;
>         }
> +
> +       DC_FP_END();
>  #endif
>
>         kref_init(&new_state->refcount);
> --
> 2.47.1
>

