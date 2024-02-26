Return-Path: <stable+bounces-23682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968208674E3
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F128619C
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF32604DE;
	Mon, 26 Feb 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1XLqAp0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D0604D7
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950540; cv=none; b=hvaV0kFUOe/I9i01CIuFMdTIqr8t31S1jMZp8xrLjUAF+p5WBL2YYUwWVX8NT40vbpBPKkLff/jgwVA088WKf8SYLjbcsb8xrDPf30yLFrN5haz7UQb52Vam3IpIBoSl+LWpS2KLTkmLMTM4IvjcCbOnp0PSxAWZsjSRTQtXg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950540; c=relaxed/simple;
	bh=Jyk9D05vn5XZiggy49D/FIORaSx6FeEgACj9dTabPdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lXicp6rGmbLWdgodRzQbAtZSduUgG7aqVTepagaJ5X/Qlso0raOmGpfqI/whY89LD4AT/m9smrUZvFEUf19XUmXlK+dheNUeaguebZJD2a7iUGFsTvrgwtXWiLt/Ygh66wAOUpI+HzqTHLLqNepTSndma8x/JUXLjKlkNyKDVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1XLqAp0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D286FC43390;
	Mon, 26 Feb 2024 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708950540;
	bh=Jyk9D05vn5XZiggy49D/FIORaSx6FeEgACj9dTabPdI=;
	h=Subject:To:Cc:From:Date:From;
	b=1XLqAp0Xuo3rL7ym5UDHf8Dx9WX75tLe+uh8UGPjdR8A/wibE7T6ePwX3g8FSgpSH
	 tw2MUq32BxFcbQN53BeqtpG8UyMwKrdM+YfUTuA4T9yjUzT1bb7UWmTRmRYMZlqJ9N
	 p11hLErVhJlvQtHlq8KK+/UrGeiijJoyVsr3C5vw=
Subject: FAILED: patch "[PATCH] scsi: sd: usb_storage: uas: Access media prior to querying" failed to apply to 6.1-stable tree
To: martin.petersen@oracle.com,bvanassche@acm.org,emilne@redhat.com,tasos@tasossah.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 13:28:57 +0100
Message-ID: <2024022657-skintight-fetal-ec4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 321da3dc1f3c92a12e3c5da934090d2992a8814c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022657-skintight-fetal-ec4b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

321da3dc1f3c ("scsi: sd: usb_storage: uas: Access media prior to querying device properties")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 321da3dc1f3c92a12e3c5da934090d2992a8814c Mon Sep 17 00:00:00 2001
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Tue, 13 Feb 2024 09:33:06 -0500
Subject: [PATCH] scsi: sd: usb_storage: uas: Access media prior to querying
 device properties

It has been observed that some USB/UAS devices return generic properties
hardcoded in firmware for mode pages for a period of time after a device
has been discovered. The reported properties are either garbage or they do
not accurately reflect the characteristics of the physical storage device
attached in the case of a bridge.

Prior to commit 1e029397d12f ("scsi: sd: Reorganize DIF/DIX code to
avoid calling revalidate twice") we would call revalidate several
times during device discovery. As a result, incorrect values would
eventually get replaced with ones accurately describing the attached
storage. When we did away with the redundant revalidate pass, several
cases were reported where devices reported nonsensical values or would
end up in write-protected state.

An initial attempt at addressing this issue involved introducing a
delayed second revalidate invocation. However, this approach still
left some devices reporting incorrect characteristics.

Tasos Sahanidis debugged the problem further and identified that
introducing a READ operation prior to MODE SENSE fixed the problem and that
it wasn't a timing issue. Issuing a READ appears to cause the devices to
update their state to reflect the actual properties of the storage
media. Device properties like vendor, model, and storage capacity appear to
be correctly reported from the get-go. It is unclear why these devices
defer populating the remaining characteristics.

Match the behavior of a well known commercial operating system and
trigger a READ operation prior to querying device characteristics to
force the device to populate the mode pages.

The additional READ is triggered by a flag set in the USB storage and
UAS drivers. We avoid issuing the READ for other transport classes
since some storage devices identify Linux through our particular
discovery command sequence.

Link: https://lore.kernel.org/r/20240213143306.2194237-1-martin.petersen@oracle.com
Fixes: 1e029397d12f ("scsi: sd: Reorganize DIF/DIX code to avoid calling revalidate twice")
Cc: stable@vger.kernel.org
Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Tasos Sahanidis <tasos@tasossah.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..bdd0acf7fa3c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3407,6 +3407,24 @@ static bool sd_validate_opt_xfer_size(struct scsi_disk *sdkp,
 	return true;
 }
 
+static void sd_read_block_zero(struct scsi_disk *sdkp)
+{
+	unsigned int buf_len = sdkp->device->sector_size;
+	char *buffer, cmd[10] = { };
+
+	buffer = kmalloc(buf_len, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	cmd[0] = READ_10;
+	put_unaligned_be32(0, &cmd[2]); /* Logical block address 0 */
+	put_unaligned_be16(1, &cmd[7]);	/* Transfer 1 logical block */
+
+	scsi_execute_cmd(sdkp->device, cmd, REQ_OP_DRV_IN, buffer, buf_len,
+			 SD_TIMEOUT, sdkp->max_retries, NULL);
+	kfree(buffer);
+}
+
 /**
  *	sd_revalidate_disk - called the first time a new disk is seen,
  *	performs disk spin up, read_capacity, etc.
@@ -3446,7 +3464,13 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 */
 	if (sdkp->media_present) {
 		sd_read_capacity(sdkp, buffer);
-
+		/*
+		 * Some USB/UAS devices return generic values for mode pages
+		 * until the media has been accessed. Trigger a READ operation
+		 * to force the device to populate mode pages.
+		 */
+		if (sdp->read_before_ms)
+			sd_read_block_zero(sdkp);
 		/*
 		 * set the default to rotational.  All non-rotational devices
 		 * support the block characteristics VPD page, which will
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index c54e9805da53..12cf9940e5b6 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -179,6 +179,13 @@ static int slave_configure(struct scsi_device *sdev)
 		 */
 		sdev->use_192_bytes_for_3f = 1;
 
+		/*
+		 * Some devices report generic values until the media has been
+		 * accessed. Force a READ(10) prior to querying device
+		 * characteristics.
+		 */
+		sdev->read_before_ms = 1;
+
 		/*
 		 * Some devices don't like MODE SENSE with page=0x3f,
 		 * which is the command used for checking if a device
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 9707f53cfda9..71ace274761f 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -878,6 +878,13 @@ static int uas_slave_configure(struct scsi_device *sdev)
 	if (devinfo->flags & US_FL_CAPACITY_HEURISTICS)
 		sdev->guess_capacity = 1;
 
+	/*
+	 * Some devices report generic values until the media has been
+	 * accessed. Force a READ(10) prior to querying device
+	 * characteristics.
+	 */
+	sdev->read_before_ms = 1;
+
 	/*
 	 * Some devices don't like MODE SENSE with page=0x3f,
 	 * which is the command used for checking if a device
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 5ec1e71a09de..01c02cb76ea6 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -208,6 +208,7 @@ struct scsi_device {
 	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
 	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
 	unsigned set_dbd_for_ms:1; /* Set "DBD" field in mode sense */
+	unsigned read_before_ms:1;	/* perform a READ before MODE SENSE */
 	unsigned no_report_opcodes:1;	/* no REPORT SUPPORTED OPERATION CODES */
 	unsigned no_write_same:1;	/* no WRITE SAME command */
 	unsigned use_16_for_rw:1; /* Use read/write(16) over read/write(10) */


