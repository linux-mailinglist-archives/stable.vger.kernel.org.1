Return-Path: <stable+bounces-119386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E9A426BB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930FD4418B5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6E2561A8;
	Mon, 24 Feb 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbygH3ul"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C921A0BD6
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411492; cv=none; b=TY1HWP+oIC0UGxWIc3l9VrBeK245GHQzTlB6vTwr+7++yveSI40ZmBuN4xUKdOttXYwV2HtaWzJ5pDqQKSdQ6Q5F4+w+rZmMqIk715lVjbksWAWfe/iQrmyDtR2FV9+/DSjhACIjkhq74ypibyKsEu1P+EiZ8pf2WSu7d+0yOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411492; c=relaxed/simple;
	bh=+ll2EL/HRbmFdt3KQ3pxPazIlysrePz+isuU7/xCrus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN7vx12eW4HfAiene5YPyMHpWqSoaflS2SWx/sQouF/CLK0zEMnFdaqdQP0enrZYGo+cqwCRD4jZtjklSvMLUwvJbIJWketky6ufpHfgAR3G1jCL8I1ksg8fvgFLoBrErAyJYnrMwuUBHLWMJoN4rTjocBYdors9I16V0iRS1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbygH3ul; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740411490; x=1771947490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ll2EL/HRbmFdt3KQ3pxPazIlysrePz+isuU7/xCrus=;
  b=hbygH3ulA5EAJOpP2/wTVG8NSPntMshf4ieSnzKpmQBcoSOTT/VvsLnB
   1/Clggfa1KmZ1cp3BCiff9seefVormEZiK+oWrnd6RRyXLt1pZFDNN3mg
   TNYm8hwO19T1odc3iygf/8kEMEEbdWq69E45xRaeIpJAJDRGkbDimGF2k
   A+7YcRFb3FkBnLD5accliChL3xekCsX3q/CbvjD380jqTYQRjilV53A6I
   +9fQrijpdHLfMPMss/8lg3laY1pUsQbv9eSC9SNHcXGRyFcY6nVszOlXk
   F//VO+u3XyqB03atDsGkmi6JHpYw/tY4TMHNgrEcEpMGpWZ9MfnJ0E1Y4
   A==;
X-CSE-ConnectionGUID: BSE+bAFLQfqKhKBGoGtu4A==
X-CSE-MsgGUID: 1krr1RKCQLiWxlR5088QCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44824823"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44824823"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:38:10 -0800
X-CSE-ConnectionGUID: gV2yU88sR/KOusIXCrnQlA==
X-CSE-MsgGUID: /e+hzTBTSU+qeXAeDtHezg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116068980"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:38:08 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Mon, 24 Feb 2025 17:39:10 +0200
Message-ID: <20250224153910.1960010-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <2025022418-clergyman-hacker-f7f7@gregkh>
References: <2025022418-clergyman-hacker-f7f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 76120b3a304aec28fef4910204b81a12db8974da upstream.

The format of the port width field in the DDI_BUF_CTL and the
TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
x3 lane mode for HDMI FRL has a different encoding in the two registers.
To account for this use the TRANS_DDI_FUNC_CTL's own port width macro.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-2-imre.deak@intel.com
(cherry picked from commit 76120b3a304aec28fef4910204b81a12db8974da)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 879f70382ff3e92fc854589ada3453e3f5f5b601)
[Imre: Rebased on v6.12.y, due to upstream API changes in
 intel_de_read(), TRANS_DDI_FUNC_CTL()]
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 293efc1f841df..834ec19b303d5 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -800,8 +800,8 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		/* select data lane width */
 		tmp = intel_de_read(dev_priv,
 				    TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;
-- 
2.44.2


