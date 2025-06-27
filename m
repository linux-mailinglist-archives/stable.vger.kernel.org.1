Return-Path: <stable+bounces-158739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31FAEAFF3
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 09:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF501760FC
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0421C16A;
	Fri, 27 Jun 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/S9FkV1"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB219ABC2
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008567; cv=none; b=kquMXd63RN3NwDI3sSyX1HMnFr++ppLeVAKE/3NqjpSVvzLCJuU/icnjriJOxyK3zRg+2xMQG2WNzx/RFRMtU4waJJrPtx8H7XMp82m3gcmIdrXtYPonNIES4t0WnALbBKUv4//9JKc1h1LSic0bVK8juzDIAkf+C1638ngoEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008567; c=relaxed/simple;
	bh=rA+y5NpRXe9kGcVuR99+0+fM6zcY4gHnctZTjGOOKS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FESXvJe+SXg8ByPJ5gMrXrLhY2TUXATGiF4U+Bii268dPrA2aX6rvHWJqxU3OBcXUhCfV1ZGODNIOyOWrTe7AC40mg00PKk7vIVHMuoHYQ7a1+NlkKuiRIvPeO5XYupofcNzaWc4mib57NSLdfynCwbNzFZwL5Gz52Jq+urx5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/S9FkV1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1d39b66e-4009-4143-a8fa-5d876bc1f7e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751008550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YlWsvrV7BaACfyKv597+qNsvY3pISsv0aYbyAd91Ns=;
	b=b/S9FkV17dZyBU9gyIoqvCZ9lEWKMXK/izhpXtTf2yF3lzMVVnGX5YDWIEAMOyw+JsnWYy
	ZS/rlXdv+yGYpIGe7LtEkl5IvH7HC+w5BVIfUfUlYeVeQFfEQNv2+ilmf3FIPf6WpIp1B5
	GZr8YjBl/kjDa13f8vVty5wzMBiXjgI=
Date: Fri, 27 Jun 2025 15:15:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, mingzhe.yang@ly.com, stable@vger.kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <20250627062319.84936-1-lance.yang@linux.dev>
 <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
 <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/6/27 14:55, Barry Song wrote:
> On Fri, Jun 27, 2025 at 6:52 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Fri, Jun 27, 2025 at 6:23 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
>>> can read past the end of a PTE table if a large folio is mapped starting at
>>> the last entry of that table. It would be quite rare in practice, as
>>> MADV_FREE typically splits the large folio ;)
>>>
>>> So let's fix the potential out-of-bounds read by refactoring the logic into
>>> a new helper, folio_unmap_pte_batch().
>>>
>>> The new helper now correctly calculates the safe number of pages to scan by
>>> limiting the operation to the boundaries of the current VMA and the PTE
>>> table.
>>>
>>> In addition, the "all-or-nothing" batching restriction is removed to
>>> support partial batches. The reference counting is also cleaned up to use
>>> folio_put_refs().
>>>
>>> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
>>>
>>
>> What about ?
>>
>> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
>> may read past the end of a PTE table when a large folio spans across two PMDs,
>> particularly after being remapped with mremap(). This patch fixes the
>> potential out-of-bounds access by capping the batch at vm_end and the PMD
>> boundary.
>>
>> It also refactors the logic into a new helper, folio_unmap_pte_batch(),
>> which supports batching between 1 and folio_nr_pages. This improves code
>> clarity. Note that such cases are rare in practice, as MADV_FREE typically
>> splits large folios.
> 
> Sorry, I meant that MADV_FREE typically splits large folios if the specified
> range doesn't cover the entire folio.

Hmm... I got it wrong as well :( It's the partial coverage that triggers 
the split.

how about this revised version:

As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
may read past the end of a PTE table when a large folio spans across two
PMDs, particularly after being remapped with mremap(). This patch fixes
the potential out-of-bounds access by capping the batch at vm_end and the
PMD boundary.

It also refactors the logic into a new helper, folio_unmap_pte_batch(),
which supports batching between 1 and folio_nr_pages. This improves code
clarity. Note that such boundary-straddling cases are rare in practice, as
MADV_FREE will typically split a large folio if the advice range does not
cover the entire folio.


