Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27F7A3A40
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbjIQUBc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbjIQUAd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59591A4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D92BC433C8;
        Sun, 17 Sep 2023 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980814;
        bh=yRo4v57t/KoTVuvefG0/CYzYGYq5DDdyUKDC+QSH6o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F84/wMjgfoofjc52w4lrNBOH4Sba7qiAsl7XBlClahEp7lJswMeFkNYm4aCjP1hQa
         /rzTwZOhJaxyWvBxdhnRRMFJI91tBPh7JSr7JIWVoB9nHdP8Xic7hMWzPlpp/CTpA+
         s4W2afItYylHBafwuOzGmPmpHHH4Ti/YM6OIyMos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 016/219] scsi: qla2xxx: Fix erroneous link up failure
Date:   Sun, 17 Sep 2023 21:12:23 +0200
Message-ID: <20230917191041.571446795@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 5b51f35d127e7bef55fa869d2465e2bca4636454 upstream.

Link up failure occurred where driver failed to see certain events from FW
indicating link up (AEN 8011) and fabric login completion (AEN 8014).
Without these 2 events, driver would not proceed forward to scan the
fabric. The cause of this is due to delay in the receive of interrupt for
Mailbox 60 that causes qla to set the fw_started flag late.  The late
setting of this flag causes other interrupts to be dropped.  These dropped
interrupts happen to be the link up (AEN 8011) and fabric login completion
(AEN 8014).

Set fw_started flag early to prevent interrupts being dropped.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-6-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    3 ++-
 drivers/scsi/qla2xxx/qla_isr.c  |    6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4816,15 +4816,16 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 	if (ha->flags.edif_enabled)
 		mid_init_cb->init_cb.frame_payload_size = cpu_to_le16(ELS_MAX_PAYLOAD);
 
+	QLA_FW_STARTED(ha);
 	rval = qla2x00_init_firmware(vha, ha->init_cb_size);
 next_check:
 	if (rval) {
+		QLA_FW_STOPPED(ha);
 		ql_log(ql_log_fatal, vha, 0x00d2,
 		    "Init Firmware **** FAILED ****.\n");
 	} else {
 		ql_dbg(ql_dbg_init, vha, 0x00d3,
 		    "Init Firmware -- success.\n");
-		QLA_FW_STARTED(ha);
 		vha->u_ql2xexchoffld = vha->u_ql2xiniexchg = 0;
 	}
 
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1121,8 +1121,12 @@ qla2x00_async_event(scsi_qla_host_t *vha
 	unsigned long	flags;
 	fc_port_t	*fcport = NULL;
 
-	if (!vha->hw->flags.fw_started)
+	if (!vha->hw->flags.fw_started) {
+		ql_log(ql_log_warn, vha, 0x50ff,
+		    "Dropping AEN - %04x %04x %04x %04x.\n",
+		    mb[0], mb[1], mb[2], mb[3]);
 		return;
+	}
 
 	/* Setup to process RIO completion. */
 	handle_cnt = 0;


