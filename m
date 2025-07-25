Return-Path: <stable+bounces-164719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FEB1180C
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 07:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF40E3BD670
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A023BCFD;
	Fri, 25 Jul 2025 05:47:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 33B061DE892;
	Fri, 25 Jul 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422436; cv=none; b=Ru3VqvRBpTaoOVJs0DqBQmW4Ht+c8hMvVlZi2FD7COb12e3MKM4iKytbbob9Smn+LcpgtKv6z/JwBUN6euPO6ZSUpFdrSvZpChbdYgegQ+ZXjIZM+S6XUpknk1WG+mlsOFejvuJzX4kUrR81ekZpomBYrxJlrBoYqpS9yS9Wp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422436; c=relaxed/simple;
	bh=XJfEVs3oguGmS/m4FpfN0MIFvfh2kHxQ1/rwU0KKeE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=bcPfp0dAFsZrml9sBfde2gZynrDNsUbqyB9DsSNfxUMnTJiXAou4xRk9thY4lhrtwTabY7QrsMBwvqjJAZ2ZRDQM/TeALsf+8tFFjoJyQUAMEMpKqrtmz0flGfX7eODpnhOZZgyotE1eTzI9P/W3K/rd6FkS/8P3sGq+tq0fwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 6D7426018CCAA;
	Fri, 25 Jul 2025 13:47:00 +0800 (CST)
Message-ID: <ef73ea4c-c081-4c64-aab3-a60ec71f03bc@nfschina.com>
Date: Fri, 25 Jul 2025 13:46:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: slub: fix dereference invalid pointer in
 alloc_consistency_checks
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <aIMBppTQ-ON7RM8y@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/7/25 12:01, Harry Yoo 写道:
> On Fri, Jul 25, 2025 at 10:48:54AM +0800, Li Qiong wrote:
>> In object_err(), need dereference the 'object' pointer, it may cause
>> a invalid pointer fault. Use slab_err() instead.
> Hi Li Qiong, this patch makes sense to me.
> But I'd suggest to rephrase it a little bit, like:
>
> mm/slab: avoid deref of free pointer in sanity checks if object is invalid
>
> For debugging purposes, object_err() prints free pointer of the object.
> However, if check_valid_pointer() returns false for object,
> `object + s->offset` is also invalid and dereferncing it can lead to a
> crash. Therefore, avoid dereferencing it and only print the object's
> address in such cases.

Thanks, I will send a v2 patch.


>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> Which commit introduced this problem?
> A Fixes: tag is needed to determine which -stable versions it should be
> backported to.
>
> And to backport MM patches to -stable, you need to explicitly add
> 'Cc: stable@vger.kernel.org' to the patch.
>
>> ---
>>  mm/slub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 31e11ef256f9..3a2e57e2e2d7 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1587,7 +1587,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>>  		return 0;
>>  
>>  	if (!check_valid_pointer(s, slab, object)) {
>> -		object_err(s, slab, object, "Freelist Pointer check fails");
>> +		slab_err(s, slab, "Freelist Pointer (0x%p) check fails", object);
> Can this be
> slab_err(s, slab, "Invalid object pointer 0x%p", object);
> to align with free_consistency_checks()?




>
>>  		return 0;
>>  	}
>>  
> It might be worth adding a comment in object_err() stating that it should
> only be called when check_valid_pointer() returns true for object, and
> a WARN_ON_ONCE(!check_valid_pointer(s, slab, object)) to catch incorrect
> usages?




