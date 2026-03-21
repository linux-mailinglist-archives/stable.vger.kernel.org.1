Return-Path: <stable+bounces-227771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAl6HeepvmkUWAMAu9opvQ
	(envelope-from <stable+bounces-227771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:23:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C582E5C4F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75BC23011129
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C3326D65;
	Sat, 21 Mar 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpfqCnXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954819005E
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102749; cv=none; b=GllxV1dFAfd1Ia22CO13tjjETatrsmTB9doFjK/U9VSy46gJ0gZbq9KdVhkYglJCxmGmsNFSw/OjKHzLC2wBTxeIlkMDswKOFCTUzWqaDMD1WOOe8OR9m+i63ByIg9qAVJQ5Sv5sZqw0sdO0t3i89viFhWmyyMokQw3fgKTlCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102749; c=relaxed/simple;
	bh=zrQrhe/at97lk42CikYwDxK8EbmAivxdIOFYgwCPEYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTMGH4QVkeh+W8GN47elZLXP+27LEKWVo7WzJTPAA2elTo/e2hONR5Pzog6idCGjZxQzAiRLxp9BCg34anjQn4S3WdmWmN7IUX+c2GVB7tCnIELP4Ay0kSYLQ9gSUAUvheqqkZVAHzKkBB4tl9bDWuDqbB9K5rFrus+Ns33fUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpfqCnXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E511DC19421;
	Sat, 21 Mar 2026 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774102748;
	bh=zrQrhe/at97lk42CikYwDxK8EbmAivxdIOFYgwCPEYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpfqCnXTuocdnrGK8DseUtYpSmbpvqxQojCeOu8vchzMtusb9hPCysf/+dzFpm6VW
	 anm0jWVRkC2/DiJ0jQU59zkwXxE/y3IPleTPfaIJHOE0FWvJA91EI8wirrKN75OsSn
	 1N4L1bsmBeE1UHfKWEevjyarBI0O0GyauqCJakri+wMnthCQ6b//sk1LyZSZzjNLYi
	 19DbB/JX+XpcEUJcS3giJb1hvvxH1m3dQCDvcULRFGXABusL+uQJpZAqoH1tssUBeX
	 4Zis1lJXb1B2aRuvxDbzm8wmAW4AdOsA+cqSa7iNDyTgLuXPgB2vXbQQ//mzz7QijK
	 OFGhTF4PJTU9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state
Date: Sat, 21 Mar 2026 10:19:06 -0400
Message-ID: <20260321141906.385910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032135-causation-partner-6f47@gregkh>
References: <2026032135-causation-partner-6f47@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227771-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C8C582E5C4F
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
[ adapted context lines to account for missing `no_psr_reason` field and `alpm_state` struct. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 358ab922d7a76..39dd7389f1a71 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1127,6 +1127,7 @@ struct intel_crtc_state {
 	u32 dc3co_exitline;
 	u16 su_y_granularity;
 	u8 active_non_psr_pipes;
+	u8 entry_setup_frames;
 
 	/*
 	 * Frequency the dpll for the port should run at. Differs from the
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index bceb9eb4ed3b2..b37994c778a97 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1584,7 +1584,7 @@ static bool _psr_compute_config(struct intel_dp *intel_dp,
 	entry_setup_frames = intel_psr_entry_setup_frames(intel_dp, adjusted_mode);
 
 	if (entry_setup_frames >= 0) {
-		intel_dp->psr.entry_setup_frames = entry_setup_frames;
+		crtc_state->entry_setup_frames = entry_setup_frames;
 	} else {
 		drm_dbg_kms(display->drm,
 			    "PSR condition failed: PSR setup timing not met\n");
@@ -1656,7 +1656,7 @@ static bool intel_psr_needs_wa_18037818876(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
-	return (DISPLAY_VER(display) == 20 && intel_dp->psr.entry_setup_frames > 0 &&
+	return (DISPLAY_VER(display) == 20 && crtc_state->entry_setup_frames > 0 &&
 		!crtc_state->has_sel_update);
 }
 
@@ -2026,6 +2026,7 @@ static void intel_psr_enable_locked(struct intel_dp *intel_dp,
 		crtc_state->req_psr2_sdp_prior_scanline;
 	intel_dp->psr.active_non_psr_pipes = crtc_state->active_non_psr_pipes;
 	intel_dp->psr.pkg_c_latency_used = crtc_state->pkg_c_latency_used;
+	intel_dp->psr.entry_setup_frames = crtc_state->entry_setup_frames;
 
 	if (!psr_interrupt_error_check(intel_dp))
 		return;
-- 
2.51.0


