Return-Path: <stable+bounces-177796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A58B4551D
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64511C23296
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A172E2EFC;
	Fri,  5 Sep 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiWYY7EU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E52E54D3
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068919; cv=none; b=f1HNKbfW/Ri69YTVBibOjfZnIdbsuL5XFtHmIV9LkwDwLJQrJhQIg8mtkjIUq3SzPbCJbvhOApY8nJIJpHQ08ZKlSqZ01Y6wQqsXECbTiPUj6v8Dv1O5ZFtKijEAlCU36IQ9l/SrVbnBFGtQahYb8Ke/qRA1XGo/BW1sSOYhDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068919; c=relaxed/simple;
	bh=IoiYsvwp+n5saJuhGWWB0NI1sBGBy5zXDS1pu1r878c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KbtIOLxUrYxvSElfv63OUNrQ4SgEMozrU5hhVBwvFj9q9HA9zMyLIZbvY81ZEYi0GpjXL+bSQScrcIhCO2lLVZk+2pSB7pmv32wggMPE8rZoAwY6722q80rGGkraQti9ss5SM1dTGRrmqrKjHi3gf/dDeBTUtFk4epGws7qz5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiWYY7EU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757068917; x=1788604917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IoiYsvwp+n5saJuhGWWB0NI1sBGBy5zXDS1pu1r878c=;
  b=AiWYY7EUrinkd3cYzEf754uGHL+Ni1T9x0dgcK5PwhTiW65IehhNY5Fo
   2eKZrbQFd4MMF9rXGz1SoMs/Twml7EhFFeYzfxsUMgF4RKOHKhx5jm4Ib
   AJdzgqFbWmecSnIEWMUFpNm4hP90G6VI058kD5Qa3Kz3gE1ZVX9ToKfbr
   1f4qR2vg4srdfM1j7A24QRUMkxsJHDJfgwOkuBIXiO/iZSo5JtstSiltN
   uoiFGHVyi1aXarw7c7iAM60pljr2bpJOR2WkgciHW101iO42L+4Bs9lTi
   u+ijUz4LhPpc3XSuwxcrXkgM2faONh1sQ39zoUv08TgSkVzZRRY12SftU
   w==;
X-CSE-ConnectionGUID: Mby6L0S6Ro+ig5WRXdZJew==
X-CSE-MsgGUID: WCFGArhQRNSeVLGPq10Bww==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58629836"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58629836"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 03:41:57 -0700
X-CSE-ConnectionGUID: Zd/HiO9QSAmynFucjeVVoA==
X-CSE-MsgGUID: FeOS1KwORcqphGJDkaAltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="171339491"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.159])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 03:41:54 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/power: fix size for for_each_set_bit() in abox iteration
Date: Fri,  5 Sep 2025 13:41:49 +0300
Message-ID: <20250905104149.1144751-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

for_each_set_bit() expects size to be in bits, not bytes. The abox mask
iteration uses bytes, but it works by coincidence, because the local
variable holding the mask is unsigned long, and the mask only ever has
bit 2 as the highest bit. Using a smaller type could lead to subtle and
very hard to track bugs.

Fixes: 62afef2811e4 ("drm/i915/rkl: RKL uses ABOX0 for pixel transfers")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 7340d5a71673..6f56ce939f00 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1174,7 +1174,7 @@ static void icl_mbus_init(struct intel_display *display)
 	if (DISPLAY_VER(display) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(display, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1639,11 +1639,11 @@ static void tgl_bw_buddy_init(struct intel_display *display)
 	if (table[config].page_mask == 0) {
 		drm_dbg_kms(display->drm,
 			    "Unknown memory configuration; disabling address buddy logic.\n");
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask))
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask))
 			intel_de_write(display, BW_BUDDY_CTL(i),
 				       BW_BUDDY_DISABLE);
 	} else {
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask)) {
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask)) {
 			intel_de_write(display, BW_BUDDY_PAGE_MASK(i),
 				       table[config].page_mask);
 
-- 
2.47.2


