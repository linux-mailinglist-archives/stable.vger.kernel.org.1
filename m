Return-Path: <stable+bounces-165113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FD1B15285
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8838C3AAF7B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2E298999;
	Tue, 29 Jul 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyAR07q4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AE2AE90
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812894; cv=none; b=ooqKFyrIG8KOfUZDtAg/WJGMQGAVPKAMhp2R7Ycc46YUkAQG3IVoqITrD9WspxSuXuXENgrzdg6yKQOY5B1E484Sj54BSYXRJ/jx/hi5OpYfZXrtKDVjLlAbXd/Vo/ZOyWvDC7ixb/4aHaPyT/Ggzec6jv752v7l5JXfZ4cLnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812894; c=relaxed/simple;
	bh=jcU5LWDiZFG93XPoWEktnrr/E0OrO3OMjhU9o+SzdjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMUKTso86P5xwMySwlLbq5wAB8UPVZ8BxVrtFug/22ahTCC1msQQ/5JhAUYwwRNtCVoo/l5WGeuWReNoth0vnOdLHAMeEwJn5MXWVOS82UsEzkOhi6RzJA4YYz5+R3fqmgg/Hs1Swbt3qCy6cH/eNh9u7978fZnAWtzgzxpgra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyAR07q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD30C4CEF4;
	Tue, 29 Jul 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753812893;
	bh=jcU5LWDiZFG93XPoWEktnrr/E0OrO3OMjhU9o+SzdjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyAR07q4jRWEMwTzKrtJtwwVgmzoADkJ6K/yKhsFIldYDYstifX6uZf0SRCXhopNc
	 TZJo2VWRiLHXYWwretbfajCIFbuY7nJEMA5zOCT5IK7DoLmFULkc0CQ9j1xvEjrNVv
	 OoJ0ULPG5oxq5JrmYhd1AdQoueZAbNktJszsxLOifbmat4FJ38LG1VLpCWTjhMwpQ6
	 udld7XvGuxDsBtB8Y7zWO9KqLY4jo57bp2y6u9P8rgmIqBQwPFpYNU3Dk0RNXQ2vsO
	 el80B5U1O6j0q4nZghuyrWGWUrO322Ydi5Ab2GYkfAHLNoGFO9Zv325AOym/cu3qfp
	 mzf+f6XBGmiEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
Date: Tue, 29 Jul 2025 14:14:48 -0400
Message-Id: <20250729181448.2846093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072822-armrest-dominoes-7934@gregkh>
References: <2025072822-armrest-dominoes-7934@gregkh>
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
index c8b6d0f79c9b..9a894e234f62 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1293,6 +1293,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
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


