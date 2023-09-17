Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6957A3825
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbjIQTbq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbjIQTbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:31:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED6122
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6784EC433C8;
        Sun, 17 Sep 2023 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979091;
        bh=VClQ+zO5a/196HwspQVQE3MI6wH1n1+tmg+6cjF510Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZnnXKYlTu4W6ARi1ldLXnHigTS5iQ3TREB1vwYAGKpALp3YbSLnS+w3ZUZRd0oQV
         0KaIgDgYaBAg9Bz6LOYRgxYfqrlb1RAMolp74Ei7SsYtdnHpXI+hU+2xzIp2JcnfNI
         Dpr4BcjSh6MduK15DnYrd2cvgdzm2hh+yAcE9k8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 211/406] scsi: hisi_sas: Modify v3 HW SATA completion error processing
Date:   Sun, 17 Sep 2023 21:11:05 +0200
Message-ID: <20230917191106.762230583@linuxfoundation.org>
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

[ Upstream commit 7e15334f5d256367fb4c77f4ee0003e1e3d9bf9d ]

If the I/O completion response frame returned by the target device has been
written to the host memory and the err bit in the status field of the
received fis is 1, ts->stat should set to SAS_PROTO_RESPONSE, and this will
let EH analyze and further determine cause of failure.

Link: https://lore.kernel.org/r/1657823002-139010-5-git-send-email-john.garry@huawei.com
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: f5393a5602ca ("scsi: hisi_sas: Fix normally completed I/O analysed as failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 937e4ba46134e..f3b53eb2cbefe 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -467,6 +467,9 @@ struct hisi_sas_err_record_v3 {
 #define RX_DATA_LEN_UNDERFLOW_OFF	6
 #define RX_DATA_LEN_UNDERFLOW_MSK	(1 << RX_DATA_LEN_UNDERFLOW_OFF)
 
+#define RX_FIS_STATUS_ERR_OFF		0
+#define RX_FIS_STATUS_ERR_MSK		(1 << RX_FIS_STATUS_ERR_OFF)
+
 #define HISI_SAS_COMMAND_ENTRIES_V3_HW 4096
 #define HISI_SAS_MSI_COUNT_V3_HW 32
 
@@ -2130,6 +2133,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			hisi_sas_status_buf_addr_mem(slot);
 	u32 dma_rx_err_type = le32_to_cpu(record->dma_rx_err_type);
 	u32 trans_tx_fail_type = le32_to_cpu(record->trans_tx_fail_type);
+	u16 sipc_rx_err_type = le16_to_cpu(record->sipc_rx_err_type);
 	u32 dw3 = le32_to_cpu(complete_hdr->dw3);
 
 	switch (task->task_proto) {
@@ -2157,7 +2161,10 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
+		if ((complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
+		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
+			ts->stat = SAS_PROTO_RESPONSE;
+		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
 		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
-- 
2.40.1



