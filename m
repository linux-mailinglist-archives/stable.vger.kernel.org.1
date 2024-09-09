Return-Path: <stable+bounces-74014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D8971905
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA31285E1A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EF1B6535;
	Mon,  9 Sep 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIChLN0I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF21B29C7
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884038; cv=none; b=dTJ1sH31C4VMh1Sbxjo00MrOlYZYVAxYh7uoTSV9Zp2LAdqyrMjj5GjnbeYg2O6DvBNpScujFfYuRJaq7gxdvd8h3NZwZ4raJ7hZRu2uUC7MzcAz6klu+CDIW1JFAiD4WDueEMgNbPidZHwcpg5gDvtl9hVfUN755opbKBg0yaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884038; c=relaxed/simple;
	bh=Q0aM9Y1aDwnToIiWtYfKEPONx6JbXHlX/WPtLIs2mgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSeZMhkBuLiNaavd1kSEhxU3HGw/2aYWtNbZHLCyFnmea1k6oIVTVAhGfmW+LEd21tTE+5mlpIJycxB9C7msR17OIwzdipUY9KIOOnVTpjdtFfQSXzDbBfZXH8IbBCaeT/vqanyyMl5UShRUmhHj2EHp5wchZT5hqpRqFHya9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIChLN0I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725884035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkATp1QtmV3cfFCcvxrwKHj5NzaYjxngX1fAPFVvMdU=;
	b=UIChLN0IEPCRUIp7fOqSSO2ennMmUaLiCYqSpYfxcOvajiEMhTpZ+EOAJSXb385uEIsp7D
	LGLPQm1f4va1C5Ce6g+gnBfpdfdS0SC1CZeOnWkwIzU8oKnHUh6kX+zMxf7AdgHE/Hldo4
	zsL/VtxbVDWPxblLO6LU6VB4clyWWkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-97NTIuAROgagfZ0TbMDsaw-1; Mon, 09 Sep 2024 08:13:54 -0400
X-MC-Unique: 97NTIuAROgagfZ0TbMDsaw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374b981dd62so2091350f8f.3
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 05:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725884033; x=1726488833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkATp1QtmV3cfFCcvxrwKHj5NzaYjxngX1fAPFVvMdU=;
        b=MulYUwT4ruC9++KWRuEa7YBAdMLM1MpO3hxcCbhHi2tt6Ny1prezV9bOQehq0ESKyL
         X8pyWH9ATYPzxKWzIHVVzDY3F9dw8wPeaa88LlC9frvDjv0+riA3Vl0ww3PUpTqfJWdb
         JGfO7IBVdIYizK0uNQw8lFRzcoZql1M0WGz1CUGtD2YulqJa0/mzixk4yFghfmvvx0CS
         Z2UOoVdsPgh7D5r00HRNHRt/DgF14nTp50sSrrpw5VWOewh9FMSpqPdn1e0Guux4OcIt
         g/xIkHRgrLvF096gvp/YeTcv7Aqoex3RZhgvvMHjPc91nfXtAen03DHyUfchhQ3yQnso
         2cTA==
X-Forwarded-Encrypted: i=1; AJvYcCXlQq/LTKPnqF3TLfX5j53e1bU7pRXXG0Hrpxkfi5GsyLCee9csEtQ68R3CCJdAMBclXe8+1Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vDcsknEm0wJb5+qgmUf8YwN2cOxGukpIQd3lZdLY2+0OYr7B
	fJ1ok5gxAWSL5GR5TgwxLoShUKF+2qk1oP5ldvR0RKY8cJOJ5a5J+nb3a+smuGmfPtDvJZo7ysN
	Ia+B76Dl4RSXeD7AhgA2MErIc54DJ2ZXvTZgnFVI6jf/130HJWrBrfQ==
X-Received: by 2002:adf:f34c:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-378895cafc0mr6687255f8f.14.1725884032743;
        Mon, 09 Sep 2024 05:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMPgGNVXT36LLq3lOi6IkAmkuKGmW1abkfOEOmlNebAx4FKPDNq5cQYQfDHfnz4n6zWNSAg==
X-Received: by 2002:adf:f34c:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-378895cafc0mr6687227f8f.14.1725884032182;
        Mon, 09 Sep 2024 05:13:52 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3d4sm5882267f8f.108.2024.09.09.05.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:13:51 -0700 (PDT)
Message-ID: <2356e3d66da3e5795295267e527042ab44f192c8.camel@redhat.com>
Subject: Re: [RFC 1/4] drm/sched: Add locking to
 drm_sched_entity_modify_sched
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Tvrtko
 Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date: Mon, 09 Sep 2024 14:13:50 +0200
In-Reply-To: <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
	 <20240906180618.12180-2-tursulin@igalia.com>
	 <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
	 <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 13:29 +0200, Christian K=C3=B6nig wrote:
> Am 09.09.24 um 11:44 schrieb Philipp Stanner:
> > On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > >=20
> > > Without the locking amdgpu currently can race
> > > amdgpu_ctx_set_entity_priority() and drm_sched_job_arm(),
> > I would explicitly say "amdgpu's amdgpu_ctx_set_entity_priority()
> > races
> > through drm_sched_entity_modify_sched() with drm_sched_job_arm()".
> >=20
> > The actual issue then seems to be drm_sched_job_arm() calling
> > drm_sched_entity_select_rq(). I would mention that, too.
> >=20
> >=20
> > > leading to the
> > > latter accesing potentially inconsitent entity->sched_list and
> > > entity->num_sched_list pair.
> > >=20
> > > The comment on drm_sched_entity_modify_sched() however says:
> > >=20
> > > """
> > > =C2=A0=C2=A0* Note that this must be called under the same common loc=
k for
> > > @entity as
> > > =C2=A0=C2=A0* drm_sched_job_arm() and drm_sched_entity_push_job(), or=
 the
> > > driver
> > > needs to
> > > =C2=A0=C2=A0* guarantee through some other means that this is never c=
alled
> > > while
> > > new jobs
> > > =C2=A0=C2=A0* can be pushed to @entity.
> > > """
> > >=20
> > > It is unclear if that is referring to this race or something
> > > else.
> > That comment is indeed a bit awkward. Both
> > drm_sched_entity_push_job()
> > and drm_sched_job_arm() take rq_lock. But
> > drm_sched_entity_modify_sched() doesn't.
> >=20
> > The comment was written in 981b04d968561. Interestingly, in
> > drm_sched_entity_push_job(), this "common lock" is mentioned with
> > the
> > soft requirement word "should" and apparently is more about keeping
> > sequence numbers in order when inserting.
> >=20
> > I tend to think that the issue discovered by you is unrelated to
> > that
> > comment. But if no one can make sense of the comment, should it
> > maybe
> > be removed? Confusing comment is arguably worse than no comment
>=20
> Agree, we probably mixed up in 981b04d968561 that submission needs a=20
> common lock and that rq/priority needs to be protected by the
> rq_lock.
>=20
> There is also the big FIXME in the drm_sched_entity documentation=20
> pointing out that this is most likely not implemented correctly.
>=20
> I suggest to move the rq, priority and rq_lock fields together in the
> drm_sched_entity structure and document that rq_lock is protecting
> the two.

That could also be a great opportunity for improving the lock naming:

void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
{
	/*
	 * Both locks need to be grabbed, one to protect from entity->rq change
	 * for entity from within concurrent drm_sched_entity_select_rq and the
	 * other to update the rb tree structure.
	 */
	spin_lock(&entity->rq_lock);
	spin_lock(&entity->rq->lock);

[...]


P.


>=20
> Then audit the code if all users of rq and priority actually hold the
> correct locks while reading and writing them.
>=20
> Regards,
> Christian.
>=20
> >=20
> > P.
> >=20
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Fixes: b37aced31eb0 ("drm/scheduler: implement a function to
> > > modify
> > > sched list")
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v5.7+
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
> > > =C2=A0=C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > index 58c8161289fe..ae8be30472cd 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > @@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct
> > > drm_sched_entity *entity,
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0	WARN_ON(!num_sched_list || !sched_list);
> > > =C2=A0=20
> > > +	spin_lock(&entity->rq_lock);
> > > =C2=A0=C2=A0	entity->sched_list =3D sched_list;
> > > =C2=A0=C2=A0	entity->num_sched_list =3D num_sched_list;
> > > +	spin_unlock(&entity->rq_lock);
> > > =C2=A0=C2=A0}
> > > =C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> > > =C2=A0=20
>=20


