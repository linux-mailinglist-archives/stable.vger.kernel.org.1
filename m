Return-Path: <stable+bounces-19300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4D084E438
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 16:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F91E1F26CC7
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09117B3EA;
	Thu,  8 Feb 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVZt/wN0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C87B3E9
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407157; cv=none; b=kL1swTga8Bcm+PHmf42Nazb30mVolzt5LuAo0P3aiMzYTRZP37ViT51YIdxeZyvwXhB2qOB3ET7vGjMNNEJXldJavxKv8VsvMuyaegkJutA3kjWr2MK8teaC9UyKn01zaX2OlUPzYPzn1vUYaPUsri6Jv/fs+5qGiQb+fU19RSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407157; c=relaxed/simple;
	bh=A9yaxMwUDVUVXXKhGKwpMz7HeXYkp/aria/DOFQHeyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DtyoSLp7MvvGs8CqZf/M3WfZRnaCObR0q78QoDiMezYdnAPf0MhOOPxofHacE63qs2v2N1H8tlQ8E5x4kgz6KMswGlaVz5WvmnjGqiqOJPTTSbGc2V1l6Ut7b/PposMs4dvN/ry0wZNqIgxtngjbpiW5XOUl95DtA0itg50suAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVZt/wN0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707407156; x=1738943156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A9yaxMwUDVUVXXKhGKwpMz7HeXYkp/aria/DOFQHeyI=;
  b=MVZt/wN0VDyQUE5WJLXg0NKRtEAe1BmjGPOJFHHkBJaSt1mJeVL4k1+C
   O+gS5JVVTFmCf67GRhERY73B36RDRWFzJCihdkScnLkHLmJqV7VMudevu
   DfBc1TG+8gNzSPXtc/ldshKa8Ep+2AlnJzg+Go7x+jzEoKowd2CFBTt+L
   hx7m71YVlouwk6goWpBmHEINlMwbX9820Xp6f4vFWnU/2nobdoyRuI0Hv
   fipdik418nydBrkhr8mMTXZD4qpVGILhcnUqDB6gBGChGPyiolv4Mmbx+
   jXwQE8ax05sogxXUi43Lw9T18FshWGKlScvXddfuvccVlT5OrkU8zsXRZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18663156"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="18663156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824867150"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824867150"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 08 Feb 2024 07:45:53 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 08 Feb 2024 17:45:52 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Limit SST link rate to <=8.1Gbps
Date: Thu,  8 Feb 2024 17:45:52 +0200
Message-ID: <20240208154552.14545-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Limit the link rate to HBR3 or below (<=8.1Gbps) in SST mode.
UHBR (10Gbps+) link rates require 128b/132b channel encoding
which we have not yet hooked up into the SST/no-sideband codepaths.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ab415f41924d..5045c34a16be 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2356,6 +2356,9 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 	limits->min_rate = intel_dp_common_rate(intel_dp, 0);
 	limits->max_rate = intel_dp_max_link_rate(intel_dp);
 
+	/* FIXME 128b/132b SST support missing */
+	limits->max_rate = min(limits->max_rate, 810000);
+
 	limits->min_lane_count = 1;
 	limits->max_lane_count = intel_dp_max_lane_count(intel_dp);
 
-- 
2.43.0


