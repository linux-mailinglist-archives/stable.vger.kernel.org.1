Return-Path: <stable+bounces-75644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AF973855
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134021C2442D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D9192B84;
	Tue, 10 Sep 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN8rgVCN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCD192B74
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973924; cv=none; b=Rg4llLkHoEoUWlTogYNfITKVKS0AwvqdZX6U88ncunRJXxq2XRNwvH0aUjBeWCmoN+G7eYyAfTAsaXFl+v1Gm+1PN1hPvNvkXc1Wguan77FKZBlzXbSHEFb+oLFIEtxXPDNTgGd/ygLXKTembBZv+9aU+b3UMPQZH1oPX9Q4bJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973924; c=relaxed/simple;
	bh=iF8axzE/QId4a9qor3MI0r+CUtkHeMhF23cw9uLx2k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR/6LctCaONGwxnpWvBzCFBkEa7qt0/Mrsqjsv8dnogevnfJN/6X21zzEE6RRCu3W+9ZquXsycvRRV/tumjRlU8rOQNrPgAMY8PIQy2JAb2leEuFKPFEWVLCU6KinzZ8JCttJUnePaHkKnnyij5y3cWLZzQsbOj5gpjJvRvwK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN8rgVCN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973922; x=1757509922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iF8axzE/QId4a9qor3MI0r+CUtkHeMhF23cw9uLx2k0=;
  b=DN8rgVCNLIA/ZQ/JDDQS8vRcoi/xTbi/+kl+Q8yYshrkN5bS34ksVv+o
   HKt2PofBywX4ackNFn2iF0jBQ02rpzHasobXL+uossa33o005ro9tOXSS
   qB2O+i2tEOCAXcfXb1fpp4mdhrsM9rzKnzDskpdM5tT22AM0jOgm4rR8W
   xbtnyr3mMQUIFUCoYLJpXf03yZzRdzvSCXgTQr/q33C7H/yQvKQVS/JlS
   oGGy6Njj3Cx6edbMCp+uWItjV/3lAAp+4iJnomn+K3IETHWNzOqmXCQzl
   YcfSwxDVwqnyTxLNDeN0K0rmpq6VPl7d7dbE16T1ZVioMDmk2GvrgOER/
   w==;
X-CSE-ConnectionGUID: pn0hW/QSTLql9iudJjUYUg==
X-CSE-MsgGUID: w9qM8SdSSY2+o0h10CnqHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24861236"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24861236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:12:02 -0700
X-CSE-ConnectionGUID: rakxbUf7QXed6xkgU4tIFQ==
X-CSE-MsgGUID: dnG7sOfIRo6sJxwVKi7JWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67037944"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:11:59 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/xe/client: add missing bo locking in show_meminfo()
Date: Tue, 10 Sep 2024 14:11:47 +0100
Message-ID: <20240910131145.136984-6-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910131145.136984-5-matthew.auld@intel.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bo_meminfo() wants to inspect bo state like tt and the ttm resource,
however this state can change at any point leading to stuff like NPD and
UAF, if the bo lock is not held. Grab the bo lock when calling
bo_meminfo(), ensuring we drop any spinlocks first. In the case of
object_idr we now also need to hold a ref.

Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_drm_client.c | 37 +++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index badfa045ead8..3cca741c500c 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "xe_assert.h"
 #include "xe_bo.h"
 #include "xe_bo_types.h"
 #include "xe_device_types.h"
@@ -151,10 +152,13 @@ void xe_drm_client_add_bo(struct xe_drm_client *client,
  */
 void xe_drm_client_remove_bo(struct xe_bo *bo)
 {
+	struct xe_device *xe = ttm_to_xe_device(bo->ttm.bdev);
 	struct xe_drm_client *client = bo->client;
 
+	xe_assert(xe, !kref_read(&bo->ttm.base.refcount));
+
 	spin_lock(&client->bos_lock);
-	list_del(&bo->client_link);
+	list_del_init(&bo->client_link);
 	spin_unlock(&client->bos_lock);
 
 	xe_drm_client_put(client);
@@ -207,7 +211,20 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	idr_for_each_entry(&file->object_idr, obj, id) {
 		struct xe_bo *bo = gem_to_xe_bo(obj);
 
-		bo_meminfo(bo, stats);
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			xe_bo_get(bo);
+			spin_unlock(&file->table_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			xe_bo_put(bo);
+			spin_lock(&file->table_lock);
+		}
 	}
 	spin_unlock(&file->table_lock);
 
@@ -217,7 +234,21 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
 			continue;
 
-		bo_meminfo(bo, stats);
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			spin_unlock(&client->bos_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			spin_lock(&client->bos_lock);
+			/* The bo ref will prevent this bo from being removed from the list */
+			xe_assert(xef->xe, !list_empty(&bo->client_link));
+		}
+
 		xe_bo_put_deferred(bo, &deferred);
 	}
 	spin_unlock(&client->bos_lock);
-- 
2.46.0


