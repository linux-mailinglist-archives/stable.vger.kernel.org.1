Return-Path: <stable+bounces-72770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5B9695B1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF3B1F220EC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871991D6DD3;
	Tue,  3 Sep 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXPHq4MN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9981CEAC0;
	Tue,  3 Sep 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348896; cv=none; b=Pna6TDbc9CDHkRS3v/crohoug5jKpwDc8em2UTBdvg+C5Ar3F1MGrJmqV73EdK/h0SGlVS5ynHn45i7NjcHkAztkYUZo7HVQCmFl9TmRqxWRyffpvnZkg445u3ciiIq84+NcB+Rs1uYGyE9OLSpXLHVbmGRl4bx1qoVB7VAa6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348896; c=relaxed/simple;
	bh=4AJT32GBtfUx0n4zgp7GIkKvAN6ljEoZ5TCSEJ6nLVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sho9B7xq70NAt21H1mEVqvKJbOelcYorNXf7F1nYPORoilPqJfHV7xbD8OSc2K/EFeRP+S6echyGFIxUvS24WP919nDq7hak4IEtSeU6CCeVg9gyhA+VNMAOh6+US7s/ETtdGChsjlgT65I5K/wGJuBS2YS/SiN45n0X8NuiHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXPHq4MN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725348895; x=1756884895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4AJT32GBtfUx0n4zgp7GIkKvAN6ljEoZ5TCSEJ6nLVE=;
  b=lXPHq4MNOWzeMjk7+4mZo5CwC97JBF6dQdrCeUx0N9eHf3fxtsby/ODz
   mhZZ9v8cmeSMqdmqO6mgnn7OdWTqPc5kedb4lVII5XCvKZnl3HhqFU38F
   fWNybb/9B3WCeC5JtlUgqEBuF5Bma+AHD/2IO8Ku8ctxCIQ7eXkRYg0m/
   7v7YTDE9L70i3PWRc+Rm7jjFO9aZeJkh5+olBxTYIhyWAsETNiRq3KzyW
   63AVsZ6BMcYc3kSAnhSvQGlfgvwrE44PxzvPFueRH2np66M/uoFasD1nB
   xrLc1VAN6+CwU3rN76XlaBpSX4alFTD6pCNxmOlk1MMZfG4bnTC8a+2L3
   g==;
X-CSE-ConnectionGUID: jFE25404RjOGhk4JDmGGXQ==
X-CSE-MsgGUID: fTYDnq24Q6WcXZ4VVhsp+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23444570"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="23444570"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:34:54 -0700
X-CSE-ConnectionGUID: +XoVRmVvSsWR30tLGOqOMg==
X-CSE-MsgGUID: UBzXbGaXRDqEI5fW6GMADQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="95623507"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.104.225]) ([10.246.104.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:34:51 -0700
Message-ID: <b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com>
Date: Tue, 3 Sep 2024 15:34:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bard.liao@intel.com
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <ZqngD56bXkx6vGma@matsya>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <ZqngD56bXkx6vGma@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/2024 2:56 PM, Vinod Koul wrote:
> On 29-07-24, 16:25, Pierre-Louis Bossart wrote:
>>
>> On 7/29/24 16:01, Krzysztof Kozlowski wrote:
>>> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
>>> 'sink_ports' - define which ports to program in
>>> sdw_program_slave_port_params().  The masks are used to get the
>>> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
>>> an array.
>>>
>>> Bitmasks can be non-continuous or can start from index different than 0,
>>> thus when looking for matching port property for given port, we must
>>> iterate over mask bits, not from 0 up to number of ports.
>>>
>>> This fixes allocation and programming slave ports, when a source or sink
>>> masks start from further index.
>>>
>>> Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> This is a valid change to optimize how the port are accessed.
>>
>> But the commit message is not completely clear, the allocation in
>> mipi_disco.c is not modified and I don't think there's anything that
>> would crash. If there are non-contiguous ports, we will still allocate
>> space that will not be initialized/used.
>>
>> 	/* Allocate memory for set bits in port lists */
>> 	nval = hweight32(prop->source_ports);
>> 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>> 					  sizeof(*prop->src_dpn_prop),
>> 					  GFP_KERNEL);
>> 	if (!prop->src_dpn_prop)
>> 		return -ENOMEM;
>>
>> 	/* Read dpn properties for source port(s) */
>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>> 			   prop->source_ports, "source");
>>
>> IOW, this is a valid change, but it's an optimization, not a fix in the
>> usual sense of 'kernel oops otherwise'.
>>
>> Am I missing something?
>>
>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>> different properties, BIT(0) cannot be set for either of the sink/source
>> port bitmask.
> The fix seems right to me, we cannot have assumption that ports are
> contagious, so we need to iterate over all valid ports and not to N
> ports which code does now!


Sorry to jump in after the commit was applied. But, it breaks my test.

The point is that dpn_prop[i].num where the i is the array index, and

num is the port number. So, `for (i = 0; i < num_ports; i++)` will iterate

over all valid ports.

We can see in below drivers/soundwire/mipi_disco.c

         nval = hweight32(prop->sink_ports);

         prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,

sizeof(*prop->sink_dpn_prop),

                                            GFP_KERNEL);

And sdw_slave_read_dpn() set data port properties one by one.

`for_each_set_bit(i, &mask, 32)` will break the system when port numbers

are not continuous. For example, a codec has source port number = 1 and 3,

then dpn_prop[0].num = 1 and dpn_prop[1].num = 3. And we need to go

throuth dpn_prop[0] and dpn_prop[1] instead of dpn_prop[1] and dpn_prop[3].


>
>>
>>> ---
>>>   drivers/soundwire/stream.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>>> index 7aa4900dcf31..f275143d7b18 100644
>>> --- a/drivers/soundwire/stream.c
>>> +++ b/drivers/soundwire/stream.c
>>> @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>>>   					    unsigned int port_num)
>>>   {
>>>   	struct sdw_dpn_prop *dpn_prop;
>>> -	u8 num_ports;
>>> +	unsigned long mask;
>>>   	int i;
>>>   
>>>   	if (direction == SDW_DATA_DIR_TX) {
>>> -		num_ports = hweight32(slave->prop.source_ports);
>>> +		mask = slave->prop.source_ports;
>>>   		dpn_prop = slave->prop.src_dpn_prop;
>>>   	} else {
>>> -		num_ports = hweight32(slave->prop.sink_ports);
>>> +		mask = slave->prop.sink_ports;
>>>   		dpn_prop = slave->prop.sink_dpn_prop;
>>>   	}
>>>   
>>> -	for (i = 0; i < num_ports; i++) {
>>> +	for_each_set_bit(i, &mask, 32) {
>>>   		if (dpn_prop[i].num == port_num)
>>>   			return &dpn_prop[i];
>>>   	}

