Return-Path: <stable+bounces-214880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEK5LqFriWkZ8wQAu9opvQ
	(envelope-from <stable+bounces-214880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 06:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8810BB5C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BAA73008296
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E152D46A9;
	Mon,  9 Feb 2026 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AlAGa2Is"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C51DF73A;
	Mon,  9 Feb 2026 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613661; cv=none; b=M5jZfiQnx1qyC5rZORyvAA7zALH/Nx/n9D2BuObiyM8w6O4v/QfeZQ7K2S6DrL2W5jRjIvdOdiAy8X+G+jnOENGqahHz+6TDqQisOsQRhQMpRxRGTU8HU5n56fmPAGdRt/TxXQ3Npk4zyc7eYP1cHKRHbIdejghYOi4j1Bqcfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613661; c=relaxed/simple;
	bh=LHqn/GixCBjCcP0ckY9K5G7256wn5lQHJeRBARtN12I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j991223XxDFMZIZn8/Fe1pbYfDcLmqqRbqEEF9W54Th9wF2x4Xm2PZFWtBNVL7HUy+ZvA0HIMOcjQxiY3chkWTIvptHcuDLs8e/Pg+RUGF6dcONXZKMMy8qnF3XhTwaDotiWvsOWrg5BsIa68vTGT5YzcrOvab+fxDss/1maEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AlAGa2Is; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/x
	fz2yEJLYMm2Um+zvW1kTIww6qHXcYAehjSQux+ryA=; b=AlAGa2IsDDjO7PiU8u
	lvJLZnvQ5EhJcbpZNHny8+lo0vE88r8xkg0IAujk3AkpQETMLSwyHs3ZtIefrZdX
	6Epq8J7vMb6/hmmocH9e8R9wBWgfUE49P9mzL1WQk8koweZrq4fKFgTgAOIHESm7
	1fw033K3kdKVjur+1EStJBCnA=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXAnWkaolpRukVOg--.391S2;
	Mon, 09 Feb 2026 13:03:34 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murohy <robin.murphy@arm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] iommu: disable SVA when CONFIG_X86 is set
Date: Mon,  9 Feb 2026 13:03:30 +0800
Message-Id: <20260209050330.3918880-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXAnWkaolpRukVOg--.391S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyUWrW3Kry8JryrXw4Utwb_yoW7Gr13pF
	WUGrWSyryDJr1rCw1Duayv9Fyjg398GFWUGFn8G3Z5uryakryjvr1a9F4fXFWUKryDGF1a
	vF4qgr1xtayFv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEqg43UUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+giBG2mJaqgzaAAA3R
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214880-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,nvidia.com,kernel.org,alien8.de,intel.com,redhat.com,google.com,linaro.org,8bytes.org,oracle.com,infradead.org,arm.com,linutronix.de,gmail.com,amd.com,suse.cz,linux-foundation.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AB8810BB5C
X-Rspamd-Action: no action

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 72f98ef9a4be30d2a60136dd6faee376f780d06c ]

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
[ The context change is due to the commit
be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
and the commit 757636ed2607 ("iommu: Rename iommu-sva-lib.{c,h}")
in v6.2 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 01e01ca760cf..964170f90597 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3068,6 +3068,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
-- 
2.34.1


