Return-Path: <stable+bounces-253462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICJ4CaSwDmr6AwYAu9opvQ
	(envelope-from <stable+bounces-253462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:13:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C4559FF04
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D0330488F2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31837A4B8;
	Thu, 21 May 2026 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuEA9YMA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071C340A6F;
	Thu, 21 May 2026 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347566; cv=none; b=ZIjNRjr1iQge//xTHZ461UEH8WQXDq3+5wS6/JAd5qRGxvrDSG4oiHD6H1ZvS0/CNu0KNvzMtYT+s7iGgCmAn1ndlBqNRqS95vB7Q+XbQ8RoFMGZk9rXmvhxbCdQ6RRTx8+31cCBYO/1R4cbaaJ2uKtO56B+jN+//YR7ekcKnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347566; c=relaxed/simple;
	bh=vAJJ3FDtSyAQe3hvVR8TP4qenyPph1Sk+kdtnQ44E/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk71OjlFtTFCrl/DactCIxypdfKRx6q6ueRUdKHq/qRn9nft8LfjfEwIOaINBKH6c2ueLpbh5YxsR9eLemFOMILueMaQpySSbhYyt2MWfsLBLmulXvpZHrx2/cDIMHs1vD/zkX0uACr0m+bXuOmJpUgr0/sTH2IvkQo9NQErczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuEA9YMA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779347565; x=1810883565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vAJJ3FDtSyAQe3hvVR8TP4qenyPph1Sk+kdtnQ44E/k=;
  b=GuEA9YMAkVIEi461Nq+gUW80vzxQLnkT5gceSOOs4FBVXnfigO0jaw3A
   CWjosHI2k6euqZT6UL5xX5UHD3IqBqjFv+0TTmoWLBLZgr6iIFh1cDFYy
   xTYsYNH7INKL7DgrWit+P7ZRnOeoXqt5dS70uTXEN+okWIrPZmVS7sxWS
   gVA6NgxnYAcM1MFCq5oxjc9wfQ/pKqzkH2ddFhf96w0mopRa9iIm2Xbhv
   0calKaGVWNZp4DJt+Q/3sY0UQKFsJ4zWxnQfB7JZL45u2TyVyy3Ncll/X
   LUEbSU45hnSKwTZKszsNTwm0vji0Ex6WWaAANshggoa5Y4fmg7gGqjDbd
   g==;
X-CSE-ConnectionGUID: JLrgsl6rRAazeE+XCyzn4Q==
X-CSE-MsgGUID: 2NOEtAU/S6+0xYenInZ5aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90835252"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="90835252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:12:44 -0700
X-CSE-ConnectionGUID: sFlmDBuWQSe1VTSHvOovxA==
X-CSE-MsgGUID: kqHmKTJsRtq0t07AC2/Fgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="240482087"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:12:42 -0700
Message-ID: <f90e3996-3f10-456f-b351-6c46054c29af@linux.intel.com>
Date: Thu, 21 May 2026 15:12:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
References: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
 <c556e432-0e80-463f-a924-83f8f1ab333b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c556e432-0e80-463f-a924-83f8f1ab333b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253462-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 73C4559FF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 21:12, Yi Liu wrote:
> On 5/19/26 13:29, Lu Baolu wrote:
>> The Intel IOMMU driver allows SVA on devices even if they do not support
>> PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when
>> PRI is supported") modified the SVA bind path to allow this configuration
>> by skipping IOPF enablement when PRI is missing. However, it failed to
>> update the unbind path.
>>
>> This creates an imbalance: the unbind path attempts to disable IOPF for
>> a device that never had it enabled, triggering a WARNING in
>> intel_iommu_disable_iopf():
>>
>>   WARNING: drivers/iommu/intel/iommu.c:3475 at 
>> intel_iommu_disable_iopf+0x4f/0x90d
>>   Call Trace:
>>    <TASK>
>>    blocking_domain_set_dev_pasid+0x50/0x70
>>    iommu_detach_device_pasid+0x89/0xc0
>>    iommu_sva_unbind_device+0x73/0x150
>>    xe_vm_close_and_put+0x4d2/0x1200 [xe]
>>
>> Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
>> in both the bind and unbind paths.
>>
>> Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is 
>> supported")
>> Cc: stable@vger.kernel.org
>> Reported-by: Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h | 11 +++++++++++
>>   drivers/iommu/intel/svm.c   | 12 ++++--------
>>   2 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index ef145560aa98..775f1c4ae346 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1254,18 +1254,29 @@ void intel_iommu_disable_iopf(struct device 
>> *dev);
>>   static inline int iopf_for_domain_set(struct iommu_domain *domain,
>>                         struct device *dev)
>>   {
>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +
>>       if (!domain || !domain->iopf_handler)
>>           return 0;
>> +    /* SVA with non-IOMMU/PRI IOPF handling is allowed. */
>> +    if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
>> +        return 0;
>> +
> 
> Looked into the history a bit, and this story begins with commit
> a86fb7717320 ("iommu/vt-d: Allow SVA with device-specific IOPF"). This
> commit enabled devices that support their own IOPF mechanism to use SVA
> even when the platform IOMMU doesn't support IOPF.
> 
> However, SVA isn't the only fault-capable domain type. Other fault-capable
> domain types (e.g., paging domains) should also be able to leverage
> device-specific IOPF capabilities.
> 
> My question is: can we drop the domain type check to support other types
> of fault-capable domains that rely on device-specific IOPF?

The Intel IOMMU driver treats the SVA case as a special case. It allows
an SVA domain with a registered iopf_handler to attach to a device for
SVA functionality. Broadly speaking, it would be better to handle this
in the IOMMU core — for example, by preventing the attachment of a
fault-capable domain to a device that lacks IOMMU-backed page fault
capabilities.

Thanks,
baolu

