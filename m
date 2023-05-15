Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23A703A68
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbjEORvD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbjEORuh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883919F26
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B3B62F15
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1F0C433D2;
        Mon, 15 May 2023 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172916;
        bh=PSavEM0hONhibW0g8tmqP9xvzFqKdpDosKygm/X3IIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbIFYuVjjHACqG5YHSRmRLuoeyad4krtruFAPX7WFU+35dt5iRKCviZkf/lGWoQCr
         9Xlks/h/srvXbP0KxnlDs51Z8sdprrfFKm8QVPoAz8xp6cuyUZX7OWEnxcl7HpHAmh
         Ys+ImAGBAH+AbUh/c5QfagN807jCTLA618kraZMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 308/381] scsi: qedi: Fix use after free bug in qedi_remove()
Date:   Mon, 15 May 2023 18:29:19 +0200
Message-Id: <20230515161750.754439457@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit c5749639f2d0a1f6cbe187d05f70c2e7c544d748 ]

In qedi_probe() we call __qedi_probe() which initializes
&qedi->recovery_work with qedi_recovery_handler() and
&qedi->board_disable_work with qedi_board_disable_work().

When qedi_schedule_recovery_handler() is called, schedule_delayed_work()
will finally start the work.

In qedi_remove(), which is called to remove the driver, the following
sequence may be observed:

Fix this by finishing the work before cleanup in qedi_remove().

CPU0                  CPU1

                     |qedi_recovery_handler
qedi_remove          |
  __qedi_remove      |
iscsi_host_free      |
scsi_host_put        |
//free shost         |
                     |iscsi_host_for_each_session
                     |//use qedi->shost

Cancel recovery_work and board_disable_work in __qedi_remove().

Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Link: https://lore.kernel.org/r/20230413033422.28003-1-zyytlz.wz@163.com
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 299d0369e4f08..7df0106f132ee 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2456,6 +2456,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
-- 
2.39.2



