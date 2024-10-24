Return-Path: <stable+bounces-87992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0A9ADA8E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A1BB22365
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98014D2B9;
	Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq1bZy2T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6716D4E5
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741142; cv=none; b=JXlUVy8SKexSHeN/p1QfXFp1GBoWsCJDCFB/+vVrw0HiteQlUs10m/ycjPSRvZeHZzLBWsmoV0esrLdzB1p7LzVZOh5qX3VU5FSv/LopMX05uXbHfE3BSr8VpPE4e4tT5Ze7PL9n4z2vBfkH1qok6TAjHCx1XT8jfAbu9vrzeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741142; c=relaxed/simple;
	bh=gVeuXRaZkrCCssdO+bXpb5vm2OjIOVBehZdaA9hfOh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrgaE/2qMVhNP7F+QPcyeVtVzTB4kFJVuLV6787pyqCswoTXSRYOTmm48uYG6xYZNjnFtHg3eKW38x08NKu3WRQV+8oqaN0rNNlFx8162JVSP0eMuoRLuK8W3FYXpQoFPvohOwYMvCQi3jQSdyyXJBEwmPh5N/dIEXUah9e/Kqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq1bZy2T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741140; x=1761277140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVeuXRaZkrCCssdO+bXpb5vm2OjIOVBehZdaA9hfOh4=;
  b=fq1bZy2TmULJmsBNDN0t5T0MWL8kpYWIs7rVxPlqkksnflUOK6elAye7
   XhZrUMWZ7Rxn+4ifnMk9phuZUHe8SeZGn6cWn/2cr3lWKj7ATFeGlq5/8
   kJC14QK++EydTb9I6M44jgIQUaLV05GUhQj2iP+JYOpMhrLjBRWoKfM3e
   WfCwsrgK1RjHuFR++46QfJrLMIzJQ9E5iTAlbu8e89MscGToK4Xj6VKKh
   Lr0xRenTIk92R1hiYWckxRxRKSg1bslg8/Ogmdfa06owBnmfmkMUL6qby
   Jp0kCOIIU4HWm2Uj9JGygS3kCzh9Ea05meTcimL2SjVJlDI5BSsbpXBng
   Q==;
X-CSE-ConnectionGUID: XPYfiB5ZRI2pJ6OBKgNtLA==
X-CSE-MsgGUID: WZ5bGMNxTVyUK0a30gbRQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264997"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: 8mYLqNtsT56a3natNcjQCA==
X-CSE-MsgGUID: KHAp9I3gSvmtT1DQsHRJrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384971"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 12/22] drm/i915/psr: Prevent Panel Replay if CRC calculation is enabled
Date: Wed, 23 Oct 2024 20:38:04 -0700
Message-ID: <20241024033815.3538736-12-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

commit a8efd8ce280996fe29f2564f705e96e18da3fa62 upstream.

Similarly as for PSR2 CRC calculation seems to timeout when Panel Replay is
enabled. Fix this by falling back to PSR if CRC calculation is enabled.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2266
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240819092549.1298233-1-jouni.hogander@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index da242ba19ed95..0876fe53a6f91 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1605,6 +1605,12 @@ _panel_replay_compute_config(struct intel_dp *intel_dp,
 	if (!alpm_config_valid(intel_dp, crtc_state, true))
 		return false;
 
+	if (crtc_state->crc_enabled) {
+		drm_dbg_kms(&i915->drm,
+			    "Panel Replay not enabled because it would inhibit pipe CRC calculation\n");
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.47.0


