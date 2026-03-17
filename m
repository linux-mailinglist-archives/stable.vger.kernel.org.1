Return-Path: <stable+bounces-226163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME8cLcuDuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5412AE294
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 734773038021
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C693ECBDD;
	Tue, 17 Mar 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKhOtr1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AF3EBF20
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765568; cv=none; b=NrEHqXbGnLdUoOz8U8z/OR6oHKErh1KRXnjP+55nL8B07XE4ygrCKJaXsdzw6z1FTsq0ASPJcE0/rRt64locRQWrgwI54Xeu45qHFPVyvIDt1cl7x6W4/IP0kcGy1pUPSkRUf/9AIJF1kBkJmqwFkn+tjZyjyNg08fSbkB+cagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765568; c=relaxed/simple;
	bh=Lj6FoEgKKfi1v4iE4e15vmOuNh+jr7qKOGMNMwPuhBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTPnmksJPkJv09qzyErOgUPl7C4dGD6Wr4lE0NNHTDeZPEjHJmjFXxqSplgRNndWHh61D5afQXRSg26B8MA8SeYI25Zb0Aqf7gfFov+MLxeRgS4RzAhCoKuJUdpU8+WT003y1MPX+JtPlHvtN2zc8731FW+8kkY8RJgUESozw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKhOtr1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC15DC2BCAF;
	Tue, 17 Mar 2026 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765568;
	bh=Lj6FoEgKKfi1v4iE4e15vmOuNh+jr7qKOGMNMwPuhBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKhOtr1yz7DujczlgDA2Fvlj/sNkAJ+KMQZgTtdLBC9xn+FVRNi1xc/1eFgU4AXYN
	 bQaD9yHeRpv2uASHMC/T10LAQizOjAnvu0VkfeYq8+DnLFVedWTBngB8DPDhCwYKYv
	 yJjzyxFk2OhEGtA+XHWb4y+Z6yOdDLueiFmQbQO+NZkr23wvTaP36w7MeQodqbw3+/
	 6URJPRb4eTK8EbiyzUKtuwat74d7K5dBhtXvhRukHjE37efLs+ozNt9nkDeahybIsz
	 MLtVPg9+LLo3uq9geLy59NYBieWHNtJ5Zd1bCQF/UDPZuqUjgSMUGHrq8Dc7unbsHW
	 PXwuN8oX1Esqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/8] drm/i915/display: Disable PSR before disabling VRR
Date: Tue, 17 Mar 2026 12:39:18 -0400
Message-ID: <20260317163924.220634-2-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226163-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5F5412AE294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

[ Upstream commit 8b68938364b6fa528d5ae1cd2ffbcd95880bff19 ]

As per bspec 49268: Disable PSR before disabling VRR.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://lore.kernel.org/r/20250324133248.4071909-4-ankit.k.nautiyal@intel.com
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 4f8899cd125d9..a0f78e1399306 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1195,6 +1195,8 @@ static void intel_pre_plane_update(struct intel_atomic_state *state,
 		intel_atomic_get_new_crtc_state(state, crtc);
 	enum pipe pipe = crtc->pipe;
 
+	intel_psr_pre_plane_update(state, crtc);
+
 	if (intel_crtc_vrr_disabling(state, crtc)) {
 		intel_vrr_disable(old_crtc_state);
 		intel_crtc_update_active_timings(old_crtc_state, false);
@@ -1205,8 +1207,6 @@ static void intel_pre_plane_update(struct intel_atomic_state *state,
 
 	intel_drrs_deactivate(old_crtc_state);
 
-	intel_psr_pre_plane_update(state, crtc);
-
 	if (hsw_ips_pre_update(state, crtc))
 		intel_crtc_wait_for_next_vblank(crtc);
 
-- 
2.51.0


