Return-Path: <stable+bounces-179587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6835B56C1F
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 22:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661AB3B3C23
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2FC1F8724;
	Sun, 14 Sep 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkK1ZCPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9144A3C
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881023; cv=none; b=av/+qudvl0J3o5uinO4Vmr8qkifDCzlV3bauxVxhNi1iaW9UTYHAzUhp7hRrh8ix3lk2KZQI9JTPW1zIl0p+HzddetF4BsHXu8nm6C/wouC3uAwnh1990H9tCY6UblWBUErh5Q6PwHfa53f4EaX0qKXaxJ/brjBeCR0Us9aN9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881023; c=relaxed/simple;
	bh=e0MCoVNKFq2j+u5ZVdh5udX63X1hzVJl7seMuZsJfd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shXdIdZbUjBGjLOAWFnOekFu0K1pr2gdHq7WoG1zFDLL4JA18N5nj02fo6n8H+E9LQqKC67kZyBUcOXWDKFfEtg874c09oBuxpVQLG7dQaHNUWtLf59lXmskl5IvJIgAzyQFV8dJvY2jTqUZQjVirvDuxwL4Gex5+uthNmRvWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkK1ZCPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C693C4CEF0;
	Sun, 14 Sep 2025 20:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881023;
	bh=e0MCoVNKFq2j+u5ZVdh5udX63X1hzVJl7seMuZsJfd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkK1ZCPGwTdR5DPyW8YVvwK8luK0JO/aeA00hxc5X1U6jWMIc9KFO342+zQn0BR80
	 9VjJy8JptMhrBHSBZgCFR/X2DO8jynmJl8JZlm+R/TgDGRjEA9pVqHTcmUtSA3y98V
	 Ao9SHO+2b10IzdCFcczvD20m8o7OqvWP3wIOGzV/kLpmEn6TXR7F02jgUwajhWIR1R
	 1qbnOkLrGmL5OZCaWgUeTdkAUS3smHYXQAhDgo227tnoCxDG18CQFTeFTFfid0fJpT
	 mV95lWbXmNXj5t0R2EoN15lxSVI2u9iX9IPnR4PPXx1z+LwnVd2vT6s9Q0jfgCRHUn
	 KLILklqKHP1IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/power: fix size for for_each_set_bit() in abox iteration
Date: Sun, 14 Sep 2025 16:17:00 -0400
Message-ID: <20250914201700.200541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091355-hut-broken-9e61@gregkh>
References: <2025091355-hut-broken-9e61@gregkh>
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
index 1a63da28f3300..8b8ba7426404a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1122,7 +1122,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (DISPLAY_VER(dev_priv) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1587,11 +1587,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
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


