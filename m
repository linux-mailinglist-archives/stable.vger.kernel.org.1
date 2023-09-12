Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9979B2A6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjIKVMQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbjIKOhm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81591CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1F8C433C8;
        Mon, 11 Sep 2023 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443057;
        bh=O2HMr9B7Tv0uu5uAkdYE4TjSMkbILJL/HeoX7RABNwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2GRLtW5penDeXPTuS5wBaDwr6hPgTYAon/o47ebalCUJ1DBX0L8Vk1xFLJU0NvZe8
         0zYEQzWOLMhvu+eoTUED2TCKhqWBtre0onfDZX8wt2mb/1/qJNyTR7unWfOUq+M6fc
         leR2DX2aB9hDU6odaEpXf5LoaL6WvRVmNcUQeLbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 213/737] net: hns3: Support tlv in regs data for HNS3 PF driver
Date:   Mon, 11 Sep 2023 15:41:12 +0200
Message-ID: <20230911134656.542144263@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit d8634b7c3f62d265fc2ecf29286aa9c5b78f969f ]

The dump register function is being refactored.
The second step in refactoring is to support tlv info in regs data for
HNS3 PF driver.

Currently, if we use "ethtool -d" to dump regs value,
the output is as follows:
  offset1: 00 01 02 03 04 05 ...
  offset2：10 11 12 13 14 15 ...
  ......

We can't get the value of a register directly.

This patch deletes the original separator information and
add tag_len_value information in regs data.
ethtool can parse register data in key-value format by -d command.

a patch will be added to the ethtool to parse regs data
in the following format:
  reg1 : value2
  reg2 : value2
  ......

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 36122201eeae ("net: hns3: fix wrong rpu tln reg issue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_regs.c        | 167 +++++++++++-------
 1 file changed, 102 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
index e566443948756..734e5f757b9c5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
@@ -106,12 +106,66 @@ static const enum hclge_opcode_type hclge_dfx_reg_opcode_list[] = {
 	HCLGE_OPC_DFX_SSU_REG_2
 };
 
-#define MAX_SEPARATE_NUM	4
-#define SEPARATOR_VALUE		0xFDFCFBFA
-#define REG_NUM_PER_LINE	4
-#define REG_LEN_PER_LINE	(REG_NUM_PER_LINE * sizeof(u32))
-#define REG_SEPARATOR_LINE	1
-#define REG_NUM_REMAIN_MASK	3
+enum hclge_reg_tag {
+	HCLGE_REG_TAG_CMDQ = 0,
+	HCLGE_REG_TAG_COMMON,
+	HCLGE_REG_TAG_RING,
+	HCLGE_REG_TAG_TQP_INTR,
+	HCLGE_REG_TAG_QUERY_32_BIT,
+	HCLGE_REG_TAG_QUERY_64_BIT,
+	HCLGE_REG_TAG_DFX_BIOS_COMMON,
+	HCLGE_REG_TAG_DFX_SSU_0,
+	HCLGE_REG_TAG_DFX_SSU_1,
+	HCLGE_REG_TAG_DFX_IGU_EGU,
+	HCLGE_REG_TAG_DFX_RPU_0,
+	HCLGE_REG_TAG_DFX_RPU_1,
+	HCLGE_REG_TAG_DFX_NCSI,
+	HCLGE_REG_TAG_DFX_RTC,
+	HCLGE_REG_TAG_DFX_PPP,
+	HCLGE_REG_TAG_DFX_RCB,
+	HCLGE_REG_TAG_DFX_TQP,
+	HCLGE_REG_TAG_DFX_SSU_2,
+};
+
+#pragma pack(4)
+struct hclge_reg_tlv {
+	u16 tag;
+	u16 len;
+};
+
+struct hclge_reg_header {
+	u64 magic_number;
+	u8 is_vf;
+	u8 rsv[7];
+};
+
+#pragma pack()
+
+#define HCLGE_REG_TLV_SIZE	sizeof(struct hclge_reg_tlv)
+#define HCLGE_REG_HEADER_SIZE	sizeof(struct hclge_reg_header)
+#define HCLGE_REG_TLV_SPACE	(sizeof(struct hclge_reg_tlv) / sizeof(u32))
+#define HCLGE_REG_HEADER_SPACE	(sizeof(struct hclge_reg_header) / sizeof(u32))
+#define HCLGE_REG_MAGIC_NUMBER	0x686e733372656773 /* meaning is hns3regs */
+
+static u32 hclge_reg_get_header(void *data)
+{
+	struct hclge_reg_header *header = data;
+
+	header->magic_number = HCLGE_REG_MAGIC_NUMBER;
+	header->is_vf = 0x0;
+
+	return HCLGE_REG_HEADER_SPACE;
+}
+
+static u32 hclge_reg_get_tlv(u32 tag, u32 regs_num, void *data)
+{
+	struct hclge_reg_tlv *tlv = data;
+
+	tlv->tag = tag;
+	tlv->len = regs_num * sizeof(u32) + HCLGE_REG_TLV_SIZE;
+
+	return HCLGE_REG_TLV_SPACE;
+}
 
 static int hclge_get_32_bit_regs(struct hclge_dev *hdev, u32 regs_num,
 				 void *data)
@@ -291,31 +345,28 @@ static int hclge_dfx_reg_cmd_send(struct hclge_dev *hdev,
 static int hclge_dfx_reg_fetch_data(struct hclge_desc *desc_src, int bd_num,
 				    void *data)
 {
-	int entries_per_desc, reg_num, separator_num, desc_index, index, i;
+	int entries_per_desc, reg_num, desc_index, index, i;
 	struct hclge_desc *desc = desc_src;
 	u32 *reg = data;
 
 	entries_per_desc = ARRAY_SIZE(desc->data);
 	reg_num = entries_per_desc * bd_num;
-	separator_num = REG_NUM_PER_LINE - (reg_num & REG_NUM_REMAIN_MASK);
 	for (i = 0; i < reg_num; i++) {
 		index = i % entries_per_desc;
 		desc_index = i / entries_per_desc;
 		*reg++ = le32_to_cpu(desc[desc_index].data[index]);
 	}
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
 
-	return reg_num + separator_num;
+	return reg_num;
 }
 
 static int hclge_get_dfx_reg_len(struct hclge_dev *hdev, int *len)
 {
 	u32 dfx_reg_type_num = ARRAY_SIZE(hclge_dfx_bd_offset_list);
-	int data_len_per_desc, bd_num;
+	int data_len_per_desc;
 	int *bd_num_list;
-	u32 data_len, i;
 	int ret;
+	u32 i;
 
 	bd_num_list = kcalloc(dfx_reg_type_num, sizeof(int), GFP_KERNEL);
 	if (!bd_num_list)
@@ -330,11 +381,8 @@ static int hclge_get_dfx_reg_len(struct hclge_dev *hdev, int *len)
 
 	data_len_per_desc = sizeof_field(struct hclge_desc, data);
 	*len = 0;
-	for (i = 0; i < dfx_reg_type_num; i++) {
-		bd_num = bd_num_list[i];
-		data_len = data_len_per_desc * bd_num;
-		*len += (data_len / REG_LEN_PER_LINE + 1) * REG_LEN_PER_LINE;
-	}
+	for (i = 0; i < dfx_reg_type_num; i++)
+		*len += bd_num_list[i] * data_len_per_desc + HCLGE_REG_TLV_SIZE;
 
 out:
 	kfree(bd_num_list);
@@ -383,6 +431,9 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
 			break;
 		}
 
+		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_DFX_BIOS_COMMON + i,
+					 ARRAY_SIZE(desc_src->data) * bd_num,
+					 reg);
 		reg += hclge_dfx_reg_fetch_data(desc_src, bd_num, reg);
 	}
 
@@ -398,50 +449,43 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
 #define HCLGE_RING_REG_OFFSET		0x200
 #define HCLGE_RING_INT_REG_OFFSET	0x4
 
-	int i, j, reg_num, separator_num;
+	int i, j, reg_num;
 	int data_num_sum;
 	u32 *reg = data;
 
 	/* fetching per-PF registers valus from PF PCIe register space */
 	reg_num = ARRAY_SIZE(cmdq_reg_addr_list);
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
+	reg += hclge_reg_get_tlv(HCLGE_REG_TAG_CMDQ, reg_num, reg);
 	for (i = 0; i < reg_num; i++)
 		*reg++ = hclge_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
-	data_num_sum = reg_num + separator_num;
+	data_num_sum = reg_num + HCLGE_REG_TLV_SPACE;
 
 	reg_num = ARRAY_SIZE(common_reg_addr_list);
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
+	reg += hclge_reg_get_tlv(HCLGE_REG_TAG_COMMON, reg_num, reg);
 	for (i = 0; i < reg_num; i++)
 		*reg++ = hclge_read_dev(&hdev->hw, common_reg_addr_list[i]);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
-	data_num_sum += reg_num + separator_num;
+	data_num_sum += reg_num + HCLGE_REG_TLV_SPACE;
 
 	reg_num = ARRAY_SIZE(ring_reg_addr_list);
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
 	for (j = 0; j < kinfo->num_tqps; j++) {
+		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_RING, reg_num, reg);
 		for (i = 0; i < reg_num; i++)
 			*reg++ = hclge_read_dev(&hdev->hw,
 						ring_reg_addr_list[i] +
 						HCLGE_RING_REG_OFFSET * j);
-		for (i = 0; i < separator_num; i++)
-			*reg++ = SEPARATOR_VALUE;
 	}
-	data_num_sum += (reg_num + separator_num) * kinfo->num_tqps;
+	data_num_sum += (reg_num + HCLGE_REG_TLV_SPACE) * kinfo->num_tqps;
 
 	reg_num = ARRAY_SIZE(tqp_intr_reg_addr_list);
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
 	for (j = 0; j < hdev->num_msi_used - 1; j++) {
+		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_TQP_INTR, reg_num, reg);
 		for (i = 0; i < reg_num; i++)
 			*reg++ = hclge_read_dev(&hdev->hw,
 						tqp_intr_reg_addr_list[i] +
 						HCLGE_RING_INT_REG_OFFSET * j);
-		for (i = 0; i < separator_num; i++)
-			*reg++ = SEPARATOR_VALUE;
 	}
-	data_num_sum += (reg_num + separator_num) * (hdev->num_msi_used - 1);
+	data_num_sum += (reg_num + HCLGE_REG_TLV_SPACE) *
+			(hdev->num_msi_used - 1);
 
 	return data_num_sum;
 }
@@ -473,12 +517,12 @@ static int hclge_get_regs_num(struct hclge_dev *hdev, u32 *regs_num_32_bit,
 
 int hclge_get_regs_len(struct hnae3_handle *handle)
 {
-	int cmdq_lines, common_lines, ring_lines, tqp_intr_lines;
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
 	int regs_num_32_bit, regs_num_64_bit, dfx_regs_len;
-	int regs_lines_32_bit, regs_lines_64_bit;
+	int cmdq_len, common_len, ring_len, tqp_intr_len;
+	int regs_len_32_bit, regs_len_64_bit;
+	struct hclge_dev *hdev = vport->back;
 	int ret;
 
 	ret = hclge_get_regs_num(hdev, &regs_num_32_bit, &regs_num_64_bit);
@@ -495,22 +539,17 @@ int hclge_get_regs_len(struct hnae3_handle *handle)
 		return ret;
 	}
 
-	cmdq_lines = sizeof(cmdq_reg_addr_list) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-	common_lines = sizeof(common_reg_addr_list) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-	ring_lines = sizeof(ring_reg_addr_list) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-	tqp_intr_lines = sizeof(tqp_intr_reg_addr_list) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-	regs_lines_32_bit = regs_num_32_bit * sizeof(u32) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-	regs_lines_64_bit = regs_num_64_bit * sizeof(u64) / REG_LEN_PER_LINE +
-		REG_SEPARATOR_LINE;
-
-	return (cmdq_lines + common_lines + ring_lines * kinfo->num_tqps +
-		tqp_intr_lines * (hdev->num_msi_used - 1) + regs_lines_32_bit +
-		regs_lines_64_bit) * REG_LEN_PER_LINE + dfx_regs_len;
+	cmdq_len = HCLGE_REG_TLV_SIZE + sizeof(cmdq_reg_addr_list);
+	common_len = HCLGE_REG_TLV_SIZE + sizeof(common_reg_addr_list);
+	ring_len = HCLGE_REG_TLV_SIZE + sizeof(ring_reg_addr_list);
+	tqp_intr_len = HCLGE_REG_TLV_SIZE + sizeof(tqp_intr_reg_addr_list);
+	regs_len_32_bit = HCLGE_REG_TLV_SIZE + regs_num_32_bit * sizeof(u32);
+	regs_len_64_bit = HCLGE_REG_TLV_SIZE + regs_num_64_bit * sizeof(u64);
+
+	/* return the total length of all register values */
+	return HCLGE_REG_HEADER_SIZE + cmdq_len + common_len + ring_len *
+		kinfo->num_tqps + tqp_intr_len * (hdev->num_msi_used - 1) +
+		regs_len_32_bit + regs_len_64_bit + dfx_regs_len;
 }
 
 void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
@@ -522,8 +561,8 @@ void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	u32 regs_num_32_bit, regs_num_64_bit;
-	int i, reg_num, separator_num, ret;
 	u32 *reg = data;
+	int ret;
 
 	*version = hdev->fw_version;
 
@@ -534,31 +573,29 @@ void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
 		return;
 	}
 
+	reg += hclge_reg_get_header(reg);
 	reg += hclge_fetch_pf_reg(hdev, reg, kinfo);
 
+	reg += hclge_reg_get_tlv(HCLGE_REG_TAG_QUERY_32_BIT,
+				 regs_num_32_bit, reg);
 	ret = hclge_get_32_bit_regs(hdev, regs_num_32_bit, reg);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Get 32 bit register failed, ret = %d.\n", ret);
 		return;
 	}
-	reg_num = regs_num_32_bit;
-	reg += reg_num;
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
+	reg += regs_num_32_bit;
 
+	reg += hclge_reg_get_tlv(HCLGE_REG_TAG_QUERY_64_BIT,
+				 regs_num_64_bit *
+				 HCLGE_REG_64_BIT_SPACE_MULTIPLE, reg);
 	ret = hclge_get_64_bit_regs(hdev, regs_num_64_bit, reg);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Get 64 bit register failed, ret = %d.\n", ret);
 		return;
 	}
-	reg_num = regs_num_64_bit * HCLGE_REG_64_BIT_SPACE_MULTIPLE;
-	reg += reg_num;
-	separator_num = MAX_SEPARATE_NUM - (reg_num & REG_NUM_REMAIN_MASK);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
+	reg += regs_num_64_bit * HCLGE_REG_64_BIT_SPACE_MULTIPLE;
 
 	ret = hclge_get_dfx_reg(hdev, reg);
 	if (ret)
-- 
2.40.1



