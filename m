Return-Path: <stable+bounces-200764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C0CB4A8E
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 05:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CEE43010999
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 04:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850D1A0BF1;
	Thu, 11 Dec 2025 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UAlCkc1R"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412486352
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425678; cv=none; b=LAjv4R4kzgQoEH+SIqeKeVPMwwxIO/W11/bD79aWbSb3yribO0HEzxTcRi6SNg/UJC7uF9BGMIX9MKniTw727m5lWRPTEsjCsk84XrD1NNsdlNzSNoogskRMISRj2MKaXzEPPdBI4n5c+24luWsm2mQCbpmSbyiRcNfKXp7nY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425678; c=relaxed/simple;
	bh=YLYEDjr9BARQJKDs0AJ02wHXxDH/0e54bhQ5m3csN/8=;
	h=In-Reply-To:Message-Id:Content-Type:From:Date:Mime-Version:To:
	 Subject:References:Cc; b=rL8EJsmj0/hM/mq3N6fRDWlWsWV/+x2MC/u9DN4GLFDaeGXHkLA6T5B6vL0D85iHzXQF+EflhVMH/W50FVEkWXN9S6y26e3TAWhnPIwnrMl9pStxaRmR4vtBsiwOVR7ut1lxZ8/T24BZWwwbtS7WKWr6udmur2v1tAz6vLKnSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UAlCkc1R; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765425670; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Bq8ab0zHhsOjIIhAgkxl/qyhdnfVtDC5vvSoEbjEKfs=;
 b=UAlCkc1RDbWLn0ChE5aIB2QHxnWtIiEFCnvQlSZkvAIaoOd7RrnKw59sAsTdiyAMtxGxGf
 P0Qg0by+RyUA1xMilNkTirDRAlTLjx0RmmIvqvRARfDdS1LA2uNvXTb0yJKQRmE0sxuhb7
 KeZrCa7GbXScz3B4pfJvwX26Ib96OXySwjManp4MO14kKSI+K0wu3ZuBj8jR29PiNsdYPs
 ef+JoOelhlMnuH5TL4hTs8UosHZLfJ7/Sjbw2e6lmrJAGot6u2YgCXfM+koRJ6cGG1btyp
 AKwHaTInzcn40ffYyPgDyEjhbXUK9Ng/NLFbA+E7v6bWNqxL4oxlXyHb1eBw/A==
In-Reply-To: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251211035946.2071-2-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.17.1
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Thu, 11 Dec 2025 11:59:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Subject: [PATCH v2 1/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Lms-Return-Path: <lba+2693a4204+a9fcbc+vger.kernel.org+guojinhui.liam@bytedance.com>

PCIe endpoints with ATS enabled and passed through to userspace
(e.g., QEMU, DPDK) can hard-lock the host when their link drops,
either by surprise removal or by a link fault.

Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
request when device is disconnected") adds pci_dev_is_disconnected()
to devtlb_invalidation_with_pasid() so ATS invalidation is skipped
only when the device is being safely removed, but it applies only
when Intel IOMMU scalable mode is enabled.

With scalable mode disabled or unsupported, a system hard-lock
occurs when a PCIe endpoint's link drops because the Intel IOMMU
waits indefinitely for an ATS invalidation that cannot complete.

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

Commit 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
adds intel_pasid_teardown_sm_context() to intel_iommu_release_device(),
which calls qi_flush_dev_iotlb() and can also hard-lock the system
when a PCIe endpoint's link drops.

Call Trace:
 qi_submit_sync
 qi_flush_dev_iotlb
 __context_flush_dev_iotlb.part.0
 intel_context_flush_no_pasid
 device_pasid_table_teardown
 pci_pasid_table_teardown
 pci_for_each_dma_alias
 intel_pasid_teardown_sm_context
 intel_iommu_release_device
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

Sometimes the endpoint loses connection without a link-down event
(e.g., due to a link fault); killing the process (virsh destroy)
then hard-locks the host.

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

pci_dev_is_disconnected() only covers safe-removal paths;
pci_device_is_present() tests accessibility by reading
vendor/device IDs and internally calls pci_dev_is_disconnected().
On a ConnectX-5 (8 GT/s, x2) this costs ~70 =C2=B5s.

Since __context_flush_dev_iotlb() is only called on
{attach,release}_dev paths (not hot), add pci_device_is_present()
there to skip inaccessible devices and avoid the hard-lock.

Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present context =
entry changed")
Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/intel/pasid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..a369690f5926 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -1102,6 +1102,15 @@ static void __context_flush_dev_iotlb(struct device_=
domain_info *info)
 	if (!info->ats_enabled)
 		return;
=20
+	/*
+	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
+	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
+	 * cannot complete.
+	 */
+	if (dev_is_pci(info->dev) &&
+		!pci_device_is_present(to_pci_dev(info->dev)))
+		return;
+
 	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
 			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
=20
--=20
2.20.1

