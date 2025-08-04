Return-Path: <stable+bounces-166434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED64B19A42
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 04:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B85C3B3787
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0891211276;
	Mon,  4 Aug 2025 02:43:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1C3B21172A;
	Mon,  4 Aug 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275405; cv=none; b=iMb4hY+XXfFdttbqQ/1ky+ZM9C/vfa2aFKywl0w5xUI7+enRHAAO56jwkU969S27GkHCgpVgH2yF7sSLd6uucxpv3NotCYDusCYoH0YCFRQ7THUC6HR9FcqW/upHkYAhfgNbpxjXW6ncWlVVU9st13AHe4L6JYSMo5ekY0oumMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275405; c=relaxed/simple;
	bh=3PAh386lsFzRd2+pj0MuZRZ316W9kq+bKf+SpdXebTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=TXkNSU8QuT6Y+lvxZUAYJIjN1pq6rLcgUbsI+04/EnCgdxhNtNW2Le0HK3izCyXYdYz1sZnMgBcgLVCNPcJj9eh4mqymUhs/1CsKIT69l2t3OZXi2siyd8SP0tfQCYYCogWV0b/ywCmIfEzi6SYzcM33rADi5Vxr9JaAAlIReYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 40B06601091D8;
	Mon,  4 Aug 2025 10:43:17 +0800 (CST)
Message-ID: <5dd480e9-5fd6-463c-8d4f-255fd063c4f4@nfschina.com>
Date: Mon, 4 Aug 2025 10:43:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/slub: avoid accessing metadata when pointer is
 invalid in object_err()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <aJAcjcBOcKCDPwjY@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/8/4 10:35, Harry Yoo 写道:
> On Mon, Aug 04, 2025 at 11:25:23AM +0900, Harry Yoo wrote:
>> On Mon, Aug 04, 2025 at 09:46:25AM +0800, Li Qiong wrote:
>>> object_err() reports details of an object for further debugging, such as
>>> the freelist pointer, redzone, etc. However, if the pointer is invalid,
>>> attempting to access object metadata can lead to a crash since it does
>>> not point to a valid object.
>>>
>>> In case check_valid_pointer() returns false for the pointer, only print
>>> the pointer value and skip accessing metadata.
>>>
>>> Fixes: 81819f0fc828 ("SLUB core")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>>> ---
>>> v2:
>>> - rephrase the commit message, add comment for object_err().
>>> v3:
>>> - check object pointer in object_err().
>>> v4:
>>> - restore changes in alloc_consistency_checks().
>>> v5:
>>> - rephrase message, fix code style.
>>> ---
>> Looks good to me,
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>
>> -- 
>> Cheers,
>> Harry / Hyeonggon
>>
>>>  mm/slub.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 31e11ef256f9..b3eff1476c85 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -1104,7 +1104,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>>>  		return;
>>>  
>>>  	slab_bug(s, reason);
>>> -	print_trailer(s, slab, object);
>>> +	if (!check_valid_pointer(s, slab, object)) {
> Wait, hold on. check_valid_pointer() returns true when object == NULL.
> the condition should be (!object || !check_valid_pointer())?

You're right, i ignored this situation.


>
>>> +		print_slab_info(slab);
>>> +		pr_err("Invalid pointer 0x%p\n", object);
>>> +	} else {
>>> +		print_trailer(s, slab, object);
>>> +	}
>>>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>>>  
>>>  	WARN_ON(1);
>>> -- 
>>> 2.30.2


