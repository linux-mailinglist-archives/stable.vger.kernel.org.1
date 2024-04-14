Return-Path: <stable+bounces-38357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D08A0E2F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3424282EDD
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE98145B3E;
	Thu, 11 Apr 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sksZzMxN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5061448EF;
	Thu, 11 Apr 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830322; cv=none; b=i6BXkUtplvZhivlx5Yt5ReieGlRXQd7/c9/yjxHU2H00EFv00MNSBF0XFhHHbzsUep2/Xnm6XzXMLONE1JsIx3Pg/JFfy7o4U9yjx/yrxTPHJ1n5Hk5wc5aRMBA+dmnD0DGIKE1uecBjJPdnoAkAVHv75NhqlgZTFKiW+5w/faI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830322; c=relaxed/simple;
	bh=zwBNaKkwBuoNrTsOi8Ym99oeh2uJ1YWAo9YY77ynsL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERkneRnhj4w1xbdbOz3rH4Ht34sEZWb2tOBWV6+5GZunw+0a/3XGiOOBVQZnMTJL1QslN85yK9k4G7TYhyzuMmGWjS5UNDm8Wm03ooa767oqtlunBdHPmkEkEq9ioKonYKfE7MA/TfmG+L1wqwRg0pLhMfhSDJbKA0r57VZ25pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sksZzMxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978FBC433C7;
	Thu, 11 Apr 2024 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830322;
	bh=zwBNaKkwBuoNrTsOi8Ym99oeh2uJ1YWAo9YY77ynsL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sksZzMxNsN+OMoZzznnv14P24+HqP23e2w05+1Wbj9CF/CdExeP4g4ZnqQa6dJDIR
	 d3MxGjNC55mwMLfN5y1ixsLuL/6UqMtJzO6myjE2VB9GkD+QP6WayxBrqRmX+dayzd
	 a3u9qCDL/828qCxY88xlDX4/BLOUcctLoO4ZQ0/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 109/143] bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state
Date: Thu, 11 Apr 2024 11:56:17 +0200
Message-ID: <20240411095424.188378237@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

[ Upstream commit bce3f770684cc1d91ff9edab431b71ac991faf29 ]

When processing a SYSERR, if the device does not respond to the MHI_RESET
from the host, the host will be stuck in a difficult to recover state.
The host will remain in MHI_PM_SYS_ERR_PROCESS and not clean up the host
channels.  Clients will not be notified of the SYSERR via the destruction
of their channel devices, which means clients may think that the device is
still up.  Subsequent SYSERR events such as a device fatal error will not
be processed as the state machine cannot transition from PROCESS back to
DETECT.  The only way to recover from this is to unload the mhi module
(wipe the state machine state) or for the mhi controller to initiate
SHUTDOWN.

This issue was discovered by stress testing soc_reset events on AIC100
via the sysfs node.

soc_reset is processed entirely in hardware.  When the register write
hits the endpoint hardware, it causes the soc to reset without firmware
involvement.  In stress testing, there is a rare race where soc_reset N
will cause the soc to reset and PBL to signal SYSERR (fatal error).  If
soc_reset N+1 is triggered before PBL can process the MHI_RESET from the
host, then the soc will reset again, and re-run PBL from the beginning.
This will cause PBL to lose all state.  PBL will be waiting for the host
to respond to the new syserr, but host will be stuck expecting the
previous MHI_RESET to be processed.

Additionally, the AMSS EE firmware (QSM) was hacked to synthetically
reproduce the issue by simulating a FW hang after the QSM issued a
SYSERR.  In this case, soc_reset would not recover the device.

For this failure case, to recover the device, we need a state similar to
PROCESS, but can transition to DETECT.  There is not a viable existing
state to use.  POR has the needed transitions, but assumes the device is
in a good state and could allow the host to attempt to use the device.
Allowing PROCESS to transition to DETECT invites the possibility of
parallel SYSERR processing which could get the host and device out of
sync.

Thus, invent a new state - MHI_PM_SYS_ERR_FAIL

This essentially a holding state.  It allows us to clean up the host
elements that are based on the old state of the device (channels), but
does not allow us to directly advance back to an operational state.  It
does allow the detection and processing of another SYSERR which may
recover the device, or allows the controller to do a clean shutdown.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240112180800.536733-1-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/init.c     |  1 +
 drivers/bus/mhi/host/internal.h |  9 ++++++---
 drivers/bus/mhi/host/pm.c       | 20 +++++++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 65ceac1837f9a..8e5ec1a409b80 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -62,6 +62,7 @@ static const char * const mhi_pm_state_str[] = {
 	[MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
 	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
 	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
+	[MHI_PM_STATE_SYS_ERR_FAIL] = "SYS ERROR Failure",
 	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
 	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal Detect",
 };
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 30ac415a3000f..4b6deea17bcd2 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -88,6 +88,7 @@ enum mhi_pm_state {
 	MHI_PM_STATE_FW_DL_ERR,
 	MHI_PM_STATE_SYS_ERR_DETECT,
 	MHI_PM_STATE_SYS_ERR_PROCESS,
+	MHI_PM_STATE_SYS_ERR_FAIL,
 	MHI_PM_STATE_SHUTDOWN_PROCESS,
 	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
 	MHI_PM_STATE_MAX
@@ -104,14 +105,16 @@ enum mhi_pm_state {
 #define MHI_PM_FW_DL_ERR				BIT(7)
 #define MHI_PM_SYS_ERR_DETECT				BIT(8)
 #define MHI_PM_SYS_ERR_PROCESS				BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS				BIT(10)
+#define MHI_PM_SYS_ERR_FAIL				BIT(10)
+#define MHI_PM_SHUTDOWN_PROCESS				BIT(11)
 /* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(11)
+#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(12)
 
 #define MHI_REG_ACCESS_VALID(pm_state)			((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
 						MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
 						MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-						MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+						MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |  \
+						MHI_PM_FW_DL_ERR)))
 #define MHI_PM_IN_ERROR_STATE(pm_state)			(pm_state >= MHI_PM_FW_DL_ERR)
 #define MHI_PM_IN_FATAL_STATE(pm_state)			(pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
 #define MHI_DB_ACCESS_VALID(mhi_cntrl)			(mhi_cntrl->pm_state & mhi_cntrl->db_access)
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index a2f2feef14768..d0d033ce9984b 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -36,7 +36,10 @@
  *     M0 <--> M0
  *     M0 -> FW_DL_ERR
  *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
- * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS
+ *     SYS_ERR_PROCESS -> SYS_ERR_FAIL
+ *     SYS_ERR_FAIL -> SYS_ERR_DETECT
+ *     SYS_ERR_PROCESS --> POR
  * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
  *     SHUTDOWN_PROCESS -> DISABLE
  * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
@@ -93,7 +96,12 @@ static const struct mhi_pm_transitions dev_state_transitions[] = {
 	},
 	{
 		MHI_PM_SYS_ERR_PROCESS,
-		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_POR | MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_FAIL,
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
 		MHI_PM_LD_ERR_FATAL_DETECT
 	},
 	/* L2 States */
@@ -629,7 +637,13 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 					!in_reset, timeout);
 		if (!ret || in_reset) {
 			dev_err(dev, "Device failed to exit MHI Reset state\n");
-			goto exit_sys_error_transition;
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			cur_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_FAIL);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			/* Shutdown may have occurred, otherwise cleanup now */
+			if (cur_state != MHI_PM_SYS_ERR_FAIL)
+				goto exit_sys_error_transition;
 		}
 
 		/*
-- 
2.43.0




