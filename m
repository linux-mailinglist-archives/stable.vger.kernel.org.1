Return-Path: <stable+bounces-230349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORDA03sw2kAvAQAu9opvQ
	(envelope-from <stable+bounces-230349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:08:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D73326728
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8734D30CC946
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA163DA7FB;
	Wed, 25 Mar 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcB4YuEi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200E3DD537
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447144; cv=none; b=cRLhaWdfPL+NrN5p2vkFYqvi0oGRSNZOrLrvN8SXFC7mOuBtmHn6OzTBbA8LDIVz0aViJWWhR4EaBE120vjhrm5inTBhdpwu2FyH4RY4lgeKsIwyXfJVW2zYzlulDkgyM9lY45SPwzT7BJZ+XuPKBrKH8CcQmiTHV8XKSRZQmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447144; c=relaxed/simple;
	bh=UsjuaPPD2is9XrOntSu2CffKCakzTixurL8WrY+SztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkOw4PU5d7oOWJhkIVx9aDZ/DYIELWEC59oBQsROpaP+rR55hnHPHHuvZBx13Fbu7rEjgvlE81NKedXrT3e0sGEUYLFSGCOmtZ0nTzZ+8S0HCT2TDIPU7ivoZOGr42q4n4vlCrqOfWTOkpuFM5/PSAvul3xHabz7ODQN49jxCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcB4YuEi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774447143; x=1805983143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsjuaPPD2is9XrOntSu2CffKCakzTixurL8WrY+SztE=;
  b=GcB4YuEihp8BN4wOmRRoJIyIsqFk/gzww2xfqDclvvx/4JEedX+94IEY
   Fg2koW0/gqJ1QCvlAl/chEsi87YCf+eaQvzDbiIAlCTS74Ajp/nKUVBys
   ARMrxRE1zmYUFmd6LiC3TOrlwxwI1QSw5JUtFBQwlLFKMTyMpqHXwKlIb
   dqmy9eHBbQsrCH5Gz9bxtwD69GjhnjaDWGhk2A1C2IMUWvWDqPwPsylOl
   C5wHVvaFh+48GkcF6rwQ+vytUUiFZ4ozXBC8bvnqlBpi3fWTsbNCc1x1u
   bDJB8jgQW3Mxk6/N6lHJfZEXgv82TZOx0Ws6lSqzziGrfQoXK7yVZMF7O
   w==;
X-CSE-ConnectionGUID: vDxQMsMxTsSqzncfQqNg/Q==
X-CSE-MsgGUID: mV3Gv1lfS5Cw0dbnCsS0qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75365797"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75365797"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:59:02 -0700
X-CSE-ConnectionGUID: OBtA/LYqSnOgSnk4CL2PxA==
X-CSE-MsgGUID: 0fqP9ah9QGOh5ZoPjzLf7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248197434"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:59:01 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 2/6] drm/i915/dp: Use crtc_state->enhanced_framing properly on ivb/hsw CPU eDP
Date: Wed, 25 Mar 2026 15:58:45 +0200
Message-ID: <20260325135849.12603-3-ville.syrjala@linux.intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230349-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8D73326728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Looks like I missed the drm_dp_enhanced_frame_cap() in the ivb/hsw CPU
eDP code when I introduced crtc_state->enhanced_framing. Fix it up so
that the state we program to the hardware is guaranteed to match what
we computed earlier.

Cc: stable@vger.kernel.org
Fixes: 3072a24c778a ("drm/i915: Introduce crtc_state->enhanced_framing")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/g4x_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/g4x_dp.c b/drivers/gpu/drm/i915/display/g4x_dp.c
index d7de329abf19..5e74d8a3ba5c 100644
--- a/drivers/gpu/drm/i915/display/g4x_dp.c
+++ b/drivers/gpu/drm/i915/display/g4x_dp.c
@@ -136,7 +136,7 @@ static void intel_dp_prepare(struct intel_encoder *encoder,
 			intel_dp->DP |= DP_SYNC_VS_HIGH;
 		intel_dp->DP |= DP_LINK_TRAIN_OFF_CPT;
 
-		if (drm_dp_enhanced_frame_cap(intel_dp->dpcd))
+		if (pipe_config->enhanced_framing)
 			intel_dp->DP |= DP_ENHANCED_FRAMING;
 
 		intel_dp->DP |= DP_PIPE_SEL_IVB(crtc->pipe);
-- 
2.52.0


