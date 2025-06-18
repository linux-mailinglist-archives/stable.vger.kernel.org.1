Return-Path: <stable+bounces-154671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DCADEDB3
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D78E189A364
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9842E8DE7;
	Wed, 18 Jun 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVEHvbNP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3E2BD5AF
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252908; cv=none; b=Q+itNgzT9GEbfvjsasBbWdCtkvsm/+5JNjHpQZAnFntmF5VZZqIBP+aD/HBOEkP74hn3eBOPxtBvIEqWdLKhlsicvuaeh52029GEKEhlyT5EJztIr9u8fQ5j/NLlawa8PxgQ/9t0mB3IxvUcmBpiX5sUeEcdhur1JwiZXhVNl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252908; c=relaxed/simple;
	bh=nU3kkYjX02w+ev8NGYBcO1oHnilazxL10dM0JMOQVVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jowCTvwjEi+wflAGPHDfqqmF7P6sNEAqq63HMBEKYsw7hgql6IpV1LfHJoQy3W+d91lWAXB0L7o7QTFAgzyCtLrrqWsaFeqgfOYgULJf73Btvj2T8BOfx8wN28FUtJKyboJcUC+mYByFk2ymepOncN5Pfo7lYmAC6NMs2FrTvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVEHvbNP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750252907; x=1781788907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nU3kkYjX02w+ev8NGYBcO1oHnilazxL10dM0JMOQVVM=;
  b=YVEHvbNPz5sACxzUmvD7kDz9l0wXsl+wtYoCJCnvU7TypzLayw0vW6Hr
   KLeKLZtb6p9r+VzCmOTSFGjFEdbIe0f9vwEtC5D1fHGo3MwEY1cHJNnO9
   XWot8B4edyMK9LcCYElUerYTDT/lHBD8nZYWqn/mZ4XWtLxLVSoHG+RZh
   GaBgw5ung55d9ILAWeQ/IxwpZmrraqjGaCc4FYSzx+MxlyVrnZ6GfxCpf
   uFjDkrVI3O/SAXJAkyZVzKmmghRTaB89Fkz/9N7ZEBz+OVVcz9e0RMDmW
   iRWKvXPxbB/XV9kFX2Si7tZWHlel+4kRtLXKLGQmKcmvpefQ0Cru0pnWr
   A==;
X-CSE-ConnectionGUID: Zwvyu4xhQSy7qGYXQgVoAw==
X-CSE-MsgGUID: iqfFMqZ9SLOHbI8ZckWESQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56272569"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56272569"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:37 -0700
X-CSE-ConnectionGUID: 1AhCHAVjQd2R7vfWFq5Heg==
X-CSE-MsgGUID: 9can9AKaS/+QNa+VwGOoyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150297010"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	suraj.kandpal@intel.com,
	jani.nikula@linux.intel.com,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 0/2] Fixes in snps-phy HDMI PLL algorithm
Date: Wed, 18 Jun 2025 18:39:49 +0530
Message-ID: <20250618130951.1596587-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes/improvement in snps-phy HDMI PLL algorithm.

Ankit Nautiyal (2):
  drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation by using
    div64_u64
  drm/i915/snps_hdmi_pll: Use clamp() instead of max(min())

 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.45.2


