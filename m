Return-Path: <stable+bounces-6256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B680D9A4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAD3B20E05
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F251C50;
	Mon, 11 Dec 2023 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNqx6bV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB6321B8;
	Mon, 11 Dec 2023 18:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA6C433C8;
	Mon, 11 Dec 2023 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320934;
	bh=x6U9sO3rNP3USDSDb/wGNpurdnb9Qlp0/gBYMVEyHjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNqx6bV1CUrjZCyqRA9nl+PRq183xy+C7pFndw3pNL6/obSJu/mQdfjHItB5eCCOv
	 e71p61920sAC2Nyy8khzZkHbyyZ/BY5rbWwklDn0A3N8+EPdi30xRTCye7wZycJdns
	 rkiM7RLlSjQsozTu36zqgWKwVv0dLBIqLB31YZGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 050/141] RDMA/irdma: Add wait for suspend on SQD
Date: Mon, 11 Dec 2023 19:21:49 +0100
Message-ID: <20231211182028.700748189@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 70dffa9a9f674..2357feddfbb9d 100644
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
index c556a36e76703..232db2c8b6ae1 100644
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
index bd13cc38e5ae1..0e998e0801982 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -79,7 +79,7 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
 
 #define MAX_DPC_ITERATIONS	128
 
-#define IRDMA_EVENT_TIMEOUT		50000
+#define IRDMA_EVENT_TIMEOUT_MS		5000
 #define IRDMA_VCHNL_EVENT_TIMEOUT	100000
 #define IRDMA_RST_TIMEOUT_HZ		4
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1d57194476a7b..1af1df8a734b8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1082,6 +1082,21 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
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
@@ -1330,6 +1345,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 			info.next_iwarp_state = IRDMA_QP_STATE_SQD;
 			issue_modify_qp = 1;
+			iwqp->suspend_pending = true;
 			break;
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
@@ -1370,6 +1386,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
index 5af3c8e9b3941..a934c985dbb4d 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -188,6 +188,7 @@ struct irdma_qp {
 	u8 flush_issued : 1;
 	u8 sig_all : 1;
 	u8 pau_mode : 1;
+	u8 suspend_pending : 1;
 	u8 rsvd : 1;
 	u8 iwarp_state;
 	u16 term_sq_flush_code;
-- 
2.42.0




