Return-Path: <stable+bounces-210708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKNEAzl9cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:16:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAAE52AD6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BE154E5B12
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA83382CB;
	Wed, 21 Jan 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVpn7D+U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBC238C16
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979698; cv=none; b=LDLXDRQ2IamjHnv7XnV7BrWIvY45LCLmC7N2xdNT+AD7FPJsX4a9a98Rv1O9Ua0j0adf6eYnErM5rQESo6DgmZ11OXGykf+PeS1fkXVSxoPh5PZmnZy/BK3WDNmpMrNhIVg+Fm0V8J04dp0+DKJgQns3WXH7Uz34Z7yelrKn5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979698; c=relaxed/simple;
	bh=MXPljD5fEgppiCAcWTE+QV4bH88CzPOxUrW5uDUo0fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvqX8KRyFQ4FOJ7I/LkuP50kqmP4aBkufbolrnJFLvIQ6jh/I7e8hmHl8qqPCo81fdnc1+G5I1SXnIUAtEQQGjldGHJH9/EEGQKHy/pGxK0qgAXyJbvd8++5Nyc1F1SzeyFcLZcD3XdYkx+5zEaZ2javUw/g61VDIhG/M8FOSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVpn7D+U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768979695; x=1800515695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXPljD5fEgppiCAcWTE+QV4bH88CzPOxUrW5uDUo0fQ=;
  b=QVpn7D+UamDjJ4Zf+voRmaJMCiT2SByaiiNli+O/7I8mZtkwJ+fmnvoV
   y7xzuwl4CIJDJwG2YlY4vEw+zcS0eN+sJRUlkYkqGUpusClLw8DrmJoaT
   c5oGpFHKAZ/zmczGkCf24Dc5Vws0JuonnjATCWHcZyFlCSCaJqNeyR/vx
   kGCqyqC8XgUKHlgdpNMXC75KK7tKH6DFIJp0326dLoAjOs8cvyrmp4YxL
   VnMybZiFO7O04cPePputrpxkt7VniAzG6cShZqwJlmOxMz34Zub6Dzp/A
   kWl3Amj+Mbwx3s96+rG3h5bamHrpkEEXGkGR97GI5/iqSJkYnJGTy786i
   Q==;
X-CSE-ConnectionGUID: gtA4m729TP+iOXvnGYGXfw==
X-CSE-MsgGUID: uzPI5VWFQdK5UOmKrEJUZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="92869395"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="92869395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:14:50 -0800
X-CSE-ConnectionGUID: Hf5YgZrfQ7a9nSf4Yr5/AA==
X-CSE-MsgGUID: 7iACQ/imSfGRENC7kimbYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211227627"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:14:48 -0800
Message-ID: <3fccd233-c5cf-4252-98ea-61f240f82695@linux.intel.com>
Date: Wed, 21 Jan 2026 15:14:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IOMMU regression in linux-6.18.y
To: Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 regressions <regressions@lists.linux.dev>, stable@vger.kernel.org
Cc: iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "Hou, Lizhi" <lizhi.hou@amd.com>
References: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
 <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210708-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 6BAAE52AD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 13:26, Mario Limonciello wrote:
> 
> 
> On 1/20/26 8:08 PM, Mario Limonciello wrote:
>> Hi,
>>
>> Recently I found out that amdxdna stopped working in linux-6.18.4.  
>> This is because of this commit in linux-6.18.y:
>>
>> commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")
>>
>> That was originally backported from upstream:
>>
>> commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")
>>
>> ---
>>
>> SVA support is a requirement for amdxdna.
>>
>> The series that this commit came from was part of a larger 8 patch 
>> series, but this was the only commit that was CC'ed to stable.
>>
>> As a result this is not broken in 6.19-rc, but it is broken in 
>> linux-6.18.y (and presumably any older stable kernels still around 
>> that picked it up).
>>
>> So there are two options I see:
>>
>> 1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel 
>> that picked it up but has amdxdna)
>>
>> 2) Bring the entire 8 patch series to linux-6.18.y.
>>
>> This is the entire series (I didn't look up the hashes from mainline, 
>> but they should have all landed):
>> https://lore.kernel.org/linux-iommu/20251022082635.2462433-1- 
>> baolu.lu@linux.intel.com/
>>
>> What should we do?
>>
> 
> If the decision is to take the remaining commits to 6.18.y to fix this I 
> did confirm they cleanly cherry pick and build.  Here are the hashes.
> 
> commit 27bfafac65d8 ("mm: add a ptdesc flag to mark kernel page tables")
> commit 977870522af3 ("mm: actually mark kernel page table pages")
> commit 412d000346ea ("x86/mm: use 'ptdesc' when freeing PMD pages")
> commit 018942956723 ("mm: introduce pure page table freeing function")
> commit bf9e4e30f353 ("x86/mm: use pagetable_free()")
> commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page 
> tables")
> commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for 
> kernel address space")
> 

Yes. These patches fix a security issue in iommu/sva on x86 and restore
the SVA functionality.

Thanks,
baolu

