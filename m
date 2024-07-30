Return-Path: <stable+bounces-62702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01859940D98
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC37285710
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC4194C7B;
	Tue, 30 Jul 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q962MRQN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6E194C74;
	Tue, 30 Jul 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331726; cv=none; b=VpJo6OO1oramnvDa9z3Abl0Ft9jQN12b+GFGMR3WrDXOCmk+e4grMkTQjR0a4qhsui1NftQHrNi1hKb8uFNFYHpgU72mbC79gGxebf4Px8Ab3yprxaTJBcIpFCPggXRlwdAQEOLEYkyKA7iiRT3HfjifwcEzMTtjIXOSzJuD2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331726; c=relaxed/simple;
	bh=FTZPCGs19HrWuOXGCtCh9HJCvH3o9m5VKj2oA581aUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gscif4T/c9waJDTWbbG1GKpfsc0zs0vCFEDaecP+trqNk8XQDIFP/lIENnZl6BBPs7tM4gBLZJCQFP8LuxlGhoo9FArRj3Gr0zWaopdSABQXugKLjdNMI1G+Y19v96mQQyFeyIURpIUL+Rh0d9qgMDX9ofMLmQK2Fb8FY/W2o/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q962MRQN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331725; x=1753867725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FTZPCGs19HrWuOXGCtCh9HJCvH3o9m5VKj2oA581aUI=;
  b=Q962MRQNPqVPSJjtywgjN2pMqB1s6rviOZfLEgIYHd6jQ8F1eEMXvriK
   M5i7+QIg+EGqnpJhYNkOGkX+qUyTtnvFHAUhsTkyprwLfwK1lLdUI+acN
   Uzz+k47olkDdV48yhK3F4OXux+UffhfkBCOQpGmLDHiHyNF/S9PCFSffJ
   cLllYmTZDoIkbqiCe8zvQ1TrkWhy0N84WRtbUr0+o3EEJRslZqiT/lQCz
   RjMQK34jJ1n99jgOhX5Hb7GZ3uMBFkYdw0PVoQVJwPw60VXyXlO4igNqk
   7e41XFkRaa5NGBeuFhbnXDehRMlOYsD7sOOBZpqtRgRV6FpVW488aitMg
   w==;
X-CSE-ConnectionGUID: 4LlLnd/ITcCkh/MwArtdEg==
X-CSE-MsgGUID: z0TTpMd/TeiSFiOTcocWzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30798418"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="30798418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:28:44 -0700
X-CSE-ConnectionGUID: 0UWqluEYSc6AIJUsE5rrmg==
X-CSE-MsgGUID: 4q8DWr3YR9u5Cc6l/nkC3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58603633"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.40]) ([10.245.246.40])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:28:41 -0700
Message-ID: <048122b2-f4cc-4cfa-a766-6fcfb05f840a@linux.intel.com>
Date: Tue, 30 Jul 2024 11:28:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <22b20ad7-8a25-4cb2-a24e-d6841b219977@linaro.org>
 <dc66cd0d-6807-4613-89a8-296ce5dd2daf@linaro.org>
 <62280458-3e74-43b0-b9a1-84df09abd30e@linux.intel.com>
 <7171817f-e8c6-4828-8423-0929644ff2df@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7171817f-e8c6-4828-8423-0929644ff2df@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 11:19, Krzysztof Kozlowski wrote:
> On 30/07/2024 10:59, Pierre-Louis Bossart wrote:
>>>>>
>>>>> 	/* Read dpn properties for source port(s) */
>>>>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>>>>> 			   prop->source_ports, "source");
>>>>>
>>>>> IOW, this is a valid change, but it's an optimization, not a fix in the
>>>>> usual sense of 'kernel oops otherwise'.
>>>>>
>>>>> Am I missing something?
>>>>>
>>>>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>>>>> different properties, BIT(0) cannot be set for either of the sink/source
>>>>> port bitmask.
>>>>
>>>> I think we speak about two different things. port num > 1, that's
>>>> correct. But index for src_dpn_prop array is something different. Look
>>>> at mipi-disco sdw_slave_read_dpn():
>>>>
>>>> 173         u32 bit, i = 0;
>>>> ...
>>>> 178         addr = ports;
>>>> 179         /* valid ports are 1 to 14 so apply mask */
>>>> 180         addr &= GENMASK(14, 1);
>>>> 181
>>>> 182         for_each_set_bit(bit, &addr, 32) {
>>>> ...
>>>> 186                 dpn[i].num = bit;
>>>>
>>>>
>>>> so dpn[0..i] = 1..n
>>>> where i is also the bit in the mask.
>>
>> yes, agreed on the indexing.
>>
>> But are we in agreement that the case of non-contiguous ports would not
>> create any issues? the existing code is not efficient but it wouldn't
>> crash, would it?
>>
>> There are multiple cases of non-contiguous ports, I am not aware of any
>> issues...
>>
>> rt700-sdw.c:    prop->source_ports = 0x14; /* BITMAP: 00010100 */
>> rt711-sdca-sdw.c:       prop->source_ports = 0x14; /* BITMAP: 00010100
>> rt712-sdca-sdw.c:       prop->source_ports = BIT(8) | BIT(4);
>> rt715-sdca-sdw.c:       prop->source_ports = 0x50;/* BITMAP: 01010000 */
>> rt722-sdca-sdw.c:       prop->source_ports = BIT(6) | BIT(2); /* BITMAP:
>> 01000100 */
>>
>> same for sinks:
>>
>> rt712-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
>> 00001010 */
>> rt722-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
>> 00001010 */
> 
> All these work because they have separate source and sink dpn_prop
> arrays. Separate arrays, separate number of ports, separate masks - all
> this is good. Now going to my code...
> 
>>
>>>> Similar implementation was done in Qualcomm wsa and wcd codecs like:
>>>> array indexed from 0:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n51
>>>>
>>>> genmask from 0, with a mistake:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n1255
>>>>
>>>> The mistake I corrected here:
>>>> https://lore.kernel.org/all/20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org/
>>>>
>>>> To summarize, the mask does not denote port numbers (1...14) but indices
>>>> of the dpn array which are from 0..whatever (usually -1 from port number).
>>>>
>>>
>>> Let me also complete this with a real life example of my work in
>>> progress. I want to use same dpn_prop array for sink and source ports
>>> and use different masks. The code in progress is:
>>>
>>> https://git.codelinaro.org/krzysztof.kozlowski/linux/-/commit/ef709a0e8ab2498751305367e945df18d7a05c78#6f965d7b74e712a5cfcbc1cca407b85443a66bac_2147_2157
>>>
>>> Without this patch, I get -EINVAL from sdw_get_slave_dpn_prop():
>>>   soundwire sdw-master-1-0: Program transport params failed: -2
>>
>> Not following, sorry. The sink and source masks are separate on purpose,
>> to allow for bi-directional ports. The SoundWire spec allows a port to
>> be configured at run-time either as source or sink. In practice I've
>> never seen this happen, all existing hardware relies on ports where the
>> direction is hard-coded/fixed, but still we want to follow the spec.
> 
> The ports are indeed hard-coded/fixed.
> 
>>
>> So if ports can be either source or sink, I am not sure how the
>> properties could be shared with a single array?
> 
> Because I could, just easier to code. :) Are you saying the code is not
> correct? If I understand the concept of source/sink dpn port mask, it
> should be correct. I have some array with source and sink ports. I pass
> it to Soundwire with a mask saying which ports are source and which are
> sink.
> 
>>
>> Those two lines aren't clear to me at all:
>>
>> 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
>> 	pdev->prop.src_dpn_prop = wsa884x_sink_dpn_prop;
> 
> I could do: s/wsa884x_sink_dpn_prop/wsa884x_dpn_prop/ and expect the
> code to be correct.

Ah I think I see what you are trying to do, you have a single dpn_prop
array but each entry is valid for either sink or source depending on the
sink / source_mask which don't overlap.

Did I get this right?


