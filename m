Return-Path: <stable+bounces-139190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75134AA5091
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF811B63920
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783262609C5;
	Wed, 30 Apr 2025 15:41:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548E13632B;
	Wed, 30 Apr 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027693; cv=none; b=CkGbR0ujBlobE/9dIoqKGQcjoQT20KvJWSq2dCURhT5q4y6lhIK6NO/D8aXM7qVul0OhAOQmpQmAOPHVMT2Coj/bLyg/hgF8z4lIEWZGOdpUPt8r0fp9TX1C8TyVI2Js8rNpyGbZ+krqGxio9ZYCpOWYV0Z0eBxlk2Z6TjAjy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027693; c=relaxed/simple;
	bh=kdy+6lyDup6NN9r8Zyqs6ADoNhHFNmabeAeGewjscmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jP68QAsNOB/ZL6CIuqFhcjm4Dy7ZIzdsUgu0gAwx70HOGg5+l8Wn+F8NVNgqkHQxoe8zbBRD9zj48HYvPu0kJzOwH+bqcCIouUZzdzwwwGnCDu1s/sD2pQZ3p8oRFtyLXZ/hRo7iECXMFQYDiNoBsB/P+zy/DCOWoCftHmxSnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DEF61063;
	Wed, 30 Apr 2025 08:41:23 -0700 (PDT)
Received: from [10.57.47.173] (unknown [10.57.47.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F5783F5A1;
	Wed, 30 Apr 2025 08:41:27 -0700 (PDT)
Message-ID: <55d0c2a9-54a3-4063-9f57-624e7eef4720@arm.com>
Date: Wed, 30 Apr 2025 16:41:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Restrict devmem for confidential VMs
Content-Language: en-GB
To: Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org,
 Nikolay Borisov <nik.borisov@suse.com>, Naveen N Rao <naveen@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mpe@ellerman.id.au
References: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
 <63bb3383-de43-4638-b229-28c33c1582be@intel.com>
 <681005cdd3631_1d522948e@dwillia2-xfh.jf.intel.com.notmuch>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <681005cdd3631_1d522948e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan

On 28/04/2025 23:48, Dan Williams wrote:
> Dave Hansen wrote:
>> On 4/17/25 12:11, Dan Williams wrote:
>>>   arch/x86/Kconfig          |    4 ++++
>>>   arch/x86/mm/pat/memtype.c |   31 ++++---------------------------
>>>   drivers/char/mem.c        |   27 +++++++++------------------
>>>   include/linux/io.h        |   21 +++++++++++++++++++++
>>>   4 files changed, 38 insertions(+), 45 deletions(-)
>>
>> This looks like a good idea on multiple levels. We can take it through
>> tip, but one things that makes me nervous is that neither of the "CHAR
>> and MISC DRIVERS" supporters are even on cc.
>>
>>> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> 
> Good catch, just note that until this latest iteration the proposal was
> entirely contained to x86 specific support functions like devmem_is_allowed().
> So yes, an oversight as this moved to a more general devmem mechanism.
> 
>> I guess arm and powerpc have cc_platform_has() so it's not _completely_
>> x86 only, either. Acks from those folks would also be appreciated since
>> it's going to affect them most immediately.
> 
> I have added Suzuki and Michael for their awareness, but I would not say
> acks are needed at this point since to date CC_ATTR_GUEST_MEM_ENCRYPT is
> strictly an x86-ism.
> 
> For example, the PowerPC implementation of cc_platform_has() has not been
> touched since Tom added it.
> 
> Suzuki, Michael, at a minimum the question this patch poses to ARM64 and
> PowerPC is whether they are going to allow CONFIG_STRICT_DEVMEM=n, or otherwise
> understand that CONFIG_STRICT_DEVMEM=y == LOCKDOWN with
> CC_ATTR_GUEST_MEM_ENCRYPT.

For CCA we don't really enforce STRICT_DEVMEM. But we do expect people
to use it for safety reasons, but is not mandatory.

Does that help ?

Suzuki



> 
>> Also, just to confirm, patch 2 can go to stable@ without _any_
>> dependency on patch 1, right?
> 
> Correct. I will make them independent / unordered patches on the repost.
> 
> Next posting to fix the "select" instead of "depends on" dependency
> management, h/t Naveen, and clarify the "'crash' vs 'SEPT violation'"
> description.


