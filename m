Return-Path: <stable+bounces-230348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJl3Djnsw2kAvAQAu9opvQ
	(envelope-from <stable+bounces-230348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:07:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF42326713
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B84F30CA2A7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E03D4121;
	Wed, 25 Mar 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpYPVYGD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6B3D16E2
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447141; cv=none; b=W2jP9PkNoylgLQcmRerm3uj4TLHg3mcSQeoJrOXLHpI6S4TWdQXMJ1K02K3HkDWB2NRh72FbRALnOo1QugBJTeGUXzzZYmlmBJt/vTvtHR8qL1MT+8h8TtB0L0wWaPFU6bTcef7Vr+Ko2heUMMoMPOicoOSWw3K96Da31tQAIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447141; c=relaxed/simple;
	bh=1Bs3HTNovwBrxNg0Idc4gwX/7gpAmETVXtpcJvZYEkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQRe+EmGEdelhhGXr1e4/fu58PJQwrA37YltdUqJvERfMsmq4tI1l4HSzDd3l4DsJnmmnShz3jCv5UYBggzthjpJ+xdYBI7yqJIAt7+zxkwPIgeDklHCPyiWFFCTJpouFr+vjMg15Cfd1/N/oT+HfdYz6uCVkwFr0rDvg2UQ7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpYPVYGD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774447140; x=1805983140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Bs3HTNovwBrxNg0Idc4gwX/7gpAmETVXtpcJvZYEkg=;
  b=ZpYPVYGDPp7ftDsnSIdFkJSqZXgy5azpDGti5W59LHREP5mzpL/GtVLs
   zJEcwNZ/sscSjLBVmoNQgdFiCgXsWl6bG9SLvRy7+4/9YX9L4rIQE4rU+
   slkO4Gkj3yOLU0HlQYWyqpu2+7zYwcTQLwu7Z2s/i2az4J36ct+kt0fmr
   CJ6Uq290bPlCvxrib9a9HUHs01ABw9JpRd8O04QiH+yyEZqTN3lt0FTzD
   oaNelCOoX7LGQ9P4aUNkQNcph7RqspkelVzz46LGGNQGs/v7/cZ5HaZCf
   c2lypheDTN+7erpBLBHImmk9o562DB4tFRwrqQ55WpH+qpU5sQ+hBmz96
   g==;
X-CSE-ConnectionGUID: 7OP73qG6Rz+cxYwLQHA33w==
X-CSE-MsgGUID: ZA0oPjzWR5WxV401STkjnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75365772"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75365772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:58:58 -0700
X-CSE-ConnectionGUID: yflzpG0ERJmbhqLQNkf7mA==
X-CSE-MsgGUID: ihxccJVjQp2CMjzXpJQA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248197423"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:58:56 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 1/6] drm/i915/cdclk: Do the full CDCLK dance for min_voltage_level changes
Date: Wed, 25 Mar 2026 15:58:44 +0200
Message-ID: <20260325135849.12603-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325135849.12603-1-ville.syrjala@linux.intel.com>
References: <20260325135849.12603-1-ville.syrjala@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230348-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: CCF42326713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently I forgot about the pipe min_voltage_level when I
decoupled the CDCLK calculations from modesets. Even if the
CDCLK frequency doesn't need changing we may still need to
bump the voltage level to accommodate an increase in the
port clock frequency.

Currently, even if there is a full modeset, we won't notice the
need to go through the full CDCLK calculations/programming,
unless the set of enabled/active pipes changes, or the
pipe/dbuf min CDCLK changes.

Duplicate the same logic we use the pipe's min CDCLK frequency
to also deal with its min voltage level.

Note that the 'allow_voltage_level_decrease' stuff isn't
really useful here since the min voltage level can only
change during a full modeset. But I think sticking to the
same approach in the three similar parts (pipe min cdclk,
pipe min voltage level, dbuf min cdclk) is a good idea.

Cc: stable@vger.kernel.org
Tested-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15826
Fixes: ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from state->modeset")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 121a12c5b8ac..a47736613f6e 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2972,6 +2972,53 @@ static int intel_cdclk_update_crtc_min_cdclk(struct intel_atomic_state *state,
 	return 0;
 }
 
+static int intel_cdclk_update_crtc_min_voltage_level(struct intel_atomic_state *state,
+						     struct intel_crtc *crtc,
+						     u8 old_min_voltage_level,
+						     u8 new_min_voltage_level,
+						     bool *need_cdclk_calc)
+{
+	struct intel_display *display = to_intel_display(state);
+	struct intel_cdclk_state *cdclk_state;
+	bool allow_voltage_level_decrease = intel_any_crtc_needs_modeset(state);
+	int ret;
+
+	if (new_min_voltage_level == old_min_voltage_level)
+		return 0;
+
+	if (!allow_voltage_level_decrease &&
+	    new_min_voltage_level < old_min_voltage_level)
+		return 0;
+
+	cdclk_state = intel_atomic_get_cdclk_state(state);
+	if (IS_ERR(cdclk_state))
+		return PTR_ERR(cdclk_state);
+
+	old_min_voltage_level = cdclk_state->min_voltage_level[crtc->pipe];
+
+	if (new_min_voltage_level == old_min_voltage_level)
+		return 0;
+
+	if (!allow_voltage_level_decrease &&
+	    new_min_voltage_level < old_min_voltage_level)
+		return 0;
+
+	cdclk_state->min_voltage_level[crtc->pipe] = new_min_voltage_level;
+
+	ret = intel_atomic_lock_global_state(&cdclk_state->base);
+	if (ret)
+		return ret;
+
+	*need_cdclk_calc = true;
+
+	drm_dbg_kms(display->drm,
+		    "[CRTC:%d:%s] min voltage level: %d -> %d\n",
+		    crtc->base.base.id, crtc->base.name,
+		    old_min_voltage_level, new_min_voltage_level);
+
+	return 0;
+}
+
 int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_state *state,
 					 int old_min_cdclk, int new_min_cdclk,
 					 bool *need_cdclk_calc)
@@ -3387,6 +3434,13 @@ static int intel_crtcs_calc_min_cdclk(struct intel_atomic_state *state,
 							need_cdclk_calc);
 		if (ret)
 			return ret;
+
+		ret = intel_cdclk_update_crtc_min_voltage_level(state, crtc,
+								old_crtc_state->min_voltage_level,
+								new_crtc_state->min_voltage_level,
+								need_cdclk_calc);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.52.0


