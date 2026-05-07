Return-Path: <stable+bounces-244558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG+KLC18/Gl0QgAAu9opvQ
	(envelope-from <stable+bounces-244558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:49:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EE4E7B8F
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55BD3301876B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D733D812C;
	Thu,  7 May 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijihpFcH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F953ACA43;
	Thu,  7 May 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154471; cv=none; b=bB7I4dTZNKTOLazt8No1H2IgqPclTZakiYWK1PrMdTFt9lWAAmW1RRi66meyt0yOr6TA7fzI/sZzrRm2JEJx7Yc5EvOWTnP7NxGTZdkXLMs+7pM8M25jzKP1plVBwWHnGORdMbwZ8gPE1rJ9VbaZlTEWEFFr4qdo9u3544H37OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154471; c=relaxed/simple;
	bh=hOh+VaLLck43nAplkfF92iG+/ppyrDVDliM63RnV7OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCD+y+Nl6/pa6oG4Q6VtWnf8BojPc4ZBv8rf2B0auRfieTSY/1e26hUEOIZ6O6PluDLT0HqsSuekzzlRzZJd0Q8DVTunwYRJAXtB7jigNvAjjs6i0MvPLYMfbAm2EmQHOFSsAh8qy0tWfe+PPUf3ZPY88KzlKs3OJ1Lcdc+9JFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijihpFcH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778154470; x=1809690470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hOh+VaLLck43nAplkfF92iG+/ppyrDVDliM63RnV7OY=;
  b=ijihpFcH1q4q83uBoszUQgqQK2FqE9W0M+6pday1FBAFX9/YBRrCp/aU
   L1u1C6WJunEUmllD4YGdS/e2N3Jw561flzoLPtxohKeTZgefmQ5K5DiHH
   VkSEuLwPqDEFl2iAnC1dkDScRPmpogSoy59We/zY1Hf8gDBYPmivxNSGu
   EAhS9/GZLVgVuC5+wDGzepCfT7LgCxaUI7A5MNeJIp2393IhMhAH/AeeM
   jNBh5rwF4y5tQ3u1b0wV30d/i7069t9J/o3Pe6w7yjLTxXJF7ShjgidBd
   L8r0U6rvVIImdqW4hUHpUDa4uicLRNwWdsenTFQ6fqikhIhT3L9q3ZAlT
   Q==;
X-CSE-ConnectionGUID: VeFPtGnPTYiIHODQo1uj4A==
X-CSE-MsgGUID: JvGSnzwoRv6EkZmjjkhgyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101777097"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="101777097"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:47:49 -0700
X-CSE-ConnectionGUID: tYFjJU1JQcuWUN7kr3tsmA==
X-CSE-MsgGUID: BkOZ65goQ9q8cJxW3piOLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236355898"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.168]) ([10.246.20.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:47:45 -0700
Message-ID: <56e52628-d029-4919-95dd-aa6da13f3b08@linux.intel.com>
Date: Thu, 7 May 2026 13:47:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/13] ice: fix setting RSS VSI hash for E830
To: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Madhu Chittim
 <madhu.chittim@intel.com>, Willem de Bruijn <willemb@google.com>,
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-9-a222a88bd962@intel.com>
 <068a5266-4721-4496-b027-3b32da3e02ea@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <068a5266-4721-4496-b027-3b32da3e02ea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F6EE4E7B8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244558-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 06.05.2026 23:06, Jacob Keller wrote:
> On 5/4/2026 10:14 PM, Jacob Keller wrote:
>> From: Marcin Szycik <marcin.szycik@linux.intel.com>
>>
>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>> mistakenly set to the value of another field, instead of its original
>> value, probably due to a typo. What happens next is hardware-dependent:
>>
>> On E810, only the first bit is meaningful (see
>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>> state than before VSI update.
>>
>> On E830, some of the remaining bits are not reserved. Setting them
>> to some unrelated values can cause the firmware to reject the update
>> because of invalid settings, or worse - succeed.
>>
>> Reproducer:
>>   sudo ethtool -X $PF1 equal 8
>>
>> Output in dmesg:
>>   Failed to configure RSS hash for VSI 6, error -5
>>
>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 1d1947a7fe11..c52c465280f7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -8046,7 +8046,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>  	ctx->info.q_opt_rss |=
>>  		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>  	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>> -	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>> +	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>>  
>>  	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>  	if (err) {
>>
> 
> Sashiko complains about ice_set_rss_hfunc() but it is unrelated to this fix:
> 
>> While looking at this function, I noticed a pre-existing issue regarding the
>> hardware cache. Does calling ice_update_vsi() with a local context leave the
>> global hw->vsi_ctx[vsi->idx] out of sync?
>> If ice_update_vsi() succeeds, vsi->info.q_opt_rss is updated, but
>> hw->vsi_ctx[vsi->idx]->info.q_opt_rss is not.
>> When an unrelated feature such as RDMA filtering is subsequently toggled via
>> ice_cfg_rdma_fltr(), could it retrieve this stale cached context via
>> ice_get_vsi_ctx() and copy the stale q_opt_rss value back into its command
>> buffer?

Yes.

>> Could this cause the firmware to silently revert the RSS hash function to its
>> previous configuration during the next ice_update_vsi() call?

No, because the context object passed to ice_update_vsi() only sets
ctx->info.valid_sections for the sections it wants to update, so unrelated
values are not updated in HW.

Looking at other ice_update_vsi() calls, most of the times the context object is
being allocated, not taken from cache. It's not immediately clear to me what
purpose does hw->vsi_ctx[] serve - it only appears to be used in
ice_cfg_rdma_fltr() (correct me if I'm wrong), where options from the cached
context are being read to fill the unchanged fields in the updated section.
This seems to be the equivalent of keeping track of context values in vsi->info,
which is what almost all ice_update_vsi() callers do.
If I had to guess, I'd say hw->vsi_ctx[] could probably be removed and vsi->info
used instead, but maybe I'm missing something.

TLDR I think this is just old, inconsistent code that could be improved, but it
needs some investigation. Until we don't have a clear signal that there's a bug,
I wouldn't touch it.

>> There also appears to be a pre-existing issue with state desynchronization
>> when handling failures. After ice_update_vsi() succeeds, vsi->rss_hfunc
>> is updated, but ice_set_rss_hfunc() then calls ice_set_rss_cfg_symm() at the
>> end of the function:
>> ice_set_rss_hfunc() {
>>         ...
>>         err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>         if (err) {
>>                 ...
>>         } else {
>>                 vsi->info.q_opt_rss = ctx->info.q_opt_rss;
>>                 vsi->rss_hfunc = hfunc;
>>                 ...
>>         }
>>         ...
>>         return ice_set_rss_cfg_symm(hw, vsi, symm);
>> }
>> If ice_set_rss_cfg_symm() fails, the error is returned but vsi->rss_hfunc
>> remains updated. If the user retries the command, the early check:
>> if (hfunc == vsi->rss_hfunc)
>>         return 0;
>> evaluates to true and returns success immediately.
>> Could this skip the ice_set_rss_cfg_symm() retry entirely, leaving the
>> hardware's flow director rules in a non-symmetric state permanently while
>> falsely reporting success?

This looks valid.

Thanks,
Marcin

> Someone from the ice team should look into this and determine whether or
> not its valid.


