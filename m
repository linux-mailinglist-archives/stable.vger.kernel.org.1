Return-Path: <stable+bounces-126856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0CBA73285
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C474C17A0B0
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91168214237;
	Thu, 27 Mar 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWs42Mky"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A432144B8
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079667; cv=none; b=DfbYbSHMI5k1Datogr2aJ039AKflSahzZjkd4GkBTkDEkwlO+YPCSJ8DTvSh5VSkDuuXVqkyXj1bmto+yWCz/VNrxr6keuWAMhXpVbflIQzlcqocY5tHVXzTWoBHmJxN4+9JdD0MvwIk8NLKKEEK9y+8K5anbHBS4yGWaicn2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079667; c=relaxed/simple;
	bh=dPTgiceUwjafHwdSnWa1VDkHBvutgxCyLTWXMroYQ7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKjb+E465dOayYVwJNLv758iSZ10A66v5/OeQJq8ZHJzBciYTFA5+nM+lz3GjCT75kEoCeISu0Acnt5qUSOvYHWDLKyB8UHd4xRjUSf+OIjS5susf5tHoQC4MBkL+tVB7JxQbHKKAzjL5LB4FafSryDQMI9yAFdDiPBf5Y2zqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWs42Mky; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743079665; x=1774615665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dPTgiceUwjafHwdSnWa1VDkHBvutgxCyLTWXMroYQ7s=;
  b=fWs42MkyT5Mb+Cn5HkDnN3YxZPZGse1KZSb16DsXKKUj6UkqVYgl6UhY
   nH6kNxpsKOT6ZwI7MFaBqcCfwaw2eEI7gFtQz1AyBfEUehH2dk1nBmtHg
   6z1eBVW8EwZjgHSLTzscwbC+uxj6lkeWxBCaWSxIur+FPjnG8Qm/01CgD
   7/uPdNx2y+EXOUagnbJGrcIO2Eac4iXIG9+OBcVDf3I+edGGwKcKOkbor
   IOsXIUnEVD0lcV7N4DG2IvCK/2UNqBn35RoRxUF2hxoeFYDCt2wlLH9Pn
   2GWPofsMQFhZC9WcJ6462w9/vQczwzNJRa8RZIVwrg5VPrS3xa6cQ49L7
   Q==;
X-CSE-ConnectionGUID: 501qX+onTBmzS0jcBv6TBw==
X-CSE-MsgGUID: rWdA0rXkRSidGh/b9yxLCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61938117"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="61938117"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:47:45 -0700
X-CSE-ConnectionGUID: etJtt3kDRQqY2UT27GZXKQ==
X-CSE-MsgGUID: pKlRY0cXSwS1XXbuh4p78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="130324033"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:47:43 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Kees Cook <kees@kernel.org>,
	Nicolas Chauvet <kwizart@gmail.com>,
	Damian Tometzki <damian@riscv-rocks.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: fix unterminated-string-initialization warning
Date: Thu, 27 Mar 2025 14:47:39 +0200
Message-Id: <20250327124739.2609656-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Initializing const char opregion_signature[16] = OPREGION_SIGNATURE
(which is "IntelGraphicsMem") drops the NUL termination of the
string. This is intentional, but the compiler doesn't know this.

Switch to initializing header->signature directly from the string
litaral, with sizeof destination rather than source. We don't treat the
signature as a string other than for initialization; it's really just a
blob of binary data.

Add a static assert for good measure to cross-check the sizes.

Reported-by: Kees Cook <kees@kernel.org>
Closes: https://lore.kernel.org/r/20250310222355.work.417-kees@kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13934
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Damian Tometzki <damian@riscv-rocks.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 509f9ccae3a9..dbad4d853d3a 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
@@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	/* emulated opregion with VBT mailbox only */
 	buf = (u8 *)vgpu_opregion(vgpu)->va;
 	header = (struct opregion_header *)buf;
-	memcpy(header->signature, opregion_signature,
-	       sizeof(opregion_signature));
+
+	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
+	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
+
 	header->size = 0x8;
 	header->opregion_ver = 0x02000000;
 	header->mboxes = MBOX_VBT;
-- 
2.39.5


