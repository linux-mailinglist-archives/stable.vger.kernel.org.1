Return-Path: <stable+bounces-60393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3393378B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888AD281D9F
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7618641;
	Wed, 17 Jul 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDubJZyl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084714267;
	Wed, 17 Jul 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199736; cv=none; b=GSLHAKf7TAcK2DV5CB75OK6Vhj0dS/hFUIaIsICjOYEXc/wJ4BDEz6h76PSceFnDLvEx4QJMv+iNbHdNH9h7GZr0hpy7IUKWZBlFwlR/9xD/A8u5YAdK6ACYmsIpgH6PtJsctm0PUTxSwEp+t0Xlctp6HouxpuhC/+ynGCLy/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199736; c=relaxed/simple;
	bh=2ORkHDg/IQyH91IGyRuUQbp/VHjRmcrzMEI+fNTKUJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBz1DG/4VOpprI2/gFvL6PliG0C0/XwAtjLPtTI/8U7TjwzRp8MHhXWVj5tfdi4rPVtg7GrKCSauhwRontqFZMx6ju0h6x2NvKWgErknSoOB0WYXid2dkc1WVvuO1BFrTJqTxAMH4rNKq+OPGCyH8/h0Wy2xH++ZY/5bc6BejmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDubJZyl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721199734; x=1752735734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ORkHDg/IQyH91IGyRuUQbp/VHjRmcrzMEI+fNTKUJw=;
  b=RDubJZyltlwSnq/Q2OpZyT8SwFnVRJEeoXon0pofX4vhSAieyHPNmFPZ
   dEKqke475ZyTR5pirNGsXvfjyLhDAZNo8xzpyDz2F2nkxLIYaYbqKVhVw
   Ah66XGB0KQ5FYKTIf1BEKg1NVfW0j2dD3+E3sicSaqq1AsdAM6PkRnOpz
   HbuvBkSb5YEBq7AA9hzpFoZ666EvKl5+B4hI99uGmu+RW861dMSjurN2o
   8TUjIK4rXs9KvxCVqdkKld8rGpYaxCnlj06cn91u5ZeAIL4MDONueGnmO
   vyYf7dIus7BB4MTsZ1768QSS7XGPcyOVJkX55YbeVRE5qo9DcSAvZUHBB
   g==;
X-CSE-ConnectionGUID: iR7yCoHDR1mnJIlmGP9rug==
X-CSE-MsgGUID: guVGp99yTPWM23IXvyW8YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18530204"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="18530204"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 00:02:14 -0700
X-CSE-ConnectionGUID: rO4h8ZivQwSuMP6Vw7fHag==
X-CSE-MsgGUID: V3QDW3qFR165M/E/9SLH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="55151063"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.74.239]) ([10.247.74.239])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 00:02:09 -0700
Message-ID: <2c5a0dcf-f9b0-49da-9dea-0a276fa4a0d9@linux.intel.com>
Date: Wed, 17 Jul 2024 15:02:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/3] igc: Fix reset adapter logics when tx mode
 change
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
 <20240707125318.3425097-3-faizal.abdul.rahim@linux.intel.com>
 <87o774u807.fsf@intel.com>
 <6bb1ba4a-41ba-4bc1-9c4b-abfb27944891@linux.intel.com>
 <87le27ssu4.fsf@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <87le27ssu4.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/2024 1:10 am, Vinicius Costa Gomes wrote:
> "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com> writes:
> 
>> Hi Vinicius,
>>
>> On 11/7/2024 6:44 am, Vinicius Costa Gomes wrote:
>>> Faizal Rahim <faizal.abdul.rahim@linux.intel.com> writes:
>>>
>>>> Following the "igc: Fix TX Hang issue when QBV Gate is close" changes,
>>>> remaining issues with the reset adapter logic in igc_tsn_offload_apply()
>>>> have been observed:
>>>>
>>>> 1. The reset adapter logics for i225 and i226 differ, although they should
>>>>      be the same according to the guidelines in I225/6 HW Design Section
>>>>      7.5.2.1 on software initialization during tx mode changes.
>>>> 2. The i225 resets adapter every time, even though tx mode doesn't change.
>>>>      This occurs solely based on the condition  igc_is_device_id_i225() when
>>>>      calling schedule_work().
>>>> 3. i226 doesn't reset adapter for tsn->legacy tx mode changes. It only
>>>>      resets adapter for legacy->tsn tx mode transitions.
>>>> 4. qbv_count introduced in the patch is actually not needed; in this
>>>>      context, a non-zero value of qbv_count is used to indicate if tx mode
>>>>      was unconditionally set to tsn in igc_tsn_enable_offload(). This could
>>>>      be replaced by checking the existing register
>>>>      IGC_TQAVCTRL_TRANSMIT_MODE_TSN bit.
>>>>
>>>> This patch resolves all issues and enters schedule_work() to reset the
>>>> adapter only when changing tx mode. It also removes reliance on qbv_count.
>>>>
>>>> qbv_count field will be removed in a future patch.
>>>>
>>>> Test ran:
>>>>
>>>> 1. Verify reset adapter behaviour in i225/6:
>>>>      a) Enrol a new GCL
>>>>         Reset adapter observed (tx mode change legacy->tsn)
>>>>      b) Enrol a new GCL without deleting qdisc
>>>>         No reset adapter observed (tx mode remain tsn->tsn)
>>>>      c) Delete qdisc
>>>>         Reset adapter observed (tx mode change tsn->legacy)
>>>>
>>>> 2. Tested scenario from "igc: Fix TX Hang issue when QBV Gate is closed"
>>>>      to confirm it remains resolved.
>>>>
>>>> Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
>>>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>> ---
>>>
>>> There were a quite a few bugs, some of them my fault, on this part of
>>> the code, changing between the modes in the hardware.
>>>
>>> So I would like some confirmation that ETF offloading/LaunchTime was
>>> also tested with this change. Just to be sure.
>>>
>>> But code-wise, looks good:
>>>
>>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>>
>>>
>>> Cheers,
>>
>>
>> Tested etf with offload, looks like working correctly.
>>
>> 1. mqprio
>> tc qdisc add dev enp1s0 handle 100: parent root mqprio num_tc 3 \
>> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
>> queues 1@0 1@1 2@2 \
>> hw 0
>>
>> No reset adapter observed.
>>
>> 2. etf with offload
>> tc qdisc replace dev enp1s0 parent 100:1 etf \
>> clockid CLOCK_TAI delta 300000 offload
>>
>> Reset adapter observed (tx mode legacy -> tsn).
>>
>> 3. delete qdisc
>> tc qdisc delete dev enp1s0 parent root handle 100
>>
>> Reset adapter observed (tx mode tsn -> legacy).
>>
> 
> That no unexpected resets are happening, is good.
> 
> But what I had in mind was some functional tests that ETF is working. I
> guess that's the only way of knowing that it's still working. Sorry that
> I wasn't clear about that.
> 
> 
> Cheers,

My bad.

Just tested ETF functionality and it is working.

1. On Tx Board
a) mqprio
    tc qdisc add dev enp1s0 handle 100: parent root mqprio num_tc 3 \
    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
    queues 1@0 1@1 2@2 \
    hw 0
b) etf with offload
    tc qdisc replace dev enp1s0 parent 100:1 etf \
    clockid CLOCK_TAI delta 300000 offload
c) use UDP TAI app to send packets where tx timestamp is set to
    current_time + 1ms for each packet.

2. On Rx Board
a) Checked .pcap log. Observed that interval duration between each rx
    packet is 1ms


Thanks for your help.

