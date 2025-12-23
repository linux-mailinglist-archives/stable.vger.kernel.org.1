Return-Path: <stable+bounces-203284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E710CD889B
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0171530334DC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439F322B70;
	Tue, 23 Dec 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFqHRM+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537501E2834;
	Tue, 23 Dec 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481189; cv=none; b=jjmZXZoeWs0eI/5RTHgtlToCdqnQf3WFF3px5fDtJ9vYE2WemEr9wRF5wTDk89dSaQvrkVIeZH8UnHd+eVrUZIInOC8UCOTiksnxy3dCHc9zfV51hEINACwEHStbi3U2smpDEA5Z06y8IMIZYB5r2+7gOUipJ1Y26Ow9Omq3iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481189; c=relaxed/simple;
	bh=L+jctpl8CY/Z02R3KgkzKjrbQKw1ezIptg6y1ooTjxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUxSQsEE36oxbhjnfkHO0IWpIU+fyrBDjPdw4Xy+53r8aCzsvyJ8pbsQtosVOCmbF/gpPnhTFqYdZK1g0Q8CJs2Mde+wvgzYOIfZXnYr6mbMKrC6zaliXt6IhMBi44tgKF1OyHk+YWmGMZx3I4gZePNuQ7rLz61rUppaqrPv4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFqHRM+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B4AC116B1;
	Tue, 23 Dec 2025 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766481188;
	bh=L+jctpl8CY/Z02R3KgkzKjrbQKw1ezIptg6y1ooTjxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BFqHRM+3GiKOoc+GhwMOq7LMBM8VqNTuJ4N/Bdlz8FfL8fyfvXJsEnjqxbbIse5wR
	 kenOtswGDIm6gAuikCico9w59FwPIejyy6tj6/ragC/1zcNH5T707l/TPcFkDW1XpB
	 jn6IncOKwQh5t1D7J7CfuX6F5ntk4RYRfFimak0yNkzCAt7BoPCxnNLEa0CNPrxxZ7
	 GP2Q6mLSKqJ5uIeZBwy7Zqas4Y+FKATL1gWJWlOBGvajsXsBcWwMuPWN61i+r8P1hj
	 kRNDZhSiMcy1gJFfwZ24MvMwLmjPTO+RG96lc6nYx3Wn+pvWujSRcZaiDKr9MA571i
	 hs5cM9IwTLxeQ==
Message-ID: <12032402-b541-4776-a716-c93f16ec7eca@kernel.org>
Date: Tue, 23 Dec 2025 10:13:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
To: Jane Chu <jane.chu@oracle.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
 osalvador@suse.de, linmiaohe@huawei.com, jiaqiyan@google.com,
 william.roche@oracle.com, rientjes@google.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, willy@infradead.org
References: <20251223012113.370674-1-jane.chu@oracle.com>
 <20251223012113.370674-2-jane.chu@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223012113.370674-2-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 02:21, Jane Chu wrote:
> When a hugetlb folio is being poisoned again, try_memory_failure_hugetlb()
> passed head pfn to kill_accessing_process(), that is not right.
> The precise pfn of the poisoned page should be used in order to
> determine the precise vaddr as the SIGBUS payload.
> 
> This issue has already been taken care of in the normal path, that is,
> hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
> correctly in the hugetlb repoisoning case, it's essential to inform
> VM the precise poisoned page, not the head page.
> 
> [1] https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
> [2] https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
> [3] https://lore.kernel.org/lkml/20251116013223.1557158-1-jiaqiyan@google.com/
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
> v2 -> v3:
>    incorporated suggestions from Miaohe and Matthew.
> v1 -> v2:
>    pickup R-B, add stable to cc list.

Please don't send new versions when the discussions on your old 
submissions are still going on. Makes the whole discussion hard to follow.

You asked in the old version:

"
What happens if non-head PFN of hugetlb is indicated in a SIGBUG to
QEMU?  Because, the regular path, the path via hwpoison_user_mappings()
already behave this way.

I'm not familiar with QEMU. AFAIK, the need for this patch came from our
VM/QEMU team.
"

I just took a look and I think it's ok. I remembered a discussion around 
[1] where we concluded that the kernel would always give us the first 
PFN, but essentially the whole hugetlb folio will vanish.

But in QEMU we work completely on the given vaddr, and are able to 
identify that it's a hugetlb folio through our information on memory 
mappings.

QEMU stores a list of positioned vaddrs, to remap them (e.g., 
fallocate(PUNCH_HOLE)) when restarting the VM. If we get various vaddrs 
for the same hugetlb folio we will simply try to remap a hugetlb folio 
several times, which is not a real problem. I think we discussed that 
that could get optimized as part of [1] (or follow-up versions) if ever 
required.

[1] 
https://lore.kernel.org/qemu-devel/20240910090747.2741475-1-william.roche@oracle.com/


-- 
Cheers

David

