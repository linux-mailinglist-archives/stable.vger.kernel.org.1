Return-Path: <stable+bounces-166522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C311EB1ABFA
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCFA3B5C58
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2A18BBB9;
	Tue,  5 Aug 2025 01:24:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 21E6C2F37;
	Tue,  5 Aug 2025 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357063; cv=none; b=annX21WU4Rvsn9IjyEDuZAWrfHh1lJ0kmqG3lWlhfUo4f9MpsuriatnFk+WinbU+jI7K6oFC6OKo7etc9dN+XOeTZKqtWEMQXV208qnMJzmUX0cyw+dseMtX1llNp2sAb5eFZkl1RhALuIqlkJHJrsTZaRawoRDnRU8FJwOPH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357063; c=relaxed/simple;
	bh=tIS40T/6nFmGK166q5PWr0xwuJJh77GmAOdS3EVK6pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=VmcGKJ8NWJYVmy6NXszzipi2sP9beInyShBvzLjpdg0ThqERjpZLVZ5u17Tm8SZx4SeEfbmryq3Ct7Em3wGILXWEkXeKw0JIr7dxnRJzRCD8Xa+dcXlZuaP5NRgc/+Y523OAA2zs4446jMGsRm5Jx+TXXt3BOfuDioAalGJ1ktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 39AE66028AE12;
	Tue,  5 Aug 2025 09:24:05 +0800 (CST)
Message-ID: <bc6f3549-2e92-4132-8e2d-bed027d156f9@nfschina.com>
Date: Tue, 5 Aug 2025 09:24:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/slub: avoid accessing metadata when pointer is
 invalid in object_err()
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Language: en-US
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <a5fb57c6-fc32-4014-a4ef-200b41ddd877@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/8/4 23:19, Vlastimil Babka 写道:
> On 8/4/25 04:57, Li Qiong wrote:
>> object_err() reports details of an object for further debugging, such as
>> the freelist pointer, redzone, etc. However, if the pointer is invalid,
>> attempting to access object metadata can lead to a crash since it does
>> not point to a valid object.
>>
>> In case the pointer is NULL or check_valid_pointer() returns false for
>> the pointer, only print the pointer value and skip accessing metadata.
> We should explain that this is not theoretical so justify the stable cc, so
> I would add:
>
> One known path to the crash is when alloc_consistency_checks() determines
> the pointer to the allocated object is invalid beause of a freelist
> corruption, and calls object_err() to report it. The debug code should
> report and handle the corruption gracefully and not crash in the process.
>
> If you agree, I can do this when picking up the patch after merge window, no
> need to resend.

Agree, thanks.


>> Fixes: 81819f0fc828 ("SLUB core")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> ---
>> v2:
>> - rephrase the commit message, add comment for object_err().
>> v3:
>> - check object pointer in object_err().
>> v4:
>> - restore changes in alloc_consistency_checks().
>> v5:
>> - rephrase message, fix code style.
>> v6:
>> - add checking 'object' if NULL.
>> ---
>>  mm/slub.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 31e11ef256f9..972cf2bb2ee6 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1104,7 +1104,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>>  		return;
>>  
>>  	slab_bug(s, reason);
>> -	print_trailer(s, slab, object);
>> +	if (!object || !check_valid_pointer(s, slab, object)) {
>> +		print_slab_info(slab);
>> +		pr_err("Invalid pointer 0x%p\n", object);
>> +	} else {
>> +		print_trailer(s, slab, object);
>> +	}
>>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>>  
>>  	WARN_ON(1);


