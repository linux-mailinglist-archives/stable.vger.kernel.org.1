Return-Path: <stable+bounces-216022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGb+Gvu+jmmzEQEAu9opvQ
	(envelope-from <stable+bounces-216022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:04:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB989133229
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B61F3088215
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF26285C91;
	Fri, 13 Feb 2026 06:04:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5542770A;
	Fri, 13 Feb 2026 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962650; cv=none; b=sVzAJLS8tcBoOLgWev4x+bwuyV9TKsV0ITYGmG+K06W40JySaq2NQi4Co7V2PPtj8fLNWFw1jg1HJaxyHSBDvRX1WyZuN1ykDKSyvkswPeiAO4okqqPb0o1UjkQkGC+EtGTgqF3FXvbJpYCdlgBQrXpcQgEXslwvUyPynMcHdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962650; c=relaxed/simple;
	bh=jsdlg2Ynwh2r9K78xMh03EfD8NoasnFnvJCqCdLLk4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmKMi4uhTP3QW/tHe3qYAiUylMLxGzfS/B7MeY3ae/N3dIppae5MJoioOU458EVv8nDfQfSWP3zJ5UavlWpsxuLq75+76M4QBoabr+N7Ay/L8QiqLZBHdixqEDfjBucG1PJ9ndzaiHr0g9vVcWB45QBJaY73WaDj/YJ4SuWDBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3jUXOvo5pvFZNAA--.57062S2;
	Fri, 13 Feb 2026 14:03:58 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHXuvEvo5pWw0bAA--.32545S3;
	Fri, 13 Feb 2026 14:03:49 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qemu-devel@nongnu.org,
	stable@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
Date: Fri, 13 Feb 2026 14:03:47 +0800
Message-Id: <20260213060347.2389818-2-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
References: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHXuvEvo5pWw0bAA--.32545S3
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAFAGmONAkAtAAEsu
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr4rGryDtrWxuFyDAw43ZFb_yoW5CFW5pa
	1agFZYgF4kJryxGFs7u3WUAw1IqFnYkF45GFZrCwnxZa1Ygw1Uuryavr1FvFn7tryfCF1r
	XF4qy3WYvw1UZaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuichao1753@phytium.com.cn,stable@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phytium.com.cn:mid,phytium.com.cn:email,intel.com:email,gourry.net:email];
	TAGGED_FROM(0.00)[bounces-216022-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[phytium.com.cn]
X-Rspamd-Queue-Id: CB989133229
X-Rspamd-Action: no action

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
Cc: <stable@vger.kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 5b009a9cd8b4..0892d532908c 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
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
2.33.0


