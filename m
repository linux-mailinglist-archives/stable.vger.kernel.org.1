Return-Path: <stable+bounces-83460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9F99A5C2
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFDE285994
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116302185A5;
	Fri, 11 Oct 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/hsSPMP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B71D517
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655661; cv=none; b=qyGGrHUqKYnHpIaLiuW7lU9SdRwvY1pua7569U7z/Ksy/ol/V6/5jN7OWGmFf4s0duo9wX80iv0DWcmoQp/2lqN2lduq7Pu88colOPvjQmkTVx4wj82r26eP/tGvZKTLKJg6LCwQv67ZOko5+/C/Dw3yBtSqhDhrpnNdvxAFZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655661; c=relaxed/simple;
	bh=lyKD+2N1e3w7ZDehh3RYOxh6saqANnxHCe0vh0jkPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3BGfrIqPpuqsfSLKx3yWVjsvTuU26rjlNQ31zTyFAk2UQOCn8Wn+aUlfxeMvrsv95ccMa+SFQWSdXOCyJZRH1eJX07QXVzIjKOjwyALApCx3N5EQpdEH5O3KX6Z6uKsK6ZmgEUGycVYwzuWkw0Mggoz8ep5tQ1qIbcFaxTfNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/hsSPMP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728655660; x=1760191660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lyKD+2N1e3w7ZDehh3RYOxh6saqANnxHCe0vh0jkPRA=;
  b=f/hsSPMPEmMdSSTjj0MAI1B65y8CuJJPMcsf0WS8dRGd+0oCyxsRS3Jo
   63BlVpkRudEAa2nB/7cCbrowzlLvRSp4sVnGIM016LtL1qLSyKxwp4Yyj
   yTUQh79IEdLYnC7+rfNdZEEXQEU18ajTC55ZBv4m+y+gawVr18w08g0RH
   Zgmwl1/IR7BR8EB/6Xh3RI9cOrSRRKmJZzWoVxikT9aTAAOaqp4vYnVV4
   YJkXqD6K/uEpibQEA9IBXdQiY4ZJuteaTpI0PFds5sdDwoYx7goB1qjrp
   r5vwLhupQMVuKjbegZa5E5ePUBWXSaoa9J84czwh9Za8Ys0qA5xJz+LXG
   w==;
X-CSE-ConnectionGUID: pmjIoI0MR+2HPWbKWmKahQ==
X-CSE-MsgGUID: POPulYHkSWOdr4UkQwsJjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28213911"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28213911"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:07:39 -0700
X-CSE-ConnectionGUID: LNtUFH2eQaKHmhzqXGMEpA==
X-CSE-MsgGUID: 5YY7U31bTISZ/v700fFZuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77387576"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:07:37 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org,
	Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH] drm/xe/ufence: ufence can be signaled right after wait_woken
Date: Fri, 11 Oct 2024 15:25:32 +0200
Message-ID: <20241011132532.3845488-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

do_comapre() can return success after wait_woken() which is treated as
-ETIME here.

Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
Cc: <stable@vger.kernel.org> # v6.8+
Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index d46fa8374980..d532283d4aa3 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -169,7 +169,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 			args->timeout = 0;
 	}
 
-	if (!timeout && !(err < 0))
+	if (!timeout && err < 0)
 		err = -ETIME;
 
 	if (q)
-- 
2.46.0


