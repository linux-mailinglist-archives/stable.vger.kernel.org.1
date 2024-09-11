Return-Path: <stable+bounces-75854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299599757CE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AD4B29BD9
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67019CC24;
	Wed, 11 Sep 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2mn4+jj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101B1AC42B
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070153; cv=none; b=GqGD0HyK8GvWLKrodK/8plO8Gaco3vPTkVeOiQRxyHY/Gxn59QXyRsgo2a4jsyuQy8RUqlhtrcLNTNBL4V4MlYnhftTX4UU4MKh7holzbWB5FVbdUnrIJV8GJhyHHzhQ1nVvXfCc2KQV1RRZk7QiV//WRuDuHvpuKfcPpEMbOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070153; c=relaxed/simple;
	bh=D/GbrL05OJHTIBBaWMmIQ5I4DXUAG07CD3m49MNb4yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqSSeOjtjS1HlANam1rSANAmtEt9CeS6lRQalEncPtDBm653j8+ZNaXwvIchJoVmH9CWq7o46guAf+N2jdgy/KEY2oO4xjQ2L4+5z9rcSn5ic9gMrTPvZfw86dPtrLDV7dLAyDkfqT1qIa2xf3moke+JimQObXQ4UytK/uqcwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2mn4+jj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726070151; x=1757606151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/GbrL05OJHTIBBaWMmIQ5I4DXUAG07CD3m49MNb4yY=;
  b=W2mn4+jjKZQG15r9Fr0phax6HByKPCPds1I9UrUJtAtcjhpndc4mNj5l
   emZ7EpHqDIe5PIsPYp/tRQg5Ge9slvY8E0jbpKFGRY31qdt2zmV8x/une
   fplPGiy9zRuE4N/CwLemu3HReilDTA65rvTsoRpzNPNPpbhyMMPcZ1aqK
   RfTR9LX4ekx3OSOAne1sov4/4mVvSNhE6jJW8Gp/26G0S3W1uIOKNWtP3
   2yM1aOeiIL1eH6PawQTyceFBypiFmk3eXNLJqyZDnyxwHitJl+Y4CGAII
   oFz85yJcrl5nAZXkH3wunjsg5D+buvjMVWnSgr15d6EuUs5dKSGL7zaV3
   g==;
X-CSE-ConnectionGUID: cx+NiqhOSViGaAPTRH0qmQ==
X-CSE-MsgGUID: lfREEpPTSJ2lE2qdtE+vAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24703331"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24703331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:55:49 -0700
X-CSE-ConnectionGUID: 7az0EBxMQbargoKjFD0Zbg==
X-CSE-MsgGUID: Njip1YpIQXqFD5PJpe9Kgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67257815"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.102])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:55:48 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2 1/4] drm/xe/client: fix deadlock in show_meminfo()
Date: Wed, 11 Sep 2024 16:55:27 +0100
Message-ID: <20240911155527.178910-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a real deadlock as well as sleeping in atomic() bug in here, if
the bo put happens to be the last ref, since bo destruction wants to
grab the same spinlock and sleeping locks.  Fix that by dropping the ref
using xe_bo_put_deferred(), and moving the final commit outside of the
lock. Dropping the lock around the put is tricky since the bo can go
out of scope and delete itself from the list, making it difficult to
navigate to the next list entry.

Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2727
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index e64f4b645e2e..badfa045ead8 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -196,6 +196,7 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	struct xe_drm_client *client;
 	struct drm_gem_object *obj;
 	struct xe_bo *bo;
+	LLIST_HEAD(deferred);
 	unsigned int id;
 	u32 mem_type;
 
@@ -215,11 +216,14 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	list_for_each_entry(bo, &client->bos_list, client_link) {
 		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
 			continue;
+
 		bo_meminfo(bo, stats);
-		xe_bo_put(bo);
+		xe_bo_put_deferred(bo, &deferred);
 	}
 	spin_unlock(&client->bos_lock);
 
+	xe_bo_put_commit(&deferred);
+
 	for (mem_type = XE_PL_SYSTEM; mem_type < TTM_NUM_MEM_TYPES; ++mem_type) {
 		if (!xe_mem_type_to_name[mem_type])
 			continue;
-- 
2.46.0


