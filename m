Return-Path: <stable+bounces-126686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871DA7120A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064711897C35
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB1B17A2FD;
	Wed, 26 Mar 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhFDyktU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4019FA8D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976423; cv=none; b=VqIQ8LdHWawe7OrOExGE7CwCcqG6YvNOFi8BWTVwGYP54MUwH/t+wlC2I2u+iKOvaV8wZ+yKdox2A9mAHJ/0y14Nf9/PgnecFvC4z93sGwiFtvGl+enPOBSC69o18Ra5q80wZj946NYVc/P57Rd/7lk4UXBGa5sNCHDSk9+oywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976423; c=relaxed/simple;
	bh=1h14r4Gq72zE+uCNNVQUHEuRRZWjoHzu+rsjHlpWOUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GotiUIgy4U40Ym0aNDi9Zn15GU6rIhcjWyfSj84UL30NiaSBpEzQNqwfZ0fWJqFUrEVGBNynEqKDCD3XcyyR5/PrxjYfg16LtBE3/EZTQNUWOPJXl38MTTnb3+ku3VuPw2FHnj+cihXXiKtl3+wm11JcKpo2v9bayBLYJvNpgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhFDyktU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742976422; x=1774512422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1h14r4Gq72zE+uCNNVQUHEuRRZWjoHzu+rsjHlpWOUg=;
  b=PhFDyktUYXipu5jxPsY1lwwAdNj7GXF/+NmiXwt7Hxb52M65Ssy02WUo
   oYPasjZrP217mDC5notsU3BI/Y7BRK0kwduj/ZtuOLsxV1lJma6BWmFcb
   ke03IvyJZlWf2Je2FggCbcH4MHy1lhhlUWbVrH6eOOMoZhTfLN6sfz2o3
   tL7y5stPqRcO3UgPrHm3XeFWXWvSfYSox9fn4zuOuw+lF2wTzoJyWHfdh
   duhLXxhPjbTMBvButZmBVjD20289tClRqBlRDfoUVe+oreBNTnOC6lmM4
   0Rw/hGWXK3EIf6Z+iSeblLtyAVdniI9vSSv3ttQ6xOSWjUtyX+oAQZWGD
   A==;
X-CSE-ConnectionGUID: aol+BUeGS7WBCKrm92mAgQ==
X-CSE-MsgGUID: UrKIENqpTgKcAtVcsCyzLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44139694"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="44139694"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:07:01 -0700
X-CSE-ConnectionGUID: BokTjAbjRGa7Q2WQF5G3TQ==
X-CSE-MsgGUID: 2o5xN5B0TqGGq7R2n+/Wdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129360645"
Received: from kwywiol-mobl1.ger.corp.intel.com (HELO [10.245.83.152]) ([10.245.83.152])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:06:59 -0700
Message-ID: <17c82a42-2174-425f-a4c4-4df18176f7a1@linux.intel.com>
Date: Wed, 26 Mar 2025 09:06:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/ivpu: Fix deadlock in ivpu_ms_cleanup()
To: Lizhi Hou <lizhi.hou@amd.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, quic_jhugo@quicinc.com, stable@vger.kernel.org
References: <20250325114306.3740022-1-maciej.falkowski@linux.intel.com>
 <20250325114306.3740022-2-maciej.falkowski@linux.intel.com>
 <a0d93faa-40e0-4fc9-8b86-1e30c3946124@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <a0d93faa-40e0-4fc9-8b86-1e30c3946124@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/25/2025 9:50 PM, Lizhi Hou wrote:
> 
> On 3/25/25 04:43, Maciej Falkowski wrote:
>> From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>
>> Fix deadlock in ivpu_ms_cleanup() by preventing runtime resume after
>> file_priv->ms_lock is acquired.
>>
>> During a failure in runtime resume, a cold boot is executed, which
>> calls ivpu_ms_cleanup_all(). This function calls ivpu_ms_cleanup()
>> that acquires file_priv->ms_lock and causes the deadlock.
>>
>> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_ms.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
>> index ffe7b10f8a76..eb485cf15ad6 100644
>> --- a/drivers/accel/ivpu/ivpu_ms.c
>> +++ b/drivers/accel/ivpu/ivpu_ms.c
>> @@ -4,6 +4,7 @@
>>    */
>>     #include <drm/drm_file.h>
>> +#include <linux/pm_runtime.h>
>>     #include "ivpu_drv.h"
>>   #include "ivpu_gem.h"
>> @@ -281,6 +282,9 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
>>   void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
>>   {
>>       struct ivpu_ms_instance *ms, *tmp;
>> +    struct ivpu_device *vdev = file_priv->vdev;
>> +
>> +    pm_runtime_get_sync(vdev->drm.dev);
> 
> Could get_sync() be failed here? Maybe it is better to add warning for failure?

Yes, this could fail but we already have detailed warnings in runtime resume callback (ivpu_pm_runtime_resume_cb()).
> 
>>         mutex_lock(&file_priv->ms_lock);
>>   @@ -293,6 +297,8 @@ void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
>>           free_instance(file_priv, ms);
>>         mutex_unlock(&file_priv->ms_lock);
>> +
>> +    pm_runtime_put_autosuspend(vdev->drm.dev);
>>   }
>>     void ivpu_ms_cleanup_all(struct ivpu_device *vdev)

Regards,
Jacek


