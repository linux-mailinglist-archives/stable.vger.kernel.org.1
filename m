Return-Path: <stable+bounces-43726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACA8C4450
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C31F21D3E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107615442D;
	Mon, 13 May 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4cvrP4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D87153589
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614432; cv=none; b=rlFvVJKIOeUzIvw4nuFAU295wQtH90ZApIIhy2BndlthFvDCUvdPYIPK57UVroLlawf9eBo96TF8mUIdJHB5ylwbpvBj/JyIuTcNZuUpkZLq4jGM7+lzNWoVArMTV4wLSQPPHHv/2FmPP37xSltfbMaOJUgfVGSXwApUu+NJgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614432; c=relaxed/simple;
	bh=dhKcZtPOMWOQA1z6uO6ZHE5TwD0Is3VlDtSO6H9c2Ao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=to7auz3TagMaBjTrsPn7D2Cbk2aGvDROHjXvtCAfRwbBaQH/1CG3BC934PBRSR6IIAFiU3atm18Kiwr0u4tQxLkpj4iechG5v3qGdLyJ9Wvin+8iex07ogEMJGBMbK8Ny/7+XneF1VLaTlfuUOBtVCtjHJ/VBrTyUDqV70q+sU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4cvrP4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1972C4AF0A;
	Mon, 13 May 2024 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614432;
	bh=dhKcZtPOMWOQA1z6uO6ZHE5TwD0Is3VlDtSO6H9c2Ao=;
	h=Subject:To:Cc:From:Date:From;
	b=J4cvrP4Ddd9K8ZxW4mckneYHSLUwXHg0P5GkoxSfvQG0f4jtW6/SOAkNzl0ewcGOt
	 kk3H5qrthT9Lni+V4BfRgw8c3JlYcnh9AiC6Iy1OJkMpwKVxvnd9rwDo9h84Z4z8wC
	 72yUG+qm5QWiMEGFpvZLIwiJkPXyVaV03jdYjxWs=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: add missing firmware sanity checks" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:33:39 +0200
Message-ID: <2024051339-establish-mollusk-f612@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2e4edfa1e2bd821a317e7d006517dcf2f3fac68d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051339-establish-mollusk-f612@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
ecf6b2d95666 ("Bluetooth: btqca: Add support for firmware image with mbn type for WCN6750")
d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
b43ca511178e ("Bluetooth: btqca: Don't modify firmware contents in-place")
c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
eaf19b0c47d1 ("Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x")
c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
99719449a4a6 ("Bluetooth: hci_qca: resolve various warnings")
054ec5e94a46 ("Bluetooth: hci_qca: Remove duplicate power off in proto close")
590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
37aee136f8c4 ("Bluetooth: hci_qca: allow max-speed to be set for QCA9377 devices")
e5d6468fe9d8 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA6390")
77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
8a208b24d770 ("Bluetooth: hci_qca: Make bt_en and susclk not mandatory for QCA Rome")
b63882549b2b ("Bluetooth: btqca: Fix the NVM baudrate tag offcet for wcn3991")
4f9ed5bd63dc ("Bluetooth: hci_qca: Not send vendor pre-shutdown command for QCA Rome")
66cb70513564 ("Bluetooth: hci_qca: Enable clocks required for BT SOC")
ae563183b647 ("Bluetooth: hci_qca: Enable power off/on support during hci down/up for QCA Rome")
5559904ccc08 ("Bluetooth: hci_qca: Add QCA Rome power off support to the qca_power_shutdown()")
5e6d8401ade9 ("Bluetooth: hci_qca: Add qca_power_on() API to support both wcn399x and Rome power up")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e4edfa1e2bd821a317e7d006517dcf2f3fac68d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 30 Apr 2024 19:07:39 +0200
Subject: [PATCH] Bluetooth: qca: add missing firmware sanity checks

Add the missing sanity checks when parsing the firmware files before
downloading them to avoid accessing and corrupting memory beyond the
vmalloced buffer.

Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
Cc: stable@vger.kernel.org	# 4.10
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cfa71708397b..6743b0a79d7a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -268,9 +268,10 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
-static void qca_tlv_check_data(struct hci_dev *hdev,
+static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
-		u8 *fw_data, enum qca_btsoc_type soc_type)
+			       u8 *fw_data, size_t fw_size,
+			       enum qca_btsoc_type soc_type)
 {
 	const u8 *data;
 	u32 type_len;
@@ -286,6 +287,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 
 	switch (config->type) {
 	case ELF_TYPE_PATCH:
+		if (fw_size < 7)
+			return -EINVAL;
+
 		config->dnld_mode = QCA_SKIP_EVT_VSE_CC;
 		config->dnld_type = QCA_SKIP_EVT_VSE_CC;
 
@@ -294,6 +298,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "File version      : 0x%x", fw_data[6]);
 		break;
 	case TLV_TYPE_PATCH:
+		if (fw_size < sizeof(struct tlv_type_hdr) + sizeof(struct tlv_type_patch))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 		type_len = le32_to_cpu(tlv->type_len);
 		tlv_patch = (struct tlv_type_patch *)tlv->data;
@@ -333,6 +340,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		break;
 
 	case TLV_TYPE_NVM:
+		if (fw_size < sizeof(struct tlv_type_hdr))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 
 		type_len = le32_to_cpu(tlv->type_len);
@@ -341,17 +351,26 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
 		BT_DBG("Length\t\t : %d bytes", length);
 
+		if (fw_size < length + (tlv->data - fw_data))
+			return -EINVAL;
+
 		idx = 0;
 		data = tlv->data;
-		while (idx < length) {
+		while (idx < length - sizeof(struct tlv_type_nvm)) {
 			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
 
 			tag_id = le16_to_cpu(tlv_nvm->tag_id);
 			tag_len = le16_to_cpu(tlv_nvm->tag_len);
 
+			if (length < idx + sizeof(struct tlv_type_nvm) + tag_len)
+				return -EINVAL;
+
 			/* Update NVM tags as needed */
 			switch (tag_id) {
 			case EDL_TAG_ID_HCI:
+				if (tag_len < 3)
+					return -EINVAL;
+
 				/* HCI transport layer parameters
 				 * enabling software inband sleep
 				 * onto controller side.
@@ -367,6 +386,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 
 			case EDL_TAG_ID_DEEP_SLEEP:
+				if (tag_len < 1)
+					return -EINVAL;
+
 				/* Sleep enable mask
 				 * enabling deep sleep feature on controller.
 				 */
@@ -375,14 +397,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 			}
 
-			idx += (sizeof(u16) + sizeof(u16) + 8 + tag_len);
+			idx += sizeof(struct tlv_type_nvm) + tag_len;
 		}
 		break;
 
 	default:
 		BT_ERR("Unknown TLV type %d", config->type);
-		break;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
@@ -532,7 +556,9 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
-	qca_tlv_check_data(hdev, config, data, soc_type);
+	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
+	if (ret)
+		return ret;
 
 	segment = data;
 	remain = size;


