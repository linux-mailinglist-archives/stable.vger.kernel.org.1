Return-Path: <stable+bounces-132373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14CA875EE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A1188D1CE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27F18DB20;
	Mon, 14 Apr 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+CJ2OFg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9426AD0
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599273; cv=none; b=syFMrNvc6zF2CT+TvNmU1BSyZBltz8ZN9sq3VP39fDOc3/wEbyCiTrxdqj/MRJVViABGy6dweDNVs7mp5V97CBiXD3OznbMVWrIILRMV+BW9s2Ts3XuZd3vyFB+19h4Bpk7jjoucpcSZk/JRsG6xJLqZQl+NjE0rD3VE9OKYt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599273; c=relaxed/simple;
	bh=6se5R8yepP16bz4Q/O11BPcg5gkYiRCtsD2+pdFa8sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ8s8IBxUSepsSPUok7tyYF4YO48O74qWWkpTNhxiAJBv9a3BJQcTGYhx2RoqtXL2wmTIqKzUyVp905XYsdPMReNSVqZIyv3wHw3ga4oPaRTXfZ6AMagiEIikyqCuvyIUklwDApt/+BaN+5Cy7bThq/T1/ic0G/Q8jnXCUBmyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+CJ2OFg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744599272; x=1776135272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6se5R8yepP16bz4Q/O11BPcg5gkYiRCtsD2+pdFa8sE=;
  b=H+CJ2OFgJ2JEfhPmkgtiIbkIFuUu+pZostjdIfr/LxRXen22xwJkt6IP
   H5Ue+6GOWBGFQGc41up2MDuSG9yXKeHSOEgxkjbqYxRtlOlfq2wDUnxR9
   Kaco37U12i2nW4jAseDrjiQf4DQLTpLAEHQYK8oWr+den6kHDeF7O5Qws
   e0BiUPO3p2dwlWbalFzTzI4gWy/eHmSFReeh/mriDyIql+XKyfFKupouv
   +2BxnUZphCpjgS8KLLqXh3e4TrMisic2fECCrRbHQuVScSGx3ucS5bmGM
   KbWLHSRxff6UwnG22yvBY7Uoi0XGEQoO+B0DMRVsPt9h0mG8V+QB9BOlr
   Q==;
X-CSE-ConnectionGUID: NUE7TwkHRoufncjp/b5VDg==
X-CSE-MsgGUID: zIUwyenYRIm+FhAWZ2FZzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46189564"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46189564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:54:31 -0700
X-CSE-ConnectionGUID: 7cVq++B2TZep6NFJi9Sv2w==
X-CSE-MsgGUID: SLMU6EC7QnCgghyLdv9xvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130016217"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:54:29 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	stable@vger.kernel.org,
	ankit.k.nautiyal@intel.com
Subject: [PATCH 1/2] drm/i915/display: Add macro for checking 3 DSC engines
Date: Mon, 14 Apr 2025 08:12:55 +0530
Message-ID: <20250414024256.2782702-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250414024256.2782702-1-ankit.k.nautiyal@intel.com>
References: <20250414024256.2782702-1-ankit.k.nautiyal@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 DSC engines per pipe is currently supported only for BMG.
Add a macro to check whether a platform supports 3 DSC engines per pipe.

Bspec: 50175
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 368b0d3417c2..1a215791d0ba 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -163,6 +163,7 @@ struct intel_display_platforms {
 #define HAS_DP_MST(__display)		(DISPLAY_INFO(__display)->has_dp_mst)
 #define HAS_DSB(__display)		(DISPLAY_INFO(__display)->has_dsb)
 #define HAS_DSC(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_dsc)
+#define HAS_DSC_3ENGINES(__display)	(DISPLAY_VERx100(display) == 1401 && HAS_DSC(__display))
 #define HAS_DSC_MST(__display)		(DISPLAY_VER(__display) >= 12 && HAS_DSC(__display))
 #define HAS_FBC(__display)		(DISPLAY_RUNTIME_INFO(__display)->fbc_mask != 0)
 #define HAS_FBC_DIRTY_RECT(__display)	(DISPLAY_VER(__display) >= 30)
-- 
2.34.1


