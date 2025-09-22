Return-Path: <stable+bounces-180978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3DB91EED
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01A37A46AC
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06612E6CD6;
	Mon, 22 Sep 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNPIp9tK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AA1A9FB4
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555034; cv=none; b=XyvR3V2CtOJjGfUt/aptymXJ8qzwkHXBYsGUMdZoGAOVhnVYpaGNGNs+tf4rCKc5y6e1l4Fxe5Y3Rc5V+7UFOLl83Mdrs6hD9nQD8IpkTmHaRHV30Pqf8ip1/E4Ac7jy2hRyu6LQSNXBLZZ7Wy1hBLwbMN7FyFomM2eEgdJh7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555034; c=relaxed/simple;
	bh=JEoWLQma3d9C5FlCU7NvQnl5f7JFiM3FrFqHNVuMSIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LovtEBttuA9cewu/0yjaxRK4ScPsv/7qZCKc9vS/5WyogoZ+Qzw56eOq2vrozH07ivoAf/5Ou62hFrAZrgy7+2CqdlKjLGlAoiSnaCjpveE08Wv9Hu1eoQZrahu7Voh6M2LqpmR+of8G402Onx6keZSdvQtMdPjBfVV89g12iPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNPIp9tK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758555031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDFZbpyvGnhx7ADmCrJggW1kUKxNmWW7JZfnJs2xw3E=;
	b=KNPIp9tKd5+buovBWblA1oQDnB3nZMZXDquvVHVA8Cl7zvBaVDTrV9xz5oG6H+z7MYe2FM
	q0CV5KRaEhuXatiDjJOowJ0Q8kJ17rfSIEVlI4xXIiVFLJaCXaaYDyrhOzPhpCy9AWi83k
	BCUrTEOZJX9nrCMz+001lmqo78IAGIU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-CxOf9nTBO9CDK9h61jiDRQ-1; Mon, 22 Sep 2025 11:30:30 -0400
X-MC-Unique: CxOf9nTBO9CDK9h61jiDRQ-1
X-Mimecast-MFC-AGG-ID: CxOf9nTBO9CDK9h61jiDRQ_1758555029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f3787688b0so1066892f8f.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555028; x=1759159828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDFZbpyvGnhx7ADmCrJggW1kUKxNmWW7JZfnJs2xw3E=;
        b=Lv9VwSjwAwiyh2xXFEKNHMWAvy+0PJw00LJgq8awzGEX/uV1udH4wnpfK16+iCV7vB
         1Wrg7Jkx//jN8ABEw0Yv2meQ/KyWGmx4x9ChcqV5ZlZH5MXwmwQ+DDAcCRcOqWQ7AsC+
         EkRwxrMOrWt9MHaTjTNtZ9YFZedGuJFHHQKRkdaB/AryEDQMzdLb9nOCKHq+YidC+xi7
         DCyGS/eD8HqTnk2BEf7DG/E0douKiiui+0Vyje7kjJeTjiUO3uVNK4nL46o7k+RFj8MB
         cl5QdXQoM5DuqTrwoRDN7Vi2WTcWPwgvZPD5GN4hagoAQllDuFIsLSedsQ6lQqSLwYUf
         fUBA==
X-Forwarded-Encrypted: i=1; AJvYcCU7M1F58GXcUTtmvI4GtfnsiTzHRMtQedJUK3uvA+xHhyyJq1aOAr6desys11pYRcmwOcBGLk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cs3ouo0CqH7W4XqeqjBN92ZXNim195n71gKPaVaX7xnT6cQU
	YSxgKC2fsnnzUFMVfMpg2Kd05WbEtQmBTO2hndMCIv1rnqJhYVh+ed0paxNhthk8OgwbddalhnM
	5jh5treDTuunuvKWFIQxePf/5KHV3BXjmOydN/QPDFn4VIm7dAf/rDAav7M/fh9wiOg==
X-Gm-Gg: ASbGnct6wyVnWRHP4mMf73OHwFKehLc2ywGhHeDt1NJRElbuop5DvGOoPWIYZthuowW
	YJ4elcdWYptHoF5z6yjxNG3QsuA6GyySwvJ6vYwDfNEv29QLAGk0Wwrljl8Ew8Tane0n+EuVLrN
	fmImXrtHr16SnmSY9qkGVXxW66TZymzGuTnMCcU5MJFgng0pKy+O5g3Z6Fdp5IGeZUvOEgAt+bY
	gsgkHXakS0BWHeriKVs6a88kRBRM6SjoQxgZnRYUoUtP6RBHVRucavUH3mZkHs2xeU8Jzi4tcrk
	ZxWiyl1aCLJ30Ji49n8rmtW7NjN+BrhKTgQ33udy/UvzwyEIqeKDGqRCgsV006munQ==
X-Received: by 2002:a5d:5846:0:b0:3e7:4835:8eeb with SMTP id ffacd0b85a97d-3ee86d6cfbfmr11687249f8f.53.1758555028442;
        Mon, 22 Sep 2025 08:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCAOkKFTVFDfFCG7poxpWc2m1ZarKrUdEd7Dh40ZUlbSwp6VnnIr9BzKAGWmopfDr1MCCvDA==
X-Received: by 2002:a5d:5846:0:b0:3e7:4835:8eeb with SMTP id ffacd0b85a97d-3ee86d6cfbfmr11687208f8f.53.1758555027927;
        Mon, 22 Sep 2025 08:30:27 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-403ec628ff7sm666524f8f.4.2025.09.22.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:30:27 -0700 (PDT)
Message-ID: <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Jules Maselbas <jmaselbas@zdiv.net>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>
Date: Mon, 22 Sep 2025 17:30:26 +0200
In-Reply-To: <20250922130948.5549-1-jmaselbas@zdiv.net>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
>=20
> In FIFO mode (which is the default), both drm_sched_entity_push_job() and
> drm_sched_rq_update_fifo(), where the latter calls the former, are
> currently taking and releasing the same entity->rq_lock.
>=20
> We can avoid that design inelegance, and also have a miniscule
> efficiency improvement on the submit from idle path, by introducing a new
> drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking t=
o
> its callers.
>=20
> v2:
> =C2=A0* Remove drm_sched_rq_update_fifo() altogether. (Christian)
>=20
> v3:
> =C2=A0* Improved commit message. (Philipp)
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-2=
-tursulin@igalia.com
> (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>

Am I interpreting this mail correctly: you want to get this patch into
stable?

Why? It doesn't fix a bug.


P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++----
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A03 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 3e75fc1f6607..9dbae7b08bc9 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -505,8 +505,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struc=
t drm_sched_entity *entity)
> =C2=A0		struct drm_sched_job *next;
> =C2=A0
> =C2=A0		next =3D to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
> -		if (next)
> -			drm_sched_rq_update_fifo(entity, next->submit_ts);
> +		if (next) {
> +			spin_lock(&entity->rq_lock);
> +			drm_sched_rq_update_fifo_locked(entity,
> +							next->submit_ts);
> +			spin_unlock(&entity->rq_lock);
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Jobs and entities might have different lifecycles. Since we're
> @@ -606,10 +610,11 @@ void drm_sched_entity_push_job(struct drm_sched_job=
 *sched_job)
> =C2=A0		sched =3D rq->sched;
> =C2=A0
> =C2=A0		drm_sched_rq_add_entity(rq, entity);
> -		spin_unlock(&entity->rq_lock);
> =C2=A0
> =C2=A0		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> -			drm_sched_rq_update_fifo(entity, submit_ts);
> +			drm_sched_rq_update_fifo_locked(entity, submit_ts);
> +
> +		spin_unlock(&entity->rq_lock);
> =C2=A0
> =C2=A0		drm_sched_wakeup(sched);
> =C2=A0	}
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 416590ea0dc3..3609d5a8fecd 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -169,14 +169,15 @@ static inline void drm_sched_rq_remove_fifo_locked(=
struct drm_sched_entity *enti
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t t=
s)
> +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, kt=
ime_t ts)
> =C2=A0{
> =C2=A0	/*
> =C2=A0	 * Both locks need to be grabbed, one to protect from entity->rq c=
hange
> =C2=A0	 * for entity from within concurrent drm_sched_entity_select_rq an=
d the
> =C2=A0	 * other to update the rb tree structure.
> =C2=A0	 */
> -	spin_lock(&entity->rq_lock);
> +	lockdep_assert_held(&entity->rq_lock);
> +
> =C2=A0	spin_lock(&entity->rq->lock);
> =C2=A0
> =C2=A0	drm_sched_rq_remove_fifo_locked(entity);
> @@ -187,7 +188,6 @@ void drm_sched_rq_update_fifo(struct drm_sched_entity=
 *entity, ktime_t ts)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compare_before);
> =C2=A0
> =C2=A0	spin_unlock(&entity->rq->lock);
> -	spin_unlock(&entity->rq_lock);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 9c437a057e5d..346a3c261b43 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -593,7 +593,7 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
> =C2=A0void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> =C2=A0				struct drm_sched_entity *entity);
> =C2=A0
> -void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t t=
s);
> +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, kt=
ime_t ts);
> =C2=A0
> =C2=A0int drm_sched_entity_init(struct drm_sched_entity *entity,
> =C2=A0			=C2=A0 enum drm_sched_priority priority,


