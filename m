Return-Path: <stable+bounces-208329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA204D1D0B5
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE68300A3C2
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750734D90C;
	Wed, 14 Jan 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/ZhogS/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D892F693D;
	Wed, 14 Jan 2026 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378571; cv=none; b=LKX5Ut3DMeGXIeT/00U3MCmBhfXr+gMPBM8H5wrkmR8uTyBQpdg/feBIHXDlL11NpSor1HreC7LwJQ6gQAqCG6feJH/2lCCORNQ5y0zQmgZBOet2MccZt6z5XQbXIkCRvg4N7XnF7nNrNoS3yYXrV5dl2wLMtQlz3e8glxcj2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378571; c=relaxed/simple;
	bh=Tk40Z3bVifct2EirVXFgyYO4QzE6BJo2N8YtpP43AC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYjuSULoduP1ggjBmSns1qM3wuNJ3Ae1TmxtneavO6+lq54i+MUhpFmMzZsGTcozslIGyKA3p0Qmu6HcpBhuXLivRm2IKrxFj1y/xVwHm8gAY5PXXtDpXwWhZZp5sU/hus2OYjOzUOQL6sEdJ1jElfDcNzE+AtXPDYFKZrLxjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/ZhogS/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768378567; x=1799914567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tk40Z3bVifct2EirVXFgyYO4QzE6BJo2N8YtpP43AC0=;
  b=a/ZhogS/Xw03OPjQm0HDdHHez9uqrI+Nfn2S0Sgh30vF2iCUsh/bTjJo
   wLEA8542vZXisjzafep8MjmxlprdS2XvBn+tqhP9QewE/meLWtANTKQZf
   7VteSDHGcRVG4iS4a0xm0hn4salZ59bZzpwrWEWLkVAkmxIW1Zl2IOgvQ
   U0IabhGRiUpOcfVmhoRaknIr1mET60z4aLC6O0aAJlNygoV5Ch2IdUSZe
   QIhNo/7SmYpP6IkNSMl79ox3nIRIzvbG/iLu9hGAM+aII5gQCzvIRPc9g
   LpHcr8Qo7HAdnAefoWjgkMB6H5EinObz/AI1S0SJAUKgWeLcPQvaJrCWR
   g==;
X-CSE-ConnectionGUID: 6OowTB87TSeS7/wP83IfQg==
X-CSE-MsgGUID: QLXcZpYVSDqiraR/d9XJCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="57228006"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="57228006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:16:04 -0800
X-CSE-ConnectionGUID: HdljNTGlSnmU4yQpS8iDuw==
X-CSE-MsgGUID: aQ92HTXqTE2w3EbiZCrUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204506952"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.91]) ([172.28.180.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:16:02 -0800
Message-ID: <954dc352-2ad2-4950-9c8b-55ebafc5841c@linux.intel.com>
Date: Wed, 14 Jan 2026 09:15:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry
 mechanism for indirect AQ
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
 <f0fee9dd-7236-464d-9e06-6adbeece81a8@molgen.mpg.de>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <f0fee9dd-7236-464d-9e06-6adbeece81a8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Paul,

On 2026-01-13 11:31 PM, Paul Menzel wrote:
> [Cc: +Michal]
> 
> Dear Dawid, dear Jakub,
> 

...

> Am 13.01.26 um 20:38 schrieb Dawid Osuchowski:
>> Ccing Michal, given they are the author of the "reverted" commit.
> 
> At least Michal was not in the (visible) Cc: list

Interesting. I was using 'git send-email' without any suppression of Cc 
or similar options. In the direct email sent from me Michal is in Cc, 
seems the mailing list for some reason stripped him...

>>   drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>

...

>>       do {
>>           status = ice_sq_send_cmd(hw, cq, desc, buf, buf_size, cd);
>>           if (!is_cmd_for_retry || !status ||
>>               hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
>>               break;
>> +        if (buf_cpy)
>> +            memcpy(buf, buf_cpy, buf_size);
>>           memcpy(desc, &desc_cpy, sizeof(desc_cpy));
>> -
> 
> Unrelated change?
> 

During internal review it was pointed out that this function contains a 
lot of empty lines, this was my feeble attempt to at least partially 
reduce their count.

>>           msleep(ICE_SQ_SEND_DELAY_TIME_MS);
>>       } while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
>> +    kfree(buf_cpy);
>>       return status;
>>   }
> 
> The diff looks good otherwise.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

Thanks,
Dawid

