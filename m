Return-Path: <stable+bounces-204618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 831FFCF2C77
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5229A304EDA5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347732E22BE;
	Mon,  5 Jan 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRcueNK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7E32D0E6
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605411; cv=none; b=bk9qXecPHeM8bNni9bwlMSyL4KgY/SLJ1GtnRVh1HDFKhXbUNYzrIChGtd6LYrA6tNRCXvd47OAKtX/gD9tSdnr3zMdJReMX0g/l0ec7ClaE/b988oLgjLr9CI1pKRwsMWIhI/AF+mO2e87yUbhO8ug2TWACzE5UrAKvYMMgBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605411; c=relaxed/simple;
	bh=wV1iBX1ry6R8p5MdgJdlfNk8/8n4CN4ApOMyQruChvY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JM0X3Zkklrykljn1PZeh14FI4PJ6bs3CUaMhqHzSe/pG2ZAokKvvdmSys/DX+7IZGri0mlP7xtw+MMcLZ7b0BOsd0hPj/09MIkl5u/WJa5IfFnZBxvcN3MxomvN4g7ixHsEUYWxAs9v8aaOSHMl6fEfmHA9MSsl5Mf1igm2W2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRcueNK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75827C2BC87;
	Mon,  5 Jan 2026 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605408;
	bh=wV1iBX1ry6R8p5MdgJdlfNk8/8n4CN4ApOMyQruChvY=;
	h=Subject:To:Cc:From:Date:From;
	b=cRcueNK74qOf/FcegL1lbrfpHLVzVC0pp6MB2Rh4iumuWZ7DnRYWcqo/sUZhmtEW0
	 pwV8W/gBl8eG0ykW3AqsKDvYJ2KJWDioPnwLNnLQ64CkatrHIXT7h5x0e0H4DPngpA
	 ika+8p+Sz5q5eAu4aH4blv6Cdf9AdklnHLOXYg2c=
Subject: FAILED: patch "[PATCH] iommu: disable SVA when CONFIG_X86 is set" failed to apply to 5.15-stable tree
To: baolu.lu@linux.intel.com,akpm@linux-foundation.org,apopple@nvidia.com,bp@alien8.de,dave.hansen@intel.com,david@redhat.com,jannh@google.com,jean-philippe@linaro.org,jgg@nvidia.com,joro@8bytes.org,kevin.tian@intel.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,luto@kernel.org,mhocko@kernel.org,mingo@redhat.com,peterz@infradead.org,robin.murphy@arm.com,rppt@kernel.org,stable@vger.kernel.org,tglx@linutronix.de,urezki@gmail.com,vasant.hegde@amd.com,vbabka@suse.cz,vinicius.gomes@intel.com,will@kernel.org,willy@infradead.org,yi1.lai@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:30:03 +0100
Message-ID: <2026010503-tweezers-junction-c503@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 72f98ef9a4be30d2a60136dd6faee376f780d06c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010503-tweezers-junction-c503@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72f98ef9a4be30d2a60136dd6faee376f780d06c Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Wed, 22 Oct 2025 16:26:27 +0800
Subject: [PATCH] iommu: disable SVA when CONFIG_X86 is set

Patch series "Fix stale IOTLB entries for kernel address space", v7.

This proposes a fix for a security vulnerability related to IOMMU Shared
Virtual Addressing (SVA).  In an SVA context, an IOMMU can cache kernel
page table entries.  When a kernel page table page is freed and
reallocated for another purpose, the IOMMU might still hold stale,
incorrect entries.  This can be exploited to cause a use-after-free or
write-after-free condition, potentially leading to privilege escalation or
data corruption.

This solution introduces a deferred freeing mechanism for kernel page
table pages, which provides a safe window to notify the IOMMU to
invalidate its caches before the page is reused.


This patch (of 8):

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables.  The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table.  Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings.  This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

Use-After-Free (UAF) and Write-After-Free (WAF) conditions arise when
kernel page table pages are freed and later reallocated.  The IOMMU could
misinterpret the new data as valid page table entries.  The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation.  This is also a
Write-After-Free issue, as the IOMMU will potentially continue to write
Accessed and Dirty bits to the freed memory while attempting to walk the
stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings.  However, the IOMMU will still walk kernel-only page tables all
the way down to the leaf entries, where it realizes the mapping is for the
kernel and errors out.  This means the IOMMU still caches these
intermediate page table entries, making the described vulnerability a real
concern.

Disable SVA on x86 architecture until the IOMMU can receive notification
to flush the paging cache before freeing the CPU kernel page table pages.

Link: https://lkml.kernel.org/r/20251022082635.2462433-1-baolu.lu@linux.intel.com
Link: https://lkml.kernel.org/r/20251022082635.2462433-2-baolu.lu@linux.intel.com
Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murohy <robin.murphy@arm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Yi Lai <yi1.lai@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

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


