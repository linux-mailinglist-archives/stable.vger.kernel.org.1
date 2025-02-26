Return-Path: <stable+bounces-119673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64751A46166
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F0B17816A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE621B1B5;
	Wed, 26 Feb 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW+PK5AL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678F84A2B
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578195; cv=none; b=P12WcZwgtELATFqhbjgmm77AskuYeG9QzRy1MW50RBU11It+FyNzBSJNsFgLqGgGL6P1MYheT4exHf8zhW1OB1hC30KRTqO1bsiPdLNDgrCbIQ3HW/NLizSDnhef3wd0bHzcsNXlckF9H6CSZp8VMZFZjMVMTrBW5cy6IwIb1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578195; c=relaxed/simple;
	bh=jTAjUk+9joQGZFsQkt+L+5w+ujSUZbOYL2BHWr7t3WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KvyHDIkw2jQoLKEeemNo+A4uvM/QGj7TaM9hd7b9T2VL4eeVaSFpGID1g5Ny89ekR6/h7J3+JIfT6Fcmh1fi9D8Gqzm+3Hv+urPzZi+5SeDIa8EnskdSBU4BEVN0H0p6eRRm6k/M8tDfmZavp6QXVxjU5q5Xbj/VU+7zSjRwjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW+PK5AL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740578194; x=1772114194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jTAjUk+9joQGZFsQkt+L+5w+ujSUZbOYL2BHWr7t3WI=;
  b=BW+PK5ALSFkDqz48rJ6K0GKtfLRGLp6lAE0HTnjWqltrSa1Q1vgRYQne
   dQM0XoBUblM8IAtro7q7jUw5HuYkmGu15g5ZNqHzu7lO0dVeE1VNaY2Ho
   qmYW4Urn7qDOV20EMvDcSrCryfRleHA6xzGG8y3xv7UzEPxq8aQuHnxwy
   N3WU61Pxc719oKSQSjebtl1GGBHbiRSuQoO8e7CR0TTxj5vNb2+KCdgd+
   6QDTEDVT98PSbnb/CMyGLsoyHb6DxZcRKKTmP9doS+muvbMxfMYgI8v74
   e8OEv2FwA7PePUmqUHXc7M4JgjSAqLRaJe7o29EzsfiphCHHLMVYbNpAs
   g==;
X-CSE-ConnectionGUID: v7XoRh0PS1yncPDB1QMrOA==
X-CSE-MsgGUID: Ue9g3uMGS1uMcUOxw3S3Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40657622"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40657622"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:56:33 -0800
X-CSE-ConnectionGUID: 2rkWMhOESB2zubNhmYZHyg==
X-CSE-MsgGUID: 1zNCwnNERpyxNwXOGRwzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121804012"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.123])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:56:31 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	stable@vger.kernel.org,
	Imre Deak <imre.deak@intel.com>,
	Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH] drm/i915/mst: update max stream count to match number of pipes
Date: Wed, 26 Feb 2025 15:56:26 +0200
Message-Id: <20250226135626.1956012-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

We create the stream encoders and attach connectors for each pipe we
have. As the number of pipes has increased, we've failed to update the
topology manager maximum number of payloads to match that. Bump up the
max stream count to match number of pipes, enabling the fourth stream on
platforms that support four pipes.

Cc: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 167e4a70ab12..822218d8cfd4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1896,7 +1896,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *dig_port, int conn_base_id)
 	/* create encoders */
 	mst_stream_encoders_create(dig_port);
 	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
-					   &intel_dp->aux, 16, 3, conn_base_id);
+					   &intel_dp->aux, 16,
+					   INTEL_NUM_PIPES(display), conn_base_id);
 	if (ret) {
 		intel_dp->mst_mgr.cbs = NULL;
 		return ret;
-- 
2.39.5


