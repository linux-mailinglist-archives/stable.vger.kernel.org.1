Return-Path: <stable+bounces-126040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD192A6F773
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E397A21ED
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA91A317A;
	Tue, 25 Mar 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpoTKfse"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80A1E522
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903229; cv=none; b=r201/CZmMAhMHTubaEE22BY5U6p5woXe9wkTzzPYFyjOJm1pegcr9AIAyHbwKeP3oMKYQJwHq8gyTfcgBFzKBNXgxZ0rvo1/aXJrLWvWBW5adQ9wurqn2X2m3RZ2BtalG1/2orthAdcbOzVZqEZ0adqZieJ0NrM+PtnvoJChieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903229; c=relaxed/simple;
	bh=BE4W5CIEeCUAQLerKm/j9es9LpqKQ7M9tjBCHlvmR3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYQTKg4ZmWAJORyW+Z79+GTz8j0WhpQ/Gbk/fnz21RLFR6LbnP+MR/vxlymwj2uoUF0j2PsZdoqeSIERLyQv9OC+Zm9raNYc1g0h0iS5SQPkdsY1D1RJrV5Ksi2ErsINCoA9UJnyBISLgs/dlWdUK9kGKRrGN1OjugWSPPcvpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpoTKfse; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742903227; x=1774439227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BE4W5CIEeCUAQLerKm/j9es9LpqKQ7M9tjBCHlvmR3w=;
  b=bpoTKfseDf8qNdSZoxT4LcZMdpuokKwlUwGX+shGsJ2mwbDWCIKgwR+Q
   U+ZBtbhhUJfPfmWZCF296T7Kzv6Hb6AeFvf3sH0i5bDlAMdmAqOl8N/p2
   L+hYpgLzdJcuEekk9Fx3C7Jl9q8xLkjjcsADT2InqA40+njnYMq/B+pue
   bKqR9KwTK4ks6Fq+GlS5pYah2WfYQvmuROOxOy1/xO8w65uJGcagKKWrf
   6jN19khmZPeHR58tv+SV2UM6oGiYnx0kMWd+VgBswrQAuSC9FM2c32w1h
   RfRbDuD7QdAyyXqjo6biYJAgw/txfbyZcUTmd12A6AHd/iZieTYh28jPc
   g==;
X-CSE-ConnectionGUID: G2UsGG8DRvasNFKYp4TXcw==
X-CSE-MsgGUID: KPrto70DRnqx1yPKOlTEDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47927682"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="47927682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:47:07 -0700
X-CSE-ConnectionGUID: qVge1cvASqOh9SJpRedJig==
X-CSE-MsgGUID: pNiVBXTXRn+p4XpMn1cDNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124162141"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:47:05 -0700
From: Maciej Falkowski <maciej.falkowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	jacek.lawrynowicz@linux.intel.com,
	lizhi.hou@amd.com,
	stable@vger.kernel.org,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>
Subject: [PATCH 1/2] accel/ivpu: Fix deadlock in ivpu_ms_cleanup()
Date: Tue, 25 Mar 2025 12:43:05 +0100
Message-ID: <20250325114306.3740022-2-maciej.falkowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325114306.3740022-1-maciej.falkowski@linux.intel.com>
References: <20250325114306.3740022-1-maciej.falkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Fix deadlock in ivpu_ms_cleanup() by preventing runtime resume after
file_priv->ms_lock is acquired.

During a failure in runtime resume, a cold boot is executed, which
calls ivpu_ms_cleanup_all(). This function calls ivpu_ms_cleanup()
that acquires file_priv->ms_lock and causes the deadlock.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index ffe7b10f8a76..eb485cf15ad6 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/drm_file.h>
+#include <linux/pm_runtime.h>
 
 #include "ivpu_drv.h"
 #include "ivpu_gem.h"
@@ -281,6 +282,9 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
 void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 {
 	struct ivpu_ms_instance *ms, *tmp;
+	struct ivpu_device *vdev = file_priv->vdev;
+
+	pm_runtime_get_sync(vdev->drm.dev);
 
 	mutex_lock(&file_priv->ms_lock);
 
@@ -293,6 +297,8 @@ void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 		free_instance(file_priv, ms);
 
 	mutex_unlock(&file_priv->ms_lock);
+
+	pm_runtime_put_autosuspend(vdev->drm.dev);
 }
 
 void ivpu_ms_cleanup_all(struct ivpu_device *vdev)
-- 
2.43.0


