Return-Path: <stable+bounces-188932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E952BFAE44
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04B842009C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC3309EF1;
	Wed, 22 Oct 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HO48mn1E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE130AAA9;
	Wed, 22 Oct 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121760; cv=none; b=WNU5AG+BAUydlRqjLssNj6/GAZRr1Po1jOAtOnjfAvrq3pKsxCaahNFNPeknfv0KL+c1t23lKrDQP3EdrGkNBvaLuNF/r6/cCil7B3l3E84VvtkT55ckKxO1DmSjEhf1qak0RGXubn6nggN9Y2fnW5wYfUfYNn6I2uVxutrmCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121760; c=relaxed/simple;
	bh=X8hpluMqUjHyF3NnFKeki1ZNOZ9A7wW3hfxRIst9gNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJqWRNUW2hXuzx9sihvEzkI7nkSJAd8LGKxme736+6hiw831f+UuAyXthfzuT/JF9AyZDic9lc9I6IyA7vKHHOcyBM9Y2Rd0erhadfeDU26mTfohY4Z0t0mkQ/AaFq8oB4pyeqOzjMBjZBI73wa0UTrvBI6vS9TiThvbZR3riL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HO48mn1E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121758; x=1792657758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8hpluMqUjHyF3NnFKeki1ZNOZ9A7wW3hfxRIst9gNk=;
  b=HO48mn1EaWM6bikVLYXswOm+wWf7J103gcxVuf89BePxwmBPzfryGGhY
   2rbWBd4ETjBOHyBQyJfUu+INYn8s4yuIn5EHnrdIPcooZQDmLm9SyjLge
   HdRc1l/jDECz46SOKUkKLNokuBcyZ4r6QKYkd75jOUiYAgnTOs6QAH80z
   cZww6i/czqqYexvB4gBBWukEsw8KQ54YgA7yJZZYfXWHpQp8VkurB2966
   XXr7LF27vBNOQMdC8sylTIdnTkHnUgtA/VxA6SB5aPR3xKN+An0GDR0Xs
   GeSdnv/EbyFYgR8ZZuojsjPoIy4R5U+LJ0JfStu/3yCX+90Hz+RqpUjis
   g==;
X-CSE-ConnectionGUID: Sa3ljfcdTBaBkvNaOgXIxw==
X-CSE-MsgGUID: eJKOQM1BRzGD8RkWXZTqmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74382487"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74382487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:29:17 -0700
X-CSE-ConnectionGUID: V+b1HRBlR6SJ4CzEl3BbxA==
X-CSE-MsgGUID: akeshMYnSd64ObPki9LPvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516218"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 1/8] iommu: Disable SVA when CONFIG_X86 is set
Date: Wed, 22 Oct 2025 16:26:27 +0800
Message-ID: <20251022082635.2462433-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables. The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table. Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings. This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

Use-After-Free (UAF) and Write-After-Free (WAF) conditions arise when
kernel page table pages are freed and later reallocated. The IOMMU could
misinterpret the new data as valid page table entries. The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation. This is also a Write-After-Free
issue, as the IOMMU will potentially continue to write Accessed and Dirty
bits to the freed memory while attempting to walk the stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings. However, the IOMMU will still walk kernel-only page tables
all the way down to the leaf entries, where it realizes the mapping
is for the kernel and errors out. This means the IOMMU still caches
these intermediate page table entries, making the described vulnerability
a real concern.

Disable SVA on x86 architecture until the IOMMU can receive notification
to flush the paging cache before freeing the CPU kernel page table pages.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..a0442faad952 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -77,6 +77,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
-- 
2.43.0


