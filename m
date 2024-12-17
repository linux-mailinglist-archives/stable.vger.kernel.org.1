Return-Path: <stable+bounces-104468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9059F490D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22859163B76
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D91E260D;
	Tue, 17 Dec 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8JhTnAX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF001DDC3F
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431979; cv=none; b=ZYaggCahG0toH+LucMZroLMe8LRVZkGmD1GltaLvDvFXEl0kNcsq1QkhIqXh0iAQPe5CiGTTlH2Fnl8E1+6AlSzW6AMDuBwq64YZ9YAp0vjSXwzXXFFmNy01falwuUWyYZVf7Xn9Ussv3RG/yyZ3WWaqFv+lyU6W06J9WQm3qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431979; c=relaxed/simple;
	bh=4FlJ4pwzfrzyfs4C+TnGpt9Q8noM2mZf0GbooS0TYzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsXXfgTl6Jo+Dg2zp03E96tAtZ1VyU+Rk/OLH69aNEbpAPG04GZiKqmiOs6yTPNN35okwwYdXrzVX93g4KIJZXMJePRHyjajp4QnA4Qkc9US37iQDIZOctRtCA3PsVgw8iSYv1ddDYwqkh0mdlrHZOUvK+F45yyo0/ZMNS+AyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8JhTnAX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734431976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAhqXekStZLW/RVUK6Cn2kQz4T1FsFdb2Ctzh50D66Q=;
	b=i8JhTnAXDCTCYtoSbeAPE7r5Wqzgj6bwD3nVZdXevjFeSbUSrt8N4yc0JCBSOiEPt2M3vk
	MxYGDy9rlKDAbupUGXqRHs35NpOSwKEzlufS+aXar8NEwf4GJrMtFfSJKTwlNdvPeElg7K
	Br1A4WTAnzXjkpoJj03wSeoIbtvaydI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Ia4U4nWaMROOHzw4Biuouw-1; Tue, 17 Dec 2024 05:39:34 -0500
X-MC-Unique: Ia4U4nWaMROOHzw4Biuouw-1
X-Mimecast-MFC-AGG-ID: Ia4U4nWaMROOHzw4Biuouw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-386321c8f4bso2754816f8f.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 02:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431973; x=1735036773;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAhqXekStZLW/RVUK6Cn2kQz4T1FsFdb2Ctzh50D66Q=;
        b=wNuIJToC3zPy0/91ZQUaCsflgeUSUYDu+QpUXfaAMEz4k2eWUO9MuFOolOLmFnDGB2
         3DWZgJq3INgcR0tUxsEXvF3+qaiSDBEoVO84b0zfbmltWHmW0yWpNwGeyEGjacao51sU
         K5zfAFNAFY63ldHxpX4CBZuZRcH+6sfyY3E1vUcAarbqKekJL6X1xxIXSRKQsfel5ByT
         F6jZEhRWu4z5XN7sVUe/a7T0CTl52vpDTmf58TKOo2Yx7Cgjvm99d8j5FIWkpWE/0U0I
         VE3NUpyHGRdPkoIjJujwr6ZFnlmOBDFHHseLJdKluq8NYtMgJWnqJmxDz+Zeve9u9e1V
         Bvfw==
X-Forwarded-Encrypted: i=1; AJvYcCX6d/7gelH37uaag8QGxhMo4AdUQenTs4OjZhvzANi/N8NRnEll34pVU1ZoxhNwYX0/MMCqP9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG9jfyIi0n4Rt/qLLgRUQ9neq+1t4S6fDzh4T5toCG2Wb7bYx
	8dwaJ8VKUVjPteC/CMMuV27SixcWSEvmspZij8/KM0nG07CNDI05hM4rdBKD+EnEro+h6dmMzUX
	v8TSUNnbA0tI+5A4vGXIjUxqZrtaa51+6zsE+mm6RuwP/ec7uyPxunw==
X-Gm-Gg: ASbGncu61YGmk4iuJDDGZI1zzqjr2zahiykQc5Gy3Xh3scMCBlHXRpTsqdwd4z6aLxW
	zbPo/XNg7fb/bE7ZVK18z9ecr+z6u/WoBov415bQRPcYJ7bt7MF1zZK18HUDdY3hPhTc5aINNmG
	0KmGVjpjMzhLSRy6nFEqPMt/5LB0OAu+XYvSv8xIOUysK/3HFZYzhD5Rwo8GfyNWjqX5OaYTypN
	7oBPCiGVLl3SntwiY3wfhPTnT2l0+W448M03oVV9HDklmZSr1p+jM+IhZASUfDY3HkIV69Lw6op
	NVrl89Y=
X-Received: by 2002:a05:6000:4716:b0:386:3a8e:64c1 with SMTP id ffacd0b85a97d-38880acda3emr11768504f8f.19.1734431973563;
        Tue, 17 Dec 2024 02:39:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDWpTSANouY9f/p66qX2YasuCynxUZ2pre4ezk5mGcNOMj159D3nD9EXVG1Ms9mE2tLc1YmA==
X-Received: by 2002:a05:6000:4716:b0:386:3a8e:64c1 with SMTP id ffacd0b85a97d-38880acda3emr11768471f8f.19.1734431973180;
        Tue, 17 Dec 2024 02:39:33 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046f8bsm10670302f8f.68.2024.12.17.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:39:32 -0800 (PST)
Message-ID: <637b5d0b19ce90d6b94c937be8055977c62bd158.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu: Make the submission path memory reclaim safe
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Date: Tue, 17 Dec 2024 11:39:31 +0100
In-Reply-To: <20241113134838.52608-1-tursulin@igalia.com>
References: <20241113134838.52608-1-tursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[+cc Krzysztof, who I think witnessed a possibly related Kernel crash
in the wild]

P.

On Wed, 2024-11-13 at 13:48 +0000, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> As commit 746ae46c1113 ("drm/sched: Mark scheduler work queues with
> WQ_MEM_RECLAIM")
> points out, ever since
> a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue
> rather than kthread"),
> any workqueue flushing done from the job submission path must only
> involve memory reclaim safe workqueues to be safe against reclaim
> deadlocks.
>=20
> This is also pointed out by workqueue sanity checks:
>=20
> =C2=A0[ ] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work
> [gpu_sched] is flushing !WQ_MEM_RECLAIM
> events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> ...
> =C2=A0[ ] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> ...
> =C2=A0[ ] Call Trace:
> =C2=A0[ ]=C2=A0 <TASK>
> ...
> =C2=A0[ ]=C2=A0 ? check_flush_dependency+0xf5/0x110
> ...
> =C2=A0[ ]=C2=A0 cancel_delayed_work_sync+0x6e/0x80
> =C2=A0[ ]=C2=A0 amdgpu_gfx_off_ctrl+0xab/0x140 [amdgpu]
> =C2=A0[ ]=C2=A0 amdgpu_ring_alloc+0x40/0x50 [amdgpu]
> =C2=A0[ ]=C2=A0 amdgpu_ib_schedule+0xf4/0x810 [amdgpu]
> =C2=A0[ ]=C2=A0 ? drm_sched_run_job_work+0x22c/0x430 [gpu_sched]
> =C2=A0[ ]=C2=A0 amdgpu_job_run+0xaa/0x1f0 [amdgpu]
> =C2=A0[ ]=C2=A0 drm_sched_run_job_work+0x257/0x430 [gpu_sched]
> =C2=A0[ ]=C2=A0 process_one_work+0x217/0x720
> ...
> =C2=A0[ ]=C2=A0 </TASK>
>=20
> Fix this by creating a memory reclaim safe driver workqueue and make
> the
> submission path use it.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: 746ae46c1113 ("drm/sched: Mark scheduler work queues with
> WQ_MEM_RECLAIM")
> Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work
> queue rather than kthread")
> Cc: stable@vger.kernel.org
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <pstanner@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25
> +++++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |=C2=A0 5 +++--
> =C2=A03 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7645e498faa4..a6aad687537e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -268,6 +268,8 @@ extern int amdgpu_agp;
> =C2=A0
> =C2=A0extern int amdgpu_wbrf;
> =C2=A0
> +extern struct workqueue_struct *amdgpu_reclaim_wq;
> +
> =C2=A0#define AMDGPU_VM_MAX_NUM_CTX			4096
> =C2=A0#define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> =C2=A0#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 38686203bea6..f5b7172e8042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -255,6 +255,8 @@ struct amdgpu_watchdog_timer
> amdgpu_watchdog_timer =3D {
> =C2=A0	.period =3D 0x0, /* default to 0x0 (timeout disable) */
> =C2=A0};
> =C2=A0
> +struct workqueue_struct *amdgpu_reclaim_wq;
> +
> =C2=A0/**
> =C2=A0 * DOC: vramlimit (int)
> =C2=A0 * Restrict the total amount of VRAM in MiB for testing.=C2=A0 The
> default is 0 (Use full VRAM).
> @@ -2971,6 +2973,21 @@ static struct pci_driver amdgpu_kms_pci_driver
> =3D {
> =C2=A0	.dev_groups =3D amdgpu_sysfs_groups,
> =C2=A0};
> =C2=A0
> +static int amdgpu_wq_init(void)
> +{
> +	amdgpu_reclaim_wq =3D
> +		alloc_workqueue("amdgpu-reclaim", WQ_MEM_RECLAIM,
> 0);
> +	if (!amdgpu_reclaim_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void amdgpu_wq_fini(void)
> +{
> +	destroy_workqueue(amdgpu_reclaim_wq);
> +}
> +
> =C2=A0static int __init amdgpu_init(void)
> =C2=A0{
> =C2=A0	int r;
> @@ -2978,6 +2995,10 @@ static int __init amdgpu_init(void)
> =C2=A0	if (drm_firmware_drivers_only())
> =C2=A0		return -EINVAL;
> =C2=A0
> +	r =3D amdgpu_wq_init();
> +	if (r)
> +		goto error_wq;
> +
> =C2=A0	r =3D amdgpu_sync_init();
> =C2=A0	if (r)
> =C2=A0		goto error_sync;
> @@ -3006,6 +3027,9 @@ static int __init amdgpu_init(void)
> =C2=A0	amdgpu_sync_fini();
> =C2=A0
> =C2=A0error_sync:
> +	amdgpu_wq_fini();
> +
> +error_wq:
> =C2=A0	return r;
> =C2=A0}
> =C2=A0
> @@ -3017,6 +3041,7 @@ static void __exit amdgpu_exit(void)
> =C2=A0	amdgpu_acpi_release();
> =C2=A0	amdgpu_sync_fini();
> =C2=A0	amdgpu_fence_slab_fini();
> +	amdgpu_wq_fini();
> =C2=A0	mmu_notifier_synchronize();
> =C2=A0	amdgpu_xcp_drv_release();
> =C2=A0}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2f3f09dfb1fd..f8fd71d9382f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -790,8 +790,9 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
> *adev, bool enable)
> =C2=A0						AMD_IP_BLOCK_TYPE_GF
> X, true))
> =C2=A0					adev->gfx.gfx_off_state =3D
> true;
> =C2=A0			} else {
> -				schedule_delayed_work(&adev-
> >gfx.gfx_off_delay_work,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delay);
> +				queue_delayed_work(amdgpu_reclaim_wq
> ,
> +						=C2=A0=C2=A0 &adev-
> >gfx.gfx_off_delay_work,
> +						=C2=A0=C2=A0 delay);
> =C2=A0			}
> =C2=A0		}
> =C2=A0	} else {


