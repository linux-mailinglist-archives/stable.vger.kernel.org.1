Return-Path: <stable+bounces-224820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q/AAF0x7smkENAAAu9opvQ
	(envelope-from <stable+bounces-224820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:37:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40426F058
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C419C3023A7D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111F34D93C;
	Thu, 12 Mar 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1DsGTGu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7E34B661
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304648; cv=none; b=kEG30QcbhnNjKkDDVCxky/IN/OfNI7Tw43KVreIIpiS5frKPLmFqeD7FZsqC1+UpvYdahnf1+05rnVc0/kSd/nvX8qFxOy+RSqLQZr3/ryzdOBMLF55NI7uWQfeKxjCvZsKsOx7WBh2/RUmGg8rqnneiNIf2RC/8Bokco7Unc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304648; c=relaxed/simple;
	bh=+PDs5kO4XWxeWJLel8FIrYbpdAkDxtWwyfQYc507CXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4r6mQhmaJ8wq2DlKzDiIYkJF6BgGMissI/w+eUGQrTeNHGJ1LEML40NZA9mgS53z7D0dyz2K7N7o+oeeCsHWRXbY8PsHhhmj2nTteFnQzOqYPqX/kPwA0lFN2a73y1+ArHltJ2PUdkKOboXTZoPm9hgL8hk11/iqB7VQYUUT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1DsGTGu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773304646; x=1804840646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+PDs5kO4XWxeWJLel8FIrYbpdAkDxtWwyfQYc507CXo=;
  b=m1DsGTGu+zEEtwIgJH9RSDGSTJe05RU1XG6IRQkAwcofiY6mauBz7/Ar
   TmxwP0zIBFiaSEeXL+2OHF3YteGCQsSRLF7FdTKrgLrGvHv/IGt9vgKGW
   OOrvq+ZExGjG3ZyAhqAk429KMJz+fzQTkoqR01c6p6BuP7B57dWsCPhI9
   Z2TrzJbCgGkI7RNmHJFTw/dTSLBZ0C2H/PSGPfNOTrJ7nda8UClNF2EDm
   8PNkWIDvi4uhNkQQ0MZqKRMZlbWukV2svYrejlebv+Zp7do7rzZa3T1HJ
   rMdk2XsmYhH9WGuUBITbCjIhFNPUvgqsco9ZKxHn69Xpzdq2HSpCwtSxw
   w==;
X-CSE-ConnectionGUID: t3g9qPkITmGHtxMgF5bULg==
X-CSE-MsgGUID: IbLXaKldSIiPReJPulFQcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74280164"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74280164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:37:25 -0700
X-CSE-ConnectionGUID: cKEma0IuQOCq4J9dLdzdiw==
X-CSE-MsgGUID: PZ+hXmPqSHKBUU9YXMSEkw==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:37:23 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/psr: Disable PSR on update_m_n and update_lrr
Date: Thu, 12 Mar 2026 10:37:09 +0200
Message-ID: <20260312083710.1593781-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312083710.1593781-1-jouni.hogander@intel.com>
References: <20260312083710.1593781-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224820-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CF40426F058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PSR/PR parameters might be changing on update_m_n or update_lrr. Disable on
update_m_n and update_lrr to ensure proper parameters are taken into use on
next PSR enable in intel_psr_post_plane_update.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15771
Fixes: 2bc98c6f97af ("drm/i915/alpm: Compute ALPM parameters into crtc_state->alpm_state")
Cc: <stable@vger.kernel.org> # v6.19+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 5041a5a138d1..7e0e4c3bf985 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3112,6 +3112,8 @@ void intel_psr_pre_plane_update(struct intel_atomic_state *state,
 			 * - Display WA #1136: skl, bxt
 			 */
 			if (intel_crtc_needs_modeset(new_crtc_state) ||
+			    new_crtc_state->update_m_n ||
+			    new_crtc_state->update_lrr ||
 			    !new_crtc_state->has_psr ||
 			    !new_crtc_state->active_planes ||
 			    new_crtc_state->has_sel_update != psr->sel_update_enabled ||
-- 
2.43.0


