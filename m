Return-Path: <stable+bounces-183164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F49BB6335
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 09:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D776619C3745
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 07:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F425EF90;
	Fri,  3 Oct 2025 07:55:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C32475CB
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478114; cv=none; b=mGoDGYamb52UE+YkghXPM5+yxg+dDvJ5fkr70nzNmpjlWcE2YLfdn4J37xZ5OE7z9Xl1FlTC+phVygNdwwi5W6JX+ibSTZVtxFrspoW9INdiroGt526Oxweuy19LFSceblHC3OYdfdrbQcAcVLa7xLHTodGPvNcjs6dGpnewZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478114; c=relaxed/simple;
	bh=ZUqhVd7vcsVc1CWlD0NUVC7kP7EMWB7/YDrJRnN/yu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWOrgfsZkbXBiRjzTxuH6Jab8TB3/1WlzCOp/IBjCC0XGo8taioD+fwy570Mo36KS0SgJYC+6eyucDPilsSyHckv98VjpycXrOjoUIVbIiBWBbtED12ciO3KQP5K2A5LB5x0tRem1xXWkht+doJXqSG77PhyfpUt7SVxzWBbsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD081655;
	Fri,  3 Oct 2025 00:54:59 -0700 (PDT)
Received: from [10.163.66.2] (unknown [10.163.66.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226B33F5A1;
	Fri,  3 Oct 2025 00:55:01 -0700 (PDT)
Message-ID: <36c12f7e-b55c-4f8c-998f-ba7a99a050aa@arm.com>
Date: Fri, 3 Oct 2025 13:24:57 +0530
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
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/10/25 7:08 am, Wei Yang wrote:
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

Thanks!

Reviewed-by: Dev Jain <dev.jain@arm.com>


