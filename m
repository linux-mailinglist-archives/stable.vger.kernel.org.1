Return-Path: <stable+bounces-208312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0DD1BFBE
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7186B300FA29
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 01:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304991FBC8E;
	Wed, 14 Jan 2026 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F06ZJOvl"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B503D3B3;
	Wed, 14 Jan 2026 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355177; cv=none; b=Fi8MDhZ9FKdxZt8wfKoWj0f3i9hj5KCbC44rwLkDmVdFegq2nO7ubivP6wm0QlfDkbQ6jNvl3oDyLWJL+J2VF9a+0+q3xFYTKlkE+zv18ht3uhy3/Va7l7MOffZG49dpYw3pL3ci+nBDhPPXTuS48LDBENJBEFFWghr+iNV3KDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355177; c=relaxed/simple;
	bh=aTA7pgDeFf3ROJ5IibL5iUMv1HiFvcV3APXLCfaXE0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE+xVsYXlT5p9IXv5YRQd6vCxrpEGr3RQRy4KJhLsILtG2xfSbIvUjSJEDpOEH9U0F8rACct0ADAva/oWYkKEnWakhRo43qQrpeG8g8rcve2K5FCWymS6qEyurg2NUJa2BKeH97YaUzwhRJ3fY159B2Yzo85AauhB/VkwD8cd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F06ZJOvl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768355166; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IydMD8wuNWInSOgTJupkde9o7rJXQ38wPrSFh8AMmlM=;
	b=F06ZJOvl2AxXfzzfceaVrU/5G9sTyZHHV/8N64vgvgEN05C5L8f7SudR3aDlTjwpExLUGKxghMQKRdX4If0YfYNYXQKynQIftekKkU7u6eUTPPs8K+RP7WbR4UndgMfAXG0HlGrvmfrHXbVUqYZFlqThgrVNZOkGhghxxZ9uoE8=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wx0Sq4r_1768355164 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 09:46:05 +0800
Message-ID: <2b87338f-d68d-4742-8b5d-c807b206830b@linux.alibaba.com>
Date: Wed, 14 Jan 2026 09:46:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
 <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com>
 <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
 <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com>
 <CAMgjq7Biq9nB_waZeWW+iJUa9Pj+paSSrke-tmnB=-3uY8k2VA@mail.gmail.com>
 <d95f9ea4-aa47-4d85-9b76-11afd0fb3ee7@linux.alibaba.com>
 <CAMgjq7DrrCx78K3uccsfpGeQfC-_+LuONSefJ+Vd+aCjyncwKw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7DrrCx78K3uccsfpGeQfC-_+LuONSefJ+Vd+aCjyncwKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/13/26 6:10 PM, Kairui Song wrote:
> On Tue, Jan 13, 2026 at 3:16 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Hi Kairui,
>>
>> Sorry for late reply.
> 
> No problem, I was also quite busy with other works :)
> 
>>
>> Yes, so I just mentioned your swapoff case.
>>
>>>> Actually, the real question is how to handle the case where a large swap
>>>> entry happens to cross the 'end' when calling shmem_truncate_range(). If
>>>> the shmem mapping stores a folio, we would split that large folio by
>>>> truncate_inode_partial_folio(). If the shmem mapping stores a large swap
>>>> entry, then as you noted, the truncation range can indeed exceed the 'end'.
>>>>
>>>> But with your change, that large swap entry would not be truncated, and
>>>> I’m not sure whether that might cause other issues. Perhaps the best
>>>> approach is to first split the large swap entry and only truncate the
>>>> swap entries within the 'end' boundary like the
>>>> truncate_inode_partial_folio() does.
>>>
>>> Right... I was thinking that the shmem_undo_range iterates the undo
>>> range twice IIUC, in the second try it will retry if shmem_free_swap
>>> returns 0:
>>>
>>> swaps_freed = shmem_free_swap(mapping, indices[i], end - indices[i], folio);
>>> if (!swaps_freed) {
>>>       /* Swap was replaced by page: retry */
>>>       index = indices[i];
>>>       break;
>>> }
>>>
>>> So I thought shmem_free_swap returning 0 is good enough. Which is not,
>>> it may cause the second loop to retry forever.
>>
>> After further investigation, I think your original fix seems to be the
>> right direction, as the second loop’s find_lock_entries() will filter
>> out large swap entries crossing the 'end' boundary. Sorry for noise.
>>
>> See the code in find_lock_entries() (Thanks to Hugh:))
>>
>>          } else {
>>                  nr = 1 << xas_get_order(&xas);
>>                  base = xas.xa_index & ~(nr - 1);
>>                  /* Omit order>0 value which begins before the start */
>>                  if (base < *start)
>>                          continue;
>>                  /* Omit order>0 value which extends beyond the end */
>>                  if (base + nr - 1 > end)
>>                          break;
>>          }
>>
>> Then the shmem_get_partial_folio() will swap-in the large swap entry and
>> split the large folio which crosses the 'end' boundary.
> 
> Right, thanks for the info.
> 
> But what about find_get_entries under whole_folios? Even though a
> large entry is splitted before that, a new large entry that crosses
> `end` could appear after that and before find_get_entries, and return
> by find_get_entries.

Yes, another corner case:(

> I think we could just skip large entries that cross `end` in the
> second loop, since if the entry exists before truncate, it must have
> been split. We can ignore newly appeared entries.

Sounds reasonable to me. Just as we don’t discard the entire folio when 
a large folio split fails by updating the 'end':

if (!truncate_inode_partial_folio(folio, lstart, lend))
	end = folio->index;

> If that's OK I can send two patches, one to ignore the large entries
> in the second loop, one to fix shmem_free_swap following your
> suggestion in this reply.

Please do. Thanks.

