Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63D79ACC4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjIKVTJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbjIKOPN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779ADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A7C433C7;
        Mon, 11 Sep 2023 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441708;
        bh=8QpAyrumpHXhrt+HTRxTuiPNqaUOXHA0b36GtoVTQhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USib0tradcJSQKbRuy08EEV7zZ2qjxU49hpRwR7syQb6nhiDFzZ6k7IfhswA3fPzZ
         hjWIZJxO9iZfveIKMi1KV3/9slbOL3skH634A6mpXyvFcaBq/VIVGoc76R2GGWiTLL
         j+49qNF5NS8Ne+iVsEjgoMTRv/uHeJi40azuQg5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Chan <michael.chan@broadcom.com>,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 509/739] bnxt_en: Update HW interface headers
Date:   Mon, 11 Sep 2023 15:45:08 +0200
Message-ID: <20230911134705.345979272@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

[ Upstream commit cf1694f09894e760f4e2cf068ee6519d11cd0ede ]

Updating the HW structures for the doorbell pacing related
information. Newly added interface structures will be used in
the followup patches.

Link: https://lore.kernel.org/r/1689742977-9128-2-git-send-email-selvin.xavier@broadcom.com
CC: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: f19fba1f79dc ("RDMA/bnxt_re: Fix max_qp count for virtual functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index b31de4cf6534b..a2d3a80236c4f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -3721,6 +3721,60 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	u8	valid;
 };
 
+/* hwrm_func_dbr_pacing_qcfg_input (size:128b/16B) */
+struct hwrm_func_dbr_pacing_qcfg_input {
+	__le16  req_type;
+	__le16  cmpl_ring;
+	__le16  seq_id;
+	__le16  target_id;
+	__le64  resp_addr;
+};
+
+/* hwrm_func_dbr_pacing_qcfg_output (size:512b/64B) */
+struct hwrm_func_dbr_pacing_qcfg_output {
+	__le16  error_code;
+	__le16  req_type;
+	__le16  seq_id;
+	__le16  resp_len;
+	u8      flags;
+#define FUNC_DBR_PACING_QCFG_RESP_FLAGS_DBR_NQ_EVENT_ENABLED     0x1UL
+	u8      unused_0[7];
+	__le32  dbr_stat_db_fifo_reg;
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK    0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_SFT     0
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC       0x1UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR0      0x2UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1      0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_LAST     \
+		FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_MASK          0xfffffffcUL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SFT           2
+	__le32  dbr_stat_db_fifo_reg_watermark_mask;
+	u8      dbr_stat_db_fifo_reg_watermark_shift;
+	u8      unused_1[3];
+	__le32  dbr_stat_db_fifo_reg_fifo_room_mask;
+	u8      dbr_stat_db_fifo_reg_fifo_room_shift;
+	u8      unused_2[3];
+	__le32  dbr_throttling_aeq_arm_reg;
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_MASK    0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_SFT     0
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_GRC       0x1UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR0      0x2UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1      0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_LAST	\
+		FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_MASK          0xfffffffcUL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SFT           2
+	u8      dbr_throttling_aeq_arm_reg_val;
+	u8      unused_3[7];
+	__le32  primary_nq_id;
+	__le32  pacing_threshold;
+	u8      unused_4[7];
+	u8      valid;
+};
+
 /* hwrm_func_drv_if_change_input (size:192b/24B) */
 struct hwrm_func_drv_if_change_input {
 	__le16	req_type;
-- 
2.40.1



