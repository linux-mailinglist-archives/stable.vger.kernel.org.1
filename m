Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953827A3920
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjIQTpI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbjIQTpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB6D133
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BCC433C7;
        Sun, 17 Sep 2023 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979891;
        bh=mXAz6GYWnI/572aQyrAB2k/eRlBhi32Qsgc6Tgb6OmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIO1QMFHPuYkdPl5X3fST7tsjzestA/w50/LwsHQSQ9NauUzkvjn6VbMSRUbgu79l
         8Op1oXOn14b146wkTbXcPM52ZsqhxQhCoJWdY9yg6HutIGIxzD6SkseG3NYV0lfK7z
         Td72BspcJsn04fFqCg8YAxhmsVS2ktj04uCB/6So=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 011/285] scsi: qla2xxx: Fix session hang in gnl
Date:   Sun, 17 Sep 2023 21:10:11 +0200
Message-ID: <20230917191052.010054047@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 39d22740712c7563a2e18c08f033deeacdaf66e7 upstream.

Connection does not resume after a host reset / chip reset. The cause of
the blockage is due to the FCF_ASYNC_ACTIVE left on. The gnl command was
interrupted by the chip reset. On exiting the command, this flag should be
turn off to allow relogin to reoccur. Clear this flag to prevent blockage.

Cc: stable@vger.kernel.org
Fixes: 17e64648aa47 ("scsi: qla2xxx: Correct fcport flags handling")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1141,7 +1141,7 @@ int qla24xx_async_gnl(struct scsi_qla_ho
 	u16 *mb;
 
 	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
-		return rval;
+		goto done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d9,
 	    "Async-gnlist WWPN %8phC \n", fcport->port_name);
@@ -1195,8 +1195,9 @@ int qla24xx_async_gnl(struct scsi_qla_ho
 done_free_sp:
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	fcport->flags &= ~(FCF_ASYNC_SENT);
 done:
-	fcport->flags &= ~(FCF_ASYNC_ACTIVE | FCF_ASYNC_SENT);
+	fcport->flags &= ~(FCF_ASYNC_ACTIVE);
 	return rval;
 }
 


