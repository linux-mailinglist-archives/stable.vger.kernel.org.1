Return-Path: <stable+bounces-43499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F18C0FCD
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76FA1C22482
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5D13B5B6;
	Thu,  9 May 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZVBL+1Xh"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD91FAA;
	Thu,  9 May 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258603; cv=none; b=bG/Bv4t9fmvozsKTxkNdKmBfcxq0Aio9zIZvUmmoKT9PYGtlqhPm9w4wFzWJch87hzvGehigcPQJg3eNVtqqHMYvNOVwD67G+c8YHVuqsS/gymO+L4tiUIGqzDloftBc1G/vyknHIyRgnO3iAsGxaeapbJ72eH3nWfp3qQFLAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258603; c=relaxed/simple;
	bh=Om+BDgaPCw0iL+muHtQNoJmPf5Hq2QpY3SBFrHv7wgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtJrLugwA2Zf6sDdp/eP1lwQ5nT81tjibhJZnUopbdfIy3nHeksgNReMyNXfQHB5y/5hqDJ38lqQ7/JvzLEf1zklQiKfjBt4SuWCSaO+hRNsL8XycSgywp2AMnXawyzuyLZJ7yARFFTlkFECWRxXgHuI+vjmTF+egVG+AaxZpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZVBL+1Xh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=gpCe6LjXBhGLTjURAG6pCgVHAv6LRa6xLP8t9gn2lQM=;
	t=1715258601; x=1715690601; b=ZVBL+1XhBBYZCBqTbIh/Qe8EeZOtLDoDxi/O/uKEDIhsVw4
	zxE4c2dQWltor/cDB76cGXqJ1xAMGsYSJ9hI9kQZUnJGArYZz3/4WAAVoo1h3CvrQPBlNDEH95b42
	kk550On/L52SNZlxJ+ph+y1ll8FwGXTu5WZYnr4mt75cuPXN5tE4z38lnWm4Xc/6SUisYuvJc4/Mk
	XixCYjC2OWd+lHF+n4ANGO75OU1IS8V69OmrMoT0UyfbHA0bWH+8F2qTlAP5XMwdMEtPoOAQjpADk
	RdnrxIKi5hT60mJ5i8cBTNOZ+4S+wvc3eWp8dNXnWwV//WtF4X2LrUWM2XUAOlZA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s537E-0007dX-TB; Thu, 09 May 2024 14:43:16 +0200
Message-ID: <41b87510-7abf-47e8-b28a-9ccc91bbd3c1@leemhuis.info>
Date: Thu, 9 May 2024 14:43:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
 drm_dp_add_payload_part2
To: Harry Wentland <harry.wentland@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: lyude@redhat.com, imre.deak@intel.com,
 =?UTF-8?Q?Leon_Wei=C3=9F?= <leon.weiss@ruhr-uni-bochum.de>,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
References: <20240307062957.2323620-1-Wayne.Lin@amd.com>
 <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715258601;09692b8d;
X-HE-SMSGID: 1s537E-0007dX-TB

On 18.04.24 21:43, Harry Wentland wrote:
> On 2024-03-07 01:29, Wayne Lin wrote:
>> [Why]
>> Commit:
>> - commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload allocation/removement")
>> accidently overwrite the commit
>> - commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2")
>> which cause regression.
>>
>> [How]
>> Recover the original NULL fix and remove the unnecessary input parameter 'state' for
>> drm_dp_add_payload_part2().
>>
>> Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload allocation/removement")
>> Reported-by: Leon Weiß <leon.weiss@ruhr-uni-bochum.de>
>> Link: https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de/
>> Cc: lyude@redhat.com
>> Cc: imre.deak@intel.com
>> Cc: stable@vger.kernel.org
>> Cc: regressions@lists.linux.dev
>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> 
> I haven't been deep in MST code in a while but this all looks
> pretty straightforward and good.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Hmmm, that was three weeks ago, but it seems since then nothing happened
to fix the linked regression through this or some other patch. Is there
a reason? The build failure report from the CI maybe?

Wayne Lin, do you know what's up?

Ciao, Thorsten

>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>>  drivers/gpu/drm/display/drm_dp_mst_topology.c             | 4 +---
>>  drivers/gpu/drm/i915/display/intel_dp_mst.c               | 2 +-
>>  drivers/gpu/drm/nouveau/dispnv50/disp.c                   | 2 +-
>>  include/drm/display/drm_dp_mst_helper.h                   | 1 -
>>  5 files changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index c27063305a13..2c36f3d00ca2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -363,7 +363,7 @@ void dm_helpers_dp_mst_send_payload_allocation(
>>  	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
>>  	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
>>  
>> -	ret = drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, new_payload);
>> +	ret = drm_dp_add_payload_part2(mst_mgr, new_payload);
>>  
>>  	if (ret) {
>>  		amdgpu_dm_set_mst_status(&aconnector->mst_status,
>> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> index 03d528209426..95fd18f24e94 100644
>> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> @@ -3421,7 +3421,6 @@ EXPORT_SYMBOL(drm_dp_remove_payload_part2);
>>  /**
>>   * drm_dp_add_payload_part2() - Execute payload update part 2
>>   * @mgr: Manager to use.
>> - * @state: The global atomic state
>>   * @payload: The payload to update
>>   *
>>   * If @payload was successfully assigned a starting time slot by drm_dp_add_payload_part1(), this
>> @@ -3430,14 +3429,13 @@ EXPORT_SYMBOL(drm_dp_remove_payload_part2);
>>   * Returns: 0 on success, negative error code on failure.
>>   */
>>  int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>> -			     struct drm_atomic_state *state,
>>  			     struct drm_dp_mst_atomic_payload *payload)
>>  {
>>  	int ret = 0;
>>  
>>  	/* Skip failed payloads */
>>  	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
>> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
>> +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
>>  			    payload->port->connector->name);
>>  		return -EIO;
>>  	}
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> index 53aec023ce92..2fba66aec038 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> @@ -1160,7 +1160,7 @@ static void intel_mst_enable_dp(struct intel_atomic_state *state,
>>  	if (first_mst_stream)
>>  		intel_ddi_wait_for_fec_status(encoder, pipe_config, true);
>>  
>> -	drm_dp_add_payload_part2(&intel_dp->mst_mgr, &state->base,
>> +	drm_dp_add_payload_part2(&intel_dp->mst_mgr,
>>  				 drm_atomic_get_mst_payload_state(mst_state, connector->port));
>>  
>>  	if (DISPLAY_VER(dev_priv) >= 12)
>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> index 0c3d88ad0b0e..88728a0b2c25 100644
>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> @@ -915,7 +915,7 @@ nv50_msto_cleanup(struct drm_atomic_state *state,
>>  		msto->disabled = false;
>>  		drm_dp_remove_payload_part2(mgr, new_mst_state, old_payload, new_payload);
>>  	} else if (msto->enabled) {
>> -		drm_dp_add_payload_part2(mgr, state, new_payload);
>> +		drm_dp_add_payload_part2(mgr, new_payload);
>>  		msto->enabled = false;
>>  	}
>>  }
>> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
>> index 9b19d8bd520a..6c9145abc7e2 100644
>> --- a/include/drm/display/drm_dp_mst_helper.h
>> +++ b/include/drm/display/drm_dp_mst_helper.h
>> @@ -851,7 +851,6 @@ int drm_dp_add_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
>>  			     struct drm_dp_mst_topology_state *mst_state,
>>  			     struct drm_dp_mst_atomic_payload *payload);
>>  int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>> -			     struct drm_atomic_state *state,
>>  			     struct drm_dp_mst_atomic_payload *payload);
>>  void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
>>  				 struct drm_dp_mst_topology_state *mst_state,
> 
> 
> 

