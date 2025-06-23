Return-Path: <stable+bounces-156714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF6AE50D1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4521B62E9C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94E22172C;
	Mon, 23 Jun 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKYti3Ly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E81EDA0F;
	Mon, 23 Jun 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714089; cv=none; b=qrwvKl1oEdxW98xfeqbvotserCO4K0fGDwV05bY32/6+xtHEu0r9FOBmc63vq7IBibhkRpkm3QR6L1YeaVDP1EbygmeTXUVt1xhc4+kAJx/LVno4XU20f1bKloFWvhbgPc8V+/X10vWV7VaLY0qC7oWuYWmuq6JuhMBro/Sb4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714089; c=relaxed/simple;
	bh=fwTPkSvxFG+JQ5WBPzVHcH/+k2YEbLRNehxaavToFxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjY5SuNtGXfZPPz8YXI4xRnB1oXgg2T8nJ/GUmw0BpZ8BT06eFOxeaS0Ais3DwhuQXL194uhFbYOy46u8SzcLvlLpGbkoU78t42v2gYH30mxCwqb0Yyo0EW8rTmRCVPH5s0YmiuvM+BqPpVazBILghlRFaSRfyxYqW+icZSKU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKYti3Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B7AC4CEEA;
	Mon, 23 Jun 2025 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714089;
	bh=fwTPkSvxFG+JQ5WBPzVHcH/+k2YEbLRNehxaavToFxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKYti3LyneZSDGPdfIwu6rcBvbkSObpl7PFwN4tXxRXyEucw+SuwZN/9TyuVRnuzY
	 40sc9pLX9ONia0nbIZbrlJyip+OtwU6ju4u58rVoFznk9yqe+bHcbim1U3s2B0y59S
	 TjTzFpf4UlNptZZkQheSCVJvEhV+ONM3CYtvPBnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Troy Hanson <quic_thanson@quicinc.com>
Subject: [PATCH 6.12 080/414] bus: mhi: host: Fix conflict between power_up and SYSERR
Date: Mon, 23 Jun 2025 15:03:37 +0200
Message-ID: <20250623130644.082752934@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Jeff Hugo <quic_jhugo@quicinc.com>

commit 4d92e7c5ccadc79764674ffc2c88d329aabbb7e0 upstream.

When mhi_async_power_up() enables IRQs, it is possible that we could
receive a SYSERR notification from the device if the firmware has crashed
for some reason. Then the SYSERR notification queues a work item that
cannot execute until the pm_mutex is released by mhi_async_power_up().

So the SYSERR work item will be pending. If mhi_async_power_up() detects
the SYSERR, it will handle it. If the device is in PBL, then the PBL state
transition event will be queued, resulting in a work item after the
pending SYSERR work item. Once mhi_async_power_up() releases the pm_mutex,
the SYSERR work item can run. It will blindly attempt to reset the MHI
state machine, which is the recovery action for SYSERR. PBL/SBL are not
interrupt driven and will ignore the MHI Reset unless SYSERR is actively
advertised. This will cause the SYSERR work item to timeout waiting for
reset to be cleared, and will leave the host state in SYSERR processing.
The PBL transition work item will then run, and immediately fail because
SYSERR processing is not a valid state for PBL transition.

This leaves the device uninitialized.

This issue has a fairly unique signature in the kernel log:

	mhi mhi3: Requested to power ON
	Qualcomm Cloud AI 100 0000:36:00.0: Fatal error received from
	device.  Attempting to recover
	mhi mhi3: Power on setup success
	mhi mhi3: Device failed to exit MHI Reset state
	mhi mhi3: Device MHI is not in valid state

We cannot remove the SYSERR handling from mhi_async_power_up() because the
device may be in the SYSERR state, but we missed the notification as the
irq was fired before irqs were enabled. We also can't queue the SYSERR work
item from mhi_async_power_up() if SYSERR is detected because that may
result in a duplicate work item, and cause the same issue since the
duplicate item will blindly issue MHI reset even if SYSERR is no longer
active.

Instead, add a check in the SYSERR work item to make sure that MHI reset is
only issued if the device is in SYSERR state for PBL or SBL EEs.

Fixes: a6e2e3522f29 ("bus: mhi: core: Add support for PM state transitions")
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Troy Hanson <quic_thanson@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250328163526.3365497-1-jeff.hugo@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/pm.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -602,6 +602,7 @@ static void mhi_pm_sys_error_transition(
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_event_ctxt *er_ctxt;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	bool reset_device = false;
 	int ret, i;
 
 	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
@@ -630,8 +631,23 @@ static void mhi_pm_sys_error_transition(
 	/* Wake up threads waiting for state transition */
 	wake_up_all(&mhi_cntrl->state_event);
 
-	/* Trigger MHI RESET so that the device will not access host memory */
 	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		/*
+		 * If the device is in PBL or SBL, it will only respond to
+		 * RESET if the device is in SYSERR state. SYSERR might
+		 * already be cleared at this point.
+		 */
+		enum mhi_state cur_state = mhi_get_mhi_state(mhi_cntrl);
+		enum mhi_ee_type cur_ee = mhi_get_exec_env(mhi_cntrl);
+
+		if (cur_state == MHI_STATE_SYS_ERR)
+			reset_device = true;
+		else if (cur_ee != MHI_EE_PBL && cur_ee != MHI_EE_SBL)
+			reset_device = true;
+	}
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (reset_device) {
 		u32 in_reset = -1;
 		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
 



