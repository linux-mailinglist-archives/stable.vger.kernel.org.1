Return-Path: <stable+bounces-188994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2571BFC312
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E796357D34
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040934887A;
	Wed, 22 Oct 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vTfD15OZ"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3934886C
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140120; cv=none; b=tr7rDtdQZ7pbCUq+4tZgmaGT7h/ghTCMB3TwKEIe+4qF9AOKy1NTeNkxDYZlZahAHpTsnb9xsj02TgPfWjI5yffiA/CzmN2etRgemLeXkhFg1qqdbtK5P/fKVsWlRMZ62+byIZZhIJ5ge2tekcNkZvrnMOZwC58jB/B0TfLR2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140120; c=relaxed/simple;
	bh=sdqYQHfzS9nTZ+Wid1WYCsfbD04MJZqLiL4+oME/ubw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiP3yojnOu2syZw6UetDlcr7bqKAhir/X0fyGGsY3a839H0Bya1lv/f1HLLY5S9hkpymSFiki1pGcRR0hraaJp1E92onr5TU6sJjhAp8t3FJx7rAVD7c3Fc0Y3orN4Br6FtqSaNUYSE8MRaebxAaBDos4oARHcKr5FWsQ9Uxi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vTfD15OZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70f8c6a1-cbb5-4a62-99aa-69b2f06bece2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761140115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vprp6Sprv0j2U+VrHGt+HSmR/LJpQhtuztUHl5jW5rg=;
	b=vTfD15OZRMChVTcmQwOa7WBPKEdewiypH04vaDg6n1f79HcjPA/w9i6+/tDMH9/S32NHSS
	Yh169jpPTrGI5oBZvykiFZ0EL4Dqa1+Gg58Z6AH2dxBYjfx3syekoh2IEWNaXEvPUVkw9A
	z10CB584zYXDjOdt9GfYv+kUpZwXinQ=
Date: Wed, 22 Oct 2025 21:34:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <2025102230-scoured-levitator-a530@gregkh>
 <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>
 <2025102210-detection-blurred-8332@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2025102210-detection-blurred-8332@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/22 16:20, Greg KH wrote:
> On Wed, Oct 22, 2025 at 04:08:45PM +0800, Leon Hwang wrote:
>>
>>
>> On 22/10/25 15:40, Greg KH wrote:
>>> On Wed, Oct 22, 2025 at 01:51:38PM +0800, Leon Hwang wrote:
>>>> Fix the build error:
>>>>
>>>> map_hugetlb.c: In function 'main':
>>>> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
>>>>    79 |         hugepage_size = default_huge_page_size();
>>>>       |                         ^~~~~~~~~~~~~~~~~~~~~~
>>>> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
>>>> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
>>>>
>>>> According to the latest selftests, 'default_huge_page_size' has been
>>>> moved to 'vm_util.c'. So fix the error by the same way.
>>>>
>>>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>  tools/testing/selftests/vm/Makefile      |  1 +
>>>>  tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
>>>>  tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
>>>>  tools/testing/selftests/vm/vm_util.h     |  1 +
>>>>  4 files changed, 23 insertions(+), 24 deletions(-)
>>>
>>>
>>> What commit id does this fix?  And again, why not just take the original
>>
>> Let me check which commit introduced the fix.
>>
>>> commits instead?
>>
>> I agree that taking the original commits would be preferable.
>>
>> However, it might involve quite a few patches to backport, which could
>> be a bit of work.
>
> We can easily take lots of patches, don't worry about the quantity.  But
> it would be good to figure out what caused this to break here, and not
> in other branches.
>

Hi Greg,

After checking with 'git blame map_hugetlb.c', the issue was introduced
by commit a584c7734a4d (“selftests: mm: fix map_hugetlb failure on 64K
page size systems”), which corresponds to upstream commit 91b80cc5b39f.
This change appears to have caused the build error in the 6.1.y tree.

Comparing several stable trees shows the following:

- 6.0.y: not backported*
- 6.1.y: backported
- 6.2.y: not backported*
- 6.3.y: not backported*
- 6.4.y: not backported*
- 6.5.y: not backported*
- 6.6.y: backported
- 6.7.y: backported

Given this, it might be preferable to revert a584c7734a4d in 6.1.y for
consistency with the other stable trees (6.0.y, 6.2–6.5.y).

WDYT?

Thanks,
Leon

