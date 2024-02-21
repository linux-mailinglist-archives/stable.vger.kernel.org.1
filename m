Return-Path: <stable+bounces-22773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE585DDCC
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CED28342F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CE7EF14;
	Wed, 21 Feb 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UFYbZ/OS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D274C62;
	Wed, 21 Feb 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524465; cv=none; b=F0LZ9ixGOIaL14RJfepK3fOCzzTV+oidgwnxGUG0XHH2AzBIu9PBq03ptIf/ZhZOLaHiD76P0MS1d7cLOfA14Mt8gQ/eVA3/G+mFbwCf/VdLecbUECzUfMOGgP4m03L/IGecji0X98wRhT3UUvCzE/VgiimeqFddCOFCFBeSSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524465; c=relaxed/simple;
	bh=/AnFlVA7Ac3/S+7kIYXyrE8eJClNvnyUDZyC8FwJubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS/9CIQler3vYMsu8ddinFtqqyl1rG+3Gh5YkFGh/yPSedFAentJojMLx9BWQNxA/MRwcSrTqATf9Q9EFwBojkGm82lVAY6RG0RBwxr5UV82qwLvDEELUt8Jrn27+ho+myGxnJ99dGefKH3HHCGKA5T+/oOEydQ9J9YNV3LIZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UFYbZ/OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BDCC433C7;
	Wed, 21 Feb 2024 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524465;
	bh=/AnFlVA7Ac3/S+7kIYXyrE8eJClNvnyUDZyC8FwJubg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFYbZ/OSMch9t4c8dRpiuJE4m04x2ELVY9cFOPMqQuGdjoBUTmhHNlOGMu9m44459
	 hx8y235M9ZKf9IxR0CmgBSj/GX9tQGKSMCOtgWUhpMoJyTq2Cm8x2Wsrc9pyOW91hp
	 bOC4QO3zjgTmKWxlFqRX2FZ3Ojm6o/i2b8Z8YsKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 224/379] scsi: core: Introduce enum scsi_disposition
Date: Wed, 21 Feb 2024 14:06:43 +0100
Message-ID: <20240221130001.525980651@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

[ Upstream commit b8e162f9e7e2da6e823a4984d6aa0523e278babf ]

Improve readability of the code in the SCSI core by introducing an
enumeration type for the values used internally that decide how to continue
processing a SCSI command. The eh_*_handler return values have not been
changed because that would involve modifying all SCSI drivers.

The output of the following command has been inspected to verify that no
out-of-range values are assigned to a variable of type enum
scsi_disposition:

KCFLAGS=-Wassign-enum make CC=clang W=1 drivers/scsi/

Link: https://lore.kernel.org/r/20210415220826.29438-6-bvanassche@acm.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 4373534a9850 ("scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c                    |  2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c |  4 +-
 drivers/scsi/device_handler/scsi_dh_emc.c  |  4 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c |  4 +-
 drivers/scsi/scsi_error.c                  | 64 ++++++++++++----------
 drivers/scsi/scsi_lib.c                    |  2 +-
 drivers/scsi/scsi_priv.h                   |  2 +-
 include/scsi/scsi.h                        | 21 +++----
 include/scsi/scsi_dh.h                     |  3 +-
 include/scsi/scsi_eh.h                     |  2 +-
 10 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2308c2be85a1..48130b254396 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1607,7 +1607,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
-		int ret = scsi_check_sense(qc->scsicmd);
+		enum scsi_disposition ret = scsi_check_sense(qc->scsicmd);
 		/*
 		 * SUCCESS here means that the sense code could be
 		 * evaluated and should be passed to the upper layers
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index bf0b3178f84d..4371d8b00656 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -405,8 +405,8 @@ static char print_alua_state(unsigned char state)
 	}
 }
 
-static int alua_check_sense(struct scsi_device *sdev,
-			    struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
 {
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index caa685cfe3d4..bd28ec6cfb72 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -280,8 +280,8 @@ static int send_trespass_cmd(struct scsi_device *sdev,
 	return res;
 }
 
-static int clariion_check_sense(struct scsi_device *sdev,
-				struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition clariion_check_sense(struct scsi_device *sdev,
+					struct scsi_sense_hdr *sense_hdr)
 {
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 85a71bafaea7..66652ab409cc 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -656,8 +656,8 @@ static blk_status_t rdac_prep_fn(struct scsi_device *sdev, struct request *req)
 	return BLK_STS_OK;
 }
 
-static int rdac_check_sense(struct scsi_device *sdev,
-				struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition rdac_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
 {
 	struct rdac_dh_data *h = sdev->handler_data;
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3d3d139127ee..242e5ea5e0c3 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -60,8 +60,8 @@ static void scsi_eh_done(struct scsi_cmnd *scmd);
 #define HOST_RESET_SETTLE_TIME  (10)
 
 static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
-static int scsi_try_to_abort_cmd(struct scsi_host_template *,
-				 struct scsi_cmnd *);
+static enum scsi_disposition scsi_try_to_abort_cmd(struct scsi_host_template *,
+						   struct scsi_cmnd *);
 
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
@@ -140,7 +140,7 @@ scmd_eh_abort_handler(struct work_struct *work)
 	struct scsi_cmnd *scmd =
 		container_of(work, struct scsi_cmnd, abort_work.work);
 	struct scsi_device *sdev = scmd->device;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	if (scsi_host_eh_past_deadline(sdev->host)) {
 		SCSI_LOG_ERROR_RECOVERY(3,
@@ -478,7 +478,7 @@ static void scsi_report_sense(struct scsi_device *sdev,
  *	When a deferred error is detected the current command has
  *	not been executed and needs retrying.
  */
-int scsi_check_sense(struct scsi_cmnd *scmd)
+enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 {
 	struct scsi_device *sdev = scmd->device;
 	struct scsi_sense_hdr sshdr;
@@ -492,7 +492,7 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 		return NEEDS_RETRY;
 
 	if (sdev->handler && sdev->handler->check_sense) {
-		int rc;
+		enum scsi_disposition rc;
 
 		rc = sdev->handler->check_sense(sdev, &sshdr);
 		if (rc != SCSI_RETURN_NOT_HANDLED)
@@ -703,7 +703,7 @@ static void scsi_handle_queue_full(struct scsi_device *sdev)
  *    don't allow for the possibility of retries here, and we are a lot
  *    more restrictive about what we consider acceptable.
  */
-static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_eh_completed_normally(struct scsi_cmnd *scmd)
 {
 	/*
 	 * first check the host byte, to see if there is anything in there
@@ -784,10 +784,10 @@ static void scsi_eh_done(struct scsi_cmnd *scmd)
  * scsi_try_host_reset - ask host adapter to reset itself
  * @scmd:	SCSI cmd to send host reset.
  */
-static int scsi_try_host_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_host_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -814,10 +814,10 @@ static int scsi_try_host_reset(struct scsi_cmnd *scmd)
  * scsi_try_bus_reset - ask host to perform a bus reset
  * @scmd:	SCSI cmd to send bus reset.
  */
-static int scsi_try_bus_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_bus_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -856,10 +856,10 @@ static void __scsi_report_device_reset(struct scsi_device *sdev, void *data)
  *    timer on it, and set the host back to a consistent state prior to
  *    returning.
  */
-static int scsi_try_target_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_target_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -887,9 +887,9 @@ static int scsi_try_target_reset(struct scsi_cmnd *scmd)
  *    timer on it, and set the host back to a consistent state prior to
  *    returning.
  */
-static int scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
 {
-	int rtn;
+	enum scsi_disposition rtn;
 	struct scsi_host_template *hostt = scmd->device->host->hostt;
 
 	if (!hostt->eh_device_reset_handler)
@@ -918,8 +918,8 @@ static int scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
  *    if the device is temporarily unavailable (eg due to a
  *    link down on FibreChannel)
  */
-static int scsi_try_to_abort_cmd(struct scsi_host_template *hostt,
-				 struct scsi_cmnd *scmd)
+static enum scsi_disposition
+scsi_try_to_abort_cmd(struct scsi_host_template *hostt, struct scsi_cmnd *scmd)
 {
 	if (!hostt->eh_abort_handler)
 		return FAILED;
@@ -1052,8 +1052,8 @@ EXPORT_SYMBOL(scsi_eh_restore_cmnd);
  * Return value:
  *    SUCCESS or FAILED or NEEDS_RETRY
  */
-static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
-			     int cmnd_size, int timeout, unsigned sense_bytes)
+static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
+	unsigned char *cmnd, int cmnd_size, int timeout, unsigned sense_bytes)
 {
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
@@ -1161,12 +1161,13 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
  *    that we obtain it on our own. This function will *not* return until
  *    the command either times out, or it completes.
  */
-static int scsi_request_sense(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_request_sense(struct scsi_cmnd *scmd)
 {
 	return scsi_send_eh_cmnd(scmd, NULL, 0, scmd->device->eh_timeout, ~0);
 }
 
-static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
+static enum scsi_disposition
+scsi_eh_action(struct scsi_cmnd *scmd, enum scsi_disposition rtn)
 {
 	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
@@ -1219,7 +1220,7 @@ int scsi_eh_get_sense(struct list_head *work_q,
 {
 	struct scsi_cmnd *scmd, *next;
 	struct Scsi_Host *shost;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * If SCSI_EH_ABORT_SCHEDULED has been set, it is timeout IO,
@@ -1297,7 +1298,8 @@ EXPORT_SYMBOL_GPL(scsi_eh_get_sense);
 static int scsi_eh_tur(struct scsi_cmnd *scmd)
 {
 	static unsigned char tur_command[6] = {TEST_UNIT_READY, 0, 0, 0, 0, 0};
-	int retry_cnt = 1, rtn;
+	int retry_cnt = 1;
+	enum scsi_disposition rtn;
 
 retry_tur:
 	rtn = scsi_send_eh_cmnd(scmd, tur_command, 6,
@@ -1385,7 +1387,8 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd)
 	static unsigned char stu_command[6] = {START_STOP, 0, 0, 0, 1, 0};
 
 	if (scmd->device->allow_restart) {
-		int i, rtn = NEEDS_RETRY;
+		int i;
+		enum scsi_disposition rtn = NEEDS_RETRY;
 
 		for (i = 0; rtn == NEEDS_RETRY && i < 2; i++)
 			rtn = scsi_send_eh_cmnd(scmd, stu_command, 6, scmd->device->request_queue->rq_timeout, 0);
@@ -1479,7 +1482,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *bdr_scmd, *next;
 	struct scsi_device *sdev;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	shost_for_each_device(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
@@ -1546,7 +1549,7 @@ static int scsi_eh_target_reset(struct Scsi_Host *shost,
 
 	while (!list_empty(&tmp_list)) {
 		struct scsi_cmnd *next, *scmd;
-		int rtn;
+		enum scsi_disposition rtn;
 		unsigned int id;
 
 		if (scsi_host_eh_past_deadline(shost)) {
@@ -1604,7 +1607,7 @@ static int scsi_eh_bus_reset(struct Scsi_Host *shost,
 	struct scsi_cmnd *scmd, *chan_scmd, *next;
 	LIST_HEAD(check_list);
 	unsigned int channel;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * we really want to loop over the various channels, and do this on
@@ -1675,7 +1678,7 @@ static int scsi_eh_host_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *next;
 	LIST_HEAD(check_list);
-	int rtn;
+	enum scsi_disposition rtn;
 
 	if (!list_empty(work_q)) {
 		scmd = list_entry(work_q->next,
@@ -1781,9 +1784,9 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
  *    doesn't require the error handler read (i.e. we don't need to
  *    abort/reset), this function should return SUCCESS.
  */
-int scsi_decide_disposition(struct scsi_cmnd *scmd)
+enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 {
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * if the device is offline, then we clearly just pass the result back
@@ -2339,7 +2342,8 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	struct Scsi_Host *shost = dev->host;
 	struct request *rq;
 	unsigned long flags;
-	int error = 0, rtn, val;
+	int error = 0, val;
+	enum scsi_disposition rtn;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 99b90031500b..38f82d15248b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1426,7 +1426,7 @@ static bool scsi_mq_lld_busy(struct request_queue *q)
 static void scsi_softirq_done(struct request *rq)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
-	int disposition;
+	enum scsi_disposition disposition;
 
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982..8a015af4aa11 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -73,7 +73,7 @@ extern void scsi_exit_devinfo(void);
 extern void scmd_eh_abort_handler(struct work_struct *work);
 extern enum blk_eh_timer_return scsi_times_out(struct request *req);
 extern int scsi_error_handler(void *host);
-extern int scsi_decide_disposition(struct scsi_cmnd *cmd);
+extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
 extern void scsi_eh_scmd_add(struct scsi_cmnd *);
 void scsi_eh_ready_devs(struct Scsi_Host *shost,
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 5339baadc082..39c7a36cd6ce 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -178,16 +178,17 @@ static inline int scsi_is_wlun(u64 lun)
 /*
  * Internal return values.
  */
-
-#define NEEDS_RETRY     0x2001
-#define SUCCESS         0x2002
-#define FAILED          0x2003
-#define QUEUED          0x2004
-#define SOFT_ERROR      0x2005
-#define ADD_TO_MLQUEUE  0x2006
-#define TIMEOUT_ERROR   0x2007
-#define SCSI_RETURN_NOT_HANDLED   0x2008
-#define FAST_IO_FAIL	0x2009
+enum scsi_disposition {
+	NEEDS_RETRY		= 0x2001,
+	SUCCESS			= 0x2002,
+	FAILED			= 0x2003,
+	QUEUED			= 0x2004,
+	SOFT_ERROR		= 0x2005,
+	ADD_TO_MLQUEUE		= 0x2006,
+	TIMEOUT_ERROR		= 0x2007,
+	SCSI_RETURN_NOT_HANDLED	= 0x2008,
+	FAST_IO_FAIL		= 0x2009,
+};
 
 /*
  * Midlevel queue return values.
diff --git a/include/scsi/scsi_dh.h b/include/scsi/scsi_dh.h
index 2852e470a8ed..47ccf2f11d89 100644
--- a/include/scsi/scsi_dh.h
+++ b/include/scsi/scsi_dh.h
@@ -52,7 +52,8 @@ struct scsi_device_handler {
 	/* Filled by the hardware handler */
 	struct module *module;
 	const char *name;
-	int (*check_sense)(struct scsi_device *, struct scsi_sense_hdr *);
+	enum scsi_disposition (*check_sense)(struct scsi_device *,
+					     struct scsi_sense_hdr *);
 	int (*attach)(struct scsi_device *);
 	void (*detach)(struct scsi_device *);
 	int (*activate)(struct scsi_device *, activate_complete, void *);
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 6bd5ed695a5e..468094254b3c 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -17,7 +17,7 @@ extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
 extern int scsi_block_when_processing_errors(struct scsi_device *);
 extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 					 struct scsi_sense_hdr *sshdr);
-extern int scsi_check_sense(struct scsi_cmnd *);
+extern enum scsi_disposition scsi_check_sense(struct scsi_cmnd *);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
-- 
2.43.0




