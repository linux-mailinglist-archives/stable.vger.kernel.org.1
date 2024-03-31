Return-Path: <stable+bounces-33858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A5893166
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2BB1F22F72
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37325143C71;
	Sun, 31 Mar 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmJtZ9eG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74BEEC0
	for <stable@vger.kernel.org>; Sun, 31 Mar 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711883023; cv=none; b=Jout7AQJSrqDhfFZCRARFNq8F7DYnY3j7SUpR49pvFL2EKdBo7W+DUhbuB9d5lNWj5upxfPcVJvyzFSWmo38duwrbBBAVs2FEH50xOO2EhVW6rVUX4x5vl6GssV5SGkh7FbWJ6i4I8Kjz2ZH7k9TWxVVZjElGpfpIb9C/XHoi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711883023; c=relaxed/simple;
	bh=bxMf5pe5Xcu2ghvDLN6ThuP3qAqeLryDB2o8Vicn3VM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r0/4r6dQ0F4uUDkNF8NaNNCg2PKx4bK8OwoUrCC3RZsA5ZVrOqBu+OVLW3vrC6sIyx/27oE4ZDya97JCUCSeI/1IRviovkBm+d0o+BmPjy4604N5/YzbpTKvf4tztTMETbCN01KhTdK9av7+dpyXtxMuT1J+0iIqXyGRpykDoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmJtZ9eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EC9C433C7;
	Sun, 31 Mar 2024 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711883023;
	bh=bxMf5pe5Xcu2ghvDLN6ThuP3qAqeLryDB2o8Vicn3VM=;
	h=Subject:To:Cc:From:Date:From;
	b=gmJtZ9eGcnGgK34kgHZy3fr6RZQ11qGKavCW4SwVJRALJ+IQYG0B7oguQ5lX1iP3p
	 kHZp5migI5LzjiIP6HOwzxC2+jnXeJTze9zAMRtp7DwjoXvqOzHnQEkZHDv4RCOUcb
	 gb4EyUO9JxGqwR8RC3QbWr51RgyfBRJ2raI58WSk=
Subject: FAILED: patch "[PATCH] USB: UAS: return ENODEV when submit urbs fail with device not" failed to apply to 5.15-stable tree
To: WeitaoWang-oc@zhaoxin.com,gregkh@linuxfoundation.org,oneukum@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 31 Mar 2024 13:03:40 +0200
Message-ID: <2024033140-goon-residence-7f8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cd5432c712351a3d5f82512908f5febfca946ca6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033140-goon-residence-7f8c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd5432c712351a3d5f82512908f5febfca946ca6 Mon Sep 17 00:00:00 2001
From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Date: Thu, 7 Mar 2024 02:08:14 +0800
Subject: [PATCH] USB: UAS: return ENODEV when submit urbs fail with device not
 attached

In the scenario of entering hibernation with udisk in the system, if the
udisk was gone or resume fail in the thaw phase of hibernation. Its state
will be set to NOTATTACHED. At this point, usb_hub_wq was already freezed
and can't not handle disconnect event. Next, in the poweroff phase of
hibernation, SYNCHRONIZE_CACHE SCSI command will be sent to this udisk
when poweroff this scsi device, which will cause uas_submit_urbs to be
called to submit URB for sense/data/cmd pipe. However, these URBs will
submit fail as device was set to NOTATTACHED state. Then, uas_submit_urbs
will return a value SCSI_MLQUEUE_DEVICE_BUSY to the caller. That will lead
the SCSI layer go into an ugly loop and system fail to go into hibernation.

On the other hand, when we specially check for -ENODEV in function
uas_queuecommand_lck, returning DID_ERROR to SCSI layer will cause device
poweroff fail and system shutdown instead of entering hibernation.

To fix this issue, let uas_submit_urbs to return original generic error
when submitting URB failed. At the same time, we need to translate -ENODEV
to DID_NOT_CONNECT for the SCSI layer.

Suggested-by: Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Link: https://lore.kernel.org/r/20240306180814.4897-1-WeitaoWang-oc@zhaoxin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 71ace274761f..08953f0d4532 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -533,7 +533,7 @@ static struct urb *uas_alloc_cmd_urb(struct uas_dev_info *devinfo, gfp_t gfp,
  * daft to me.
  */
 
-static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
+static int uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 {
 	struct uas_dev_info *devinfo = cmnd->device->hostdata;
 	struct urb *urb;
@@ -541,30 +541,28 @@ static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 
 	urb = uas_alloc_sense_urb(devinfo, gfp, cmnd);
 	if (!urb)
-		return NULL;
+		return -ENOMEM;
 	usb_anchor_urb(urb, &devinfo->sense_urbs);
 	err = usb_submit_urb(urb, gfp);
 	if (err) {
 		usb_unanchor_urb(urb);
 		uas_log_cmd_state(cmnd, "sense submit err", err);
 		usb_free_urb(urb);
-		return NULL;
 	}
-	return urb;
+	return err;
 }
 
 static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 			   struct uas_dev_info *devinfo)
 {
 	struct uas_cmd_info *cmdinfo = scsi_cmd_priv(cmnd);
-	struct urb *urb;
 	int err;
 
 	lockdep_assert_held(&devinfo->lock);
 	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (err)
+			return err;
 		cmdinfo->state &= ~SUBMIT_STATUS_URB;
 	}
 
@@ -572,7 +570,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
 							cmnd, DMA_FROM_DEVICE);
 		if (!cmdinfo->data_in_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_DATA_IN_URB;
 	}
 
@@ -582,7 +580,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_in_urb);
 			uas_log_cmd_state(cmnd, "data in submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_IN_URB;
 		cmdinfo->state |= DATA_IN_URB_INFLIGHT;
@@ -592,7 +590,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		cmdinfo->data_out_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
 							cmnd, DMA_TO_DEVICE);
 		if (!cmdinfo->data_out_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_DATA_OUT_URB;
 	}
 
@@ -602,7 +600,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_out_urb);
 			uas_log_cmd_state(cmnd, "data out submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
 		cmdinfo->state |= DATA_OUT_URB_INFLIGHT;
@@ -611,7 +609,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 	if (cmdinfo->state & ALLOC_CMD_URB) {
 		cmdinfo->cmd_urb = uas_alloc_cmd_urb(devinfo, GFP_ATOMIC, cmnd);
 		if (!cmdinfo->cmd_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_CMD_URB;
 	}
 
@@ -621,7 +619,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->cmd_urb);
 			uas_log_cmd_state(cmnd, "cmd submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->cmd_urb = NULL;
 		cmdinfo->state &= ~SUBMIT_CMD_URB;
@@ -698,7 +696,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
-		set_host_byte(cmnd, DID_ERROR);
+		set_host_byte(cmnd, DID_NO_CONNECT);
 		scsi_done(cmnd);
 		goto zombie;
 	}


