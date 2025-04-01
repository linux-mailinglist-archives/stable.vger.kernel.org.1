Return-Path: <stable+bounces-127347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813FA780A1
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E0D1883BD2
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4E204693;
	Tue,  1 Apr 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ04TIZS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253C26AF3
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525487; cv=none; b=h4CEcTcVWHXDxDK7qAwitKgGL0ketytPSgrK1DJqVzwi47Ohg/2rAtUBdXrl7CfAWKgQQrY+JpVPHAJsEQ/djHjMRzlUnbbjjpUMbtrDopAdTi4j1chHNI3CmG520JEWIFajXCrQ9Hb4WVQDenGdcFMEeRQlaIdpq2MpvuPu8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525487; c=relaxed/simple;
	bh=SZf271VfOjlaxtvm/iinogqmiUjjofRuKWh7OgdDSZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuXjBCqctGeYKAWyRlP0/cQnTnRajcjjysabnZiioNsUJviE+rBtW/edIDHu+n6Wt1nTWqjM1ASyJosazhlWB3wRXx7MgnpfHyTDoqxAede9YToWuVsXFh4Fsn1oGuZUFI9XveZ/t1+GYr4TBtwxrc1FTPzDWpZ86ZZODxfQ3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ04TIZS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743525486; x=1775061486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SZf271VfOjlaxtvm/iinogqmiUjjofRuKWh7OgdDSZs=;
  b=ZQ04TIZS/W+HU9mouRfcnXEBr8c5D5WyqR6ezf1aWSQR89s+JHP3SVqK
   fVTRmEVB/QEHi7QkhNeKdF0TyorQnN0fxCpcTJnYjc1feDSJv/Oh7WS3S
   SR97LlzPbtFGMtYftRib5hh7cl9QAVT+U81bxz78sn8EBMv2Cae9ZUud4
   F/aCsG/IS4cszDPqSPjYxUKBay/ojGdfYIo0h7ts2mFsmgOI9gIPgRCPb
   l4l1zPwQNSmE8OQwr9ih1LadmGyU7cVwgc7YF3IP+O18PJ0uRSsJq7mdg
   nhNBMJVp4l6mA+lUmbNFDrvt1+jAh05xesp3MZjyCgG5GwJqfjw2myT9h
   A==;
X-CSE-ConnectionGUID: LZ0cLrZiSx2l5xsOAUTSHw==
X-CSE-MsgGUID: F1X8E6xaRQeG1GpIoaINvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55520048"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="55520048"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 09:38:05 -0700
X-CSE-ConnectionGUID: Du1X8kyJTICkCAciKvlq4w==
X-CSE-MsgGUID: GWp3WaDGTeqQz+56dEPI/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131638607"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 01 Apr 2025 09:38:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Apr 2025 19:38:01 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 3/4] drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
Date: Tue,  1 Apr 2025 19:37:51 +0300
Message-ID: <20250401163752.6412-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250401163752.6412-1-ville.syrjala@linux.intel.com>
References: <20250401163752.6412-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The intel-media-driver is currently broken on DG1 because
it uses EXEC_CAPTURE with recovarable contexts. Relax the
check to allow that.

I've also submitted a fix for the intel-media-driver:
https://github.com/intel/media-driver/pull/1920

Cc: stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 71b1669ea9bd ("drm/i915/uapi: tweak error capture on recoverable contexts")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index ca7e9216934a..ea9d5063ce78 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
 			continue;
 
 		if (i915_gem_context_is_recoverable(eb->gem_context) &&
-		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
+		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
 			return -EINVAL;
 
 		for_each_batch_create_order(eb, j) {
-- 
2.45.3


