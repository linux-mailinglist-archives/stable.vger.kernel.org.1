Return-Path: <stable+bounces-96320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5189E2411
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FEFB2CC4E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE31EF0BA;
	Tue,  3 Dec 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="InbymvZ0"
X-Original-To: stable@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579C3BB24
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236214; cv=none; b=mo+NKlbOl8BYIth5wU6vC63gFBkN2+y0/2kTwAT4wO1yIQW9pPeHRIQrzu4hPnEBkfwtIda4dIx2qH1sAjF2S+ZBsoHfpjSq1XkcrenUVvY41M56dJ73rczYa4Y/DRJIb26qRPhoTC3vIUjMiVtJGGOmKtyfYp4FteZS4EFbnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236214; c=relaxed/simple;
	bh=PHtKvKzqaN8QW8/YbaPhJiZhzChDD7GwWDJJvXBmbPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4Tcv5x7Py8vPYzUS2Fa6NgAJ5FNzOyXcTtoiMOR0zetm0P40hyh30pyMEljJ3+TfS8mMYiIsByFN/OHcHy83c4qOs9AZ/Jh7U+q376PRV6M34gKikKXdWExaxfYPJrfGi3yk7r2u7p9Qh/KAHt6crtZrlp9QfuRRZOFcl4OkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=InbymvZ0; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 3A0AD635B045;
	Tue, 03 Dec 2024 15:24:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1733235890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p2f9EBisy+fDJnijtk7RDLfWwOl8Sw+jW1RFq2kuCCc=;
	b=InbymvZ02J644ukZKBAyKjZU1qRpIpprETkYS6Ljos3bSlptWCVSNY/xgif43NjjPrgxbF
	kVfW5j+Yb+QaedO2jRAo79l2XRpt42w/ZRUrbrPun+rCD0sPKaCLyEyfF8X7kdWRBNwNRX
	d2/Wg+LNfpvqEBPZzFmTSeCh4fpYPTc=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <pstanner@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Make the submission path memory reclaim safe
Date: Tue, 03 Dec 2024 15:24:36 +0100
Message-ID: <2757527.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20241113134838.52608-1-tursulin@igalia.com>
References: <20241113134838.52608-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12561666.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12561666.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Tue, 03 Dec 2024 15:24:36 +0100
Message-ID: <2757527.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20241113134838.52608-1-tursulin@igalia.com>
References: <20241113134838.52608-1-tursulin@igalia.com>
MIME-Version: 1.0

On st=C5=99eda 13. listopadu 2024 14:48:38, st=C5=99edoevropsk=C3=BD standa=
rdn=C3=AD =C4=8Das Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> As commit 746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_ME=
M_RECLAIM")
> points out, ever since
> a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rathe=
r than kthread"),
> any workqueue flushing done from the job submission path must only
> involve memory reclaim safe workqueues to be safe against reclaim
> deadlocks.
>=20
> This is also pointed out by workqueue sanity checks:
>=20
>  [ ] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work [gpu_sched] i=
s flushing !WQ_MEM_RECLAIM events:amdgpu_device_delay_enable_gfx_off [amdgp=
u]
> ...
>  [ ] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> ...
>  [ ] Call Trace:
>  [ ]  <TASK>
> ...
>  [ ]  ? check_flush_dependency+0xf5/0x110
> ...
>  [ ]  cancel_delayed_work_sync+0x6e/0x80
>  [ ]  amdgpu_gfx_off_ctrl+0xab/0x140 [amdgpu]
>  [ ]  amdgpu_ring_alloc+0x40/0x50 [amdgpu]
>  [ ]  amdgpu_ib_schedule+0xf4/0x810 [amdgpu]
>  [ ]  ? drm_sched_run_job_work+0x22c/0x430 [gpu_sched]
>  [ ]  amdgpu_job_run+0xaa/0x1f0 [amdgpu]
>  [ ]  drm_sched_run_job_work+0x257/0x430 [gpu_sched]
>  [ ]  process_one_work+0x217/0x720
> ...
>  [ ]  </TASK>
>=20
> Fix this by creating a memory reclaim safe driver workqueue and make the
> submission path use it.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: 746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_=
MEM_RECLAIM")
> Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work queu=
e rather than kthread")
> Cc: stable@vger.kernel.org
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <pstanner@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  5 +++--
>  3 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 7645e498faa4..a6aad687537e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -268,6 +268,8 @@ extern int amdgpu_agp;
> =20
>  extern int amdgpu_wbrf;
> =20
> +extern struct workqueue_struct *amdgpu_reclaim_wq;
> +
>  #define AMDGPU_VM_MAX_NUM_CTX			4096
>  #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 38686203bea6..f5b7172e8042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -255,6 +255,8 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer =
=3D {
>  	.period =3D 0x0, /* default to 0x0 (timeout disable) */
>  };
> =20
> +struct workqueue_struct *amdgpu_reclaim_wq;
> +
>  /**
>   * DOC: vramlimit (int)
>   * Restrict the total amount of VRAM in MiB for testing.  The default is=
 0 (Use full VRAM).
> @@ -2971,6 +2973,21 @@ static struct pci_driver amdgpu_kms_pci_driver =3D=
 {
>  	.dev_groups =3D amdgpu_sysfs_groups,
>  };
> =20
> +static int amdgpu_wq_init(void)
> +{
> +	amdgpu_reclaim_wq =3D
> +		alloc_workqueue("amdgpu-reclaim", WQ_MEM_RECLAIM, 0);
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
>  static int __init amdgpu_init(void)
>  {
>  	int r;
> @@ -2978,6 +2995,10 @@ static int __init amdgpu_init(void)
>  	if (drm_firmware_drivers_only())
>  		return -EINVAL;
> =20
> +	r =3D amdgpu_wq_init();
> +	if (r)
> +		goto error_wq;
> +
>  	r =3D amdgpu_sync_init();
>  	if (r)
>  		goto error_sync;
> @@ -3006,6 +3027,9 @@ static int __init amdgpu_init(void)
>  	amdgpu_sync_fini();
> =20
>  error_sync:
> +	amdgpu_wq_fini();
> +
> +error_wq:
>  	return r;
>  }
> =20
> @@ -3017,6 +3041,7 @@ static void __exit amdgpu_exit(void)
>  	amdgpu_acpi_release();
>  	amdgpu_sync_fini();
>  	amdgpu_fence_slab_fini();
> +	amdgpu_wq_fini();
>  	mmu_notifier_synchronize();
>  	amdgpu_xcp_drv_release();
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2f3f09dfb1fd..f8fd71d9382f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -790,8 +790,9 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, =
bool enable)
>  						AMD_IP_BLOCK_TYPE_GFX, true))
>  					adev->gfx.gfx_off_state =3D true;
>  			} else {
> -				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
> -					      delay);
> +				queue_delayed_work(amdgpu_reclaim_wq,
> +						   &adev->gfx.gfx_off_delay_work,
> +						   delay);
>  			}
>  		}
>  	} else {

I can confirm this fixed the warning for me.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

What's the fate of this submission?

Thank you.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart12561666.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmdPFKQACgkQil/iNcg8
M0uaFQ//TWtXGh+QZvL2dQBjnQ+mB98FUGMflIvfyiN9/6XJ965LmXSnIdy51w2p
uO7KjxLlCfWPj2LC6kLqmibR4m9COFBVnQQRSsb6ZVRTLAtuh7OaANsFNO4KUytq
0PPhlfv9MabJiG9IN+qWmEFcv79uU0jocU/DFXQAq6iHEUwGJ2SiySXXuHdZ0EmU
qOGOd0VBRyHZEMp4PNEfdJ6KtYNrreha4wzpRR9Aj7Ed5xt4YAZcEMPQAr59qkNx
IDzx8tzswUGJfooaCPmn1/y1CaxBiMk5zjdiGRej/29yhbznsuG48pr1WlXGtYVW
Gy7Mj6PfoHlRFrJ77PIG6UcfmcUtHDszTcq2KDSCZtBJ4meBHiokVlkWIjtSHzj6
7BoHNQBRH0jf3wTkmBZkrIhrlnPduOD0QgK5oXl6wExft4g5CCn0C7plu6cQ3RFL
r0hFjJr0N/wCghk8jiCFCOjbcperKb2GCDMmn2tmRWilVTbPFqEQOwdOOSKcO/YH
djCGxFfrzZ8qdDfBLU8PDlP5yfVfiSMHEonPAvdekXxdSp70MZnM45b0VtakDNoB
ZV3Me1meaak1obFJnPWESA+yh/w7k2kUDVaoB8H62gYty5WTbsg4LxVtMriil2XU
pLHlSX2aYdnsMZnT2tUzc7O2f4gijXZga4hkxX1VaCOtQDOu0eA=
=MPVr
-----END PGP SIGNATURE-----

--nextPart12561666.O9o76ZdvQC--




