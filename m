Return-Path: <stable+bounces-74128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67347972B15
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C3B24F89
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451F17E00A;
	Tue, 10 Sep 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrmCEif/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AF17C220
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954222; cv=none; b=c6HaCUTCuUKIAJrs9o36YqJTPz0htr7qGwdtkLJMm/ZELrX5c+ooHTpHrtV7Z1snaiOcecKVb8uIKzZSvPgcijOSO+OJDdkWv/15buxUrmev8XO1NUHp63beH5t+Tu0EkW5ejPneTnQUKY8HJCQzgTjSY+Z0QOg1u9TN7RsQpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954222; c=relaxed/simple;
	bh=J41GJ+168AoRWbYdCtNtiY/tH+k7UrxXAcDjwTort6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+CSbER/9VDLuqBjWAXunSadzeZoElQj3MZtYyGpc9UNWoltsl6pg5G5yC3+V7PXnGtQ0pBWNFIVtyqrIjMmdXWh7TCMkHakEZe7c5rbBIoQXmRRy06p8IX0CJQvVFjHnzJLqR746U8iqUfNIuyYJMP1UZ+aWn9V+xtuT74iRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrmCEif/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so16205205e9.3
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725954218; x=1726559018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrlnuOGbE3/jD0mKWDJ0SbkbzsZFxQ0jXYoeSrOzRTs=;
        b=jrmCEif/FEYfRsUb8HeGA3M+m/Z8bbs/9f8wsCAD9muK2EcHBWFQW5KzVNc/4eKIQp
         F0lDIip4WCcpvut/jYh5yfdlN2V0eLhJm0FgHf2mNPrJC4qNqWsBs3LELnoM9JCj3eLe
         GJ9GFcXIMpG/ihc4HkT4wHRnIFwJIepWze3lGvuuRyzzVG8DXqiH+KrGjQFRmPVaLIen
         nq/8/Xrbu3Ya1ggR+Z1b5ELXe1fV39AMt9mTIk3MCg6+VFUyjO2fPWqDZFc040YscLNi
         3h9oXILMWVkPv2nlwsP9quBd4I4km2luUEK29mAHabRQka9ifWFSPXij4oG0j2/lUNAH
         hp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954218; x=1726559018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrlnuOGbE3/jD0mKWDJ0SbkbzsZFxQ0jXYoeSrOzRTs=;
        b=UWyGQV0AI+Isub7lLG01JkTbk/AgyTPJJGjBw9fPqUyHap9j+nxKYoZP7SvRPgyIX6
         wCXQc7soONPFPbRBpG1mCr6+tPYkMxlpvSgCElw8tcACc5Xxgetc/Z9ur54MH28qGyDa
         cwYrY43DhLdXt5m3RvkysYzcqawONL+vxx30MLN3VQdo+p8beypUoFH4bhvep5SCMdnH
         idVRIh6sr6x8vdONnclI8+4T6wyFlWcFdPOr9r7ay2vl4rc+mnkcPeTyytLO+S3OzFdf
         M7UXN7x7qWxmk5H/G+ommKtuiRE7zzMedPw+w8ge4pkdkDBa6Pcr4mDJlpMmOPDKkVaE
         +KsA==
X-Forwarded-Encrypted: i=1; AJvYcCV23zEow0Fb7lBfS+TqCy6xQ7glSPFDp0uMcaERhALOKgIX89krLfgw91qX4vSoXhBZBY+bnZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0zQoD9qFKd2Px5tamYTEa6aba7T7f7zPEJuXXpTg3qWxuU9P
	vSNSMS8XQUcXwejOynkP8c+PDfzL6kUb0u7TL/rFkNR8Ggb2S3Zx
X-Google-Smtp-Source: AGHT+IGCG6IFrUeothqN13k/Kz4AkFspY4On6g/qAPTWlFA/ip2SFfSLWyD/6dgQYLU7cFiSfRs6WA==
X-Received: by 2002:a5d:668b:0:b0:371:8e0d:b0fc with SMTP id ffacd0b85a97d-378896122afmr8418493f8f.35.1725954217618;
        Tue, 10 Sep 2024 00:43:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a2a5sm8043976f8f.17.2024.09.10.00.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:43:37 -0700 (PDT)
Message-ID: <6c188161-9ac9-4093-b257-cbaf0146a02b@gmail.com>
Date: Tue, 10 Sep 2024 09:43:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/sched: Add locking to
 drm_sched_entity_modify_sched
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Stanner <pstanner@redhat.com>, stable@vger.kernel.org
References: <20240909171937.51550-1-tursulin@igalia.com>
 <20240909171937.51550-2-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909171937.51550-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.09.24 um 19:19 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Without the locking amdgpu currently can race between
> amdgpu_ctx_set_entity_priority() (via drm_sched_entity_modify_sched()) and
> drm_sched_job_arm(), leading to the latter accesing potentially
> inconsitent entity->sched_list and entity->num_sched_list pair.
>
> v2:
>   * Improve commit message. (Philipp)
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
> Cc: Philipp Stanner <pstanner@redhat.com>
> Cc: <stable@vger.kernel.org> # v5.7+

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 58c8161289fe..ae8be30472cd 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>   {
>   	WARN_ON(!num_sched_list || !sched_list);
>   
> +	spin_lock(&entity->rq_lock);
>   	entity->sched_list = sched_list;
>   	entity->num_sched_list = num_sched_list;
> +	spin_unlock(&entity->rq_lock);
>   }
>   EXPORT_SYMBOL(drm_sched_entity_modify_sched);
>   


