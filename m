Return-Path: <stable+bounces-179589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C749B56C25
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A934178158
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DAB284678;
	Sun, 14 Sep 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmTA/Rl7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486921A38F9
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881443; cv=none; b=YzFyq84mmA4Snp01/XOExvB+E6PwMldhJaJmnASmfWTkzzrRTT+XcibaQhmuYXOf4u1O0FY32EaLFjrRv4eFPZGnbFB569A2hcVJCp9dWI57tat4htns0zFaw6SShuSLBj4HM6f4d2NaeENr5x/YGy5gQwGoMNRZeCIum2H8qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881443; c=relaxed/simple;
	bh=GH+8PbRHoCrEX96jdWeylHWYmBy+uRuI2SQTAnoyoo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUZG3eTeGQdhqMgbe/4tl0cKn8gtf1eWRCi1FFM3wN8B17vsWdUGl79ZXfRuvcikyF3PJFFVMTBiNuP65dsmUE12AzOblB+vwX8xUp2auG1lZ6nE8v87Wv7+NNZXfs194UyC5zfPphq2u/9ZpEqXj1AG1NrsyB2k7R9gj7V3nNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmTA/Rl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEEC4CEF0;
	Sun, 14 Sep 2025 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881442;
	bh=GH+8PbRHoCrEX96jdWeylHWYmBy+uRuI2SQTAnoyoo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmTA/Rl7DHN1oiEYjDhSkYyybfgNaEhXnuz85d68nr64P6BlkcgDc9SgxCNeV7FBx
	 53rmkoyH+pATcOqJMbM5GeprKyC2UoCuKV0kKyQxgU3E1FqXvRmBVYv1o+TntWBwAl
	 kjIeKFylRZnhcVlibNUFGNhtDG/ZfJiNyedbnHLuy3YJX10htr8qxznPMfBdvtKIyf
	 Ia6GjAgIN7AhAUkoaENWqX8tA53N63zptCBuHIsYUkKSkpo7ugxt+p79hbssG8bE/F
	 6HtoURtANPg+V0HsG6HugxJyDyzX7p8ZxX6dEpMqg7dePHW86ZhUW0j0GivfxO17t5
	 De3vQ6P3aohcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/i915/power: fix size for for_each_set_bit() in abox iteration
Date: Sun, 14 Sep 2025 16:23:59 -0400
Message-ID: <20250914202359.203056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091356-brownnose-numbing-a046@gregkh>
References: <2025091356-brownnose-numbing-a046@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit cfa7b7659757f8d0fc4914429efa90d0d2577dd7 ]

for_each_set_bit() expects size to be in bits, not bytes. The abox mask
iteration uses bytes, but it works by coincidence, because the local
variable holding the mask is unsigned long, and the mask only ever has
bit 2 as the highest bit. Using a smaller type could lead to subtle and
very hard to track bugs.

Fixes: 62afef2811e4 ("drm/i915/rkl: RKL uses ABOX0 for pixel transfers")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: stable@vger.kernel.org # v5.9+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://lore.kernel.org/r/20250905104149.1144751-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 7ea3baa6efe4bb93d11e1c0e6528b1468d7debf6)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
[ adapted struct intel_display *display parameters to struct drm_i915_private *dev_priv ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 7277e58b01f13..30174c050cc16 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -4780,7 +4780,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (IS_GEN(dev_priv, 12))
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -5277,11 +5277,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
 	if (table[config].page_mask == 0) {
 		drm_dbg(&dev_priv->drm,
 			"Unknown memory configuration; disabling address buddy logic.\n");
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask))
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask))
 			intel_de_write(dev_priv, BW_BUDDY_CTL(i),
 				       BW_BUDDY_DISABLE);
 	} else {
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask)) {
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask)) {
 			intel_de_write(dev_priv, BW_BUDDY_PAGE_MASK(i),
 				       table[config].page_mask);
 
-- 
2.51.0


