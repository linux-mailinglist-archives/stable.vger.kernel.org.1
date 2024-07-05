Return-Path: <stable+bounces-58149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F376928C81
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E80EB24E4E
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4316D310;
	Fri,  5 Jul 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi6FKv0J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603816ABC6;
	Fri,  5 Jul 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198357; cv=none; b=p/CQT331D6TWeYXI7zk8JOxOyYUbJD70anNBhPdsZsO2nzsOA3azODyiAnz4abac2Rbd7BLLAULped5Pf2S6hndLkLbLt8yjdRgQYatFTwJEFwW8n8hu8KrDE05FF9+VqFYzMmlYNAZ87ICb+W70PP0/wfrjGMKrvYNefa/CIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198357; c=relaxed/simple;
	bh=bVhBpudNHtT6aZemL1Hlw4OKJZa6uNcfbc/AzBjAcHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jy3fNEyDsy2+YARo54mA5+zxSX+xyqusXYLZnTgqHdtC2meoPFWN7XLFLLXM5ckUMc0EQkkZm/6FzeMVQ4KqEu+nFwa6/7r3klbmcoeIgEUmhpXehiTr7WVf94wMOeeiOhnrrXPPgnE0Q5nSVTO/uNBI6nDacJhf34lA/PcOJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi6FKv0J; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720198356; x=1751734356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bVhBpudNHtT6aZemL1Hlw4OKJZa6uNcfbc/AzBjAcHA=;
  b=Pi6FKv0JOkvg1xopoD1P4TDWmuRetftcNBcAXbGWwMdCd4XEBUIB9xRB
   kTQ/J0yfsGP4MehaYsY0nwfLtsT9vCdBCZc8t+Fh305aap0QlpJlOR8kY
   qP8OaGuQj+tM/lvepFKIk1ALgdZ6nFqrp7sqeXH6H1cAO6KwTehm67ULQ
   ZJGgPwV5cUmK7R58QKmP5wHYsXquRCdm1HmS3y98FocM1I07oljXUTLDy
   rV/bQlufVF5UhlXOjBLiJmuZB80VUYq/qzRyRKjUIp9+sNS+1UK3zyEHa
   nNgGe5cJL4xXG4Ewnpt0Q9EZ5nU3ZieDF5irCxOebCmVAnt9dBtYcJJHw
   w==;
X-CSE-ConnectionGUID: 7dO4p0AwQAikYjv4imS/AQ==
X-CSE-MsgGUID: NQN5glWYR/OuiJpHfBDbug==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17628324"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17628324"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:52:35 -0700
X-CSE-ConnectionGUID: BPtgV7+XSzyw7zOf+zxruw==
X-CSE-MsgGUID: 3AUomb7nSEuFS8hAk75H7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47659166"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.162]) ([10.247.38.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:52:32 -0700
Message-ID: <89ffac90-0293-4621-8178-99120af354ef@linux.intel.com>
Date: Sat, 6 Jul 2024 00:52:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1 2/4] igc: Fix reset adapter logics when tx mode
 change
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-3-faizal.abdul.rahim@linux.intel.com>
 <20240703150318.GN598357@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240703150318.GN598357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> ---
>>   drivers/net/ethernet/intel/igc/igc_tsn.c | 26 +++++++++++++++++++++---
>>   1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> index 02dd41aff634..61f047ebf34d 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -49,6 +49,13 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>>   	return new_flags;
>>   }
>>   
>> +static bool igc_tsn_is_tx_mode_in_tsn(struct igc_adapter *adapter)
>> +{
>> +	struct igc_hw *hw = &adapter->hw;
>> +
>> +	return (bool)(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);
> 
> Perhaps it is more a question of taste than anything else.
> But my preference, FIIW, is to avoid casts.
> And I think in this case using !! is a common pattern.
> 
> (Completely untested!)
> 
> 	return !!(rd32(IGC_TQAVCTRL) & IGC_TQAVCTRL_TRANSMIT_MODE_TSN);
> 

Sure, will update.

>> +
>> +	if ((any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
>> +	    (!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter)))
>> +		return true;
>> +	else
>> +		return false;
> 
> Likewise, this is probably more a matter of taste than anything else.
> But I think this could be expressed as:
> 
> (Completely untested!)
> 
> 	return (any_tsn_enabled && !igc_tsn_is_tx_mode_in_tsn(adapter)) ||
> 		(!any_tsn_enabled && igc_tsn_is_tx_mode_in_tsn(adapter));
> 
> Similarly in the previous patch of this series.
> 

Will update, your suggestion is better, lesser parenthesis.
Thanks.

