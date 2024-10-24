Return-Path: <stable+bounces-87989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CCB9ADA8A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3BB1F22420
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6516D9AE;
	Thu, 24 Oct 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu5lwaKj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B329166F34
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741140; cv=none; b=Y9j4WyhpvoXNC7+el1htMc9oc9qov59+Rj3QwfAPsTqIXZxX4mYyDbbhSZjy0o4lHwr05QSGQk40QELg3JI+6xg2nozkEX45InWaEou29UNeEfsgt924pvagrl2aAJn8/z+mKilpTkQMA3j8fGzGNbcv4R8olq+vd38U8UzpeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741140; c=relaxed/simple;
	bh=VDfQL9Y8RzOB2tLOHKSBfinqiSyyrgGbZifyJe+O7AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIrbswWjrNFHxycGna23cPKY0mreU0PE76MXEK0/ZAajtuHEQmKLSqOjmDZ6EqTQmn3DuD9xdrM8s25ZUFnRYY+6OUoUht3GFwK4Ub0hqOmWoWa1/Q47FFQxJgtGDZZTy9qaH3nOZ4KPVl2/v3rxDj3V+z1Ouq9Mz6UK6O3okUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu5lwaKj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741138; x=1761277138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VDfQL9Y8RzOB2tLOHKSBfinqiSyyrgGbZifyJe+O7AM=;
  b=lu5lwaKjDAKTxdU+c1GNkwXERrPuEHsA337zUtegtHfGUJej0Oc43x12
   igWmicboqzazNUCnjlNwCZg3zK0kpL2+O7FfXsvX7HjiFjQ4yYONWAnsy
   +z0dBpLAYKrWSei7syJadyS3z3ySYL5+EZxa1irYY8SsoWMz5Vgm/zDEF
   qyQA9w7hJDh3fkXPnomzmJEzvMgvxN+DKoIZwujq+Wy8TktZnPQAgYXYu
   +LwfQ6xO4SAfqgRCQvarXMnreC5SNNMxg64f/ZNW+2oaG5BwchzZEm6S5
   ZCvnR5MwH+10LdGDCtOlnBH09x5cyP4ubNwqzgD8LIJHyDq5mDjViWqst
   A==;
X-CSE-ConnectionGUID: WsxnNiq2SoSwakvX1F3ZYg==
X-CSE-MsgGUID: TZx4lwMFSPmiOyU/ctIWSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264994"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: w9xzTj2SQricPqQpTZejLg==
X-CSE-MsgGUID: plIyQjZPSweFIC5Rtn2Aeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384962"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 09/22] drm/i915/pps: Disable DPLS_GATING around pps sequence
Date: Wed, 23 Oct 2024 20:38:01 -0700
Message-ID: <20241024033815.3538736-9-lucas.demarchi@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit c7085d08c7e53d9aef0cdd4b20798356f6f5d469 upstream.

Disable bit 29 of SCLKGATE_DIS register around pps sequence
when we turn panel power on.

--v2
-Squash two commit together [Jani]
-Use IS_DISPLAY_VER [Jani]
-Fix multiline comment [Jani]

--v3
-Define register in a more appropriate place [Mitul]

--v4
-Register is already defined no need to define it again [Ville]
-Use correct WA number (lineage no.) [Dnyaneshwar]
-Fix the range on which this WA is applied [Dnyaneshwar]

Bspec: 49304
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240813042807.4015214-1-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_pps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
index 7ce926241e83a..0918eb218fc84 100644
--- a/drivers/gpu/drm/i915/display/intel_pps.c
+++ b/drivers/gpu/drm/i915/display/intel_pps.c
@@ -951,6 +951,14 @@ void intel_pps_on_unlocked(struct intel_dp *intel_dp)
 		intel_de_posting_read(dev_priv, pp_ctrl_reg);
 	}
 
+	/*
+	 * WA: 22019252566
+	 * Disable DPLS gating around power sequence.
+	 */
+	if (IS_DISPLAY_VER(dev_priv, 13, 14))
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     0, PCH_DPLSUNIT_CLOCK_GATE_DISABLE);
+
 	pp |= PANEL_POWER_ON;
 	if (!IS_IRONLAKE(dev_priv))
 		pp |= PANEL_POWER_RESET;
@@ -961,6 +969,10 @@ void intel_pps_on_unlocked(struct intel_dp *intel_dp)
 	wait_panel_on(intel_dp);
 	intel_dp->pps.last_power_on = jiffies;
 
+	if (IS_DISPLAY_VER(dev_priv, 13, 14))
+		intel_de_rmw(dev_priv, SOUTH_DSPCLK_GATE_D,
+			     PCH_DPLSUNIT_CLOCK_GATE_DISABLE, 0);
+
 	if (IS_IRONLAKE(dev_priv)) {
 		pp |= PANEL_POWER_RESET; /* restore panel reset bit */
 		intel_de_write(dev_priv, pp_ctrl_reg, pp);
-- 
2.47.0


