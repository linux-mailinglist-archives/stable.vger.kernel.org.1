Return-Path: <stable+bounces-139162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC6AA4BF8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFB816FC3A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E325DB1F;
	Wed, 30 Apr 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J06ZQ/+O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BD25B1DC;
	Wed, 30 Apr 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017416; cv=none; b=oEncrd5Wvc8vTXL+RTvukWyrWRl2ENt1WtWabEos/vj/HFlQAhBwUzrHGB45VHXzCKgZ0J887mwN0ah5f+GkunyO0bX6/gkEsicS+i4jPXIQYXk+YKgFkylcD1k4YLe7QniIkFjh0mnFXe2VA9a/Riu8NZODjvVkyBWMxQVsk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017416; c=relaxed/simple;
	bh=XLiifVM8tpVTt3sDeWqv3GzIqnKiNXazkFeieaXDH44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G12NT/Egsu9TRdlBxrqdmYEWDFi3OGJV2yqjyDZL3cXeMlxGBK4VtFlHYpM3u6m/EH0VOw2cBtvp1P/8gKz3VGwglNQoCsD3sGzY8Kdhk3sOehpK7e6QZ5fOb6g9YTcTdSsz6ZlOZxY4/ysT7Sj6TrazptJ/6401KRpXwYw7KzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J06ZQ/+O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017415; x=1777553415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XLiifVM8tpVTt3sDeWqv3GzIqnKiNXazkFeieaXDH44=;
  b=J06ZQ/+OkELXekMwbdKAGr4qDj83wSrCLOSQtvSCtx4aQnhzG9lGcJIG
   W2F7PjTUDxRhUKFMrDF6hrtsrvyeIvyGvjd9ZrNac+6aG3vAua9CxUCBt
   UmuQJ6pq/3xBN8yJMsf6lHPlmyjYOuyjzuSGtcPG3AW2IJC9Bo0PJ+ep1
   wgwO3qjzfu1cVlCvJA2Hk2171hsFGOpZNVYVtbgfG7z0P0Ddf8N2RAB+G
   v+JD1c9MBhWkqQmYu3lvZjiAFckeqK0zdRk72b6wjdBNiNY1R1/aCIqzC
   iyJk7QGrtP+D0zCvUASYVEfPABRpyCgsAdy0HuSFU5VcYlWWGpTgJOfDQ
   g==;
X-CSE-ConnectionGUID: kzh6fLEKTi+gOB7kyzVwWA==
X-CSE-MsgGUID: CvAuLkdgQzCalCKCf2gK5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="50330375"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="50330375"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:50:14 -0700
X-CSE-ConnectionGUID: HDQKG5NPREqULlEawMa65w==
X-CSE-MsgGUID: zMQhSXbnT7Kgp2fugu745Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135091569"
Received: from dmatouse-mobl1.ger.corp.intel.com (HELO [10.245.252.148]) ([10.245.252.148])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:50:12 -0700
Message-ID: <08f09dbb-5507-4f38-acea-d76c2c7a1764@linux.intel.com>
Date: Wed, 30 Apr 2025 14:50:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Karol Wachowski <karol.wachowski@intel.com>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
 <2025042227-crumb-rubble-7854@gregkh>
 <80f49ba8-caea-47d5-be38-dd1eefd09988@linux.intel.com>
 <2025042449-capitol-neuron-b6fe@gregkh>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2025042449-capitol-neuron-b6fe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/24/2025 12:34 PM, Greg KH wrote:
> On Thu, Apr 24, 2025 at 12:22:31PM +0200, Jacek Lawrynowicz wrote:
>> Hi,
>>
>> On 4/22/2025 2:17 PM, Greg KH wrote:
>>> On Tue, Apr 08, 2025 at 11:57:11AM +0200, Jacek Lawrynowicz wrote:
>>>> From: Karol Wachowski <karol.wachowski@intel.com>
>>>>
>>>> commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
>>>>
>>>> Trigger recovery of the NPU upon receiving HW context violation from
>>>> the firmware. The context violation error is a fatal error that prevents
>>>> any subsequent jobs from being executed. Without this fix it is
>>>> necessary to reload the driver to restore the NPU operational state.
>>>>
>>>> This is simplified version of upstream commit as the full implementation
>>>> would require all engine reset/resume logic to be backported.
>>>
>>> We REALLY do not like taking patches that are not upstream.  Why not
>>> backport all of the needed patches instead, how many would that be?
>>> Taking one-off patches like this just makes it harder/impossible to
>>> maintain the code over time as further fixes in this same area will NOT
>>> apply properly at all.
>>>
>>> Think about what you want to be touching 5 years from now, a one-off
>>> change that doesn't match the rest of the kernel tree, or something that
>>> is the same?
>>
>> Sure, I'm totally on board with backporting all required patches.
>> I thought it was not possible due to 100 line limit.
>>
>> This would be the minimum set of patches:
>>
>> Patch 1:
>>  drivers/accel/ivpu/ivpu_drv.c   | 32 +++-----------
>>  drivers/accel/ivpu/ivpu_drv.h   |  2 +
>>  drivers/accel/ivpu/ivpu_job.c   | 78 ++++++++++++++++++++++++++-------
>>  drivers/accel/ivpu/ivpu_job.h   |  1 +
>>  drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
>>  drivers/accel/ivpu/ivpu_sysfs.c |  5 ++-
>>  6 files changed, 75 insertions(+), 46 deletions(-)
>>
>> Patch 2:
>>  drivers/accel/ivpu/ivpu_job.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> Patch 3:
>>  drivers/accel/ivpu/ivpu_job.c     |   2 +-
>>  drivers/accel/ivpu/ivpu_jsm_msg.c |   3 +-
>>  drivers/accel/ivpu/vpu_boot_api.h |  45 +++--
>>  drivers/accel/ivpu/vpu_jsm_api.h  | 303 +++++++++++++++++++++++++-----
>>  4 files changed, 293 insertions(+), 60 deletions(-)
>>
>> Patch 4:
>>  drivers/accel/ivpu/ivpu_job.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> First patch needs some changes to apply correctly to 6.12 but the rest of them apply pretty cleanly.
>> Is this acceptable?
> 
> Totally acceptable, that's trivial compared to many of the larger
> backports we have taken over the years :)

OK, I've sent two separate patchses for 6.12 and 6.14 that contain minimal number of patches.
I've rebased only two patches in each patchsets and the rest is as-is from upstream.
Let me know in case I messed something up.

Regards,
Jacek



