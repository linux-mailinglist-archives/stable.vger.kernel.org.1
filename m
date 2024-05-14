Return-Path: <stable+bounces-45018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27988C555E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FAD1F219CE
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082661E4B0;
	Tue, 14 May 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2Lsuxev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4CF9D4;
	Tue, 14 May 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687844; cv=none; b=X9SabIPv/Z3t+RH5BmT3rJ5SCNGHa3GhSdi8jpfqGu1sPD+63adeUFhnHjucK+VsZQA3mKp5aq3xArbri7RxeuMZP+dMbFKohiR7nHdtF9ucg8CdFeNT34uZyjaXp3YgcRETf6wk/TkJm3bkj2r2kXOiYGxOnItIxEUnp3hsWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687844; c=relaxed/simple;
	bh=vm02U/qkEWLPAQTi0GXrO8JLXVeSTV6xRZ/iNQ/gdY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWfRMPRRiz8Ay8RlVUuzbzZkj5pCux7NMdGs481CGuaPQyHqKf35v+J2WDgeQLrzgw3cIyUxfhln1WUW5AvIWhvTbBjC8b+Sxjw2xptUKHoa8oSFnbestaL8utnex+91RfjG0ifqtxY3kshRHI3Q2AoxgkZnf/oblAlsLpHpn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2Lsuxev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08117C2BD10;
	Tue, 14 May 2024 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687844;
	bh=vm02U/qkEWLPAQTi0GXrO8JLXVeSTV6xRZ/iNQ/gdY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2Lsuxev+IJYzfPMKO9Nl4FPHjNclURqf+Y0hiInkrCaZNEjLgc7MQOpm4sn1E1Jw
	 o7M35G5mDN0OvpJhEcMUH3bEImLhcpMMtceaiyxWIuzuwUTx+7kiEshOtmK8vCqFW5
	 on64qLvYo9wxCEFEnxa0lv0o+DeqOzdm+QvOUZcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jie Wang <wangjie125@huawei.com>,
	Guangbin Huang <huangguangbin2@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 125/168] net: hns3: refactor hclge_cmd_send with new hclge_comm_cmd_send API
Date: Tue, 14 May 2024 12:20:23 +0200
Message-ID: <20240514101011.403558379@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit eaa5607db377a73e639162a459d8b125c6a67bfb ]

This patch firstly uses new hardware description struct hclge_comm_hw as
child member of hclge_hw and deletes the original child memebers of
hclge_hw. All the hclge_hw variables used in PF module is modified
according to the new hclge_hw.

Secondly hclge_cmd_send is refactored to use hclge_comm_cmd_send APIs. The
old functions called by hclge_cmd_send are deleted and hclge_cmd_send is
kept to avoid too many meaningless modifications.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 6639a7b95321 ("net: hns3: change type of numa_node_mask as nodemask_t")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/Makefile  |   7 +-
 .../hisilicon/hns3/hns3pf/hclge_cmd.c         | 311 +++---------------
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  72 +---
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  56 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  10 +-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  11 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |   2 +-
 8 files changed, 100 insertions(+), 373 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index 33e546cef2881..cb3aaf5252d07 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -16,10 +16,13 @@ hns3-objs = hns3_enet.o hns3_ethtool.o hns3_debugfs.o
 hns3-$(CONFIG_HNS3_DCB) += hns3_dcbnl.o
 
 obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
-hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_cmd.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlink.o
+
+hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_cmd.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlink.o \
+		hns3_common/hclge_comm_cmd.o
 
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o
 hclge-objs = hns3pf/hclge_main.o hns3pf/hclge_cmd.o hns3pf/hclge_mdio.o hns3pf/hclge_tm.o \
-		hns3pf/hclge_mbx.o hns3pf/hclge_err.o  hns3pf/hclge_debugfs.o hns3pf/hclge_ptp.o hns3pf/hclge_devlink.o
+		hns3pf/hclge_mbx.o hns3pf/hclge_err.o  hns3pf/hclge_debugfs.o hns3pf/hclge_ptp.o hns3pf/hclge_devlink.o \
+		hns3_common/hclge_comm_cmd.o
 
 hclge-$(CONFIG_HNS3_DCB) += hns3pf/hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 9c2eeaa822944..59dd2283d25bb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -11,46 +11,24 @@
 #include "hnae3.h"
 #include "hclge_main.h"
 
-#define cmq_ring_to_dev(ring)   (&(ring)->dev->pdev->dev)
-
-static int hclge_ring_space(struct hclge_cmq_ring *ring)
-{
-	int ntu = ring->next_to_use;
-	int ntc = ring->next_to_clean;
-	int used = (ntu - ntc + ring->desc_num) % ring->desc_num;
-
-	return ring->desc_num - used - 1;
-}
-
-static int is_valid_csq_clean_head(struct hclge_cmq_ring *ring, int head)
-{
-	int ntu = ring->next_to_use;
-	int ntc = ring->next_to_clean;
-
-	if (ntu > ntc)
-		return head >= ntc && head <= ntu;
-
-	return head >= ntc || head <= ntu;
-}
-
-static int hclge_alloc_cmd_desc(struct hclge_cmq_ring *ring)
+static int hclge_alloc_cmd_desc(struct hclge_comm_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
-	ring->desc = dma_alloc_coherent(cmq_ring_to_dev(ring), size,
-					&ring->desc_dma_addr, GFP_KERNEL);
+	ring->desc = dma_alloc_coherent(&ring->pdev->dev,
+					size, &ring->desc_dma_addr, GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static void hclge_free_cmd_desc(struct hclge_cmq_ring *ring)
+static void hclge_free_cmd_desc(struct hclge_comm_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
 	if (ring->desc) {
-		dma_free_coherent(cmq_ring_to_dev(ring), size,
+		dma_free_coherent(&ring->pdev->dev, size,
 				  ring->desc, ring->desc_dma_addr);
 		ring->desc = NULL;
 	}
@@ -59,12 +37,13 @@ static void hclge_free_cmd_desc(struct hclge_cmq_ring *ring)
 static int hclge_alloc_cmd_queue(struct hclge_dev *hdev, int ring_type)
 {
 	struct hclge_hw *hw = &hdev->hw;
-	struct hclge_cmq_ring *ring =
-		(ring_type == HCLGE_TYPE_CSQ) ? &hw->cmq.csq : &hw->cmq.crq;
+	struct hclge_comm_cmq_ring *ring =
+		(ring_type == HCLGE_TYPE_CSQ) ? &hw->hw.cmq.csq :
+						&hw->hw.cmq.crq;
 	int ret;
 
 	ring->ring_type = ring_type;
-	ring->dev = hdev;
+	ring->pdev = hdev->pdev;
 
 	ret = hclge_alloc_cmd_desc(ring);
 	if (ret) {
@@ -96,11 +75,10 @@ void hclge_cmd_setup_basic_desc(struct hclge_desc *desc,
 		desc->flag |= cpu_to_le16(HCLGE_CMD_FLAG_WR);
 }
 
-static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
+static void hclge_cmd_config_regs(struct hclge_hw *hw,
+				  struct hclge_comm_cmq_ring *ring)
 {
 	dma_addr_t dma = ring->desc_dma_addr;
-	struct hclge_dev *hdev = ring->dev;
-	struct hclge_hw *hw = &hdev->hw;
 	u32 reg_val;
 
 	if (ring->ring_type == HCLGE_TYPE_CSQ) {
@@ -128,176 +106,8 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 
 static void hclge_cmd_init_regs(struct hclge_hw *hw)
 {
-	hclge_cmd_config_regs(&hw->cmq.csq);
-	hclge_cmd_config_regs(&hw->cmq.crq);
-}
-
-static int hclge_cmd_csq_clean(struct hclge_hw *hw)
-{
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	struct hclge_cmq_ring *csq = &hw->cmq.csq;
-	u32 head;
-	int clean;
-
-	head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-	rmb(); /* Make sure head is ready before touch any data */
-
-	if (!is_valid_csq_clean_head(csq, head)) {
-		dev_warn(&hdev->pdev->dev, "wrong cmd head (%u, %d-%d)\n", head,
-			 csq->next_to_use, csq->next_to_clean);
-		dev_warn(&hdev->pdev->dev,
-			 "Disabling any further commands to IMP firmware\n");
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
-		dev_warn(&hdev->pdev->dev,
-			 "IMP firmware watchdog reset soon expected!\n");
-		return -EIO;
-	}
-
-	clean = (head - csq->next_to_clean + csq->desc_num) % csq->desc_num;
-	csq->next_to_clean = head;
-	return clean;
-}
-
-static int hclge_cmd_csq_done(struct hclge_hw *hw)
-{
-	u32 head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-	return head == hw->cmq.csq.next_to_use;
-}
-
-static bool hclge_is_special_opcode(u16 opcode)
-{
-	/* these commands have several descriptors,
-	 * and use the first one to save opcode and return value
-	 */
-	static const u16 spec_opcode[] = {
-		HCLGE_OPC_STATS_64_BIT,
-		HCLGE_OPC_STATS_32_BIT,
-		HCLGE_OPC_STATS_MAC,
-		HCLGE_OPC_STATS_MAC_ALL,
-		HCLGE_OPC_QUERY_32_BIT_REG,
-		HCLGE_OPC_QUERY_64_BIT_REG,
-		HCLGE_QUERY_CLEAR_MPF_RAS_INT,
-		HCLGE_QUERY_CLEAR_PF_RAS_INT,
-		HCLGE_QUERY_CLEAR_ALL_MPF_MSIX_INT,
-		HCLGE_QUERY_CLEAR_ALL_PF_MSIX_INT,
-		HCLGE_QUERY_ALL_ERR_INFO
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(spec_opcode); i++) {
-		if (spec_opcode[i] == opcode)
-			return true;
-	}
-
-	return false;
-}
-
-struct errcode {
-	u32 imp_errcode;
-	int common_errno;
-};
-
-static void hclge_cmd_copy_desc(struct hclge_hw *hw, struct hclge_desc *desc,
-				int num)
-{
-	struct hclge_desc *desc_to_use;
-	int handle = 0;
-
-	while (handle < num) {
-		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
-		*desc_to_use = desc[handle];
-		(hw->cmq.csq.next_to_use)++;
-		if (hw->cmq.csq.next_to_use >= hw->cmq.csq.desc_num)
-			hw->cmq.csq.next_to_use = 0;
-		handle++;
-	}
-}
-
-static int hclge_cmd_convert_err_code(u16 desc_ret)
-{
-	struct errcode hclge_cmd_errcode[] = {
-		{HCLGE_CMD_EXEC_SUCCESS, 0},
-		{HCLGE_CMD_NO_AUTH, -EPERM},
-		{HCLGE_CMD_NOT_SUPPORTED, -EOPNOTSUPP},
-		{HCLGE_CMD_QUEUE_FULL, -EXFULL},
-		{HCLGE_CMD_NEXT_ERR, -ENOSR},
-		{HCLGE_CMD_UNEXE_ERR, -ENOTBLK},
-		{HCLGE_CMD_PARA_ERR, -EINVAL},
-		{HCLGE_CMD_RESULT_ERR, -ERANGE},
-		{HCLGE_CMD_TIMEOUT, -ETIME},
-		{HCLGE_CMD_HILINK_ERR, -ENOLINK},
-		{HCLGE_CMD_QUEUE_ILLEGAL, -ENXIO},
-		{HCLGE_CMD_INVALID, -EBADR},
-	};
-	u32 errcode_count = ARRAY_SIZE(hclge_cmd_errcode);
-	u32 i;
-
-	for (i = 0; i < errcode_count; i++)
-		if (hclge_cmd_errcode[i].imp_errcode == desc_ret)
-			return hclge_cmd_errcode[i].common_errno;
-
-	return -EIO;
-}
-
-static int hclge_cmd_check_retval(struct hclge_hw *hw, struct hclge_desc *desc,
-				  int num, int ntc)
-{
-	u16 opcode, desc_ret;
-	int handle;
-
-	opcode = le16_to_cpu(desc[0].opcode);
-	for (handle = 0; handle < num; handle++) {
-		desc[handle] = hw->cmq.csq.desc[ntc];
-		ntc++;
-		if (ntc >= hw->cmq.csq.desc_num)
-			ntc = 0;
-	}
-	if (likely(!hclge_is_special_opcode(opcode)))
-		desc_ret = le16_to_cpu(desc[num - 1].retval);
-	else
-		desc_ret = le16_to_cpu(desc[0].retval);
-
-	hw->cmq.last_status = desc_ret;
-
-	return hclge_cmd_convert_err_code(desc_ret);
-}
-
-static int hclge_cmd_check_result(struct hclge_hw *hw, struct hclge_desc *desc,
-				  int num, int ntc)
-{
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	bool is_completed = false;
-	u32 timeout = 0;
-	int handle, ret;
-
-	/**
-	 * If the command is sync, wait for the firmware to write back,
-	 * if multi descriptors to be sent, use the first one to check
-	 */
-	if (HCLGE_SEND_SYNC(le16_to_cpu(desc->flag))) {
-		do {
-			if (hclge_cmd_csq_done(hw)) {
-				is_completed = true;
-				break;
-			}
-			udelay(1);
-			timeout++;
-		} while (timeout < hw->cmq.tx_timeout);
-	}
-
-	if (!is_completed)
-		ret = -EBADE;
-	else
-		ret = hclge_cmd_check_retval(hw, desc, num, ntc);
-
-	/* Clean the command send queue */
-	handle = hclge_cmd_csq_clean(hw);
-	if (handle < 0)
-		ret = handle;
-	else if (handle != num)
-		dev_warn(&hdev->pdev->dev,
-			 "cleaned %d, need to clean %d\n", handle, num);
-	return ret;
+	hclge_cmd_config_regs(hw, &hw->hw.cmq.csq);
+	hclge_cmd_config_regs(hw, &hw->hw.cmq.crq);
 }
 
 /**
@@ -311,43 +121,7 @@ static int hclge_cmd_check_result(struct hclge_hw *hw, struct hclge_desc *desc,
  **/
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 {
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	struct hclge_cmq_ring *csq = &hw->cmq.csq;
-	int ret;
-	int ntc;
-
-	spin_lock_bh(&hw->cmq.csq.lock);
-
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
-		spin_unlock_bh(&hw->cmq.csq.lock);
-		return -EBUSY;
-	}
-
-	if (num > hclge_ring_space(&hw->cmq.csq)) {
-		/* If CMDQ ring is full, SW HEAD and HW HEAD may be different,
-		 * need update the SW HEAD pointer csq->next_to_clean
-		 */
-		csq->next_to_clean = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-		spin_unlock_bh(&hw->cmq.csq.lock);
-		return -EBUSY;
-	}
-
-	/**
-	 * Record the location of desc in the ring for this time
-	 * which will be use for hardware to write back
-	 */
-	ntc = hw->cmq.csq.next_to_use;
-
-	hclge_cmd_copy_desc(hw, desc, num);
-
-	/* Write to hardware */
-	hclge_write_dev(hw, HCLGE_NIC_CSQ_TAIL_REG, hw->cmq.csq.next_to_use);
-
-	ret = hclge_cmd_check_result(hw, desc, num, ntc);
-
-	spin_unlock_bh(&hw->cmq.csq.lock);
-
-	return ret;
+	return hclge_comm_cmd_send(&hw->hw, desc, num, true);
 }
 
 static void hclge_set_default_capability(struct hclge_dev *hdev)
@@ -401,7 +175,7 @@ static __le32 hclge_build_api_caps(void)
 	return cpu_to_le32(api_caps);
 }
 
-static enum hclge_cmd_status
+static enum hclge_comm_cmd_status
 hclge_cmd_query_version_and_capability(struct hclge_dev *hdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
@@ -433,18 +207,22 @@ hclge_cmd_query_version_and_capability(struct hclge_dev *hdev)
 
 int hclge_cmd_queue_init(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
 	int ret;
 
 	/* Setup the lock for command queue */
-	spin_lock_init(&hdev->hw.cmq.csq.lock);
-	spin_lock_init(&hdev->hw.cmq.crq.lock);
+	spin_lock_init(&cmdq->csq.lock);
+	spin_lock_init(&cmdq->crq.lock);
+
+	cmdq->csq.pdev = hdev->pdev;
+	cmdq->crq.pdev = hdev->pdev;
 
 	/* Setup the queue entries for use cmd queue */
-	hdev->hw.cmq.csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
-	hdev->hw.cmq.crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
+	cmdq->csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
+	cmdq->crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
 
 	/* Setup Tx write back timeout */
-	hdev->hw.cmq.tx_timeout = HCLGE_CMDQ_TX_TIMEOUT;
+	cmdq->tx_timeout = HCLGE_CMDQ_TX_TIMEOUT;
 
 	/* Setup queue rings */
 	ret = hclge_alloc_cmd_queue(hdev, HCLGE_TYPE_CSQ);
@@ -463,7 +241,7 @@ int hclge_cmd_queue_init(struct hclge_dev *hdev)
 
 	return 0;
 err_csq:
-	hclge_free_cmd_desc(&hdev->hw.cmq.csq);
+	hclge_free_cmd_desc(&hdev->hw.hw.cmq.csq);
 	return ret;
 }
 
@@ -491,22 +269,23 @@ static int hclge_firmware_compat_config(struct hclge_dev *hdev, bool en)
 
 int hclge_cmd_init(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
 	int ret;
 
-	spin_lock_bh(&hdev->hw.cmq.csq.lock);
-	spin_lock(&hdev->hw.cmq.crq.lock);
+	spin_lock_bh(&cmdq->csq.lock);
+	spin_lock(&cmdq->crq.lock);
 
-	hdev->hw.cmq.csq.next_to_clean = 0;
-	hdev->hw.cmq.csq.next_to_use = 0;
-	hdev->hw.cmq.crq.next_to_clean = 0;
-	hdev->hw.cmq.crq.next_to_use = 0;
+	cmdq->csq.next_to_clean = 0;
+	cmdq->csq.next_to_use = 0;
+	cmdq->crq.next_to_clean = 0;
+	cmdq->crq.next_to_use = 0;
 
 	hclge_cmd_init_regs(&hdev->hw);
 
-	spin_unlock(&hdev->hw.cmq.crq.lock);
-	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+	spin_unlock(&cmdq->crq.lock);
+	spin_unlock_bh(&cmdq->csq.lock);
 
-	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	clear_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	/* Check if there is new reset pending, because the higher level
 	 * reset may happen when lower level reset is being processed.
@@ -550,7 +329,7 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	return 0;
 
 err_cmd_init:
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	return ret;
 }
@@ -571,19 +350,23 @@ static void hclge_cmd_uninit_regs(struct hclge_hw *hw)
 
 void hclge_cmd_uninit(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
+
+	cmdq->csq.pdev = hdev->pdev;
+
 	hclge_firmware_compat_config(hdev, false);
 
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 	/* wait to ensure that the firmware completes the possible left
 	 * over commands.
 	 */
 	msleep(HCLGE_CMDQ_CLEAR_WAIT_TIME);
-	spin_lock_bh(&hdev->hw.cmq.csq.lock);
-	spin_lock(&hdev->hw.cmq.crq.lock);
+	spin_lock_bh(&cmdq->csq.lock);
+	spin_lock(&cmdq->crq.lock);
 	hclge_cmd_uninit_regs(&hdev->hw);
-	spin_unlock(&hdev->hw.cmq.crq.lock);
-	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+	spin_unlock(&cmdq->crq.lock);
+	spin_unlock_bh(&cmdq->csq.lock);
 
-	hclge_free_cmd_desc(&hdev->hw.cmq.csq);
-	hclge_free_cmd_desc(&hdev->hw.cmq.crq);
+	hclge_free_cmd_desc(&cmdq->csq);
+	hclge_free_cmd_desc(&cmdq->crq);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e07709ef239df..303a7592bb18d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -11,63 +11,18 @@
 
 #define HCLGE_CMDQ_TX_TIMEOUT		30000
 #define HCLGE_CMDQ_CLEAR_WAIT_TIME	200
-#define HCLGE_DESC_DATA_LEN		6
 
 struct hclge_dev;
 
 #define HCLGE_CMDQ_RX_INVLD_B		0
 #define HCLGE_CMDQ_RX_OUTVLD_B		1
 
-struct hclge_cmq_ring {
-	dma_addr_t desc_dma_addr;
-	struct hclge_desc *desc;
-	struct hclge_dev *dev;
-	u32 head;
-	u32 tail;
-
-	u16 buf_size;
-	u16 desc_num;
-	int next_to_use;
-	int next_to_clean;
-	u8 ring_type; /* cmq ring type */
-	spinlock_t lock; /* Command queue lock */
-};
-
-enum hclge_cmd_return_status {
-	HCLGE_CMD_EXEC_SUCCESS	= 0,
-	HCLGE_CMD_NO_AUTH	= 1,
-	HCLGE_CMD_NOT_SUPPORTED	= 2,
-	HCLGE_CMD_QUEUE_FULL	= 3,
-	HCLGE_CMD_NEXT_ERR	= 4,
-	HCLGE_CMD_UNEXE_ERR	= 5,
-	HCLGE_CMD_PARA_ERR	= 6,
-	HCLGE_CMD_RESULT_ERR	= 7,
-	HCLGE_CMD_TIMEOUT	= 8,
-	HCLGE_CMD_HILINK_ERR	= 9,
-	HCLGE_CMD_QUEUE_ILLEGAL	= 10,
-	HCLGE_CMD_INVALID	= 11,
-};
-
-enum hclge_cmd_status {
-	HCLGE_STATUS_SUCCESS	= 0,
-	HCLGE_ERR_CSQ_FULL	= -1,
-	HCLGE_ERR_CSQ_TIMEOUT	= -2,
-	HCLGE_ERR_CSQ_ERROR	= -3,
-};
-
 struct hclge_misc_vector {
 	u8 __iomem *addr;
 	int vector_irq;
 	char name[HNAE3_INT_NAME_LEN];
 };
 
-struct hclge_cmq {
-	struct hclge_cmq_ring csq;
-	struct hclge_cmq_ring crq;
-	u16 tx_timeout;
-	enum hclge_cmd_status last_status;
-};
-
 #define HCLGE_CMD_FLAG_IN	BIT(0)
 #define HCLGE_CMD_FLAG_OUT	BIT(1)
 #define HCLGE_CMD_FLAG_NEXT	BIT(2)
@@ -1236,25 +1191,6 @@ struct hclge_caps_bit_map {
 };
 
 int hclge_cmd_init(struct hclge_dev *hdev);
-static inline void hclge_write_reg(void __iomem *base, u32 reg, u32 value)
-{
-	writel(value, base + reg);
-}
-
-#define hclge_write_dev(a, reg, value) \
-	hclge_write_reg((a)->io_base, reg, value)
-#define hclge_read_dev(a, reg) \
-	hclge_read_reg((a)->io_base, reg)
-
-static inline u32 hclge_read_reg(u8 __iomem *base, u32 reg)
-{
-	u8 __iomem *reg_addr = READ_ONCE(base);
-
-	return readl(reg_addr + reg);
-}
-
-#define HCLGE_SEND_SYNC(flag) \
-	((flag) & HCLGE_CMD_FLAG_NO_INTR)
 
 struct hclge_hw;
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num);
@@ -1262,10 +1198,10 @@ void hclge_cmd_setup_basic_desc(struct hclge_desc *desc,
 				enum hclge_opcode_type opcode, bool is_read);
 void hclge_cmd_reuse_desc(struct hclge_desc *desc, bool is_read);
 
-enum hclge_cmd_status hclge_cmd_mdio_write(struct hclge_hw *hw,
-					   struct hclge_desc *desc);
-enum hclge_cmd_status hclge_cmd_mdio_read(struct hclge_hw *hw,
-					  struct hclge_desc *desc);
+enum hclge_comm_cmd_status hclge_cmd_mdio_write(struct hclge_hw *hw,
+						struct hclge_desc *desc);
+enum hclge_comm_cmd_status hclge_cmd_mdio_read(struct hclge_hw *hw,
+					       struct hclge_desc *desc);
 
 void hclge_cmd_uninit(struct hclge_dev *hdev);
 int hclge_cmd_queue_init(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 93e55c6c4cf5e..a744ebb72b137 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -24,6 +24,7 @@
 #include "hclge_err.h"
 #include "hnae3.h"
 #include "hclge_devlink.h"
+#include "hclge_comm_cmd.h"
 
 #define HCLGE_NAME			"hclge"
 
@@ -1677,11 +1678,11 @@ static int hclge_alloc_tqps(struct hclge_dev *hdev)
 		 * HCLGE_TQP_MAX_SIZE_DEV_V2
 		 */
 		if (i < HCLGE_TQP_MAX_SIZE_DEV_V2)
-			tqp->q.io_base = hdev->hw.io_base +
+			tqp->q.io_base = hdev->hw.hw.io_base +
 					 HCLGE_TQP_REG_OFFSET +
 					 i * HCLGE_TQP_REG_SIZE;
 		else
-			tqp->q.io_base = hdev->hw.io_base +
+			tqp->q.io_base = hdev->hw.hw.io_base +
 					 HCLGE_TQP_REG_OFFSET +
 					 HCLGE_TQP_EXT_REG_OFFSET +
 					 (i - HCLGE_TQP_MAX_SIZE_DEV_V2) *
@@ -1825,7 +1826,7 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 	nic->pdev = hdev->pdev;
 	nic->ae_algo = &ae_algo;
 	nic->numa_node_mask = hdev->numa_node_mask;
-	nic->kinfo.io_base = hdev->hw.io_base;
+	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
 	ret = hclge_knic_setup(vport, num_tqps,
 			       hdev->num_tx_desc, hdev->num_rx_desc);
@@ -2511,8 +2512,8 @@ static int hclge_init_roce_base_info(struct hclge_vport *vport)
 	roce->rinfo.base_vector = hdev->num_nic_msi;
 
 	roce->rinfo.netdev = nic->kinfo.netdev;
-	roce->rinfo.roce_io_base = hdev->hw.io_base;
-	roce->rinfo.roce_mem_base = hdev->hw.mem_base;
+	roce->rinfo.roce_io_base = hdev->hw.hw.io_base;
+	roce->rinfo.roce_mem_base = hdev->hw.hw.mem_base;
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
@@ -3366,7 +3367,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 	if (BIT(HCLGE_VECTOR0_IMPRESET_INT_B) & msix_src_reg) {
 		dev_info(&hdev->pdev->dev, "IMP reset interrupt\n");
 		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
 		hdev->rst_stats.imp_rst_cnt++;
 		return HCLGE_VECTOR0_EVENT_RST;
@@ -3374,7 +3375,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 
 	if (BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) & msix_src_reg) {
 		dev_info(&hdev->pdev->dev, "global reset interrupt\n");
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		set_bit(HNAE3_GLOBAL_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
 		hdev->rst_stats.global_rst_cnt++;
@@ -3513,7 +3514,7 @@ static void hclge_get_misc_vector(struct hclge_dev *hdev)
 
 	vector->vector_irq = pci_irq_vector(hdev->pdev, 0);
 
-	vector->addr = hdev->hw.io_base + HCLGE_MISC_VECTOR_REG_BASE;
+	vector->addr = hdev->hw.hw.io_base + HCLGE_MISC_VECTOR_REG_BASE;
 	hdev->vector_status[0] = 0;
 
 	hdev->num_msi_left -= 1;
@@ -3697,7 +3698,7 @@ static int hclge_set_all_vf_rst(struct hclge_dev *hdev, bool reset)
 static void hclge_mailbox_service_task(struct hclge_dev *hdev)
 {
 	if (!test_and_clear_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state) ||
-	    test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state) ||
+	    test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state) ||
 	    test_and_set_bit(HCLGE_STATE_MBX_HANDLING, &hdev->state))
 		return;
 
@@ -3944,7 +3945,7 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 		 * any mailbox handling or command to firmware is only valid
 		 * after hclge_cmd_init is called.
 		 */
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		hdev->rst_stats.pf_rst_cnt++;
 		break;
 	case HNAE3_FLR_RESET:
@@ -4498,11 +4499,11 @@ static void hclge_get_vector_info(struct hclge_dev *hdev, u16 idx,
 
 	/* need an extend offset to config vector >= 64 */
 	if (idx - 1 < HCLGE_PF_MAX_VECTOR_NUM_DEV_V2)
-		vector_info->io_addr = hdev->hw.io_base +
+		vector_info->io_addr = hdev->hw.hw.io_base +
 				HCLGE_VECTOR_REG_BASE +
 				(idx - 1) * HCLGE_VECTOR_REG_OFFSET;
 	else
-		vector_info->io_addr = hdev->hw.io_base +
+		vector_info->io_addr = hdev->hw.hw.io_base +
 				HCLGE_VECTOR_EXT_REG_BASE +
 				(idx - 1) / HCLGE_PF_MAX_VECTOR_NUM_DEV_V2 *
 				HCLGE_VECTOR_REG_OFFSET_H +
@@ -5140,7 +5141,7 @@ int hclge_bind_ring_with_vector(struct hclge_vport *vport,
 	struct hclge_desc desc;
 	struct hclge_ctrl_vector_chain_cmd *req =
 		(struct hclge_ctrl_vector_chain_cmd *)desc.data;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	enum hclge_opcode_type op;
 	u16 tqp_type_and_id;
 	int i;
@@ -7666,7 +7667,7 @@ static bool hclge_get_cmdq_stat(struct hnae3_handle *handle)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	return test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	return test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 }
 
 static bool hclge_ae_dev_resetting(struct hnae3_handle *handle)
@@ -8864,7 +8865,7 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	char format_mac_addr[HNAE3_FORMAT_MAC_ADDR_LEN];
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_mac_vlan_tbl_entry_cmd req;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc[3];
 
 	/* mac addr check */
@@ -11450,10 +11451,11 @@ static int hclge_dev_mem_map(struct hclge_dev *hdev)
 	if (!(pci_select_bars(pdev, IORESOURCE_MEM) & BIT(HCLGE_MEM_BAR)))
 		return 0;
 
-	hw->mem_base = devm_ioremap_wc(&pdev->dev,
-				       pci_resource_start(pdev, HCLGE_MEM_BAR),
-				       pci_resource_len(pdev, HCLGE_MEM_BAR));
-	if (!hw->mem_base) {
+	hw->hw.mem_base =
+		devm_ioremap_wc(&pdev->dev,
+				pci_resource_start(pdev, HCLGE_MEM_BAR),
+				pci_resource_len(pdev, HCLGE_MEM_BAR));
+	if (!hw->hw.mem_base) {
 		dev_err(&pdev->dev, "failed to map device memory\n");
 		return -EFAULT;
 	}
@@ -11492,8 +11494,8 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 
 	pci_set_master(pdev);
 	hw = &hdev->hw;
-	hw->io_base = pcim_iomap(pdev, 2, 0);
-	if (!hw->io_base) {
+	hw->hw.io_base = pcim_iomap(pdev, 2, 0);
+	if (!hw->hw.io_base) {
 		dev_err(&pdev->dev, "Can't map configuration register space\n");
 		ret = -ENOMEM;
 		goto err_clr_master;
@@ -11508,7 +11510,7 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 	return 0;
 
 err_unmap_io_base:
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 err_clr_master:
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
@@ -11522,10 +11524,10 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 
-	if (hdev->hw.mem_base)
-		devm_iounmap(&pdev->dev, hdev->hw.mem_base);
+	if (hdev->hw.hw.mem_base)
+		devm_iounmap(&pdev->dev, hdev->hw.hw.mem_base);
 
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_free_irq_vectors(pdev);
 	pci_clear_master(pdev);
 	pci_release_mem_regions(pdev);
@@ -11586,7 +11588,7 @@ static void hclge_reset_prepare_general(struct hnae3_ae_dev *ae_dev,
 
 	/* disable misc vector before reset done */
 	hclge_enable_vector(&hdev->misc_vector, false);
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	if (hdev->reset_type == HNAE3_FLR_RESET)
 		hdev->rst_stats.flr_rst_cnt++;
@@ -11877,7 +11879,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_devlink_uninit:
 	hclge_devlink_uninit(hdev);
 err_pci_uninit:
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 6870ccc9d9eac..4e52a7d96483c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -228,7 +228,6 @@ enum HCLGE_DEV_STATE {
 	HCLGE_STATE_MBX_HANDLING,
 	HCLGE_STATE_ERR_SERVICE_SCHED,
 	HCLGE_STATE_STATISTICS_UPDATING,
-	HCLGE_STATE_CMD_DISABLE,
 	HCLGE_STATE_LINK_UPDATING,
 	HCLGE_STATE_RST_FAIL,
 	HCLGE_STATE_FD_TBL_CHANGED,
@@ -297,11 +296,9 @@ struct hclge_mac {
 };
 
 struct hclge_hw {
-	void __iomem *io_base;
-	void __iomem *mem_base;
+	struct hclge_comm_hw hw;
 	struct hclge_mac mac;
 	int num_vec;
-	struct hclge_cmq cmq;
 };
 
 /* TQP stats */
@@ -616,6 +613,11 @@ struct key_info {
 #define MAX_FD_FILTER_NUM	4096
 #define HCLGE_ARFS_EXPIRE_INTERVAL	5UL
 
+#define hclge_read_dev(a, reg) \
+	hclge_comm_read_reg((a)->hw.io_base, reg)
+#define hclge_write_dev(a, reg, value) \
+	hclge_comm_write_reg((a)->hw.io_base, reg, value)
+
 enum HCLGE_FD_ACTIVE_RULE_TYPE {
 	HCLGE_FD_RULE_NONE,
 	HCLGE_FD_ARFS_ACTIVE,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 1bd3d6056163b..77c432ab7856c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -33,7 +33,7 @@ static int hclge_gen_resp_to_vf(struct hclge_vport *vport,
 {
 	struct hclge_mbx_pf_to_vf_cmd *resp_pf_to_vf;
 	struct hclge_dev *hdev = vport->back;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc;
 	u16 resp;
 
@@ -92,7 +92,7 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 {
 	struct hclge_mbx_pf_to_vf_cmd *resp_pf_to_vf;
 	struct hclge_dev *hdev = vport->back;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc;
 
 	if (msg_len > HCLGE_MBX_MAX_MSG_SIZE) {
@@ -745,7 +745,7 @@ static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
 	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
 
-	return tail == hw->cmq.crq.next_to_use;
+	return tail == hw->hw.cmq.crq.next_to_use;
 }
 
 static void hclge_handle_ncsi_error(struct hclge_dev *hdev)
@@ -1045,7 +1045,7 @@ static void hclge_mbx_request_handling(struct hclge_mbx_ops_param *param)
 
 void hclge_mbx_handler(struct hclge_dev *hdev)
 {
-	struct hclge_cmq_ring *crq = &hdev->hw.cmq.crq;
+	struct hclge_comm_cmq_ring *crq = &hdev->hw.hw.cmq.crq;
 	struct hclge_respond_to_vf_msg resp_msg;
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclge_mbx_ops_param param;
@@ -1055,7 +1055,8 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 	param.resp_msg = &resp_msg;
 	/* handle all the mailbox requests in the queue */
 	while (!hclge_cmd_crq_empty(&hdev->hw)) {
-		if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
+		if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE,
+			     &hdev->hw.hw.comm_state)) {
 			dev_warn(&hdev->pdev->dev,
 				 "command queue needs re-initializing\n");
 			return;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 1231c34f09494..63d2be4349e3e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -47,7 +47,7 @@ static int hclge_mdio_write(struct mii_bus *bus, int phyid, int regnum,
 	struct hclge_desc desc;
 	int ret;
 
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state))
+	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state))
 		return 0;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, false);
@@ -85,7 +85,7 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 	struct hclge_desc desc;
 	int ret;
 
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state))
+	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state))
 		return 0;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, true);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index dd0750f6daa6c..0f06f95b09bc2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -464,7 +464,7 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 	}
 
 	spin_lock_init(&ptp->lock);
-	ptp->io_base = hdev->hw.io_base + HCLGE_PTP_REG_OFFSET;
+	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
 	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
 	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
 	hdev->ptp = ptp;
-- 
2.43.0




