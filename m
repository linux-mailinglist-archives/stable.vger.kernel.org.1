Return-Path: <stable+bounces-132415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F9A87B83
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767E716949D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388925DCFB;
	Mon, 14 Apr 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPhGvIqm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8D25D20F
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621717; cv=none; b=IzptvZhGkgqeri0QXPkuA1UPmTnhREv9bMpmQBrwIwqh2+lqG9jvKJ8sen9U52BDektxj3QXVRDGNogGlZcPL8iImNJ5BDrraSRHTAvw746NJVaUazhAOREmJ9gsHDd1asy9qFjqCVuaVXp6bOxyuHBnlchdNw7R6AqIzp9bjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621717; c=relaxed/simple;
	bh=pnxQh0AiTMXyb4nILx63z4xpYF4EJbKL28hPXmzpELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNUa4bOQMNLozGq2RTB5AHsmAiLENvjv5PAJEqGS1h4rLp3+VjLXS7eVI3Y9zPlLrCvH0lqPk6POk90RX+uPJHNTunUZalEknsU4LS7s3NwqRKAj+c9zRYVyxMEUkJy6309+BRvPOeWiQHkkzPppCPjL959BqVJzEbFSF4Y2qZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPhGvIqm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744621715; x=1776157715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnxQh0AiTMXyb4nILx63z4xpYF4EJbKL28hPXmzpELw=;
  b=hPhGvIqmqoM8sZuPfKMqJ+F2adsF2qDPWKazmTWGCI2LgBxdGJuI9xLr
   t+pXmZnwHypgtjRu1/BCm6l4hCjwmWkogQaqZuLqGY3kS8uXxt64ffJX0
   vMtHiws6v3pWQ6oRz8QTCW6j5PPgxZwjJaglV9RclmAdqWlfrWE3JkcEt
   G7cKpFilar75u1PzVVnN7/uuu2WmpzWA21cuthQpT1tPgHVH2XUxKca20
   Rc0pJsWhKJSOXVVaOEwKR+NcCWRRqlKTqIwabqZ+6D4ZM6IRY8be5xyGv
   oyZ44bB04bMo48NfIpTSGcnKQJgrJ3OzpjBlmCSINN/D9j1wJ48ysWXFo
   w==;
X-CSE-ConnectionGUID: wE3wHkkHQq6sqfkTyj4wCA==
X-CSE-MsgGUID: dIsv/phfTuWg37D7KIwAKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45994212"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="45994212"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:08:35 -0700
X-CSE-ConnectionGUID: 3Vr0uzICQs+6zUQgD/EqQQ==
X-CSE-MsgGUID: 30a2i2MBQXefGka17fyIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130743881"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:08:33 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	stable@vger.kernel.org,
	ankit.k.nautiyal@intel.com
Subject: [PATCH 1/2] drm/i915/display: Add macro for checking 3 DSC engines
Date: Mon, 14 Apr 2025 14:27:01 +0530
Message-ID: <20250414085701.2802374-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250414024256.2782702-2-ankit.k.nautiyal@intel.com>
References: <20250414024256.2782702-2-ankit.k.nautiyal@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 DSC engines per pipe is currently supported only for BMG.
Add a macro to check whether a platform supports 3 DSC engines per pipe.

v2:Fix Typo in macro argument. (Suraj).
Added fixes tag.

Bspec: 50175
Fixes: be7f5fcdf4a0 ("drm/i915/dp: Enable 3 DSC engines for 12 slices")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 368b0d3417c2..87c666792c0d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -163,6 +163,7 @@ struct intel_display_platforms {
 #define HAS_DP_MST(__display)		(DISPLAY_INFO(__display)->has_dp_mst)
 #define HAS_DSB(__display)		(DISPLAY_INFO(__display)->has_dsb)
 #define HAS_DSC(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_dsc)
+#define HAS_DSC_3ENGINES(__display)	(DISPLAY_VERx100(__display) == 1401 && HAS_DSC(__display))
 #define HAS_DSC_MST(__display)		(DISPLAY_VER(__display) >= 12 && HAS_DSC(__display))
 #define HAS_FBC(__display)		(DISPLAY_RUNTIME_INFO(__display)->fbc_mask != 0)
 #define HAS_FBC_DIRTY_RECT(__display)	(DISPLAY_VER(__display) >= 30)
-- 
2.34.1


