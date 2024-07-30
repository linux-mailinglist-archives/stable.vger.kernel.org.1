Return-Path: <stable+bounces-62698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63550940D68
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C271C2446A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BC194C71;
	Tue, 30 Jul 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FH8kY6F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB2194AF2
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331546; cv=none; b=TWxVcrmX6eLosaWk8JiP2YZXJSJLkESmyBECGOD/68f+N+SXSoHya+2wbf8L28s0Or8arMLc/CjdixQrWCFk/zaX3ucztMtCrkGbtDxZJD+nTR75aIYa89A3sw9mLcbk7i9KcTlYOR0/U5o3XEymKxM1g373ERkP3rLUCe5SZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331546; c=relaxed/simple;
	bh=UdCDn3l/Clx0l6OVr+CUzNsv9EUXMQOehixpwYPT258=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oKkVOQ95dJ8K7l3Ypg5UoE3a6nwXISqzwpzsuyDcYCe7ehSSD5DUXoZiFg4WL+Gsc67izvvLfbh6hzOE/NSB6TAJ7cNOXLIubwN5dvEGuUGDDK912KD30ubq1ao0290iLndPsunB/csVC7Mtiwq+39nQHTF6xG8DA/jaoBG1kDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FH8kY6F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A719C4AF0C;
	Tue, 30 Jul 2024 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331546;
	bh=UdCDn3l/Clx0l6OVr+CUzNsv9EUXMQOehixpwYPT258=;
	h=Subject:To:Cc:From:Date:From;
	b=FH8kY6F7vr5YE7IYQJrbIPOY67IBrnL/Kz285w0JfpwETfSLFo5hBEF1fiG6ceL3y
	 VukTYaMyJ8EYllK0x90/+isLNZt0kqAwSWs9MQA01ppRUdQmNg/km+SvmX/0/+LLZ3
	 jTAMpQ6R7yNWmikZLJSTTo7/jstyLKtaNwACxC4g=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Unable to act on RSCN for port online" failed to apply to 5.10-stable tree
To: qutran@marvell.com,himanshu.madhani@oracle.com,lkp@intel.com,martin.petersen@oracle.com,njavali@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:25:34 +0200
Message-ID: <2024073034-gradation-sandlot-2343@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c3d98b12eef8db436e32f1a8c5478be57dc15621
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073034-gradation-sandlot-2343@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c3d98b12eef8 ("scsi: qla2xxx: Unable to act on RSCN for port online")
1d201c81d4cc ("scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called")
a60447e7d451 ("scsi: qla2xxx: Suppress a kernel complaint in qla_create_qpair()")
91f6f5fbe87b ("scsi: qla2xxx: edif: Reduce connection thrash")
bb2ca6b3f09a ("scsi: qla2xxx: Relogin during fabric disturbance")
7a8ff7d9854a ("scsi: qla2xxx: Fix NVMe session down detection")
4de067e5df12 ("scsi: qla2xxx: edif: Add N2N support for EDIF")
d07b75ba9649 ("scsi: qla2xxx: edif: Fix EDIF enable flag")
225479296c4f ("scsi: qla2xxx: edif: Reject AUTH ELS on session down")
4a0a542fe5e4 ("scsi: qla2xxx: Changes to support kdump kernel for NVMe BFS")
44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
44d018577f17 ("scsi: qla2xxx: edif: Add encryption to I/O path")
7a09e8d92c6d ("scsi: qla2xxx: edif: Add doorbell notification for app")
9efea843a906 ("scsi: qla2xxx: edif: Add detection of secure device")
8a4bb2c1dd62 ("scsi: qla2xxx: edif: Add authentication pass + fail bsgs")
dd30706e73b7 ("scsi: qla2xxx: edif: Add key update")
fac2807946c1 ("scsi: qla2xxx: edif: Add extraction of auth_els from the wire")
84318a9f01ce ("scsi: qla2xxx: edif: Add send, receive, and accept for auth_els")
7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs")
7ebb336e45ef ("scsi: qla2xxx: edif: Add start + stop bsgs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3d98b12eef8db436e32f1a8c5478be57dc15621 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Wed, 10 Jul 2024 22:40:47 +0530
Subject: [PATCH] scsi: qla2xxx: Unable to act on RSCN for port online

The device does not come online when the target port is online. There were
multiple RSCNs indicating multiple devices were affected. Driver is in the
process of finishing a fabric scan. A new RSCN (device up) arrived at the
tail end of the last fabric scan. Driver mistakenly thinks the new RSCN is
being taken care of by the previous fabric scan, where this notification is
cleared and not acted on. The laser needs to be blinked again to get the
device to show up.

To prevent driver from accidentally clearing the RSCN notification, each
RSCN is given a generation value.  A fabric scan will scan for that
generation(s).  Any new RSCN arrive after the scan start will have a new
generation value. This will trigger another scan to get latest data. The
RSCN notification flag will be cleared when the scan is associate to that
generation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406210538.w875N70K-lkp@intel.com/
Fixes: bb2ca6b3f09a ("scsi: qla2xxx: Relogin during fabric disturbance")
Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-2-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 2f49baf131e2..ba134f6237b8 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3312,6 +3312,8 @@ struct fab_scan_rp {
 struct fab_scan {
 	struct fab_scan_rp *l;
 	u32 size;
+	u32 rscn_gen_start;
+	u32 rscn_gen_end;
 	u16 scan_retry;
 #define MAX_SCAN_RETRIES 5
 	enum scan_flags_t scan_flags;
@@ -5030,6 +5032,7 @@ typedef struct scsi_qla_host {
 
 	/* Counter to detect races between ELS and RSCN events */
 	atomic_t		generation_tick;
+	atomic_t		rscn_gen;
 	/* Time when global fcport update has been scheduled */
 	int			total_fcport_update_gen;
 	/* List of pending LOGOs, protected by tgt_mutex */
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 1cf9d200d563..e801cd9e2345 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3168,6 +3168,29 @@ static int qla2x00_is_a_vp(scsi_qla_host_t *vha, u64 wwn)
 	return rc;
 }
 
+static bool qla_ok_to_clear_rscn(scsi_qla_host_t *vha, fc_port_t *fcport)
+{
+	u32 rscn_gen;
+
+	rscn_gen = atomic_read(&vha->rscn_gen);
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2017,
+	    "%s %d %8phC rscn_gen %x start %x end %x current %x\n",
+	    __func__, __LINE__, fcport->port_name, fcport->rscn_gen,
+	    vha->scan.rscn_gen_start, vha->scan.rscn_gen_end, rscn_gen);
+
+	if (val_is_in_range(fcport->rscn_gen, vha->scan.rscn_gen_start,
+	    vha->scan.rscn_gen_end))
+		/* rscn came in before fabric scan */
+		return true;
+
+	if (val_is_in_range(fcport->rscn_gen, vha->scan.rscn_gen_end, rscn_gen))
+		/* rscn came in after fabric scan */
+		return false;
+
+	/* rare: fcport's scan_needed + rscn_gen must be stale */
+	return true;
+}
+
 void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 {
 	fc_port_t *fcport;
@@ -3281,10 +3304,10 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 				   (fcport->scan_needed &&
 				    fcport->port_type != FCT_INITIATOR &&
 				    fcport->port_type != FCT_NVME_INITIATOR)) {
+				fcport->scan_needed = 0;
 				qlt_schedule_sess_for_deletion(fcport);
 			}
 			fcport->d_id.b24 = rp->id.b24;
-			fcport->scan_needed = 0;
 			break;
 		}
 
@@ -3325,7 +3348,9 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 				do_delete = true;
 			}
 
-			fcport->scan_needed = 0;
+			if (qla_ok_to_clear_rscn(vha, fcport))
+				fcport->scan_needed = 0;
+
 			if (((qla_dual_mode_enabled(vha) ||
 			      qla_ini_mode_enabled(vha)) &&
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
@@ -3355,7 +3380,9 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 					    fcport->port_name, fcport->loop_id,
 					    fcport->login_retry);
 				}
-				fcport->scan_needed = 0;
+
+				if (qla_ok_to_clear_rscn(vha, fcport))
+					fcport->scan_needed = 0;
 				qla24xx_fcport_handle_login(vha, fcport);
 			}
 		}
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8377624d76c9..d88f05ea55cb 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1842,10 +1842,18 @@ int qla24xx_post_newsess_work(struct scsi_qla_host *vha, port_id_t *id,
 	return qla2x00_post_work(vha, e);
 }
 
+static void qla_rscn_gen_tick(scsi_qla_host_t *vha, u32 *ret_rscn_gen)
+{
+	*ret_rscn_gen = atomic_inc_return(&vha->rscn_gen);
+	/* memory barrier */
+	wmb();
+}
+
 void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	fc_port_t *fcport;
 	unsigned long flags;
+	u32 rscn_gen;
 
 	switch (ea->id.b.rsvd_1) {
 	case RSCN_PORT_ADDR:
@@ -1875,15 +1883,16 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 					 * Otherwise we're already in the middle of a relogin
 					 */
 					fcport->scan_needed = 1;
-					fcport->rscn_gen++;
+					qla_rscn_gen_tick(vha, &fcport->rscn_gen);
 				}
 			} else {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				qla_rscn_gen_tick(vha, &fcport->rscn_gen);
 			}
 		}
 		break;
 	case RSCN_AREA_ADDR:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
@@ -1891,11 +1900,12 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 
 			if ((ea->id.b24 & 0xffff00) == (fcport->d_id.b24 & 0xffff00)) {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				fcport->rscn_gen = rscn_gen;
 			}
 		}
 		break;
 	case RSCN_DOM_ADDR:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
@@ -1903,19 +1913,20 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 
 			if ((ea->id.b24 & 0xff0000) == (fcport->d_id.b24 & 0xff0000)) {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				fcport->rscn_gen = rscn_gen;
 			}
 		}
 		break;
 	case RSCN_FAB_ADDR:
 	default:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
 				continue;
 
 			fcport->scan_needed = 1;
-			fcport->rscn_gen++;
+			fcport->rscn_gen = rscn_gen;
 		}
 		break;
 	}
@@ -1924,6 +1935,7 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 	if (vha->scan.scan_flags == 0) {
 		ql_dbg(ql_dbg_disc, vha, 0xffff, "%s: schedule\n", __func__);
 		vha->scan.scan_flags |= SF_QUEUED;
+		vha->scan.rscn_gen_start = atomic_read(&vha->rscn_gen);
 		schedule_delayed_work(&vha->scan.scan_work, 5);
 	}
 	spin_unlock_irqrestore(&vha->work_lock, flags);
@@ -6393,6 +6405,8 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		qlt_do_generation_tick(vha, &discovery_gen);
 
 		if (USE_ASYNC_SCAN(ha)) {
+			/* start of scan begins here */
+			vha->scan.rscn_gen_end = atomic_read(&vha->rscn_gen);
 			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
 			    NULL);
 			if (rval)
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index a4a56ab0ba74..ef4b3cc1cd77 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -631,3 +631,11 @@ static inline int qla_mapq_alloc_qp_cpu_map(struct qla_hw_data *ha)
 	}
 	return 0;
 }
+
+static inline bool val_is_in_range(u32 val, u32 start, u32 end)
+{
+	if (val >= start && val <= end)
+		return true;
+	else
+		return false;
+}


