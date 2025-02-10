Return-Path: <stable+bounces-114631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD85A2F098
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10903A83AC
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0C25291A;
	Mon, 10 Feb 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/jRly18"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9E222575
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199601; cv=none; b=HhPi+Kot+XwMoiggZzA/Czi7K3sMsZa0NLLCGBnSSe+RExLqJG5Qy/8WIksBuY6X3gN4ZRR/2nq79VniroSkKnDel9q/9Esv7fog/0NpOxjOwLdqj6i0X1tVgpADcZRgMhmmjEx6B9P04Iof4USsDLoFQQ7PW+8UjIKbipOYPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199601; c=relaxed/simple;
	bh=jYv6SXJtsUEv3IN+0aNTDdcD3HCKgJNZLjwz6/qYU2U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mrWlYzXOM38dhDywkh1VZvcTEGe6rOmQRy+51wCRJHbnbqg1oDRVV89ALqTZRYHTrbt7YWYMztxbUc2wJ5Q2WllXK23aXgTjZHyQ7HOKvdAJewu/ENs3fuXqGsvlq+CT6JnMUwKA3FIV7MQyQl8ANmQrCwLo/S6SosC1U8lc3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/jRly18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A777C4CED1;
	Mon, 10 Feb 2025 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199600;
	bh=jYv6SXJtsUEv3IN+0aNTDdcD3HCKgJNZLjwz6/qYU2U=;
	h=Subject:To:Cc:From:Date:From;
	b=e/jRly18yFz7+wNWx0/bbazxZ9WiXGFpYjIJ1fbCTGdyLbYeOjgcyc7xVzepUpuD8
	 irJgU8JrYmMyQFgHRges3dbOQHPvJ/GU/aPQEkOwoDMdMsoy9h934DNlQqAljlU/wy
	 DYOSYbbxYtllC3ThZqc5MNMVpdSGmfmjZQvzFvaE=
Subject: FAILED: patch "[PATCH] accel/ivpu: Fix error handling in recovery/reset" failed to apply to 6.12-stable tree
To: jacek.lawrynowicz@linux.intel.com,maciej.falkowski@linux.intel.com,quic_jhugo@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:59:57 +0100
Message-ID: <2025021056-earlobe-epidural-b92d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 41a2d8286c905614f29007f1bc8e652d54654b82
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021056-earlobe-epidural-b92d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41a2d8286c905614f29007f1bc8e652d54654b82 Mon Sep 17 00:00:00 2001
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Date: Wed, 29 Jan 2025 13:40:09 +0100
Subject: [PATCH] accel/ivpu: Fix error handling in recovery/reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Disable runtime PM for the duration of reset/recovery so it is possible
to set the correct runtime PM state depending on the outcome of the
`ivpu_resume()`. Don’t suspend or reset the HW if the NPU is suspended
when the reset/recovery is requested. Also, move common reset/recovery
code to separate functions for better code readability.

Fixes: 27d19268cf39 ("accel/ivpu: Improve recovery and reset support")
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250129124009.1039982-4-jacek.lawrynowicz@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index c3774d222132..8b2b050cc41a 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -115,41 +115,57 @@ static int ivpu_resume(struct ivpu_device *vdev)
 	return ret;
 }
 
-static void ivpu_pm_recovery_work(struct work_struct *work)
+static void ivpu_pm_reset_begin(struct ivpu_device *vdev)
 {
-	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
-	struct ivpu_device *vdev = pm->vdev;
-	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
-	int ret;
-
-	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
-
-	ret = pm_runtime_resume_and_get(vdev->drm.dev);
-	if (ret)
-		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
-
-	ivpu_jsm_state_dump(vdev);
-	ivpu_dev_coredump(vdev);
+	pm_runtime_disable(vdev->drm.dev);
 
 	atomic_inc(&vdev->pm->reset_counter);
 	atomic_set(&vdev->pm->reset_pending, 1);
 	down_write(&vdev->pm->reset_lock);
+}
+
+static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
+{
+	int ret;
 
-	ivpu_suspend(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_ms_cleanup_all(vdev);
 
 	ret = ivpu_resume(vdev);
-	if (ret)
+	if (ret) {
 		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
+		pm_runtime_set_suspended(vdev->drm.dev);
+	} else {
+		pm_runtime_set_active(vdev->drm.dev);
+	}
 
 	up_write(&vdev->pm->reset_lock);
 	atomic_set(&vdev->pm->reset_pending, 0);
 
-	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	pm_runtime_enable(vdev->drm.dev);
+}
+
+static void ivpu_pm_recovery_work(struct work_struct *work)
+{
+	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
+	struct ivpu_device *vdev = pm->vdev;
+	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
+
+	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
+
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_jsm_state_dump(vdev);
+		ivpu_dev_coredump(vdev);
+		ivpu_suspend(vdev);
+	}
+
+	ivpu_pm_reset_complete(vdev);
+
+	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 }
 
 void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
@@ -328,16 +344,13 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
 
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
-	atomic_inc(&vdev->pm->reset_counter);
-	atomic_set(&vdev->pm->reset_pending, 1);
 
-	pm_runtime_get_sync(vdev->drm.dev);
-	down_write(&vdev->pm->reset_lock);
-	ivpu_prepare_for_reset(vdev);
-	ivpu_hw_reset(vdev);
-	ivpu_pm_prepare_cold_boot(vdev);
-	ivpu_jobs_abort_all(vdev);
-	ivpu_ms_cleanup_all(vdev);
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_prepare_for_reset(vdev);
+		ivpu_hw_reset(vdev);
+	}
 
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");
 }
@@ -345,18 +358,12 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 void ivpu_pm_reset_done_cb(struct pci_dev *pdev)
 {
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
-	int ret;
 
 	ivpu_dbg(vdev, PM, "Post-reset..\n");
-	ret = ivpu_resume(vdev);
-	if (ret)
-		ivpu_err(vdev, "Failed to set RESUME state: %d\n", ret);
-	up_write(&vdev->pm->reset_lock);
-	atomic_set(&vdev->pm->reset_pending, 0);
-	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 
-	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	ivpu_pm_reset_complete(vdev);
+
+	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 }
 
 void ivpu_pm_init(struct ivpu_device *vdev)


