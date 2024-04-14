Return-Path: <stable+bounces-38907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51E8A10F6
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBEF1F2D09B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BB145B05;
	Thu, 11 Apr 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8Xfh2UO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D013D24D;
	Thu, 11 Apr 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831940; cv=none; b=hCG2iyl3NzT2wkyfXeDpfSpYuBEb6FO98+RjA1ps0vGUThQ1VNAtW+A12Sz40obR80hGD1YJWRiPTlR+pcAy3CIwFu3BbulmWtMCUVrPo1FrgWzvpnnVSBruI+blDm0I8MTcmAj8/F0cInLAuYJ8bxP5s6ABAlohOYf16uq1Tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831940; c=relaxed/simple;
	bh=OuX57w3Y+lKwLpDcmrguSkEwb5y2n1MkhAtvoNMrdzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLjkXtME+gF2Wuxh82DpSqJNGS7wH9MrABUQ+TtyIQNXAWLiHepGYTJU+6Aucsj8l031MQXiLSMkHS7F2pR4e5AFCGncY0fh4QyLcC3fiF0UCEKxvRFKVeIw4SoYsI/C1UaJQ0VdOUEHD8jq5i54Aa2+utZJr9u2zLloyZvF5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8Xfh2UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF64C433C7;
	Thu, 11 Apr 2024 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831939;
	bh=OuX57w3Y+lKwLpDcmrguSkEwb5y2n1MkhAtvoNMrdzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8Xfh2UOLJ12FzbElsFvjlgMU3ILhutUn1WkDoSmOo5fk+q8gRLvkanvfkc2IEISE
	 ZX/yX/A2hPxn/JBAoAx5r2KMrAZfwsgJWhCHhPWFa5r/btuy3zfm3c2QJMHBJHzYxZ
	 5eEnkeTATfETYep+IQrG7wiqnC8PSOVcHtxPdPTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 176/294] scsi: qla2xxx: Fix command flush on cable pull
Date: Thu, 11 Apr 2024 11:55:39 +0200
Message-ID: <20240411095440.928131730@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit a27d4d0e7de305def8a5098a614053be208d1aa1 upstream.

System crash due to command failed to flush back to SCSI layer.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 27 PID: 793455 Comm: kworker/u130:6 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-372.9.1.el8.x86_64 #1
 Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 09/03/2021
 Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
 RIP: 0010:__wake_up_common+0x4c/0x190
 Code: 24 10 4d 85 c9 74 0a 41 f6 01 04 0f 85 9d 00 00 00 48 8b 43 08 48 83 c3 08 4c 8d 48 e8 49 8d 41 18 48 39 c3 0f 84 f0 00 00 00 <49> 8b 41 18 89 54 24 08 31 ed 4c 8d 70 e8 45 8b 29 41 f6 c5 04 75
 RSP: 0018:ffff95f3e0cb7cd0 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: ffff8b08d3b26328 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff8b08d3b26320
 RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffffffffffe8
 R10: 0000000000000000 R11: ffff95f3e0cb7a60 R12: ffff95f3e0cb7d20
 R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8b2fdf6c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000002f1e410002 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  __wake_up_common_lock+0x7c/0xc0
  qla_nvme_ls_req+0x355/0x4c0 [qla2xxx]
 qla2xxx [0000:12:00.1]-f084:3: qlt_free_session_done: se_sess 0000000000000000 / sess ffff8ae1407ca000 from port 21:32:00:02:ac:07:ee:b8 loop_id 0x02 s_id 01:02:00 logout 1 keep 0 els_logo 0
 ? __nvme_fc_send_ls_req+0x260/0x380 [nvme_fc]
 qla2xxx [0000:12:00.1]-207d:3: FCPort 21:32:00:02:ac:07:ee:b8 state transitioned from ONLINE to LOST - portid=010200.
  ? nvme_fc_send_ls_req.constprop.42+0x1a/0x45 [nvme_fc]
 qla2xxx [0000:12:00.1]-2109:3: qla2x00_schedule_rport_del 21320002ac07eeb8. rport ffff8ae598122000 roles 1
 ? nvme_fc_connect_ctrl_work.cold.63+0x1e3/0xa7d [nvme_fc]
 qla2xxx [0000:12:00.1]-f084:3: qlt_free_session_done: se_sess 0000000000000000 / sess ffff8ae14801e000 from port 21:32:01:02:ad:f7:ee:b8 loop_id 0x04 s_id 01:02:01 logout 1 keep 0 els_logo 0
  ? __switch_to+0x10c/0x450
 ? process_one_work+0x1a7/0x360
 qla2xxx [0000:12:00.1]-207d:3: FCPort 21:32:01:02:ad:f7:ee:b8 state transitioned from ONLINE to LOST - portid=010201.
  ? worker_thread+0x1ce/0x390
  ? create_worker+0x1a0/0x1a0
 qla2xxx [0000:12:00.1]-2109:3: qla2x00_schedule_rport_del 21320102adf7eeb8. rport ffff8ae3b2312800 roles 70
  ? kthread+0x10a/0x120
 qla2xxx [0000:12:00.1]-2112:3: qla_nvme_unregister_remote_port: unregister remoteport on ffff8ae14801e000 21320102adf7eeb8
  ? set_kthread_struct+0x40/0x40
 qla2xxx [0000:12:00.1]-2110:3: remoteport_delete of ffff8ae14801e000 21320102adf7eeb8 completed.
  ? ret_from_fork+0x1f/0x40
 qla2xxx [0000:12:00.1]-f086:3: qlt_free_session_done: waiting for sess ffff8ae14801e000 logout

The system was under memory stress where driver was not able to allocate an
SRB to carry out error recovery of cable pull.  The failure to flush causes
upper layer to start modifying scsi_cmnd.  When the system frees up some
memory, the subsequent cable pull trigger another command flush. At this
point the driver access a null pointer when attempting to DMA unmap the
SGL.

Add a check to make sure commands are flush back on session tear down to
prevent the null pointer access.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240227164127.36465-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_target.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1038,6 +1038,16 @@ void qlt_free_session_done(struct work_s
 		    "%s: sess %p logout completed\n", __func__, sess);
 	}
 
+	/* check for any straggling io left behind */
+	if (!(sess->flags & FCF_FCP2_DEVICE) &&
+	    qla2x00_eh_wait_for_pending_commands(sess->vha, sess->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x3027,
+		    "IO not return. Resetting.\n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
+
 	if (sess->logo_ack_needed) {
 		sess->logo_ack_needed = 0;
 		qla24xx_async_notify_ack(vha, sess,



