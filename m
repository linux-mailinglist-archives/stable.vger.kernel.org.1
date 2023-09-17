Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84F7A3A68
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbjIQUDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjIQUCw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:02:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D21AC
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:02:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5A2C433CC;
        Sun, 17 Sep 2023 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980940;
        bh=97eQxU2/CPhj49e/Ihl5fJxv5iqhT8EYavOOSrb1zkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5Zmf6YRJbItx0b0a+PHwGg9yXtpwVd82EqpOoz7FCEaZNkdJeAGPlkZkpQIl10EJ
         BOG16Zo3nyfPiYPlAnwucYwKVq2PqkDR8HpQ2gPQQ3rHdbg+dXJnnCr5CAshpEAl1i
         JzVjdtWIDR6HaNOrMsfwZZ7yqu9YRxzsoSuJY+WQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 023/219] scsi: qla2xxx: Error code did not return to upper layer
Date:   Sun, 17 Sep 2023 21:12:30 +0200
Message-ID: <20230917191041.832254254@linuxfoundation.org>
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

commit 0ba0b018f94525a6b32f5930f980ce9b62b72e6f upstream.

TMF was returned with an error code. The error code was not preserved to be
returned to upper layer. Instead, the error code from the Marker was
returned.

Preserve error code from TMF and return it to upper layer.

Cc: stable@vger.kernel.org
Fixes: da7c21b72aa8 ("scsi: qla2xxx: Fix command flush during TMF")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230821130045.34850-6-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2224,6 +2224,8 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 			rval = QLA_FUNCTION_FAILED;
 		}
 	}
+	if (tm_iocb->u.tmf.data)
+		rval = tm_iocb->u.tmf.data;
 
 done_free_sp:
 	/* ref: INIT */


