Return-Path: <stable+bounces-78344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D098B777
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C585282739
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F019AD87;
	Tue,  1 Oct 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+1IqR6u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8F19CC0F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772255; cv=none; b=b6HazLLAdRKV6uQsMk97j7NhkjVh0U2gjjZTHhpGxCJf/NF6/3QkTTWF8kVNmOe2z7RlLl/Dza2Te2HVZjLS/FYIsWtebmTpKzGkVKNPsBCVbu//QOrev2W+OFDNqM6PUCwAYR4D7QxQiNDEHcTGpDAYSe5OFlhJCCfmDr73BDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772255; c=relaxed/simple;
	bh=db3UHJh35L4cGJx/Hqhgo2aQFFxUN/bvEq43r+t7vBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjPhSXupDJrJHkKAHQC5rVenFoFWpGl7nSY6PS0Zx72/skurZLmGsDzDMwcooRoUk84TiSF+K1gJudjXHtzQAaH5o3GJrMYlK2frQgtMrGMi7mwFpAT90N/J2Vdt37C68rHrdA7gfQo9esxrGj3XDR8xEwl37SJ2Sj/WbOHvQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+1IqR6u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727772254; x=1759308254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=db3UHJh35L4cGJx/Hqhgo2aQFFxUN/bvEq43r+t7vBs=;
  b=X+1IqR6u+U5ujBchlKpLG+o6koD7mlgsTc7AFq7rV4wk1x5rp836pKsq
   /YzsdVL8B1w6MDvRqiI48hJUIBpismd9wzWuqOGxQMQ+MJxuza5NT+APM
   5Ri+zzZVsmUPpv9B55GueEUVA5UYS5QVy+Fc+UwCXkIOJV1GgFvLLIChq
   7XjF7Z6RJLW04r3mPZf5YQQOPejoPyt20rJC4Mqvhq3eIZ4WVOYqeKAun
   96LZMktUJWekuEAiGNG5e3RpQXakFsW7bqWiN6qdR0u1UNG4Ubp9rCfEm
   0OiSmOktW6Xhv/gUy9C9V+pAeb1uv4LBD99GKsSBGfjc4WhPVJP9BWEoO
   A==;
X-CSE-ConnectionGUID: tqMsCTwNQ7ygDTd2/8c3vg==
X-CSE-MsgGUID: GSEaTsrSS7GEzUVUV0NFVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="27020720"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27020720"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:14 -0700
X-CSE-ConnectionGUID: Ogcyf97HQdOlcyHn+TliRQ==
X-CSE-MsgGUID: GqqBy7ZvSiWq7pinIBnF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104413738"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:44:12 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/xe/guc_submit: fix xa_store() error checking
Date: Tue,  1 Oct 2024 09:43:49 +0100
Message-ID: <20241001084346.98516-7-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001084346.98516-5-matthew.auld@intel.com>
References: <20241001084346.98516-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like we are meant to use xa_err() to extract the error encoded in
the ptr.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 80062e1d3f66..8a5c21a87977 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -393,7 +393,6 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
 static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
 {
 	int ret;
-	void *ptr;
 	int i;
 
 	/*
@@ -413,12 +412,10 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
 	q->guc->id = ret;
 
 	for (i = 0; i < q->width; ++i) {
-		ptr = xa_store(&guc->submission_state.exec_queue_lookup,
-			       q->guc->id + i, q, GFP_NOWAIT);
-		if (IS_ERR(ptr)) {
-			ret = PTR_ERR(ptr);
+		ret = xa_err(xa_store(&guc->submission_state.exec_queue_lookup,
+				      q->guc->id + i, q, GFP_NOWAIT));
+		if (ret)
 			goto err_release;
-		}
 	}
 
 	return 0;
-- 
2.46.2


