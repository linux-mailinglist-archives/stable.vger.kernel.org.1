Return-Path: <stable+bounces-73992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B33971473
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A7E28130A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD131B3726;
	Mon,  9 Sep 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBoybCdP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EF1B3B30
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875513; cv=none; b=MGXMHcZ4+ES8fkUHEsa/3Sckt7PNsb9cxyGn1QsX7zfSJ+TJDjMfVy4i4guZl0A8iqXVsLq7R9mtBZUee0TCsM1H+KBbCY1GMwIVDESRvmdIzX+wfTRqDfdlejTxZ0u7wUppdp2XoICTYp2kX1Hj3y63YVcQ7EId1CZ1Z/Z1O10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875513; c=relaxed/simple;
	bh=yXHSetILptmnymruviDww0H37rnxlR/HkJqFwd/hm9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJimC5VJ83+sbHpj+RXCzmNjxfWm9f0ohZHte4pSyRu318FHgobNFccy6H+i7oNvdBGRDDbysY7zGlmQYP1TxWnB3FK2M5wx4d6S45XHZaYamgmvzYd2HYuRf93YHygOt8fUtKLqd8+i2yf7/Dzin4tigiupjcInR0dLfvSd+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBoybCdP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725875510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Tbw+vwPqAwjyalWaaJ8tVR88aCGFVgkshL4vXUNzo=;
	b=iBoybCdPuDKQIXveFE9nadpmPjMJIHlf1nYmZLuqHz8dqoidRLs6SGQn8pLJgE6PpFgXm4
	S3dMHRsOU+YL3wS9GrVLzIx1bUTzttfEgwKfcDtziFO4+x6iwDEvF5EHfFQaTTwQA6EF8q
	d92K4doZ8TuO1JmVQjmBlZNLhyhnBcQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-yP8nLuR8NPiWwXpY-FjPxA-1; Mon, 09 Sep 2024 05:51:48 -0400
X-MC-Unique: yP8nLuR8NPiWwXpY-FjPxA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso2072506f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 02:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875507; x=1726480307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+Tbw+vwPqAwjyalWaaJ8tVR88aCGFVgkshL4vXUNzo=;
        b=o/7wKFLQXeb9azOc145VK6/WNW0LjRQz0ToEw/VId1lvE3d5KS7kaOoIjlgfdRXCIA
         RcQ2xfNOkDIaAf0toIJFHfYEU6i50WjxR+daR9Bve+f2xwgHIuNPlIJ+5XqD8vM+2E3J
         e2dBFfs9jqVFA9+8punkSEs30I5laVjAuUba7y0r/DPvkfv8XVueCikvufHHLBadfbXH
         hfZA6caiAUmMartSAJgXrSRnKr6IP+69IkOWN+GQAS4K/ahFTPzX3GgkxKjAujzENrDM
         4+6qtr0OzwE2v4mk/EQ8qM4NcRejNqDRzfSsa+Lp0MFPMqwIajhuu1vwoVd0o5vJCIw0
         IXAw==
X-Forwarded-Encrypted: i=1; AJvYcCXv2pnt8RTRJUiDF6dm3859ym9FVD8Fk1b7qrxHDpd6hF6XjSPIoZMKWr3Q/XAInv5V+cuMUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhwlHahZI1+nLFlwDSe6gV2CN/D/DhA2aSQU0QEiF/wWCXO48
	RBvo6W8jSLAU95JWRKb6ND2IUeFPjlXPxMuLQYB2+KbB4+26mF5iJ94PhpqLbCdSXOndRE7dV/6
	jBUcWIj3cJFlebk4LB2U/hniClnm6K8kmmgQFjEqgOOXb6+sP71FzdA==
X-Received: by 2002:adf:f2c7:0:b0:374:c157:a84a with SMTP id ffacd0b85a97d-378885dfa6dmr6447744f8f.16.1725875507540;
        Mon, 09 Sep 2024 02:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/5zepFCrbxUqLeH1UXU2lnxmqLq6D4IEGIZA56a9vh4xBHhJLHcdXgd1cWD/A0n6hc7YGA==
X-Received: by 2002:adf:f2c7:0:b0:374:c157:a84a with SMTP id ffacd0b85a97d-378885dfa6dmr6447716f8f.16.1725875507060;
        Mon, 09 Sep 2024 02:51:47 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dd932sm5549616f8f.98.2024.09.09.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:51:46 -0700 (PDT)
Message-ID: <ee0e0294c2af5a651cc3a28404cde23df764bb43.camel@redhat.com>
Subject: Re: [RFC 2/4] drm/sched: Always wake up correct scheduler in
 drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date: Mon, 09 Sep 2024 11:51:45 +0200
In-Reply-To: <20240906180618.12180-3-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
	 <20240906180618.12180-3-tursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> Since drm_sched_entity_modify_sched() can modify the entities run
> queue
> lets make sure to only derefernce the pointer once so both adding and
> waking up are guaranteed to be consistent.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify
> sched list")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.7+
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index ae8be30472cd..62b07ef7630a 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -599,6 +599,8 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0
> =C2=A0	/* first job wakes up scheduler */
> =C2=A0	if (first) {
> +		struct drm_sched_rq *rq;
> +
> =C2=A0		/* Add the entity to the run queue */
> =C2=A0		spin_lock(&entity->rq_lock);
> =C2=A0		if (entity->stopped) {
> @@ -608,13 +610,15 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0			return;
> =C2=A0		}
> =C2=A0
> -		drm_sched_rq_add_entity(entity->rq, entity);
> +		rq =3D entity->rq;
> +
> +		drm_sched_rq_add_entity(rq, entity);
> =C2=A0		spin_unlock(&entity->rq_lock);
> =C2=A0
> =C2=A0		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> =C2=A0			drm_sched_rq_update_fifo(entity, submit_ts);
> =C2=A0
> -		drm_sched_wakeup(entity->rq->sched, entity);
> +		drm_sched_wakeup(rq->sched, entity);

OK, I think that makes sense. But I'd mention that the more readable
solution of moving the spin_unlock() down here cannot be done because
drm_sched_rq_update_fifo() needs that same lock.

P.

> =C2=A0	}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_push_job);


