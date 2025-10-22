Return-Path: <stable+bounces-188925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C8BFAD05
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A0584D92
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F14302745;
	Wed, 22 Oct 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRxCzfRy"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF23019C4
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120550; cv=none; b=qB8D1KtPQRRqSPKjY3/JC0P2wfmvJnXvMsBYQTOj92ocyfU0YRg3GNeua9RP38m2h4Tb1Z5LW4UA8f+90JB8bBTLRps3B5zyQGuM1oMDPpPgJHdmDCuS2nAtrA4pq2NQwZqtf0PvSSvZcYUbMuTuDaERHcYXrJGLpilKz0a6Nzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120550; c=relaxed/simple;
	bh=RsP5RrPvtPbyQEE6lSIsb/kLdVzTRaNk8Als0dqrf5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAYxhQbkfovt/I3p52pSJvIPcfoyX3fyfAou5qIzv7JztAdCtlTKeQTjCPsBWlqntQfbSDzrbeX+7ATw0vlFXKWbnFzk1ugCge6VYsvKnhiwD9bp4KaGP4xzNtHVfi0IbFO4ENQyc11xvCteEs3GzXLZTiNjs/LK+uQ5bguccvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRxCzfRy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761120533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXVMbOIfSgQPYb3Rv158n4rxfH8lc3g8IYzbeXhIsuI=;
	b=NRxCzfRyDKrdrdCaeEz+qFuxY+6mWedZ/EXzT2J6s/POmGvSXZAGbnlUgsNtnTl47Ga/OO
	b6B2Fm3BVsBLOscecU8WMG97uCmjhWlLx5E5dnGA+3LGGUHnDkLj05Aq+hQFHMClFMlTYL
	dbv3F7ZkGGuImW6ZIQJefaUyIOy6afk=
Date: Wed, 22 Oct 2025 16:08:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Content-Language: en-US
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <2025102230-scoured-levitator-a530@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2025102230-scoured-levitator-a530@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 22/10/25 15:40, Greg KH wrote:
> On Wed, Oct 22, 2025 at 01:51:38PM +0800, Leon Hwang wrote:
>> Fix the build error:
>>
>> map_hugetlb.c: In function 'main':
>> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
>>    79 |         hugepage_size = default_huge_page_size();
>>       |                         ^~~~~~~~~~~~~~~~~~~~~~
>> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
>> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
>>
>> According to the latest selftests, 'default_huge_page_size' has been
>> moved to 'vm_util.c'. So fix the error by the same way.
>>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/testing/selftests/vm/Makefile      |  1 +
>>  tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
>>  tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
>>  tools/testing/selftests/vm/vm_util.h     |  1 +
>>  4 files changed, 23 insertions(+), 24 deletions(-)
> 
> 
> What commit id does this fix?  And again, why not just take the original

Let me check which commit introduced the fix.

> commits instead?

I agree that taking the original commits would be preferable.

However, it might involve quite a few patches to backport, which could
be a bit of work.

If the backport turns out to be too complex, I think it’s acceptable to
leave the build error as-is for now.

Thanks,
Leon

> 
> thanks,
> 
> greg k-h


