Return-Path: <stable+bounces-95778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FB9DBF8D
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E2216484C
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC3155303;
	Fri, 29 Nov 2024 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+DoBMzY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AEB184F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732863025; cv=none; b=nOkNm0jZvKikoyVJujJ+8KU+YXGBZd2yggoCr0WlIoiIO+zVztBbYhQ0TDGQx64FPmyHFCSSE46ULFd3O3LJM3DWENwfOgRNJVcaB+rKMjdSPprTm1BnQKJEJSvj3KEmDNOyd14ZSF924PNDLvsk0DRFyWNbADsaJWATQGFZKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732863025; c=relaxed/simple;
	bh=nf8tAorTsdTHxzRpEK90h3CagUqwvx9Se/b4avykyi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNCdM3dg+vSGhDa0Z8wmV7zDyHDFEkwtPZdcth41vm0UI/3PNWiPA/NRaAZM4ErD/uGYu3rrT9xvyEahRCZ/k2BUQjZqXebnKZ/kHTZwgsY9KbNGhh1/q8ZKCGKA5tjCXJ8jnAa3LaL0AL0ha1LgEnFSab+e97rBKCcUUVxSKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+DoBMzY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732863023; x=1764399023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nf8tAorTsdTHxzRpEK90h3CagUqwvx9Se/b4avykyi8=;
  b=h+DoBMzYkLI/D0dyKdH8gP50AFQHvpuPQgnpweut+hp8ZDWIBco+vcVv
   z2/yx44Lj0qiW8rwbV2F/Xjqs+RS4cXP4/RUG61eD7DyWaQhr06qQMgKf
   /fYCkyOH+OIzPoN6nQF0MhQUFYgbuZrFAQIJAn5yzU45rQEu993/gKi7r
   Kxw76x7AEhmOu4vn/SuXdBFDceLhfDOm+GAuZxwnQ2h9EUKYRVzHdwkT0
   n0ZBpRyj8n3QaHyDhHSf7JWMbap9CzuY6S5gb+9Wrb7U6GjWHH/UgXomw
   pqEptv2oGvOljynH/RTbyhMxQsYBl5hTG9iVTNTpnVfp+wCo9SZz1fmO8
   g==;
X-CSE-ConnectionGUID: LHSmlP2FQWyGMpMxiiGqLA==
X-CSE-MsgGUID: AX0Xvpn+RDGMv/VhZZQgBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44468022"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="44468022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 22:50:21 -0800
X-CSE-ConnectionGUID: i+BJFHLDScm0TbIsmmWAqQ==
X-CSE-MsgGUID: uHjolGQcSuStvEqnOjJ4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92589181"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 28 Nov 2024 22:50:19 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 Nov 2024 08:50:17 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Sagar Ghuge <sagar.ghuge@intel.com>,
	Nanley Chery <nanley.g.chery@intel.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 1/4] drm/i915/fb: Relax clear color alignment to 64 bytes
Date: Fri, 29 Nov 2024 08:50:11 +0200
Message-ID: <20241129065014.8363-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129065014.8363-1-ville.syrjala@linux.intel.com>
References: <20241129065014.8363-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Mesa changed its clear color alignment from 4k to 64 bytes
without informing the kernel side about the change. This
is now likely to cause framebuffer creation to fail.

The only thing we do with the clear color buffer in i915 is:
1. map a single page
2. read out bytes 16-23 from said page
3. unmap the page

So the only requirement we really have is that those 8 bytes
are all contained within one page. Thus we can deal with the
Mesa regression by reducing the alignment requiment from 4k
to the same 64 bytes in the kernel. We could even go as low as
32 bytes, but IIRC 64 bytes is the hardware requirement on
the 3D engine side so matching that seems sensible.

Cc: stable@vger.kernel.org
Cc: Sagar Ghuge <sagar.ghuge@intel.com>
Cc: Nanley Chery <nanley.g.chery@intel.com>
Reported-by: Xi Ruoyao <xry111@xry111.site>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13057
Closes: https://lore.kernel.org/all/45a5bba8de009347262d86a4acb27169d9ae0d9f.camel@xry111.site/
Link: https://gitlab.freedesktop.org/mesa/mesa/-/commit/17f97a69c13832a6c1b0b3aad45b06f07d4b852f
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 6a7060889f40..223c4218c019 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -1694,7 +1694,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
 		 * arithmetic related to alignment and offset calculation.
 		 */
 		if (is_gen12_ccs_cc_plane(&fb->base, i)) {
-			if (IS_ALIGNED(fb->base.offsets[i], PAGE_SIZE))
+			if (IS_ALIGNED(fb->base.offsets[i], 64))
 				continue;
 			else
 				return -EINVAL;
-- 
2.45.2


