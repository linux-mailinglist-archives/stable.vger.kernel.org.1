Return-Path: <stable+bounces-240228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pJFHHJLP52k1BAIAu9opvQ
	(envelope-from <stable+bounces-240228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B743EEF4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A2E3021B01
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8ED3D9DA6;
	Tue, 21 Apr 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQtQxoid"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD0288D0
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799629; cv=none; b=JTn7BbaY+yEwMAGXRWlYfnJcAb1G6m+PXZlD9D6zrAg9HF9svaVzhRqts3Wor3HYYbhgHf5RanBIJ9zsYUu+Li8ISJCUDhaplRgQ2DiMjutRHtdpjEPd4RcWi03B0KgJX+rIdce7AUTqEQomeAwjqBYPaTp0OAmEhK9YhIKFrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799629; c=relaxed/simple;
	bh=vfjoOLZRLHrzWh7KAuxNROKCvJcO+e8hunyr5RlAQqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VZAAXXJ4HzlJmukWZqRQhA2gYxuu+0Q5DydAIbdyA1h8mzvfaHY86zI5F8LFc9WlFp31kqrTvtDyg7lp2KWA8KIXG9u+Lu0uDTQ1QU6UjZoZ0+zUKeECcIC2AWpQSRJ8aYnEJ0QT2u+k5FF8OinCSn5oITQQ6LbQnHxeZgj2Mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQtQxoid; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776799615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3sJeS58A7kF1kifMPXuvvNzeZ+Rukp0hi1eq+lRanZ8=;
	b=JQtQxoidpVLNT0G+sauoSitoJ3zFwptAdIyH957gu0hFiqm2pd+7P53lmPHmWIcH7m5n+e
	lTPWsRjeZLpF8S8GR+QAinQDMOjsIYrTUQJYVvKXSvRqGVKTDpTzpDEwm1alERGG8e8Xw6
	YMF7wJRcAKnbMshTdBsSD+LuPycfccs=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Tue, 21 Apr 2026 19:26:13 +0000
Subject: [PATCH] iommu/amd: Bounds-check devid in __rlookup_amd_iommu()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>
X-B4-Tracking: v=1; b=H4sIAFXP52kC/yWMSw6CQBAFr0J6bUcYCTFexbiYTwOtzgzpZogJ4
 e6CLuvlVa2gJEwKt2oFoYWVc9qhOVXgR5sGQg47g6lNV7emQRsDco6xoLxzfpUJXS4pKLZkat/
 2/uK6K+z6JNTz55e+P/6sxT3Jz0fveDirhE5s8uMxZeGB0zlanUlg274Qh8D+nAAAAA==
X-Change-ID: 20260421-amd-iommu-rlookup-bounds-4e20c4fc3b68
To: Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ziyuan Chen <zc@anthropic.com>, Josef Bacik <josef@toxicpanda.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240228-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jose.fernandez@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid,anthropic.com:email,toxicpanda.com:email]
X-Rspamd-Queue-Id: 5D8B743EEF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iommu_device_register() walks every device on the PCI bus via
bus_for_each_dev() and calls amd_iommu_probe_device() for each. The
inlined check_device() path computes the device's sbdf, calls
rlookup_amd_iommu() to find the owning IOMMU, and only afterwards
verifies devid <= pci_seg->last_bdf. __rlookup_amd_iommu() indexes
rlookup_table[devid] with no bounds check of its own, so for a PCI
device whose BDF is not described by the IVRS, the lookup reads past
the end of the allocation before the caller's bounds check can run.

This was harmless before commit e874c666b15b ("iommu/amd: Change
rlookup, irq_lookup, and alias to use kvalloc()"): the table was a
zeroed page-order allocation, so the over-read returned NULL and the
caller's NULL check skipped the device. After that commit the table is
a tight kvcalloc() and the over-read returns adjacent slab contents,
which check_device() then dereferences as a struct amd_iommu *,
causing a boot-time GPF.

Seen on Google Compute Engine ct6e VMs, where the virtualized IVRS
describes only the four TPU endpoints 00:04.0-07.0; the gVNIC at
00:08.0 (devid 0x40) indexes 56 bytes past the 456-byte allocation,
into the adjacent kmalloc-512 slab object:

  pci 0000:00:04.0: Adding to iommu group 0
  pci 0000:00:05.0: Adding to iommu group 1
  pci 0000:00:06.0: Adding to iommu group 2
  pci 0000:00:07.0: Adding to iommu group 3
  Oops: general protection fault, probably for non-canonical address 0x3a64695f78746382: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.22 #1
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/06/2025
  RIP: 0010:amd_iommu_probe_device+0x54/0x3a0
  Call Trace:
   __iommu_probe_device+0x107/0x520
   probe_iommu_group+0x29/0x50
   bus_for_each_dev+0x7e/0xe0
   iommu_device_register+0xc9/0x240
   iommu_go_to_state+0x9c0/0x1c60
   amd_iommu_init+0x14/0x40
   pci_iommu_init+0x16/0x60
   do_one_initcall+0x47/0x2f0

Guard the array access in __rlookup_amd_iommu(). With the fix applied
on 6.18.22, the gVNIC at 00:08.0 is skipped cleanly and the VM boots.

Fixes: e874c666b15b ("iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()")
Cc: stable@vger.kernel.org
Reported-by: Ziyuan Chen <zc@anthropic.com>
Tested-by: Ziyuan Chen <zc@anthropic.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b55..66dd0b6b98069 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -351,8 +351,12 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
 	struct amd_iommu_pci_seg *pci_seg;
 
 	for_each_pci_segment(pci_seg) {
-		if (pci_seg->id == seg)
-			return pci_seg->rlookup_table[devid];
+		if (pci_seg->id != seg)
+			continue;
+		/* IVRS may not describe every device on the bus */
+		if (devid > pci_seg->last_bdf)
+			return NULL;
+		return pci_seg->rlookup_table[devid];
 	}
 	return NULL;
 }

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260421-amd-iommu-rlookup-bounds-4e20c4fc3b68

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>


