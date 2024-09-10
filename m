Return-Path: <stable+bounces-75652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971C973913
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB4E1C249DF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34274192B8B;
	Tue, 10 Sep 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0hKBByp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2017E8F7;
	Tue, 10 Sep 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976191; cv=none; b=AW7HlQdYWXHaUJc+l0gHGqgdihi/IAgnEiSOqO1uzh3oIbTE0gNZbTg+mkoFCXsqGvt321bk9shrK5z81uOsmIkG1aWfnKfKH2cxdGI/VAsVZ5BepG1VuJ+bguBjMJNhj50TdGg5adSYWGqJWR//jhYB+RxFe+2iWFm5j0GLvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976191; c=relaxed/simple;
	bh=sB67UM2Zr/q7FoL8u4RtQFupw/SD6hgP282y93A+VVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SWugFNOzzY+WHxSnPFKe2VlMT8grlun2x5xeNiY9xOD74Y8W1CHov02b0WxK91b+braEzUA/VH5aOkKsFH/HynspZZC6b6/YTVlRbmFnqJCix+F65JLiBLrJRw89Q/ZeWCVcWRFoFuNw+R6ApA/vGVJAmNpv6aojxkBZwhDPBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0hKBByp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725976189; x=1757512189;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sB67UM2Zr/q7FoL8u4RtQFupw/SD6hgP282y93A+VVc=;
  b=b0hKBBypQZ9802NJXCx+yZBYMKHtp23gnz5KlFzQ4f1mCjYcKHesfG25
   r8sqCTHoQnfD6zVmPDU3uBzelSRKDhHKaB7ZFkEO+MZN2C6JtCospKhfV
   w1Qr6P8unw9VPd6nlqDxn2pKDstJMVN4XGQwsW19k7oN1YCoBNMbVgSL+
   qoQKFC1oa8myeXarVQ9N/rwem04ZnTvA3csapkWKuo8YzsQPQsop2a9cz
   1u/QwDOhy+7lSZfHuW1ugyVlUkAtpc+/kEUxqs1X/htUF6ZQDA7jKeahc
   0bqhLTrKRC2kV+pzruJB0qXqMU57p4i7gh6ckpkE5+3HEru7f7vNb0JGY
   w==;
X-CSE-ConnectionGUID: PhShz7C7RBCtItB9b7ZmRg==
X-CSE-MsgGUID: 6ovSeOT0TN6i9I36/lL+nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42240468"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="42240468"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:49:48 -0700
X-CSE-ConnectionGUID: re10FFAzQcigLzN/JNyLIQ==
X-CSE-MsgGUID: eGchYnd+QDWW4DIT/4hATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66652238"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO [10.245.245.155]) ([10.245.245.155])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:49:46 -0700
Message-ID: <a7a4bb04-de90-4637-b9e4-81c3138347d3@linux.intel.com>
Date: Tue, 10 Sep 2024 16:49:55 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org
References: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
 <568137f5-4e4f-4df7-8054-011977077098@linux.intel.com>
Content-Language: en-US
In-Reply-To: <568137f5-4e4f-4df7-8054-011977077098@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/09/2024 16:05, Péter Ujfalusi wrote:
> 
> 
> On 09/09/2024 19:47, Krzysztof Kozlowski wrote:
>> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
>> breaks codecs using non-continuous masks in source and sink ports.  The
>> commit missed the point that port numbers are not used as indices for
>> iterating over prop.sink_ports or prop.source_ports.
>>
>> Soundwire core and existing codecs expect that the array passed as
>> prop.sink_ports and prop.source_ports is continuous.  The port mask still
>> might be non-continuous, but that's unrelated.
>>
>> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
>> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
>> Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Vinod: can you pick this patch for 6.11 if there is still time since
upstream is also broken since 6.11-rc6


> 
>>
>> ---
>>
>> Resending with Ack/Rb tags and missing Cc-stable.
>> ---
>>  drivers/soundwire/stream.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index f275143d7b18..7aa4900dcf31 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>>  					    unsigned int port_num)
>>  {
>>  	struct sdw_dpn_prop *dpn_prop;
>> -	unsigned long mask;
>> +	u8 num_ports;
>>  	int i;
>>  
>>  	if (direction == SDW_DATA_DIR_TX) {
>> -		mask = slave->prop.source_ports;
>> +		num_ports = hweight32(slave->prop.source_ports);
>>  		dpn_prop = slave->prop.src_dpn_prop;
>>  	} else {
>> -		mask = slave->prop.sink_ports;
>> +		num_ports = hweight32(slave->prop.sink_ports);
>>  		dpn_prop = slave->prop.sink_dpn_prop;
>>  	}
>>  
>> -	for_each_set_bit(i, &mask, 32) {
>> +	for (i = 0; i < num_ports; i++) {
>>  		if (dpn_prop[i].num == port_num)
>>  			return &dpn_prop[i];
>>  	}
> 

-- 
Péter

