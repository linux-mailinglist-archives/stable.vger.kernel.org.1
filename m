Return-Path: <stable+bounces-137053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23140AA0910
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7854B483C60
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2043275854;
	Tue, 29 Apr 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E36cSTi1"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6BE200130
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924456; cv=none; b=CIHqEAXcwANC7Cxbz1Ztg87b1JqO3f+ia/oUgbNRxM2zGK9DaXY1aZf6JAswKsyM2UdTWTEluvFeZRts669XT7gBk35Y25LPZjZ2bIXciOU6UPE9yIWjDTb0aoKMiVgr/7yV7PR83dIrVFpzo4g9du8CyNVYvH4NlBSuoPki8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924456; c=relaxed/simple;
	bh=4BsfPMt85RF+yieVNYkX12jdqliwvgqgNJdXL1vUxK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SH02qE+KlPAbV4nCEjp90qrI86vVqWa337aywksKBZ8y51CIbGd8WDTvWMNDh7izQT44NboQBUJbWmBKl8NbPWUIs+6x33guZT7hqD5CUJXjje7Hy/ggWv+KraIXGs2zTPyXoGdCcJUSx6mN6sET+PQochlPOvk2aDMj/nZMQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E36cSTi1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n9kw9NbSYa3wceyO5y7c71uxM/68avOApvxZH4c2MwE=; b=E36cSTi1oGm8NxzpxzRhA+Av9Y
	4AOGnN68ncaJQ/4LJv/lrsxR1f+37OXrrzRnxKN79L7q995CsGXCqi+YSxy9SrNXWi98ny7dgYvL/
	Kv18I1giiiZvB0oEoYeAbJe0R9mdBiepF90XPnP43+75O/GVYprwGFzVd5J9wbrWutCveCONvFYwA
	FCnrTXX1wmtymfjfEnwiVsDbvhug5B/i6vGsv28wk0rFEZBMSHJG0zeCFLxsdtCDLqR4VkrmBwgaP
	1kSm2HPpmgG0q3btRlDYNysrYJgBv5pu6wb4qZkPQtRcj/AFbOWR+ZtUQimfT2zwkhjEGX+yeVEwh
	9ZQAxwuA==;
Received: from 80.174.116.62.dyn.user.ono.com ([80.174.116.62] helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u9ihU-000HSZ-F2; Tue, 29 Apr 2025 13:00:47 +0200
Message-ID: <1a7a025cc4b75c3667a12a1ab4781a07b31026d5.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Add job to pending list if the reset was
 skipped
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	stable@vger.kernel.org, Daivik Bhatia <dtgs1208@gmail.com>
Date: Tue, 29 Apr 2025 13:00:36 +0200
In-Reply-To: <ace509ac67221d5a3e7215ea132c8155179850e4.camel@igalia.com>
References: <20250427202907.94415-2-mcanal@igalia.com>
	 <ace509ac67221d5a3e7215ea132c8155179850e4.camel@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Never mind, somehow I missed you're already doing that in this patch.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El lun, 28-04-2025 a las 07:45 +0200, Iago Toral escribi=C3=B3:
> Hi Maira,
>=20
> Looks good to me, but don't we need to do the same in
> v3d_csd_job_timedout?
>=20
> Iago
>=20
> El dom, 27-04-2025 a las 17:28 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > When a CL/CSD job times out, we check if the GPU has made any
> > progress
> > since the last timeout. If so, instead of resetting the hardware,
> > we
> > skip
> > the reset and let the timer get rearmed. This gives long-running
> > jobs
> > a
> > chance to complete.
> >=20
> > However, when `timedout_job()` is called, the job in question is
> > removed
> > from the pending list, which means it won't be automatically freed
> > through
> > `free_job()`. Consequently, when we skip the reset and keep the job
> > running, the job won't be freed when it finally completes.
> >=20
> > This situation leads to a memory leak, as exposed in [1].
> >=20
> > Similarly to commit 704d3d60fec4 ("drm/etnaviv: don't block
> > scheduler
> > when
> > GPU is still active"), this patch ensures the job is put back on
> > the
> > pending list when extending the timeout.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# 6.0
> > Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12227=C2=A0[1]
> > Reported-by: Daivik Bhatia <dtgs1208@gmail.com>
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > ---
> > =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 18 +++++++++++-------
> > =C2=A01 file changed, 11 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> > b/drivers/gpu/drm/v3d/v3d_sched.c
> > index b3be08b0ca91..a98dcf9d75b1 100644
> > --- a/drivers/gpu/drm/v3d/v3d_sched.c
> > +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> > @@ -734,11 +734,6 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d,
> > struct drm_sched_job *sched_job)
> > =C2=A0	return DRM_GPU_SCHED_STAT_NOMINAL;
> > =C2=A0}
> > =C2=A0
> > -/* If the current address or return address have changed, then the
> > GPU
> > - * has probably made progress and we should delay the reset.=C2=A0 Thi=
s
> > - * could fail if the GPU got in an infinite loop in the CL, but
> > that
> > - * is pretty unlikely outside of an i-g-t testcase.
> > - */
> > =C2=A0static enum drm_gpu_sched_stat
> > =C2=A0v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum
> > v3d_queue
> > q,
> > =C2=A0		=C2=A0=C2=A0=C2=A0 u32 *timedout_ctca, u32 *timedout_ctra)
> > @@ -748,9 +743,16 @@ v3d_cl_job_timedout(struct drm_sched_job
> > *sched_job, enum v3d_queue q,
> > =C2=A0	u32 ctca =3D V3D_CORE_READ(0, V3D_CLE_CTNCA(q));
> > =C2=A0	u32 ctra =3D V3D_CORE_READ(0, V3D_CLE_CTNRA(q));
> > =C2=A0
> > +	/* If the current address or return address have changed,
> > then the GPU
> > +	 * has probably made progress and we should delay the
> > reset.
> > This
> > +	 * could fail if the GPU got in an infinite loop in the
> > CL,
> > but that
> > +	 * is pretty unlikely outside of an i-g-t testcase.
> > +	 */
> > =C2=A0	if (*timedout_ctca !=3D ctca || *timedout_ctra !=3D ctra) {
> > =C2=A0		*timedout_ctca =3D ctca;
> > =C2=A0		*timedout_ctra =3D ctra;
> > +
> > +		list_add(&sched_job->list, &sched_job->sched-
> > > pending_list);
> > =C2=A0		return DRM_GPU_SCHED_STAT_NOMINAL;
> > =C2=A0	}
> > =C2=A0
> > @@ -790,11 +792,13 @@ v3d_csd_job_timedout(struct drm_sched_job
> > *sched_job)
> > =C2=A0	struct v3d_dev *v3d =3D job->base.v3d;
> > =C2=A0	u32 batches =3D V3D_CORE_READ(0, V3D_CSD_CURRENT_CFG4(v3d-
> > > ver));
> > =C2=A0
> > -	/* If we've made progress, skip reset and let the timer
> > get
> > -	 * rearmed.
> > +	/* If we've made progress, skip reset, add the job to the
> > pending
> > +	 * list, and let the timer get rearmed.
> > =C2=A0	 */
> > =C2=A0	if (job->timedout_batches !=3D batches) {
> > =C2=A0		job->timedout_batches =3D batches;
> > +
> > +		list_add(&sched_job->list, &sched_job->sched-
> > > pending_list);
> > =C2=A0		return DRM_GPU_SCHED_STAT_NOMINAL;
> > =C2=A0	}
> > =C2=A0
>=20


