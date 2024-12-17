Return-Path: <stable+bounces-104413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F79F40E3
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A3E7A1A54
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A713B2B6;
	Tue, 17 Dec 2024 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hukVWBXR"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D418035;
	Tue, 17 Dec 2024 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402932; cv=none; b=q6UGmg2Y13FCqNKWOzy1dNvx5RQc0lchGPfvMbAidV+wNAhB/WyI2VQB6PTBeghSVSPhOFP+ahkOEWTr/K4pjFUMkFi6Mp6CT0W8AGxAlDXCgQMrwJnSmtVfwwBcEjWVUYsZ7JVgYFgxcGw9GQ7Td2tAyK4+gZEoBYvJXO4fnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402932; c=relaxed/simple;
	bh=IO1xjhgU+FfmY/Vym4aESi6rCs43Z6y4dWYDCX8wdmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB/ifZr/9YCMUETHpqKb64cc6kjdqpfDn/WWI+wZKXb2+E+Vra4YNz/qAvP6SNXu9Fn6msjUKjYAtkLegYSMaZDJXu0XuWEnwmDL8wJjWM/2qvet6wf9dlyutsv6VAvdRyYuuSpVBzkZGHU1IYbiVkefNJbdEDjS8PJ4wUUBqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hukVWBXR; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734402925; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VfhzARcc9uued7slDxaklm2CNSXGlycRCAO6rIZO6hg=;
	b=hukVWBXRAIRSnbqH8EIw3Wo5VEARgL4OMGMpYmfEzvGYt5iGHMqb62+3iMrn+YwbE7wvVQImBbdF/VH7AD8CyzueLuNN2WawY1AzF5fq6naisSBWv/XjfBz3IGnJxFGx5pFGH2DBDjDjUNgaiQvQrq7hBo3UIWySFhr1daxmUjg=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLguzw5_1734402924 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 10:35:25 +0800
Message-ID: <78586900-a5bc-4377-8fb9-f322f2028310@linux.alibaba.com>
Date: Tue, 17 Dec 2024 10:35:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734350044-12928-1-git-send-email-yangge1116@126.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1734350044-12928-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/16 19:54, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> in __compaction_suitable()") allow compaction to proceed when free
> pages required for compaction reside in the CMA pageblocks, it's
> possible that __compaction_suitable() always returns true, and in
> some cases, it's not acceptable.
> 
> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> of memory. I have configured 16GB of CMA memory on each NUMA node,
> and starting a 32GB virtual machine with device passthrough is
> extremely slow, taking almost an hour.
> 
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA
> node, watermark for order-0 always be met for compaction, so
> __compaction_suitable() always returns true, even if the node is
> unable to allocate non-CMA memory for the virtual machine.
> 
> For costly allocations, because __compaction_suitable() always
> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> place, resulting in excessively long virtual machine startup times.
> Call trace:
> __alloc_pages_slowpath
>      if (compact_result == COMPACT_SKIPPED ||
>          compact_result == COMPACT_DEFERRED)
>          goto nopage; // should exit __alloc_pages_slowpath() from here
> 
> In order to quickly fall back to remote node, we should remove
> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
> in long term GUP flow. After this fix, starting a 32GB virtual machine
> with device passthrough takes only a few seconds.
> 
> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---

I sent a follow-up fix patch[1] to update the cc->alloc_flags, and with 
that, looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

[1] 
https://lore.kernel.org/all/20241217022955.141818-1-baolin.wang@linux.alibaba.com/

