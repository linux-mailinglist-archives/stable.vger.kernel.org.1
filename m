Return-Path: <stable+bounces-41639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269358B5667
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDFAB240C4
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06333EA8C;
	Mon, 29 Apr 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pju7s2vf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F91EB2F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389778; cv=none; b=pCp6EmYC876OZSIq4IYT3ogqCUYoNLzJA5wTlauxEMqkUYfVjzRopepJtDbGzOCPMyTeIISfpx6SJbiyyK1naIk/wQ2Zkt3EM13AZC159AVCEV29k4U0jhPre5VIl+4AS99AmNzGqg359rqaF4PWzfPZXjFt0bwMJjs+54xd3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389778; c=relaxed/simple;
	bh=n8ZNvPVOOvBQgsQb2mnZTnIu9gJeFupM5GPdxk4NRgg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dC56g59xJxTt0dJULE9RT5suH9CYmbPhT1Y7qSm/8rDAUzWq5uVmlD3lAVr5iACU81mfyz7gyiYyjVtEB6oKD2EJnkyE2nnxn1qBlJKbw/p3xZWfAYSHFk0a2TSd5jnUfErWoZqiNUxubVCXppoIb98k+0u8VGvU1nJRm4r207w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pju7s2vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7730C113CD;
	Mon, 29 Apr 2024 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389778;
	bh=n8ZNvPVOOvBQgsQb2mnZTnIu9gJeFupM5GPdxk4NRgg=;
	h=Subject:To:Cc:From:Date:From;
	b=Pju7s2vf+Jo8PTTkAzbapq8g9ZLK7XB7pv6d4caREgz/CuRKdwr4yFvIlStkxlN1L
	 NuP4nU02FP/Znwg+OkaglMBDeiaykRc64GQ/Gr7aSpsVYW18UWs4HYuR0wkdkAxpi6
	 ay3pFW7UeSvVGmrxmJezuEn04G8Un1qDTShkxNtA=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix invalid device address check" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com,mka@chromium.org,quic_janathot@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:22:55 +0200
Message-ID: <2024042954-refract-eraser-aaf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 32868e126c78876a8a5ddfcb6ac8cb2fffcf4d27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042954-refract-eraser-aaf8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

32868e126c78 ("Bluetooth: qca: fix invalid device address check")
77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
4790a73ace86 ("Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"")
7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
a7f8dedb4be2 ("Bluetooth: qca: add support for QCA2066")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32868e126c78876a8a5ddfcb6ac8cb2fffcf4d27 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 16 Apr 2024 11:15:09 +0200
Subject: [PATCH] Bluetooth: qca: fix invalid device address check

Qualcomm Bluetooth controllers may not have been provisioned with a
valid device address and instead end up using the default address
00:00:00:00:5a:ad.

This was previously believed to be due to lack of persistent storage for
the address but it may also be due to integrators opting to not use the
on-chip OTP memory and instead store the address elsewhere (e.g. in
storage managed by secure world firmware).

According to Qualcomm, at least WCN6750, WCN6855 and WCN7850 have
on-chip OTP storage for the address.

As the device type alone cannot be used to determine when the address is
valid, instead read back the address during setup() and only set the
HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.

This specifically makes sure that controllers that have been provisioned
with an address do not start as unconfigured.

Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com/
Fixes: 5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990")
Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Cc: stable@vger.kernel.org	# 6.5
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 19cfc342fc7b..216826c31ee3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -15,6 +15,8 @@
 
 #define VERSION "0.1"
 
+#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
+
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
 {
@@ -612,6 +614,38 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static int qca_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+	int err;
+
+	if (bacmp(&hdev->public_addr, BDADDR_ANY))
+		return 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to read device address (%d)", err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		bt_dev_err(hdev, "Device address length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
@@ -818,6 +852,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		break;
 	}
 
+	err = qca_check_bdaddr(hdev);
+	if (err)
+		return err;
+
 	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ecbc52eaf101..92fa20f5ac7d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1905,8 +1905,6 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bdaddr_property_broken)
 			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);


