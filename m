Return-Path: <stable+bounces-200766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC1CB4A9D
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 05:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C5E3013956
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53786352;
	Thu, 11 Dec 2025 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j5xh8t2i"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD361F2380
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425699; cv=none; b=N2m3AsELKdimPYRGipd4RWkkWzz+6K4F0F0PUbtQR3kTE+lwKhi+T5HK7UFRvP5d61bYN2OsrCrV8XahYskmfXkz1R/j/dGzlQTMvqRLkec9rEagdsaWiU8u7BJ/7Qqa/2VWkEnfO+Tdzjb8zhPqDt4nwzCLcKBExU63MMHFU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425699; c=relaxed/simple;
	bh=4Q6NgeycfZthGEeAHFhDPjP2yvbchRqZ4whFCZCWnBg=;
	h=References:To:Cc:Subject:Date:Mime-Version:Message-Id:In-Reply-To:
	 Content-Type:From; b=UJwCJJexqr9keJfsgbwKaY0UaYGPaWaFsY7hPWPC/E8R4BoY75Mp6aqn5aUqAKbJjqOvXU7Ytn5hL+6jo0RbDRcq/XLFgPtfPob/7wR9oh5bOm4SCEQNgSs9bohBg10anVL6IZSdNTxDE5U3a99elnyBfO9hTw9NacUUvffEV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j5xh8t2i; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765425691; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9UfJ9VIVOS38iGxyFptQJegd8mcO/MEORiq3nC7/r9Y=;
 b=j5xh8t2iNTYYp1IriO5eV6INcxfxegpTIEQCJ0G8/rfhyMTaZZqoXbpYR0uK1iYPAn2dAZ
 Td7NMVAdd5Jo9epajNyM5uacgDbuZNbi/ezrM/Rq4EWMP0kj0y6yZPpJNeTbbsMtMk0Jey
 ttCwiX6Ze8YGTZXEdw1P8nZtkd/JQDTD3l4XH0wbQzxA/67OTFSQHrbwAgysBbwS8G5LSk
 t1LiZR87/FhdofDjr24Qdjdm3uEidsnvNffXDJ/WdvOn+xVuenhMLNL+w+48Y0iYEYUP8p
 xTcdNBBNxXt8RIXS8x9WIJSNlyieeNIlaafxC39+QfDne2BFNKIQlrc456gurA==
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2693a4219+2db28b+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>, 
	<will@kernel.org>
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Date: Thu, 11 Dec 2025 11:59:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Message-Id: <20251211035946.2071-3-guojinhui.liam@bytedance.com>
In-Reply-To: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1

Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
request when device is disconnected") relies on
pci_dev_is_disconnected() to skip ATS invalidation for
safely-removed devices, but it does not cover link-down caused
by faults, which can still hard-lock the system.

For example, if a VM fails to connect to the PCIe device,
"virsh destroy" is executed to release resources and isolate
the fault, but a hard-lockup occurs while releasing the group fd.

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

Although pci_device_is_present() is slower than
pci_dev_is_disconnected(), it still takes only ~70 =C2=B5s on a
ConnectX-5 (8 GT/s, x2) and becomes even faster as PCIe speed
and width increase.

Besides, devtlb_invalidation_with_pasid() is called only in the
paths below, which are far less frequent than memory map/unmap.

1. mm-struct release
2. {attach,release}_dev
3. set/remove PASID
4. dirty-tracking setup

The gain in system stability far outweighs the negligible cost
of using pci_device_is_present() instead of pci_dev_is_disconnected()
to decide when to skip ATS invalidation, especially under GDR
high-load conditions.

Fixes: 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation request when=
 device is disconnected")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index a369690f5926..e64d445de964 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -218,7 +218,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iomm=
u,
 	if (!info || !info->ats_enabled)
 		return;
=20
-	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+	if (!pci_device_is_present(to_pci_dev(dev)))
 		return;
=20
 	sid =3D PCI_DEVID(info->bus, info->devfn);
--=20
2.20.1

