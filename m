Return-Path: <stable+bounces-126918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9DA7454E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0870188EF39
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA83211485;
	Fri, 28 Mar 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqCAaJHW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E618DB2B
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150242; cv=none; b=uGgQKfoNtq8yurSwVcqpzQ5pMRozMmEq9H9s2NqmakB6ZxodaKubnzyNh2KjiguH/EN6MTHaEJt+L5D1I4GC/w6wTKv7V4OMAG0kqpobHMxOa3xbm78BAUt/ARb87xEUgm6kF+ElhKpSX1/JJhqD/bKQkS5Pfs75uhQiQBdRsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150242; c=relaxed/simple;
	bh=eGI32WhpgyzFIHFK5QikFy6F+lcZCPEkmnoatYyfojk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Exc9LP19MBvNPuLlZ0dxlfuy3P7dI8khUTffz4KY8m4RIZCjOwAUwpBeC20NghQPfMlBooR/FjpsW8nAmgWlM812VOJwVKiKQ2qcJZsFqskbJQGQA8fUzmWb6zbbOAQwggBJbn6XBUVbYo69nVx7i+FPrnzcSFn8KEEYpCkxnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqCAaJHW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743150241; x=1774686241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eGI32WhpgyzFIHFK5QikFy6F+lcZCPEkmnoatYyfojk=;
  b=jqCAaJHWn6Fio4zSaysnGo+QTTr0/BR88bqOWjw5emqL9uoYBK2tXJ8r
   g9D9Jr6dS4Y+u4/8Dli/3ARlV9dOi6sMGxrU6Yg7HBo+/sUMnqh3IanaB
   hcNcM4Ka6tWOorqZmuomtBWdmlSFlVcrtzfoOL5uK/bIjEhcc8L0coziW
   i5CB2ipwpZwZo31b8qKw68NPhueeWIdRxdgF3upd60LOK7m+7VtVr2Yvb
   XvjTnHcmDK5pPUI7d5wGEO8KwWUPmeS7tL+HECl/dn2QHOA7Z2qa72csk
   LF4OFJJaiH4j28dLtOOCB1jVVRWRdDnhtVnP57t2oOr4NrypeTMIHhu4V
   Q==;
X-CSE-ConnectionGUID: nCW6DqmARkW5HiSokeS0hQ==
X-CSE-MsgGUID: pIaRGw8HTCCs4h+i21fznA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44635231"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="44635231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 01:24:00 -0700
X-CSE-ConnectionGUID: gF2iXmXYSxqjZdUZih+0tg==
X-CSE-MsgGUID: /IyywgYtRMq8bdbaQky+FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="125839079"
Received: from tmilea-mobl3.ger.corp.intel.com (HELO [10.245.115.15]) ([10.245.115.15])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 01:23:58 -0700
Message-ID: <a4365e8a-093d-488c-be79-6eda6b29ddde@linux.intel.com>
Date: Fri, 28 Mar 2025 09:23:57 +0100
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
 <17c82a42-2174-425f-a4c4-4df18176f7a1@linux.intel.com>
 <40a4d432-aa18-6a60-adcc-e73eb3c7fcb7@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <40a4d432-aa18-6a60-adcc-e73eb3c7fcb7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/27/2025 6:38 PM, Lizhi Hou wrote:
> 
> On 3/26/25 01:06, Jacek Lawrynowicz wrote:
>> Hi,
>>
>> On 3/25/2025 9:50 PM, Lizhi Hou wrote:
>>> On 3/25/25 04:43, Maciej Falkowski wrote:
>>>> From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>>>
>>>> Fix deadlock in ivpu_ms_cleanup() by preventing runtime resume after
>>>> file_priv->ms_lock is acquired.
>>>>
>>>> During a failure in runtime resume, a cold boot is executed, which
>>>> calls ivpu_ms_cleanup_all(). This function calls ivpu_ms_cleanup()
>>>> that acquires file_priv->ms_lock and causes the deadlock.
>>>>
>>>> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
>>>> Cc: <stable@vger.kernel.org> # v6.11+
>>>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>>> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
>>>> ---
>>>>    drivers/accel/ivpu/ivpu_ms.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
>>>> index ffe7b10f8a76..eb485cf15ad6 100644
>>>> --- a/drivers/accel/ivpu/ivpu_ms.c
>>>> +++ b/drivers/accel/ivpu/ivpu_ms.c
>>>> @@ -4,6 +4,7 @@
>>>>     */
>>>>      #include <drm/drm_file.h>
>>>> +#include <linux/pm_runtime.h>
>>>>      #include "ivpu_drv.h"
>>>>    #include "ivpu_gem.h"
>>>> @@ -281,6 +282,9 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
>>>>    void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
>>>>    {
>>>>        struct ivpu_ms_instance *ms, *tmp;
>>>> +    struct ivpu_device *vdev = file_priv->vdev;
>>>> +
>>>> +    pm_runtime_get_sync(vdev->drm.dev);
>>> Could get_sync() be failed here? Maybe it is better to add warning for failure?
>> Yes, this could fail but we already have detailed warnings in runtime resume callback (ivpu_pm_runtime_resume_cb()).
> 
> Will the deadlock still happens if this function fails?

No. The deadlock was caused by runtime resume in free_instance().
pm_runtime_get_sync() will always bump PM usage counter, so there will be no resume regardless if it fails or not.

>>>>          mutex_lock(&file_priv->ms_lock);
>>>>    @@ -293,6 +297,8 @@ void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
>>>>            free_instance(file_priv, ms);
>>>>          mutex_unlock(&file_priv->ms_lock);
>>>> +
>>>> +    pm_runtime_put_autosuspend(vdev->drm.dev);
>>>>    }
>>>>      void ivpu_ms_cleanup_all(struct ivpu_device *vdev)
>> Regards,
>> Jacek
>>


