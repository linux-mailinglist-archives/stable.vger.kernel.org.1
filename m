Return-Path: <stable+bounces-179586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC6B56B79
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 21:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0BB1899DE7
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFF8284678;
	Sun, 14 Sep 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBI0qGyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A168469D
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876954; cv=none; b=m9OuDJu1b3hPjpdttq1qsD3ho+JxedRj+c+Udt+/p97jCbdjmdkh3OLcu9E1tv3M+m6NWt6gjP2d4YPpZVxMe8wYcBkIwJ1Wxq21zqIafit2bavhKZDXBJC7CcPM8rjHzEFQApBuxK/OcAdhyiLEFfPI4fqH08LahGzLmvr+9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876954; c=relaxed/simple;
	bh=gMCa7Xm0E1apWWcxIlAt2+ix1LQcLi7zWeWZ6EOmMlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckEd/2KpPXQlAsbrvkHVAEDU56b1dgauCJrIS2AUsWBgm3XjPkXtag3MHM/esypflillWQykTwNaN0ug46OmtNjKbCZ3jzrf1VtPeOUvLJIrwEpi7EIz0iGV0VUNI85o+Kvd1mPglWI7+dyF4jgPwgJoaPYKiszM6tUXFY2NzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBI0qGyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90416C4CEF0;
	Sun, 14 Sep 2025 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876954;
	bh=gMCa7Xm0E1apWWcxIlAt2+ix1LQcLi7zWeWZ6EOmMlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBI0qGyT5Ec3Ntr1GYI1oL3qjVpfJFYC3a0Rns/AbQs2MuxttQIbqw62ihPD4LREx
	 1KNQqLK3EBhAcLvl6lbsSoENyzO5DQZ3EtN2cCNl4WRpx1Ggdrbu05XHGub2Y5sloB
	 8H5KL4HT4VyNnNMZErFztsGCCQP8XU5HcdSWlPhvIedqIpjFp84rFc5oy1encaOi7Z
	 eljKLxlDU8f5ZjlNCRwG2F6W2PD93SmAnU5fy5jTmO8BwhLNE3/VPKjD6K+ZZrBQbD
	 7GJlpg3g2+HGwK62n1yITtYFA9hMuAmwbwMuDTqwat45wLifUs+65ss8Y8r5yXMsql
	 lAm0HOT0b4/ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/i915/power: fix size for for_each_set_bit() in abox iteration
Date: Sun, 14 Sep 2025 15:09:11 -0400
Message-ID: <20250914190911.183186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091355-getaway-public-74cc@gregkh>
References: <2025091355-getaway-public-74cc@gregkh>
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
index 9e01054c24300..8beeda3439818 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1170,7 +1170,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (DISPLAY_VER(dev_priv) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1623,11 +1623,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
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


