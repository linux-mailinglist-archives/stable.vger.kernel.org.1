Return-Path: <stable+bounces-87578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F89A6C2D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D940E281E93
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805191D7E5B;
	Mon, 21 Oct 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfjCk4bU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196581D1E88;
	Mon, 21 Oct 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521225; cv=none; b=WEqj1yBDl8XXmb63PizxF2lAAWd/lttLiAB6d6WWl35xvQVWp95HQ5B2RmP/DspLS6xUTBjZHoNgRMeFYLlhUqsoJdTgDy6IikQ8m9egEU90KDVVvHZV1qBO0nfv1cwIXamlbm1WescTeqLNMPX6Hag/+5L4CMvCNzSnQ5nEqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521225; c=relaxed/simple;
	bh=VKVb6R/kxF3VgL968A4q+prGm/RC2EwQ5vjr4iY9xC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bc8ZBHAD523F+rqBsCt+7rlzOA3X/7k2LCKnMuXfN9xQp+exgDMsHcGVsWtGt6lRTDuJdBNKoZEEH8fxY+0zov2NaL2cd2UYElZKBs0pE9wHJKoIPRZzekbTil67F2FbioMRtmp0x/+J7iB4jwY0ffs+8sMMhuArGcgma0Pnqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfjCk4bU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729521223; x=1761057223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKVb6R/kxF3VgL968A4q+prGm/RC2EwQ5vjr4iY9xC4=;
  b=SfjCk4bU7uFBa4x78CcsmF7cgQoa1AEbrhpYJQyerQ2gQ0ygMg3Ip/9h
   jX82E8QTojGwj1LUXmJe/cTH6YVkfdEHJBq/CMXM+NB81BgClQRwAgq2I
   pu0eK9eTopNI5aDfJpzP+kkPoLtmSV33lVPEJArqakgDaNAqq+4Wez5M4
   vvmY8s+2RxXFbhdTGhs+s5ZQXREx5aUtsFsygelN9GNUeF3u2RmSMxRVB
   xGTaYeRjlhMog4eyXuhF66a21MYxsRjtw0JnwxGhX/jZoaWJ8i9dg83Ad
   LOp0+sDv8ajeGhBCYWS5TkflwQdgzWf6NJWy5/TAarGDEQfrwLbocqJFA
   g==;
X-CSE-ConnectionGUID: yFn4aBt0T+abDJMrwrOtoQ==
X-CSE-MsgGUID: 43uVvfVKSSW+92wCefqKsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28782569"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28782569"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:33:42 -0700
X-CSE-ConnectionGUID: XAWovZcGTK+oBrjKFZd4cQ==
X-CSE-MsgGUID: cGE54+BSRK69QGfqcwRoWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79181496"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:33:41 -0700
Message-ID: <0ead8466-a068-4e1f-93aa-47dc269b5b62@intel.com>
Date: Mon, 21 Oct 2024 17:33:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241018052901.446638-1-avri.altman@wdc.com>
 <59f6c217-d84e-4626-9265-ce5cd8a043f4@intel.com>
 <DM6PR04MB6575EAADE9A5C775C0837361FC432@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575EAADE9A5C775C0837361FC432@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/24 15:24, Avri Altman wrote:
>>
>> On 18/10/24 08:29, Avri Altman wrote:
>>> While reviewing the SDUC series, Adrian made a comment concerning the
>>> memory allocation code in mmc_sd_num_wr_blocks() - see [1].
>>> Prevent memory allocations from triggering I/O operations while ACMD22
>>> is in progress.
>>>
>>> [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
>>>
>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Avri Altman <avri.altman@wdc.com>
>>> Cc: stable@vger.kernel.org
>>
>> Some checkpatch warnings:
>>
>>   WARNING: Use lore.kernel.org archive links when possible - see
>> https://lore.kernel.org/lists.html
>>   #12:
>>   [1] https://www.spinics.net/lists/linux-mmc/msg82199.html
> Done.
> 
>>
>>   WARNING: The commit message has 'stable@', perhaps it also needs a
>> 'Fixes:' tag?
> I tried to look for the patch that introduced mmc_sd_num_wr_blocks but couldn't find it in Ulf's tree.

Seems like the following introduced the kmalloc()

	commit 051913dada046ac948eb6f48c0717fc25de2a917
	Author: Ben Dooks <ben@simtec.co.uk>
	Date:   Mon Jun 8 23:33:57 2009 +0100

	    mmc_block: do not DMA to stack

> 
> Thanks,
> Avri
>>
>>   total: 0 errors, 2 warnings, 17 lines checked
>>
>> Otherwise:
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>>>
>>> ---
>>> Changes since v1:
>>>  - Move memalloc_noio_restore around (Adrian)
>>> ---
>>>  drivers/mmc/core/block.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>>> 04f3165cf9ae..a813fd7f39cc 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card
>> *card, u32 *written_blocks)
>>>       u32 result;
>>>       __be32 *blocks;
>>>       u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
>>> +     unsigned int noio_flag;
>>> +
>>>       struct mmc_request mrq = {};
>>>       struct mmc_command cmd = {};
>>>       struct mmc_data data = {};
>>> @@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct
>> mmc_card *card, u32 *written_blocks)
>>>       mrq.cmd = &cmd;
>>>       mrq.data = &data;
>>>
>>> +     noio_flag = memalloc_noio_save();
>>>       blocks = kmalloc(resp_sz, GFP_KERNEL);
>>> +     memalloc_noio_restore(noio_flag);
>>>       if (!blocks)
>>>               return -ENOMEM;
>>>
> 


