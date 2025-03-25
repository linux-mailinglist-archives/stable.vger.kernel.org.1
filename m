Return-Path: <stable+bounces-126041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A15A6F772
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7A3AD4E3
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90D1D7E42;
	Tue, 25 Mar 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE1WwiUk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BC433A8
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903230; cv=none; b=Mc1D9Q494di0ggsnHJoKLihF02qPMt7lVinZsx774q1HfORWuxIAQLOAtOHYjGFoNx3FKGgJwtVXCR63jtOZ/zrjxK2w/3K2pwTNNyXXf6PtwvLNR4TfKxraTX0x3dpQwyooPxalmVZNWfmX2nyAcOqX7R3qMZa+aw8EFIv1tWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903230; c=relaxed/simple;
	bh=b7bFA/uLKAvdPMG5WhIPWidg2cv+LiaOcHiUyxMcn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtvxPjJNXkL++eoBzk4X1n8xPKKLE6ZdLW8NG8w5j1gx75Jkb9V4G4SK1d6xdNs/eGInn48KGIlV6pGGEAbQrZDvoBN6wi1CVswdtA3x9O8gY/MFfn+6X0+wPhEHxOxGpNBoIrXlc5PceWoSnE5SjOgP3KprghaXbvyjd3t9PmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE1WwiUk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742903229; x=1774439229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7bFA/uLKAvdPMG5WhIPWidg2cv+LiaOcHiUyxMcn2I=;
  b=aE1WwiUkdToFw/AWz+EjS8e9sg2VGM78PP1bUFHzFiG1x7Cxdd6zcd0y
   yPui4IHaVue4s/JBF3cs7Ts2+B5cD2feeJ9NOdycMCOYSNegQzwOo1pS6
   ErBLslvVh6UUuY8Ezu0TcIZA0eo7ikSDSPZ8INEotNZi0eaMCehyKBB8b
   8M8gb6MBDuVYXWC0Qs17+9Xhg62eGgO5BUCh5LIsqde0wCkoEM3+qtkCr
   rE+s7QKiPdgneBsE1Jb079jILS55uD3wGvY31pNs+sJLgv0bCqYlKzjAr
   RG8DdWj8eXtSgP7Q5gXh7rbc3g/QEJlSxJD67sDu9byFv1oxwSq7JkwOB
   g==;
X-CSE-ConnectionGUID: r0aLxrMqTXKV36/yhGQT+g==
X-CSE-MsgGUID: W3Tqr7BGTaufkbs3GlKssQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47927686"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="47927686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:47:09 -0700
X-CSE-ConnectionGUID: aCu11OelSUeCAPeEuRzxog==
X-CSE-MsgGUID: s6nJVX4dR0CVjLlxwtR0uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124162152"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:47:07 -0700
From: Maciej Falkowski <maciej.falkowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	jacek.lawrynowicz@linux.intel.com,
	lizhi.hou@amd.com,
	stable@vger.kernel.org,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>
Subject: [PATCH 2/2] accel/ivpu: Fix PM related deadlocks in MS IOCTLs
Date: Tue, 25 Mar 2025 12:43:06 +0100
Message-ID: <20250325114306.3740022-3-maciej.falkowski@linux.intel.com>
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

Prevent runtime resume/suspend while MS IOCTLs are in progress.
Failed suspend will call ivpu_ms_cleanup() that would try to acquire
file_priv->ms_lock, which is already held by the IOCTLs.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_debugfs.c |  4 ++--
 drivers/accel/ivpu/ivpu_ms.c      | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 0825851656a2..f0dad0c9ce33 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -332,7 +332,7 @@ ivpu_force_recovery_fn(struct file *file, const char __user *user_buf, size_t si
 		return -EINVAL;
 
 	ret = ivpu_rpm_get(vdev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ivpu_pm_trigger_recovery(vdev, "debugfs");
@@ -383,7 +383,7 @@ static int dct_active_set(void *data, u64 active_percent)
 		return -EINVAL;
 
 	ret = ivpu_rpm_get(vdev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (active_percent)
diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index eb485cf15ad6..2a043baf10ca 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -45,6 +45,10 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	    args->sampling_period_ns < MS_MIN_SAMPLE_PERIOD_NS)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	if (get_instance_by_mask(file_priv, args->metric_group_mask)) {
@@ -97,6 +101,8 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	kfree(ms);
 unlock:
 	mutex_unlock(&file_priv->ms_lock);
+
+	ivpu_rpm_put(vdev);
 	return ret;
 }
 
@@ -161,6 +167,10 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
 	if (!args->metric_group_mask)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
@@ -188,6 +198,7 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
 unlock:
 	mutex_unlock(&file_priv->ms_lock);
 
+	ivpu_rpm_put(vdev);
 	return ret;
 }
 
@@ -205,11 +216,17 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 {
 	struct ivpu_file_priv *file_priv = file->driver_priv;
 	struct drm_ivpu_metric_streamer_stop *args = data;
+	struct ivpu_device *vdev = file_priv->vdev;
 	struct ivpu_ms_instance *ms;
+	int ret;
 
 	if (!args->metric_group_mask)
 		return -EINVAL;
 
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&file_priv->ms_lock);
 
 	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
@@ -218,6 +235,7 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 	mutex_unlock(&file_priv->ms_lock);
 
+	ivpu_rpm_put(vdev);
 	return ms ? 0 : -EINVAL;
 }
 
-- 
2.43.0


