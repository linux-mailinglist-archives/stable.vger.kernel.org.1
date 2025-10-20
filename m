Return-Path: <stable+bounces-188221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7CBF2C14
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0834FA648
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F53314D7;
	Mon, 20 Oct 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PO6H//qZ"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D93321D0;
	Mon, 20 Oct 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981870; cv=none; b=SpNS90rKd3bKEY6ecBHLIkCXYSzHni1XfqAVGzCOrYjJ7S7YTwoWinlu4Lx2/3w4Pa5GA8ePlqzLGAF//oKa5uMM5+cpofTOPDkRaTv4gADB/L1s5wTiDpNXVx8oRUVsfblYcw+Rs5L0IDVp18WhK3gnmrdSatuOsKcwAUOnwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981870; c=relaxed/simple;
	bh=bftfsfrtI2uDI1lrX1EbWuG01ZEQ2COYpCsNPm/6SfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZqT+WLtQ7kO1IZZDsUUg6ZqZdfhqFGgrmHv2h0vVCEf2QjEREO7KZeKJX87hRB3WorjZBWWR9iq78fXqER/xRYGF/8x+WfWkCd5aN9ZZ+viYS/xF4DBnwtWZ1COg8ID1FDFSVLcFcg1igZ+xKi/25bWlz5Ub37stRDBkzup7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PO6H//qZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1ukOi8KmMMcIuLOLnHaaaMCNubPEB8ZpaPvZm1idAI=;
	b=PO6H//qZUyG0YhWZeukv9QZ5aQkskez1W0tCzMIQfEzth0nZcSUszRjcnaZgElZxN+u7ua
	wDrWfYZiPUwsBaf/qtJOSiDH3iHNk37FJYn4DFqa5vgzSikVLn4rlW8wirSSz16gRbQSuk
	BLCWOj7/OO8oU7rJxYshQSQ17lkE8qE=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 08/10] cacheinfo: Fix LLC is not exported through sysfs
Date: Tue, 21 Oct 2025 01:36:22 +0800
Message-Id: <20251020173624.20228-9-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 5c2712387d4850e0b64121d5fd3e6c4e84ea3266 ]

After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
based arm64 server. This is because the LLC cacheinfo is partly reset
when secondary CPUs boot up. On arm64 the primary cpu will allocate
and setup cacheinfo:
init_cpu_topology()
  for_each_possible_cpu()
    fetch_cache_info() // Allocate cacheinfo and init levels
detect_cache_attributes()
  cache_shared_cpu_map_setup()
    if (!last_level_cache_is_valid()) // not valid, setup LLC
      cache_setup_properties() // setup LLC

On secondary CPU boot up:
detect_cache_attributes()
  populate_cache_leaves()
    get_cache_type() // Get cache type from clidr_el1,
                     // for LLC type=CACHE_TYPE_NOCACHE
  cache_shared_cpu_map_setup()
    if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
                                      // leave LLC's type=CACHE_TYPE_NOCACHE

The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
test it's valid or not, but populate_cache_leaves() will only reset
LLC's type, so we won't try to re-setup LLC's type and leave it
CACHE_TYPE_NOCACHE and won't export it through sysfs.

This patch tries to fix this by not re-populating the cache leaves if
the LLC is valid.

Fixes: 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20230328114915.33340-1-yangyicong@huawei.com
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 26ae36f2ff58..60ecf7cc0250 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -490,12 +490,18 @@ int detect_cache_attributes(unsigned int cpu)
 
 populate_leaves:
 	/*
-	 * populate_cache_leaves() may completely setup the cache leaves and
-	 * shared_cpu_map or it may leave it partially setup.
+	 * If LLC is valid the cache leaves were already populated so just go to
+	 * update the cpu map.
 	 */
-	ret = populate_cache_leaves(cpu);
-	if (ret)
-		goto free_ci;
+	if (!last_level_cache_is_valid(cpu)) {
+		/*
+		 * populate_cache_leaves() may completely setup the cache leaves and
+		 * shared_cpu_map or it may leave it partially setup.
+		 */
+		ret = populate_cache_leaves(cpu);
+		if (ret)
+			goto free_ci;
+	}
 
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
-- 
2.25.1


