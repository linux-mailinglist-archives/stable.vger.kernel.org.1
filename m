Return-Path: <stable+bounces-215580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE/pEtCHimk1LgAAu9opvQ
	(envelope-from <stable+bounces-215580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:20:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CF115F4C
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D121A300C596
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F6246783;
	Tue, 10 Feb 2026 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C6QebXQ6"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7E7262A;
	Tue, 10 Feb 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686411; cv=none; b=oVQDh34F1FujBSCmCnC1eo6v6M3SD3TYhpe2HLBgG2YpDJPjCAbYTNNluRBnmZjq3vIVSDfLzAzU7ZunXbxVlLWHFlkjSjvOd2Dljz2KAPMBFxUe0r3tCbMcRqdcLn0mHslh885FgVWknO3UmBC9NHwRXn0HJV7ZWSPlktIv/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686411; c=relaxed/simple;
	bh=KQDMo6KDE8bY9om2BIOOP4wysK63lPkaFonb63R/kcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtj0VcXBxq7JEfpiPk8/MwWiwkyRbgLGd6wDItO1U3ZZTcdKndBHEms4qD6UJ2a7Dnx8+/f9Et2fTOqbSi0s5m4AKau6Wl89eEUGs99wPDLD2qjMDNtD4WhebKt4STQ0kKGjjZw1iiwRAJHWAqH7G//aPoPklQA5L37qVh84+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C6QebXQ6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770686406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cN85VGoE32TAaBeuh7trX4TvvDZc5iL4HxTbBbIYYCc=;
	b=C6QebXQ6fNMh2yrMD4tomXEcyMyuk52FjdP05uOIaIM8FejLaa2ZMRSL/XyBG1b3O0mxf+Z69GRFUiDRRJy/U+838tEfbWsxnE9w42Ho46agRXLnilyb4B+s0+JWGqPx0sN4NutrXRwCZGdhNtkKhqMuOOK6LZBAaxltxf2BQJo=
Received: from 30.74.144.109(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wyx9JBp_1770686404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Feb 2026 09:20:05 +0800
Message-ID: <e69270cf-dac1-448c-ace8-3f789e5cdc6e@linux.alibaba.com>
Date: Tue, 10 Feb 2026 09:20:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
To: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <72534BCC-2581-4BFA-B3BC-2CC6FF1B1E7A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215580-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C20CF115F4C
X-Rspamd-Action: no action



On 2/10/26 3:42 AM, Zi Yan wrote:
> On 9 Feb 2026, at 14:39, David Hildenbrand (Arm) wrote:
> 
>> On 2/9/26 18:44, Zi Yan wrote:
>>> On 9 Feb 2026, at 12:36, David Hildenbrand (Arm) wrote:
>>>
>>>> On 2/9/26 17:33, Zi Yan wrote:
>>>>>
>>>>>
>>>>> I agree. Silently fixing non zero ->private just moves the work/responsibility
>>>>> from users to core mm. They could do better. :)
>>>>>
>>>>> We can have a patch or multiple patches to fix users do not zero ->private
>>>>> when freeing a page and add the patch below.
>>>>
>>>> Do we know roughly which ones don't zero it out?
>>>
>>> So far based on [1], I found:
>>>
>>> 1. shmem_swapin_folio() in mm/shmem.c does not zero ->swap.val (overlapping
>>> with private);

After Kairui’s series [1], the shmem part looks good to me. As we no 
longer skip the swapcache now, we shouldn’t clear the ->swap.val of a 
swapcache folio if failed to swap-in.

[1]https://lore.kernel.org/all/20251219195751.61328-1-ryncsn@gmail.com/T/#mcba8a32e1021dc28ce1e824c9d042dca316a30d7

>>> 2. __free_slab() in mm/slub.c does not zero ->inuse, ->objects, ->frozen
>>> (overlapping with private).
>>>
>>> Mikhail found ttm_pool_unmap_and_free() in drivers/gpu/drm/ttm/ttm_pool.c
>>> does not zero ->private, which stores page order.


