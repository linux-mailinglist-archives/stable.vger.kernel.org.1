Return-Path: <stable+bounces-253839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE9TNE2yEGpWcgYAu9opvQ
	(envelope-from <stable+bounces-253839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2D5B993B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5719C3005AD0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D0349CCB;
	Fri, 22 May 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEx3xRgE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9C376BC6
	for <stable@vger.kernel.org>; Fri, 22 May 2026 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478910; cv=none; b=KXgQVd5uhTyv3QKG+6Lu9ki6ngSkr/7PT7XYtXZgUVJ7AjVVqpGy3AcLqp4OsIofQOawjIcrTI/KZk9ma7V0yLpGaL7VuGZUwB0HsLxwp2lf3WqJJZjv4YAEKggEikhgx77tGQVyXI6m/alCUgJ0fjs7sM7dhK1kSOWAL+moiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478910; c=relaxed/simple;
	bh=WVeaZxXefflV1ZoX6LqAyQ0zuNjwPHQ2yUvMR+Jjf5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nosEm1MUcWNOHIA8k+I9zlvDpXkCNJY61vQ0+WYgQLrxK9S+M4myIOXVcqfKgmlM/waOeKIe9Tj2KsEMOygDzJ5K/V+szwT/2mjQpdtgk4hSAMMSItG09YmF+CKKZCa5+3DXQbDQjk6FJYSL4oWuDNOP6pxIrAgwGg45dfRtxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEx3xRgE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779478909; x=1811014909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVeaZxXefflV1ZoX6LqAyQ0zuNjwPHQ2yUvMR+Jjf5Y=;
  b=oEx3xRgE2Nc3QL8BHIi2UnelipE+ktqTIXVcHaMm9qHNp+SA9z9MlOP6
   Gqu+7MZ6aGsy5289kUCcpfoTw1U9ER/uRRaDWcf7PT4tTWLRuA0cFuvmv
   12NKM1LfFQSI/uCnRwdL4PRi6c1pe1Jl1dg1CEQtbZeceJqtws6EG/LOF
   eDI+gz7O1NxgeX8nZczCE7rY3APnBSetKuGvLawjSFAYF3YfkMcgQMwyP
   OnTVNl6sStLAu59B++USFnT1ByMNeZwWMVyy4TeqcYWu8ewkNXQiZ81fT
   MUaVuABgT7TDBWEDiz/cnondYqRjGU27Gx+ohZuWt+8SxsIm3SnMfdmfe
   w==;
X-CSE-ConnectionGUID: bwe9PnUTQ1yug5stYSv7OA==
X-CSE-MsgGUID: K8tZHpfyRiqPHfjZkIYmuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97838400"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="97838400"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:41:47 -0700
X-CSE-ConnectionGUID: NDqlCsfeQNux6ggXXrmrrw==
X-CSE-MsgGUID: OvGtYfDzQpe8ZVwh8xdULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="237966470"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.124.223.186])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:41:45 -0700
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	matthew.brost@intel.com,
	matthew.d.roper@intel.com,
	shuicheng.lin@intel.com
Subject: [PATCH 6.12.y] drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()
Date: Fri, 22 May 2026 16:40:58 -0300
Message-ID: <20260522194134.126626-2-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051542-splatter-narrow-b00a@gregkh>
References: <2026051542-splatter-narrow-b00a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253839-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 2DF2D5B993B
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
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
---
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index f4332f06b6c8..695d625c83ee 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -39,10 +39,18 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
-	struct xe_gsc *gsc = &gt->uc.gsc;
+	struct xe_gsc *gsc;
 	bool ret = true;
 
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


