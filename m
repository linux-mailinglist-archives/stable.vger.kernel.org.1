Return-Path: <stable+bounces-26382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203E870E53
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C2E282557
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B701EB5A;
	Mon,  4 Mar 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f8nkIU7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2810A35;
	Mon,  4 Mar 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588575; cv=none; b=PJFhVCtFnRyz4FngqSmjsZKrAXvVfHdD/rodfNMbSvQaMhW7N9jnbs8vfONicVjRzlU9aJYQp5mQtt0d4mTC41+Sdbg195NzKHZJ9F59sX5wsshdy1Hwbt0bdGCsfoACaGTsAXRKnwRf3Jo5z12sledSPANiRkbvTDIXpyPDUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588575; c=relaxed/simple;
	bh=3C9U6Lli1tV6EAcSgdDEeeWRWFGFc5n3qlqYibuZ8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvHPwj0v4qPCfn3eyH0pjOPhrmNb/CuGiNCXiV7+/NQ4UdsGUSxUrYH7fANMkA9thbkjo4rOExmH143GxRE/72vNMYUY6HIzA62K0mgcHadyNA8KR0vluhgDRGKpPVGOAqUH2OO8ZU8MCBO2emAu20rLjyCpp/ANY3cnNwRPuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f8nkIU7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434D4C433C7;
	Mon,  4 Mar 2024 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588575;
	bh=3C9U6Lli1tV6EAcSgdDEeeWRWFGFc5n3qlqYibuZ8PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8nkIU7w2nTYq0quFGVfalBMXD7bA1m9Slb1miDqhS0nDLf8XUlOnOZAJ7IzE/0zR
	 exu9HcdfaejqH0TopXdDDW1fwamTl3cH4iEzjN2W3Izjf39MQqvHyX6agx6wf7vP6r
	 ezy/sFYzkjP8U6huIBkD9+4F9RCnljnDJbGKinTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tasos Sahanidis <tasos@tasossah.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/215] scsi: sd: usb_storage: uas: Access media prior to querying device properties
Date: Mon,  4 Mar 2024 21:21:08 +0000
Message-ID: <20240304211557.173185622@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

[ Upstream commit 321da3dc1f3c92a12e3c5da934090d2992a8814c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c              | 26 +++++++++++++++++++++++++-
 drivers/usb/storage/scsiglue.c |  7 +++++++
 drivers/usb/storage/uas.c      |  7 +++++++
 include/scsi/scsi_device.h     |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 31b5273f43a71..4433b02c8935f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3284,6 +3284,24 @@ static bool sd_validate_opt_xfer_size(struct scsi_disk *sdkp,
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
@@ -3323,7 +3341,13 @@ static int sd_revalidate_disk(struct gendisk *disk)
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
index c54e9805da536..12cf9940e5b67 100644
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
index de3836412bf32..ed22053b3252f 100644
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
index b407807cc6695..a64713fe52640 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -204,6 +204,7 @@ struct scsi_device {
 	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
 	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
 	unsigned set_dbd_for_ms:1; /* Set "DBD" field in mode sense */
+	unsigned read_before_ms:1;	/* perform a READ before MODE SENSE */
 	unsigned no_report_opcodes:1;	/* no REPORT SUPPORTED OPERATION CODES */
 	unsigned no_write_same:1;	/* no WRITE SAME command */
 	unsigned use_16_for_rw:1; /* Use read/write(16) over read/write(10) */
-- 
2.43.0




