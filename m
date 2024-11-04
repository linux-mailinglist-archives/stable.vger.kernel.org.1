Return-Path: <stable+bounces-89606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6CB9BB043
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAEA281864
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708941ABEDC;
	Mon,  4 Nov 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHADPCSq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67411AF0A0
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713934; cv=none; b=Z5/gIwWMC3i9pOoQ4rJrIswE9/Kk0WVJn03WTEClpj/JQSd0PYz5nJkFf5EWL+3OMQ+/J8t1AcCOH7F7SZhxsbTczRRlroMWjtnBLgxfIAWU1A04zh1qPkZYUmUc3et7bdSovaeSgvJIxnimi8Sp70z76PpC0RfSx3fo3VtzPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713934; c=relaxed/simple;
	bh=5qf+0pNKlPu1st6EDIfrxCuG8kgDLuYUOKPqIwEDN8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHlwE4AqDi1DTv5OeGQ7XVdsehKu1n7hUy2+dsMZj54OJtNlpGDyHNxIgB6k+xxDRHQU6GF8xtSdMZmkCQy4lr0TBt1j6/8jr/DQDCBqyRawCs5hjyYQxEcz5WHLPBfA7Ptbr/Kgrq90fR3QdtGSWoCmTGje2NDQCtu0Zj89FBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHADPCSq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730713933; x=1762249933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5qf+0pNKlPu1st6EDIfrxCuG8kgDLuYUOKPqIwEDN8k=;
  b=QHADPCSqqx6EggGGtd4+toX+DHwBm/sVmA+O+grypyN7S0416XYc65jH
   9OpzvVex0rHDrlU/efCb/A+lqL/PVHQViq1FucD0OeolELuHMx2tGEvZi
   eB1Ur90KDWMFLVcfQZXdW+eJYjsVnUJ3iyV+u26K3wtBkSK4t8stlEfSs
   kvCwP0A5gyWOHLfYyRodfu/jLRoVcRWv+7iP8X4etDg1nntLCfV3R1OpF
   oHkUqKKE2sWC62L/yRavc9kTLnSuBKnVlPgcq2feYihHVq9UMk3ZBB5Q9
   ui+n5qu+/dWfjaMmC2O262NjRfZI7Kl+BPe83rY8U79WZPjDRZGKFUZhL
   g==;
X-CSE-ConnectionGUID: PI8nOF3iSBGHYO1+YDxeeQ==
X-CSE-MsgGUID: MK7CR/zbTH2hdPXMGORWiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52964284"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52964284"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:52:12 -0800
X-CSE-ConnectionGUID: bBofio/RT1GiMTqu9zyGig==
X-CSE-MsgGUID: GgYrB+OWQ3CtH/D9FRsYZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88177539"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.196.144]) ([10.245.196.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:52:08 -0800
Message-ID: <6a2fe619-2749-477c-ac79-4fa9ff21191c@linux.intel.com>
Date: Mon, 4 Nov 2024 10:52:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
To: John Harrison <john.c.harrison@intel.com>,
 Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <04ed3481-cc77-43c7-89f4-159ce52f3e7c@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <04ed3481-cc77-43c7-89f4-159ce52f3e7c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/1/2024 7:48 PM, John Harrison wrote:
> On 10/29/2024 05:01, Nirmoy Das wrote:
>> Move LNL scheduling WA to xe_device.h so this can be used in other
>> places without needing keep the same comment about removal of this WA
>> in the future. The WA, which flushes work or workqueues, is now wrapped
>> in macros and can be reused wherever needed.
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> cc: <stable@vger.kernel.org> # v6.11+
>> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device.h | 14 ++++++++++++++
>>   drivers/gpu/drm/xe/xe_guc_ct.c | 11 +----------
>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
>> index 4c3f0ebe78a9..f1fbfe916867 100644
>> --- a/drivers/gpu/drm/xe/xe_device.h
>> +++ b/drivers/gpu/drm/xe/xe_device.h
>> @@ -191,4 +191,18 @@ void xe_device_declare_wedged(struct xe_device *xe);
>>   struct xe_file *xe_file_get(struct xe_file *xef);
>>   void xe_file_put(struct xe_file *xef);
>>   +/*
>> + * Occasionally it is seen that the G2H worker starts running after a delay of more than
>> + * a second even after being queued and activated by the Linux workqueue subsystem. This
>> + * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
>> + * Lunarlake Hybrid CPU. Issue disappears if we disable Lunarlake atom cores from BIOS
>> + * and this is beyond xe kmd.
>> + *
>> + * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
>> + */
>> +#define LNL_FLUSH_WORKQUEUE(wq__) \
>> +    flush_workqueue(wq__)
>> +#define LNL_FLUSH_WORK(wrk__) \
>> +    flush_work(wrk__)
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>> index 1b5d8fb1033a..703b44b257a7 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>> @@ -1018,17 +1018,8 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>>         ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
>>   -    /*
>> -     * Occasionally it is seen that the G2H worker starts running after a delay of more than
>> -     * a second even after being queued and activated by the Linux workqueue subsystem. This
>> -     * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
>> -     * Lunarlake Hybrid CPU. Issue dissappears if we disable Lunarlake atom cores from BIOS
>> -     * and this is beyond xe kmd.
>> -     *
>> -     * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
>> -     */
>>       if (!ret) {
>> -        flush_work(&ct->g2h_worker);
>> +        LNL_FLUSH_WORK(&ct->g2h_worker);
>>           if (g2h_fence.done) {
>>               xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
>>                      g2h_fence.seqno, action[0]);
> This message is still wrong.

I see that this is open from the previous patch, https://patchwork.freedesktop.org/patch/620189/#comment_1128218.


Sent out a patch to improve the message.


Thanks,

Nirmoy

>
> We have a warning that says 'job completed successfully'! That is misleading. It needs to say "done after flush" or "done but flush was required" or something along those lines.
>
> John.
>
>

