Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB87A3821
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbjIQTbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjIQTbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:31:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D4D119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41265C433C8;
        Sun, 17 Sep 2023 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979078;
        bh=kD7D9ArMiE/oft0ZoRUzTEBKdBqBUhK7s66gG8dXOho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vn1DW6DGJ4RcJdw4Ut1faqUBs/BjYHUB+aOpbkJlVD5Z4A5hDTQ7yN+CyxD8LwCgt
         CwVufteCm9QyBW+Wh963kpASj6Y117bB7hinQyqB4HIfcRhDeUqjYexkO+7Q1AaY2d
         feql9pjuX638aWv1Mv/ayTDO8dDBODPfZKoaN4+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 208/406] scsi: hisi_sas: Print SAS address for v3 hw erroneous completion print
Date:   Sun, 17 Sep 2023 21:11:02 +0200
Message-ID: <20230917191106.680918938@linuxfoundation.org>
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

From: Luo Jiaxing <luojiaxing@huawei.com>

[ Upstream commit 4da0b7f6fac331f2d2336df3ca88a335f545b4dc ]

To help debugging efforts, print the device SAS address for v3 hw erroneous
completion log.

Here is an example print:

hisi_sas_v3_hw 0000:b4:02.0: erroneous completion iptt=2193 task=000000002b0c13f8 dev id=17 addr=570fd45f9d17b001

Link: https://lore.kernel.org/r/1617709711-195853-3-git-send-email-john.garry@huawei.com
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: f5393a5602ca ("scsi: hisi_sas: Fix normally completed I/O analysed as failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 65971bd80186b..e025855609336 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2240,8 +2240,9 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 
 		slot_err_v3_hw(hisi_hba, task, slot);
 		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
+			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d addr=%016llx CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
 				 slot->idx, task, sas_dev->device_id,
+				 SAS_ADDR(device->sas_addr),
 				 dw0, dw1, complete_hdr->act, dw3,
 				 error_info[0], error_info[1],
 				 error_info[2], error_info[3]);
-- 
2.40.1



