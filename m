Return-Path: <stable+bounces-185572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522DBD7352
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 05:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D88A54E5DB6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 03:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF224468D;
	Tue, 14 Oct 2025 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SO7R+w7Q"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FB17A30A
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413757; cv=none; b=GlyF0cb8xYJIHtzjmB6oShc8tacl1nTAUWVs52/pEhDr75KjaRfYzeCgziKvDU6yQTl4N5+c5GKKev3E03SuIH9RRm/wlzmsD2H3/qV0shZaKhFgXvdRsHihreHbe8+2tLabBEVzd9OVg9iIgpGPZ+gdztC3GJT/q/1U/rKaTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413757; c=relaxed/simple;
	bh=YAcyXEgI+hXldoYFlpGXIvC109KWm3hpmHpiPV7nrs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiQq9mYI0ORxhtKxcnW/pwWwPNuRS2tTe3UQTzuQc1iA0H318HTrS9OZHqun7VNGVfM4XiNwl0sAzxNUzu/4JGPgWa0nKSldJJIg1QRcbUX2obzO8AM89WnJ5kKC6eVqfCR5ZuSAkaeGdGsB4eBa/+znHj0jLawkgu3UZZZhZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SO7R+w7Q; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760413746; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WVB1k0iyALQBn8mrDij0TlFOM8IGUTNYDz3MNRZQY6A=;
	b=SO7R+w7Q1VT2676pryDMpMswxjN4ChJbOtfzynMvczpZsnjU6G9CFQTa9uvDCCjIw9NgbdyTNcLSYz5Tpk2vAevMJ/khRaarkiPUAEFz+DbaWYcbPh5Ffdf6EW4nB1fDM/YdEV3vhsYd7F17T4WYUsc7+AAvguNcMNbYJmNZzy8=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqAD6FT_1760413744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 11:49:04 +0800
Message-ID: <51b210a5-3967-45d1-a081-465b2c5f0fd1@linux.alibaba.com>
Date: Tue, 14 Oct 2025 11:49:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/2 09:38, Wei Yang wrote:
> We add pmd folio into ds_queue on the first page fault in
> __do_huge_pmd_anonymous_page(), so that we can split it in case of
> memory pressure. This should be the same for a pmd folio during wp
> page fault.
> 
> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
> to add it to ds_queue, which means system may not reclaim enough memory
> in case of memory pressure even the pmd folio is under used.
> 
> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
> folio installation consistent.
> 
> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: <stable@vger.kernel.org>
> 
> ---

Nice catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

