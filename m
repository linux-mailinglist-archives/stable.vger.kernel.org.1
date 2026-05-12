Return-Path: <stable+bounces-245588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEoLIVguA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0067521796
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65D7331A8608
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE6394E8A;
	Tue, 12 May 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAxfaugY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E0394EA2
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592630; cv=none; b=haaLBcJQJCFcaYDC7W21CQ5IOccK5nQIFM007mVmxsb5FiKgu/vx7JNFZ9LfM1fOC1JimuTRbON0CexRPTMvL+6uXzf5Aw7az9P4N/Aqrgf7XmPopqQmfeieZwhFPZAOV8qeLQrzA4fvOQ70myUGXTdNUC1vvRS7sTWrKEgI6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592630; c=relaxed/simple;
	bh=wtJqHHaIl13PAglqRFyFPd5gLhqQXFoxrvpBhQYYIEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMoWeRpUk67Ib8bpnoXvrhCsD3USA7tO4O9pJOdzz9M9guod7AFY5wjxP202sYhv7p5lynr/fD9pXC7HCH3e/7tmVFv3EETr7jtLaW+6tclEp8Nx0GQOXfh0m/LqI6kTHMmSbCvyJtrvV6Talg0iETLsm3HdJlLAlWv+tLgIR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAxfaugY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778592629; x=1810128629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wtJqHHaIl13PAglqRFyFPd5gLhqQXFoxrvpBhQYYIEI=;
  b=QAxfaugYWVocuVDjzN2XmtgOnAo5QpVVNuhOB14XGBOkSb4Evd4MOYKV
   7NMSi4THhS+MLxF8wuwobcU2BBSF3qE3eKEJhgJana9CB/9GbE3Lm7MBj
   zQijcde3jxSpSmqn5sSxH1zY9yDAaa02fsOveCtA3J71mJ4YzN/3u/1BO
   w/DUHinNERI2jDnUkUw6MGIKInTosQEnUhFoq8q9mA3AN7kpavFskJcLE
   z/R8Qk0LQD011ecQh9cB/Ce1ovqZ4OX2dQ2fc7cz2pW60K0LkwXq7lpKe
   LzDn5LNGndMpWMZz3AVaDTsZvZNBRnIi5lNSw9ewTapGDhfR2YPEX1J0H
   A==;
X-CSE-ConnectionGUID: vPvGfr1JRS61oj7k5HU+Jw==
X-CSE-MsgGUID: 8pkP5U2fT9eSJHQRCgba7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79448916"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79448916"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:30:27 -0700
X-CSE-ConnectionGUID: 6zNkqupeSrOr3resEA9THA==
X-CSE-MsgGUID: ha2l5MCwQri+SNdEqz8fwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="241766446"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184]) ([10.245.245.184])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:30:25 -0700
Message-ID: <353e4a2f-102e-4d77-98b1-19f37d691e8c@intel.com>
Date: Tue, 12 May 2026 14:30:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0067521796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245588-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,lists.freedesktop.org:email]
X-Rspamd-Action: no action

On 11/05/2026 17:24, Thomas Hellström wrote:
> Apply the same fix as b2ed01e7ad ("drm/ttm: Fix ttm_bo_swapout()
> infinite LRU walk on swapout failure") to the ttm_bo_shrink() path.
> 
> Move del_bulk_move from before the backup to after success only,
> using ttm_resource_del_bulk_move_unevictable() since the resource
> is now unevictable once fully backed up.
> 
> Fixes: 70d645deac98 ("drm/ttm: Add helpers for shrinking")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Assisted-by: GitHub_Copilot:claude-opus-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f83b7d5ec6c6..3e3c201a0222 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
>   	if (lret < 0)
>   		return lret;
>   
> -	if (bo->bulk_move) {
> -		spin_lock(&bdev->lru_lock);
> -		ttm_resource_del_bulk_move(bo->resource, bo);
> -		spin_unlock(&bdev->lru_lock);
> -	}
> -
>   	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
>   			     {.purge = flags.purge,
>   			      .writeback = flags.writeback});
>   
> -	if (lret <= 0 && bo->bulk_move) {
> +	if (lret > 0) {
>   		spin_lock(&bdev->lru_lock);
> -		ttm_resource_add_bulk_move(bo->resource, bo);
> +		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
> +		ttm_resource_move_to_lru_tail(bo->resource);
>   		spin_unlock(&bdev->lru_lock);
>   	}
>   


