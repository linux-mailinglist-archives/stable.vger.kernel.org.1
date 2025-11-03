Return-Path: <stable+bounces-192148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C9C2A276
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 07:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E62F4E6500
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB928DB54;
	Mon,  3 Nov 2025 06:13:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCF28D84F;
	Mon,  3 Nov 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150412; cv=none; b=Sx/zahG8naZ0nSrHSsbQ0mj9fnQ7nVRacpwPiV/EDvTDbvCOW7o4cisbhawGhrGkBl3zYgQRxBcv/fpev13BZlidAOFRCHTgnlpgHC4sk1B3qhdCNDVwpsEH4f/qo+5v3HSbucwwFG0vudTv8UhHUB0JTcMQfKeXM2tKWSuIVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150412; c=relaxed/simple;
	bh=8CR0To9DjrlA5b2jldomA8p9V5YJ3rL/o4pVZ7+NjTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6EOw16pWLREFYsysuivhaL1E3ehwX+ucj3H9C2ufMcYoqPK8PLnbbYSWu70gmsMwccMBuUj+hqZtCiCnqlJZ7fjwnsFcISfgEKMmNBVIXfOu4wRrGWy+v4L3DTeQyN7EovrDOvQhABS83/1sbzD3uzPjnm/t2wlXe3Nzgs/RCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A77228FA;
	Sun,  2 Nov 2025 22:13:21 -0800 (PST)
Received: from Mac.blr.arm.com (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6CDA3F694;
	Sun,  2 Nov 2025 22:13:25 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ryan.roberts@arm.com,
	rppt@kernel.org,
	shijie@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64/pageattr: Propagate return value from __change_memory_common
Date: Mon,  3 Nov 2025 11:43:06 +0530
Message-Id: <20251103061306.82034-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Post a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full"),
__change_memory_common has a real chance of failing due to split failure.
Before that commit, this line was introduced in c55191e96caa, still having
a chance of failing if it needs to allocate pagetable memory in
apply_to_page_range, although that has never been observed to be true.
In general, we should always propagate the return value to the caller.

Cc: stable@vger.kernel.org
Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Based on Linux 6.18-rc4.

 arch/arm64/mm/pageattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5135f2d66958..b4ea86cd3a71 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
 	struct vm_struct *area;
+	int ret;
 	int i;
 
 	if (!PAGE_ALIGNED(addr)) {
@@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
 		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
+			ret = __change_memory_common((u64)page_address(area->pages[i]),
 					       PAGE_SIZE, set_mask, clear_mask);
+			if (ret)
+				return ret;
 		}
 	}
 
-- 
2.30.2


