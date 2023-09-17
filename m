Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE47A3779
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbjIQTVE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjIQTUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:20:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7E11A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:20:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF300C433C8;
        Sun, 17 Sep 2023 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978431;
        bh=ovFgaXuSXdonpH1bDl0AlOBnBHrmMGEWeiRR2hYvq0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SymcQsC2q8jsD937/hYLRMb2hciI3RuGklsKUm6Cjtxyz07oVg0VxU3GvG6Das+Kr
         aMQg7yPisYOZO/zPQh1THTi3PycxkGP+XXac+AYXVxWD9su61fApSQkUhHmceA/eCI
         DlaM7NGHuDa48ugw/P2oAaOE/oNgiEYKfvC+bcCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/406] scsi: storvsc: Always set no_report_opcodes
Date:   Sun, 17 Sep 2023 21:08:31 +0200
Message-ID: <20230917191102.651005522@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 31d16e712bdcaee769de4780f72ff8d6cd3f0589 ]

Hyper-V synthetic SCSI devices do not support the MAINTENANCE_IN SCSI
command, so scsi_report_opcode() always fails, resulting in messages like
this:

hv_storvsc <guid>: tag#205 cmd 0xa3 status: scsi 0x2 srb 0x86 hv 0xc0000001

The recently added support for command duration limits calls
scsi_report_opcode() four times as each device comes online, which
significantly increases the number of messages logged in a system with many
disks.

Fix the problem by always marking Hyper-V synthetic SCSI devices as not
supporting scsi_report_opcode(). With this setting, the MAINTENANCE_IN SCSI
command is not issued and no messages are logged.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1686343101-18930-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 45d8549623442..37ad5f5256474 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1537,6 +1537,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
-- 
2.40.1



