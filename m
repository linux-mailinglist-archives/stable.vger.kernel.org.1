Return-Path: <stable+bounces-244801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHhkDPIZ/mmQmwAAu9opvQ
	(envelope-from <stable+bounces-244801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:14:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835434F9D4A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF80D30477D1
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFEC3FF8B1;
	Fri,  8 May 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="miuG7geX"
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F011DE8AD
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260182; cv=none; b=lQEtGBas+9ySGZur0w08qvPURl5DzGzfS56L5Cp1XOR6T9AMLfMj6YI3kT/D26p7Jui9ooM7wl/RlaTXk+VPjky5wHI12MMy5htUcXi8vRBlkuz5rwXZh2sK1wtwZW0hqx+J+N1imdISjNlKcnOJQMZpk5oinV9wyqyKtMULZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260182; c=relaxed/simple;
	bh=g7sFg48r5Dm+Qo/8mMdFgMdzbwgpDyCQ/p6NpvKjuO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhzH1OWJjHCNJFPpzNHPt3SwvbTx2lvFhMcCCUxLQ18nz4q9NczLHx78Jf0WZrV2X27rE5KTqbCnm+EyaMyKa2v0gZ8zTuoGFbGxfyi8vY/rrcf37wfWrrJ226/AGtkuFiT18ItWe1hKtssJFLkSJQBp+OnInUAAed2dg2QB/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=miuG7geX; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1778259792;
	bh=g7sFg48r5Dm+Qo/8mMdFgMdzbwgpDyCQ/p6NpvKjuO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=miuG7geX4V6aqu09394g21y6aer2ii5J64k2rHShJV8jxg/42yvdAD+jr8x1BExwg
	 PmLL9b/4p/cj6ohFV2NhFfHbyKkXEuIwEFeFsOo3TxcQv424om/vILos5m59ZGvfHQ
	 /yOrmhjgjr0Pskt7f0HccWUa1Lis4ijC1oiBt410jI5yfdIEEcccL4FT/e+hzPOX9O
	 2bvHcx2+FCcRCyGs9J3p5iBtXsdGk2cZkEUCaL3svIVO63DCZ1kasqQmCeMk5vX+gy
	 sTWk2FNsVbcecTdbihl5sTP32OhZ1LoYQCZsVwLnkQ6gHvNFVtzStkIqvvTsR0TemU
	 IKi5yt+iqOA2A==
Message-ID: <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
Date: Fri, 8 May 2026 19:03:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to
 -ENOSPC
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 835434F9D4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244801-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email,intel.com:email,gmx.de:email,amd.com:email,lankhrost.se:email]
X-Rspamd-Action: no action

Hey,

Den 2026-05-08 kl. 18:09, skrev Thomas Hellström:
> dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
> hit and the charge fails. TTM has no concept of -EAGAIN from resource
> allocation; -ENOSPC is the canonical error meaning "no space, try
> eviction". Convert at the source in ttm_resource_alloc() so no caller
> needs to handle an unexpected error code, and clean up the now-redundant
> -EAGAIN check in ttm_bo_alloc_resource().
> 
> Without this, -EAGAIN escaping ttm_resource_alloc() during an eviction
> walk causes the walk to terminate early instead of continuing to the
> next candidate.
> 
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Maarten Lankhorst <dev@lankhorst.se>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.14+
> Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c       | 2 +-
>  drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index d85f0a37ac35..cee3828df655 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>  		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
>  		if (ret) {
> -			if (ret != -ENOSPC && ret != -EAGAIN) {
> +			if (ret != -ENOSPC) {
>  				dmem_cgroup_pool_state_put(limit_pool);
>  				return ret;
>  			}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 9f36631d48b6..b0efffe5a526 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -385,8 +385,11 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  
>  	if (man->cg) {
>  		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> -		if (ret)
> +		if (ret) {
> +			if (ret == -EAGAIN)
> +				ret = -ENOSPC;
>  			return ret;
> +		}
>  	}
>  
>  	ret = man->func->alloc(man, bo, place, res_ptr);

Yeah looks reasonable with the conversion to callbacks.

Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>

