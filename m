Return-Path: <stable+bounces-56294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23E91ECC3
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1862D1C219F7
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080938F4E;
	Tue,  2 Jul 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1vl7NjM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594564D;
	Tue,  2 Jul 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719884427; cv=none; b=dP2hdsU2JCWtKk9VI/2TXvwvJ5Q602K+uza+OUQeQtYvYEetm0JdG75uJ44hFeZzPRv0imXguIEncWpf5eji4ZUk9Zkx4jFBdWDMQedQPHVW327O2bZBWqZRfwns58NFswwi3ogDUvdI4+59EAFYfgH+Tl86hNZfvQUURpIo4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719884427; c=relaxed/simple;
	bh=3rWIcEBuDquwT65mdmMptUDstbXhoHxLkzl2I+eVtbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fz8zw04wVslWdbcSudZz7JUVWx13/nzb6fH/dDN0i/8RH9oEwymdoOuG7hHiO/myRz140VQL9NkqClYPEOqPMdvTt3J+7Z4No6YvRgJCIgmjKcz8uXOzJHwZr7ixuDeQQMmdIffvPigbWdrn2lacYVVEaEQhGJZa1SV6x4CMEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1vl7NjM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719884426; x=1751420426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3rWIcEBuDquwT65mdmMptUDstbXhoHxLkzl2I+eVtbE=;
  b=i1vl7NjMTN28RiBHaD/0R+0YjdHLcx2f+gntf2nd3znrlj1TOxw7KZiA
   RhP9KBOIhhQbLkP/lPPgu3shhpcQWhExEEjq9+ZoeL/zTqSTbXuhDbAHN
   YvXEYUgiyQp4cVQblDs4pIHemKLDC6w6Z4Y1q0amoN+0++IINs6JMKN/A
   B7hRqxHhWvWHfiUjLmqLneRE7CGUFOgcJtBb1vuiUUabjFbhfPgcY6j4w
   WkIE5IxBUy4PMs6NFMM0vbXJUXAgFAQGe+6594Ygl1NB+butuudcQ/y0a
   +MR0DcBxDJU4s+ilqa5yE5hRpoKVrgDKUCzPrsMIAlvgTtud3qN3kYV1U
   Q==;
X-CSE-ConnectionGUID: 9wroL5s2S2O146ABOk1n1Q==
X-CSE-MsgGUID: 4rb+p1atRreB6mF6McSPjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28170611"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="28170611"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 18:40:25 -0700
X-CSE-ConnectionGUID: bZfVIyY8QFmgdJ7w841ySA==
X-CSE-MsgGUID: KN3DL8ezQbWFQVfa63X4LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="50168557"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.161]) ([10.247.38.161])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 18:40:21 -0700
Message-ID: <d14d14ec-2d86-46f4-9a70-6a1cd3b016c5@linux.intel.com>
Date: Tue, 2 Jul 2024 09:40:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix packet still tx
 after gate close by reducing i226 MAC retry buffer
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>
 <e981261e-77be-407b-b601-f7214a4f57dd@molgen.mpg.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <e981261e-77be-407b-b601-f7214a4f57dd@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

Thanks for reviewing.

On 1/7/2024 8:42 pm, Paul Menzel wrote:
> Dear Faizal,
> 
> 
> Thank you for your patch.
> 
> Am 01.07.24 um 12:00 schrieb Faizal Rahim:
>> AVNU testing uncovered that even when the taprio gate is closed,
>> some packets still transmit.
> 
> What is AVNU? *some* would fit on the line above.

AVNU stands for "Avnu Alliance." AVNU (Audio Video Bridging Network 
Alliance) is an industry consortium that promotes and certifies 
interoperability of devices implementing IEEE 802.1 standards for 
time-sensitive applications.

This AVNU test refers to AVNU certification test plan.
Should I add this information in the commit ?

>> A known i225/6 hardware errata states traffic might overflow the planned
> 
> Do you have an idea for that errata? Please document it. (I see you added 
> it at the end. Maybe use [1] notation for referencing it.)

Sure.

>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> As you Cc’ed stable@vger.kernel.org, add a Fixes: tag?

Accidentally CC'ed stable@vger.kernel.org.
Since it's a hardware bug, not software, probably Fixes: tag not needed ?
Not sure which Fixes: commit to point to hmm.

I'll remove stable kernel email and omit Fixes: tag, is that okay?

>>   /* Returns the TSN specific registers to their default values after
>>    * the adapter is reset.
>>    */
>> @@ -91,6 +100,9 @@ static int igc_tsn_disable_offload(struct igc_adapter 
>> *adapter)
>>       wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
>>       wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
>> +    if (igc_is_device_id_i226(hw))
>> +        igc_tsn_restore_retx_default(adapter);
>> +
>>       tqavctrl = rd32(IGC_TQAVCTRL);
>>       tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
>>                 IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
>> @@ -111,6 +123,25 @@ static int igc_tsn_disable_offload(struct 
>> igc_adapter *adapter)
>>       return 0;
>>   }
>> +/* To partially fix i226 HW errata, reduce MAC internal buffering from 
>> 192 Bytes
>> + * to 88 Bytes by setting RETX_CTL register using the recommendation from:
>> + * a) Ethernet Controller I225/I22 Specification Update Rev 2.1
>> + *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
>> + * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
>> + */
>> +static void igc_tsn_set_retx_qbvfullth(struct igc_adapter *adapter)
> 
> It’d put threshold in the name.

My earlier thought is that it is easier to look for the keyword "qbvfullth" 
in the i226 SW User Manual where you'll get a hit that brings you directly 
to that register. "qbvfullthreshold" would not.
There are some comments in the new code that links 'th' to 'threshold' for 
the reader.

But I'm okay to change it to "qbvfullthreshold".
Thoughts?

Regards,
Faizal

