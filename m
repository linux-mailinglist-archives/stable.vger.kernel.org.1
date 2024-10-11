Return-Path: <stable+bounces-83478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B582299A85D
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F841C23423
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E546198E6F;
	Fri, 11 Oct 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axm6IJIt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB8198858
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661960; cv=none; b=W9nqzgjJh7zI3KhwxqPlmOiayrXW5CnFibzcDfIRmvxAmpWR79MTSJgRsF0euSzX0prPP/IzJO5Fcd5tF59je8mdL4ekR4guwUlseec2hu4kOXskg2br3CzbPHct3EfdQYmh520yvF/7fmZwGVqlW3Qm92SK52FxfkXng8WS9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661960; c=relaxed/simple;
	bh=WDrjCudsvxf46qeev48SGKCNR7uWGLHMWOLnwSUkFeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCHxJbQEHLTViIkgv85zQv0yL1nKLqNt86sgG1LCESY0bRYZ5Q+DjcfTCfrYhoXZoNphiR7cNbGwcY9tcQqfJTtR9PWLnzlKL+q6qSTxQZUcpJXUpjkiLAqs4enKnRcbjDMx+uPM8mlpaIclCjrV0WdbnK0qWMUbF+r4H8iuum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axm6IJIt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728661958; x=1760197958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WDrjCudsvxf46qeev48SGKCNR7uWGLHMWOLnwSUkFeM=;
  b=axm6IJIto+3p5PikB921pNjEg+2xbhjYnYfQg5S00zG08c01VJI+3PAU
   wtLFVJws/AyJHz9csMDcFkO+PX9fjEntp0N5kAjvnl+XFLGWXW2ZaIXMa
   v5drmG0KlUqm/a6FVT4RFpAwwuwpiH2tL+/2ECEWBw0A73ZwgcgPvj5OM
   PXctgCV0HGNsEjuxJre3orrcY1vRRH5c52SbHOmV7spFqrF8+duOWgSxI
   0VmETTAz6YopfijolNT1vqeoje6nfzv0b4KjhK3cTEwtSiba13q157jcy
   vumFRIwT//8Q+S52pkv73gC6Ovd/Ile3JzsLTWT/XlYJ/ZIEU98NSvVkm
   g==;
X-CSE-ConnectionGUID: 3GsDFjdmSzKhYhvh7Yb6Qw==
X-CSE-MsgGUID: 35l2jj/NTzSaEqOLgPlmYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28172867"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28172867"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 08:52:37 -0700
X-CSE-ConnectionGUID: ptkkBB/GT7GnCxqa2saVSQ==
X-CSE-MsgGUID: 3SX2yvYITcmeS20ncgYRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77762091"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 08:52:35 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org,
	Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2] drm/xe/ufence: ufence can be signaled right after wait_woken
Date: Fri, 11 Oct 2024 17:10:29 +0200
Message-ID: <20241011151029.4160630-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

do_comapre() can return success after a timedout wait_woken() which was
treated as -ETIME. The loop calling wait_woken() sets correct err so
there is no need to re-evaluate err.

v2: Remove entire check that reevaluate err at the end(Matt)

Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
Cc: <stable@vger.kernel.org> # v6.8+
Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index d46fa8374980..f5deb81eba01 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -169,9 +169,6 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 			args->timeout = 0;
 	}
 
-	if (!timeout && !(err < 0))
-		err = -ETIME;
-
 	if (q)
 		xe_exec_queue_put(q);
 
-- 
2.46.0


