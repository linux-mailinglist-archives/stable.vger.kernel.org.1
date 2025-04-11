Return-Path: <stable+bounces-132271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD0EA860E9
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5585F16A661
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5C1F4198;
	Fri, 11 Apr 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSWb9rIs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735361F3FC8
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382602; cv=none; b=ndeuQeUE4+llDaboxXVrmjXIaqM/rt61CLb+yCL0VzY6yI6yDRkOZ9ntbnZx26T8Kvso8xY7/NHWQq/z2Ph3hjIXuWjdeNqC3iFfz86bqagOzkuwvRDXEC1KT8aNdNVSnH+nN6ImF+B8G3bHcjHeJTC0qb9JojPpIAbQjCtdW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382602; c=relaxed/simple;
	bh=3Z6HT9Tfv0F4a8qgDzqrJy9v3ND72f5yLT6i3F3ZeW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFRMzHBfKp0qplJKvgOTmkfd2IN7p9JIlcgvN2gDBah4kW6mODXnaBCQ9uyMrNl8bevKDQSiQEYSZMSG2kGo7crdglc5RJBK5Hgk7xgweXJPxdqtrkfdLIJnTWSUPLpSzr6ivfAxeJwRGvKolbYpnBR2n6NQLFFWozFusr6h03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSWb9rIs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744382600; x=1775918600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Z6HT9Tfv0F4a8qgDzqrJy9v3ND72f5yLT6i3F3ZeW0=;
  b=TSWb9rIsJ+ZKw7MgAV8ee08JXVGbdtnGHVJe8sui1b1pjFFeVkFCuHx6
   HYOFTJIf9Hd7uqOuhonFLPVY7Aey3PvjC5TZaIdbhuWxuriTqL+E37pGG
   DC5uauT0p5/DHuc5dnC6wCtUHMx4V4tPPzBpLLkmG6u7xQlUV23RzOxe5
   vOprEO0SsNHCYs41RfP4Tk1TYMUyGW8Dmn6rlG9I4G8oDn9G4wx/mSuSd
   bRWgahL9Dv2Kcc/8QJ3R4k6dNWwk0G4+1huRbPsNhb+KHTA97jIky9p0o
   W9YuYgtrWwL6IKachsi6YWZF8FXDLHGSBtk7TaHyvaqdZ6Ny90/naFxUA
   w==;
X-CSE-ConnectionGUID: J3vsUw/FT0ak+bvtWK+N1Q==
X-CSE-MsgGUID: nqQTYmh4QE6G7mEqq+5v3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="57316232"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="57316232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 07:43:19 -0700
X-CSE-ConnectionGUID: r9FBdMF5SOe0SZIBZ6HAWw==
X-CSE-MsgGUID: zdrtha3ISFadceuLL7lzmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134370135"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 11 Apr 2025 07:43:17 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 11 Apr 2025 17:43:16 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v2 1/2] drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
Date: Fri, 11 Apr 2025 17:43:12 +0300
Message-ID: <20250411144313.11660-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411144313.11660-1-ville.syrjala@linux.intel.com>
References: <20250411144313.11660-1-ville.syrjala@linux.intel.com>
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
Testcase: igt/gem_exec_capture/capture-invisible
Fixes: 71b1669ea9bd ("drm/i915/uapi: tweak error capture on recoverable contexts")
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
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
2.49.0


