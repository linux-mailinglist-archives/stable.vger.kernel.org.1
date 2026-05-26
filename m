Return-Path: <stable+bounces-254313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKL9NwWCFWoSWQcAu9opvQ
	(envelope-from <stable+bounces-254313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:20:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4C5D4C96
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B01E303C037
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3283DFC87;
	Tue, 26 May 2026 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zZzXOMz1"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA43DEAFE;
	Tue, 26 May 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794278; cv=none; b=msRNgq/pFS3fLttWywEelZ4FGM7knO6EvY0YX1K3g/o0cR4bRaB/n74h11PUsCimmyM5zGqtUhnUC+BWXGGcYNIoeXHFWkTBNW6oScuQSYeEtXkILr7IQCjfOBoevl3alaEKxgiKh3l+BpJo2qa+1e+ZQUsowwq7aJ0CKc4UDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794278; c=relaxed/simple;
	bh=hwtDOxXeD0fTzfCdaBWFswivtKHbaJIAWf0YkWXmI10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X0uC9WcQ93uhLhdXxBPN7OCOZyzdYl3XNn1ipkEx0rajbUTu6TSCGHa8+M506xqiq98ledBGkFE/juDOoOx/cf8dZ3DpuYnGE5UkypSn/TlJAJ3osvmXE2HH6sJPC+JK5VUpKYAmJWdZ+98H6CxHMuo9uM7jFZeON91z1EPKj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zZzXOMz1; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aFgQI5aMdJK6GkuCY5wGRn20esivYerd6yQfalhpU20=;
	b=zZzXOMz1lMzP33XmKHCwqjbVopQ4NjEqn8wwOaV7lLtWJ1qGNnqtzEqZy2lNRcT4Q+6ffeXrV
	xQXGCroUgRfBbFP/qtlHYO41imXKuLENmGc5IR+xLCGgRzwzf3Y0zifUqLRC/k5ZudobWU9oRp6
	M6gL5ooQ1zDoGsQyE3pTWyU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gPqlb5ZnkznTXQ;
	Tue, 26 May 2026 19:09:47 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CA0940538;
	Tue, 26 May 2026 19:17:45 +0800 (CST)
Received: from [10.174.179.248] (10.174.179.248) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 19:17:44 +0800
Message-ID: <ec937b4e-2afc-496c-b980-4d3ea70e4a31@huawei.com>
Date: Tue, 26 May 2026 19:17:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: update file PMD counter before
 folio_put()
To: Lorenzo Stoakes <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, Yang Shi
	<yang.shi@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260526101337.1984081-1-yintirui@huawei.com>
 <ahV8PuP2sg7fV_DR@lucifer>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <ahV8PuP2sg7fV_DR@lucifer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yintirui@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254313-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 50C4C5D4C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/2026 7:05 PM, Lorenzo Stoakes wrote:
> On Tue, May 26, 2026 at 06:13:37PM +0800, Yin Tirui wrote:
>> __split_huge_pmd_locked() updates the file/shmem RSS counter after
>> dropping the PMD mapping's folio reference. If folio_put() drops the
>> last reference, mm_counter_file() can later read freed folio state via
>> folio_test_swapbacked().
>>
>> Move the counter update before folio_put().
>>
>> Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
> That's an old commit :) I mean I suspect we're probably not actually ever
> dropping the folio ref to 0 here since we never had a report since ~2018.
>
> The page cache keeping a reference I guess?
>
> But doesn't mean we shouldn't fix this on principal/there being some way
> this could happen.
Yes, agreed.
>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> LGTM, so:
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Thanks!
>> ---
>>   mm/huge_memory.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0135c29a4372..a5f4a48b7b77 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3145,7 +3145,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
>>   				folio_set_referenced(folio);
>>   			folio_remove_rmap_pmd(folio, page, vma);
>> +			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>>   			folio_put(folio);
>> +			return;
> Hmm, sucks to duplicate like this, but for purposes of backport and getting
> this resolved fine, we can clean it up later.
Yes, that was my intention as well: keep this patch minimal for backport.
I will post the related refactoring patch soon.
>>   		}
>>   		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>>   		return;
>> --
>> 2.43.0
>>
> Cheers, Lorenzo
>
-- 
Yin Tirui


