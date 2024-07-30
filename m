Return-Path: <stable+bounces-62657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA6940CAE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A2F283798
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300119306B;
	Tue, 30 Jul 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5VVoylI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C746193066;
	Tue, 30 Jul 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329990; cv=none; b=o1DBHBCcmhdniSL4jY/qiQayT1Q8wh3XzWT1I5fsB4uA4/FfCA+aHLGClYcNp1Sl0rtNBSOaNC4rD+hZBCx1dB/tqvr1OnotQqe4RFC45/6cdyMOKgvpc5H5rODo1/eqZuqGHlVjvfjfWcfyYpQK3VL/CUJ/qtetEp/8Gxzu2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329990; c=relaxed/simple;
	bh=UoLFiRXLnSzQFz3vQxHApNbca+UPgWp52jw1xG/qCOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVofBhpmntIm4HuPPBmnibvmyZ8yLAXidYpSV+IMqLhxJU5FSSd7vETQwK3DuMDwSSBzt/p115Hx5ojrY4kXG5cy5hu/9v3TRvxAfwjg0EIJumn6a67XoFis9R/QSvcLeRZM0c0OTFUdmoJg2RcNxfGxhyVP8uvXOZTKUe3LMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5VVoylI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722329990; x=1753865990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UoLFiRXLnSzQFz3vQxHApNbca+UPgWp52jw1xG/qCOc=;
  b=M5VVoylIvvkcXRr2bR2UGgflFrazbBtc8TL5O6T0LYopmrrvNfslXVJO
   4bDzW0+nqpBaHO37SGASjOxtcgMShIR6Hta5Uklrxh5bzCljkQkw6EYi+
   19/SGGnGvIRnWTmEcvOC9gXNQ+EfbJlMYWsWIkLfUbSb1FgctY5Sa3flT
   U+2pRN/6U/WyRvbzRDC0wAjK3iKDVJ+K5FEigvZnfKkN5qspK9QwSp9ZX
   oa96NE+G7qx69XYoUOjbgY4Oqa6kw+Xvtbwjob2VzQR7ORAsQqKanFLSJ
   /q1y62uSVrnD2VztTCbHE8n7wwiUPaF2FCTT/sJpusX8u7Y4acAP5Qkln
   w==;
X-CSE-ConnectionGUID: q9XmkROgSQCo6/GOhHskWA==
X-CSE-MsgGUID: mncge4JvQN6oEc1c1CLYeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23893704"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23893704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:59:49 -0700
X-CSE-ConnectionGUID: 53BEnqcuT4uuBZiTGV0yGg==
X-CSE-MsgGUID: SxIeXmWdSMSPNv+Hi2iRcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58407084"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.40]) ([10.245.246.40])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:59:45 -0700
Message-ID: <62280458-3e74-43b0-b9a1-84df09abd30e@linux.intel.com>
Date: Tue, 30 Jul 2024 10:59:42 +0200
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <dc66cd0d-6807-4613-89a8-296ce5dd2daf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 10:39, Krzysztof Kozlowski wrote:
> On 30/07/2024 10:23, Krzysztof Kozlowski wrote:
>> On 29/07/2024 16:25, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 7/29/24 16:01, Krzysztof Kozlowski wrote:
>>>> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
>>>> 'sink_ports' - define which ports to program in
>>>> sdw_program_slave_port_params().  The masks are used to get the
>>>> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
>>>> an array.
>>>>
>>>> Bitmasks can be non-continuous or can start from index different than 0,
>>>> thus when looking for matching port property for given port, we must
>>>> iterate over mask bits, not from 0 up to number of ports.
>>>>
>>>> This fixes allocation and programming slave ports, when a source or sink
>>>> masks start from further index.
>>>>
>>>> Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> This is a valid change to optimize how the port are accessed.
>>>
>>> But the commit message is not completely clear, the allocation in
>>> mipi_disco.c is not modified and I don't think there's anything that
>>> would crash. If there are non-contiguous ports, we will still allocate
>>> space that will not be initialized/used.
>>>
>>> 	/* Allocate memory for set bits in port lists */
>>> 	nval = hweight32(prop->source_ports);
>>> 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>>> 					  sizeof(*prop->src_dpn_prop),
>>> 					  GFP_KERNEL);
>>> 	if (!prop->src_dpn_prop)
>>> 		return -ENOMEM;
>>>
>>> 	/* Read dpn properties for source port(s) */
>>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>>> 			   prop->source_ports, "source");
>>>
>>> IOW, this is a valid change, but it's an optimization, not a fix in the
>>> usual sense of 'kernel oops otherwise'.
>>>
>>> Am I missing something?
>>>
>>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>>> different properties, BIT(0) cannot be set for either of the sink/source
>>> port bitmask.
>>
>> I think we speak about two different things. port num > 1, that's
>> correct. But index for src_dpn_prop array is something different. Look
>> at mipi-disco sdw_slave_read_dpn():
>>
>> 173         u32 bit, i = 0;
>> ...
>> 178         addr = ports;
>> 179         /* valid ports are 1 to 14 so apply mask */
>> 180         addr &= GENMASK(14, 1);
>> 181
>> 182         for_each_set_bit(bit, &addr, 32) {
>> ...
>> 186                 dpn[i].num = bit;
>>
>>
>> so dpn[0..i] = 1..n
>> where i is also the bit in the mask.

yes, agreed on the indexing.

But are we in agreement that the case of non-contiguous ports would not
create any issues? the existing code is not efficient but it wouldn't
crash, would it?

There are multiple cases of non-contiguous ports, I am not aware of any
issues...

rt700-sdw.c:    prop->source_ports = 0x14; /* BITMAP: 00010100 */
rt711-sdca-sdw.c:       prop->source_ports = 0x14; /* BITMAP: 00010100
rt712-sdca-sdw.c:       prop->source_ports = BIT(8) | BIT(4);
rt715-sdca-sdw.c:       prop->source_ports = 0x50;/* BITMAP: 01010000 */
rt722-sdca-sdw.c:       prop->source_ports = BIT(6) | BIT(2); /* BITMAP:
01000100 */

same for sinks:

rt712-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
00001010 */
rt722-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
00001010 */

>> Similar implementation was done in Qualcomm wsa and wcd codecs like:
>> array indexed from 0:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n51
>>
>> genmask from 0, with a mistake:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n1255
>>
>> The mistake I corrected here:
>> https://lore.kernel.org/all/20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org/
>>
>> To summarize, the mask does not denote port numbers (1...14) but indices
>> of the dpn array which are from 0..whatever (usually -1 from port number).
>>
> 
> Let me also complete this with a real life example of my work in
> progress. I want to use same dpn_prop array for sink and source ports
> and use different masks. The code in progress is:
> 
> https://git.codelinaro.org/krzysztof.kozlowski/linux/-/commit/ef709a0e8ab2498751305367e945df18d7a05c78#6f965d7b74e712a5cfcbc1cca407b85443a66bac_2147_2157
> 
> Without this patch, I get -EINVAL from sdw_get_slave_dpn_prop():
>   soundwire sdw-master-1-0: Program transport params failed: -2

Not following, sorry. The sink and source masks are separate on purpose,
to allow for bi-directional ports. The SoundWire spec allows a port to
be configured at run-time either as source or sink. In practice I've
never seen this happen, all existing hardware relies on ports where the
direction is hard-coded/fixed, but still we want to follow the spec.

So if ports can be either source or sink, I am not sure how the
properties could be shared with a single array?

Those two lines aren't clear to me at all:

	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
	pdev->prop.src_dpn_prop = wsa884x_sink_dpn_prop;


