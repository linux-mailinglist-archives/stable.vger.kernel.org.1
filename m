Return-Path: <stable+bounces-6078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05680D8A1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135C7B21565
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30451C2D;
	Mon, 11 Dec 2023 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5M2gDx5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C55102A;
	Mon, 11 Dec 2023 18:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867B9C433C7;
	Mon, 11 Dec 2023 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320451;
	bh=DUgZjC+AlwRHpSbHLw2BXIV27g4RjOJOVtLwA2c7FfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5M2gDx5MyCpMG491oSI+lUaN1D3l/vSw+q8Zvm04u7Sbx4XZFaNAMRtsto121Dk2
	 SRjAUTPFPnjKrU9ifLKpFH8s8XAeTGkFt3ChNMKAQMbhqnvSTMC1TANnBNF5/V6Slg
	 7TUjSfOnk6bw4FIUCJ7ydOBZaT55UZ5k9B4ai2Vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/194] RDMA/irdma: Add wait for suspend on SQD
Date: Mon, 11 Dec 2023 19:20:56 +0100
Message-ID: <20231211182039.437220049@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit bd6da690c27d75cae432c09162d054b34fa2156f ]

Currently, there is no wait for the QP suspend to complete on a modify
to SQD state. Add a wait, after the modify to SQD state, for the Suspend
Complete AE. While we are at it, update the suspend timeout value in
irdma_prep_tc_change to use IRDMA_EVENT_TIMEOUT_MS too.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20231114170246.238-3-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/hw.c    |  6 +++++-
 drivers/infiniband/hw/irdma/main.c  |  2 +-
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 21 +++++++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.h |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index c07ce85d243f1..027584febb8ca 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -322,7 +322,11 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			break;
 		case IRDMA_AE_QP_SUSPEND_COMPLETE:
 			if (iwqp->iwdev->vsi.tc_change_pending) {
-				atomic_dec(&iwqp->sc_qp.vsi->qp_suspend_reqs);
+				if (!atomic_dec_return(&qp->vsi->qp_suspend_reqs))
+					wake_up(&iwqp->iwdev->suspend_wq);
+			}
+			if (iwqp->suspend_pending) {
+				iwqp->suspend_pending = false;
 				wake_up(&iwqp->iwdev->suspend_wq);
 			}
 			break;
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 514453777e07d..be1030d1adfaf 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -48,7 +48,7 @@ static void irdma_prep_tc_change(struct irdma_device *iwdev)
 	/* Wait for all qp's to suspend */
 	wait_event_timeout(iwdev->suspend_wq,
 			   !atomic_read(&iwdev->vsi.qp_suspend_reqs),
-			   IRDMA_EVENT_TIMEOUT);
+			   msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS));
 	irdma_ws_reset(&iwdev->vsi);
 }
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 9cbe64311f985..6a6b14d8fca45 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -78,7 +78,7 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
 
 #define MAX_DPC_ITERATIONS	128
 
-#define IRDMA_EVENT_TIMEOUT		50000
+#define IRDMA_EVENT_TIMEOUT_MS		5000
 #define IRDMA_VCHNL_EVENT_TIMEOUT	100000
 #define IRDMA_RST_TIMEOUT_HZ		4
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 02015927fd046..447e1bcc82a32 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1098,6 +1098,21 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+static int irdma_wait_for_suspend(struct irdma_qp *iwqp)
+{
+	if (!wait_event_timeout(iwqp->iwdev->suspend_wq,
+				!iwqp->suspend_pending,
+				msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS))) {
+		iwqp->suspend_pending = false;
+		ibdev_warn(&iwqp->iwdev->ibdev,
+			   "modify_qp timed out waiting for suspend. qp_id = %d, last_ae = 0x%x\n",
+			   iwqp->ibqp.qp_num, iwqp->last_aeq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * irdma_modify_qp_roce - modify qp request
  * @ibqp: qp's pointer for modify
@@ -1359,6 +1374,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 			info.next_iwarp_state = IRDMA_QP_STATE_SQD;
 			issue_modify_qp = 1;
+			iwqp->suspend_pending = true;
 			break;
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
@@ -1399,6 +1415,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			ctx_info->rem_endpoint_idx = udp_info->arp_idx;
 			if (irdma_hw_modify_qp(iwdev, iwqp, &info, true))
 				return -EINVAL;
+			if (info.next_iwarp_state == IRDMA_QP_STATE_SQD) {
+				ret = irdma_wait_for_suspend(iwqp);
+				if (ret)
+					return ret;
+			}
 			spin_lock_irqsave(&iwqp->lock, flags);
 			if (iwqp->iwarp_state == info.curr_iwarp_state) {
 				iwqp->iwarp_state = info.next_iwarp_state;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index a536e9fa85ebf..9f9e273bbff3e 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -193,6 +193,7 @@ struct irdma_qp {
 	u8 flush_issued : 1;
 	u8 sig_all : 1;
 	u8 pau_mode : 1;
+	u8 suspend_pending : 1;
 	u8 rsvd : 1;
 	u8 iwarp_state;
 	u16 term_sq_flush_code;
-- 
2.42.0




