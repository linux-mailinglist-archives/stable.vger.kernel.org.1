Return-Path: <stable+bounces-105132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCA9F5FBD
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935761889EF2
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF4159596;
	Wed, 18 Dec 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rjj/+jC3"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E455FEED;
	Wed, 18 Dec 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508683; cv=none; b=GiZ9qWOK38zaEVRzPUKKPvuc7V56B8eWed6RFmE7QyNjFZGE6VUti//csJ+jxu+ktQvccHaOlsP7szTjsljqZq1GkM1+GxT8S2h9DCaTcwoTIyMUUjshXlc18I7IQ2hHQfSn9JwJB+ggIF7bjikqyK3X5E4+khFKihQJH+pHobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508683; c=relaxed/simple;
	bh=R8oL9HPGBNzLNd0sw+7+qI9wZ/5kfDeg58n1Gbv53z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjcAiG8MbL6OTwNiWN3eUx/DKH54DpQrEhYZpRbCuAQGYZbZ+HqMO0dq434vfcGCSDuwdtLhgn2FsmEZFLvGmbsRih3cZG2MXs3kTUnfijd5eN45o2VmjQVg2SWYGlj/cYh/tKpYKnj5SMx74Srkj1PsV92fkYyO4GvJHdiLxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rjj/+jC3; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734508677; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=73PG00jNypyVuZ+U9GLfUx2Y2h80nJwkdo7O7xfYAZE=;
	b=rjj/+jC3hdhKefUrY/LcXaRNOf8uNZg+IduxJAkgLk/vBSFg/tB37VnB815VnCsVBjQMuHrk575jr3nMzCr6fPq0t2f9D2e2KKufIIm9gbQFP6Tew3RQf7v2MVk/rUkoXIQAx4at7sQVLSzIcrf+M7ACq8MDgd+QJ0Inx95t8z0=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLloubY_1734508675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:57:56 +0800
Message-ID: <ded3d2bf-650e-4ddc-b2be-d6faddeb3037@linux.alibaba.com>
Date: Wed, 18 Dec 2024 15:57:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] mm, compaction: don't use ALLOC_CMA for unmovable
 allocations
To: Johannes Weiner <hannes@cmpxchg.org>, yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734436004-1212-1-git-send-email-yangge1116@126.com>
 <20241217155551.GA37530@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241217155551.GA37530@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/17 23:55, Johannes Weiner wrote:
> Hello Yangge,
> 
> On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>> in __compaction_suitable()") allow compaction to proceed when free
>> pages required for compaction reside in the CMA pageblocks, it's
>> possible that __compaction_suitable() always returns true, and in
>> some cases, it's not acceptable.
>>
>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>> and starting a 32GB virtual machine with device passthrough is
>> extremely slow, taking almost an hour.
>>
>> During the start-up of the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>> Long term GUP cannot allocate memory from CMA area, so a maximum
>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>> machine memory. Since there is 16G of free CMA memory on the NUMA
>> node, watermark for order-0 always be met for compaction, so
>> __compaction_suitable() always returns true, even if the node is
>> unable to allocate non-CMA memory for the virtual machine.
>>
>> For costly allocations, because __compaction_suitable() always
>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>> place, resulting in excessively long virtual machine startup times.
>> Call trace:
>> __alloc_pages_slowpath
>>      if (compact_result == COMPACT_SKIPPED ||
>>          compact_result == COMPACT_DEFERRED)
>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>
>> Other unmovable alloctions, like dma_buf, which can be large in a
>> Linux system, are also unable to allocate memory from CMA, and these
>> allocations suffer from the same problems described above. In order
>> to quickly fall back to remote node, we should remove ALLOC_CMA both
>> in __compaction_suitable() and __isolate_free_page() for unmovable
>> alloctions. After this fix, starting a 32GB virtual machine with
>> device passthrough takes only a few seconds.
> 
> The symptom is obviously bad, but I don't understand this fix.
> 
> The reason we do ALLOC_CMA is that, even for unmovable allocations,
> you can create space in non-CMA space by moving migratable pages over
> to CMA space. This is not a property we want to lose. But I also don't

Good point. I missed that and I need to withdraw my reviewed tag. Thanks.

