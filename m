Return-Path: <stable+bounces-94651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF09D6524
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873801613E6
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66C1DFD8E;
	Fri, 22 Nov 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+wAZ04Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E989185935
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309669; cv=none; b=Vctu2cErGxHGo9I+da7r1Od8dBAJDKgPmRPEYXYe7NoVuEDmSO5bkzSIE2X4ydbcE+w4AfufIF1eza4GR4utcglafMv8mbSMzp1rPNaUWXXRtuIJxvdwLm8l1lhDGZLhlR2o3G8dfhEyv+j8vR2jEMtlr1nBBqU1es+k+Y5kZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309669; c=relaxed/simple;
	bh=fIr3V3tJD6RPLofmUOUEfFy8YAGQ1fFluIGHxHaQn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV8aSTt3r/yj8rpA23RcEykZ8OevidcWCpbsYbBFram6yvBdBuTOGWUsIdZqlcIHQacZVWUdxjesGkvFD1qwsNinEokHWf0lXE1c3ZObMy30fxei6avyJqjl7QCoVFC1lrEkMEchyLT3zCcW6LT+MiI6N4rboIAgFZ3mYuMKbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+wAZ04Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309668; x=1763845668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIr3V3tJD6RPLofmUOUEfFy8YAGQ1fFluIGHxHaQn1k=;
  b=d+wAZ04QotmdlZy25LBVbz+mikRNI9JRfnP7ZYuaqkrK53cxTFk5OrJP
   b85fN7ASQSqcz+R0CSFIvypNAwA5oNJozR5N8EokfnO+8HwPS6kdBSXM+
   4PVu0nppwE00X3SZbNJdj98c+TyUiAiqW9wRi/wLWTXnGlBzVikECLGVN
   B1IE3y2oDS/wrsVYZRRaOSU7ZCeKr1xBQ6EBaAVWZkwoSrtuO5qCt1hsp
   6Wu1pTXl33curvdhOrV3HFFzuZo3sDZBVCilQOHGrJzF8Blsu5IT+C5vt
   HSqU0E+1BxI9igf8ER9BEsCMVewDerSmlAHx9/xCdaygQYpNFHG3lvhQl
   w==;
X-CSE-ConnectionGUID: jec+CJkNSXOvSLrnmNfLfw==
X-CSE-MsgGUID: cvIqnF4lTgq7nJPDzMLj8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878271"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878271"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
X-CSE-ConnectionGUID: EeXQthu7S+mE0N7x4KdI6w==
X-CSE-MsgGUID: KxIgYlTKRtSd0GyE2Eal+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457237"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 15/31] drm/i915/dp: Disable unnecessary HPD polling for eDP
Date: Fri, 22 Nov 2024 13:07:03 -0800
Message-ID: <20241122210719.213373-16-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

commit a31f62f693c87316eea1711ab586f8f5a7d7a0b3 upstream.

A registered eDP connector is considered to be always connected, so it's
unnecessary to poll it for a connect/disconnect event. Polling it
involves AUX accesses toggling the panel power, which in turn can
generate a spurious short HPD pulse and possibly a new poll cycle via
the short HPD handler runtime resuming the device. Avoid this by
disabling the polling for eDP connectors.

This avoids IGT tests timing out while waiting for the device to runtime
suspend, the timeout caused by the above runtime resume->poll->suspend->
resume cycle keeping the device in the resumed state.

Testcase: igt/kms_pm_rpm/unverisal-planes
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241009194358.1321200-3-imre.deak@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 31cec30079509..6ce3d9c4904eb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6842,7 +6842,8 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 	if (!HAS_GMCH(dev_priv) && DISPLAY_VER(dev_priv) < 12)
 		connector->interlace_allowed = true;
 
-	intel_connector->polled = DRM_CONNECTOR_POLL_HPD;
+	if (type != DRM_MODE_CONNECTOR_eDP)
+		intel_connector->polled = DRM_CONNECTOR_POLL_HPD;
 	intel_connector->base.polled = intel_connector->polled;
 
 	intel_connector_attach_encoder(intel_connector, intel_encoder);
-- 
2.47.0


