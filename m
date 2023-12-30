Return-Path: <stable+bounces-8721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4D820469
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A251F216DC
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768031FC5;
	Sat, 30 Dec 2023 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIbjHkvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7723A5
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 10:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD457C433C7;
	Sat, 30 Dec 2023 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933883;
	bh=qlrxEgo/mxBNm3qC5qCK/WVhWwHAVLaolr7rYuIj6f4=;
	h=Subject:To:Cc:From:Date:From;
	b=AIbjHkvnGCF0DW2iWKmhjxRAsbnRTlq616CS7aTQOMgiPK8lew1JffNE9f/WLKfqg
	 t0bVy/K6XuwQULHjVbOr/G3gmMDduxO+FdAUX0eRr69AeSD761WxZyOXzg/x555FWA
	 X4+Lu0MxHy972gTaPJHb5+ch8Cdxdju5TL/v8wqU=
Subject: FAILED: patch "[PATCH] scsi: core: Always send batch on reset or error handling" failed to apply to 5.10-stable tree
To: alexander.atanasov@virtuozzo.com,martin.petersen@oracle.com,ming.lei@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:58:00 +0000
Message-ID: <2023123000-cornmeal-magnesium-abc7@gregkh>
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
git cherry-pick -x 066c5b46b6eaf2f13f80c19500dbb3b84baabb33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123000-cornmeal-magnesium-abc7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

066c5b46b6ea ("scsi: core: Always send batch on reset or error handling command")
bf23e619039d ("scsi: core: Use a structure member to track the SCSI command submitter")
aa8e25e5006a ("scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request")
d2c945f01d23 ("scsi: core: Make scsi_get_lba() return the LBA")
f0f214fe8cd3 ("scsi: core: Introduce scsi_get_sector()")
7ba46799d346 ("scsi: core: Add scsi_prot_ref_tag() helper")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 066c5b46b6eaf2f13f80c19500dbb3b84baabb33 Mon Sep 17 00:00:00 2001
From: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Date: Fri, 15 Dec 2023 14:10:08 +0200
Subject: [PATCH] scsi: core: Always send batch on reset or error handling
 command

In commit 8930a6c20791 ("scsi: core: add support for request batching") the
block layer bd->last flag was mapped to SCMD_LAST and used as an indicator
to send the batch for the drivers that implement this feature. However, the
error handling code was not updated accordingly.

scsi_send_eh_cmnd() is used to send error handling commands and request
sense. The problem is that request sense comes as a single command that
gets into the batch queue and times out. As a result the device goes
offline after several failed resets. This was observed on virtio_scsi
during a device resize operation.

[  496.316946] sd 0:0:4:0: [sdd] tag#117 scsi_eh_0: requesting sense
[  506.786356] sd 0:0:4:0: [sdd] tag#117 scsi_send_eh_cmnd timeleft: 0
[  506.787981] sd 0:0:4:0: [sdd] tag#117 abort

To fix this always set SCMD_LAST flag in scsi_send_eh_cmnd() and
scsi_reset_ioctl().

Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Link: https://lore.kernel.org/r/20231215121008.2881653-1-alexander.atanasov@virtuozzo.com
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..1223d34c04da 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1152,6 +1152,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 
 	scsi_log_send(scmd);
 	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -2459,6 +2460,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 
 	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
+	scmd->flags |= SCMD_LAST;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;


