Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFB7A3828
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjIQTcO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbjIQTbn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882D129
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD329C433C7;
        Sun, 17 Sep 2023 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979095;
        bh=CiFSRwtOJvJW8zB4xGB0BPmh5m2H9Sa3NhfpRFopsuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Al+XMp8uYUoJrpMpo+wyED1PusMuIk6B39qwAqLlxqNcAesYERUxain2EXEj+hr7y
         v9rv55M/csLY9kZ5yzsYs3qctozf58xXfRmcL4Ywj5X3iNY/1auZ0EyvHGucnyQBCk
         dZzAcPqP1srP4FFFpw+0rBB79P4iN3RuzDVCaiY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 212/406] scsi: hisi_sas: Fix warnings detected by sparse
Date:   Sun, 17 Sep 2023 21:11:06 +0200
Message-ID: <20230917191106.786571621@linuxfoundation.org>
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

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit c0328cc595124579328462fc45d7a29a084cf357 ]

This patch fixes the following warning:

drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2168:43: sparse: sparse: restricted __le32 degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304161254.NztCVZIO-lkp@intel.com/
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1684118481-95908-4-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: f5393a5602ca ("scsi: hisi_sas: Fix normally completed I/O analysed as failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index f3b53eb2cbefe..0aea82a1205bd 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2135,6 +2135,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	u32 trans_tx_fail_type = le32_to_cpu(record->trans_tx_fail_type);
 	u16 sipc_rx_err_type = le16_to_cpu(record->sipc_rx_err_type);
 	u32 dw3 = le32_to_cpu(complete_hdr->dw3);
+	u32 dw0 = le32_to_cpu(complete_hdr->dw0);
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
@@ -2144,8 +2145,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			 * but I/O information has been written to the host memory, we examine
 			 * response IU.
 			 */
-			if (!(complete_hdr->dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
-				(complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
+			if (!(dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
+			    (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
 				return false;
 
 			ts->residual = trans_tx_fail_type;
@@ -2161,7 +2162,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		if ((complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
+		if ((dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
 		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
 			ts->stat = SAS_PROTO_RESPONSE;
 		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
-- 
2.40.1



