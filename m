Return-Path: <stable+bounces-116932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E7A3AAA8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 22:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737F11676D1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188DF1BE23F;
	Tue, 18 Feb 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJY8RYhv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EE158A13
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913561; cv=none; b=Ogp4t6S7vj0yTe/aKd3c6GFug4+leTC/02eMRExg3LlUKIEeRtAjzv1hlcrldFUfmLJEtTgmYMRjDucB3Pc1dSGelzeZYlrjj0yYtQOYe7vyDqB1mm5b2LrIxumNofWxIftTV60oTY0fxWDwUtJ3CT3GH+Cok1DbwP0qTvf2Abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913561; c=relaxed/simple;
	bh=/34wpp6yakrzhidCMPsVjwf9R4U+PnmLvidB6UkYHjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMrguMWn5PxLqjQakq18XViB6e7iicnsyn1maiPSutkYSy7a5OcItmUWZuEWFe9ASnwBdRsC3gCtB+pIJm80KnCgZRBIGee53DZODLDIF7aXIubmzKcI6gG5FOxDfEHsaTqSGOmjkzuoOcMH6XDp/xJWtmF3/Ipe3Do/pVBSIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJY8RYhv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739913560; x=1771449560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/34wpp6yakrzhidCMPsVjwf9R4U+PnmLvidB6UkYHjM=;
  b=IJY8RYhvJkD8HzoM8t2s4rBkvbtaTelFT8U6/4jWAM240GjGAJWeCEIg
   0+1Ik0CDzEWAKtqkaNWIrxUP1AIJC60iNRTHIqURFpNqUYaaAwrFgoNTG
   L1UE4u/ig+vFBxudEQG/whgZTNrPTwZtsCLI/70ClDFv/jr806Ep/G7z8
   gGOgvweLF9b4MJb2DcdrJrhEjoE4+mSvCu/x4/JJglM3DsXCzwDen3pfQ
   lV8zxpCgBTj05Ud1qBX36rJLEcPSunFwZaUlcJGtlxYP0Ad9ACc8Zuu/d
   KOXvM1VrwCGhwgaUcIgUlU4X4KR2iczWr772SQtvFpoONePnZZ4orzLJh
   g==;
X-CSE-ConnectionGUID: 2qfSpf9LRpinnvr3X0Szrw==
X-CSE-MsgGUID: iUwy7RRDRQOOzx1nSaf+FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39862251"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="39862251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:19:20 -0800
X-CSE-ConnectionGUID: dZrO6h3wQGq/tSVQ6OJ4tw==
X-CSE-MsgGUID: yO0yX1GAToSXyBlRtd5kmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114693347"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 18 Feb 2025 13:19:17 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 18 Feb 2025 23:19:16 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/19] drm/i915/cdclk: Do cdclk post plane programming later
Date: Tue, 18 Feb 2025 23:18:55 +0200
Message-ID: <20250218211913.27867-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250218211913.27867-1-ville.syrjala@linux.intel.com>
References: <20250218211913.27867-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

We currently call intel_set_cdclk_post_plane_update() far
too early. When pipes are active during the reprogramming
the current spot only works for the cd2x divider update
case, as that is synchronize to the pipe's vblank. Squashing
and crawling are not synchronized in any way, so doing the
programming while the pipes/planes are potentially still using
the old hardware state could lead to underruns.

Move the post plane reprgramming to a spot where we know
that the pipes/planes have switched over the new hardware
state.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 065fdf6dbb88..cb9c6ad3aa11 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7527,9 +7527,6 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 
 	intel_program_dpkgc_latency(state);
 
-	if (state->modeset)
-		intel_set_cdclk_post_plane_update(state);
-
 	intel_wait_for_vblank_workers(state);
 
 	/* FIXME: We should call drm_atomic_helper_commit_hw_done() here
@@ -7606,6 +7603,8 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 		intel_verify_planes(state);
 
 	intel_sagv_post_plane_update(state);
+	if (state->modeset)
+		intel_set_cdclk_post_plane_update(state);
 	intel_pmdemand_post_plane_update(state);
 
 	drm_atomic_helper_commit_hw_done(&state->base);
-- 
2.45.3


