Return-Path: <stable+bounces-225617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMKVNWYyuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:40:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37929D888
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E705230186AB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DDE3BA231;
	Mon, 16 Mar 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mafykr8q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2643B9D8C
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679204; cv=none; b=aalNqi9zvwT4iMGgUdUZZbOkVEZkxGUcU9/Mzlfrd/2Z96/M2OfLMrPPU4c/BFjb81Q0nWRa/iGCpzZtuL6DaN2jlaVenons9SWNa4s5110fTWQo4XWZnQvVr5l8SZtr+vBn4Am6G3BaawATaf46INoCNqksAroYAy0esOY+JOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679204; c=relaxed/simple;
	bh=X+1cXAGqYt76ApyxRWpM6zbw57LF77SbCAxABu90hy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJrNZuaS1w4IgufY80RLrEDkZv8623QzLJrtuvLkio3QDAprhfluqkUaMwoutU4EuBvBHOZtJ++uUiZS9sa4rt/cJsgym1sn7IypAxJeJ3mStf2ExGvRYNw/gI+RSpcZrFYrfuV9QByKGKDn/6aBu92mrg857pYMt0akg8B2TSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mafykr8q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773679203; x=1805215203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+1cXAGqYt76ApyxRWpM6zbw57LF77SbCAxABu90hy8=;
  b=mafykr8qiLroX3CsettQayFoWHlOF5m0TvT1AbBGMDypobK2o30Qg5fS
   wQewjj9KshCpupyVg7sN+OF8ZY3Dw7PP+3ZJDOnWS9KXpFklgiq5Vb5wt
   +o4B+5f4bHvpFoksT2V2nl3CyKbLehyoR9CDBnKxH3w408CXo8plzKGts
   9DmtYc0/OQAIwZx7T9HPkRYnWmixNETtEV3fm+8FyYt4ppndX7oGdKnyb
   h8fajlbHrlIMVGpZKhb0sZJiMSslhvhD5F7ZBr9+HjTBc69Wtp+tJfJnK
   e1jY5VwXDiAnmZesvrNQpHON+qEppSWygkh9gw9SRar4o0yhJfXtOJWvQ
   w==;
X-CSE-ConnectionGUID: N1+WdVRaRui3xZqU1J7T8w==
X-CSE-MsgGUID: 4Z4H+pdnTvGFfM14tPQ5FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74735678"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74735678"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:40:02 -0700
X-CSE-ConnectionGUID: u/8TmVzeTKKfi1s3ZUog0w==
X-CSE-MsgGUID: tdWv/I/OR9+oXmjQh/Bbkw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.42])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:40:00 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Khaled Almahallawy <khaled.almahallawy@intel.com>
Subject: [PATCH 1/3] drm/i915: Unlink NV12 planes earlier
Date: Mon, 16 Mar 2026 18:39:51 +0200
Message-ID: <20260316163953.12905-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316163953.12905-1-ville.syrjala@linux.intel.com>
References: <20260316163953.12905-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225617-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F37929D888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

unlink_nv12_plane() will clobber parts of the plane state
potentially already set up by plane_atomic_check(), so we
must make sure not to call the two in the wrong order.
The problem happens when a plane previously selected as
a Y plane is now configured as a normal plane by user space.
plane_atomic_check() will first compute the proper plane
state based on the userspace request, and unlink_nv12_plane()
later clears some of the state.

This used to work on account of unlink_nv12_plane() skipping
the state clearing based on the plane visibility. But I removed
that check, thinking it was an impossible situation. Now when
that situation happens unlink_nv12_plane() will just WARN
and proceed to clobber the state.

Rather than reverting to the old way of doing things, I think
it's more clear if we unlink the NV12 planes before we even
compute the new plane state.

Cc: stable@vger.kernel.org
Reported-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Closes: https://lore.kernel.org/intel-gfx/20260212004852.1920270-1-khaled.almahallawy@intel.com/
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Fixes: 6a01df2f1b2a ("drm/i915: Remove pointless visible check in unlink_nv12_plane()")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index e06a0618b4c6..076b9b356481 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -436,11 +436,16 @@ void intel_plane_copy_hw_state(struct intel_plane_state *plane_state,
 		drm_framebuffer_get(plane_state->hw.fb);
 }
 
+static void unlink_nv12_plane(struct intel_crtc_state *crtc_state,
+			      struct intel_plane_state *plane_state);
+
 void intel_plane_set_invisible(struct intel_crtc_state *crtc_state,
 			       struct intel_plane_state *plane_state)
 {
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
 
+	unlink_nv12_plane(crtc_state, plane_state);
+
 	crtc_state->active_planes &= ~BIT(plane->id);
 	crtc_state->scaled_planes &= ~BIT(plane->id);
 	crtc_state->nv12_planes &= ~BIT(plane->id);
@@ -1513,6 +1518,9 @@ static void unlink_nv12_plane(struct intel_crtc_state *crtc_state,
 	struct intel_display *display = to_intel_display(plane_state);
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
 
+	if (!plane_state->planar_linked_plane)
+		return;
+
 	plane_state->planar_linked_plane = NULL;
 
 	if (!plane_state->is_y_plane)
@@ -1550,8 +1558,7 @@ static int icl_check_nv12_planes(struct intel_atomic_state *state,
 		if (plane->pipe != crtc->pipe)
 			continue;
 
-		if (plane_state->planar_linked_plane)
-			unlink_nv12_plane(crtc_state, plane_state);
+		unlink_nv12_plane(crtc_state, plane_state);
 	}
 
 	if (!crtc_state->nv12_planes)
-- 
2.52.0


