Return-Path: <stable+bounces-74008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915739716EC
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8761C217CE
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A91B5ED8;
	Mon,  9 Sep 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbsSDnvL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACF1AF4F0
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881503; cv=none; b=CzgI5W8z1spjH+a7y++ngyx9gwtmM0VV6+J51ksNqDHUAWBEa1zz/SvwTJgczPncMyJZP61HqVdH55v2jG5WHv2jCoL7rGj+lii5ov0obhGgmE8/OOK1+U1ufgxDNMWzU3R9ELqK6ga13Ln36y1mTZc/YOwdva/4C/Qd5TTe9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881503; c=relaxed/simple;
	bh=NCkdSWjfMe59VFhGI52m44MeRPXZiWAWdxlbJAIMkOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1UALaal0iK3spAbtS27x3X3HuONpo5akzE/gZpfcLbAooHsukB6CCiGXaCzQYCju0D1iHKjiYwUKPAp6ZUD/fN0rLTNgm8Qe8+O2s5A3sGaWzZg8/WKr19rNd2LwG/KvlQ9zG/efXm48xF3KIBsr+qu9Dz9mSKw0+fldwEeeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbsSDnvL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so2746785e9.3
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725881500; x=1726486300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSQ8DnlWBkAu7rryVAU68vxkUdLhsbCL/EHImXGoOho=;
        b=CbsSDnvLbF7+aCcHa/1csReAOQzdZ/1i+32W9inYHXKQJuVToffcFrmzhBt5n9BuuV
         huJBh8zMTTaDJnwjUXNdWvh0iH1STE8PdBpmPr/fi3sT3tloVAgKJg/yrmcBb7VNoWIY
         zGeG+U/mP7NBUyenD6Lp0S9l0jxnYS2ZpkE2dvuJniJ5FzssUnOtjaKGakVsTHk7NwWk
         5UkkTMcWVNpQZOn77XV6jzBmaca1+gVLE54Hg1+BA83nqfhuVlvM1NhXrKbMSIwYOSl6
         +LaktnMoToo+OzOIOpXlpAyPe1hmQeIrMefzsl52rMnIRXFp9DzPjLg0sW8a6+6G/q6F
         OnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881500; x=1726486300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSQ8DnlWBkAu7rryVAU68vxkUdLhsbCL/EHImXGoOho=;
        b=U2sjCpZ/QibOLJukpZvD8lJ+5oZii1shZ17kzRThHXH+a6/7ta14rfNGHM7bBGMPDU
         ghWp1IZxjIwDhNzvNs28k66gqBFQ/E4KZdcwc8kBgfIV4BDEXRCg9IZ7AkLs1r5nuTys
         j7gf8hUFqpB9wF8W5IKC3+S0S8Cqcmx1C23YYusiI8lSFaDJQQwd/kh6B8JK8PLqMUWy
         zlPtjOe278pBxrhrit+eFz7RtjBzUHiApoDa3c8zDsMt63j9fUgkL6tnkaBojE4r96Gc
         0LWCF7KmR+IZ4iDGHHC5vHIm4OotyWSkeA09Gc2T1tcYYeOCtWCXQ1H/HrPqxe5JEQ/r
         R54g==
X-Forwarded-Encrypted: i=1; AJvYcCU0iEM4taacEC9Hq95oe5jgmRiqNA+LeYomQEBbuK+CS8MQciatB+8SJyLA9V/aV4fFFu5QzIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPsNx8zRzmAEIfYdsKPPuLaWFDPJNWDIIZaQVaI6bLSYyGIWh
	maMSMx5U4f5AjO5c5fVtpOKoZiq+zJ+3mzqHe3XxRjS/HlcHp1uZ
X-Google-Smtp-Source: AGHT+IF5JWMxmrkXMHQ1hLF1Imsbf560J8naprq0JYGcLAYu7eBg/ZJazjze3qFIZW3QP01yw4XYug==
X-Received: by 2002:a05:600c:3ba7:b0:42c:ba1f:543e with SMTP id 5b1f17b1804b1-42cba1f5946mr9572135e9.26.1725881499523;
        Mon, 09 Sep 2024 04:31:39 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895676117sm5795161f8f.60.2024.09.09.04.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:31:39 -0700 (PDT)
Message-ID: <9f2bd368-1d73-4d87-9b13-c90cd5a2cbbe@gmail.com>
Date: Mon, 9 Sep 2024 13:31:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] drm/sched: Always wake up correct scheduler in
 drm_sched_entity_push_job
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 stable@vger.kernel.org
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-3-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240906180618.12180-3-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.09.24 um 20:06 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Since drm_sched_entity_modify_sched() can modify the entities run queue
> lets make sure to only derefernce the pointer once so both adding and
> waking up are guaranteed to be consistent.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.7+
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index ae8be30472cd..62b07ef7630a 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -599,6 +599,8 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   
>   	/* first job wakes up scheduler */
>   	if (first) {
> +		struct drm_sched_rq *rq;
> +

I think we should go a step further and keep the scheduler to wake up 
and not the rq.

Regards,
Christian.

>   		/* Add the entity to the run queue */
>   		spin_lock(&entity->rq_lock);
>   		if (entity->stopped) {
> @@ -608,13 +610,15 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   			return;
>   		}
>   
> -		drm_sched_rq_add_entity(entity->rq, entity);
> +		rq = entity->rq;
> +
> +		drm_sched_rq_add_entity(rq, entity);
>   		spin_unlock(&entity->rq_lock);
>   
>   		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>   			drm_sched_rq_update_fifo(entity, submit_ts);
>   
> -		drm_sched_wakeup(entity->rq->sched, entity);
> +		drm_sched_wakeup(rq->sched, entity);
>   	}
>   }
>   EXPORT_SYMBOL(drm_sched_entity_push_job);


