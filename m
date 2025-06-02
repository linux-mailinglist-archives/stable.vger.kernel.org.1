Return-Path: <stable+bounces-148951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C5ACAE80
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4BB189F334
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109C1CD208;
	Mon,  2 Jun 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivnGhoHI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDF2D7BF
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869531; cv=none; b=PMRKDw3LBtCwbubskZ96/6atsFoRuybIPdWvSxnwfwgg97wJjW9fRKb3QEPdvRD26O+cSTm/qeik+hI3ms+Xn9mgiAUdiOYXkmG6Sa0CCKyxv8/wwDdA3TBXfDoohM0/JAdNP9LQwgVvvROF7DkEF953qn+YOWPksxb/adSx9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869531; c=relaxed/simple;
	bh=H568FxVEZlGiJFy0RPATsOPZ24o2IPx/SM2md2PJdwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stWEXba0IHWDT2ZWiujLC9ki83QoqF6blhmOuDCfduR3YWR/cyLCz3RR64tBR7aM9x02Z93TtJGLaiqk9NfFvZ8ka5HDb5CzpahIqG6raSPZF2xsVoCi9PhPRffCAAhF9Qe4wJxFjk0HP5a1GLm3NEhwPgdVuFo0h9iukWP7rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivnGhoHI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748869530; x=1780405530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H568FxVEZlGiJFy0RPATsOPZ24o2IPx/SM2md2PJdwE=;
  b=ivnGhoHIfDyD2SKUD3cPhrSpd1/owm1cASzT6MBNlDrjmlFXo2cdedZM
   +DuhJsVR/ZpohuIhymO9NN+UZPT9zCyE122VU5ZZgqS+TiPdpaLUqEGWy
   oTa/oiVNA+kRbEfjYAks8kqgtfy6XDH/e3mtJ5cyyK5GugRJrKayoxH7A
   NC6i5FFSXtKda7cvrRR2GVkOnvICOq+XtjGN306VMeigNJ/qxU2gePT2/
   4gF6Hd1ua2YzakFf053tGd1b6274nJDLXgH9oksCIraQqVTdCHtx6sjgr
   LHwgVvN0PRbaecp1G+iko6mM6dEOvchzhQSRpNUJcOX82L6n70uF8QTKu
   g==;
X-CSE-ConnectionGUID: VwXWGxWuSBmAk23O2EE7Ug==
X-CSE-MsgGUID: OmkgErEOQ0mHp3jsS71mrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="73406304"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="73406304"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 06:05:30 -0700
X-CSE-ConnectionGUID: /S1V5dB2QcqIypvX5THjaQ==
X-CSE-MsgGUID: P2XEzj+5QvuWVxgOvbqzkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="149309252"
Received: from vmusin-mobl1.ger.corp.intel.com (HELO [10.245.112.120]) ([10.245.112.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 06:05:28 -0700
Message-ID: <861208c3-3505-4386-848f-a7c7a9508604@linux.intel.com>
Date: Mon, 2 Jun 2025 15:05:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Trigger device recovery on engine
 reset/resume failure
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, Karol Wachowski <karol.wachowski@intel.com>,
 stable@vger.kernel.org
References: <20250528154253.500556-1-jacek.lawrynowicz@linux.intel.com>
 <5b8763f2-3c1c-3621-912f-995af0076d91@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <5b8763f2-3c1c-3621-912f-995af0076d91@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/28/2025 7:53 PM, Lizhi Hou wrote:
> 
> On 5/28/25 08:42, Jacek Lawrynowicz wrote:
>> From: Karol Wachowski <karol.wachowski@intel.com>
>>
>> Trigger full device recovery when the driver fails to restore device state
>> via engine reset and resume operations. This is necessary because, even if
>> submissions from a faulty context are blocked, the NPU may still process
>> previously submitted faulty jobs if the engine reset fails to abort them.
>> Such jobs can continue to generate faults and occupy device resources.
>> When engine reset is ineffective, the only way to recover is to perform
>> a full device recovery.
>>
>> Fixes: dad945c27a42 ("accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW")
>> Cc: <stable@vger.kernel.org> # v6.15+
>> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_job.c     | 6 ++++--
>>   drivers/accel/ivpu/ivpu_jsm_msg.c | 9 +++++++--
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
>> index 1c8e283ad9854..fae8351aa3309 100644
>> --- a/drivers/accel/ivpu/ivpu_job.c
>> +++ b/drivers/accel/ivpu/ivpu_job.c
>> @@ -986,7 +986,8 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
>>           return;
>>         if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
>> -        ivpu_jsm_reset_engine(vdev, 0);
>> +        if (ivpu_jsm_reset_engine(vdev, 0))
>> +            return;
> 
> Is it possible the context aborting is entered again before the full device recovery work is executed?

This is a good point but ivpu_context_abort_work_fn() is triggered by an IRQ and the first thing we do when triggering recovery is disabling IRQs.
The recovery work also flushes context_abort_work before staring to tear down everything, so we should be safe.

Regards,
Jacek


