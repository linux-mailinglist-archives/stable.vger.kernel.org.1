Return-Path: <stable+bounces-152582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5DAD7E45
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 00:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9381D3B507D
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F022D8DAE;
	Thu, 12 Jun 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXayhVhA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406572DECC9
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766504; cv=none; b=TiSFcRKFHpOtsuvQZ7dYLE5B4aWvJWIIssoFb+fHGCbl/vpV+WPKSloyEj+20laPDYVf9ylZZ9wnNuZiuqoQ5qtxQl5KhHWxQ8PUXGfEMww8lgE8QNJuCTJDMV6a/uACwZGD4SJais3tsPnbXpem2kqXRZFAgYuYOY+zcySctng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766504; c=relaxed/simple;
	bh=kWoTnOx6wC+YUG6sd3T0BM74MyVEqOKLoBscpuPxDjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TimLdrzrvBcXFSVHnuqi6AMSMGd8GNw2BLH628iKyiZdt9pUsFzmucDzYzz1FO9cbiqmW0tQqD1cqBePLW47YIyqUSyT55kMQYnjfKw1Oj5/V+/lkvVyCScnILdey1y8FvBxlX5Ia4QY/gQAdZc6+UxBGlkx7fwyGzc+OjD8bCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXayhVhA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749766504; x=1781302504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWoTnOx6wC+YUG6sd3T0BM74MyVEqOKLoBscpuPxDjA=;
  b=lXayhVhAWGz1gNwGIvNciP2zSHAe8GKr5kkTpARxDmK7wuIWpz7wEfDF
   9w/XnISgsr9XNMj6b2chctcbwjzK25hVb2MqS2xYz5QVv+6Q/SwWxyc85
   WazRLI7bWtidEs9YhGpIbnSBu6D0hWU7rp0a2k85+XH7NRtbUq35/7oXY
   Uj2yxtuDrfLdGzSe9DtaLnreqa6IokrjavWl+uRTcgodxFdwIgMnnv1Do
   8ehgLXBo7QBtcXTBEOozGYsQ9lR+0UUEaONMoL/R6ARmF5JkHtHRA8b2g
   RtOQCX3VtAP4lrMq23duyVovh4tJd0SYPfLthJofaEBeyha0Ehl5QsKJh
   Q==;
X-CSE-ConnectionGUID: wA5AeLYgT1W63us0NaUyFQ==
X-CSE-MsgGUID: svx3a1CDT9eryZriM0WvYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55641814"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55641814"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:15:03 -0700
X-CSE-ConnectionGUID: 7/2zJnDXQsqROxBzwBWRyg==
X-CSE-MsgGUID: TlWunpA5R5KckmL4PDSryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152555144"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:15:02 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix memset on iomem
Date: Thu, 12 Jun 2025 15:14:12 -0700
Message-ID: <20250612-vmap-vaddr-v1-1-26238ed443eb@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250612-vmap-vaddr-cba93a33b947
X-Mailer: b4 0.15-dev-a7f9c
Content-Transfer-Encoding: 8bit

It should rather use xe_map_memset() as the BO is created with
XE_BO_FLAG_VRAM_IF_DGFX in xe_guc_pc_init().

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 18c6239920355..3beaaa7b25c1b 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1068,7 +1068,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 		goto out;
 	}
 
-	memset(pc->bo->vmap.vaddr, 0, size);
+	xe_map_memset(xe, &pc->bo->vmap, 0, 0, size);
 	slpc_shared_data_write(pc, header.size, size);
 
 	earlier = ktime_get();




