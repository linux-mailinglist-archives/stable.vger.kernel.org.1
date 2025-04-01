Return-Path: <stable+bounces-127306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DAA77799
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A455E3AD6FD
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9801EE034;
	Tue,  1 Apr 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn7KBeR8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E991EE019
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499137; cv=none; b=mG/8TaL1/+Tk/ue4YEkCl+6TcTYyDWxGcI3zlU7lmqOBUadI7ZUstZA8IEf+rY891C7QbGDpdutq9D/8Eq9puzZvOVkM71T6FzJ3lXV3uGuq53rLktIIPXozcvo2BVQms3p4rMWCV1SjYHXdW8YnUFEUKWlBp3DOSkSkvYJ7Ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499137; c=relaxed/simple;
	bh=S3+pOJoUuUOEkrcjFFOuXEmEJU8uMeYFcgKG22k7/t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QmA14htVK19Q5IhYfiZLz+GJC1XGEQDeV4fceDjsU2P37z7bbdSt6qHQjXGaRpiZ2UHbhjd3EXPIO9XX3Y4hwyx3OqY52a11qkf5C5Apoj/Sl5/Dz5mFBREHOuKy6RmD4uDnvNQrfIXkRjPMN1u9eEhGSRQ+EBhbW/JEswSANiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn7KBeR8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743499135; x=1775035135;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=S3+pOJoUuUOEkrcjFFOuXEmEJU8uMeYFcgKG22k7/t4=;
  b=Qn7KBeR81rDJa7OEATzYO2kRn8F+x8S+czMVJBcC2n/nHQmO3OPYrvuv
   q4oYqH8jNaqR9bx34HzSpjFf9AbTl0rWq3QKcF5SylQYhfWjYUY7r7uLP
   KRSxQOthY5iAKbkOB0/qTKqUISUETRbT9eQPwLJAjCZH+VG0K2QENWctx
   VS/PCMn/nHrTGzWKQkUcfLb411oI2UC26cOB6IBt28k5KTLizNF5WWZTF
   hYto3pJzqBwGxc1gz+I2TAY0t+5wA3r1ULeCsj8AHeEiUJimn2KV/CTnL
   8o+g5bD+fAB7582Xe51xuzOuQV9X43+/6rAszGycmzfH0xgavoAbXfWtx
   A==;
X-CSE-ConnectionGUID: uZ6MberMT7q8MkEo11Hi2w==
X-CSE-MsgGUID: +10j66ARTc2J78NV7LE6/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="43960440"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="43960440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 02:18:53 -0700
X-CSE-ConnectionGUID: l62pIIDVTpKQjS29hPejPw==
X-CSE-MsgGUID: h1upR25NRkGMXNeVbsnwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131541390"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 02:18:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Cc: Wayne Lin <Wayne.Lin@amd.com>, Jerry Zuo <jerry.zuo@amd.com>, Zaeem
 Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 cascardo@igalia.com, imre.deak@intel.com
Subject: Re: [PATCH 6.12] drm/amd/display: Don't write DP_MSTM_CTRL after LT
In-Reply-To: <20250331145819.682274-1-cascardo@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250331145819.682274-1-cascardo@igalia.com>
Date: Tue, 01 Apr 2025 12:18:46 +0300
Message-ID: <87zfh02qa1.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 31 Mar 2025, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> From: Wayne Lin <Wayne.Lin@amd.com>
>
> [ Upstream commit bc068194f548ef1f230d96c4398046bf59165992 ]
>
> [Why]
> Observe after suspend/resme, we can't light up mst monitors under specific
> mst hub.

This is already at stable backport stage, but it would really be helpful
to log *which* specific mst hub we're talking about here. Now the
information is lost in time, at least to outsiders.

BR,
Jani.



> The reason is that driver still writes DPCD DP_MSTM_CTRL after LT.
> It's forbidden even we write the same value for that dpcd register.
>
> [How]
> We already resume the mst branch device dpcd settings during
> resume_mst_branch_status(). Leverage drm_dp_mst_topology_queue_probe() to
> only probe the topology, not calling drm_dp_mst_topology_mgr_resume() which
> will set DP_MSTM_CTRL as well.
>
> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d9a3917d207e..c4c6538eabae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3231,8 +3231,7 @@ static int dm_resume(void *handle)
>  	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
>  	enum dc_connection_type new_connection_type = dc_connection_none;
>  	struct dc_state *dc_state;
> -	int i, r, j, ret;
> -	bool need_hotplug = false;
> +	int i, r, j;
>  	struct dc_commit_streams_params commit_params = {};
>  
>  	if (dm->dc->caps.ips_support) {
> @@ -3427,23 +3426,16 @@ static int dm_resume(void *handle)
>  		    aconnector->mst_root)
>  			continue;
>  
> -		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
> -
> -		if (ret < 0) {
> -			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> -					aconnector->dc_link);
> -			need_hotplug = true;
> -		}
> +		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
>  	}
>  	drm_connector_list_iter_end(&iter);
>  
> -	if (need_hotplug)
> -		drm_kms_helper_hotplug_event(ddev);
> -
>  	amdgpu_dm_irq_resume_late(adev);
>  
>  	amdgpu_dm_smu_write_watermarks_table(adev);
>  
> +	drm_kms_helper_hotplug_event(ddev);
> +
>  	return 0;
>  }

-- 
Jani Nikula, Intel

