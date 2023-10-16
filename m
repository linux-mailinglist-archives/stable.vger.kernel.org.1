Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04B7CA2A2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjJPIw3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJPIwX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:52:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD4E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2BBC433C8;
        Mon, 16 Oct 2023 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446341;
        bh=VKPGhlyhFVaANjb0ZWuwPZ3YGl/U2XUjVB5leGS5Z7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ews5u50bH8dKxa25gOA/uJR9MzOUpKcURd4XBcwyP3I8g5kUqk4uhU7veS6KBbKYs
         AINhGOqaU1VUkMSkVoV+T+qC0lQFJH+nWZXyrOUZ4vyeuxYzIdxuYNDecpbmM8gg/5
         ybmc6eR4PNR2Ti52KvEw3DrmBtSc/KxHHPBRWXpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Tesarik <petr@tesarici.cz>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1 008/131] scsi: Do not rescan devices with a suspended queue
Date:   Mon, 16 Oct 2023 10:39:51 +0200
Message-ID: <20231016084000.271274969@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 626b13f015e080e434b1dee9a0c116ddbf4fb695 upstream.

Commit ff48b37802e5 ("scsi: Do not attempt to rescan suspended devices")
modified scsi_rescan_device() to avoid attempting rescanning a suspended
device. However, the modification added a check to verify that a SCSI
device is in the running state without checking if the device request
queue (in the case of block device) is also running, thus allowing the
exectuion of internal requests. Without checking the device request
queue, commit ff48b37802e5 fix is incomplete and deadlocks on resume can
still happen. Use blk_queue_pm_only() to check if the device request
queue allows executing commands in addition to checking the SCSI device
state.

Reported-by: Petr Tesarik <petr@tesarici.cz>
Fixes: ff48b37802e5 ("scsi: Do not attempt to rescan suspended devices")
Cc: stable@vger.kernel.org
Tested-by: Petr Tesarik <petr@tesarici.cz>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_scan.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1619,12 +1619,13 @@ int scsi_rescan_device(struct scsi_devic
 	device_lock(dev);
 
 	/*
-	 * Bail out if the device is not running. Otherwise, the rescan may
-	 * block waiting for commands to be executed, with us holding the
-	 * device lock. This can result in a potential deadlock in the power
-	 * management core code when system resume is on-going.
+	 * Bail out if the device or its queue are not running. Otherwise,
+	 * the rescan may block waiting for commands to be executed, with us
+	 * holding the device lock. This can result in a potential deadlock
+	 * in the power management core code when system resume is on-going.
 	 */
-	if (sdev->sdev_state != SDEV_RUNNING) {
+	if (sdev->sdev_state != SDEV_RUNNING ||
+	    blk_queue_pm_only(sdev->request_queue)) {
 		ret = -EWOULDBLOCK;
 		goto unlock;
 	}


