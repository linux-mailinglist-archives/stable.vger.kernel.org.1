Return-Path: <stable+bounces-262869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5W2HLEuwK2p9BwQAu9opvQ
	(envelope-from <stable+bounces-262869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:07:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD56771C8
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:07:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WMfki1yo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262869-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262869-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752F330F5A32
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40F31AF07;
	Fri, 12 Jun 2026 07:04:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E2D94BA
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:04:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247857; cv=none; b=XUBIbK67Y31kYGEVpxRptGSyfzcNIXq/rXDEeV76zGsdnLuD2mODI0q/RfNROqlj4hkuWCOCdF5m8PMfBj3HU52fUH5QlSg8MDLfDJ4D1kGFBAL9kBwlikCZn4KxZWTYt0ECN89EWCxJjXDgLZz2WoL9laQHSUKYv4OE/QaqzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247857; c=relaxed/simple;
	bh=6kwqU0zLEAgeeI/DL2ujqskXuExfGE4u6+mDD6PU7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWQzr7MZRqoraUdRW6660uHY4PF73mqSeQ4EaRIc/UZzZYY/sUvfqTRviN887hr8sGfzinU8nYUMbSjnwgA/jXiOOS8Ep2Ouw7Oa9G99RSCZ10eJ5EuPPliSpunWnKVfwdwZN9zNX5NaeH3f5nXHM+W1ruOSRmBbh3JwI6eTBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMfki1yo; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781247856; x=1812783856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6kwqU0zLEAgeeI/DL2ujqskXuExfGE4u6+mDD6PU7Y0=;
  b=WMfki1yorshpcPWPJATh+ihuBUUW5D8VbhYVdNpBHMo457H2dxH2RmZJ
   CEChcPQjIvRkkg3Qf//GKiQFaSiSup9ufpwm4qag+1kuCC2wPsG5FmLwo
   YrKyE4MRCyk7+ozVjqYbQ2nvqqrGklyoRHChvHtt1APiZ2tMCIAhe8axX
   xdMtbR28lEABxWX+qg2VmaFl42AmBgrZTYUbAEq8puRxKj6ErPmRNhTNM
   T+MRlMhAdmTwHSO2eNvME0Th74GVUXNf+R+kB94ttcHEKomgD8veaoTSg
   6Qd5XWacRL71RXOaOAneGLJoyjX92w3ofq95LQOMHtijp2Y4V0M8luj3z
   g==;
X-CSE-ConnectionGUID: cfjKmZVfRKGVeRBp3C9q3w==
X-CSE-MsgGUID: dBfIwCGiQNKj4hC0VjMNMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99652370"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="99652370"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 00:04:15 -0700
X-CSE-ConnectionGUID: VuryZ3gtTRq5W3XXdBVCDA==
X-CSE-MsgGUID: Pcxr6bzGRd+7Sk/ygUqTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="240392871"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk) ([10.190.239.37])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 00:04:14 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list allocation
Date: Fri, 12 Jun 2026 12:34:02 +0530
Message-ID: <20260612070401.543305-2-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262869-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tejas.upadhyay@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:tejas.upadhyay@intel.com,m:zhanjun.dong@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tejas.upadhyay@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FCD56771C8

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
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: GitHub Copilot:Claude Opus 4.6
--
v2:
- use bitmap_weighted_or() (Zhanjun)
---
 drivers/gpu/drm/xe/xe_guc_capture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 21f7caf9ea08..1a019137ddf4 100644
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
+		total = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
+					   gt->fuse_topo.c_dss_mask,
+					   XE_MAX_DSS_FUSE_BITS) *
+			guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	}
 
 	if (!total)
 		return;
-- 
2.52.0


