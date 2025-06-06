Return-Path: <stable+bounces-151610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698DAD00B6
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776603B155C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7318286D78;
	Fri,  6 Jun 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvRtlJ2b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CC2798FF
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206768; cv=none; b=IXnG9URfGYnQD8p+SEhislXzd782Z2XDpIyVFzU38ZMOyfiHZpfaqPbFzf7q2b3PmjHvqwI0gdABqnIh/XzM5xLl2MuJ+lAW2ACzEUhdF1DCMoOcrnJgXbXOevwjfhzx0yvKboDQvlru00FOQCYrah96o8S39aaweBxn2bgtNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206768; c=relaxed/simple;
	bh=qXK/Pec3ts9s2S4G47/MrdTjAEaxTbRhoLzSxXSrD+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+akv+5smbbsxOZQrWaGa376wL4yUmlxbh8LPSbcbtjl49NSOVOlWIO/FHDUTyHd4jHD0WGJ1D2ex93T1WTIJVBpDV4QoYknspjeHRPxkiigsVOiv+e+3O3KjvEFm3MSy6bXDZahy3TMPHxm80aVLA3CRvuWhp4Ki5m2cnPkkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvRtlJ2b; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749206765; x=1780742765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXK/Pec3ts9s2S4G47/MrdTjAEaxTbRhoLzSxXSrD+4=;
  b=IvRtlJ2b/fLdTRlzAfFjVt4o0uEOOa00y6LKf5Zd2SiSwpMKAzxuOmj3
   1M5JvpEaG/6y35QdM8rVHQT3EWoIJbTaxo2S7LltMyFLzhNh0B54zBLAQ
   +RTOcUHWhAPfK5V/hr5N+QfuaAelmdTEQ8abweTU/mrbPCIDVeZo1ze1J
   S4GM3NirGfRVyMA5H08v9tpRk5o0X2SEOGKlwhyAlPctvXpb/Tw5XyJfu
   TOySSajjHjsp8P09lt/iu1uNuuoOY+d9CGutkp/ldUmQ4KKN4tZ0jfHFw
   BvEPgevHY7ZJ7caa6mPOgYaOGOv5j9Ua24lmPJMHszKB+Pv3fUN9B3aAd
   A==;
X-CSE-ConnectionGUID: sFRfvPECSNq2LrdGN1c6WQ==
X-CSE-MsgGUID: vmyGJ1NmQV+SLzu/RaOEFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50582342"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="50582342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:46:04 -0700
X-CSE-ConnectionGUID: hLL9ssjDTXSBAK1EpqAlxQ==
X-CSE-MsgGUID: goRUD85cTqmc2z9B7yuzJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="146384867"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.52])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:46:03 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/xe: move DPT l2 flush to a more sensible place
Date: Fri,  6 Jun 2025 11:45:48 +0100
Message-ID: <20250606104546.1996818-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606104546.1996818-3-matthew.auld@intel.com>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only need the flush for DPT host updates here. Normal GGTT updates don't
need special flush.

Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index 461ecdfdb742..b16a6e3ff4b4 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -165,6 +165,9 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 
 	vma->dpt = dpt;
 	vma->node = dpt->ggtt_node[tile0->id];
+
+	/* Ensure DPT writes are flushed */
+	xe_device_l2_flush(xe);
 	return 0;
 }
 
@@ -334,8 +337,6 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 	if (ret)
 		goto err_unpin;
 
-	/* Ensure DPT writes are flushed */
-	xe_device_l2_flush(xe);
 	return vma;
 
 err_unpin:
-- 
2.49.0


