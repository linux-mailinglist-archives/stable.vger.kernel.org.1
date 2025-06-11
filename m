Return-Path: <stable+bounces-152370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FEAD48EA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 04:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E12189F6A2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83918BC2F;
	Wed, 11 Jun 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Gi4X5Lv0"
X-Original-To: stable@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A1EAF9;
	Wed, 11 Jun 2025 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749609361; cv=none; b=TBQz/XLVACAlgRWBbx8FSwuCW+BrPwtdOWu8NZbgXlLFRQ92MjzOr1obJXuMLLtDutm7Jf/O+ogGuyFelQclU2MFHDkAnXlVUEZIoITcqkW76gyjGiJnO+Xx1tjVlgn51+ezROElQ9u/43wi/O98zVkduEcOPlCdy25yVK4IlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749609361; c=relaxed/simple;
	bh=+iHAyZuQxdh1hnR8AoXUzwExgpbgBZ9kpS3GBDKs3NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBP6zVsx1vQgKP7GCF2Wa96Zjk8GOca4mYlLexHwiBkdgeTAM4p9ggULxNsLmnpqOmKAURUAF/sIJ377zNgPAEwMAJBa4mnB2h7O0sz6jf1MczVu3baX6glfaezUwFTsZmGImoXIc8ZQwm4q0O75lhe0NXrCfmoo/InKxO93tdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Gi4X5Lv0; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1749609359; x=1781145359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iHAyZuQxdh1hnR8AoXUzwExgpbgBZ9kpS3GBDKs3NU=;
  b=Gi4X5Lv0UtEr08CGJtqvmlQ2D7xY0lAHw/A3/7HYeUy82sNZlbqCHVlN
   IlIi2fGLnYXUI5Y61+YgiSCetphE5xxZHovmx18RcmArhGbVKjoItYzV9
   em0W00y7XrrmUGnB5W/hwrR79g0mencskTNwRoX8o75fNIHdTQsZUJTpZ
   hMzaBTKGt9xgJSJ7g9LcLyJlqp+2jsAqAdmCmkha+r1G6iXvh1JxkAFNd
   zCNZPK2hnW0vuhEZW/gO9ub/BJJz2yqPt282FFIGKgtxVKOlHWfi20uls
   w9SxoYDNWhunxTxf1MTPrBeCEMi0S5Tj+fteddXn51d/LmbDfdgMHn9bo
   Q==;
X-CSE-ConnectionGUID: 5pHxzLLGSO+AJAu5HfJrOg==
X-CSE-MsgGUID: evajQBnKS1yiSWenIxrbaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="181824685"
X-IronPort-AV: E=Sophos;i="6.16,226,1744038000"; 
   d="scan'208";a="181824685"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:34:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EB94ED8E1D;
	Wed, 11 Jun 2025 11:34:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90CE8D4C03;
	Wed, 11 Jun 2025 11:34:44 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 38BE01A0071;
	Wed, 11 Jun 2025 10:34:41 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	stable@vger.kernel.org,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2] mm/memory-tier: Fix abstract distance calculation overflow
Date: Wed, 11 Jun 2025 10:34:39 +0800
Message-ID: <20250611023439.2845785-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250610062751.2365436-1-lizhijian@fujitsu.com>
References: <20250610062751.2365436-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt_perf_to_adistance(), the calculation of abstract distance (adist)
involves multiplying several int values including MEMTIER_ADISTANCE_DRAM.
```
*adist = MEMTIER_ADISTANCE_DRAM *
		(perf->read_latency + perf->write_latency) /
		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
		(perf->read_bandwidth + perf->write_bandwidth);
```
Since these values can be large, the multiplication may exceed the maximum
value of an int (INT_MAX) and overflow (Our platform did), leading to an
incorrect adist.

User-visible impact:
The memory tiering subsystem will misinterpret slow memory (like CXL)
as faster than DRAM, causing inappropriate demotion of pages from
CXL (slow memory) to DRAM (fast memory).

For example, we will see the following demotion chains from the dmesg, where
Node0,1 are DRAM, and Node2,3 are CXL node:
 Demotion targets for Node 0: null
 Demotion targets for Node 1: null
 Demotion targets for Node 2: preferred: 0-1, fallback: 0-1
 Demotion targets for Node 3: preferred: 0-1, fallback: 0-1

Change MEMTIER_ADISTANCE_DRAM to be a long constant by writing it with the
'L' suffix. This prevents the overflow because the multiplication will then
be done in the long type which has a larger range.

Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
Cc: stable@vger.kernel.org
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
  Document the 'User-visible impact' # Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/memory-tiers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dc0cf2863e2..7a805796fcfd 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -18,7 +18,7 @@
  * adistance value (slightly faster) than default DRAM adistance to be part of
  * the same memory tier.
  */
-#define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
+#define MEMTIER_ADISTANCE_DRAM	((4L * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
 struct memory_tier;
 struct memory_dev_type {
-- 
2.41.0


