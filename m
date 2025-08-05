Return-Path: <stable+bounces-166553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E296AB1B2F2
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A31822CA
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D2275B15;
	Tue,  5 Aug 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPDYRZ5z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B6276059
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395025; cv=none; b=MvfjYWxpWqvkhSC5LEatOb+sr0LH1dQo1U9lH3nzh/pk8P58IzKn8dYNFswCivosOATNmPHXI0Bg2HN2PuvB79St7FYmwJXIJ0G5qRQbQAY0p4E9NlVwPTa0OgBCmsQUyVrwDwQevCMc3UIAD3yl0go8VF8NcYLfR7limA/MYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395025; c=relaxed/simple;
	bh=iyk6vFm0CV9wP9U5+AR3P67YyB7CCgRy4RMX2mEDQrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GxT6hb3tRDlAwbuCHEmTBfvpi6iim72mhGcq9yyiLFFcqg1jdxpuIK2EZwruwcIQQWsloDxrDK06Tza6D9q4HfYv8haQ5POEJMpMT/K1/AKjOSeneRGiYj9WsmKVhrklFEYvkbjNu3ThysbQcSsgGPnHzYHofgwlJ7t5DCje5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPDYRZ5z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754395023; x=1785931023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyk6vFm0CV9wP9U5+AR3P67YyB7CCgRy4RMX2mEDQrE=;
  b=lPDYRZ5zX7wCT8ncxxs94mGrj3sSGcClUn71Wp31miCdCYL8ms82Ua9X
   +UUAf5dVuhNLLVRCVz/ZW3SDYAKpjIrntRjHfZ04Xlxn39g61qM5uDpfR
   ldSwJJl0kZxRlRMDFQSSqfX3QjZPIGrOFbBPRdfHE2uqdES0sky8nieEH
   FTgae3yxpvS3nblllQ56ZFQ1rJuvKu8UrBv4M8bBA7bpy3sKL9dMSa1vx
   atnRdlUsHziIB3dTvdeSgDeuFQ7QP7rXYZcmNPJtXeDhCMXs/HjR8k7pQ
   /ccPBhotPFeNdwGAaL0pnTY4Mn8fCFJ5i3+Z5YoSo5YyWtEDl/rAeFGuf
   w==;
X-CSE-ConnectionGUID: sz3CNy5jT7CzdlOirt3rLA==
X-CSE-MsgGUID: OXmN3kDURBW0MBEC7AzSSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60493547"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60493547"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 04:57:03 -0700
X-CSE-ConnectionGUID: IJVu6eaDTfW2BKNeUQjc3g==
X-CSE-MsgGUID: FkC4YRAbTM6jF3BT/3CxeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="168733040"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.8])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 04:57:00 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH] drm/i915: silence rpm wakeref asserts on GEN11_GU_MISC_IIR access
Date: Tue,  5 Aug 2025 14:56:56 +0300
Message-Id: <20250805115656.832235-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Commit 8d9908e8fe9c ("drm/i915/display: remove small micro-optimizations
in irq handling") not only removed the optimizations, it also enabled
wakeref asserts for the GEN11_GU_MISC_IIR access. Silence the asserts by
wrapping the access inside intel_display_rpm_assert_{block,unblock}().

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Closes: https://lore.kernel.org/r/aG0tWkfmxWtxl_xc@zx2c4.com
Fixes: 8d9908e8fe9c ("drm/i915/display: remove small micro-optimizations in irq handling")
Cc: <stable@vger.kernel.org> # v6.13+
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index fb25ec8adae3..68157f177b6a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -1506,10 +1506,14 @@ u32 gen11_gu_misc_irq_ack(struct intel_display *display, const u32 master_ctl)
 	if (!(master_ctl & GEN11_GU_MISC_IRQ))
 		return 0;
 
+	intel_display_rpm_assert_block(display);
+
 	iir = intel_de_read(display, GEN11_GU_MISC_IIR);
 	if (likely(iir))
 		intel_de_write(display, GEN11_GU_MISC_IIR, iir);
 
+	intel_display_rpm_assert_unblock(display);
+
 	return iir;
 }
 
-- 
2.39.5


