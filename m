Return-Path: <stable+bounces-254305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKgfAdd8FWpEVwcAu9opvQ
	(envelope-from <stable+bounces-254305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64C5D4817
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36EC9305B032
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61D3DDDA0;
	Tue, 26 May 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HGMzteVU"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB53DD87B;
	Tue, 26 May 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792793; cv=none; b=PGjJd+WtBE5nSo2YFWeKQC8a+9V8Upnfuud74gVIBSCyC+YrtsY5ZZel8lBfisWzeNwTRdFIjwZk+LLOrYpPdUKmpdvcSlcpXcLUwR8rT5DeVc5xhO8W3CF0QOcIaOJd0Ihe/ABG4IrKh9TqJi14jYykKTnJgrRRoYZIRSXVgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792793; c=relaxed/simple;
	bh=7M+onpYw8gLR5tR7barcD4nPQYwq2SNr0FO6Bsz6Zo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C5/L153ApBt96jbec7fGuW+Otff2HX7i2bDl76JYzbvjn57YOVSvwC+6zb8+CP41z1CL8t1xNi5tGSI9YfhvrM1a5UShS0wSsW68wKZ6qpwI77xEqTWNJVnTpUnEm4hbKG2XxS2w7QJyToQ3+8243MW0BinA2jeWzdu90z4vDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HGMzteVU; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ov+rk9L2rw1E2R4gtvgCjNGl58mgqEUWPTlCjYTIzck=;
	b=HGMzteVURZvXY0Lo5+tM/YJAMN/SM92qEo06iaTeyF0bMi9LIB6LPweODVqAj0R6vbVUKedov
	ZP1/+lZ60NO7M1qO0C7HmvC6n0xo7aRH70TfFDY+HAE8282ym1oIZDBfKDyDf0A35tY01RLq4qv
	MrxoF/lL3mNSrNIZx9H8Pfc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gPqCM13y2zKm4N;
	Tue, 26 May 2026 18:45:19 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id AA11A4056A;
	Tue, 26 May 2026 18:53:06 +0800 (CST)
Received: from [10.174.179.248] (10.174.179.248) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 18:53:05 +0800
Message-ID: <65570a39-9738-44db-bd05-837b9e54faf7@huawei.com>
Date: Tue, 26 May 2026 18:53:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: update file PUD counter before
 folio_put()
To: Lorenzo Stoakes <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Dan Williams <djbw@kernel.org>, Alistair Popple
	<apopple@nvidia.com>, <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260526101355.1984244-1-yintirui@huawei.com>
 <ahV1WCxlXhOKfO_S@lucifer>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <ahV1WCxlXhOKfO_S@lucifer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-254305-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yintirui@huawei.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A64C5D4817
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/2026 6:47 PM, Lorenzo Stoakes wrote:
> You sent this twice :)
>
> On Tue, May 26, 2026 at 06:13:55PM +0800, Yin Tirui wrote:
>> __split_huge_pud_locked() updates the file/shmem RSS counter after
>> dropping the PUD mapping's folio reference. If folio_put() drops the
>> last reference, mm_counter_file() can later read freed folio state via
>> folio_test_swapbacked().
>>
>> Move the counter update before folio_put().
>>
>> Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> Patch looks sane to me, so:
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>
> There seems to be an identical problem in __split_huge_pmd_locked() - could you
> do the same fix there?

I have already sent it as another separate patch.

https://lore.kernel.org/linux-mm/20260526101337.1984081-1-yintirui@huawei.com/T/#u

>
> Thanks, Lorenzo
>
>> ---
>>   mm/huge_memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a5f4a48b7b77..9832ee910d5e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3027,9 +3027,9 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>   	if (!folio_test_referenced(folio) && pud_young(old_pud))
>>   		folio_set_referenced(folio);
>>   	folio_remove_rmap_pud(folio, page, vma);
>> -	folio_put(folio);
>>   	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
>>   		-HPAGE_PUD_NR);
>> +	folio_put(folio);
>>   }
>>
>>   void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
>> --
>> 2.43.0
>>
-- 
Yin Tirui


