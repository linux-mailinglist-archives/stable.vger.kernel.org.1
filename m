Return-Path: <stable+bounces-9534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665A8232CD
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5559B2363B
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FB1C28A;
	Wed,  3 Jan 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaJNn/NM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3B1BDEC;
	Wed,  3 Jan 2024 17:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C4CC433C8;
	Wed,  3 Jan 2024 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301912;
	bh=hnh/0Iy34kgyrvAbcO0q7K9oYJtABVCoLYGaI+wAIfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaJNn/NMhkC2XGLacE7HhHs4u/VDfrK43jwJ7Q+E62NX7kfWNUDWArli0Lm9K6mmx
	 d/1Tec4x7ohDXm9T530MPsQH1nTyDNgD/CdPTIAXedWXrh5VWL7iCD68t+vgHRaHsO
	 DIZMsYiSM4krkVVjB3uOdMdaaJ1MMWS3cH75EFmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Block <bblock@linux.ibm.com>,
	Bean Huo <beanhuo@micron.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 66/75] scsi: core: Use a structure member to track the SCSI command submitter
Date: Wed,  3 Jan 2024 17:55:47 +0100
Message-ID: <20240103164853.081685220@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit bf23e619039d360d503b7282d030daf2277a5d47 ]

Conditional statements are faster than indirect calls. Use a structure
member to track the SCSI command submitter such that later patches can call
scsi_done(scmd) instead of scmd->scsi_done(scmd).

The asymmetric behavior that scsi_send_eh_cmnd() sets the submission
context to the SCSI error handler and that it does not restore the
submission context to the SCSI core is retained.

Link: https://lore.kernel.org/r/20211007202923.2174984-2-bvanassche@acm.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 066c5b46b6ea ("scsi: core: Always send batch on reset or error handling command")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_error.c | 17 ++++++-----------
 drivers/scsi/scsi_lib.c   | 10 ++++++++++
 drivers/scsi/scsi_priv.h  |  1 +
 include/scsi/scsi_cmnd.h  |  7 +++++++
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 89189b65e5eb6..93374173b9579 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -50,8 +50,6 @@
 
 #include <asm/unaligned.h>
 
-static void scsi_eh_done(struct scsi_cmnd *scmd);
-
 /*
  * These should *probably* be handled by the host itself.
  * Since it is allowed to sleep, it probably should.
@@ -500,7 +498,8 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 		/* handler does not care. Drop down to default handling */
 	}
 
-	if (scmd->cmnd[0] == TEST_UNIT_READY && scmd->scsi_done != scsi_eh_done)
+	if (scmd->cmnd[0] == TEST_UNIT_READY &&
+	    scmd->submitter != SUBMITTED_BY_SCSI_ERROR_HANDLER)
 		/*
 		 * nasty: for mid-layer issued TURs, we need to return the
 		 * actual sense data without any recovery attempt.  For eh
@@ -768,7 +767,7 @@ static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
  * scsi_eh_done - Completion function for error handling.
  * @scmd:	Cmd that is done.
  */
-static void scsi_eh_done(struct scsi_cmnd *scmd)
+void scsi_eh_done(struct scsi_cmnd *scmd)
 {
 	struct completion *eh_action;
 
@@ -1068,7 +1067,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	shost->eh_action = &done;
 
 	scsi_log_send(scmd);
-	scmd->scsi_done = scsi_eh_done;
+	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -1095,6 +1094,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	if (rtn) {
 		if (timeleft > stall_for) {
 			scsi_eh_restore_cmnd(scmd, &ses);
+
 			timeleft -= stall_for;
 			msleep(jiffies_to_msecs(stall_for));
 			goto retry;
@@ -2322,11 +2322,6 @@ void scsi_report_device_reset(struct Scsi_Host *shost, int channel, int target)
 }
 EXPORT_SYMBOL(scsi_report_device_reset);
 
-static void
-scsi_reset_provider_done_command(struct scsi_cmnd *scmd)
-{
-}
-
 /**
  * scsi_ioctl_reset: explicitly reset a host/bus/target/device
  * @dev:	scsi_device to operate on
@@ -2363,7 +2358,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scmd->request = rq;
 	scmd->cmnd = scsi_req(rq)->cmd;
 
-	scmd->scsi_done		= scsi_reset_provider_done_command;
+	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 78bc50cfdeaed..20c2700e1f639 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1596,6 +1596,15 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
+	switch (cmd->submitter) {
+	case SUBMITTED_BY_BLOCK_LAYER:
+		break;
+	case SUBMITTED_BY_SCSI_ERROR_HANDLER:
+		return scsi_eh_done(cmd);
+	case SUBMITTED_BY_SCSI_RESET_IOCTL:
+		return;
+	}
+
 	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
@@ -1685,6 +1694,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	scsi_set_resid(cmd, 0);
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
+	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
 	cmd->scsi_done = scsi_mq_done;
 
 	blk_mq_start_request(req);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982d..89992d8879acd 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -82,6 +82,7 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 int scsi_eh_get_sense(struct list_head *work_q,
 		      struct list_head *done_q);
 int scsi_noretry_cmd(struct scsi_cmnd *scmd);
+void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 7173b209144b7..2e26eb0d353e8 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -65,6 +65,12 @@ struct scsi_pointer {
 #define SCMD_STATE_COMPLETE	0
 #define SCMD_STATE_INFLIGHT	1
 
+enum scsi_cmnd_submitter {
+	SUBMITTED_BY_BLOCK_LAYER = 0,
+	SUBMITTED_BY_SCSI_ERROR_HANDLER = 1,
+	SUBMITTED_BY_SCSI_RESET_IOCTL = 2,
+} __packed;
+
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
@@ -88,6 +94,7 @@ struct scsi_cmnd {
 	unsigned char prot_op;
 	unsigned char prot_type;
 	unsigned char prot_flags;
+	enum scsi_cmnd_submitter submitter;
 
 	unsigned short cmd_len;
 	enum dma_data_direction sc_data_direction;
-- 
2.43.0




