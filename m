Return-Path: <stable+bounces-18307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C103848234
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8C1C241C2
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4B47F7B;
	Sat,  3 Feb 2024 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwyORiRS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB11A701;
	Sat,  3 Feb 2024 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933702; cv=none; b=hxYroTz3wUJUzmbpWSZeYORcbmNKRe0f4Pgs8KBzTa0PUpsKhdBCFgHiWksEhO85QE8V+PVazCCg9zvIqIdIJd+fTtOWeuF2tX71E6Ay4GguLiZvjBvUg5+TDvqKRiX71CaXhopoUVvvUkvct5LtlR+eUAcAGPQeUbuSeGaVetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933702; c=relaxed/simple;
	bh=iBDgpnRoFV/TFHlR3A2bz1EmOznaXGECKJoAiWw9L2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHywDTDV8bYwAwrRP6RHoG14wDxouqfmkR8eOWDFuRSzYlVExhOCX9faOa6oPdIiUZjmSIAfQ45BB/z7NgCt9+VO3AcchNBF8LZm1svc/fmiQ4798xZsTJijg7cO63hmHYNwRf5+RgNA3kPrukJBkAMZCHsNq+u0rgFp+V/0B8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwyORiRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D6FC43394;
	Sat,  3 Feb 2024 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933702;
	bh=iBDgpnRoFV/TFHlR3A2bz1EmOznaXGECKJoAiWw9L2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwyORiRSm4NXaDEVMWXQvb0/On9PYniKr+89EH/mOdLQoDJ+bOA1+FJ9x7uUtli4w
	 3iIGslCH8/Gp/wnLsAYaCrRuvaKqzhaUOl0QMHQvrmJam2JsviJG+yueqX+TCWGZHd
	 i4EelSpiJNeoiHM87DOpSRJHTS9P3tFn+tkLOQBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 303/322] pds_core: Prevent race issues involving the adminq
Date: Fri,  2 Feb 2024 20:06:40 -0800
Message-ID: <20240203035408.845115306@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit 7e82a8745b951b1e794cc780d46f3fbee5e93447 ]

There are multiple paths that can result in using the pdsc's
adminq.

[1] pdsc_adminq_isr and the resulting work from queue_work(),
    i.e. pdsc_work_thread()->pdsc_process_adminq()

[2] pdsc_adminq_post()

When the device goes through reset via PCIe reset and/or
a fw_down/fw_up cycle due to bad PCIe state or bad device
state the adminq is destroyed and recreated.

A NULL pointer dereference can happen if [1] or [2] happens
after the adminq is already destroyed.

In order to fix this, add some further state checks and
implement reference counting for adminq uses. Reference
counting was used because multiple threads can attempt to
access the adminq at the same time via [1] or [2]. Additionally,
multiple clients (i.e. pds-vfio-pci) can be using [2]
at the same time.

The adminq_refcnt is initialized to 1 when the adminq has been
allocated and is ready to use. Users/clients of the adminq
(i.e. [1] and [2]) will increment the refcnt when they are using
the adminq. When the driver goes into a fw_down cycle it will
set the PDSC_S_FW_DEAD bit and then wait for the adminq_refcnt
to hit 1. Setting the PDSC_S_FW_DEAD before waiting will prevent
any further adminq_refcnt increments. Waiting for the
adminq_refcnt to hit 1 allows for any current users of the adminq
to finish before the driver frees the adminq. Once the
adminq_refcnt hits 1 the driver clears the refcnt to signify that
the adminq is deleted and cannot be used. On the fw_up cycle the
driver will once again initialize the adminq_refcnt to 1 allowing
the adminq to be used again.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://lore.kernel.org/r/20240129234035.69802-5-brett.creeley@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 31 +++++++++++++++++-----
 drivers/net/ethernet/amd/pds_core/core.c   | 21 +++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h   |  1 +
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 68be5ea251fc..5edff33d56f3 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -63,6 +63,15 @@ static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 	return nq_work;
 }
 
+static bool pdsc_adminq_inc_if_up(struct pdsc *pdsc)
+{
+	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER) ||
+	    pdsc->state & BIT_ULL(PDSC_S_FW_DEAD))
+		return false;
+
+	return refcount_inc_not_zero(&pdsc->adminq_refcnt);
+}
+
 void pdsc_process_adminq(struct pdsc_qcq *qcq)
 {
 	union pds_core_adminq_comp *comp;
@@ -75,9 +84,9 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	int aq_work = 0;
 	int credits;
 
-	/* Don't process AdminQ when shutting down */
-	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
-		dev_err(pdsc->dev, "%s: called while PDSC_S_STOPPING_DRIVER\n",
+	/* Don't process AdminQ when it's not up */
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_err(pdsc->dev, "%s: called while adminq is unavailable\n",
 			__func__);
 		return;
 	}
@@ -124,6 +133,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
 				      credits,
 				      PDS_CORE_INTR_CRED_REARM);
+	refcount_dec(&pdsc->adminq_refcnt);
 }
 
 void pdsc_work_thread(struct work_struct *work)
@@ -138,9 +148,9 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	struct pdsc *pdsc = data;
 	struct pdsc_qcq *qcq;
 
-	/* Don't process AdminQ when shutting down */
-	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
-		dev_err(pdsc->dev, "%s: called while PDSC_S_STOPPING_DRIVER\n",
+	/* Don't process AdminQ when it's not up */
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_err(pdsc->dev, "%s: called while adminq is unavailable\n",
 			__func__);
 		return IRQ_HANDLED;
 	}
@@ -148,6 +158,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
 	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
+	refcount_dec(&pdsc->adminq_refcnt);
 
 	return IRQ_HANDLED;
 }
@@ -231,6 +242,12 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	int err = 0;
 	int index;
 
+	if (!pdsc_adminq_inc_if_up(pdsc)) {
+		dev_dbg(pdsc->dev, "%s: preventing adminq cmd %u\n",
+			__func__, cmd->opcode);
+		return -ENXIO;
+	}
+
 	wc.qcq = &pdsc->adminqcq;
 	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
 	if (index < 0) {
@@ -286,6 +303,8 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 			queue_work(pdsc->wq, &pdsc->health_work);
 	}
 
+	refcount_dec(&pdsc->adminq_refcnt);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(pdsc_adminq_post);
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index cc5e3d1fe652..e1f554f25329 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -452,6 +452,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	if (init)
 		pdsc_debugfs_add_viftype(pdsc);
 
+	refcount_set(&pdsc->adminq_refcnt, 1);
 	clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
 	return 0;
 
@@ -514,6 +515,24 @@ void pdsc_stop(struct pdsc *pdsc)
 					   PDS_CORE_INTR_MASK_SET);
 }
 
+static void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
+{
+	/* The driver initializes the adminq_refcnt to 1 when the adminq is
+	 * allocated and ready for use. Other users/requesters will increment
+	 * the refcnt while in use. If the refcnt is down to 1 then the adminq
+	 * is not in use and the refcnt can be cleared and adminq freed. Before
+	 * calling this function the driver will set PDSC_S_FW_DEAD, which
+	 * prevent subsequent attempts to use the adminq and increment the
+	 * refcnt to fail. This guarantees that this function will eventually
+	 * exit.
+	 */
+	while (!refcount_dec_if_one(&pdsc->adminq_refcnt)) {
+		dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
+				    __func__);
+		cpu_relax();
+	}
+}
+
 void pdsc_fw_down(struct pdsc *pdsc)
 {
 	union pds_core_notifyq_comp reset_event = {
@@ -529,6 +548,8 @@ void pdsc_fw_down(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	pdsc_adminq_wait_and_dec_once_unused(pdsc);
+
 	/* Notify clients of fw_down */
 	if (pdsc->fw_reporter)
 		devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 860bce1731c7..d6d19f72df00 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -184,6 +184,7 @@ struct pdsc {
 	struct mutex devcmd_lock;	/* lock for dev_cmd operations */
 	struct mutex config_lock;	/* lock for configuration operations */
 	spinlock_t adminq_lock;		/* lock for adminq operations */
+	refcount_t adminq_refcnt;
 	struct pds_core_dev_info_regs __iomem *info_regs;
 	struct pds_core_dev_cmd_regs __iomem *cmd_regs;
 	struct pds_core_intr __iomem *intr_ctrl;
-- 
2.43.0




