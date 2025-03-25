Return-Path: <stable+bounces-126039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A1A6F719
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511E3189066F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD41E522;
	Tue, 25 Mar 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GF2JVEwP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103D1A317A
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903196; cv=none; b=nPhsOxlnaJPk2yKZPqa3RR788qH1wEkGLP8d1RSinHL+5aWbi2ALwEd+5wjEyy42dUJO6r5LFEdMyD2JCuN2UAf+XMKLjdrKrxAzNxCstWtBIujTSFPxjwjveOis2Cizjs+/jRQw83CVNxtm93rtYCqkkgXa4EBJl1eZ8cp7QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903196; c=relaxed/simple;
	bh=1x79yEYreSGkC6yiWobsNWC0aoxRJJN2bDrRks2sCYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icp9Ze/83R8mgFp4n94YHISaCSeDLvkubwb/n4zbKKXfQv3HR/XoTSIs2vK+7xVkqed+8a+Y6uUai+BH3Wy5jLEPW+c49is2a6dyW5m+5weEnA/Xhc9APPpAUUmA3pB8A+jFllDWf25b1w50pu1cJdPbBiHcv6A8oJeUFkEXUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GF2JVEwP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742903194; x=1774439194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1x79yEYreSGkC6yiWobsNWC0aoxRJJN2bDrRks2sCYs=;
  b=GF2JVEwPow2+CPX43TR9zDY/iWx5IqG34w5A+rhFzY4bEB4WxHIexfXi
   QmJtLj1qyigHM8NIrySGiKO1dCBu1vssae+qax5sRjx2UH983rapvTuWT
   UnNTj/OOYFN2czh8GivsJq6fXtUO9b4pgiTZO/7zcVedbmGw5WLabdLbX
   XpM53sxhh9/Sdw+zREAOvrOwkKouqpholAddGS+HXJ5jVXOFWDK73S3aP
   CZqxSndIiWONcllVoVapNKpJgI9W6+wMM4DsVkfOj/A5U1YcDWdN2CPJW
   8C/Uro3cw+4GWyrUW5Usb3KcChAeuE3H/+IcW23sjIyHCBzFPAXwLKNUA
   w==;
X-CSE-ConnectionGUID: 6dSUGOedRwOQMIVofkfC3Q==
X-CSE-MsgGUID: BdasWqjiQ4CP5tutunzw9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="44032634"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="44032634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:46:33 -0700
X-CSE-ConnectionGUID: RhJWMDMJSdGyIUGNHYtE8A==
X-CSE-MsgGUID: RaxQvUIDTTK+1v9j7sYoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124529977"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:46:21 -0700
From: Maciej Falkowski <maciej.falkowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	jacek.lawrynowicz@linux.intel.com,
	lizhi.hou@amd.com,
	stable@vger.kernel.org,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Fix warning in ivpu_ipc_send_receive_internal()
Date: Tue, 25 Mar 2025 12:42:19 +0100
Message-ID: <20250325114219.3739951-1-maciej.falkowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Warn if device is suspended only when runtime PM is enabled.
Runtime PM is disabled during reset/recovery and it is not an error
to use ivpu_ipc_send_receive_internal() in such cases.

Fixes: 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during probe and resume")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ipc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 0e096fd9b95d..39f83225c181 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -302,7 +302,8 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
 	struct ivpu_ipc_consumer cons;
 	int ret;
 
-	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
+	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev) &&
+		    pm_runtime_enabled(vdev->drm.dev));
 
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 
-- 
2.43.0


