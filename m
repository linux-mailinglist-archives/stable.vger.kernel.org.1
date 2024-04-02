Return-Path: <stable+bounces-35617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A08958F5
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9344628D6C3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E466131751;
	Tue,  2 Apr 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jz4qI9SU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039B1E480
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073353; cv=none; b=nL3kzK+PnIKaEuAf4PQWSUpUgpDBnM8TbYeG90g+RwX6aXtG+EtOQRBqDtqbfWQrs4iF+W7Z9DR4+ccFNcwPPGXH780Cx/rmaeDXr4TpaiJXQL545w6n8Dh2lP1zJUFWvccsnSmQurjjkCYxp5l14CoH5gPYMopnEFhmEEKWT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073353; c=relaxed/simple;
	bh=a9L0IZ6AKmuym+UvxTyui0eHUeV+vC+1qL5uOaKKEqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MoDjatnM6FuXyI8i11F4xaKIuItqB+tPJvuUGIohYeMuO+7G4f+ItYx3BMtj+leKYZB/nY2P1AL7rz4k3w1t++UqBDd60flhhNVAepHF9/YnOqSp3WKN38bkMet5PO6MKX8dWw2Za5ZfAJN0kGw3Ksd7l2mX7YGy5Lse+zWmPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jz4qI9SU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712073352; x=1743609352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a9L0IZ6AKmuym+UvxTyui0eHUeV+vC+1qL5uOaKKEqI=;
  b=jz4qI9SUYLQEdRChYYmZgs/CGbhFZL4xeQEVTcEuy13Xkc2pOFWLyMc9
   ieKFSRWdjgO9QUh2Ly3RTPD/5PuW1ToOUJKGKBFj+Ko3ytdnKrD9Ne/a7
   zH+SgrwCC0/1kj04G7K68/u2lnkVLd/rxwsjkb1QpfYgvmZfrsBXRJqdR
   Qdk8vWwRbTWXOo+d7cTmVstOchc6xds/qAKXSTON8ntEYJKJPUywpC/H5
   qPUg5QqgtQZ5o6W9owJcQUAjbsji78kwTP1L14/Oz9BtjhOSXphGwEFlN
   q3Fw+sEtfq722eh/V06y0CfOukCfCuLgLLR2tzKOARVpYlnvFWbhVj3pd
   w==;
X-CSE-ConnectionGUID: WQcHkX64TfmZ+K0lPQaiOw==
X-CSE-MsgGUID: r+HBqG32R6ezlf33RkkXYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18612830"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18612830"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:55:51 -0700
X-CSE-ConnectionGUID: kV6C0khkRvu2dlv+UJLa2g==
X-CSE-MsgGUID: xpE7JFYzTWOX5kAQYa41JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18160232"
Received: from pramona-mobl.ger.corp.intel.com (HELO localhost) ([10.252.57.179])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:55:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/display: fix display param dup for NULL char * params
Date: Tue,  2 Apr 2024 18:55:34 +0300
Message-Id: <20240402155534.1788466-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

The display param duplication deviates from the original param
duplication in that it converts NULL params to to allocated empty
strings. This works for the vbt_firmware parameter, but not for
dmc_firmware_path, the user of which interprets NULL and the empty
string as distinct values. Specifically, the empty dmc_firmware_path
leads to DMC and PM being disabled.

Just remove the NULL check and pass it to kstrdup(), which safely
returns NULL for NULL input.

Fixes: 8015bee0bfec ("drm/i915/display: Add framework to add parameters specific to display")
Fixes: 0d82a0d6f556 ("drm/i915/display: move dmc_firmware_path to display params")
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
index c8e3d6892e23..49c6b42077dc 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_params.c
@@ -176,9 +176,9 @@ void intel_display_params_dump(struct drm_i915_private *i915, struct drm_printer
 #undef PRINT
 }
 
-__maybe_unused static void _param_dup_charp(char **valp)
+static void _param_dup_charp(char **valp)
 {
-	*valp = kstrdup(*valp ? *valp : "", GFP_ATOMIC);
+	*valp = kstrdup(*valp, GFP_ATOMIC);
 }
 
 __maybe_unused static void _param_nop(void *valp)
-- 
2.39.2


