Return-Path: <stable+bounces-78258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD998A3DD
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3992815D3
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAF2AE8E;
	Mon, 30 Sep 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Dzh9vgy2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438C18E038
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701315; cv=none; b=TYQ4IT70Ajs6NISY8x7xxVPKoQSEF9pZxyowJYewIvUFecPaIwLSFpwZzT3nHb+nD3yz36LFtx88TvFm1L7j56sCRQvwYU/bkA/MmI6j1VBmQW97WRpPe2QUSJCZSzltiNp35cWOIjoAIrnntIQK3vrsOw5FeqR3SDiTD4jalLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701315; c=relaxed/simple;
	bh=9c/AiGYbUkHNhaHaDuVGS9wQSfpWKgsrOeoB7XoHiGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz8tiKrFhc6ESopKxF/82hFpFVoXGJf6pSAla/3nPwS3FyPznCdB1TgA8rnVsg0ADOuUsq2BmUCM+wAHsN8B8R52QrMNbw5VA1sWt6F3MGDQsMe7RTI5rJv93jR65KLW5Cmento7PgWoYlNENggfthkt72N7QgQnHiZ6RMwEU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Dzh9vgy2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IwgILRWQxDEiAPXAZe44pm+PcxfbkeM8mxeAatZZQ6A=; b=Dzh9vgy2NSyCitzAUn8I3ndAVI
	LQvJCVJi29y/HBvX57ivLzjLUH+UuhibFpjVf/3g9936KYHBwuNmOR6MRg351hqXqw+UumxSWgD3t
	JnRLyJMKU7OGbx24dwviTd5ULPDIHcVhiRTzc/XnuYn2rUnWbwArhJHlq5zNv9gUxcMlaCmDVcZQi
	htZCsnTndnDJM8ECwNgqXGZEjeTfFxRUm+lNwi+mP4mCwX8hu0M5w51Fc4RSo0JiMGUUkmn371e7a
	bUMYgSHjAk4YN1d9LONhM02mnhTwnNpFd71xMGsOgkqWORNIpjTwVjvfg/GRkhW3F3WUSZWvp9qD3
	WqgxNN1A==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1svG1o-002qk6-Eq; Mon, 30 Sep 2024 15:01:28 +0200
Message-ID: <8392475d-489e-4aa3-b6c2-7cd15b86dab2@igalia.com>
Date: Mon, 30 Sep 2024 14:01:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/sched: Always increment correct scheduler score
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org,
 Nirmoy Das <nirmoy.das@intel.com>, Nirmoy Das <nirmoy.das@intel.com>
References: <20240913160559.49054-1-tursulin@igalia.com>
 <20240913160559.49054-4-tursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20240913160559.49054-4-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/09/2024 17:05, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Entities run queue can change during drm_sched_entity_push_job() so make
> sure to update the score consistently.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with multiple queues")
> Cc: Nirmoy Das <nirmoy.das@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.9+
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 76e422548d40..6645a8524699 100644
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
> @@ -614,6 +613,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>   		rq = entity->rq;
>   		sched = rq->sched;
>   
> +		atomic_inc(sched->score);

Ugh this is wrong. :(

I was working on some further consolidation and realised this.

It will create an imbalance in score since score is currently supposed 
to be accounted twice:

  1. +/- 1 for each entity (de-)queued
  2. +/- 1 for each job queued/completed

By moving it into the "if (first) branch" it unbalances it.

But it is still true the original placement is racy. It looks like what 
is required is an unconditional entity->lock section after 
spsc_queue_push. AFAICT that's the only way to be sure entity->rq is set 
for the submission at hand.

Question also is, why +/- score in entity add/remove and not just for jobs?

In the meantime patch will need to get reverted.

Regards,

Tvrtko

>   		drm_sched_rq_add_entity(rq, entity);
>   		spin_unlock(&entity->rq_lock);
>   

