Return-Path: <stable+bounces-220737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJeBAO8/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A31C6D97
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E49630DFD4E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5DB40148F;
	Sat, 28 Feb 2026 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWeUIXhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5A401487;
	Sat, 28 Feb 2026 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300618; cv=none; b=mantXNX6UZyTYodEagKbSUnc1bT+4eeRQAwMChNP1zMI6KWh7ksLtvFywj/9QJ25i9pjveXpQO1gU5BX53YjcxKYRZGDEb3q47fkmcckKdPgFA3udVmwqF14Zn+JiIRjXfNGHL+T//pXLe4wSZynP3Peh5y0+kD43imM//yWnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300618; c=relaxed/simple;
	bh=pZrv2YZrYsK87xb10fIhnLIW90OJBm3wCI/Krk++uIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E60SH4zJ0mQva5QddOjZ78yMdnfOgvggD1jBarIwolChgS+haqbpTJfIVLhlRFTSTFuYnIET/AY6AKUmKDlizhpjYRjsKig8sOsLK5aSpsCqDdwYdB/M7k0J6WHsSY4kmZM/O8jX4xBjFeKkJibPJg5EHYGz4fIKcwEjHBzoJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWeUIXhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410A5C19425;
	Sat, 28 Feb 2026 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300617;
	bh=pZrv2YZrYsK87xb10fIhnLIW90OJBm3wCI/Krk++uIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWeUIXhSWwzrPlRaJhn1GoH2Xdnau8TCTINf/Ti7PQpsO5Ga4a9u4iDi13wNFtRsD
	 oX+xF1pMJ8gD5VePRye+6Yfj4bDHdhWVESLx01Nfn9RLkZF5/mdtzXfHSx+CEVFiLk
	 atvV+NWDdYgH1UkOr19YpnWovLRO7ne+eXctuKQokJAYyZ8CMAJIW14oeIg8auzpFU
	 t/Z2mAn7THFaJaqY5FywYFAVTg3OZKqPqUzAm2Fn+0EHiDpfBf9UdP9A+P36ftrnVw
	 /jSKmmORtkNCA8psHrHhHpUyQnsLohXm8ny6cfTT8xP1XaSRXVxINV4FhWyolpllLH
	 0ygDEtx4ZkJoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 658/844] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Date: Sat, 28 Feb 2026 12:29:31 -0500
Message-ID: <20260228173244.1509663-659-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220737-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,bytedance.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A12A31C6D97
X-Rspamd-Action: no action

From: Jinhui Guo <guojinhui.liam@bytedance.com>

[ Upstream commit 10e60d87813989e20eac1f3eda30b3bae461e7f9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index d3841a88e5948..b63a71904cfb8 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -219,7 +219,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
-	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+	if (!pci_device_is_present(to_pci_dev(dev)))
 		return;
 
 	sid = PCI_DEVID(info->bus, info->devfn);
-- 
2.51.0


