Return-Path: <stable+bounces-164546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEFB0FF10
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733CFAA4FA4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33C1C84B2;
	Thu, 24 Jul 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp2EGqLm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790C1BF58;
	Thu, 24 Jul 2025 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326529; cv=none; b=m/ZcvS5mwige5mTQ2n9NBx00mh3mN2USZX71G9Oa/oiLGYh70wkujHet+8YuVxOtyiUC/v/eQARtmnZmniTUSnOT7lm0FwleOq0oMYX9vJXZFT+/QZm8+557c0jKKCMcqufihK0gJ5jUnRxr8Wb4rud6F0HEoL7+viudfmVcbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326529; c=relaxed/simple;
	bh=MPswY0sUn5VESBoIZJzrTD9qlzGCy9PKSH2fxpb0sMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkr6wuecHHHQM0VRmpNTVUYCuFu2idQIdlpRH2+k1AN7/PS6qqJi424UfhMoaTRMTkoOf3tf6VSsSa4G/qd9t1ZcaWazKnO0cGbxD5TnWf1ujaA785zS0LNmbwPmeZiqwbrB67T67SdbVHFp74w2BSHE4IWlEavTD0RJZhpASKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mp2EGqLm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753326528; x=1784862528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MPswY0sUn5VESBoIZJzrTD9qlzGCy9PKSH2fxpb0sMM=;
  b=Mp2EGqLm5K2qI+3urU1okM9Fx20gDpNoR1YgO4Y7kaTjn9fjOk7qJWhB
   yAfdiKy/odrAvSixLgAK9pXu1aVaVt7RpFrdBWMlJjuiqyUCNXS+4Dn98
   cVqGL6Py2jjW/vDHRMpmAqWn3fQgS2pw5eKOKxzvtlVzA1xE3/AM719bw
   YM22BLxuPdewMaDqo6hcse+vT+cxWacfrdo1n/9SEKgGBjVmn1yhZHF4b
   maeQXzc7wFXJNBe1G5vt+kA1AdJ6IB+DVW+k2wgOXE7QXfm8KlHXMLAY2
   WNDtpT09WIqetV1b7FI7LkkKSVEYUalH3apTfDZ1L+6kQASAqz21Tk+E8
   w==;
X-CSE-ConnectionGUID: mtvp2ltmSG2z23LF8634Mw==
X-CSE-MsgGUID: OZ+Zlg8SRoSL5zJwe8xqmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66697447"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66697447"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 20:08:47 -0700
X-CSE-ConnectionGUID: JYkasPmyRhmlo66qvT7cJw==
X-CSE-MsgGUID: fLgr/wueRpysOsxf+Ksd+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="190851555"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 20:08:44 -0700
Message-ID: <8470a880-3c38-43af-a7f7-fa0d815b737c@linux.intel.com>
Date: Thu, 24 Jul 2025 11:06:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 23:26, Dave Hansen wrote:
> On 7/10/25 06:22, Jason Gunthorpe wrote:
>>> Why does this matter? We flush the CPU TLB in a bunch of different ways,
>>> _especially_ when it's being done for kernel mappings. For example,
>>> __flush_tlb_all() is a non-ranged kernel flush which has a completely
>>> parallel implementation with flush_tlb_kernel_range(). Call sites that
>>> use _it_ are unaffected by the patch here.
>>>
>>> Basically, if we're only worried about vmalloc/vfree freeing page
>>> tables, then this patch is OK. If the problem is bigger than that, then
>>> we need a more comprehensive patch.
>> I think we are worried about any place that frees page tables.
> 
> The two places that come to mind are the remove_memory() code and
> __change_page_attr().
> 
> The remove_memory() gunk is in arch/x86/mm/init_64.c. It has a few sites
> that do flush_tlb_all(). Now that I'm looking at it, there look to be
> some races between freeing page tables pages and flushing the TLB. But,
> basically, if you stick to the sites in there that do flush_tlb_all()
> after free_pagetable(), you should be good.
> 
> As for the __change_page_attr() code, I think the only spot you need to
> hit is cpa_collapse_large_pages() and maybe the one in
> __split_large_page() as well.

Thank you for the guide. It appears that all paths mentioned above will
eventually call flush_tlb_all() after changing the page table. So, I can
simply put a call site in flush_tlb_all()? Something like this:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a41499dfdc3f..3b85e7d3ba44 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1479,6 +1479,8 @@ void flush_tlb_all(void)
         else
                 /* Fall back to the IPI-based invalidation. */
                 on_each_cpu(do_flush_tlb_all, NULL, 1);
+
+       iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
  }

> 
> This is all disturbingly ad-hoc, though. The remove_memory() code needs
> fixing and I'll probably go try to bring some order to the chaos in the
> process of fixing it up. But that's a separate problem than this IOMMU fun.

Yes. Please.

Thanks,
baolu

