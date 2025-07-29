Return-Path: <stable+bounces-165110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CFB15249
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630CA17C8F1
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A2299A8F;
	Tue, 29 Jul 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmFpMoXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FB298CA5
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811018; cv=none; b=YtngOYJW1POTrEXNaPUHXQQugi0T7ja3hl9oGvIB/ueqDtMljoaz3wIchEz7iiC/iyCG4IqLEvlVsEITyjhSnAph//UQzPwikxkT2w8xdarRWUemfrMkEOtLjGVfRImPEK7L1VTCL6HLbABh7PCrg6srnjBhjQzQdKb1backJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811018; c=relaxed/simple;
	bh=C7eu2m0TmmiZmHIOXQNKQu210ejup4oLKPOu8qcg85A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp8trVdCAvbN04iV0Air4oqLpyX/dg5VDfNGRxJHfDE8C+72LQs2Qw0XEnI5LbYgyFOF+DJEkgep1IRkwBAA+TlvnzJ6Cx9nQBcQ7R71qTqBnKLzGQQfjgIstOnq6K88kik7/vfFpMOz3NNwuf+voPh6av8TeR/r1aaTQfLiUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmFpMoXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768A0C4CEF4;
	Tue, 29 Jul 2025 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811017;
	bh=C7eu2m0TmmiZmHIOXQNKQu210ejup4oLKPOu8qcg85A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmFpMoXBpWTZ+3KI9DDiEQFCHlFxAObef4VpDnPllUKKLLQY3mEh9YTNauTXQ9MlE
	 VAB9zJyiwhPTTaU2soI+djpwg0CBWsiE8KOJbco40weoWqRN/Op+ZOxz6PPV5qTQmp
	 Q/0fvOTLWKI/DfO9cCuXrJq74EECYlPlTxCq8n1RR7UCDjycO4KMkij9zKMN87Rk8x
	 5pL0/o81qsRzOJYA7moAAdU6ZdrcOXo4x+3mbDYiU/I7NSy54+qzw6sbbRGDgET6lo
	 k/rn7Z6XXN3YDiTJ+PXclv8PacDv+kgyrl7s1tAayBKq5f9pVR+6qgGG+tpkmgHmU3
	 yCzX2USJXP3MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
Date: Tue, 29 Jul 2025 13:43:33 -0400
Message-Id: <20250729174333.2834925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072832-cannabis-shout-55f6@gregkh>
References: <2025072832-cannabis-shout-55f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 9e0c433d0c05fde284025264b89eaa4ad59f0a3e ]

On g4x we currently use the 96MHz non-SSC refclk, which can't actually
generate an exact 2.7 Gbps link rate. In practice we end up with 2.688
Gbps which seems to be close enough to actually work, but link training
is currently failing due to miscalculating the DP_LINK_BW value (we
calcualte it directly from port_clock which reflects the actual PLL
outpout frequency).

Ideas how to fix this:
- nudge port_clock back up to 270000 during PLL computation/readout
- track port_clock and the nominal link rate separately so they might
  differ a bit
- switch to the 100MHz refclk, but that one should be SSC so perhaps
  not something we want

While we ponder about a better solution apply some band aid to the
immediate issue of miscalculated DP_LINK_BW value. With this
I can again use 2.7 Gbps link rate on g4x.

Cc: stable@vger.kernel.org
Fixes: 665a7b04092c ("drm/i915: Feed the DPLL output freq back into crtc_state")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250710201718.25310-2-ville.syrjala@linux.intel.com
Reviewed-by: Imre Deak <imre.deak@intel.com>
(cherry picked from commit a8b874694db5cae7baaf522756f87acd956e6e66)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ changed display->platform.g4x to IS_G4X(i915) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ca9e0c730013..af80f1ac8880 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1506,6 +1506,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (IS_G4X(i915) && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;
-- 
2.39.5


