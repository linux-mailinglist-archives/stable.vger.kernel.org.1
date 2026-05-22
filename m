Return-Path: <stable+bounces-253828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF2lAwClEGqYbwYAu9opvQ
	(envelope-from <stable+bounces-253828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:48:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A05B927A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF1F83009B32
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A9377ED2;
	Fri, 22 May 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C03bcIVb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838B35F610
	for <stable@vger.kernel.org>; Fri, 22 May 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475693; cv=none; b=HHrclqAotWVYP/06ukDwgeD5GyxK6sOfFmB08a+bH+xRya+TNIsTWnlRXuYgohK6I784D3P5hs6lNycWwVKlJeA7RUGlPXxx1PfT4GzrYQVPh3Emihj6gPjy5DWESxMWeOANTxNAENm+hWj3JgC2Mf1Qz8M5V8wqZ5GBYBQc+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475693; c=relaxed/simple;
	bh=KVk+azdU64nporbz/LWFbIPvUFe85iqeZkoA4XIsKGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox5P4KIv/G4+lFC1JlEqFmOwSuKxzeU4GPXdrUtV2ZCB+pNXLVtA0h+WPfpBHQUjE41FLTyMpaVCoiCcLbD6R0CIviI3FdXdh+AWM+isbw1MnM0ByvnMM8X7yrcy6+ePsn2vukMAySO12rbIj1e4B3XygFeNUHqUginCg7rJbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C03bcIVb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779475693; x=1811011693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVk+azdU64nporbz/LWFbIPvUFe85iqeZkoA4XIsKGQ=;
  b=C03bcIVbwrgL3ER1XFvtwRgJPpzAue++ejxpMvdDueRMFKcUVvDzpoW+
   C2Qa9XmCNorX0WsuF8+TLN0hBrKpphwARibhM3y9569W1LdyKyPJt5Lgb
   EPBuMycgm8mPcgSIUYyBEjnwL73PnGn1MD60TDQG2LqMBzoYZaSJ/4mvw
   2cS1SfBdM0+36Zybb14MXg2yDbqFDHd65iTd0d6kwSpJ9+gqkZRA1eQie
   PT7CbBVKouYD8sqlbdWmRlOxxfF9IPB5rmOsYl1mTwgPnM8xlo0Z5/Ri1
   cLDzDyPXCRlgbsxD1xBuoJLlU6sLR33KhLlGnpDMoUUl9zOEtfjkPuoIY
   A==;
X-CSE-ConnectionGUID: 2Xm+JL3pTsC+2tQiE5ODRQ==
X-CSE-MsgGUID: LkVLaxLYTkqjntq92Y2IUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="84293854"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="84293854"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:48:12 -0700
X-CSE-ConnectionGUID: RuAE+18+SW6gWfyYrmcGJw==
X-CSE-MsgGUID: 99CGu0hPQeiwbitLtf/EfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="279094107"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.124.223.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:48:10 -0700
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	matthew.brost@intel.com,
	matthew.d.roper@intel.com,
	shuicheng.lin@intel.com
Subject: [PATCH 6.18.y] drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()
Date: Fri, 22 May 2026 15:47:22 -0300
Message-ID: <20260522184742.119776-2-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051542-traps-bubbling-c3d7@gregkh>
References: <2026051542-traps-bubbling-c3d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo.sousa@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 798A05B927A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When media GT is disabled via configfs, there is no allocation for
media_gt, which is kept as NULL.  In such scenario,
intel_hdcp_gsc_check_status() results in a kernel pagefault error due to
&gt->uc.gsc being evaluated as an invalid memory address.

Fix that by introducing a NULL check on media_gt and bailing out early
if so.

While at it, also drop the NULL check for gsc, since it can't be NULL if
media_gt is not NULL.

v2:
  - Get address for gsc only after checking that gt is not NULL.
    (Shuicheng)
  - Drop the NULL check for gsc. (Shuicheng)
v3:
  - Add "Fixes" and "Cc: <stable...>" tags. (Matt)

Fixes: 4af50beb4e0f ("drm/xe: Use gsc_proxy_init_done to check proxy status")
Cc: <stable@vger.kernel.org> # v6.10+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://patch.msgid.link/20260416-check-for-null-media_gt-in-intel_hdcp_gsc_check_status-v2-1-9adb9fd3b621@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
(cherry picked from commit bfaf87e84ca3ca3f6e275f9ae56da47a8b55ffd1)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
(cherry picked from commit 60a1e131a811b68703da58fd805ab359b704ab03)
---
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index 4ae847b628e2..6324f526dcfa 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -35,11 +35,19 @@ bool intel_hdcp_gsc_check_status(struct drm_device *drm)
 	struct xe_device *xe = to_xe_device(drm);
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
-	struct xe_gsc *gsc = &gt->uc.gsc;
+	struct xe_gsc *gsc;
 	bool ret = true;
 	unsigned int fw_ref;
 
-	if (!gsc || !xe_uc_fw_is_enabled(&gsc->fw)) {
+	if (!gt) {
+		drm_dbg_kms(&xe->drm,
+			    "not checking GSC status for HDCP2.x: media GT not present or disabled\n");
+		return false;
+	}
+
+	gsc = &gt->uc.gsc;
+
+	if (!xe_uc_fw_is_enabled(&gsc->fw)) {
 		drm_dbg_kms(&xe->drm,
 			    "GSC Components not ready for HDCP2.x\n");
 		return false;
-- 
2.53.0


