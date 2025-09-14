Return-Path: <stable+bounces-179585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63739B56B75
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249D43A6604
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AE2627EC;
	Sun, 14 Sep 2025 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp8FlcdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09891B532F
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876501; cv=none; b=LxapfV9y28TW+Wnr71DRLAXB+xUbV00iIkFP1oGJNR6AdGxGiAf5ZUZx+3Pwx7sZAsuPqTPL55K/gwif5ox6G7ff6+IA88sN4EzCdzlsCQUB3bENqUTji2uyCT4a0Yq/uRmgGs2mFfHsA6tCE+857MlM9sS+qf7JuJZYrTOFRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876501; c=relaxed/simple;
	bh=fcSMzifsDY1dsyJOMi8+zHu8/68nnmF4UaDJMKtVzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJyOVV/jaKqHbIe3FJ/QOR3NkI5Rx42yz72t6dZBE4CB0x/NFsI4whzVkRwiWDSV2/YqgqSfq6RlYfW6qrBk/Tv1g05AidVavZKiMze+AFZNojUVTbEpZ44q8w9dT1W8Rqfcd0TdLwCe80+LQwAvdy2jewPcbPHcN6VGicToZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp8FlcdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B540AC4CEF0;
	Sun, 14 Sep 2025 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876500;
	bh=fcSMzifsDY1dsyJOMi8+zHu8/68nnmF4UaDJMKtVzas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pp8FlcdZHtHhsNJXEJGJWHzR5uNWJRs8ljmvFXtEORZ+JqpFmyU9Q3tgIzr1UH9e2
	 B0GH1e+A4h5QvMFzC3a4p253QCqLoMSe6scmuu840CGU1TapQDZyydveZ9CUH5fH4M
	 zThX/HvOcUkh672ItlzQhRO7E9wSC2XqRGRWOo/eeu0D4qe/jYNCVcvayNh7PN8C4J
	 UmN4p3dZGMKAVkEyDKMtRnfmxOFTRgrmDWvVA2una/A83M4nGqHsBci1n08RhOF6yn
	 4Az2M9CL5+Ym/3eqSAhIcsHamLsQV2nhk6QIH3kx8EFROzbuHmie9UhS24IQpeo082
	 THC9gptoY4nOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/power: fix size for for_each_set_bit() in abox iteration
Date: Sun, 14 Sep 2025 15:01:37 -0400
Message-ID: <20250914190137.180351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091354-plenty-unlined-c98e@gregkh>
References: <2025091354-plenty-unlined-c98e@gregkh>
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
index ef2fdbf973460..85335d8dfec11 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1150,7 +1150,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (DISPLAY_VER(dev_priv) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1603,11 +1603,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
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


