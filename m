Return-Path: <stable+bounces-200765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B00CB4A91
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 05:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87AE03000B26
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 04:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C529D26E;
	Thu, 11 Dec 2025 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YL6A5QO8"
X-Original-To: stable@vger.kernel.org
Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039D1F2380
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425685; cv=none; b=lmewr0mXNGnmXaIS9ck9/fkHHQKzFkKgdsJFYB7hyskam9k8u02aondVqIa7w8UBHAs43cc8LiggdwPbZ8cpq8UL2SVjhcIepdqDPZiibThpUIjg1zuJZEc0Tarl1wGB1OsF0OfAktNfeEMqSp2uIHq1eBHtUv20lbvbiv0XiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425685; c=relaxed/simple;
	bh=uhu92BLENLWaXhi4GZrcTRvbZ04OJs9xOzHiG2udBWc=;
	h=From:To:Cc:Content-Type:Message-Id:Mime-Version:Subject:Date; b=ptopMBF6YJaPr7rcQOMvKBsVzxA0WmViG0kmCnkumXcoogptOzM5MxVq16hSYJ1R/gPcPhBHon88Rc9KHFS39gXs+g8UAtq7N0RKpqC9qYEhC+ONuF2rpyIQcGV19vbeeuQBE7WQyoTfuAZ4hLJkGihuJS+ytlKJL4rETPtWNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YL6A5QO8; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765425638; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4a0bdH18Z7oN7kDT0wFFmJrB1RRo4gjm1L4d0kfvD6M=;
 b=YL6A5QO8LhuUCEYhgs8F8FM24rAU/AGqvMqRuNNqkAL0Oj4ad98lYtsM3/ihKR+vRe2I2h
 Hcw1kTRSg4Vvt9d6Gb0/KiuRLdECYQu5wSGhvSUS/bhvXWznr0bE6AToKXTKQK6RymC5cw
 oS2JSm5b588WwPcx+xiAJfMfd42kETmMbx4e6UpSWjS/HsmVbwXJvdYabNZGVNNKytavmd
 xElpBcRRuzyE/5w/6BnPg6eNOYIqUAH+m0yHvPjFLJvPJ3ZB04Vp755YtIFJMv/NLa36tR
 afRCAbGqoIBjWFo8idqh9rIY1NGqRkA5QBgfU1jpFgM8SF+C7U7Jz4vUk2FnvA==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Message-Id: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+2693a41e4+cf53de+vger.kernel.org+guojinhui.liam@bytedance.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device
Date: Thu, 11 Dec 2025 11:59:44 +0800
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>

Hi, all

We hit hard-lockups when the Intel IOMMU waits indefinitely for an ATS invalidation
that cannot complete, especially under GDR high-load conditions.

1. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
   non-scalable mode. Two scenarios exist: NIC link-down with an explicit link-down
   event and link-down without any event.

   a) NIC link-down with an explicit link-dow event.
      Call Trace:
       qi_submit_sync
       qi_flush_dev_iotlb
       __context_flush_dev_iotlb.part.0
       domain_context_clear_one_cb
       pci_for_each_dma_alias
       device_block_translation
       blocking_domain_attach_dev
       iommu_deinit_device
       __iommu_group_remove_device
       iommu_release_device
       iommu_bus_notifier
       blocking_notifier_call_chain
       bus_notify
       device_del
       pci_remove_bus_device
       pci_stop_and_remove_bus_device
       pciehp_unconfigure_device
       pciehp_disable_slot
       pciehp_handle_presence_or_link_change
       pciehp_ist

   b) NIC link-down without an event - hard-lock on VM destroy.
      Call Trace:
       qi_submit_sync
       qi_flush_dev_iotlb
       __context_flush_dev_iotlb.part.0
       domain_context_clear_one_cb
       pci_for_each_dma_alias
       device_block_translation
       blocking_domain_attach_dev
       __iommu_attach_device
       __iommu_device_set_domain
       __iommu_group_set_domain_internal
       iommu_detach_group
       vfio_iommu_type1_detach_group
       vfio_group_detach_container
       vfio_group_fops_release
       __fput

2. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
   scalable mode; NIC link-down without an event hard-locks on VM destroy.
   Call Trace:
    qi_submit_sync
    qi_flush_dev_iotlb
    intel_pasid_tear_down_entry
    device_block_translation
    blocking_domain_attach_dev
    __iommu_attach_device
    __iommu_device_set_domain
    __iommu_group_set_domain_internal
    iommu_detach_group
    vfio_iommu_type1_detach_group
    vfio_group_detach_container
    vfio_group_fops_release
    __fput

Fix both issues with two patches:
1. Skip dev-IOTLB flush for inaccessible devices in __context_flush_dev_iotlb() using
   pci_device_is_present().
2. Use pci_device_is_present() instead of pci_dev_is_disconnected() to decide when to
   skip ATS invalidation in devtlb_invalidation_with_pasid().

Best Regards,
Jinhui

---
v1: https://lore.kernel.org/all/20251210171431.1589-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Baolu Lu)
 - Simplify the pci_device_is_present() check in __context_flush_dev_iotlb().
 - Add Cc: stable@vger.kernel.org to both patches.

Jinhui Guo (2):
  iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
    scalable mode
  iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
    scalable mode

 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.20.1

