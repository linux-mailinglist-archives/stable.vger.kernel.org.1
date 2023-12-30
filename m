Return-Path: <stable+bounces-8988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E98205BB
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94D2B2127E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED579DE;
	Sat, 30 Dec 2023 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bX64dWDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA879CD;
	Sat, 30 Dec 2023 12:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B08C433C7;
	Sat, 30 Dec 2023 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938282;
	bh=kyr+kzKaSSMnBz+IRwe7BuSRDWhESMUG/z5LQpDTtpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX64dWDowc+WJFXMZHVCmO5AK5t1OrcbkJ7a4Tc3VoKcOd/J5BQOWKunYt+duP/df
	 fkphh4DHNnPZRNJFVCPHKMNMZWwvzB0PFcIbEzhQb2QvoTGwTUwKPO2EVILDfJvvQV
	 yCGAcTaJfeFB5KOTNGb9SyHWHIaI2hvBBFagivSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 096/112] Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"
Date: Sat, 30 Dec 2023 12:00:09 +0000
Message-ID: <20231230115809.884695854@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

From: Martin K. Petersen <martin.petersen@oracle.com>

commit c5becf57dd5659c687d41d623a69f42d63f59eb2 upstream.

This reverts commit 9dc704dcc09eae7d21b5da0615eb2ed79278f63e.

Several reports have been made indicating that this commit caused
hangs. Numerous attempts at root causing and fixing the issue have
been unsuccessful so let's revert for now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217599
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/aacraid.h |    1 -
 drivers/scsi/aacraid/commsup.c |    6 +-----
 drivers/scsi/aacraid/linit.c   |   14 --------------
 drivers/scsi/aacraid/src.c     |   25 ++-----------------------
 4 files changed, 3 insertions(+), 43 deletions(-)

--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1678,7 +1678,6 @@ struct aac_dev
 	u32			handle_pci_error;
 	bool			init_reset;
 	u8			soft_reset_support;
-	u8			use_map_queue;
 };
 
 #define aac_adapter_interrupt(dev) \
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -223,12 +223,8 @@ int aac_fib_setup(struct aac_dev * dev)
 struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 {
 	struct fib *fibptr;
-	u32 blk_tag;
-	int i;
 
-	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-	i = blk_mq_unique_tag_to_tag(blk_tag);
-	fibptr = &dev->fibs[i];
+	fibptr = &dev->fibs[scsi_cmd_to_rq(scmd)->tag];
 	/*
 	 *	Null out fields that depend on being zero at the start of
 	 *	each I/O
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -19,7 +19,6 @@
 
 #include <linux/compat.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -506,15 +505,6 @@ common_config:
 	return 0;
 }
 
-static void aac_map_queues(struct Scsi_Host *shost)
-{
-	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
-
-	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-			      aac->pdev, 0);
-	aac->use_map_queue = true;
-}
-
 /**
  *	aac_change_queue_depth		-	alter queue depths
  *	@sdev:	SCSI device we are considering
@@ -1499,7 +1489,6 @@ static struct scsi_host_template aac_dri
 	.bios_param			= aac_biosparm,
 	.shost_groups			= aac_host_groups,
 	.slave_configure		= aac_slave_configure,
-	.map_queues			= aac_map_queues,
 	.change_queue_depth		= aac_change_queue_depth,
 	.sdev_groups			= aac_dev_groups,
 	.eh_abort_handler		= aac_eh_abort,
@@ -1787,8 +1776,6 @@ static int aac_probe_one(struct pci_dev
 	shost->max_lun = AAC_MAX_LUN;
 
 	pci_set_drvdata(pdev, shost);
-	shost->nr_hw_queues = aac->max_msix;
-	shost->host_tagset = 1;
 
 	error = scsi_add_host(shost, &pdev->dev);
 	if (error)
@@ -1921,7 +1908,6 @@ static void aac_remove_one(struct pci_de
 	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
 
 	aac_cancel_rescan_worker(aac);
-	aac->use_map_queue = false;
 	scsi_remove_host(shost);
 
 	__aac_shutdown(aac);
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -493,10 +493,6 @@ static int aac_src_deliver_message(struc
 #endif
 
 	u16 vector_no;
-	struct scsi_cmnd *scmd;
-	u32 blk_tag;
-	struct Scsi_Host *shost = dev->scsi_host_ptr;
-	struct blk_mq_queue_map *qmap;
 
 	atomic_inc(&q->numpending);
 
@@ -509,25 +505,8 @@ static int aac_src_deliver_message(struc
 		if ((dev->comm_interface == AAC_COMM_MESSAGE_TYPE3)
 			&& dev->sa_firmware)
 			vector_no = aac_get_vector(dev);
-		else {
-			if (!fib->vector_no || !fib->callback_data) {
-				if (shost && dev->use_map_queue) {
-					qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-					vector_no = qmap->mq_map[raw_smp_processor_id()];
-				}
-				/*
-				 *	We hardcode the vector_no for
-				 *	reserved commands as a valid shost is
-				 *	absent during the init
-				 */
-				else
-					vector_no = 0;
-			} else {
-				scmd = (struct scsi_cmnd *)fib->callback_data;
-				blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-				vector_no = blk_mq_unique_tag_to_hwq(blk_tag);
-			}
-		}
+		else
+			vector_no = fib->vector_no;
 
 		if (native_hba) {
 			if (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF) {



