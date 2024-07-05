Return-Path: <stable+bounces-58150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EB928C8D
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69308287CE1
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAB16D338;
	Fri,  5 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LglkokbF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7092F5E;
	Fri,  5 Jul 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198729; cv=none; b=mhnz5PGSJ/1HGw6ez1yui6RS1foUObt+zU7NhBtn5wL/brrTWIzhkcuGP/Ba+4n/qwkIf/UzQL9aHVnysvKddLYJaLkZIfdMN0jeGSWEhK3/MVaTbcEBd3J1Y5KjFELK5y8Uu51/h4Xze75TwegPS0OVQFQkx8OBgz1b0Zkuhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198729; c=relaxed/simple;
	bh=oOHv5vKH1IZynVlCLLK+KNAq96qbLhSgisVIUWyYrEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb25doHsC0MsFT7b6lxPQTdWogWcvWnrEXnDXL55cUQimnrRa8MsuVntGmE5RvS9VK1TlWIO2O7yw4BTBb3JRHAP8jwOhL/ABhzB0mzh8S/HeRBpLIcZ5p+yXsmNRgi+Ni7G4mK6S2Z6pOk+f0PLMoZYE5gE9sk/12zcMjdgM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LglkokbF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720198727; x=1751734727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oOHv5vKH1IZynVlCLLK+KNAq96qbLhSgisVIUWyYrEw=;
  b=LglkokbFeKZDd1CrkI9XuvBc079rCovaDgiABCmfugHQQR4qOv4KczjX
   kvTFsz6eA7oKgrEcfuJrhv2M2MEPTnIZLm1C1mql+mkDQo4R+FSkDOSe+
   q3KilVjPlK9JIneSpdxlYq5a2y1GHvw45AwcM9Bsn1MBSNzbBWOUJZmpz
   99pj4l7g/lNcCwirWpaEGXajTVOI25TdTlICYCGUy/SGZXZbgRxnmQEhF
   R+pF5/dcqJ6k2ktxHDx8VDB9wbx/muNAk9w2x8VcPDmil9RyHpdHVl2Wt
   KFqlvLFbs48tgjuG4nTUTRcAnf8cr5OTBOB9UmyTtwTye3wyUiYWttlMw
   g==;
X-CSE-ConnectionGUID: kqdKHJTJTCSrB4uEbmCZVg==
X-CSE-MsgGUID: nu4+wcVfRbmT5EfvpC1ezA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28649331"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="28649331"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:58:46 -0700
X-CSE-ConnectionGUID: TFZusHLnTp+7M7CpwAdY1w==
X-CSE-MsgGUID: XPBUW+DgTyi4UrXnOfwS9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="51518219"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.162]) ([10.247.38.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:58:43 -0700
Message-ID: <5dbb95b5-96c1-4bbc-a4e0-c0616efa7ac2@linux.intel.com>
Date: Sat, 6 Jul 2024 00:58:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1 1/4] igc: Fix qbv_config_change_errors logics
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 richardcochran@gmail.com
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-2-faizal.abdul.rahim@linux.intel.com>
 <20240703150830.GO598357@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240703150830.GO598357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> index 22cefb1eeedf..02dd41aff634 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -78,6 +78,17 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>>   	wr32(IGC_GTXOFFSET, txoffset);
>>   }
>>   
>> +bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter)
>> +{
>> +	struct igc_hw *hw = &adapter->hw;
>> +
>> +	if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
>> +	    adapter->taprio_offload_enable)
>> +		return true;
>> +	else
>> +		return false;
> 
> As per my response to patch 2/4, I think something like this is a bit
> nicer:
> 
> (Completely untested!)
> 
> 	return (rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
> 		adapter->taprio_offload_enable;
> 
> 

Will update, thanks.


