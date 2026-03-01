Return-Path: <stable+bounces-222100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI05GDeeo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:02:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7491CCAEA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0A4030DEC41
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1916303CA0;
	Sun,  1 Mar 2026 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioI/dnOW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247E2FE577;
	Sun,  1 Mar 2026 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329898; cv=none; b=KK2INnzUt9VepJNuiezM0KGFBgltfzcrEP4OI3S/LfwVk0PR1E93gFTJZNIFWRp/FUy8pHp7fkvkMdrsf1FC/tItvchg/QdjxxLjhJkiHrjYafOYe2irLWmHMMtldPw5vd+98+ez7WgAnKi9TGIDmgMUsi50oYe/MPm2CokrnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329898; c=relaxed/simple;
	bh=hbv5kg007avlzh4pA0OW9AAOG1KnUD6hPlxj3fyEvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhfAbDBKv4+f7YxLkY1SCl78HjqmXXjMWGk9Ws2Z+X9Uc3xtACp2VlLJlksE47KHVfdJz+yseVSi1PGysnxWZR6MVP1WCauzxD58iQU9KEzDVLppCb/ttadGT4JmkBdYTK1iRPvdfbjfpbHrIXz/Gg1tr5qwo+Fg5Q4LII86uC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioI/dnOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E0EC19421;
	Sun,  1 Mar 2026 01:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329898;
	bh=hbv5kg007avlzh4pA0OW9AAOG1KnUD6hPlxj3fyEvOc=;
	h=From:To:Cc:Subject:Date:From;
	b=ioI/dnOW6XDLvTrWHf5wbQtJjIDGoxuM9R9HIPCBG1WEzLYMscUMXA9as9EYLf/Aa
	 DipHVImQK/NsbWC8l2bzXaCzkkegdO3NM5+bHK9w9b9v3a/nKYaH+H9rfMrkd6tya2
	 C42G7i2AeaAsMrF2w5SEcQjMDWK9QfcAZzy2YlD1rcB3TvMbayaZPjm07dHriezcwM
	 9DbjCCGXLweKUj8Xs2dTICDTF7rXpXRh7x2MW3SK8axAacGBi0KMDxKXomjVy6FdfL
	 gTFsCFnyp5Wr7UrzQ15Fzy+Ag0qQCwPA+2SsqY8Zpbt/ZgxG1VFX1e/ajgOVPyLxp6
	 bGnAbjrfdqBkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev
Subject: FAILED: Patch "iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:51:36 -0500
Message-ID: <20260301015136.1717973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222100-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: EC7491CCAEA
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 10e60d87813989e20eac1f3eda30b3bae461e7f9 Mon Sep 17 00:00:00 2001
From: Jinhui Guo <guojinhui.liam@bytedance.com>
Date: Thu, 22 Jan 2026 09:48:51 +0800
Subject: [PATCH] iommu/vt-d: Flush dev-IOTLB only when PCIe device is
 accessible in scalable mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
pci_dev_is_disconnected(), it still takes only ~70 µs on a
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

Fixes: 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation request when device is disconnected")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Link: https://lore.kernel.org/r/20251211035946.2071-3-guojinhui.liam@bytedance.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3f6d78180d799..99692f88b8834 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -218,7 +218,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
-	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+	if (!pci_device_is_present(to_pci_dev(dev)))
 		return;
 
 	sid = PCI_DEVID(info->bus, info->devfn);
-- 
2.51.0





