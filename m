Return-Path: <stable+bounces-83473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A488D99A752
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16741C224C6
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD695126C01;
	Fri, 11 Oct 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoAlO/PG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E300199BC
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659786; cv=none; b=bers7CJFOUMVGhOvXmMy+vx9HjJTMQb7YWv+nA7TO35Gno0HI8UJSv2DD1LdoUQ39iR2fCDvbBuqaRiE59PLx0EtZ1rbLeyMdEBuymZ/pup6/VX1NQF872nVb61UtYzl5OfCwZ3D/4TilV5TY09xqX90kAPpCQGNnS5m8J8QvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659786; c=relaxed/simple;
	bh=VRlHoGf2kTc1wTdOe0oRNrggpX+5VHu9zERrBMmlKHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhk/PPTMM6u7/EGRYnTRCdIdCD1CAYyci8cyi/qlJRUrDDICNTadhGcxLXotRr+UJuiuMfjjYtU4SYAx7HDG+wjBPI+FGvxwpEUujnaUxETmyle0VPbWCCuNxr3qEPUxid6hJTbMclt+aBsMbSRBPfu/8Rf/beL+XogTvHfwnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoAlO/PG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728659784; x=1760195784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VRlHoGf2kTc1wTdOe0oRNrggpX+5VHu9zERrBMmlKHc=;
  b=eoAlO/PGWVQ8xEvTo7NwiAhapIEueAMkaX1xaO2h7jGNqUeCLNUsS231
   JBrmXIG1IR1on7ExTu3AvggEJgCWLFyKjRyYNTdgiZqG2xeyI297jyCLv
   vdZ16u9G61WVGUb/cfukoiGLySP3cocijHcx04Cm6xIBw4DvAFMM83ZZ2
   A/Q17z+HCdyDEJP2dR4CnxZr9qqIxt6bq6GgHAYMPNU/CiYqJKIIW/xys
   7QkRVYJQ/L4d6INW1xI6b1QRR6vnNvSQHM2d5GTcUfHuJGbxe+6ySjNYD
   AQDvE0tEFDrH6TxH30o8bnW+hH0KwyojHgtWufa+qM/1NLKJIlE8GPj3D
   Q==;
X-CSE-ConnectionGUID: fFgEaDBWRnya3n68qeXg8A==
X-CSE-MsgGUID: GMy9cjCVQiuUYS5fHV/J1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38712828"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="38712828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 08:16:24 -0700
X-CSE-ConnectionGUID: VINWo5/GQQGsib50x5FdEA==
X-CSE-MsgGUID: Q5YHAz4qR22K6XRKoz0OUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76841741"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO [10.245.245.149]) ([10.245.245.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 08:16:22 -0700
Message-ID: <0e96d34e-1204-4208-bab6-5b8f585e672b@intel.com>
Date: Fri, 11 Oct 2024 16:16:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/ufence: ufence can be signaled right after
 wait_woken
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20241011132532.3845488-1-nirmoy.das@intel.com>
 <07151ff0-90b1-4ec8-9f64-f695fb411dbf@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <07151ff0-90b1-4ec8-9f64-f695fb411dbf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2024 15:10, Nirmoy Das wrote:
> 
> On 10/11/2024 3:25 PM, Nirmoy Das wrote:
>> do_comapre() can return success after wait_woken() which is treated as
>> -ETIME here.
> 
> s/after wait_woken()/after timedout wait_woken()
> 
> I will resend with that change.
> 
>>
>> Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
>> Cc: <stable@vger.kernel.org> # v6.8+
>> Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> index d46fa8374980..d532283d4aa3 100644
>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> @@ -169,7 +169,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>>   			args->timeout = 0;
>>   	}
>>   
>> -	if (!timeout && !(err < 0))

Since err > 0 is impossible, this could be written as: && err == 0.

So I think this is saying: if we have timedout and err does not already 
have an error set then go ahead and set to -ETIME since we hit the 
timeout. But it might have -EIO or -ERESTARTSYS for example, which 
should then take precedence over -ETIME...

>> +	if (!timeout && err < 0)

...this would then trample the existing err. The err can either be zero 
or an existing error at this point, so I think just remove this entire 
check:

-       if (!timeout && !(err < 0))
-               err = -ETIME;
-

?

>>   		err = -ETIME;
>>   
>>   	if (q)

