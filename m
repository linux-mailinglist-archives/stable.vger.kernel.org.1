Return-Path: <stable+bounces-74011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A09716F7
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93CB1F23F2D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09541B3725;
	Mon,  9 Sep 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlmZJJZP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5A11711
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881589; cv=none; b=sUZesQAoNHTqQoBgY9TkeOwq5y9JAJl8QKV0ZKS8w6bt9VI6iuYSbKsA1uQymTvqrs5T3ViRbfgJD4xx0lRTOEBw3HDkpBjjzWUHdRFAQgN58i2FhdyasvUKNYmLFevFiNA5kqcjee4YfJcChHsomoKN20Ea90OsOEXmk08fYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881589; c=relaxed/simple;
	bh=oQzj3SRaW+BUPTNLXzCYIeprv4dPylygdfqb7VDNhWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGjrLdDISEYF+lRXcUtjBEw0Gyg4Xj2FvubXXRK4UAgW7Hue2B4x4gQlBrBSW2kymoZnkir32OKev1//R/taHSBprXbEHXtvp6aQLZGiUJ2Yv/b6j9ULlulznpD8qXb5Wo73G6fXce6tednptPIAU5O70EVXbJgGYlhvB3E5RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlmZJJZP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso16622885e9.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725881586; x=1726486386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DlM5K73/93Xqq3pXsHbZNFb988cXH9S9D9zFTKzhUY=;
        b=VlmZJJZPAA/FOAjoNgkr8FJebr9yEg3A2yp9WpugUVuiEsqSrwph2mmYKJZ0GsNG+p
         aTE4WU/ki4/nvWlRJTquS9vgPA+0ouJ6ffGh+mYMCr3lWfU2rACA7kNr6HKW2HSXOwjV
         hnCL0gMWbpjslfDn9TVGGf7ruj8UJkFOepFL1CX4p6DViL44PIH2vs+W2jh/GWpXxP+X
         YunzyKkOZk9IbBRMbO+s9JqfR1iVJZI9ZnvY29CtJROh/anuxskHDK2o/7DLF1IkCHfi
         vPDaDbfJjSVmSISHjvcqZa/pN5WvV+seTw607EEHsdb4KYIjdDPWjSAd7LJAXkOf7IF0
         rlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881586; x=1726486386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DlM5K73/93Xqq3pXsHbZNFb988cXH9S9D9zFTKzhUY=;
        b=I7FeE+pwHG7WhsEwW+b57MGqua18R06npjfShAu+YirE8topoM9o8a6zbgSWbDUONx
         CUynemx+ydeohrTnIYsWYL58pcGdzzqPXU2aKDx5COBHxqPz88rGe9e4UbfNF7TBV9Dm
         95sTrlDBZQBUs6AtMJtqgszfuUSAek998H62SdAL6Ux/c9xSH+UlIsYkKLc47NcQrXCs
         popMTMtQNOzjc3IvuW6AM5MLJiX0uEmruYPxbRTBzoXQ4IRh1kt2y9dtKXtIlN4UCVNI
         S2yg0lu4gJMr0gG//1ecXSnbhWeYgJ/993cjae+DvpmtK0XhztXLRkkATQ63y1teLegX
         UNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj4sxEFetsQ9hCEWYUcjGcSreLKiWEbsK3OqK94DCNhxwNYALECFkaAt47eovKzAFsyOLsQ90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfsyWH7tSkyr7a2eEi1BimouuUcB3kTh0/Q5Q9E2q/Vy5NIef
	NIWyrbEHSUo44X44TbS9FhLesZyWdfGw2wC+WK3FDnZyYdqbUQjZ
X-Google-Smtp-Source: AGHT+IFL7lxb/ox29rfL6wtx5kb8CqIE8JwV0WeUoTZ68calHjSUsYxA+SMLZEeq7bv3mK/rTaBWRQ==
X-Received: by 2002:a05:600c:3b83:b0:42c:b750:19f3 with SMTP id 5b1f17b1804b1-42cb7501f19mr22977905e9.0.1725881585147;
        Mon, 09 Sep 2024 04:33:05 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a5csm74450765e9.6.2024.09.09.04.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:33:04 -0700 (PDT)
Message-ID: <4a85cf20-e0b5-4061-90d2-f85d84435f8e@gmail.com>
Date: Mon, 9 Sep 2024 13:33:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] drm/sched: Always increment correct scheduler score
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Nirmoy Das <nirmoy.das@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-4-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240906180618.12180-4-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.09.24 um 20:06 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Entities run queue can change during drm_sched_entity_push_job() so make
> sure to update the score consistently.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with multiple queues")

Good catch, that might explain some of the odd behavior we have seen for 
load balancing.

Reviewed-by: Christian König <christian.koenig@amd.com>

> Cc: Nirmoy Das <nirmoy.das@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.9+
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 62b07ef7630a..2a910c1df072 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   	ktime_t submit_ts;
>   
>   	trace_drm_sched_job(sched_job, entity);
> -	atomic_inc(entity->rq->sched->score);
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   
>   	/*
> @@ -612,6 +611,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   
>   		rq = entity->rq;
>   
> +		atomic_inc(rq->sched->score);
>   		drm_sched_rq_add_entity(rq, entity);
>   		spin_unlock(&entity->rq_lock);
>   


