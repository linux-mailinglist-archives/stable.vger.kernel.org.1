Return-Path: <stable+bounces-36001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD1899537
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DB1C214D1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E12232B;
	Fri,  5 Apr 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udgZA9tM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F53D76
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298277; cv=none; b=fob4+aZ4w83dfTZBkYEXpy3yzisLbapbq0bMrF7/q5rJP4su8D0D014p8cNmjP3h5wqNB5LTXhNy/PyjggGQB5BLgX6NIeqTUZluqglXyJshkT6aroSYh/iOkf/TXGzq7GlOLuMDuRPVtFE2bj47yZHg5gaGSNDUHCpwo/InLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298277; c=relaxed/simple;
	bh=38KAxGAcBodZcX5Bh6++yuLK7IDb1s8tLQm+ZDjjiPM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sKX8evu4SXjvR17gAEzBuKIyNNslDalWETvGC17tbGRr+RpCW8+GaC5b30yBV7l79YY6QU7BMQb0onjCPjASLpFzmiSXBEinnWFTcO4z43YalAEzaNOR3hyhL43848ruaGZ2d3HX0TPXpwPzGVr0a4UVkxF061uQ4twUwmF8abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=udgZA9tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419CCC433C7;
	Fri,  5 Apr 2024 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298276;
	bh=38KAxGAcBodZcX5Bh6++yuLK7IDb1s8tLQm+ZDjjiPM=;
	h=Subject:To:Cc:From:Date:From;
	b=udgZA9tMoZLcxwiY3EDDd+7YIULLVx1RgdulcbLSim0Yo02FqiF2fnbXcmmqV9Hya
	 b/QQhEeYcj41nFeENTUh9+VpnJh3xRan3uGGFbuXwwFyyOtwAaaziPf/GRw8ZdrkBu
	 2WNrY5ZbTlmW5a3+iXkV/CtQKkDUv1hBDx9GpZvQ=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix device-address endianness" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,luiz.von.dentz@intel.com,mka@chromium.org,nikita@trvn.ru,quic_bgodavar@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:24:33 +0200
Message-ID: <2024040532-revolt-overreact-690a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 77f45cca8bc55d00520a192f5a7715133591c83e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040532-revolt-overreact-690a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77f45cca8bc55d00520a192f5a7715133591c83e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 20 Mar 2024 08:55:54 +0100
Subject: [PATCH] Bluetooth: qca: fix device-address endianness

The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
device address in big-endian order when setting it using the
EDL_WRITE_BD_ADDR_OPCODE command.

Presumably, this is the case for all non-ROME devices which all use the
EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
use a different command and expect the address in little-endian order).

Reverse the little-endian address before setting it to make sure that
the address can be configured using tools like btmgmt or using the
'local-bd-address' devicetree property.

Note that this can potentially break systems with boot firmware which
has started relying on the broken behaviour and is incorrectly passing
the address via devicetree in big-endian order.

The only device affected by this should be the WCN3991 used in some
Chromebooks. As ChromeOS updates the kernel and devicetree in lockstep,
the new 'qcom,local-bd-address-broken' property can be used to determine
if the firmware is buggy so that the underlying driver bug can be fixed
without breaking backwards compatibility.

Set the HCI_QUIRK_BDADDR_PROPERTY_BROKEN quirk for such platforms so
that the address is reversed when parsing the address property.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b40b32fa7f1c..19cfc342fc7b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -826,11 +826,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
-				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	baswap(&bdaddr_swapped, bdaddr);
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
+				&bdaddr_swapped, HCI_EV_VENDOR,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4ecbcb1644cc..ecbc52eaf101 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -225,6 +225,7 @@ struct qca_serdev {
 	struct qca_power *bt_power;
 	u32 init_speed;
 	u32 oper_speed;
+	bool bdaddr_property_broken;
 	const char *firmware_name;
 };
 
@@ -1842,6 +1843,7 @@ static int qca_setup(struct hci_uart *hu)
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
+	struct qca_serdev *qcadev;
 	const char *soc_name;
 
 	ret = qca_check_speeds(hu);
@@ -1904,6 +1906,11 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->bdaddr_property_broken)
+			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
@@ -2284,6 +2291,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
+	qcadev->bdaddr_property_broken = device_property_read_bool(&serdev->dev,
+			"qcom,local-bd-address-broken");
+
 	if (data)
 		qcadev->btsoc_type = data->soc_type;
 	else


