Return-Path: <stable+bounces-221537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPCVDBaYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 347851CB177
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9A643042FE4
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34165285C84;
	Sun,  1 Mar 2026 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGaUrFBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3F2727EB
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328514; cv=none; b=n49u3XYEq9sn6kDzNqusz16BeQ0TKlvwp4FVZJ9KQpxSrHFsqIN6UId6BM8Jh3UbrK/v+PMJHLtmRZfOcdcUUx9sKElZQV/JjrCXpo7UaMvLzSgoCSwWOJSuLnriVVFfUBeywz3vEPC2Gi9MA8W7yCOjrxafdFDyNxcSk854ru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328514; c=relaxed/simple;
	bh=8bfwFCO8SIFrbKV1cwycC69fkm4iZipWVhEKQ5L6dcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2scRwxjwS570zWlzXZ7uQIm072SpPyafGbP855Ta06DrpKrhK4NyMr6OmBQvF6u6R2Rif5KjK3huB6L20OggrctGumWSDm26KcielrcP6CjPgY7CtnYQGRGWCFfMmODCv+NmcJTgRB+ZHWhoFfpJ4tepEYJh2UY33He9CP8eFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGaUrFBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C623C19421;
	Sun,  1 Mar 2026 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328513;
	bh=8bfwFCO8SIFrbKV1cwycC69fkm4iZipWVhEKQ5L6dcI=;
	h=From:To:Cc:Subject:Date:From;
	b=eGaUrFBycjIxreSz5k8O47OfOVXtrnqaQYRaseR+2Q1urnt/g9M7QSF+wY+bV6+7W
	 c6fyrD9bkONk+3gILyKLscIKyA8XQh8eZJjOqtCT6alE7fWfXE48w7QYpkJw/BarBn
	 rRgtfCrLhUXqB98oB+T3H3ANZsGQ/OaWsfeDJn586cIWRqokJQqO2GBZlA1hhIbUeR
	 p7jMQlRnN8ZR23ryoaJCo2NbCebuK3JHlawmTbKFJmkDf5B/sqU+PWBjUrlM3PSGY8
	 Suh/GdmqS/JWaZtgSncYTGoM+loAt0EC1jtcX0lMKNcxbq/LbxCP5f7kgyzA64GJa5
	 i4BspvJG+rBlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cuichao1753@phytium.com.cn
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm: numa_memblks: Identify the accurate NUMA ID of CFMW" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:31 -0500
Message-ID: <20260301012832.1686293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221537-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 347851CB177
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f043a93fff9e3e3e648b6525483f59104b0819fa Mon Sep 17 00:00:00 2001
From: Cui Chao <cuichao1753@phytium.com.cn>
Date: Fri, 13 Feb 2026 14:03:47 +0800
Subject: [PATCH] mm: numa_memblks: Identify the accurate NUMA ID of CFMW

In some physical memory layout designs, the address space of CFMW (CXL
Fixed Memory Window) resides between multiple segments of system memory
belonging to the same NUMA node. In numa_cleanup_meminfo, these multiple
segments of system memory are merged into a larger numa_memblk. When
identifying which NUMA node the CFMW belongs to, it may be incorrectly
assigned to the NUMA node of the merged system memory.

When a CXL RAM region is created in userspace, the memory capacity of
the newly created region is not added to the CFMW-dedicated NUMA node.
Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
containing RAM). This makes it impossible to clearly distinguish
between the two types of memory, which may affect memory-tiering
applications.

Example memory layout:

Physical address space:
    0x00000000 - 0x1FFFFFFF  System RAM (node0)
    0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
    0x40000000 - 0x5FFFFFFF  System RAM (node0)
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

After numa_cleanup_meminfo, the two node0 segments are merged into one:
    0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.

To address this scenario, accurately identifying the correct NUMA node
can be achieved by checking whether the region belongs to both
numa_meminfo and numa_reserved_meminfo.

While this issue is only observed in a QEMU configuration, and no known
end users are impacted by this problem, it is likely that some firmware
implementation is leaving memory map holes in a CXL Fixed Memory Window.
CXL hotplug depends on mapping free window capacity, and it seems to be
only a coincidence to have not hit this problem yet.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260213060347.2389818-2-cuichao1753@phytium.com.cn
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 8f5735fda0a21..3f53464240e8d 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -570,15 +570,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 int phys_to_target_node(u64 start)
 {
 	int nid = meminfo_to_nid(&numa_meminfo, start);
+	int reserved_nid = meminfo_to_nid(&numa_reserved_meminfo, start);
 
 	/*
-	 * Prefer online nodes, but if reserved memory might be
-	 * hot-added continue the search with reserved ranges.
+	 * Prefer online nodes unless the address is also described
+	 * by reserved ranges, in which case use the reserved nid.
 	 */
-	if (nid != NUMA_NO_NODE)
+	if (nid != NUMA_NO_NODE && reserved_nid == NUMA_NO_NODE)
 		return nid;
 
-	return meminfo_to_nid(&numa_reserved_meminfo, start);
+	return reserved_nid;
 }
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 
-- 
2.51.0





