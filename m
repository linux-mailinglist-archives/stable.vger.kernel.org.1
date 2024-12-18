Return-Path: <stable+bounces-105196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725E9F6C73
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 18:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A520169ACF
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924C1FA240;
	Wed, 18 Dec 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1Q6Dis9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D876153BF7
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543563; cv=none; b=Yri9rg8h7X1IjM9s5USgk2XZ8q4DraHjqgwGtSC9xZZwAL4CC6CgS5taurCxWBQudIcmV0jRf48IkcHzlD4OLyERfKz6eM4H9zJ0akGQrakMUJYQy7vw1eMFPeZ3slVbAlxnDP8mnpFLXAhsJuLZ8koQq8ieUxBwMAivUz2XQrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543563; c=relaxed/simple;
	bh=Ez7N0N7o3+6nJ01R9Qy8bDgSgFFvG3YGEb0iqpDyb+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fte90FsiL5WPmYunXcrsFR7Mt9vMm4HYQoF7/z/jpEnZsToQ/1xU36uHLXkzygHOqoZpwhwUeU+b7RQYkD/2/9TWLwFNjEjxPB7nePhytvL4HfK4w0bjJnNfh9DR9OedMhv+K2aAR0Gd4xhxcOxvpUQlgjOLj1FjK4XZpwbKIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1Q6Dis9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543561; x=1766079561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ez7N0N7o3+6nJ01R9Qy8bDgSgFFvG3YGEb0iqpDyb+E=;
  b=G1Q6Dis9vflbGMY3NWL2thCdPk+xokPKmcmnWMPwClCTE2a174KNZNUA
   rPOoPoxSdVIHBs1OH/feLWwmxVufo+azPVCgiB81OG1Qmz7dUQel+wd1M
   fhHqRVEy6yHOjBKmcrVoDQZkIgqM0Ed5YRkeWvm+0YoNzM8qOvx+/EPV3
   6P235q+JXkslyljBc+Fp2wyQ/fPIkCNbWkBCZ6JFQMz5jhc53aPk4hRc2
   UfTZqJ3NA1MxMHlkZ39oCU9Immnden12LOeIvXkh9G5wX/ZykqspdxoYf
   h1vQOfUkmOSHwg/7/qBnHZJ92rRFXWHSyW7O+7nkknIAh317ic6pN8+Uq
   g==;
X-CSE-ConnectionGUID: X64NF35hRO6z2C7/lwimSw==
X-CSE-MsgGUID: u+1QtIdXRtejEFT6Ueo1EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22619208"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22619208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:36:56 -0800
X-CSE-ConnectionGUID: mBv1F+0RQKaKPDl6uUu7OA==
X-CSE-MsgGUID: Q4aapQR6Qnm7fSF9U8fx0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="98165369"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 18 Dec 2024 09:36:54 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 18 Dec 2024 19:36:53 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/4] drm/i915: Drop 64bpp YUV formats from ICL+ SDR planes
Date: Wed, 18 Dec 2024 19:36:47 +0200
Message-ID: <20241218173650.19782-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218173650.19782-1-ville.syrjala@linux.intel.com>
References: <20241218173650.19782-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

I'm seeing underruns with these 64bpp YUV formats on TGL.

The weird details:
- only happens on pipe B/C/D SDR planes, pipe A SDR planes
  seem fine, as do all HDR planes
- somehow CDCLK related, higher CDCLK allows for bigger plane
  with these formats without underruns. With 300MHz CDCLK I
  can only go up to 1200 pixels wide or so, with 650MHz even
  a 3840 pixel wide plane was OK
- ICL and ADL so far appear unaffected

So not really sure what's the deal with this, but bspec does
state "64-bit formats supported only on the HDR planes" so
let's just drop these formats from the SDR planes. We already
disallow 64bpp RGB formats.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index ff9764cac1e7..80e558042d97 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -106,8 +106,6 @@ static const u32 icl_sdr_y_plane_formats[] = {
 	DRM_FORMAT_Y216,
 	DRM_FORMAT_XYUV8888,
 	DRM_FORMAT_XVYU2101010,
-	DRM_FORMAT_XVYU12_16161616,
-	DRM_FORMAT_XVYU16161616,
 };
 
 static const u32 icl_sdr_uv_plane_formats[] = {
@@ -134,8 +132,6 @@ static const u32 icl_sdr_uv_plane_formats[] = {
 	DRM_FORMAT_Y216,
 	DRM_FORMAT_XYUV8888,
 	DRM_FORMAT_XVYU2101010,
-	DRM_FORMAT_XVYU12_16161616,
-	DRM_FORMAT_XVYU16161616,
 };
 
 static const u32 icl_hdr_plane_formats[] = {
-- 
2.45.2


