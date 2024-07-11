Return-Path: <stable+bounces-59072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8092E2BB
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB591281519
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8568B14B06C;
	Thu, 11 Jul 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A6K+ZKXq"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECA12BF02
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687872; cv=none; b=FTu3UPvbj3+w809Z9t8NeJBT8Uf4FN8UvtDua87vxmj30BFDzHRkkZeuLduKIH9kQHoeOo24+gVsfpw2F8NooP5Evr0oKmyYEC0KGS/3zANWHHXjheR2ZByXr68P03HoVdIMkN9AnDjw8jnKDIxI7B8M+iMh8+4S4HEfqk6Dpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687872; c=relaxed/simple;
	bh=vEWb1vYa4H8kA6IMwpEybQiAbU1QDdLjdSkZCj2lkSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSQ4D6FbvXUkFAayDfTx9XrTDDGPxjUnUG2h6+2YoNDvck3LXwSCB78p7rnfM8WaPTOzRMSRzH/L4oedRj3dykYpaSWheMcVuv5RpYGxOcpGHGEWS93pRVIfyJiCEFjK9YumbNomrwPBTyj0++RAhOZxVUYi1W7Ms42WeDGPzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A6K+ZKXq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TD+6al8ce2H5BBBxJ+FQ1i/d3K1MOtEzoW9hOCI7t6k=; b=A6K+ZKXq8uAsq0cVR2RV+8nG7x
	4g/vSonQeYm9lQ7TlWhLZ7GjpQqYG22hyn3dcF/zsrsOYO6SPH8pcIL1b8xEQZULwSJL/Tr3au4YN
	zUIL3WOEo5ZUD3pFKG0RYEisIRVHngAH6rExtZO6wiSbT4/CzVYHrxaGyM8gBTws90y1UwusENmuE
	+lU9aZo0lhIO+1ZUZ+awcq9X2o9/uQfzrWMIVmqzxbfZXFvKsoFKSm1lbxlJrt92vJk2NALlcmSyJ
	Vk+7ly8i9gEfdJUCTYvt59heFkijGXhFlLrSrqxj+HyJf101AdXKiiqVHsCjhrHFF+YD1JLir8U6d
	o/CIue/g==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRpW4-00Dbnq-0L; Thu, 11 Jul 2024 10:51:04 +0200
Message-ID: <504bfca3-a8cf-4c42-9b04-41e696a2ad0f@igalia.com>
Date: Thu, 11 Jul 2024 09:51:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/v3d: Validate passed in drm syncobj handles in
 the timestamp extension
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Iago Toral Quiroga <itoral@igalia.com>,
 stable@vger.kernel.org
References: <20240710134130.17292-1-tursulin@igalia.com>
 <20240710134130.17292-5-tursulin@igalia.com>
 <6c4a6268-6e0a-476b-adca-b1c35ea71abc@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6c4a6268-6e0a-476b-adca-b1c35ea71abc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/07/2024 18:06, Maíra Canal wrote:
> On 7/10/24 10:41, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> If userspace provides an unknown or invalid handle anywhere in the handle
>> array the rest of the driver will not handle that well.
>>
>> Fix it by checking handle was looked up successfuly or otherwise fail the
> 
> I believe you mean "Fix it by checking if the handle..."
> 
> Also s/successfuly/successfully

Oops, thank you!

> 
>> extension by jumping into the existing unwind.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the 
>> timestamp query job")
>> Cc: Maíra Canal <mcanal@igalia.com>
>> Cc: Iago Toral Quiroga <itoral@igalia.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/v3d/v3d_submit.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c 
>> b/drivers/gpu/drm/v3d/v3d_submit.c
>> index ca1b1ad0a75c..3313423080e7 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -497,6 +497,10 @@ v3d_get_cpu_timestamp_query_params(struct 
>> drm_file *file_priv,
>>           }
>>           job->timestamp_query.queries[i].syncobj = 
>> drm_syncobj_find(file_priv, sync);
>> +        if (!job->timestamp_query.queries[i].syncobj) {
>> +            err = -ENOENT;
> 
> I'm not sure if err should be -ENOENT or -EINVAL, but based on other 
> drivers, I believe it should be -EINVAL.

After a quick grep I am inclined to think ENOENT is correct. DRM core 
uses that, and drivers seem generally confused (split between ENOENT and 
EINVAL). With one even going for ENODEV!

Regards,

Tvrtko
>> +            goto error;
>> +        }
>>       }
>>       job->timestamp_query.count = timestamp.count;
>> @@ -550,6 +554,10 @@ v3d_get_cpu_reset_timestamp_params(struct 
>> drm_file *file_priv,
>>           }
>>           job->timestamp_query.queries[i].syncobj = 
>> drm_syncobj_find(file_priv, sync);
>> +        if (!job->timestamp_query.queries[i].syncobj) {
>> +            err = -ENOENT;
>> +            goto error;
>> +        }
>>       }
>>       job->timestamp_query.count = reset.count;
>> @@ -613,6 +621,10 @@ v3d_get_cpu_copy_query_results_params(struct 
>> drm_file *file_priv,
>>           }
>>           job->timestamp_query.queries[i].syncobj = 
>> drm_syncobj_find(file_priv, sync);
>> +        if (!job->timestamp_query.queries[i].syncobj) {
>> +            err = -ENOENT;
>> +            goto error;
>> +        }
>>       }
>>       job->timestamp_query.count = copy.count;

