Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098C7A3851
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjIQTeX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbjIQTeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:34:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF7D9;
        Sun, 17 Sep 2023 12:33:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27086C433CA;
        Sun, 17 Sep 2023 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979235;
        bh=5GX1ASNRpsL5EjulZoFhuYlzVcQ537kwY9kiqIIJPBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbDzE6I/LtPAwKTfBu8dhtd3jMKnFPwDBANWNMOXuLT2v+JglEQnC7YvTOys4K+94
         T9IWYtz5jvnwCs37/GWzEG1YCerlscIox+eNY+m1ztEG9Lafd6uqwmgdieb7FkXpF7
         966dkAHlT/oeghIcVd53kb9SByzmoTXKO4xI/VrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Saurav Kashyap <skashyap@marvell.com>,
        Rob Evers <revers@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/406] scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
Date:   Sun, 17 Sep 2023 21:11:21 +0200
Message-ID: <20230917191107.168932031@linuxfoundation.org>
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

From: Oleksandr Natalenko <oleksandr@redhat.com>

[ Upstream commit 31b5991a9a91ba97237ac9da509d78eec453ff72 ]

The qedf_dbg_debug_cmd_read() function invokes sprintf() directly on a
__user pointer, which may crash the kernel.

Avoid doing that by using a small on-stack buffer for scnprintf() and then
calling simple_read_from_buffer() which does a proper copy_to_user() call.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Link: https://lore.kernel.org/lkml/20230724120241.40495-1-oleksandr@redhat.com/
Link: https://lore.kernel.org/linux-scsi/20230726101236.11922-1-skashyap@marvell.com/
Cc: Saurav Kashyap <skashyap@marvell.com>
Cc: Rob Evers <revers@redhat.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jozef Bacik <jobacik@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: linux-scsi@vger.kernel.org
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Acked-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Link: https://lore.kernel.org/r/20230731084034.37021-3-oleksandr@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_debugfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 3eb4334ac6a32..1c5716540e465 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -138,15 +138,14 @@ qedf_dbg_debug_cmd_read(struct file *filp, char __user *buffer, size_t count,
 			loff_t *ppos)
 {
 	int cnt;
+	char cbuf[32];
 	struct qedf_dbg_ctx *qedf_dbg =
 				(struct qedf_dbg_ctx *)filp->private_data;
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=0x%x\n", qedf_debug);
-	cnt = sprintf(buffer, "debug mask = 0x%x\n", qedf_debug);
+	cnt = scnprintf(cbuf, sizeof(cbuf), "debug mask = 0x%x\n", qedf_debug);
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
 }
 
 static ssize_t
-- 
2.40.1



