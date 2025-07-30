Return-Path: <stable+bounces-165200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7CB15AC2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7830616664B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCE43169;
	Wed, 30 Jul 2025 08:36:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DBCAC12B94;
	Wed, 30 Jul 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864616; cv=none; b=p0iAMgHzFhSw6wJmd4KzN1J4s5JLeS9jX799m4G7apUHlUuQjv2ZPbYNAUWavEWhpHVVRQM9BqGgmIlqfpuB/Lf5/DBMeGWSW8IlHNYeywPksEkQUtDTTcsTAZPEhwe3SbCvGrwkIq6huH62FN2F+cdgxJ3LGJm3xfkU1uEW6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864616; c=relaxed/simple;
	bh=yS7jmUVHtW+OYqy+MmzP+5FmK5X3aid7WjwurKzBX6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=mTOACgGcIw5Gv5uHaHsSXDBrUiCnJPBptAqZAMWaMwxhHk9Xm41mlqgbsw6pEYN94YGwZaART4OwuxPOW7P81pYBCCcqgzffof7LDBWz2qPzITo6OlAUetPxjrG+2B/XaN3bVHzXK7SLfrWbyEXnDgiJsTXJHe53EeXnBGajIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7133C602F9058;
	Wed, 30 Jul 2025 16:36:45 +0800 (CST)
Message-ID: <8e9fb1b0-8da9-48aa-ac2c-ac4634ba5f7b@nfschina.com>
Date: Wed, 30 Jul 2025 16:36:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: slub: avoid deref of free pointer in sanity checks
 if object is invalid
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <aImn9eytstNbfODq@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/30 13:04, Harry Yoo 写道:
> On Wed, Jul 30, 2025 at 09:46:09AM +0800, liqiong wrote:
>> 在 2025/7/29 21:41, Harry Yoo 写道:
>>> On Tue, Jul 29, 2025 at 04:14:55PM +0800, Li Qiong wrote:
>>>> Fixes: bb192ed9aa71 ("mm/slub: Convert most struct page to struct slab by spatch")
>>> As Vlastimil mentioned in previous version, this is not the first commit
>>> that introduced this problem.
> Please don't forget to update Fixes: tag :)

It seems that it's the first commit:    Fixes: 81819f0fc828 ("SLUB core"  )


>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>>>> ---
>>>> v2:
>>>> - rephrase the commit message, add comment for object_err().
>>>> v3:
>>>> - check object pointer in object_err().
>>>> ---
>>>>  mm/slub.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 31e11ef256f9..d3abae5a2193 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>>>>  		return;
>>>>  
>>>>  	slab_bug(s, reason);
>>>> -	print_trailer(s, slab, object);
>>>> +	if (!check_valid_pointer(s, slab, object)) {
>>>> +		print_slab_info(slab);
>>>> +		pr_err("invalid object 0x%p\n", object);
>>> Can we just handle this inside print_trailer() because that's the function
>>> that prints the object's free pointer, metadata, etc.?
>> Maybe it's clearer ,  if  object pointer being invalid, don't enter print_trailer()，
>> print_trailer() prints  valid object.
> You're probably right. No strong opinion.
> object_err() is the only user anyway.
>
>>>> +	} else
>>>> +		print_trailer(s, slab, object);
>>>>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>>>>  
>>>>  	WARN_ON(1);
>>>> @@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>>>>  		return 0;
>>>>  
>>>>  	if (!check_valid_pointer(s, slab, object)) {
>>>> -		object_err(s, slab, object, "Freelist Pointer check fails");
>>>> +		slab_err(s, slab, "Freelist Pointer(0x%p) check fails", object);
>>>>  		return 0;
>>> Do we really need this hunk after making object_err() resiliant
>>> against wild pointers?
>> That's the origin issue,   it may be  inappropriate to use object_err(), if check_valid_pointer being false.
> That was the original issue, but you're making it not crash even if
> with bad pointers are passed?

Make sense, fix in object_err(),  it wouldn't  crash and print the message.

>
>>>>  	}


