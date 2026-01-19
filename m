Return-Path: <stable+bounces-210347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD3D3A92D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0819130CE9EF
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8E35B149;
	Mon, 19 Jan 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMYhCwCq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09033CE8A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826263; cv=none; b=nhLBqOz+O35f1U03Lfj1L0P0snUDnH0qPNuJBAK+wPjkke6HA+Zk/cJn1N0LmiJguqXNgTSl+1jQSnFyXOCWj9U9pffaguFT22j8T8upU2vcnbVWS6fpIhngVhSSIgEazrXHcco9QBYusjjoVehR7O3D7vsd23JUqK76Qkiaohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826263; c=relaxed/simple;
	bh=tDFzLqyyYdzzKAXqB1JC8rT6PcL9iO/N2PSqjN7pwHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THA/bYc3VTOsGZlAAgv99PqlZYP2MlAc9fAC1rG+xIwPRGZhJmc8lbNVdI4/XqMmppWlmMAC2xwYyfwKgcFjDcTgwvAhhdAwngRyZt9RTZ/t42fgF5mgG8Ad421UStxMfKHGS8xvaOPq3TdUeKx2E+SS5EEiN6ACOhv9uD13KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMYhCwCq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768826262; x=1800362262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDFzLqyyYdzzKAXqB1JC8rT6PcL9iO/N2PSqjN7pwHk=;
  b=NMYhCwCqfqCj03tZL7Aczpt0zUSDxbLaloHbTBUDn2dE7zlRWZFfjTjZ
   TQRNYegxxRe/SEhDuQFWTTATPUaW26jOUHHhAxE8wYnhE+SKwnW4vR5U7
   ThVD68KnV96T5G+fLOW3yPJPSVEinINr9ZSuP3fCyC328Q9zDAdrqxUgy
   S7R3yWfCloENdvoMN9v7nwuk9EkA5j0iohUfveHmJz2ozyV+1Qk7vVRv6
   hIooonYNfX737Wlj39XxISiGD20x0Am+dXw6shEEbLph3VqxrKoNUrFpb
   s0tV2Mcor+wO07M7g0prB9f4ilBJDPnBNXlBdRfVqeULO1yN2tIqF73/6
   A==;
X-CSE-ConnectionGUID: LsMhoezoRze8XgV/nCp72A==
X-CSE-MsgGUID: ZDZjp1i7R1eCDfrQiNlCPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70124162"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70124162"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 04:37:41 -0800
X-CSE-ConnectionGUID: bajIkM4MT+i04BC9a4nUhA==
X-CSE-MsgGUID: g/77RmGQQA6iraGyHzvtCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210001221"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.99]) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 04:37:39 -0800
Message-ID: <598d3899-5942-485b-8e76-61bcbdfa5cbe@intel.com>
Date: Mon, 19 Jan 2026 12:37:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
To: "Zhang, Carl" <carl.zhang@intel.com>,
 "Brost, Matthew" <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Souza, Jose" <jose.souza@intel.com>,
 "Mrozek, Michal" <michal.mrozek@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
 <fh6dgogrt3ibrod7qkguejy4bj3cmvlbnxksmedhvfx3ejglk2@nu3h6doh7sdx>
 <cc27ae58-b579-4332-9653-c62b38f32add@intel.com>
 <aURm1LgtNPYNxRCP@lstrano-desk.jf.intel.com>
 <PH0PR11MB55798387B824D4101E19545E87A9A@PH0PR11MB5579.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <PH0PR11MB55798387B824D4101E19545E87A9A@PH0PR11MB5579.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/12/2025 06:36, Zhang, Carl wrote:
> 
> 
>> -----Original Message-----
>> From: Brost, Matthew <matthew.brost@intel.com>
>> Sent: Friday, December 19, 2025 4:41 AM
>> To: Auld, Matthew <matthew.auld@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>; intel-
>> xe@lists.freedesktop.org; Thomas Hellström
>> <thomas.hellstrom@linux.intel.com>; Souza, Jose <jose.souza@intel.com>;
>> Mrozek, Michal <michal.mrozek@intel.com>; Zhang, Carl
>> <carl.zhang@intel.com>; stable@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
>>
>> On Mon, Nov 24, 2025 at 01:41:55PM +0000, Matthew Auld wrote:
>>> On 20/11/2025 15:34, Lucas De Marchi wrote:
>>>> On Thu, Nov 20, 2025 at 01:27:29PM +0000, Matthew Auld wrote:
>>>>> Currently this is very broken if someone attempts to create a bind
>>>>> queue and share it across multiple VMs. For example currently we
>>>>> assume it is safe to acquire the user VM lock to protect some of
>>>>> the bind queue state, but if allow sharing the bind queue with
>>>>> multiple VMs then this quickly breaks down.
>>>>>
>>>>> To fix this reject using a bind queue with any VM that is not the
>>>>> same VM that was originally passed when creating the bind queue.
>>>>> This a uAPI change, however this was more of an oversight on
>>>>> kernel side that we didn't reject this, and expectation is that
>>>>> userspace shouldn't be using bind queues in this way, so in theory this
>> change should go unnoticed.
>>>>>
>>>>> Based on a patch from Matt Brost.
>>>>>
>>>>> v2 (Matt B):
>>>>>   - Hold the vm lock over queue create, to ensure it can't be
>>>>> closed as
>>>>>     we attach the user_vm to the queue.
>>>>>   - Make sure we actually check for NULL user_vm in destruction path.
>>>>> v3:
>>>>>   - Fix error path handling.
>>>>>
>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>> GPUs")
>>>>> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>> Cc: José Roberto de Souza <jose.souza@intel.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Michal Mrozek <michal.mrozek@intel.com>
>>>>> Cc: Carl Zhang <carl.zhang@intel.com>
>>>>> Cc: <stable@vger.kernel.org> # v6.8+
>>>>
>>>> we never had any platform officially supported back in 6.8. Let's
>>>> make it 6.12 to avoid useless backporting work.
>>>>
>>>>> Acked-by: José Roberto de Souza <jose.souza@intel.com>
>>>>
>>>> Michal / Carl, can you also ack compute/media are ok with this change?
>>>
> I am ok , current media driver only use default 0,  did not create bind exec queue .

Thanks for confirming.

Michal, ping on this from compute POV?

> 
>>> Ping on this? I did a cursory grep for DRM_XE_ENGINE_CLASS_VM_BIND and
>>> found no users in compute-runtime or media-driver in upstream. This
>>> change should only be noticeable if you directly use
>>> DRM_XE_ENGINE_CLASS_VM_BIND to create a dedicated bind queue, which
>> you then pass into vm_bind.
>>>
>>
>> Yes, ping? It would be good to get this series in.
>>
>> Matt
>>
>>>>
>>>> Lucas De Marchi
>>>
> Thanks
> Carl


