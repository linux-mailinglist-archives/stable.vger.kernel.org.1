Return-Path: <stable+bounces-111126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7407EA21D3F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C23A6557
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034E184E;
	Wed, 29 Jan 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwqZcDQI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DD10F1
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154419; cv=none; b=qQfSrsMlUMqnLf8kQiT3l9mD5fhEH6QhlAmcl2Gsmm1rWy/uoVIEP3S5pUvmUvWM/aYGKG7avFsE6ywnffJAM0tSC6piUwm8PGA7G5J5nlBPnkfwIE8iQDQeBGGoW98PfguUCKBvdZgGe0VDe5PtS7owEIBZIkDQWRCkAxUUDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154419; c=relaxed/simple;
	bh=B2CrWdcsOicH9+yP6JOFhLTScavsFkbHwpJkajJlaJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPeAaaUDRWeFTRQYsLNr0wvNF0xZZIBta+9lnkQ4b/t4snREp139WzwD+F1lwIU5XWrKDHUxCHKYuNaLWgRdJMjPpjdylSVCeAt2YrAFM4930NAVbd99i0MH3J7jsH/FI3YD1qpbDDBAP8NcKJLlWEVUSmU10xUEzbynj5RTjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwqZcDQI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738154418; x=1769690418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2CrWdcsOicH9+yP6JOFhLTScavsFkbHwpJkajJlaJM=;
  b=cwqZcDQI9gR7C8CXeNKU5y9hmIg/TjzD52uwOj7sLrrN7MERd3FY2CVQ
   oJ87oqtVnJu9SrTlNMSIddxhedTKH2Tg/cbHuMOKRt5o/l66dqatiRI4Z
   0MpoXRnz9/E9B/bn4HbFgoKE4Q5ltwIiOvT2l/Mx3yDac5unYdSgE7vRF
   ERkt0jzj78zkrDmapVtepz4Pi5z20Zjdq2JRK1izSL2YY6RtyaW7wqoo1
   TiBycyVfHjNGYtLbVvN+XDjT1qMDWx2z1frJGBkLNq1f40gPmmpAUbwvv
   bMTDOVP69mYGEwMEL1cqNl3ogfdGaKDmsTHBufXUZRDNIfgpqLGfnHvjD
   g==;
X-CSE-ConnectionGUID: EkkcC5JNRES9XMya1M3R7w==
X-CSE-MsgGUID: VWZxpcdERH6cb7wjHt3P9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49647267"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="49647267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:17 -0800
X-CSE-ConnectionGUID: RxrTt+IvSJ2xz4kjOzRMsg==
X-CSE-MsgGUID: g0R02cOsRemid+OBtV39Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113030872"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:15 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	maciej.falkowski@linux.intel.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get() fails
Date: Wed, 29 Jan 2025 13:40:08 +0100
Message-ID: <20250129124009.1039982-3-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_resume_and_get() sets dev->power.runtime_error that causes
all subsequent pm_runtime_get_sync() calls to fail.
Clear the runtime_error using pm_runtime_set_suspended(), so the driver
doesn't have to be reloaded to recover when the NPU fails to boot during
runtime resume.

Fixes: 7d4b4c74432d ("accel/ivpu: Remove suspend_reschedule_counter")
Cc: <stable@vger.kernel.org> # v6.11+
Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 949f4233946c6..c3774d2221326 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -309,7 +309,10 @@ int ivpu_rpm_get(struct ivpu_device *vdev)
 	int ret;
 
 	ret = pm_runtime_resume_and_get(vdev->drm.dev);
-	drm_WARN_ON(&vdev->drm, ret < 0);
+	if (ret < 0) {
+		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
+		pm_runtime_set_suspended(vdev->drm.dev);
+	}
 
 	return ret;
 }
-- 
2.45.1


