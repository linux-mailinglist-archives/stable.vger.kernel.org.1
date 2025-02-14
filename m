Return-Path: <stable+bounces-116425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1DA3601F
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 15:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AF01891365
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082526562C;
	Fri, 14 Feb 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFN/cW5L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BC245002
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542746; cv=none; b=blxxw+39O6URqlvgMfxgNgtqB2mTD1awkWKEPu37M6kXeu4dclTCIpi8WpZpHVY2Pa+zfMjy/780Cf6PBaxgbr/aeAMYInEOt4J63LPI1lZxbRZBrprPgx9PL7T1bs9kHEPnsn4kGbgCAHRO8C+s9jPLcLLajmy7rzxWI2m67ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542746; c=relaxed/simple;
	bh=msQYmafI/c0c6tU2qwhGKbFDzHpUJGVMCjEFwmmEiI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEggOuFkCAO+YmkkNliNsVVx5VLBFT8AymlUDrerDsZhRmBWD56u3DpwY/MLPLuTUiUl1qT3Wi4j3XIxxGvFDAG4+X5CQ4gwVeapi8T65YxvurUzBmiO6NeYL+u4VDWTliu3s1az2Nu84bGhfDIS9uQoTcT6h/DY2QrYGcr72kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFN/cW5L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739542744; x=1771078744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msQYmafI/c0c6tU2qwhGKbFDzHpUJGVMCjEFwmmEiI8=;
  b=aFN/cW5L91AUjv4ZuDL1DxrRY3EIDM4sVDnDLC9/jB4yd0PTgZdgFArU
   ZWrAPMPzjzKwaL3pM04Ju9PTLcGxCyfu9zmKLE+idccGshiU5hyF1lU7u
   3CUomNv63zGFSxnYhh4FYtKuzAY0mQwuKJgG8C8WXClKkq0SEkSjnPClE
   IRyAm55DG3fVYXyzsd9mfzWlQuNDFw4/UuRrpu2ZrHIQIKhX3BJ+4TTbQ
   vA390q2x9wWiBiTsk2zB4DajMceCQQjiAJWVuDRti3rIG9XTHlL4mL3dR
   A1MNcrNU81C39ilz3K5KqfNeCR5tdSGYhnubppNlWMQokdo0HaYirFZwg
   Q==;
X-CSE-ConnectionGUID: Vdu/dg3LSWmjxpD1AXwgew==
X-CSE-MsgGUID: rJglLtHTS8CQbgZo9bQicg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40217704"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40217704"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:19:04 -0800
X-CSE-ConnectionGUID: kd6ijtDeQ2KhA1x0gJz80w==
X-CSE-MsgGUID: RffigLOiSlCGZ+/NzdxFpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136694225"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:19:02 -0800
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 01/11] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Fri, 14 Feb 2025 16:19:51 +0200
Message-ID: <20250214142001.552916-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20250214142001.552916-1-imre.deak@intel.com>
References: <20250214142001.552916-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The format of the port width field in the DDI_BUF_CTL and the
TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
x3 lane mode for HDMI FRL has a different encoding in the two registers.
To account for this use the TRANS_DDI_FUNC_CTL's own port width macro.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 9600c2a346d4c..5d3d54922d629 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -805,8 +805,8 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		/* select data lane width */
 		tmp = intel_de_read(display,
 				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;
-- 
2.44.2


