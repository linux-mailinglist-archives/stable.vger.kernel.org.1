Return-Path: <stable+bounces-87987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94189ADA85
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4161F220B0
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E0167296;
	Thu, 24 Oct 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VX5W1q2Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD861662F4
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741138; cv=none; b=ZTHJobx1GtfC09NElTLd1ff7FeZIMrm9JAC9d6Rr2XrqISjkq1jfNQx4Y7EHfWG1B4zCVfBOteH/afld7iWYVWLc1aQ1XhCPiCcO4eJUXOvt0rrpkRFgtYVHwZP05J9TMN9p7X6mjIoBxk+uJCU/JP9EWQ3RoIOK8+61L/Xk7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741138; c=relaxed/simple;
	bh=NlMLMj7R3okoQvQx+vzUGG8kQUYmNhfEEdZv488T4rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3hxw6wY/tRLs4JdiKlnhypILORJcAImUjimYT8LTBxZzeuXZt4YKl56APdKfkcYAdzn+CReUUNNL8fQ6GK8quE+dcqFo+NoV6dDbB/xWzeALABm/k34LC03kZGERSWEftNms+sqi17rT5azXsQHHeMNWPnsq48cQj2/TJLOuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VX5W1q2Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741136; x=1761277136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlMLMj7R3okoQvQx+vzUGG8kQUYmNhfEEdZv488T4rQ=;
  b=VX5W1q2QbE/vtdxh52SQSpYK5cB7OZZVoEc5ErhhdPF+chDICyeUz6by
   1LCAjrERGLSRDuFydZjEGwJLNH+MlpodidX/C7YfYTPATNMjnZh7FyAfD
   l32ISR32xmCB3+mpjQWmUqchWFJRKBUGa5bSV6LbssvCW8EDRGpoywWU8
   760tkj5f9sxvh3B3LbZOJQQRpJA54FNxjOh2rZJs4fPrzZqL6Ge/RZHxh
   tjgNLt14R8/xh9pPohxwxGQ7LITg1IEta/5x+iwjXOvRT2yjR5bsAnvJp
   fiyZPidv1sznsxw5ziJGvwNurlPkk+ciYiZMEHlBvyocG4ZjOwFEk1w3W
   A==;
X-CSE-ConnectionGUID: io3Hq5zjTXm7oAOXHZMMOw==
X-CSE-MsgGUID: G6jONMmGTiWMisAI4a8Usw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264991"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: 2FX7FdvzRSeAyf1PHIvWoA==
X-CSE-MsgGUID: ZLdwFGGqRD+MFYhZkTwNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384954"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 07/22] drm/i915/dp: Clear VSC SDP during post ddi disable routine
Date: Wed, 23 Oct 2024 20:37:59 -0700
Message-ID: <20241024033815.3538736-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit 3e307d6c28e7bc7d94b5699d0ed7fe07df6db094 upstream.

Clear VSC SDP if intel_dp_set_infoframes is called from post ddi disable
routine i.e with the variable of enable as false. This is to avoid
an infoframes.enable mismatch issue which is caused when pipe is
connected to eDp which has psr then connected to DPMST. In this case
eDp's post ddi disable routine does not clear infoframes.enable VSC
for the given pipe and DPMST does not recompute VSC SDP and write
infoframes.enable which causes a mismatch.

--v2
-Make the comment match the code [Jani]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240724163743.3668407-1-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d5ce883b289dc..999557a5c0f12 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4393,8 +4393,11 @@ void intel_dp_set_infoframes(struct intel_encoder *encoder,
 	if (!enable && HAS_DSC(dev_priv))
 		val &= ~VDIP_ENABLE_PPS;
 
-	/* When PSR is enabled, this routine doesn't disable VSC DIP */
-	if (!crtc_state->has_psr)
+	/*
+	 * This routine disables VSC DIP if the function is called
+	 * to disable SDP or if it does not have PSR
+	 */
+	if (!enable || !crtc_state->has_psr)
 		val &= ~VIDEO_DIP_ENABLE_VSC_HSW;
 
 	intel_de_write(dev_priv, reg, val);
-- 
2.47.0


