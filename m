Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417770C7EE
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjEVTdz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjEVTdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DC18F;
        Mon, 22 May 2023 12:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE0862934;
        Mon, 22 May 2023 19:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63DC433D2;
        Mon, 22 May 2023 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783992;
        bh=8RFKb6BkAvCRoieuFxAhj7c6BUO42qkMC7DClxoX/l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV9un9coDNfBQ4+l7cMZzE4YgQSAXm/wlI9QILfY92fYIeJPl00D+8mU/0MRNuAT5
         RYyy/3MTwb3MUtVUBY3UqHNykG3OecR2l0VGlbIlg3Jf+sGcfwy6YBisGFeECi3f8T
         bU2iaxHns4tJavvjRB+TD5k3/I+tuIFG/j6lUMFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxime Bizon <mbizon@freebox.fr>,
        linux-usb@vger.kernel.org, stable <stable@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.1 228/292] usb-storage: fix deadlock when a scsi command timeouts more than once
Date:   Mon, 22 May 2023 20:09:45 +0100
Message-Id: <20230522190411.652787945@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maxime Bizon <mbizon@freebox.fr>

commit a398d5eac6984316e71474e25b975688f282379b upstream.

With faulty usb-storage devices, read/write can timeout, in that case
the SCSI layer will abort and re-issue the command. USB storage has no
internal timeout, it relies on SCSI layer aborting commands via
.eh_abort_handler() for non those responsive devices.

After two consecutive timeouts of the same command, SCSI layer calls
.eh_device_reset_handler(), without calling .eh_abort_handler() first.

With usb-storage, this causes a deadlock:

  -> .eh_device_reset_handler
    -> device_reset
      -> mutex_lock(&(us->dev_mutex));

mutex already by usb_stor_control_thread(), which is waiting for
command completion:

  -> usb_stor_control_thread (mutex taken here)
    -> usb_stor_invoke_transport
      -> usb_stor_Bulk_transport
        -> usb_stor_bulk_srb
	  -> usb_stor_bulk_transfer_sglist
	    -> usb_sg_wait

Make sure we cancel any pending command in .eh_device_reset_handler()
to avoid this.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Cc: linux-usb@vger.kernel.org
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/all/ZEllnjMKT8ulZbJh@sakura/
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230505114759.1189741-1-mbizon@freebox.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/scsiglue.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -406,22 +406,25 @@ static DEF_SCSI_QCMD(queuecommand)
  ***********************************************************************/
 
 /* Command timeout and abort */
-static int command_abort(struct scsi_cmnd *srb)
+static int command_abort_matching(struct us_data *us, struct scsi_cmnd *srb_match)
 {
-	struct us_data *us = host_to_us(srb->device->host);
-
-	usb_stor_dbg(us, "%s called\n", __func__);
-
 	/*
 	 * us->srb together with the TIMED_OUT, RESETTING, and ABORTING
 	 * bits are protected by the host lock.
 	 */
 	scsi_lock(us_to_host(us));
 
-	/* Is this command still active? */
-	if (us->srb != srb) {
+	/* is there any active pending command to abort ? */
+	if (!us->srb) {
 		scsi_unlock(us_to_host(us));
 		usb_stor_dbg(us, "-- nothing to abort\n");
+		return SUCCESS;
+	}
+
+	/* Does the command match the passed srb if any ? */
+	if (srb_match && us->srb != srb_match) {
+		scsi_unlock(us_to_host(us));
+		usb_stor_dbg(us, "-- pending command mismatch\n");
 		return FAILED;
 	}
 
@@ -444,6 +447,14 @@ static int command_abort(struct scsi_cmn
 	return SUCCESS;
 }
 
+static int command_abort(struct scsi_cmnd *srb)
+{
+	struct us_data *us = host_to_us(srb->device->host);
+
+	usb_stor_dbg(us, "%s called\n", __func__);
+	return command_abort_matching(us, srb);
+}
+
 /*
  * This invokes the transport reset mechanism to reset the state of the
  * device
@@ -455,6 +466,9 @@ static int device_reset(struct scsi_cmnd
 
 	usb_stor_dbg(us, "%s called\n", __func__);
 
+	/* abort any pending command before reset */
+	command_abort_matching(us, NULL);
+
 	/* lock the device pointers and do the reset */
 	mutex_lock(&(us->dev_mutex));
 	result = us->transport_reset(us);


