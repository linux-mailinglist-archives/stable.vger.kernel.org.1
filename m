Return-Path: <stable+bounces-136594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE54A9B03A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AAF7AD3DD
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1E18A959;
	Thu, 24 Apr 2025 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7IwEsyx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2012CDA5
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503817; cv=none; b=R/D7rIGNLEZevl15oRP0JDZUrE/vIfgnR5d/sk2hunNRRodKIBHT7iU8NSlDUydSqnxT9fdgRUiFNBSC/1kl+cDidAGiGB9HbUQ/1bTP1oSkphch85k/1lfRtNgxQIXW2Hf4QCSMJvVe8rTz4d+x6/84lb6I7OlBOmAlYyXVDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503817; c=relaxed/simple;
	bh=HgYWa0KeSKcfGbmk47jhXCWVY/vg+Gf8SDRhG1C38DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inotattj4k5LPbRlIQuryU+SfOVGEMNL7EPRKwC77regM3iCeFYudI8BwnriDN/wbjJ4Qj/nncD6Lo7Ogsjkd2wqyrETqPxcohbuFDmqIk3GHCvLOM4JV3QG82h6IvjShXGkSDdufG8XGYFrUbklbFrYdqHPv3AvFuAsUbOVlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7IwEsyx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745503815; x=1777039815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HgYWa0KeSKcfGbmk47jhXCWVY/vg+Gf8SDRhG1C38DY=;
  b=I7IwEsyxx4Qxv08lukwtH3KuxMzo8VRNaj9Z+MYQ0QZSmlDrkT1CUQdu
   qY2eMeXdZRiqwYJBm0kdvSRZ7wRFQETKDPoQowSytSb2KGcQHaIJBAwC1
   zZD/kuGCWL1DJxGZSetYxU9NnPBi87wGyLgAxs8Jve+v5NiRA4tmU65ne
   0uJ9WuPBsDKzEUwbAIG7RaBxkqExqf8SU6suIFFYgNjKgbdK2JPgibjRO
   Ktps4aepU5OncMfHpbZMeAjFyvfyGROzaIh34oFtLJKYE0U5BXWpSAhXA
   +zJ0uTZaTQZfJD2nkK30F++8loqim5VeZzIhmrMJ3Lq4oveH41DPiqiZY
   w==;
X-CSE-ConnectionGUID: Fa/9FGvGToGeK0S4/P+3pg==
X-CSE-MsgGUID: /8vVOSkXSCCGz8VryRPeEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47013899"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47013899"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:10:12 -0700
X-CSE-ConnectionGUID: 4hbJSsyqQhmhnYjAK4eA/A==
X-CSE-MsgGUID: 0UgLxu6/Tx+o26VGVaaeJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="137429596"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.124.221.210]) ([10.124.221.210])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:10:10 -0700
Message-ID: <39b30d41-c073-43f9-8860-1091789a40f8@linux.intel.com>
Date: Thu, 24 Apr 2025 07:10:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: stable@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Cedric Xing <cedric.xing@intel.com>,
 x86@kernel.org
References: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
 <7f1c8e94-9be7-4ff7-a2a4-063edce48c96@linux.intel.com>
 <6809aaf1c7e44_71fe29494@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6809aaf1c7e44_71fe29494@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/23/25 8:07 PM, Dan Williams wrote:
> Sathyanarayanan Kuppuswamy wrote:
>> On 4/23/25 2:01 PM, Dan Williams wrote:
>>> Unlike sysfs, the lifetime of configfs objects is controlled by
>>> userspace. There is no mechanism for the kernel to find and delete all
>>> created config-items. Instead, the configfs-tsm-report mechanism has an
>>> expectation that tsm_unregister() can happen at any time and cause
>>> established config-item access to start failing.
>>>
>>> That expectation is not fully satisfied. While tsm_report_read(),
>>> tsm_report_{is,is_bin}_visible(), and tsm_report_make_item() safely fail
>>> if tsm_ops have been unregistered, tsm_report_privlevel_store()
>>> tsm_report_provider_show() fail to check for ops registration. Add the
>>> missing checks for tsm_ops having been removed.
>>>
>>> Now, in supporting the ability for tsm_unregister() to always succeed,
>>> it leaves the problem of what to do with lingering config-items. The
>>> expectation is that the admin that arranges for the ->remove() (unbind)
>>> of the ${tsm_arch}-guest driver is also responsible for deletion of all
>>> open config-items. Until that deletion happens, ->probe() (reload /
>>> bind) of the ${tsm_arch}-guest driver fails.
>>>
>>> This allows for emergency shutdown / revocation of attestation
>>> interfaces, and requires coordinated restart.
>>>
>>> Fixes: 70e6f7e2b985 ("configfs-tsm: Introduce a shared ABI for attestation reports")
>>> Cc: stable@vger.kernel.org
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Steven Price <steven.price@arm.com>
>>> Cc: Sami Mujawar <sami.mujawar@arm.com>
>>> Cc: Borislav Petkov (AMD) <bp@alien8.de>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Reported-by: Cedric Xing <cedric.xing@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>> Looks good to me
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Thanks!
>
> [..]
>>>    static const struct config_item_type tsm_reports_type = {
>>> @@ -459,6 +478,11 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
>>>    		return -EBUSY;
>>>    	}
>>>    
>>> +	if (atomic_read(&provider.count)) {
>>> +		pr_err("configfs/tsm not empty\n");
>>
>> Nit: I think adding the provider ops name will make the debug log clear.
> Recall though that the ->name field is a tsm_ops property. At this point
> tsm_ops is already unregistered. Even if we kept the name around by
> strdup() at register time the name does not help solving the conflict,
> only rmdir of the created configs-item unblocks the next registration.

Makes sense.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


