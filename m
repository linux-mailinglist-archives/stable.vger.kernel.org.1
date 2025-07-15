Return-Path: <stable+bounces-161942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD80B05156
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 07:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33BB3AB342
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C372D3229;
	Tue, 15 Jul 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kcppz3+1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34932255F24;
	Tue, 15 Jul 2025 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559017; cv=none; b=ogWY4POa+bDjTJ5w2LSq5aGaUy1Aa99/Yt9MwLlQlmQPN32qL0SCSneDZwWVDj/wglesixAkhJwgPqZE4/OXVA+GlC88AEnjXKei2UGwOx7ZKL55trN4Ya2rZXW61w0YOjkwBRzcvxfZrSEtrX2TLxrtlHiQ47B6KAAsPseBeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559017; c=relaxed/simple;
	bh=DF3Z4TOQv7VenxVCrrz12/o3nauXZ9mahkVgcCe6yN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmvxssakJjgSX5SaI3hd1gcDEzHjhHdr64jz2Gyn4E42zrF17DYL14odE74zTCrm1x/GOxBpVRSXXXCRmh8UxMmKDlK0Pb6tRMIlsvz8oZ9o42bBNnWnM9nfGUwA4tQHpijQ5mCo785Z2/wcjMDW2pFjMV+G1nGFqhA/4eixVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kcppz3+1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752559016; x=1784095016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DF3Z4TOQv7VenxVCrrz12/o3nauXZ9mahkVgcCe6yN8=;
  b=Kcppz3+1/9/DXSXCZolpbRrba/o+2dzzcv7/rRy+cIZIIpEYYP1OX/UB
   xpj1DDHqZayifGlYRPHaCsWoadEvPeGVeBFCqctCFSTaVbn/ilobmZOjb
   9EOtCsJPtgJp5V/vs8FCan1O3FTCGIA/ELn1hsGD2bfGJ1sTmX1k5gWCV
   Wl1RrGHHkf/5c9C0TGfxehAHYiXRQVJ0Eu3uOFDMZI59KhRzh0YaRiXsg
   hGsVs8Pyx+oS+SH6/lFvHXzNvB6/Aumi/CrKyoeKxlT/R7i6ohvIaCTA7
   ZLJ2gqQMWq633+NN9xmTM8qU0YkSOaMpD47vf0CsY50vGUfp0pfo9zaiU
   A==;
X-CSE-ConnectionGUID: 0kNb2dk5QsSP73DZ407ECw==
X-CSE-MsgGUID: uf4hE3+8Qg2UXhDaxLlfUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65027412"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="65027412"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 22:56:55 -0700
X-CSE-ConnectionGUID: OZ2ylrF3RXCTtBBI+cphmQ==
X-CSE-MsgGUID: hVrIGg11QVuckiLR6+NMLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="194287973"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 22:56:51 -0700
Message-ID: <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
Date: Tue, 15 Jul 2025 13:55:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 16:32, Peter Zijlstra wrote:
> On Fri, Jul 11, 2025 at 11:00:06AM +0800, Baolu Lu wrote:
>> Hi Peter Z,
>>
>> On 7/10/25 21:54, Peter Zijlstra wrote:
>>> On Wed, Jul 09, 2025 at 02:28:00PM +0800, Lu Baolu wrote:
>>>> The vmalloc() and vfree() functions manage virtually contiguous, but not
>>>> necessarily physically contiguous, kernel memory regions. When vfree()
>>>> unmaps such a region, it tears down the associated kernel page table
>>>> entries and frees the physical pages.
>>>>
>>>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
>>>> shares and walks the CPU's page tables. Architectures like x86 share
>>>> static kernel address mappings across all user page tables, allowing the
>>>> IOMMU to access the kernel portion of these tables.
>>>>
>>>> Modern IOMMUs often cache page table entries to optimize walk performance,
>>>> even for intermediate page table levels. If kernel page table mappings are
>>>> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
>>>> entries, Use-After-Free (UAF) vulnerability condition arises. If these
>>>> freed page table pages are reallocated for a different purpose, potentially
>>>> by an attacker, the IOMMU could misinterpret the new data as valid page
>>>> table entries. This allows the IOMMU to walk into attacker-controlled
>>>> memory, leading to arbitrary physical memory DMA access or privilege
>>>> escalation.
>>>>
>>>> To mitigate this, introduce a new iommu interface to flush IOMMU caches
>>>> and fence pending page table walks when kernel page mappings are updated.
>>>> This interface should be invoked from architecture-specific code that
>>>> manages combined user and kernel page tables.
>>>
>>> I must say I liked the kPTI based idea better. Having to iterate and
>>> invalidate an unspecified number of IOMMUs from non-preemptible context
>>> seems 'unfortunate'.
>>
>> The cache invalidation path in IOMMU drivers is already critical and
>> operates within a non-preemptible context. This approach is, in fact,
>> already utilized for user-space page table updates since the beginning
>> of SVA support.
> 
> OK, fair enough I suppose. What kind of delays are we talking about
> here? The fact that you basically have a unbounded list of IOMMUs
> (although in practise I suppose it is limited by the amount of GPUs and
> other fancy stuff you can stick in your machine) does slightly worry me.

Yes, the mm (struct mm of processes that are bound to devices) list is
an unbounded list and can theoretically grow indefinitely. This results
in an unpredictable critical region.

I am considering whether this could be relaxed a bit if we manage the
IOMMU device list that is used for SVA. The number of IOMMU hardware
units in a system is limited and bounded, which might make the critical
region deterministic.

If that's reasonable, we can do it like this (compiled but not tested):

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..9ed3be2ffaeb 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,6 +9,14 @@

  #include "iommu-priv.h"

+struct sva_iommu_device_item {
+	struct iommu_device *iommu;
+	unsigned int users;
+	struct list_head node;
+};
+
+static LIST_HEAD(sva_iommu_device_list);
+static DEFINE_SPINLOCK(sva_iommu_device_lock);
  static DEFINE_MUTEX(iommu_sva_lock);
  static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
  						   struct mm_struct *mm);
@@ -52,6 +60,71 @@ static struct iommu_mm_data 
*iommu_alloc_mm_data(struct mm_struct *mm, struct de
  	return iommu_mm;
  }

+static int iommu_sva_add_iommu_device(struct device *dev)
+{
+	struct iommu_device *iommu = dev->iommu->iommu_dev;
+	struct sva_iommu_device_item *iter;
+
+	struct sva_iommu_device_item *new __free(kfree) =
+		kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->iommu = iommu;
+	new->users = 1;
+
+	guard(spinlock_irqsave)(&sva_iommu_device_lock);
+	list_for_each_entry(iter, &sva_iommu_device_list, node) {
+		if (iter->iommu == iommu) {
+			iter->users++;
+			return 0;
+		}
+	}
+	list_add(&no_free_ptr(new)->node, &sva_iommu_device_list);
+
+	return 0;
+}
+
+static void iommu_sva_remove_iommu_device(struct device *dev)
+{
+	struct iommu_device *iommu = dev->iommu->iommu_dev;
+	struct sva_iommu_device_item *iter, *tmp;
+
+	guard(spinlock_irqsave)(&sva_iommu_device_lock);
+	list_for_each_entry_safe(iter, tmp, &sva_iommu_device_list, node) {
+		if (iter->iommu != iommu)
+			continue;
+
+		if (--iter->users == 0) {
+			list_del(&iter->node);
+			kfree(iter);
+		}
+		break;
+	}
+}
+
+static int iommu_sva_attach_device(struct iommu_domain *domain, struct 
device *dev,
+				   ioasid_t pasid, struct iommu_attach_handle *handle)
+{
+	int ret;
+
+	ret = iommu_sva_add_iommu_device(dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_attach_device_pasid(domain, dev, pasid, handle);
+	if (ret)
+		iommu_sva_remove_iommu_device(dev);
+
+	return ret;
+}
+
+static void iommu_sva_detach_device(struct iommu_domain *domain,
+				    struct device *dev, ioasid_t pasid)
+{
+	iommu_detach_device_pasid(domain, dev, pasid);
+	iommu_sva_remove_iommu_device(dev);
+}
+
  /**
   * iommu_sva_bind_device() - Bind a process address space to a device
   * @dev: the device
@@ -112,8 +185,7 @@ struct iommu_sva *iommu_sva_bind_device(struct 
device *dev, struct mm_struct *mm

  	/* Search for an existing domain. */
  	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-						&handle->handle);
+		ret = iommu_sva_attach_device(domain, dev, iommu_mm->pasid, 
&handle->handle);
  		if (!ret) {
  			domain->users++;
  			goto out;
@@ -127,8 +199,7 @@ struct iommu_sva *iommu_sva_bind_device(struct 
device *dev, struct mm_struct *mm
  		goto out_free_handle;
  	}

-	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-					&handle->handle);
+	ret = iommu_sva_attach_device(domain, dev, iommu_mm->pasid, 
&handle->handle);
  	if (ret)
  		goto out_free_domain;
  	domain->users = 1;
@@ -170,7 +241,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
  		return;
  	}

-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
+	iommu_sva_detach_device(domain, dev, iommu_mm->pasid);
  	if (--domain->users == 0) {
  		list_del(&domain->next);
  		iommu_domain_free(domain);
@@ -312,3 +383,15 @@ static struct iommu_domain 
*iommu_sva_domain_alloc(struct device *dev,

  	return domain;
  }
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct sva_iommu_device_item *item;
+
+	guard(spinlock_irqsave)(&sva_iommu_device_lock);
+	list_for_each_entry(item, &sva_iommu_device_list, node) {
+		if (!item->iommu->ops->paging_cache_invalidate)
+			continue;
+		item->iommu->ops->paging_cache_invalidate(item->iommu, start, end);
+	}
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..f3716200cc09 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -595,6 +595,8 @@ iommu_copy_struct_from_full_user_array(void *kdst, 
size_t kdst_entry_size,
   *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
   *		- IOMMU_DOMAIN_DMA: must use a dma domain
   *		- 0: use the default setting
+ * @paging_cache_invalidate: Invalidate paging structure caches that store
+ * 			     intermediate levels of the page table.
   * @default_domain_ops: the default ops for domains
   * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU 
instance behind
   *                the @dev, as the set of virtualization resources 
shared/passed
@@ -654,6 +656,9 @@ struct iommu_ops {

  	int (*def_domain_type)(struct device *dev);

+	void (*paging_cache_invalidate)(struct iommu_device *dev,
+					unsigned long start, unsigned long end);
+
  	struct iommufd_viommu *(*viommu_alloc)(
  		struct device *dev, struct iommu_domain *parent_domain,
  		struct iommufd_ctx *ictx, unsigned int viommu_type);
@@ -1571,6 +1576,7 @@ struct iommu_sva *iommu_sva_bind_device(struct 
device *dev,
  					struct mm_struct *mm);
  void iommu_sva_unbind_device(struct iommu_sva *handle);
  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long 
end);
  #else
  static inline struct iommu_sva *
  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1595,6 +1601,7 @@ static inline u32 mm_get_enqcmd_pasid(struct 
mm_struct *mm)
  }

  static inline void mm_pasid_drop(struct mm_struct *mm) {}
+static inline void iommu_sva_invalidate_kva_range(unsigned long start, 
unsigned long end) {}
  #endif /* CONFIG_IOMMU_SVA */

  #ifdef CONFIG_IOMMU_IOPF
-- 
2.43.0

> At some point the low latency folks are going to come hunting you down.
> Do you have a plan on how to deal with this; or are we throwing up our
> hands an say, the hardware sucks, deal with it?
> 

Thanks,
baolu

