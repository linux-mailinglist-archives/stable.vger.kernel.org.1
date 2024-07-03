Return-Path: <stable+bounces-57593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B238925D23
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF631C20AB0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26D17B51B;
	Wed,  3 Jul 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK8uhV7x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296861FE7;
	Wed,  3 Jul 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005352; cv=none; b=o3h451cE+XZTZ8Tg+UOHOFttPseXMIH0SHucQn6Qm5iCz0qN3o1+r9zCC+g0zOYH7WeP2V9NiHcp1LyilYupQYKR/hqK/fs7UvNIL2PQDtGcAZHJ4qmVbXbHX5BKbev0jBViUL0RvvqHVOAk5Dk6UBbOSpe8ckUeSYxkN72qjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005352; c=relaxed/simple;
	bh=TPQmXlpJ7U14+Ig0Hfipel4fRK1UJQZdbR5eThOWIaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+Tvp3G12ROYoDT+2jOwplaW4m3dzw5WgjOUJGMUexhsID9EfJtE1Q3zmxzTgN7saGj+ZdBgY2P0iFygcW3uaLVlLHWpq8xlcJEtj3ChRoIScvPmNwt0AIUuXo+6BHN3k8+F6IpzWZBbP6eQ/6EmFT9GPYiK2/sNCd218EwmgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK8uhV7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5EBC2BD10;
	Wed,  3 Jul 2024 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005352;
	bh=TPQmXlpJ7U14+Ig0Hfipel4fRK1UJQZdbR5eThOWIaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK8uhV7x+RJ7Ree70XLzg3J9ZhcxKr5MdzYiLqvrlvxUi6oAUtDT7pg71Zd5XC+W6
	 9Ni0ablYxQVHJwyyqCw/8ZJsv3TsLXPQVZ1vwWoWvh8iJp/TuYYzb+A0+b7qrXYTPB
	 DcCPqvzZ7hIdc7r58xVB1eGIooPuV/C4TqmBb++0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Jiang <quic_tjiang@quicinc.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/356] Bluetooth: qca: add support for QCA2066
Date: Wed,  3 Jul 2024 12:36:29 +0200
Message-ID: <20240703102915.101832538@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Tim Jiang <quic_tjiang@quicinc.com>

[ Upstream commit a7f8dedb4be2cc930a29af24427b885405ecd15d ]

This patch adds support for QCA2066 firmware patch and NVM downloading.
as the RF performance of QCA2066 SOC chip from different foundries may
vary. Therefore we use different NVM to configure them based on board ID.

Changes in v2
 - optimize the function qca_generate_hsp_nvm_name
 - remove redundant debug code for function qca_read_fw_board_id

Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: cda0d6a198e2 ("Bluetooth: qca: fix info leak when fetching fw build id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqca.c   | 68 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h   |  5 ++-
 drivers/bluetooth/hci_qca.c | 11 ++++++
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b14201b7bcd04..abd621d224667 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -160,6 +160,44 @@ static int qca_send_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
+{
+	u8 cmd;
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	int err = 0;
+
+	cmd = EDL_GET_BID_REQ_CMD;
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
+				&cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
+		return err;
+	}
+
+	edl = skb_pull_data(skb, sizeof(*edl));
+	if (!edl) {
+		bt_dev_err(hdev, "QCA read board ID with no header");
+		err = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_GET_BID_REQ_CMD) {
+		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
+		err = -EIO;
+		goto out;
+	}
+
+	*bid = (edl->data[1] << 8) + edl->data[2];
+	bt_dev_dbg(hdev, "%s: bid = %x", __func__, *bid);
+
+out:
+	kfree_skb(skb);
+	return err;
+}
+
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -575,6 +613,23 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
+		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
+{
+	const char *variant;
+
+	/* hsp gf chip */
+	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0)
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
+	else
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
+}
+
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
@@ -583,6 +638,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
+	u16 boardid = 0;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -613,6 +669,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/apbtfw%02x.tlv", rom_ver);
 		break;
+	case QCA_QCA2066:
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
+		break;
 	case QCA_QCA6390:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
@@ -643,6 +703,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
+	if (soc_type == QCA_QCA2066)
+		qca_read_fw_board_id(hdev, &boardid);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
@@ -665,6 +728,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
+		case QCA_QCA2066:
+			qca_generate_hsp_nvm_name(config.fwname,
+				sizeof(config.fwname), ver, rom_ver, boardid);
+			break;
 		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/htnv%02x.bin", rom_ver);
@@ -692,6 +759,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	switch (soc_type) {
 	case QCA_WCN3991:
+	case QCA_QCA2066:
 	case QCA_QCA6390:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index fa77c07daecf5..d69ecfdef2a20 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -12,6 +12,7 @@
 #define EDL_PATCH_VER_REQ_CMD		(0x19)
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
 #define EDL_GET_BUILD_INFO_CMD		(0x20)
+#define EDL_GET_BID_REQ_CMD			(0x23)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
 #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
@@ -45,7 +46,8 @@
 	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
 
 #define QCA_FW_BUILD_VER_LEN		255
-
+#define QCA_HSP_GF_SOC_ID			0x1200
+#define QCA_HSP_GF_SOC_MASK			0x0000ff00
 
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
@@ -144,6 +146,7 @@ enum qca_btsoc_type {
 	QCA_WCN3990,
 	QCA_WCN3998,
 	QCA_WCN3991,
+	QCA_QCA2066,
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 62491e7610384..0800f6e62b7f0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1801,6 +1801,10 @@ static int qca_setup(struct hci_uart *hu)
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
 	switch (soc_type) {
+	case QCA_QCA2066:
+		soc_name = "qca2066";
+		break;
+
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -1981,6 +1985,11 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.num_vregs = 4,
 };
 
+static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
+	.soc_type = QCA_QCA2066,
+	.num_vregs = 0,
+};
+
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
@@ -2492,6 +2501,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id qca_bluetooth_of_match[] = {
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
@@ -2508,6 +2518,7 @@ MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
+	{ "QCOM2066", (kernel_ulong_t)&qca_soc_data_qca2066 },
 	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
 	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
 	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
-- 
2.43.0




