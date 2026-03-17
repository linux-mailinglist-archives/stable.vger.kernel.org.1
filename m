Return-Path: <stable+bounces-226164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIhbOdmEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635A2AE4D1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4E5830A8728
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36553D6698;
	Tue, 17 Mar 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvH85QlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E014F70
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765569; cv=none; b=ZEIaK+cAHSImc+B0YKine7osRtwybGvE4XWCvi70OUiBioj7e6zuamx28mbroaL89OMqVvdpYQm5bm+XapOPHu3d5aT0ed3eH6haUxFQn89SOYl7XksiltxjwtL02d/dvIqvCnYvnIHx7TikHx2QPyhuO4soAP2BWKh5x7q2R4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765569; c=relaxed/simple;
	bh=TMe821J5oWLSpKUeUWUXUaOs4OV3qWDpTOTd5DJzzI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeA2/YqeL4Op/VpoJbwPFB8AEiMDwsxUdoCK5/uma4FnA64GAX4KeosK+DeppNqENqjQf2huZkDoDuAss99D7ppZx9f4vfSl8uc+lo6/Hps73B/drhLB2nWYSZ0VDprjm4Rv2fUh5nU6CFuJ6MT5ugob5ocAkzvUEQuwQx87POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvH85QlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75765C2BC86;
	Tue, 17 Mar 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765569;
	bh=TMe821J5oWLSpKUeUWUXUaOs4OV3qWDpTOTd5DJzzI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvH85QlSF2BCE/XgTJQkTRLsEKFlLVWqGVLE3g5vNUp+/MdTkuokkhgUmxMkxQOMs
	 nfByKWDOJlRV7ayO4nnI6bK29WvZqkq1yb7zs2At9jemLItHO81A79s9A6XuhkpdRN
	 ugaTVZUfQmM8+AceRTcF4mP8X+XAupd+3qnCCutzM7Vt625jmfmcCWzFeQqN41W0eF
	 dPv0y1sczOQxP8neMkHZa7FJx9pspRDqxHOaybdE3t9VMM9h3XC9LpNcCfpji7qP8P
	 1joG9DER8Mf2f0V2/q93aaGZUqmfgWT1dT6v1C327bAfZSGVlFEU42RkZp+lVmL/hm
	 m9H5B6LMAWluQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/8] drm/i915/display: Move intel_psr_post_plane_update() at the later
Date: Tue, 17 Mar 2026 12:39:19 -0400
Message-ID: <20260317163924.220634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317163924.220634-1-sashal@kernel.org>
References: <2026031731-secret-rocket-af05@gregkh>
 <20260317163924.220634-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226164-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 9635A2AE4D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

[ Upstream commit 9c29a0dd8c6eae77f3d0addac78331d1a516dc39 ]

In intel_post_plane_update() there are things which might need to do
vblank waits, so enabling PSR as early as we do now is simply
counter-productive. Therefore move intel_psr_post_plane_update() at the
last of intel_post_plane_update().

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Link: https://lore.kernel.org/r/20250324133248.4071909-5-ankit.k.nautiyal@intel.com
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index a0f78e1399306..e2736f50fef83 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1087,8 +1087,6 @@ static void intel_post_plane_update(struct intel_atomic_state *state,
 		intel_atomic_get_new_crtc_state(state, crtc);
 	enum pipe pipe = crtc->pipe;
 
-	intel_psr_post_plane_update(state, crtc);
-
 	intel_frontbuffer_flip(dev_priv, new_crtc_state->fb_bits);
 
 	if (new_crtc_state->update_wm_post && new_crtc_state->hw.active)
@@ -1117,6 +1115,8 @@ static void intel_post_plane_update(struct intel_atomic_state *state,
 
 	if (audio_enabling(old_crtc_state, new_crtc_state))
 		intel_encoders_audio_enable(state, crtc);
+
+	intel_psr_post_plane_update(state, crtc);
 }
 
 static void intel_crtc_enable_flip_done(struct intel_atomic_state *state,
-- 
2.51.0


