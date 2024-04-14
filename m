Return-Path: <stable+bounces-39385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79358A42AB
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA28B20DEB
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB792446AF;
	Sun, 14 Apr 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="raENZvBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A723328DB
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713102003; cv=none; b=oXQrTS5zLL8VoPTHCC4tyXiXfTSmAZ49o7zHLiVeapL7C2FYnAoiC/x40XPCNQLAZMo4S7jQXIpwWI5rKi+nm3bhWRtxehGl3B5nm0S6bNzg9REdCSXVcwzfa5PJmMuldTXY0FyP+TRPbd5I5QXH8uHAVM0YkxJRl/vwFO/hGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713102003; c=relaxed/simple;
	bh=lRYfP0mBegB3eA1tz61hlY4wECY6X9lAuGdFhrdpDWA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XRiGdB1EPE742k772/83OBuGXdTNibA5q+YvGXHNEBXB71c5N5NYNn8BGQJ02h5Q4bnzMzSb7KX4uiKKL1O4Q+wzpKZ4NGnojk3i0mXQ32BnZqWrP6W8GB/NAQekRV5JPOv8pttosaWDJe33IIxbnEJ8vdOCWYXGkxj+8CV7FOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=raENZvBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC0C072AA;
	Sun, 14 Apr 2024 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713102002;
	bh=lRYfP0mBegB3eA1tz61hlY4wECY6X9lAuGdFhrdpDWA=;
	h=Subject:To:Cc:From:Date:From;
	b=raENZvBHIeeDLDUSsFesEjmwNSk5iiX8SHnqPhOgrLh772gUi8I2b5fAZ+ho6081X
	 2gFR71R4SCsNwBtR8rGH8DdhlrFoHeCOUteH+eLD3/9910SzQbLkUmdV1sv9JUWQ/q
	 EwVSq67XLIeoMLiCWSUFnKXB+rVOhLe4RS34LsmU=
Subject: FAILED: patch "[PATCH] r8169: fix LED-related deadlock on module removal" failed to apply to 6.8-stable tree
To: hkallweit1@gmail.com,andrew@lunn.ch,davem@davemloft.net,lukas@wunner.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Apr 2024 15:39:59 +0200
Message-ID: <2024041459-lagging-tiny-7189@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 19fa4f2a85d777a8052e869c1b892a2f7556569d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041459-lagging-tiny-7189@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
be51ed104ba9 ("r8169: add LED support for RTL8125/RTL8126")
3907f1ffc0ec ("r8169: add support for RTL8126A")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19fa4f2a85d777a8052e869c1b892a2f7556569d Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 8 Apr 2024 20:47:40 +0200
Subject: [PATCH] r8169: fix LED-related deadlock on module removal

Binding devm_led_classdev_register() to the netdev is problematic
because on module removal we get a RTNL-related deadlock. Fix this
by avoiding the device-managed LED functions.

Note: We can safely call led_classdev_unregister() for a LED even
if registering it failed, because led_classdev_unregister() detects
this and is a no-op in this case.

Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
Cc: stable@vger.kernel.org
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 4c043052198d..00882ffc7a02 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -73,6 +73,7 @@ enum mac_version {
 };
 
 struct rtl8169_private;
+struct r8169_led_classdev;
 
 void r8169_apply_firmware(struct rtl8169_private *tp);
 u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp);
@@ -84,7 +85,8 @@ void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 			char *buf, int buf_len);
 int rtl8168_get_led_mode(struct rtl8169_private *tp);
 int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val);
-void rtl8168_init_leds(struct net_device *ndev);
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev);
 int rtl8125_get_led_mode(struct rtl8169_private *tp, int index);
 int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode);
-void rtl8125_init_leds(struct net_device *ndev);
+struct r8169_led_classdev *rtl8125_init_leds(struct net_device *ndev);
+void r8169_remove_leds(struct r8169_led_classdev *leds);
diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 7c5dc9d0df85..e10bee706bc6 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -146,22 +146,22 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
 	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
 
 	/* ignore errors */
-	devm_led_classdev_register(&ndev->dev, led_cdev);
+	led_classdev_register(&ndev->dev, led_cdev);
 }
 
-void rtl8168_init_leds(struct net_device *ndev)
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev)
 {
-	/* bind resource mgmt to netdev */
-	struct device *dev = &ndev->dev;
 	struct r8169_led_classdev *leds;
 	int i;
 
-	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(RTL8168_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
-		return;
+		return NULL;
 
 	for (i = 0; i < RTL8168_NUM_LEDS; i++)
 		rtl8168_setup_ldev(leds + i, ndev, i);
+
+	return leds;
 }
 
 static int rtl8125_led_hw_control_is_supported(struct led_classdev *led_cdev,
@@ -245,20 +245,31 @@ static void rtl8125_setup_led_ldev(struct r8169_led_classdev *ldev,
 	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
 
 	/* ignore errors */
-	devm_led_classdev_register(&ndev->dev, led_cdev);
+	led_classdev_register(&ndev->dev, led_cdev);
 }
 
-void rtl8125_init_leds(struct net_device *ndev)
+struct r8169_led_classdev *rtl8125_init_leds(struct net_device *ndev)
 {
-	/* bind resource mgmt to netdev */
-	struct device *dev = &ndev->dev;
 	struct r8169_led_classdev *leds;
 	int i;
 
-	leds = devm_kcalloc(dev, RTL8125_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(RTL8125_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
-		return;
+		return NULL;
 
 	for (i = 0; i < RTL8125_NUM_LEDS; i++)
 		rtl8125_setup_led_ldev(leds + i, ndev, i);
+
+	return leds;
+}
+
+void r8169_remove_leds(struct r8169_led_classdev *leds)
+{
+	if (!leds)
+		return;
+
+	for (struct r8169_led_classdev *l = leds; l->ndev; l++)
+		led_classdev_unregister(&l->led);
+
+	kfree(leds);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6f1e6f386b7b..8a27328eae34 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -647,6 +647,8 @@ struct rtl8169_private {
 	const char *fw_name;
 	struct rtl_fw *rtl_fw;
 
+	struct r8169_led_classdev *leds;
+
 	u32 ocp_base;
 };
 
@@ -5044,6 +5046,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
+	r8169_remove_leds(tp->leds);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -5501,9 +5505,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
 		if (rtl_is_8125(tp))
-			rtl8125_init_leds(dev);
+			tp->leds = rtl8125_init_leds(dev);
 		else if (tp->mac_version > RTL_GIGA_MAC_VER_06)
-			rtl8168_init_leds(dev);
+			tp->leds = rtl8168_init_leds(dev);
 	}
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",


