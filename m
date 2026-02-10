Return-Path: <stable+bounces-215588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HuWNFW+YimkvMQAAu9opvQ
	(envelope-from <stable+bounces-215588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:31:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C01164AF
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235B0302D5D4
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215852765C4;
	Tue, 10 Feb 2026 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H966aqLn"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD121EB9E1;
	Tue, 10 Feb 2026 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690664; cv=none; b=m3BsKrRmuB5T3yEWTNHL9Tix+WERstPuLTubVbUi4i2X2uKm/qzTynoZJN6xrPy9AbHh6fPUQNJx5dnKWsVCotrVyKe2DDSnX791SUvKQuztWJc0GfV02vX4H4mupaUr1E/JnmnxsNWaYucidQpMpNQS6GRpI8BZQ9zaRl/KaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690664; c=relaxed/simple;
	bh=t6wf/Zstas2cDk7L5NOaYIHeVFaN7bvNx3DSyxLaCFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXbeLcFT0Fyn+YqILqPy567vub5NdfPe3h5SlqUwwGTaSQ7YOK1FPhKS+w1RhDjkcsgQdncMEAAkefWvXQk78zp7SJaC1FX3o5wp6ur6a5xli7JltTQE3ApCI68xdGc2uwcM1E8Kz3eszpM6vTLk1HpCcE63KFvJJBR9UTOLv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H966aqLn; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770690652; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=X204tj98l8Xz4PuAgzHG5WPMc/+SwoCgN6960bpJKFk=;
	b=H966aqLnBigm7ngCcS9cTs4aO6QLts5CHEkrWgxdxzS8+kE82YxXvmOL0EvX6BV56XxOgfx8/leRHyiVYkrfRJwPnsPpLAh+1qqf1y3A5LFyzSwm96RF4IJb9fxdf21+e3emnpr43Nz3mRlJxiBX36hVjpo0aDzXbHoXUO+ojTI=
Received: from 30.74.144.109(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WyxNktA_1770690331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Feb 2026 10:25:32 +0800
Message-ID: <42cc23b4-4fd9-4286-8090-371cee180687@linux.alibaba.com>
Date: Tue, 10 Feb 2026 10:25:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hughd@google.com,
 chrisl@kernel.org, ryncsn@gmail.com, stable@vger.kernel.org,
 willy@infradead.org
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <0BC1D792-80CA-4E60-AEA0-187F73BD4723@nvidia.com>
 <bc0b6d03-4309-463d-a112-aae57cee335d@kernel.org>
 <22431471-b569-4ade-9881-387debada00b@kernel.org>
 <91F2E741-5473-4D34-ADA1-C9E6EDCBF5E0@nvidia.com>
 <546b200d-5b70-4db4-99f1-f50f6a343c10@kernel.org>
 <3E055DAD-647A-456B-9230-4DD2574D4E8E@nvidia.com>
 <4a759288-baf9-4fe6-9d16-034edf6615f0@kernel.org>
 <72534BCC-2581-4BFA-B3BC-2CC6FF1B1E7A@nvidia.com>
 <e69270cf-dac1-448c-ace8-3f789e5cdc6e@linux.alibaba.com>
 <71370B54-A462-4F72-AF82-8E076AF112FC@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <71370B54-A462-4F72-AF82-8E076AF112FC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215588-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kvack.org,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A66C01164AF
X-Rspamd-Action: no action



On 2/10/26 10:12 AM, Zi Yan wrote:
> On 9 Feb 2026, at 20:20, Baolin Wang wrote:
> 
>> On 2/10/26 3:42 AM, Zi Yan wrote:
>>> On 9 Feb 2026, at 14:39, David Hildenbrand (Arm) wrote:
>>>
>>>> On 2/9/26 18:44, Zi Yan wrote:
>>>>> On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:
>>>>>
>>>>>> On 2/9/26 17:33, Zi Yan wrote:
>>>>>>>
>>>>>>>
>>>>>>> I agree. Silently fixing non zero ->private just moves the work/responsibility
>>>>>>> from users to core mm. They could do better. :)
>>>>>>>
>>>>>>> We can have a patch or multiple patches to fix users do not zero ->private
>>>>>>> when freeing a page and add the patch below.
>>>>>>
>>>>>> Do we know roughly which ones don't zero it out?
>>>>>
>>>>> So far based on [1], I found:
>>>>>
>>>>> 1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (overlapping
>>>>> with private);
>>
>> After Kairui’s series [1], the shmem part looks good to me. As we no longer skip the swapcache now, we shouldn’t clear the ->swap.val of a swapcache folio if failed to swap-in.
> 
> What do you mean by "after Kairui's series[1]"? Can you elaborate a little bit more?

Sure. This patch [2] in Kairui's series will never skip the swapcache, 
which means the shmem folio we’re trying to swap-in must be in the 
swapcache.

[2] 
https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/T/#me242d9f77d2caa126124afd5a7731113e8f0346e

> For the diff below, does the "folio_put(folio)" have different outcomes based on
> skip_swapcache? Only if skip_swapcache is true, "folio_put(folio)" frees the folio?

Please check the latest mm-stable branch. The skip_swapcache related 
logic has been removed by Kairui’s series [1].

> diff --git a/mm/shmem.c b/mm/shmem.c
> index ec6c01378e9d..546e193ef993 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   failed_nolock:
>          if (skip_swapcache)
>                  swapcache_clear(si, folio->swap, folio_nr_pages(folio));
> -       if (folio)
> +       if (folio) {
> +               folio->swap.val = 0;
>                  folio_put(folio);
> +       }
>          put_swap_device(si);
> 
>          return error;

Without Kairui's series, this change is incorrect. Yes, only if 
skip_swapcache is true, the "folio_put(folio)" frees the folio. 
Otherwise the folio is in the swapcache, and we will not free it.

>> [1]https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/T/#mcba8a32e1021dc28ce1e824c9d042dca316a30d7

