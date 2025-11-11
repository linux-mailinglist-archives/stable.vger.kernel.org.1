Return-Path: <stable+bounces-194497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3553C4E853
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FD93A25CB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24555207A20;
	Tue, 11 Nov 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYlpMEYK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLoNpnF3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC133AA194
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871453; cv=none; b=VQs6h5oaYY5daGN1piDufSj6I5GcTWHU1ceURR18IJomt8RNPJU9BtIZ7LrOMcsdPjKcGcVcoS+kwXbflfIo0gIDtsRE2cJcpQ4gn3TGew6cfu53PsuWLt7Wmcw0hp/iBJploNpSKppeSWArXnP58foauwV9l/apTiGDbB1o4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871453; c=relaxed/simple;
	bh=EDg6YmEAzbu/GOfwJqfdGomycl8LOXqUbfNFHSaUPzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sp57YUxamZO6HEnrcpgZ3lzPcaxKGpVSdm6yMaL/BPbGXgQHiA6Nf0U9KS29/30krKgRHm/JOgN9jRDlsXQzUh1o94csD3EreL+o3aAAIRR5et6+6+n0QYU6ZczqziK4NktuW0e7/mEmbbsHEJ7rD0EOSXOrBJgLKaOpBFFM3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYlpMEYK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLoNpnF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762871450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogR+cOwcd72jgQoTAFtAdbDI3BPnqSizGCNP3RzMtIM=;
	b=hYlpMEYKbZ6unAMye4NHSZ5ijimep3OvA6Cs3fejgbovvGebTnqrn8C6lS17J1fTtt4XYQ
	b70olLuJ/P2CUpM/biZnod7gyQ8kSR2MaqOvxxDOwOcOByu2o+VX77jAhZ0cTb5Z/P6ypO
	rx1S1+cbVVyj8sDe48bGsE+gxSOkhkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-MDCDyxCKNUSwG0YPjYVeWg-1; Tue, 11 Nov 2025 09:30:49 -0500
X-MC-Unique: MDCDyxCKNUSwG0YPjYVeWg-1
X-Mimecast-MFC-AGG-ID: MDCDyxCKNUSwG0YPjYVeWg_1762871448
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso31241875e9.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 06:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762871448; x=1763476248; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ogR+cOwcd72jgQoTAFtAdbDI3BPnqSizGCNP3RzMtIM=;
        b=TLoNpnF3SUFThvnVkFiOLHTkEWP7IMn3T8DIXWYasx65nzB8O2+I3PzFxw7VAxfQjq
         +9OpeQGjMDWYXk+k/QstZWLh8H91eKx+/Lziqvdgjj2LNCWjftUIwP8RDH0zSJtJ02/C
         6LUU1re2PWdRK6Oa/CV6l0BhEOuCT0NAluuOACDxLbUVV1hb26t0K134W4sRjDGZgm4N
         yUk2RGeqR1cVVm5zHTYeQO4ghoSjjLoYJHHcnlTRgB+WDL0uGl4QDUueyTmrG3KFEWOK
         6+obr0E8BVeRKsaeWlSnZ6WYFCsCOpCZaPruLvY2s4qihuFo5BilneNXq1xfcH8d+8iW
         +PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871448; x=1763476248;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogR+cOwcd72jgQoTAFtAdbDI3BPnqSizGCNP3RzMtIM=;
        b=ZtBFh4GvtMmqcBGMPL4njUQxvx1P++6iqa41VkU3HohM8x02epRmigl8ZAoCm+PzhP
         B7t8yPynVARbpPjA13PvRyF7QAQjmd1+vAAXEDaxDFd2s5/abvhI4LPPPGljrTQUOISB
         T84bXAAaZFoeQe+Ukuz+JEyRDIx93r2ZRNTC5upbnjWE+rUuSrvGIhVjeorOUwAYVG+E
         i9RAqbP3FJ94px0oCr/yFC3O7TnSVuRfR2/QCftoPR2+/BGnN0PO4BnvxVrKAxpkj+tP
         FWWj/cQ9so0m/cSikA4ZqUozeLFHnF8ZRKHJbM7tJNNd83ct9+qtZ2/sQtssMDP1IBBW
         cecg==
X-Forwarded-Encrypted: i=1; AJvYcCWpHUK2J0sze6U2iVK7enKhGELYEIESKjCP5G2cHmdX4t6R6MwB9W0U/kjTHOjadokMSkoxhiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHwF3cUDk2fe7teO5KcUP/9K8Xd7ghevdyIfJOzw3Z3PhETu5
	TO7kwUb8AEeoMZ3g0319OLDvUzcfs9NRNDqb2MDmcE/pwYNhTxST3mIbPecgIa1uKYIA7LtIm2B
	k1lpHIlSjk8RX2A9FvOhgiyGW/NFOAv6/LeH3hMQKu3TDDvp3mxN8Z1FFqw==
X-Gm-Gg: ASbGnct5DHSuLV3UuIo9ap33EDNXyCA2hk/g5VC37NXrqV5mr6syin/yC5VNyDTPxZQ
	QOFcJ2MiuaPSlr/CCnVca9bn/15CxjaNipr8hJKqiFbjanz+fJi2/beG/e5mtLVDJ948FxxaSQG
	TxdxY3YJrOzHxV34LmZSXc1wVVnuTtENMBrfluUYdEmqmCT2K1Ag6hwuZrf0jNdHJ2X1veWx1cG
	JLibjh/d7LPQOieovEWWkAbW2UoKEyWm/fCBkqVy0LjVCavX4E7mTaspOm9co7HXdYzYBv7+xGo
	Ib8RUYRwDCNBMUl+kBkmU+bIp0mUeYSjf4rmknSe53DMLBJo6anipqPsvXJ7s7uo4nkNl33wGzG
	kaIBEB7l4LEhdb8+UWyer/Oyknw==
X-Received: by 2002:a05:600c:1381:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4777328f2a6mr123871485e9.28.1762871448190;
        Tue, 11 Nov 2025 06:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGug/PeuPcxtjEEu7qSWA6IfTJ6My/ez4ZrKcgwBAQv1Ogvzt5befPXheYjkD2Wk7l51Jwk8w==
X-Received: by 2002:a05:600c:1381:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4777328f2a6mr123871115e9.28.1762871447736;
        Tue, 11 Nov 2025 06:30:47 -0800 (PST)
Received: from [10.200.68.138] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm261513135e9.15.2025.11.11.06.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:30:47 -0800 (PST)
Message-ID: <b239f2abb28d4e5dfc36c67bb6b88975a63c11e6.camel@redhat.com>
Subject: Re: [PATCH 6.12 084/565] drm/sched: Re-group and rename the entity
 run-queue lock
From: Philipp Stanner <pstanner@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, Sasha Levin <sashal@kernel.org>
Date: Tue, 11 Nov 2025 15:30:45 +0100
In-Reply-To: <20251111004528.857251276@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
	 <20251111004528.857251276@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-11 at 09:39 +0900, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.=C2=A0 If anyone has any objections, please let =
me know.

This and patch 83 are mere code improvements, not bug fixes.


P.

>=20
> ------------------
>=20
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> [ Upstream commit f93126f5d55920d1447ef00a3fbe6706f40f53de ]
>=20
> When writing to a drm_sched_entity's run-queue, writers are protected
> through the lock drm_sched_entity.rq_lock. This naming, however,
> frequently collides with the separate internal lock of struct
> drm_sched_rq, resulting in uses like this:
>=20
> 	spin_lock(&entity->rq_lock);
> 	spin_lock(&entity->rq->lock);
>=20
> Rename drm_sched_entity.rq_lock to improve readability. While at it,
> re-order that struct's members to make it more obvious what the lock
> protects.
>=20
> v2:
> =C2=A0* Rename some rq_lock straddlers in kerneldoc, improve commit text.=
 (Philipp)
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> [pstanner: Fix typo in docstring]
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-5=
-tursulin@igalia.com
> Stable-dep-of: d25e3a610bae ("drm/sched: Fix race in drm_sched_entity_sel=
ect_rq()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c |=C2=A0=C2=A0 28 +++++++++=
+++++--------------
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 2 +-
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 21 +++++++++++-------=
---
> =C2=A03 files changed, 26 insertions(+), 25 deletions(-)
>=20
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -106,7 +106,7 @@ int drm_sched_entity_init(struct drm_sch
> =C2=A0	/* We start in an idle state. */
> =C2=A0	complete_all(&entity->entity_idle);
> =C2=A0
> -	spin_lock_init(&entity->rq_lock);
> +	spin_lock_init(&entity->lock);
> =C2=A0	spsc_queue_init(&entity->job_queue);
> =C2=A0
> =C2=A0	atomic_set(&entity->fence_seq, 0);
> @@ -134,10 +134,10 @@ void drm_sched_entity_modify_sched(struc
> =C2=A0{
> =C2=A0	WARN_ON(!num_sched_list || !sched_list);
> =C2=A0
> -	spin_lock(&entity->rq_lock);
> +	spin_lock(&entity->lock);
> =C2=A0	entity->sched_list =3D sched_list;
> =C2=A0	entity->num_sched_list =3D num_sched_list;
> -	spin_unlock(&entity->rq_lock);
> +	spin_unlock(&entity->lock);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> =C2=A0
> @@ -246,10 +246,10 @@ static void drm_sched_entity_kill(struct
> =C2=A0	if (!entity->rq)
> =C2=A0		return;
> =C2=A0
> -	spin_lock(&entity->rq_lock);
> +	spin_lock(&entity->lock);
> =C2=A0	entity->stopped =3D true;
> =C2=A0	drm_sched_rq_remove_entity(entity->rq, entity);
> -	spin_unlock(&entity->rq_lock);
> +	spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0	/* Make sure this entity is not used by the scheduler at the momen=
t */
> =C2=A0	wait_for_completion(&entity->entity_idle);
> @@ -395,9 +395,9 @@ static void drm_sched_entity_wakeup(stru
> =C2=A0void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
> =C2=A0				=C2=A0=C2=A0 enum drm_sched_priority priority)
> =C2=A0{
> -	spin_lock(&entity->rq_lock);
> +	spin_lock(&entity->lock);
> =C2=A0	entity->priority =3D priority;
> -	spin_unlock(&entity->rq_lock);
> +	spin_unlock(&entity->lock);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_set_priority);
> =C2=A0
> @@ -507,10 +507,10 @@ struct drm_sched_job *drm_sched_entity_p
> =C2=A0
> =C2=A0		next =3D to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
> =C2=A0		if (next) {
> -			spin_lock(&entity->rq_lock);
> +			spin_lock(&entity->lock);
> =C2=A0			drm_sched_rq_update_fifo_locked(entity,
> =C2=A0							next->submit_ts);
> -			spin_unlock(&entity->rq_lock);
> +			spin_unlock(&entity->lock);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -551,14 +551,14 @@ void drm_sched_entity_select_rq(struct d
> =C2=A0	if (fence && !dma_fence_is_signaled(fence))
> =C2=A0		return;
> =C2=A0
> -	spin_lock(&entity->rq_lock);
> +	spin_lock(&entity->lock);
> =C2=A0	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sche=
d_list);
> =C2=A0	rq =3D sched ? sched->sched_rq[entity->priority] : NULL;
> =C2=A0	if (rq !=3D entity->rq) {
> =C2=A0		drm_sched_rq_remove_entity(entity->rq, entity);
> =C2=A0		entity->rq =3D rq;
> =C2=A0	}
> -	spin_unlock(&entity->rq_lock);
> +	spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0	if (entity->num_sched_list =3D=3D 1)
> =C2=A0		entity->sched_list =3D NULL;
> @@ -599,9 +599,9 @@ void drm_sched_entity_push_job(struct dr
> =C2=A0		struct drm_sched_rq *rq;
> =C2=A0
> =C2=A0		/* Add the entity to the run queue */
> -		spin_lock(&entity->rq_lock);
> +		spin_lock(&entity->lock);
> =C2=A0		if (entity->stopped) {
> -			spin_unlock(&entity->rq_lock);
> +			spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0			DRM_ERROR("Trying to push to a killed entity\n");
> =C2=A0			return;
> @@ -615,7 +615,7 @@ void drm_sched_entity_push_job(struct dr
> =C2=A0		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> =C2=A0			drm_sched_rq_update_fifo_locked(entity, submit_ts);
> =C2=A0
> -		spin_unlock(&entity->rq_lock);
> +		spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0		drm_sched_wakeup(sched);
> =C2=A0	}
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -176,7 +176,7 @@ void drm_sched_rq_update_fifo_locked(str
> =C2=A0	 * for entity from within concurrent drm_sched_entity_select_rq an=
d the
> =C2=A0	 * other to update the rb tree structure.
> =C2=A0	 */
> -	lockdep_assert_held(&entity->rq_lock);
> +	lockdep_assert_held(&entity->lock);
> =C2=A0
> =C2=A0	spin_lock(&entity->rq->lock);
> =C2=A0
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -97,13 +97,21 @@ struct drm_sched_entity {
> =C2=A0	struct list_head		list;
> =C2=A0
> =C2=A0	/**
> +	 * @lock:
> +	 *
> +	 * Lock protecting the run-queue (@rq) to which this entity belongs,
> +	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
> +	 */
> +	spinlock_t			lock;
> +
> +	/**
> =C2=A0	 * @rq:
> =C2=A0	 *
> =C2=A0	 * Runqueue on which this entity is currently scheduled.
> =C2=A0	 *
> =C2=A0	 * FIXME: Locking is very unclear for this. Writers are protected =
by
> -	 * @rq_lock, but readers are generally lockless and seem to just race
> -	 * with not even a READ_ONCE.
> +	 * @lock, but readers are generally lockless and seem to just race with
> +	 * not even a READ_ONCE.
> =C2=A0	 */
> =C2=A0	struct drm_sched_rq		*rq;
> =C2=A0
> @@ -136,18 +144,11 @@ struct drm_sched_entity {
> =C2=A0	 * @priority:
> =C2=A0	 *
> =C2=A0	 * Priority of the entity. This can be modified by calling
> -	 * drm_sched_entity_set_priority(). Protected by &rq_lock.
> +	 * drm_sched_entity_set_priority(). Protected by @lock.
> =C2=A0	 */
> =C2=A0	enum drm_sched_priority=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 priority;
> =C2=A0
> =C2=A0	/**
> -	 * @rq_lock:
> -	 *
> -	 * Lock to modify the runqueue to which this entity belongs.
> -	 */
> -	spinlock_t			rq_lock;
> -
> -	/**
> =C2=A0	 * @job_queue: the list of jobs of this entity.
> =C2=A0	 */
> =C2=A0	struct spsc_queue		job_queue;
>=20
>=20


