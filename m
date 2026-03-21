Return-Path: <stable+bounces-227776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJkcFk3DvmkKawMAu9opvQ
	(envelope-from <stable+bounces-227776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 17:11:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C18832E6473
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96542300F18F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1772FF641;
	Sat, 21 Mar 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoaqXoJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DE2741B6
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109514; cv=none; b=Ae/eUJqo1ulD/UHUUG6b/xetZrTQhmUPp8y3CJoDRrkOZPCS+DL7N8XW+3W/B/2Y4kN8KsvrBn6/MnL00Df1ROy9Y56uK1IL+m29HcAFAXcW+bfs5bcmA/rMrBMu5wtibqHx7Pm6exJUkiaD36Lk1vzZciPPZXixc1N20FtPelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109514; c=relaxed/simple;
	bh=WdH4OGE/7FF+vCeZsSUl2++yuOIMsVNm8OwvXq2oE2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfUh6nApVdodFpIctSZ/9ImJakbRoSZxcAImE5o5SVq5tNnJy/FnYUwRHdqa6tcH2jGFfA++HaH+dQrDSoaPylx5XmQ80cVP3o/YdmwswJ5+L6CIuDBl5Hmy6uOKtFoQGR4mHE2Z5V41mJ+LmaslK9S23095E7KV2twm9mJVKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoaqXoJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F6AC19421;
	Sat, 21 Mar 2026 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774109514;
	bh=WdH4OGE/7FF+vCeZsSUl2++yuOIMsVNm8OwvXq2oE2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoaqXoJxv33IMg1kqssjCGYT0EkgYNA8T2eR162VjX7rj9WD8bSH29JC0eugEYWqQ
	 QjgMDPZjqbzHAM9NOyCXvJnQgE8QZSqbFmxrF3vJyqD69fOxoR7E52sZ/D9DUs+7cL
	 Eg4WmJAWboSk8J11VaX8yoS8VcUBeyoVfBZ/a2UFyWgyoePqwLqO5I2wWiag6n6xXU
	 KpU/azgwFFhiWDF5iWViTrtyes5UDctYQvdRCawX4uyoOUf+HvfAcWBRPvHmLejV8W
	 5sRQORns4vANO//EK4KOPWFR8BX+qycxv8XXds+lGAF1G5Po6SpgDLxaVO418GR1+q
	 Y1ojot8CxXtmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state
Date: Sat, 21 Mar 2026 12:11:51 -0400
Message-ID: <20260321161151.417267-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032136-cradling-overrate-d235@gregkh>
References: <2026032136-cradling-overrate-d235@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227776-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: C18832E6473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 7caac659a837af9fd4cad85be851982b88859484 ]

PSR entry_setup_frames is currently computed directly into struct
intel_dp:intel_psr:entry_setup_frames. This causes a problem if mode change
gets rejected after PSR compute config: Psr_entry_setup_frames computed for
this rejected state is in intel_dp:intel_psr:entry_setup_frame. Fix this by
computing it into intel_crtc_state and copy the value into
intel_dp:intel_psr:entry_setup_frames on PSR enable.

Fixes: 2b981d57e480 ("drm/i915/display: Support PSR entry VSC packet to be transmitted one frame earlier")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260312083710.1593781-3-jouni.hogander@intel.com
(cherry picked from commit 8c229b4aa00262c13787982e998c61c0783285e0)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ dropped intel_psr_needs_wa_18037818876 hunk and adjusted surrounding context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 9812191e7ef29..2039c17a9ee78 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1218,6 +1218,7 @@ struct intel_crtc_state {
 	bool wm_level_disabled;
 	u32 dc3co_exitline;
 	u16 su_y_granularity;
+	u8 entry_setup_frames;
 
 	/*
 	 * Frequence the dpll for the port should run at. Differs from the
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 34d61e44c6bd9..3432d2c26baaa 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1570,7 +1570,7 @@ static bool _psr_compute_config(struct intel_dp *intel_dp,
 	entry_setup_frames = intel_psr_entry_setup_frames(intel_dp, adjusted_mode);
 
 	if (entry_setup_frames >= 0) {
-		intel_dp->psr.entry_setup_frames = entry_setup_frames;
+		crtc_state->entry_setup_frames = entry_setup_frames;
 	} else {
 		drm_dbg_kms(display->drm,
 			    "PSR condition failed: PSR setup timing not met\n");
@@ -1978,6 +1978,7 @@ static void intel_psr_enable_locked(struct intel_dp *intel_dp,
 	intel_dp->psr.psr2_sel_fetch_cff_enabled = false;
 	intel_dp->psr.req_psr2_sdp_prior_scanline =
 		crtc_state->req_psr2_sdp_prior_scanline;
+	intel_dp->psr.entry_setup_frames = crtc_state->entry_setup_frames;
 
 	if (!psr_interrupt_error_check(intel_dp))
 		return;
-- 
2.51.0


