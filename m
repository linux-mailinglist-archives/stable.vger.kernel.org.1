Return-Path: <stable+bounces-146034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4EAC04BC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F210A7B10DD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC41B87F2;
	Thu, 22 May 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiLmt0vz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039129A0
	for <stable@vger.kernel.org>; Thu, 22 May 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747896100; cv=none; b=Cv0zJVJ++IgLJkp26HNt8lVjXQLLAZ6u62JmUmY+mwl3OwMKdAuBHLNePmrza7/lMlEONOm591yz6SAsyqAP+gAEia88axFgljGqMu/e/4iJdj681e3hjVKjK1u4o9l0MoS3O0hzzPT3m/Gg7/xzhBfkRzPJviibIzrWANAjD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747896100; c=relaxed/simple;
	bh=6xTzO9hqlUBe4tPUsXaZc24i76m7UYKEKJYzOe+5rOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgDRieLX94piWyjLkUiy9aA2Nbuq54BzH5jSics1o4vlwaz34yAUV8y9Z1aB7MHt9yXbiSEFhD/iE0N0s6IU/ZGj+Tm3SLzhVKPKKOzMpS0FnT8rIyQWywKGZjdtwqY6QATImfSkUhEd3TGTB9hfwkEtspnVxjITB9UzgEsn7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiLmt0vz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747896098; x=1779432098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6xTzO9hqlUBe4tPUsXaZc24i76m7UYKEKJYzOe+5rOU=;
  b=SiLmt0vz2QlBbepMQn72BTZJqcK4eKJokX0LuVE34wfLB4dTdRj9mixx
   Fkkl+XJBumlbmLQQBuXl7sMUgKNt6X6/f4+eCsJD+U170iDrq1lSmt+Zo
   MPQNWNwYxxfruqgIq3U82rXQ3/2JpfgBtJXdvdrv9k7SrCf8gR/JpUcJA
   pGhfRWsrcpa/Ok2Ia6UzxlYh5taO8lGNWKc0qL2We2TLW3up3yZtIuMwd
   BEKU54TzdPhKKgAgN8fmEqh3BlLEaOavBULMr6mBAEcceJrlG7uQL5CUv
   Dbm5cZiMmcTZ1zvXaZuOiSYoYyCacsbBQDBWNe9hu3TvVksaG6EG7CtEV
   A==;
X-CSE-ConnectionGUID: t+ACyUC2SmKxjgAooGTekg==
X-CSE-MsgGUID: ZA6/9s62T2+uJVEUItpMxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60952421"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="60952421"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:41:38 -0700
X-CSE-ConnectionGUID: oHeBkgw8Quukhr69I+M/2A==
X-CSE-MsgGUID: PWWKu6UAR3OmKDS8Ccu6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="141372244"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:41:35 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"
Date: Thu, 22 May 2025 09:41:27 +0300
Message-ID: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.

The IS_DGFX check was put in place because error capture of buffer
objects is expected to be broken on devices with VRAM.

We seem to have already submitted the userspace fix to remove that
flag, so lets just rely on that for DG1.

Cc: stable@vger.kernel.org # v6.0+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 7d44aadcd5a5..02c59808cbe4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
 			continue;
 
 		if (i915_gem_context_is_recoverable(eb->gem_context) &&
-		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
+		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
 			return -EINVAL;
 
 		for_each_batch_create_order(eb, j) {
-- 
2.49.0


