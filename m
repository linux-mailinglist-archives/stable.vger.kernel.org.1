Return-Path: <stable+bounces-10489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A453A82AB52
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30C9B228BB
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30A11C8F;
	Thu, 11 Jan 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piuwULAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72711722;
	Thu, 11 Jan 2024 09:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB6EC433F1;
	Thu, 11 Jan 2024 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704966791;
	bh=z8Yexzam4e4y//qvwKHQBXMU5SdfDP7zAZHYZ8cSXxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piuwULAsSvmxBfUma89RGCrRSxnJpgrfenMHyzzzke/C0jzSc99jZ8KzAE6jAF13Q
	 hVZTrgsDsQgKAlFGzcpLewpPsyjGxved4aEbBlBzQwYPfH8VP/HMylBRoioJtt8Vph
	 f2oIyLYZuiJZKY5+rcesc37CMFCJRgud9wXGDQQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Machek <pavel@ucw.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 3/7] Revert "scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request"
Date: Thu, 11 Jan 2024 10:52:52 +0100
Message-ID: <20240111094700.389055308@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111094700.222742213@linuxfoundation.org>
References: <20240111094700.222742213@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit df83ca8e986d0285974dfa510973191547dcd173 which is
commit aa8e25e5006aac52c943c84e9056ab488630ee19 upstream.

As reported, a lot of scsi changes were made just to resolve a 2 line
patch, so let's revert them all and then manually fix up the 2 line
fixup so that things are simpler and potential abi changes are not an
issue.

Link: https://lore.kernel.org/r/ZZ042FejzwMM5vDW@duo.ucw.cz
Reported-by: Pavel Machek <pavel@ucw.cz>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi.c         |    2 +-
 drivers/scsi/scsi_error.c   |   15 +++++++--------
 drivers/scsi/scsi_lib.c     |   28 +++++++++++++---------------
 drivers/scsi/scsi_logging.c |   18 ++++++++----------
 include/scsi/scsi_cmnd.h    |    8 +++-----
 include/scsi/scsi_device.h  |   16 +++++++---------
 6 files changed, 39 insertions(+), 48 deletions(-)

--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -197,7 +197,7 @@ void scsi_finish_command(struct scsi_cmn
 				"(result %x)\n", cmd->result));
 
 	good_bytes = scsi_bufflen(cmd);
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
+	if (!blk_rq_is_passthrough(cmd->request)) {
 		int old_good_bytes = good_bytes;
 		drv = scsi_cmd_to_driver(cmd);
 		if (drv->done)
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -230,7 +230,7 @@ scsi_abort_command(struct scsi_cmnd *scm
  */
 static void scsi_eh_reset(struct scsi_cmnd *scmd)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
+	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_reset)
 			sdrv->eh_reset(scmd);
@@ -1167,7 +1167,7 @@ static int scsi_request_sense(struct scs
 
 static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
+	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_action)
 			rtn = sdrv->eh_action(scmd, rtn);
@@ -1733,24 +1733,22 @@ static void scsi_eh_offline_sdevs(struct
  */
 int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 {
-	struct request *req = scsi_cmd_to_rq(scmd);
-
 	switch (host_byte(scmd->result)) {
 	case DID_OK:
 		break;
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return req->cmd_flags & REQ_FAILFAST_TRANSPORT;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT);
 	case DID_PARITY:
-		return req->cmd_flags & REQ_FAILFAST_DEV;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
 	case DID_ERROR:
 		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
 		    status_byte(scmd->result) == RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return req->cmd_flags & REQ_FAILFAST_DRIVER;
+		return (scmd->request->cmd_flags & REQ_FAILFAST_DRIVER);
 	}
 
 	if (status_byte(scmd->result) != CHECK_CONDITION)
@@ -1761,7 +1759,8 @@ check_type:
 	 * assume caller has checked sense and determined
 	 * the check condition was retryable.
 	 */
-	if (req->cmd_flags & REQ_FAILFAST_DEV || blk_rq_is_passthrough(req))
+	if (scmd->request->cmd_flags & REQ_FAILFAST_DEV ||
+	    blk_rq_is_passthrough(scmd->request))
 		return 1;
 
 	return 0;
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -153,15 +153,13 @@ scsi_set_blocked(struct scsi_cmnd *cmd,
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = scsi_cmd_to_rq(cmd);
-
-	if (rq->rq_flags & RQF_DONTPREP) {
-		rq->rq_flags &= ~RQF_DONTPREP;
+	if (cmd->request->rq_flags & RQF_DONTPREP) {
+		cmd->request->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(rq, true);
+	blk_mq_requeue_request(cmd->request, true);
 }
 
 /**
@@ -200,7 +198,7 @@ static void __scsi_queue_insert(struct s
 	 */
 	cmd->result = 0;
 
-	blk_mq_requeue_request(scsi_cmd_to_rq(cmd), true);
+	blk_mq_requeue_request(cmd->request, true);
 }
 
 /**
@@ -510,7 +508,7 @@ void scsi_run_host_queues(struct Scsi_Ho
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
+	if (!blk_rq_is_passthrough(cmd->request)) {
 		struct scsi_driver *drv = scsi_cmd_to_driver(cmd);
 
 		if (drv->uninit_command)
@@ -660,7 +658,7 @@ static void scsi_io_completion_reprep(st
 
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	unsigned long wait_for;
 
 	if (cmd->allowed == SCSI_CMD_RETRIES_NO_LIMIT)
@@ -679,7 +677,7 @@ static bool scsi_cmd_runtime_exceeced(st
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	int level = 0;
 	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
 	      ACTION_DELAYED_RETRY} action;
@@ -851,7 +849,7 @@ static int scsi_io_completion_nz_result(
 {
 	bool sense_valid;
 	bool sense_current = true;	/* false implies "deferred sense" */
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	struct scsi_sense_hdr sshdr;
 
 	sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -940,7 +938,7 @@ void scsi_io_completion(struct scsi_cmnd
 {
 	int result = cmd->result;
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = scsi_cmd_to_rq(cmd);
+	struct request *req = cmd->request;
 	blk_status_t blk_stat = BLK_STS_OK;
 
 	if (unlikely(result))	/* a nz result may or may not be an error */
@@ -1008,7 +1006,7 @@ static inline bool scsi_cmd_needs_dma_dr
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct request *rq = cmd->request;
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
@@ -1137,7 +1135,7 @@ void scsi_init_command(struct scsi_devic
 {
 	void *buf = cmd->sense_buffer;
 	void *prot = cmd->prot_sdb;
-	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	unsigned int flags = cmd->flags & SCMD_PRESERVED_FLAGS;
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
@@ -1596,12 +1594,12 @@ static blk_status_t scsi_prepare_cmd(str
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
-	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
+	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
+	blk_mq_complete_request(cmd->request);
 }
 
 static void scsi_mq_put_budget(struct request_queue *q)
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -28,9 +28,8 @@ static void scsi_log_release_buffer(char
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
-	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
-
-	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
+	return scmd->request->rq_disk ?
+		scmd->request->rq_disk->disk_name : NULL;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
@@ -92,7 +91,7 @@ void scmd_printk(const char *level, cons
 	if (!logbuf)
 		return;
 	off = sdev_format_header(logbuf, logbuf_len, scmd_name(scmd),
-				 scsi_cmd_to_rq((struct scsi_cmnd *)scmd)->tag);
+				 scmd->request->tag);
 	if (off < logbuf_len) {
 		va_start(args, fmt);
 		off += vscnprintf(logbuf + off, logbuf_len - off, fmt, args);
@@ -189,7 +188,7 @@ void scsi_print_command(struct scsi_cmnd
 		return;
 
 	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), scsi_cmd_to_rq(cmd)->tag);
+				 scmd_name(cmd), cmd->request->tag);
 	if (off >= logbuf_len)
 		goto out_printk;
 	off += scnprintf(logbuf + off, logbuf_len - off, "CDB: ");
@@ -211,7 +210,7 @@ void scsi_print_command(struct scsi_cmnd
 
 			off = sdev_format_header(logbuf, logbuf_len,
 						 scmd_name(cmd),
-						 scsi_cmd_to_rq(cmd)->tag);
+						 cmd->request->tag);
 			if (!WARN_ON(off > logbuf_len - 58)) {
 				off += scnprintf(logbuf + off, logbuf_len - off,
 						 "CDB[%02x]: ", k);
@@ -374,8 +373,7 @@ EXPORT_SYMBOL(__scsi_print_sense);
 /* Normalize and print sense buffer in SCSI command */
 void scsi_print_sense(const struct scsi_cmnd *cmd)
 {
-	scsi_log_print_sense(cmd->device, scmd_name(cmd),
-			     scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag,
+	scsi_log_print_sense(cmd->device, scmd_name(cmd), cmd->request->tag,
 			     cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 }
 EXPORT_SYMBOL(scsi_print_sense);
@@ -394,8 +392,8 @@ void scsi_print_result(const struct scsi
 	if (!logbuf)
 		return;
 
-	off = sdev_format_header(logbuf, logbuf_len, scmd_name(cmd),
-				 scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag);
+	off = sdev_format_header(logbuf, logbuf_len,
+				 scmd_name(cmd), cmd->request->tag);
 
 	if (off >= logbuf_len)
 		goto out_printk;
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -162,9 +162,7 @@ static inline void *scsi_cmd_priv(struct
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-	struct request *rq = scsi_cmd_to_rq(cmd);
-
-	return *(struct scsi_driver **)rq->rq_disk->private_data;
+	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
 }
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
@@ -228,14 +226,14 @@ static inline int scsi_sg_copy_to_buffer
 
 static inline sector_t scsi_get_sector(struct scsi_cmnd *scmd)
 {
-	return blk_rq_pos(scsi_cmd_to_rq(scmd));
+	return blk_rq_pos(scmd->request);
 }
 
 static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
 {
 	unsigned int shift = ilog2(scmd->device->sector_size) - SECTOR_SHIFT;
 
-	return blk_rq_pos(scsi_cmd_to_rq(scmd)) >> shift;
+	return blk_rq_pos(scmd->request) >> shift;
 }
 
 /*
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -264,15 +264,13 @@ sdev_prefix_printk(const char *, const s
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-#define scmd_dbg(scmd, fmt, a...)					\
-	do {								\
-		struct request *__rq = scsi_cmd_to_rq((scmd));		\
-									\
-		if (__rq->rq_disk)					\
-			sdev_dbg((scmd)->device, "[%s] " fmt,		\
-				 __rq->rq_disk->disk_name, ##a);	\
-		else							\
-			sdev_dbg((scmd)->device, fmt, ##a);		\
+#define scmd_dbg(scmd, fmt, a...)					   \
+	do {								   \
+		if ((scmd)->request->rq_disk)				   \
+			sdev_dbg((scmd)->device, "[%s] " fmt,		   \
+				 (scmd)->request->rq_disk->disk_name, ##a);\
+		else							   \
+			sdev_dbg((scmd)->device, fmt, ##a);		   \
 	} while (0)
 
 enum scsi_target_state {



