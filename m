Return-Path: <stable+bounces-253629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPglOpFOD2r7IwYAu9opvQ
	(envelope-from <stable+bounces-253629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901DA5AB09C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D04AF30055A9
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91833C456D;
	Thu, 21 May 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariushoch.de header.i=@mariushoch.de header.b="EXuGrg2m"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0F3911B2;
	Thu, 21 May 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388038; cv=none; b=ngOZKeWJMqm/915hNt4eswA0mtuesMHJs3OgpX+w/EeTWq+oML5oQl3vC3KBSPrgv87o7GTX8C8JvijWbAl4KoY6DzmHlv44A3wbao8x3t7bceVQtroajgB37pJQ2E75Ndx4Seh6qkZdmjMOid7la0Eu2LrKNFy29xbe/fWectE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388038; c=relaxed/simple;
	bh=A3BNSUMwsfIMr+beJtpFVWODqCytvU1Ncr0xSyoqKnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YG/CgjARkByXLtL+Avlt9z2AbbbfEZ7zKAxVTdDiWKI2Yf5juqz7gX1CBwXuS1XK7hZn04AxuTny6P8Ng/sweFjwSLDfixGHJ9TNZzs2B13KBuBfHiPfxoYv9D857fshKHiTXGq/v1dENQz8LPHKiCytvZc3oYWe+YK0znIwurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariushoch.de; spf=pass smtp.mailfrom=mariushoch.de; dkim=pass (2048-bit key) header.d=mariushoch.de header.i=@mariushoch.de header.b=EXuGrg2m; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariushoch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariushoch.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gLxhP28rTz9vLF;
	Thu, 21 May 2026 20:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
	s=MBO0001; t=1779388021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GYkf84zKQ1koXdJ8sJbWorRHXORylD9/JuNrnSRVhMk=;
	b=EXuGrg2mnXNU2e83JRMVB5I2K3ncTReK933T4sXH6nAcQLJ+oDRgYS9VRO5qcCohfvUsHV
	9QdC39z76pint1GOoMOjOmwPjupiX6Y0aSyap+yX5LUcchK2Lx8dGBCipWJ2PkcJj81+vN
	TBxmNdbCldjXqXxXb3+/LPpmqt7XpGpO+9k1w7p0RCnhEeCrgWpXDZlkM0rqQSRme4G5wR
	sy+B6gohE941vLOREpIsnqZRvEVQtzy+tTko9hTLjnn6lQbmbNv8NSaB+Htf65RP+tGs+g
	8rCNO7jjrOHdqJpu2huEPhGKvurez37TrzVB/RvXGPKe2kuvTwus3osZZRMtOQ==
From: Marius Hoch <mail@mariushoch.de>
To: linux-kernel@vger.kernel.org
Cc: Marius Hoch <mail@mariushoch.de>,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Joe Perches <joe@perches.com>,
	Mika Kahola <mika.kahola@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: Don't set min_cdclk in the initial crtc_state
Date: Thu, 21 May 2026 20:07:12 +0200
Message-ID: <20260521180722.328317-2-mail@mariushoch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mariushoch.de:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253629-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mariushoch.de,vger.kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,perches.com,lists.freedesktop.org];
	DMARC_NA(0.00)[mariushoch.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@mariushoch.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mariushoch.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 901DA5AB09C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Setting the min_cdclk this early means that intel_cdclk_atomic_check
(called via intel_atomic_check) will not pick up the initial min_cdclk, as
there is no change between the old and new atomic states. This is
problematic, especially on Gemini Lake, where the picture gets unstable if
the CDCLK is too low (see vlv_dsi_min_cdclk).

This was introduced in 7a8d9cfa6db0, which states that the min_cdclk must
be set before calling intel_compute_global_watermarks. However, as the
only place that calls intel_compute_global_watermarks is
intel_atomic_check, right after setting the min_cdclk on new_crtc_state,
there is no need to set the min_cdclk initially.

This surfaced as a bug on my IdeaPad Duet 3 after ba91b9eecb47, leading
to the screen output being completely garbled initially (when asking for
the dm-crypt passphrase). It recovers after the passphrase prompt, as this
only affects the initial state.

Tested on an IdeaPad Duet 3 10IGL5-LTE (with UHD Graphics 605).

Cc: stable@vger.kernel.org
Fixes: 7a8d9cfa6db0 ("drm/i915: Compute per-crtc min_cdclk earlier")
Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/gpu/drm/i915/display/intel_modeset_setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 4086f16a12bf..9278856375e9 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -865,11 +865,6 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 				    crtc_state->plane_min_cdclk[plane->id]);
 		}
 
-		crtc_state->min_cdclk = intel_crtc_min_cdclk(crtc_state);
-
-		drm_dbg_kms(display->drm, "[CRTC:%d:%s] min_cdclk %d kHz\n",
-			    crtc->base.base.id, crtc->base.name, crtc_state->min_cdclk);
-
 		intel_pmdemand_update_port_clock(display, pmdemand_state, pipe,
 						 crtc_state->port_clock);
 	}
-- 
2.54.0


