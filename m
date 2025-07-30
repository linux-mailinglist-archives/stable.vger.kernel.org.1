Return-Path: <stable+bounces-165157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C6B15708
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E75A123F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7392E62C;
	Wed, 30 Jul 2025 01:46:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6351B2E36E0;
	Wed, 30 Jul 2025 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839991; cv=none; b=Ro0/69ESQ3O42CalYFpJTLdpAz91FUsSrraCgU6gGh/pvfVSQREKFdlgHQhk6in6g2pkMnYFeKoSXr2HsxDROqeBx6VCbWvOBr5Mb5LLc4vBPKm6OnTJgdWOcmEWQk6cu1x/MlUyOUGVjCigyc7Do438WQVrPMtugp1NHhUWAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839991; c=relaxed/simple;
	bh=ixuFqC5gUdt9/G6HV1zdtifv6cLTz89LDVT7XjDz3M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=JY/MvIInDfcka/PXOyiyjJK8Cirl7TrxwcSESFKccaazUd7nAyBMcJq4Zr68pR338NAXTLXOaJfZmgSk8y8YjqmkzNtWAq9t8xG9iB3H0VZAEzdKCGw5oBGSbhfmBCxImNWOonQddxHpZ6iIIpiFOMsCbG4vjwiK834LlxpKAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id A1D576018E413;
	Wed, 30 Jul 2025 09:46:09 +0800 (CST)
Message-ID: <b8ed1a62-79bd-4c86-a951-80b128223f19@nfschina.com>
Date: Wed, 30 Jul 2025 09:46:09 +0800
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
In-Reply-To: <aIjPlvRyRttUDAow@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/29 21:41, Harry Yoo 写道:
> On Tue, Jul 29, 2025 at 04:14:55PM +0800, Li Qiong wrote:
>> For debugging, object_err() prints free pointer of the object.
>> However, if check_valid_pointer() returns false for a object,
>> dereferncing `object + s->offset` can lead to a crash. Therefore,
>> print the object's address in such cases.
> As the code changed a bit, I think the commit message could better reflect
> what this patch actually does.
Yes.

>
>> Fixes: bb192ed9aa71 ("mm/slub: Convert most struct page to struct slab by spatch")
> As Vlastimil mentioned in previous version, this is not the first commit
> that introduced this problem.
>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> ---
>> v2:
>> - rephrase the commit message, add comment for object_err().
>> v3:
>> - check object pointer in object_err().
>> ---
>>  mm/slub.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 31e11ef256f9..d3abae5a2193 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>>  		return;
>>  
>>  	slab_bug(s, reason);
>> -	print_trailer(s, slab, object);
>> +	if (!check_valid_pointer(s, slab, object)) {
>> +		print_slab_info(slab);
>> +		pr_err("invalid object 0x%p\n", object);
> Can we just handle this inside print_trailer() because that's the function
> that prints the object's free pointer, metadata, etc.?
Maybe it's clearer ,  if  object pointer being invalid, don't enter print_trailer()，
print_trailer() prints  valid object.

>
> Also, the message should start with a capital letter.
>
> and "invalid object" sounds misleading because it's the pointer
> that is invalid. Perhaps simply "Invalid pointer 0x%p\n"?
> (What would be the most comprehensive message here? :P)

Make sense,   will change it.
>
>> +	} else
>> +		print_trailer(s, slab, object);
>>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>>  
>>  	WARN_ON(1);
>> @@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>>  		return 0;
>>  
>>  	if (!check_valid_pointer(s, slab, object)) {
>> -		object_err(s, slab, object, "Freelist Pointer check fails");
>> +		slab_err(s, slab, "Freelist Pointer(0x%p) check fails", object);
>>  		return 0;
> Do we really need this hunk after making object_err() resiliant
> against wild pointers?

That's the origin issue,   it may be  inappropriate to use object_err(), if check_valid_pointer being false.

>
>>  	}


