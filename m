Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D37A7E60
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjITMRm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjITMRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDF18B
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F7C433B8;
        Wed, 20 Sep 2023 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212234;
        bh=2sAsbuqFSL4F8IRQIsEeL/fToNslu1lvID3I2Vo9YBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbUuTkw4DWQud/+L5UhKo6HRAgVKY/4rJMntPOE0MnRIS/I+tmWGazcXDFGZMWBxc
         WQfj2aerBhcIWR+ySZIzIGp/xO0NA4ALoYiFLfDPuoVAAUhQfE039B9ryXFjMFReFT
         eekIfd+435bYSxb2Yi55tZ0oT+yTVZle9IzVdHZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 198/273] scsi: qla2xxx: Turn off noisy message log
Date:   Wed, 20 Sep 2023 13:30:38 +0200
Message-ID: <20230920112852.616476155@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 8ebaa45163a3fedc885c1dc7d43ea987a2f00a06 upstream.

Some consider noisy log as test failure.  Turn off noisy message log.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -518,7 +518,7 @@ static int qla_nvme_post_cmd(struct nvme
 
 	rval = qla2x00_start_nvme_mq(sp);
 	if (rval != QLA_SUCCESS) {
-		ql_log(ql_log_warn, vha, 0x212d,
+		ql_dbg(ql_dbg_io + ql_dbg_verbose, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);


