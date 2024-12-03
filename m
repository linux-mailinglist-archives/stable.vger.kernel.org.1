Return-Path: <stable+bounces-97556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348B9E24F8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9F016F806
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BC1F75A5;
	Tue,  3 Dec 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bgsKhhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A41EE001;
	Tue,  3 Dec 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240919; cv=none; b=W2iDLangfDorsbC/pFnss3L8v/UZALfeHW/4RRroyvXigtZy6IFxeZFq4s3/Me2FMwa+Ty4z4wvM/+B/fN9eQgYyMnbG5IcBF76dIAVWEIERKDf1rwe7uJ2bwR6s0FP++D8AUC+GpcuM+1d7AeDMHNWDhiK9OwJvMfpKIH2mXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240919; c=relaxed/simple;
	bh=nq5eYT+pc2lhWL785i5fOrRpe0DMkKMtcCsMHy2oW6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNH/+JZGRaKbZtZ3bWfYf20kOp2eDB7JtFL/gO+0QYdq9+Jj6csqOkDJ2XanvQd1vS+WTR1ViSwIxbsd79DR6PG6COZOBoIitiLQL4UMifOkkqh+HH7C/NP7lP5hAxiOiA5XqiGDlqDKsXcX64g+4cfFGAxfcsJIFtgxs27JgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bgsKhhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD5FC4CECF;
	Tue,  3 Dec 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240918;
	bh=nq5eYT+pc2lhWL785i5fOrRpe0DMkKMtcCsMHy2oW6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1bgsKhhVrzsi1CsWbBf44ci4nLeKIUWvqHX8J8eTobJT+zGEUV0w5eZLUtQQQ4akQ
	 ZFSTnaRYGrJjqUaMwmqxxp57k5fvkXn/mM8EksAZ3QFlKRrmUVVyWy/PRRtiEkMZEQ
	 E9qRAicSbIEzS2QMiXTSIDo28LKX6DVsGcv9ezII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 243/826] accel/ivpu: Prevent recovery invocation during probe and resume
Date: Tue,  3 Dec 2024 15:39:30 +0100
Message-ID: <20241203144753.246958974@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Wachowski <karol.wachowski@intel.com>

[ Upstream commit 5eaa497411197c41b0813d61ba3fbd6267049082 ]

Refactor IPC send and receive functions to allow correct
handling of operations that should not trigger a recovery process.

Expose ivpu_send_receive_internal(), which is now utilized by the D0i3
entry, DCT initialization, and HWS initialization functions.
These functions have been modified to return error codes gracefully,
rather than initiating recovery.

The updated functions are invoked within ivpu_probe() and ivpu_resume(),
ensuring that any errors encountered during these stages result in a proper
teardown or shutdown sequence. The previous approach of triggering recovery
within these functions could lead to a race condition, potentially causing
undefined behavior and kernel crashes due to null pointer dereferences.

Fixes: 45e45362e095 ("accel/ivpu: Introduce ivpu_ipc_send_receive_active()")
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-23-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_ipc.c     | 35 +++++++++++--------------------
 drivers/accel/ivpu/ivpu_ipc.h     |  7 +++----
 drivers/accel/ivpu/ivpu_jsm_msg.c | 19 +++++++----------
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 78b32a8232419..29b723039a345 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -291,15 +291,16 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	return ret;
 }
 
-static int
+int
 ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			       enum vpu_ipc_msg_type expected_resp_type,
-			       struct vpu_jsm_msg *resp, u32 channel,
-			       unsigned long timeout_ms)
+			       struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms)
 {
 	struct ivpu_ipc_consumer cons;
 	int ret;
 
+	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
+
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 
 	ret = ivpu_ipc_send(vdev, &cons, req);
@@ -325,19 +326,21 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
 	return ret;
 }
 
-int ivpu_ipc_send_receive_active(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
-				 enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
-				 u32 channel, unsigned long timeout_ms)
+int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
+			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
+			  u32 channel, unsigned long timeout_ms)
 {
 	struct vpu_jsm_msg hb_req = { .type = VPU_JSM_MSG_QUERY_ENGINE_HB };
 	struct vpu_jsm_msg hb_resp;
 	int ret, hb_ret;
 
-	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
 
 	ret = ivpu_ipc_send_receive_internal(vdev, req, expected_resp, resp, channel, timeout_ms);
 	if (ret != -ETIMEDOUT)
-		return ret;
+		goto rpm_put;
 
 	hb_ret = ivpu_ipc_send_receive_internal(vdev, &hb_req, VPU_JSM_MSG_QUERY_ENGINE_HB_DONE,
 						&hb_resp, VPU_IPC_CHAN_ASYNC_CMD,
@@ -345,21 +348,7 @@ int ivpu_ipc_send_receive_active(struct ivpu_device *vdev, struct vpu_jsm_msg *r
 	if (hb_ret == -ETIMEDOUT)
 		ivpu_pm_trigger_recovery(vdev, "IPC timeout");
 
-	return ret;
-}
-
-int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
-			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
-			  u32 channel, unsigned long timeout_ms)
-{
-	int ret;
-
-	ret = ivpu_rpm_get(vdev);
-	if (ret < 0)
-		return ret;
-
-	ret = ivpu_ipc_send_receive_active(vdev, req, expected_resp, resp, channel, timeout_ms);
-
+rpm_put:
 	ivpu_rpm_put(vdev);
 	return ret;
 }
diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
index 4fe38141045ea..fb4de7fb8210e 100644
--- a/drivers/accel/ivpu/ivpu_ipc.h
+++ b/drivers/accel/ivpu/ivpu_ipc.h
@@ -101,10 +101,9 @@ int ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 		     struct ivpu_ipc_hdr *ipc_buf, struct vpu_jsm_msg *jsm_msg,
 		     unsigned long timeout_ms);
-
-int ivpu_ipc_send_receive_active(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
-				 enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
-				 u32 channel, unsigned long timeout_ms);
+int ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
+				   enum vpu_ipc_msg_type expected_resp_type,
+				   struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms);
 int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
 			  u32 channel, unsigned long timeout_ms);
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 46ef16c3c0691..88105963c1b28 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -270,9 +270,8 @@ int ivpu_jsm_pwr_d0i3_enter(struct ivpu_device *vdev)
 
 	req.payload.pwr_d0i3_enter.send_response = 1;
 
-	ret = ivpu_ipc_send_receive_active(vdev, &req, VPU_JSM_MSG_PWR_D0I3_ENTER_DONE,
-					   &resp, VPU_IPC_CHAN_GEN_CMD,
-					   vdev->timeout.d0i3_entry_msg);
+	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_PWR_D0I3_ENTER_DONE, &resp,
+					     VPU_IPC_CHAN_GEN_CMD, vdev->timeout.d0i3_entry_msg);
 	if (ret)
 		return ret;
 
@@ -430,8 +429,8 @@ int ivpu_jsm_hws_setup_priority_bands(struct ivpu_device *vdev)
 
 	req.payload.hws_priority_band_setup.normal_band_percentage = 10;
 
-	ret = ivpu_ipc_send_receive_active(vdev, &req, VPU_JSM_MSG_SET_PRIORITY_BAND_SETUP_RSP,
-					   &resp, VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_SET_PRIORITY_BAND_SETUP_RSP,
+					     &resp, VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to set priority bands: %d\n", ret);
 
@@ -544,9 +543,8 @@ int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us
 	req.payload.pwr_dct_control.dct_active_us = active_us;
 	req.payload.pwr_dct_control.dct_inactive_us = inactive_us;
 
-	return ivpu_ipc_send_receive_active(vdev, &req, VPU_JSM_MSG_DCT_ENABLE_DONE,
-					    &resp, VPU_IPC_CHAN_ASYNC_CMD,
-					    vdev->timeout.jsm);
+	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_DCT_ENABLE_DONE, &resp,
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
 }
 
 int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
@@ -554,7 +552,6 @@ int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
 	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_DCT_DISABLE };
 	struct vpu_jsm_msg resp;
 
-	return ivpu_ipc_send_receive_active(vdev, &req, VPU_JSM_MSG_DCT_DISABLE_DONE,
-					    &resp, VPU_IPC_CHAN_ASYNC_CMD,
-					    vdev->timeout.jsm);
+	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_DCT_DISABLE_DONE, &resp,
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
 }
-- 
2.43.0




