Return-Path: <stable+bounces-159736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0076AF7A43
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62410189875E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DD2EE28F;
	Thu,  3 Jul 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnOJoypG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15C2E7649;
	Thu,  3 Jul 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555178; cv=none; b=aqXYuP7aTyne8NSUefF2BdfyBrxrxlFrmBTA0XAInc1cnXzLtv1kCD7VOfZ/25zUgdmHGUh6vwBc4wtnflQN5LINZhGvwj5SYihn/CmNWQP75I4qyZiZx4Y08NUBqnO7daispkj7P6SKhjf9bqzQ1uJaHABZvu1Q9ZmoDwqM480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555178; c=relaxed/simple;
	bh=iiljEAx9MDaD4XyRmxAs/SRKcBpsVGnMrt4dpuyNvpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8HZlTBabEUsj/Z/PNqSBThWFZzV8Ah25cyU0ZaUbxOXaosA6Jle5fnLv/WWRUX1CS7+2Ehdnjm42kaik55ARvrnCU28EVGc3lHK5NT/MkqevMgBZ1QztJ4AnliUgkhm0rD22ucW4O4/E9+S859T7M+ACgfkb8YeQXTGBBT7214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnOJoypG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF558C4CEE3;
	Thu,  3 Jul 2025 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555178;
	bh=iiljEAx9MDaD4XyRmxAs/SRKcBpsVGnMrt4dpuyNvpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnOJoypGOCbgm8Fi984V1tkVCb8gjtLXiWmucj9tVi80uREt7Wbt8y81sBfIkLh3J
	 HrzmtkLcfhP5tns5kAEH3W4f1lDReijls4ieU/pgVSzpZFuRimwc9ZEHWgV9SRPMbi
	 Eoa4KM4xklVHKehUooL6tbT6/uexVRNzNvqzzdQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arun Easi <aeasi@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.15 200/263] scsi: fnic: Fix crash in fnic_wq_cmpl_handler when FDMI times out
Date: Thu,  3 Jul 2025 16:42:00 +0200
Message-ID: <20250703144012.388831909@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karan Tilak Kumar <kartilak@cisco.com>

commit a35b29bdedb4d2ae3160d4d6684a6f1ecd9ca7c2 upstream.

When both the RHBA and RPA FDMI requests time out, fnic reuses a frame to
send ABTS for each of them. On send completion, this causes an attempt to
free the same frame twice that leads to a crash.

Fix crash by allocating separate frames for RHBA and RPA, and modify ABTS
logic accordingly.

Tested by checking MDS for FDMI information.

Tested by using instrumented driver to:

 - Drop PLOGI response
 - Drop RHBA response
 - Drop RPA response
 - Drop RHBA and RPA response
 - Drop PLOGI response + ABTS response
 - Drop RHBA response + ABTS response
 - Drop RPA response + ABTS response
 - Drop RHBA and RPA response + ABTS response for both of them

Fixes: 09c1e6ab4ab2 ("scsi: fnic: Add and integrate support for FDMI")
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Tested-by: Arun Easi <aeasi@cisco.com>
Co-developed-by: Arun Easi <aeasi@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Cc: stable@vger.kernel.org
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Link: https://lore.kernel.org/r/20250618003431.6314-1-kartilak@cisco.com
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fnic/fdls_disc.c |  113 +++++++++++++++++++++++++++++++-----------
 drivers/scsi/fnic/fnic.h      |    2 
 drivers/scsi/fnic/fnic_fdls.h |    1 
 3 files changed, 87 insertions(+), 29 deletions(-)

--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -763,47 +763,69 @@ static void fdls_send_fabric_abts(struct
 	iport->fabric.timer_pending = 1;
 }
 
-static void fdls_send_fdmi_abts(struct fnic_iport_s *iport)
+static uint8_t *fdls_alloc_init_fdmi_abts_frame(struct fnic_iport_s *iport,
+		uint16_t oxid)
 {
-	uint8_t *frame;
+	struct fc_frame_header *pfdmi_abts;
 	uint8_t d_id[3];
+	uint8_t *frame;
 	struct fnic *fnic = iport->fnic;
-	struct fc_frame_header *pfabric_abts;
-	unsigned long fdmi_tov;
-	uint16_t oxid;
-	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
-			sizeof(struct fc_frame_header);
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
 		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send FDMI ABTS");
-		return;
+		return NULL;
 	}
 
-	pfabric_abts = (struct fc_frame_header *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	pfdmi_abts = (struct fc_frame_header *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
 	fdls_init_fabric_abts_frame(frame, iport);
 
 	hton24(d_id, FC_FID_MGMT_SERV);
-	FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+	FNIC_STD_SET_D_ID(*pfdmi_abts, d_id);
+	FNIC_STD_SET_OX_ID(*pfdmi_abts, oxid);
+
+	return frame;
+}
+
+static void fdls_send_fdmi_abts(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	unsigned long fdmi_tov;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_frame_header);
 
 	if (iport->fabric.fdmi_pending & FDLS_FDMI_PLOGI_PENDING) {
-		oxid = iport->active_oxid_fdmi_plogi;
-		FNIC_STD_SET_OX_ID(*pfabric_abts, oxid);
+		frame = fdls_alloc_init_fdmi_abts_frame(iport,
+						iport->active_oxid_fdmi_plogi);
+		if (frame == NULL)
+			return;
+
 		fnic_send_fcoe_frame(iport, frame, frame_size);
 	} else {
 		if (iport->fabric.fdmi_pending & FDLS_FDMI_REG_HBA_PENDING) {
-			oxid = iport->active_oxid_fdmi_rhba;
-			FNIC_STD_SET_OX_ID(*pfabric_abts, oxid);
+			frame = fdls_alloc_init_fdmi_abts_frame(iport,
+						iport->active_oxid_fdmi_rhba);
+			if (frame == NULL)
+				return;
+
 			fnic_send_fcoe_frame(iport, frame, frame_size);
 		}
 		if (iport->fabric.fdmi_pending & FDLS_FDMI_RPA_PENDING) {
-			oxid = iport->active_oxid_fdmi_rpa;
-			FNIC_STD_SET_OX_ID(*pfabric_abts, oxid);
+			frame = fdls_alloc_init_fdmi_abts_frame(iport,
+						iport->active_oxid_fdmi_rpa);
+			if (frame == NULL) {
+				if (iport->fabric.fdmi_pending & FDLS_FDMI_REG_HBA_PENDING)
+					goto arm_timer;
+				else
+					return;
+			}
+
 			fnic_send_fcoe_frame(iport, frame, frame_size);
 		}
 	}
 
+arm_timer:
 	fdmi_tov = jiffies + msecs_to_jiffies(2 * iport->e_d_tov);
 	mod_timer(&iport->fabric.fdmi_timer, round_jiffies(fdmi_tov));
 	iport->fabric.fdmi_pending |= FDLS_FDMI_ABORT_PENDING;
@@ -2244,6 +2266,21 @@ void fdls_fabric_timer_callback(struct t
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 }
 
+void fdls_fdmi_retry_plogi(struct fnic_iport_s *iport)
+{
+	struct fnic *fnic = iport->fnic;
+
+	iport->fabric.fdmi_pending = 0;
+	/* If max retries not exhausted, start over from fdmi plogi */
+	if (iport->fabric.fdmi_retry < FDLS_FDMI_MAX_RETRY) {
+		iport->fabric.fdmi_retry++;
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+					 "Retry FDMI PLOGI. FDMI retry: %d",
+					 iport->fabric.fdmi_retry);
+		fdls_send_fdmi_plogi(iport);
+	}
+}
+
 void fdls_fdmi_timer_callback(struct timer_list *t)
 {
 	struct fnic_fdls_fabric_s *fabric = from_timer(fabric, t, fdmi_timer);
@@ -2289,14 +2326,7 @@ void fdls_fdmi_timer_callback(struct tim
 	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 
-	iport->fabric.fdmi_pending = 0;
-	/* If max retries not exhaused, start over from fdmi plogi */
-	if (iport->fabric.fdmi_retry < FDLS_FDMI_MAX_RETRY) {
-		iport->fabric.fdmi_retry++;
-		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-					 "retry fdmi timer %d", iport->fabric.fdmi_retry);
-		fdls_send_fdmi_plogi(iport);
-	}
+	fdls_fdmi_retry_plogi(iport);
 	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -3714,11 +3744,32 @@ static void fdls_process_fdmi_abts_rsp(s
 	switch (FNIC_FRAME_TYPE(oxid)) {
 	case FNIC_FRAME_TYPE_FDMI_PLOGI:
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_plogi);
+
+		iport->fabric.fdmi_pending &= ~FDLS_FDMI_PLOGI_PENDING;
+		iport->fabric.fdmi_pending &= ~FDLS_FDMI_ABORT_PENDING;
 		break;
 	case FNIC_FRAME_TYPE_FDMI_RHBA:
+		iport->fabric.fdmi_pending &= ~FDLS_FDMI_REG_HBA_PENDING;
+
+		/* If RPA is still pending, don't turn off ABORT PENDING.
+		 * We count on the timer to detect the ABTS timeout and take
+		 * corrective action.
+		 */
+		if (!(iport->fabric.fdmi_pending & FDLS_FDMI_RPA_PENDING))
+			iport->fabric.fdmi_pending &= ~FDLS_FDMI_ABORT_PENDING;
+
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_rhba);
 		break;
 	case FNIC_FRAME_TYPE_FDMI_RPA:
+		iport->fabric.fdmi_pending &= ~FDLS_FDMI_RPA_PENDING;
+
+		/* If RHBA is still pending, don't turn off ABORT PENDING.
+		 * We count on the timer to detect the ABTS timeout and take
+		 * corrective action.
+		 */
+		if (!(iport->fabric.fdmi_pending & FDLS_FDMI_REG_HBA_PENDING))
+			iport->fabric.fdmi_pending &= ~FDLS_FDMI_ABORT_PENDING;
+
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_rpa);
 		break;
 	default:
@@ -3728,10 +3779,16 @@ static void fdls_process_fdmi_abts_rsp(s
 		break;
 	}
 
-	timer_delete_sync(&iport->fabric.fdmi_timer);
-	iport->fabric.fdmi_pending &= ~FDLS_FDMI_ABORT_PENDING;
-
-	fdls_send_fdmi_plogi(iport);
+	/*
+	 * Only if ABORT PENDING is off, delete the timer, and if no other
+	 * operations are pending, retry FDMI.
+	 * Otherwise, let the timer pop and take the appropriate action.
+	 */
+	if (!(iport->fabric.fdmi_pending & FDLS_FDMI_ABORT_PENDING)) {
+		timer_delete_sync(&iport->fabric.fdmi_timer);
+		if (!iport->fabric.fdmi_pending)
+			fdls_fdmi_retry_plogi(iport);
+	}
 }
 
 static void
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -30,7 +30,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.8.0.0"
+#define DRV_VERSION		"1.8.0.1"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -394,6 +394,7 @@ void fdls_send_tport_abts(struct fnic_ip
 bool fdls_delete_tport(struct fnic_iport_s *iport,
 		       struct fnic_tport_s *tport);
 void fdls_fdmi_timer_callback(struct timer_list *t);
+void fdls_fdmi_retry_plogi(struct fnic_iport_s *iport);
 
 /* fnic_fcs.c */
 void fnic_fdls_init(struct fnic *fnic, int usefip);



