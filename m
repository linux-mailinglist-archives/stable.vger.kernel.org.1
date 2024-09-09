Return-Path: <stable+bounces-73990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7403971423
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343821F24985
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FC1B3B26;
	Mon,  9 Sep 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hszwq6P2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB01B3B25
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875086; cv=none; b=fwMzM0ankENSXx+Gk4zdd8CXhyYVRxEjtzYNl860goUXgXNhOq9HY0/UkKV9RzKErhyKs9KtkeUR9XpOZLB7wdshI79OGiwRi+A15Z/8IvUtNE163+HAYIx0aGrePfbaOrjk1ycLBARrbmsKiUfIIWUzGhV4T4bXZszZcRNpl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875086; c=relaxed/simple;
	bh=oTWru4to7EuYaDsIL2xfy+rHa4BayCDuQ+Emwsup6GU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UegXzTx5pipE/6g0eYYfWLhy/Wie62j4tjhonUL5VM3eE5CDYm47pML1Tu+lqXY0ciKAAO2VB1i7An2Ija926vvBcdR6+hIgFFGsg6Mo75s1bfyO81MaAbq8oG6KxIqKziac58LE7URhdIYQl0k9MD+/3feeoaRg85zdiuh7758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hszwq6P2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725875082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVm8c6/Sqrp3TPhfrJ3lOZfRVhjrw6Pp99SGfZDmV7c=;
	b=hszwq6P2dxrnutPXZJPlpAZQGgcfcM3p2rL0vWnxu3tNCokA+nc/6PyBxwel7KfJ7Qgdub
	McrN5dX4lfM3jn+zWtwmxHTmh9u+J+P51+jGQXpkWGqLEkHM2wLpBPhAQRkLdkYw2rKtlg
	jfdBLb3ih1Kc4NoivMKpzFxo/BoZRHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-3vDtSj0rMb-wWIYhJ64AiQ-1; Mon, 09 Sep 2024 05:44:40 -0400
X-MC-Unique: 3vDtSj0rMb-wWIYhJ64AiQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c90d24e3so2903789f8f.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 02:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875079; x=1726479879;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVm8c6/Sqrp3TPhfrJ3lOZfRVhjrw6Pp99SGfZDmV7c=;
        b=EuqiIRo6RaiwH0LR3XwThTYP4Cf2CbMNLk57MeT7nwAWuQwjbOaJ8xeFMPSaPA57g/
         chJ2QRTsV798+NsQEdOrZLV6dWLPpWBiQESPIykfl4Gv3EbWn9JvD91e9deFUQp1WYhn
         xhLSt32G0yfXez1GiNB5sVhMmfoQkSZhqlygWb9G8nogWvVYNYVUv39fzmbbHXwb9y9P
         4SAbKw1GgJeLQcb9TVVhyN+8vHAJfjVfo7s78v8lN1q0rTHldvqJavH9ZX16EoP065WL
         kLynnPsashOVEGHfeKRq77PrxhX6D2UnDsxz/3Z15Kyh2CuTwyXa0LVeghgJPj05CEb9
         SrIw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9pVI6hyxse3klwZUqemdV4D4xUHQfhBRf9UW5hLQlVMQlVRJoB+G0pwBUV5N9WV4vqXOKso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbRNq2xMA/isco38vGt/uN1PS2KngAiYaIUZ0BR1+B4iVqiRS
	M7fZdyHHaogS3/62+dFKmO65QsrA5N7V3KzScJNbVXPWsGQ9yYkiviUzYVazdrFAWr7UBKg3k85
	64y8P3ezAxxGsHxQ4q47tgIue3dbaGtX5c23uKa0/ghHKlK5rt/2inA==
X-Received: by 2002:a5d:5cce:0:b0:374:bec7:8f with SMTP id ffacd0b85a97d-378922b7691mr4984489f8f.28.1725875078963;
        Mon, 09 Sep 2024 02:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHGK2Xu8mRHpEjTebQMfnfsEbelIPzvsXlp8WnWNlp+vzax9rKo9hm67Y9/zhgSmtVdtsggA==
X-Received: by 2002:a5d:5cce:0:b0:374:bec7:8f with SMTP id ffacd0b85a97d-378922b7691mr4984463f8f.28.1725875078446;
        Mon, 09 Sep 2024 02:44:38 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956650f2sm5549862f8f.26.2024.09.09.02.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:44:38 -0700 (PDT)
Message-ID: <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
Subject: Re: [RFC 1/4] drm/sched: Add locking to
 drm_sched_entity_modify_sched
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date: Mon, 09 Sep 2024 11:44:36 +0200
In-Reply-To: <20240906180618.12180-2-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
	 <20240906180618.12180-2-tursulin@igalia.com>
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
> Without the locking amdgpu currently can race
> amdgpu_ctx_set_entity_priority() and drm_sched_job_arm(),=C2=A0

I would explicitly say "amdgpu's amdgpu_ctx_set_entity_priority() races
through drm_sched_entity_modify_sched() with drm_sched_job_arm()".

The actual issue then seems to be drm_sched_job_arm() calling
drm_sched_entity_select_rq(). I would mention that, too.


> leading to the
> latter accesing potentially inconsitent entity->sched_list and
> entity->num_sched_list pair.
>=20
> The comment on drm_sched_entity_modify_sched() however says:
>=20
> """
> =C2=A0* Note that this must be called under the same common lock for
> @entity as
> =C2=A0* drm_sched_job_arm() and drm_sched_entity_push_job(), or the drive=
r
> needs to
> =C2=A0* guarantee through some other means that this is never called whil=
e
> new jobs
> =C2=A0* can be pushed to @entity.
> """
>=20
> It is unclear if that is referring to this race or something else.

That comment is indeed a bit awkward. Both drm_sched_entity_push_job()
and drm_sched_job_arm() take rq_lock. But
drm_sched_entity_modify_sched() doesn't.

The comment was written in 981b04d968561. Interestingly, in
drm_sched_entity_push_job(), this "common lock" is mentioned with the
soft requirement word "should" and apparently is more about keeping
sequence numbers in order when inserting.

I tend to think that the issue discovered by you is unrelated to that
comment. But if no one can make sense of the comment, should it maybe
be removed? Confusing comment is arguably worse than no comment

P.

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
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 58c8161289fe..ae8be30472cd 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct
> drm_sched_entity *entity,
> =C2=A0{
> =C2=A0	WARN_ON(!num_sched_list || !sched_list);
> =C2=A0
> +	spin_lock(&entity->rq_lock);
> =C2=A0	entity->sched_list =3D sched_list;
> =C2=A0	entity->num_sched_list =3D num_sched_list;
> +	spin_unlock(&entity->rq_lock);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> =C2=A0


