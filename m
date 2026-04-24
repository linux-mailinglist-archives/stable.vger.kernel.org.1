Return-Path: <stable+bounces-240563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJORNbMI62lvHgAAu9opvQ
	(envelope-from <stable+bounces-240563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:07:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEE45A27E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE52A300F510
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221AD34A767;
	Fri, 24 Apr 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLJ6jrt5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF4340282
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777010864; cv=none; b=rgfaZeuYzMMSyeXXKuoh31Q9+H0NPNWbEc7pBECp4R9SHGrpdw4dKXlFmWmJJvzxTQ6qoFpSinUEQE0Iip8yqa4/iPdCuM6Ezoj3AOg3evLEwgUag8yyGvmUcjKPgSmmZrqQlJImNIB7L20eZw2wpa1BHGBeGo+QaEA363teCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777010864; c=relaxed/simple;
	bh=JSPx+6IfXN+/99zgJPnD5tKlVWiTGBXQ+oLisOcAL2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myYD+cYocW9M2ie+lXYiqwXFbOn1MbZ+0xUIN9XfERy8jz+34M5pG6QvyO6ilZH57BqL+raeFZ5cV9z6CGdIHf+YMM7WHzSzxfLR3/XdN36pJI6Sp2NbZIGXKToNiAMgrh8IhDfYjEazagJvNlUubse3BTvI6uKUutzDps3ul/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLJ6jrt5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777010862; x=1808546862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JSPx+6IfXN+/99zgJPnD5tKlVWiTGBXQ+oLisOcAL2s=;
  b=LLJ6jrt5nSUjjsFJFQ6MwJNIUySD2m9giZmtl5L+eSd6bLeRwfa3M/WA
   ykaxEEQwImKJVRmlGSqmz6iFz3u48r/X/NAiWCRUCh1sCryoCizLRjnRR
   wIs40Xxaqx58FJi4l9BCtMoEsh2q9WmLP9cephEXoWRolgflydwKXVHub
   UWnel3Fwu+QazKbv7nPsPMgYUg4lXb8RzlefrPebW4+cov3ScbacIb+vm
   ESmfC6SEqQfzJyZQOdrIH5KQLSPyx1q+xR9md7h9wt3e6fIFJAyujVwH2
   Rb0YjukQrwaae2uC8M4tFrU60NDA8UYj/cp/YxBGF/dzu0yWfKA+rbVbK
   Q==;
X-CSE-ConnectionGUID: gFHGlPb/RN6mD0NaEbu87g==
X-CSE-MsgGUID: qUlpA90WR5aiGaNBf4kx/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77690819"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77690819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:07:42 -0700
X-CSE-ConnectionGUID: dRf7tJ2hQa+v7Midt8McKg==
X-CSE-MsgGUID: aWo7DJ/zTnGX/0TjQON4Jg==
X-ExtLoop1: 1
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2026 23:07:40 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	chaitanya.kumar.borah@intel.com,
	pranay.samala@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/i915/display: Copy color pipeline from plane in the primary joiner pipe
Date: Fri, 24 Apr 2026 11:11:27 +0530
Message-Id: <20260424054129.2148049-2-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260424054129.2148049-1-chaitanya.kumar.borah@intel.com>
References: <20260424054129.2148049-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CEEE45A27E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When copying plane color state in a joiner configuration, use the plane in
the primary joiner pipe since it carries the pipeline number selected by
the user-space.

This assumes that all pipes in the joiner are symmetric in their plane
color capabilities.

Cc: stable@vger.kernel.org # v6.19+
Fixes: a78f1b6baf4d ("drm/i915/color: Add framework to program CSC")
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d08e9166824b..a8efe0011b23 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -398,7 +398,7 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 	if (!state)
 		return;
 
-	iter_colorop = plane_state->uapi.color_pipeline;
+	iter_colorop = from_plane_state->uapi.color_pipeline;
 
 	while (iter_colorop) {
 		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state, i) {
-- 
2.25.1


