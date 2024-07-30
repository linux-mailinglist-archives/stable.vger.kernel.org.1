Return-Path: <stable+bounces-64247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB3941D0C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7520FB29130
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A21A76B7;
	Tue, 30 Jul 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfyty211"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40131A76B4;
	Tue, 30 Jul 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359485; cv=none; b=o61SAUmbjYqPEsfrXSx/CHxUhfakPiG/4qPbThPY9lt7DB6RaE5YSvDE4b0AfqRKtIR53W4zhLKqXgl/o1pdYnNnZccsOxz96B6yqLvLABcGmbNxtZbni8omqt2EgPyqa9sPsECEnoPztM7U8gTJbOxGgkbKtP1zkmDt+ZvRogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359485; c=relaxed/simple;
	bh=uLleGvMyyirLyk4rSCl/A9LlE5GSoBwQXUhRRtMwxEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUxn0hgAWeVAKdSKxJHPzYCQ6BCEqYeEsLdBjLN6L9aspURdfHb7lV9W0uoILKyZgYOy6oZZ9O2aqFC2AFalGH3sg15wa8UK+cAtaQXywQOMmtZKOrVTusz7bKjbMgN5grFnx8XHn1KjwM4pXbnxuNkMCiNebFBt3iDDPlqZVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfyty211; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43984C32782;
	Tue, 30 Jul 2024 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359485;
	bh=uLleGvMyyirLyk4rSCl/A9LlE5GSoBwQXUhRRtMwxEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfyty21189DTyajUUvLw5A8al0+jfz42Jjdb4N8FH0UUVkLI16g+EATB6Qnm2gntI
	 nWMqNwH+a1hK/oXLfjRO5WxkAKGAPisJgR5BFVPjeN22udt26oIvOC34ZSciMC7IUw
	 wdpzGr9VePM26Z87wobJk8woKcFhh4915ohPft5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 460/568] scsi: qla2xxx: Unable to act on RSCN for port online
Date: Tue, 30 Jul 2024 17:49:27 +0200
Message-ID: <20240730151658.001006408@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

From: Quinn Tran <qutran@marvell.com>

commit c3d98b12eef8db436e32f1a8c5478be57dc15621 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_def.h    |    3 +++
 drivers/scsi/qla2xxx/qla_gs.c     |   33 ++++++++++++++++++++++++++++++---
 drivers/scsi/qla2xxx/qla_init.c   |   24 +++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_inline.h |    8 ++++++++
 4 files changed, 60 insertions(+), 8 deletions(-)

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
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3168,6 +3168,29 @@ static int qla2x00_is_a_vp(scsi_qla_host
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
@@ -3281,10 +3304,10 @@ void qla24xx_async_gnnft_done(scsi_qla_h
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
 
@@ -3325,7 +3348,9 @@ login_logout:
 				do_delete = true;
 			}
 
-			fcport->scan_needed = 0;
+			if (qla_ok_to_clear_rscn(vha, fcport))
+				fcport->scan_needed = 0;
+
 			if (((qla_dual_mode_enabled(vha) ||
 			      qla_ini_mode_enabled(vha)) &&
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
@@ -3355,7 +3380,9 @@ login_logout:
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
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1842,10 +1842,18 @@ int qla24xx_post_newsess_work(struct scs
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
@@ -1875,15 +1883,16 @@ void qla2x00_handle_rscn(scsi_qla_host_t
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
@@ -1891,11 +1900,12 @@ void qla2x00_handle_rscn(scsi_qla_host_t
 
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
@@ -1903,19 +1913,20 @@ void qla2x00_handle_rscn(scsi_qla_host_t
 
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
@@ -1924,6 +1935,7 @@ void qla2x00_handle_rscn(scsi_qla_host_t
 	if (vha->scan.scan_flags == 0) {
 		ql_dbg(ql_dbg_disc, vha, 0xffff, "%s: schedule\n", __func__);
 		vha->scan.scan_flags |= SF_QUEUED;
+		vha->scan.rscn_gen_start = atomic_read(&vha->rscn_gen);
 		schedule_delayed_work(&vha->scan.scan_work, 5);
 	}
 	spin_unlock_irqrestore(&vha->work_lock, flags);
@@ -6393,6 +6405,8 @@ qla2x00_configure_fabric(scsi_qla_host_t
 		qlt_do_generation_tick(vha, &discovery_gen);
 
 		if (USE_ASYNC_SCAN(ha)) {
+			/* start of scan begins here */
+			vha->scan.rscn_gen_end = atomic_read(&vha->rscn_gen);
 			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
 			    NULL);
 			if (rval)
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -631,3 +631,11 @@ static inline int qla_mapq_alloc_qp_cpu_
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



