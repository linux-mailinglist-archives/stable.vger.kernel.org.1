Return-Path: <stable+bounces-59142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112592EC72
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C0A2821EF
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1815B999;
	Thu, 11 Jul 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY4nY7BZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512E8F72
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714563; cv=none; b=a0wtijgPtyB+AK/JNhJ2HC4LANO5xsN4iTJwlslJQKkThr4plHWSydzijAdPBlkdrgXjXt4bpnV+S3HTw4FXDSTZIR6tWB39AQ1CmC+q7gzTIt8m/XAdiaJ5GbBj+6fQTKzCq1QnHzK7CzbWGenPzhmFzC9DBWzCd88MEVnJVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714563; c=relaxed/simple;
	bh=g+C4Z1uYirgb3hW9Ol5Td2idagm1RdThfrrZAow1pDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RUqdZ0FCLq+WqnoA72KuqrthLPyYgLnTytPKtpNkRFshyt0WUvSeEpkkqCdnVp6gCVvpHKdPZb5pYRnf6z1uRW/KvFtCDKzrGJ7gd4XW4yfcMTWCKwzBM/ZU8VyjCpnZuUWmphi6TglsdQz+Wmq5UYH2WF9O6NDlML3eVXK/AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY4nY7BZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720714562; x=1752250562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+C4Z1uYirgb3hW9Ol5Td2idagm1RdThfrrZAow1pDk=;
  b=XY4nY7BZi+GUeeJxvIXHg3Gc8X5Tb8gsCzxRTegvwrZFIdFITGa5bguv
   DohPi1fGQj6wMvJclbAJK6UvMJbpiZ9UyagSKV/kmnD6pAnjd+nscSc5x
   AsrfGALiCoIdUUcJS6jDArxdwuoaiZVcAOAf1YzNkKKjBmW0t/6qtrIl+
   MjCKOsx/KSzyKVA4xHzLsRKUQNwrcvV6pPlgeHsKN2DRFJINxLPshs8ai
   RpdsVL1iuyCeXxELBGX9AnPlfztyNI0UDqfuo2oQZEB5+1zaPZk7A9CDz
   ca3Voxyo72NoTIg1tnbxPNW0B7ZLYaz2BJSZRiDQLOttoyBbtfYcabitb
   w==;
X-CSE-ConnectionGUID: H3++4P4ETs6Qc18o6KmJzw==
X-CSE-MsgGUID: K+Qf140IQCSHJ7mRKKBj1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17956515"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17956515"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:16:01 -0700
X-CSE-ConnectionGUID: MHtwAUG1Qvaq8hf6jIRZwg==
X-CSE-MsgGUID: EbSsQSZhR2aa4AyQZz9lGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="71811711"
Received: from nitin-super-server.iind.intel.com ([10.145.169.70])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 09:15:59 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: chris.p.wilson@intel.com,
	tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	andi.shyti@intel.com,
	nirmoy.das@intel.com,
	janusz.krzysztofik@linux.intel.com,
	nitin.r.gote@intel.com,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8
Date: Thu, 11 Jul 2024 22:02:08 +0530
Message-Id: <20240711163208.1355736-1-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're seeing a GPU HANG issue on a CHV platform, which was caused by
bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8").

Gen8 platform has only timeslice and doesn't support a preemption mechanism
as engines do not have a preemption timer and doesn't send an irq if the
preemption timeout expires. So, add a fix to not consider preemption
during dequeuing for gen8 platforms.

v2: Simplify can_preempt() function (Tvrtko Ursulin)

v3:
 - Inside need_preempt(), condition of can_preempt() is not required
   as simplified can_preempt() is enough. (Chris Wilson)

Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
Suggested-by: Andi Shyti <andi.shyti@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
CC: <stable@vger.kernel.org> # v5.2+
---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 21829439e686..72090f52fb85 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3315,11 +3315,7 @@ static void remove_from_engine(struct i915_request *rq)
 
 static bool can_preempt(struct intel_engine_cs *engine)
 {
-	if (GRAPHICS_VER(engine->i915) > 8)
-		return true;
-
-	/* GPGPU on bdw requires extra w/a; not implemented */
-	return engine->class != RENDER_CLASS;
+	return GRAPHICS_VER(engine->i915) > 8;
 }
 
 static void kick_execlists(const struct i915_request *rq, int prio)
-- 
2.25.1


