Return-Path: <stable+bounces-262184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BjW6DUirJ2qC0QIAu9opvQ
	(envelope-from <stable+bounces-262184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 07:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477165C8E2
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 07:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=F22a8Tb3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262184-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262184-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B553059186
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 05:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D53C81B9;
	Tue,  9 Jun 2026 05:57:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B61A6823
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 05:57:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984642; cv=none; b=CDsGPoD5hrqYpBqx+mdeoLLrChGruqBjyc4v22oh5o38hKHOZwroOZEj9HMbSAJxntemzrdczCM4tI2tM67NOMjyDyUOSUr0OhZgzDpWB2GVDFQIGENjd/fYoQmPOt+4a5jEq1UCfpN/DIYBeURdG0/Cpc5mb75uNNx+nrhpGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984642; c=relaxed/simple;
	bh=e33XHZt40DK+LETfjffUuyaHnJdVe3d2u69qNT7FblA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkULDVB7YDYb7Y1J8+lfyjAPrx+zNAKb4L/b5je7JYsTobqdfwxcgDjz/lMdVKnM54hmTc2FeWnuwPjqb4QeqszUjiB+sCD2c37N5GZF3Kpw5n7vyc7xE/xKDUK0l+FknAeWWOGehiSLmnCayHpZ23fcciuIvDtjEHMhFaX06yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F22a8Tb3; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780984641; x=1812520641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e33XHZt40DK+LETfjffUuyaHnJdVe3d2u69qNT7FblA=;
  b=F22a8Tb3G9DyBG8s0XCWeegstOf3MQ4cxkwJQmqoFgfxK8Z0z+Kf/dl6
   X2YWCXckMlS2PXCQA0P688mwTvKAtfTZZ4uo8BuzGMONY+twWY3127gtc
   gMrGZEzCUU536ugoejh8AINL1wAkp30kzV28b/R3aA0RTT82w41hNd+1+
   84qtjnU1m/aY1AUmCYRVzD6qokZOrhW+C8YPuOP7Q7ENPzzOma1snCqnd
   M9a5szB1/BZiaoNZKMpTC+s7Rj/MGcvgH+R/N6oQiqmKsTGCzMlUPOcKp
   JanwMHvHg4f+TPAEq3CzVsPFSXYjUk5nJGeLvII6UkHe2bNS/r8LKbak7
   g==;
X-CSE-ConnectionGUID: 0N4NjhiqRDuMOR77k4Dpmw==
X-CSE-MsgGUID: qfXCQSmYSVKbtpEti/XGkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99153993"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99153993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:57:21 -0700
X-CSE-ConnectionGUID: 4ehlEUvXQ2uSKXW+x5GqNg==
X-CSE-MsgGUID: f3hP7JhrTd+NUmz/xkn6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="242822695"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk) ([10.190.239.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:57:18 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list allocation
Date: Tue,  9 Jun 2026 11:26:58 +0530
Message-ID: <20260609055657.440911-2-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262184-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:tejas.upadhyay@intel.com,m:zhanjun.dong@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tejas.upadhyay@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tejas.upadhyay@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9477165C8E2

The size calculation for the steered register extarray uses only the
geometry DSS mask (g_dss_mask) to determine the number of entries to
allocate:

  total = bitmap_weight(gt->fuse_topo.g_dss_mask, ...) * steer_reg_num;

However, the filling loop uses for_each_dss_steering(), which iterates
over for_each_dss(), defined as the union of g_dss_mask and c_dss_mask
(geometry + compute DSS). On platforms with compute-only DSS bits, the
loop writes past the allocated buffer, corrupting adjacent slab objects.

This manifests as list_del corruption and SLUB redzone overwrites during
drm_managed_release on device unbind, since the overflow corrupts the
drmres list_head of neighboring allocations.

Fix by computing the allocation size using the union of both DSS masks,
matching the iteration pattern of for_each_dss_steering().

Fixes: b170d696c1e2 ("drm/xe/guc: Add XE_LP steered register lists")
References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: GitHub Copilot (Claude Opus 4.6)
---
 drivers/gpu/drm/xe/xe_guc_capture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 21f7caf9ea08..181e8b60357d 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -461,8 +461,14 @@ static void guc_capture_alloc_steered_lists(struct xe_guc *guc)
 	if (!list || guc->capture->extlists)
 		return;
 
-	total = bitmap_weight(gt->fuse_topo.g_dss_mask, sizeof(gt->fuse_topo.g_dss_mask) * 8) *
-		guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	{
+		xe_dss_mask_t all_dss;
+
+		bitmap_or(all_dss, gt->fuse_topo.g_dss_mask,
+			  gt->fuse_topo.c_dss_mask, XE_MAX_DSS_FUSE_BITS);
+		total = bitmap_weight(all_dss, XE_MAX_DSS_FUSE_BITS) *
+			guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	}
 
 	if (!total)
 		return;
-- 
2.52.0


