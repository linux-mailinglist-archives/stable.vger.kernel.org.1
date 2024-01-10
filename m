Return-Path: <stable+bounces-9533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456D8232CC
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3011F20C37
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDEF1C284;
	Wed,  3 Jan 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XJDwpEQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926C1BDFE;
	Wed,  3 Jan 2024 17:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F3C433C7;
	Wed,  3 Jan 2024 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301909;
	bh=4ynPFn7fOtT/c0sfM8/JxdveWsK4Am01psw03ofOTaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJDwpEQ6WLeXWb0Y5tBQ6PXLJfi+V/uIyIWZNUfGLuYhaY8W33MXH1eQA08TkKDfm
	 L4WGPQ3oKzkS4QZ21E4KJ2c8bRj0lNcACyNc/SuzumBAMWAtxtEA8qg+VbO8hAOdW4
	 XJd2Tc1HOm9hxAtWmdwjccGPH+TnEO7JGER65Svc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 65/75] scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
Date: Wed,  3 Jan 2024 17:55:46 +0100
Message-ID: <20240103164852.947067658@linuxfoundation.org>
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

[ Upstream commit aa8e25e5006aac52c943c84e9056ab488630ee19 ]

Prepare for removal of the request pointer by using scsi_cmd_to_rq()
instead. Cast away constness where necessary when passing a SCSI command
pointer to scsi_cmd_to_rq(). This patch does not change any functionality.

Link: https://lore.kernel.org/r/20210809230355.8186-3-bvanassche@acm.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 066c5b46b6ea ("scsi: core: Always send batch on reset or error handling command")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi.c         |  2 +-
 drivers/scsi/scsi_error.c   | 15 ++++++++-------
 drivers/scsi/scsi_lib.c     | 28 +++++++++++++++-------------
 drivers/scsi/scsi_logging.c | 18 ++++++++++--------
 include/scsi/scsi_cmnd.h    |  8 +++++---
 include/scsi/scsi_device.h  | 16 +++++++++-------
 6 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d6c25a88cebc9..034f2c8a9e0b5 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -197,7 +197,7 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 				"(result %x)\n", cmd->result));
 
 	good_bytes = scsi_bufflen(cmd);
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		int old_good_bytes = good_bytes;
 		drv = scsi_cmd_to_driver(cmd);
 		if (drv->done)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 0c4bc42b55c20..89189b65e5eb6 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -230,7 +230,7 @@ scsi_abort_command(struct scsi_cmnd *scmd)
  */
 static void scsi_eh_reset(struct scsi_cmnd *scmd)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_reset)
 			sdrv->eh_reset(scmd);
@@ -1167,7 +1167,7 @@ static int scsi_request_sense(struct scsi_cmnd *scmd)
 
 static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_action)
 			rtn = sdrv->eh_action(scmd, rtn);
@@ -1733,22 +1733,24 @@ static void scsi_eh_offline_sdevs(struct list_head *work_q,
  */
 int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 {
+	struct request *req = scsi_cmd_to_rq(scmd);
+
 	switch (host_byte(scmd->result)) {
 	case DID_OK:
 		break;
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT);
+		return req->cmd_flags & REQ_FAILFAST_TRANSPORT;
 	case DID_PARITY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
+		return req->cmd_flags & REQ_FAILFAST_DEV;
 	case DID_ERROR:
 		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
 		    status_byte(scmd->result) == RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DRIVER);
+		return req->cmd_flags & REQ_FAILFAST_DRIVER;
 	}
 
 	if (status_byte(scmd->result) != CHECK_CONDITION)
@@ -1759,8 +1761,7 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	 * assume caller has checked sense and determined
 	 * the check condition was retryable.
 	 */
-	if (scmd->request->cmd_flags & REQ_FAILFAST_DEV ||
-	    blk_rq_is_passthrough(scmd->request))
+	if (req->cmd_flags & REQ_FAILFAST_DEV || blk_rq_is_passthrough(req))
 		return 1;
 
 	return 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 99b90031500b2..78bc50cfdeaed 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -153,13 +153,15 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	if (cmd->request->rq_flags & RQF_DONTPREP) {
-		cmd->request->rq_flags &= ~RQF_DONTPREP;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	if (rq->rq_flags & RQF_DONTPREP) {
+		rq->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(rq, true);
 }
 
 /**
@@ -198,7 +200,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 */
 	cmd->result = 0;
 
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(scsi_cmd_to_rq(cmd), true);
 }
 
 /**
@@ -508,7 +510,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		struct scsi_driver *drv = scsi_cmd_to_driver(cmd);
 
 		if (drv->uninit_command)
@@ -658,7 +660,7 @@ static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	unsigned long wait_for;
 
 	if (cmd->allowed == SCSI_CMD_RETRIES_NO_LIMIT)
@@ -677,7 +679,7 @@ static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	int level = 0;
 	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
 	      ACTION_DELAYED_RETRY} action;
@@ -849,7 +851,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 {
 	bool sense_valid;
 	bool sense_current = true;	/* false implies "deferred sense" */
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	struct scsi_sense_hdr sshdr;
 
 	sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -938,7 +940,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	blk_status_t blk_stat = BLK_STS_OK;
 
 	if (unlikely(result))	/* a nz result may or may not be an error */
@@ -1006,7 +1008,7 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
@@ -1135,7 +1137,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
 	void *buf = cmd->sense_buffer;
 	void *prot = cmd->prot_sdb;
-	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned int flags = cmd->flags & SCMD_PRESERVED_FLAGS;
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
@@ -1594,12 +1596,12 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
-	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
+	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
 }
 
 static void scsi_mq_put_budget(struct request_queue *q)
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 8ea44c6595efa..f0ae55ad09738 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -28,8 +28,9 @@ static void scsi_log_release_buffer(char *bufptr)
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
-	return scmd->request->rq_disk ?
-		scmd->request->rq_disk->disk_name : NULL;
+	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
+
+	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
@@ -91,7 +92,7 @@ void scmd_printk(const char *level, const struct scsi_cmnd *scmd,
 	if (!logbuf)
 		return;
 	off = sdev_format_header(logbuf, logbuf_len, scmd_name(scmd),
-				 scmd->request->tag);
+				 scsi_cmd_to_rq((struct scsi_cmnd *)scmd)->tag);
 	if (off < logbuf_len) {
 		va_start(args, fmt);
 		off += vscnprintf(logbuf + off, logbuf_len - off, fmt, args);
@@ -188,7 +189,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 		return;
 
 	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+				 scmd_name(cmd), scsi_cmd_to_rq(cmd)->tag);
 	if (off >= logbuf_len)
 		goto out_printk;
 	off += scnprintf(logbuf + off, logbuf_len - off, "CDB: ");
@@ -210,7 +211,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 
 			off = sdev_format_header(logbuf, logbuf_len,
 						 scmd_name(cmd),
-						 cmd->request->tag);
+						 scsi_cmd_to_rq(cmd)->tag);
 			if (!WARN_ON(off > logbuf_len - 58)) {
 				off += scnprintf(logbuf + off, logbuf_len - off,
 						 "CDB[%02x]: ", k);
@@ -373,7 +374,8 @@ EXPORT_SYMBOL(__scsi_print_sense);
 /* Normalize and print sense buffer in SCSI command */
 void scsi_print_sense(const struct scsi_cmnd *cmd)
 {
-	scsi_log_print_sense(cmd->device, scmd_name(cmd), cmd->request->tag,
+	scsi_log_print_sense(cmd->device, scmd_name(cmd),
+			     scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag,
 			     cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 }
 EXPORT_SYMBOL(scsi_print_sense);
@@ -392,8 +394,8 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	if (!logbuf)
 		return;
 
-	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+	off = sdev_format_header(logbuf, logbuf_len, scmd_name(cmd),
+				 scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag);
 
 	if (off >= logbuf_len)
 		goto out_printk;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 162a53a39ac0d..7173b209144b7 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -162,7 +162,9 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	return *(struct scsi_driver **)rq->rq_disk->private_data;
 }
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
@@ -226,14 +228,14 @@ static inline int scsi_sg_copy_to_buffer(struct scsi_cmnd *cmd,
 
 static inline sector_t scsi_get_sector(struct scsi_cmnd *scmd)
 {
-	return blk_rq_pos(scmd->request);
+	return blk_rq_pos(scsi_cmd_to_rq(scmd));
 }
 
 static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
 {
 	unsigned int shift = ilog2(scmd->device->sector_size) - SECTOR_SHIFT;
 
-	return blk_rq_pos(scmd->request) >> shift;
+	return blk_rq_pos(scsi_cmd_to_rq(scmd)) >> shift;
 }
 
 /*
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 1a5c9a3df6d69..993e1e79dd0ce 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -264,13 +264,15 @@ sdev_prefix_printk(const char *, const struct scsi_device *, const char *,
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-#define scmd_dbg(scmd, fmt, a...)					   \
-	do {								   \
-		if ((scmd)->request->rq_disk)				   \
-			sdev_dbg((scmd)->device, "[%s] " fmt,		   \
-				 (scmd)->request->rq_disk->disk_name, ##a);\
-		else							   \
-			sdev_dbg((scmd)->device, fmt, ##a);		   \
+#define scmd_dbg(scmd, fmt, a...)					\
+	do {								\
+		struct request *__rq = scsi_cmd_to_rq((scmd));		\
+									\
+		if (__rq->rq_disk)					\
+			sdev_dbg((scmd)->device, "[%s] " fmt,		\
+				 __rq->rq_disk->disk_name, ##a);	\
+		else							\
+			sdev_dbg((scmd)->device, fmt, ##a);		\
 	} while (0)
 
 enum scsi_target_state {
-- 
2.43.0




