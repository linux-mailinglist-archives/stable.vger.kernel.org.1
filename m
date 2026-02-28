Return-Path: <stable+bounces-221056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKpzG5NJo2nx/AQAu9opvQ
	(envelope-from <stable+bounces-221056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6C1C7C3B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006FD32198F3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC747CC96;
	Sat, 28 Feb 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1V1wEih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C7301EE3;
	Sat, 28 Feb 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301399; cv=none; b=PUhXDzFFSvT17U/KM4asF92t3aBJNvuRShE6Td2sdWipQSYeFkBgBN1kn0T3KJdu2kysztr+YsOfqBIksM+Q3OFsr2P3a2g8X8bCWMPEGA2s/Q3JIkq78ynQcABRV/6I6Z3YWyFJ06vbh/w2MVxi9G8ph/UYriYp4GuknEbeWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301399; c=relaxed/simple;
	bh=rQsxdeDZ480m7skH3l8/h/NuJK1gSv8geEtcIRimRQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqbyQnNlyUQI1J0CI/UwTcc9GT39e1NFdL9PPPsgOm7ytXDh1Q0YPmpseFI25WNWGV4PITrd+iyJNsW7TpJwOCCQKWqT+BsMq96xt/k9lHmN+odzgM7oJucKjD93lmI+lieUiYwaSQ5DLf1YNMDGSRpY6Ue1KNCxBy1UxKc9LiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1V1wEih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B681C19424;
	Sat, 28 Feb 2026 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301399;
	bh=rQsxdeDZ480m7skH3l8/h/NuJK1gSv8geEtcIRimRQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1V1wEihq4Wc8AT/kXxtdYaFUCQAOrwFtabI35CwSEwcGI56y0cyaHUZ+QET7TLUf
	 5KKutzmO+jGoGeKqq+6P4iJExAM0xWl9lvWNibRa7ejuM/KzvD+UQoKP22KeXBaUqe
	 6GM5zYg57y6cW4LX+q02JvVburTdYl+xwFB1XjwODOyuc9dnf330d34Nm62wWA52vd
	 AEgfdv35HCnG1LQspzdj5DoimTDtMdJ04lwko1Vvk6T3BwBkKg+8DB48I+vEY9O/HH
	 aOW5OvTW4NIC6HHEL+Y02zrvX4PAKa9LOwoTGLufMupkoEIpRDNcPgZGC8Tbzdozhp
	 TMSm4pjJThVQA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>,
	stable@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 588/752] iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode
Date: Sat, 28 Feb 2026 12:44:59 -0500
Message-ID: <20260228174750.1542406-588-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221056-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,bytedance.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 00A6C1C7C3B
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
index d13099a6cb9c3..6782ba5f5e57f 100644
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


