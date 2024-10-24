Return-Path: <stable+bounces-87984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EE9ADA81
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7721F22456
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39164166F06;
	Thu, 24 Oct 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU1z5z2H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFD15B96E
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741135; cv=none; b=SMjC+M+IB60cE9I+9lx4NIghdMQuMZb2bjo0847WgxKhVCi7M7Qtg1QGZ36NUvWTgYHw/qBD9KvaPLE12Jwrgq4/WIOWqKstPb46YvgkN+u5KcniBzy7FwnlWj38ufticx8b8aN9fzew5p4Vv9/zkBEfjyrbDzWxYFfBRnJEvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741135; c=relaxed/simple;
	bh=ONnFF5bnV61wTQOe071ePWPxrMfVnvrHosX57deqboA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi3FX3afUXMWV92KMB2G2qJEkYfWUEMR1nlJBMCDka16SzTPSXhBkWhTNvISlZNoxRZdPyPWFZjwrN24O8nli5X9bOXYD/UpRF9PMZEV9T78AtTEfT1UBuhalLF/cNsHYWI0bW7GqKMoGqqcLNupQb5Fab0iU5OpJ7SDl6WTDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU1z5z2H; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741134; x=1761277134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ONnFF5bnV61wTQOe071ePWPxrMfVnvrHosX57deqboA=;
  b=YU1z5z2HcaszAz3Tp8MObZ5WB34vJVaIRujMqfVfJ+nvZgfgEKogO7iH
   +l9+b1Q+w1rfvjmP7trCi6nrYDlqvtnpuq9eR4SF7bvuplI57zwJB/tAY
   z66sP8VOXsw2jJvj9k5oPNJp4F2zRbrkE0r4rShjkAe12U7flOQYRhXZz
   XxXASYUX5Pqyy99WzjSc5uE1IZMBQlxoq2Dm/9+ZfXkbudOznwO05EeZf
   d7oQZz7RlFSd/Yn7vsm4jOVuwrxepZinHhufJNPDR6AyxbIB7uqESGNys
   MsTvS+kReerWwgURZim80sSbPiq2OZ7fXpHYKBJzg2Kll3qlVH8CbIP6a
   g==;
X-CSE-ConnectionGUID: IiENsg+YS+yAQjrK2F6dWA==
X-CSE-MsgGUID: eubrflg4QMmSSLix4q7DHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264987"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264987"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
X-CSE-ConnectionGUID: QCzBmi/nQfeTjoVL6wmP0A==
X-CSE-MsgGUID: MYyL9BS3SYO0Eka4sgevVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384945"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Nemesa Garg <nemesa.garg@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 04/22] drm/i915/display: WA for Re-initialize dispcnlunitt1 xosc clock
Date: Wed, 23 Oct 2024 20:37:56 -0700
Message-ID: <20241024033815.3538736-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>

commit 7fbad577c82c5dd6db7217855c26f51554e53d85 upstream.

The dispcnlunit1_cp_xosc_clk should be de-asserted in display off
and only asserted in display on. As part of this workaround, Display
driver shall execute set-reset sequence at the end of the initialize
sequence to ensure clk does not remain active in display OFF.

--v2:
- Rebase.
--v3:
- Correct HSD number in commit message.
--v4:
- Reformat commit message.
- Use intel_de_rmw instead of intel_de_write
--v5:
- Build Fixes.

WA: 15013987218
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240708083247.2611258-1-mitulkumar.ajitkumar.golani@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index e288a1b21d7e6..0af1e34ef2a70 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1704,6 +1704,14 @@ static void icl_display_core_init(struct drm_i915_private *dev_priv,
 	/* Wa_14011503030:xelpd */
 	if (DISPLAY_VER(dev_priv) == 13)
 		intel_de_write(dev_priv, XELPD_DISPLAY_ERR_FATAL_MASK, ~0);
+
+	/* Wa_15013987218 */
+	if (DISPLAY_VER(dev_priv) == 20) {
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     0, PCH_GMBUSUNIT_CLOCK_GATE_DISABLE);
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     PCH_GMBUSUNIT_CLOCK_GATE_DISABLE, 0);
+	}
 }
 
 static void icl_display_core_uninit(struct drm_i915_private *dev_priv)
-- 
2.47.0


