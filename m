Return-Path: <stable+bounces-167369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE834B22FA8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1D104E1EFF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9C2FD1D6;
	Tue, 12 Aug 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvbwQJ/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF286331;
	Tue, 12 Aug 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020587; cv=none; b=mmNs2YkUfcOMLNuzPfO0tRBw0RPVhpT098L+AYNA5HfIEVxuNfL+CXEiWpq/EPR7c1T5uZCZlmSxoSALFdeRrT125M3CellsSxAO6ioxEM9zDazXMhG8ro2Plh8d6C1nnP6Y5B89FchMsFbrdZ8cgu3Z4ew8cAAUzIio2zcLNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020587; c=relaxed/simple;
	bh=h0Vu5j3dqnJJ+F8G43ntIsnU65F7w45GVOQSdtMQtFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK7ePRl6m1KtC1Ptm2Y44TKvUpVpof3mPh439clkWn6AU/0Cl+RdLc+kKsZjIZTItWvFm+DDC6TG3TpPJxxPV8pcVJkqaEBq4A4q+iO3nB05M4UnKp+ABA2ZtePXjM2iZNEuLFMyZwx2SeUiBrwIiM52GuWZkn8OiXyLXvbJ7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvbwQJ/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65480C4CEF0;
	Tue, 12 Aug 2025 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020586;
	bh=h0Vu5j3dqnJJ+F8G43ntIsnU65F7w45GVOQSdtMQtFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvbwQJ/cXZdgAesAsUI9hGpej0xtzM3iDY5d+8jiwoFwjTFIcPAxyX6TDeWA2YlIx
	 zGsfbmK671t4MNIS3GD8OFd0yDXAPJfuZPYB2v+jThl4V3s4JCXxUTq9L6hL5tZWiy
	 dZslHYgaAQLzvf7/uQgHpp8xnFNy8PVxAcQexlcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/253] wifi: plfxlc: Fix error handling in usb driver probe
Date: Tue, 12 Aug 2025 19:28:30 +0200
Message-ID: <20250812172953.895345940@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 3fe79a25c3cd54d25d30bc235c0c57f8a123d9d5 ]

If probe fails before ieee80211_register_hw() is successfully done,
ieee80211_unregister_hw() will be called anyway. This may lead to various
bugs as the implementation of ieee80211_unregister_hw() assumes that
ieee80211_register_hw() has been called.

Divide error handling section into relevant subsections, so that
ieee80211_unregister_hw() is called only when it is appropriate. Correct
the order of the calls: ieee80211_unregister_hw() should go before
plfxlc_mac_release(). Also move ieee80211_free_hw() to plfxlc_mac_release()
as it supposed to be the opposite to plfxlc_mac_alloc_hw() that calls
ieee80211_alloc_hw().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Link: https://patch.msgid.link/20250321185226.71-3-m.masimov@mt-integration.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 11 ++++----
 drivers/net/wireless/purelifi/plfxlc/mac.h |  2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c | 29 +++++++++++-----------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 70d6f5244e5e..7585ded553dd 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -100,11 +100,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 	return r;
 }
 
-void plfxlc_mac_release(struct plfxlc_mac *mac)
-{
-	plfxlc_chip_release(&mac->chip);
-}
-
 int plfxlc_op_start(struct ieee80211_hw *hw)
 {
 	plfxlc_hw_mac(hw)->chip.usb.initialized = 1;
@@ -751,3 +746,9 @@ struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf)
 	SET_IEEE80211_DEV(hw, &intf->dev);
 	return hw;
 }
+
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw)
+{
+	plfxlc_chip_release(&plfxlc_hw_mac(hw)->chip);
+	ieee80211_free_hw(hw);
+}
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.h b/drivers/net/wireless/purelifi/plfxlc/mac.h
index 49b92413729b..c0445932b2e8 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.h
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.h
@@ -168,7 +168,7 @@ static inline u8 *plfxlc_mac_get_perm_addr(struct plfxlc_mac *mac)
 }
 
 struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf);
-void plfxlc_mac_release(struct plfxlc_mac *mac);
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw);
 
 int plfxlc_mac_preinit_hw(struct ieee80211_hw *hw, const u8 *hw_address);
 int plfxlc_mac_init_hw(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 8151bc5e00cc..901e0139969e 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -604,7 +604,7 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_upload_mac_and_serial(intf, hw_address, serial_number);
 	if (r) {
 		dev_err(&intf->dev, "MAC and Serial upload failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	chip->unit_type = STA;
@@ -613,13 +613,13 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_mac_preinit_hw(hw, hw_address);
 	if (r) {
 		dev_err(&intf->dev, "Init mac failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	r = ieee80211_register_hw(hw);
 	if (r) {
 		dev_err(&intf->dev, "Register device failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}
 
 	if ((le16_to_cpu(interface_to_usbdev(intf)->descriptor.idVendor) ==
@@ -632,7 +632,7 @@ static int probe(struct usb_interface *intf,
 	}
 	if (r != 0) {
 		dev_err(&intf->dev, "FPGA download failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	tx->mac_fifo_full = 0;
@@ -642,21 +642,21 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_usb_init_hw(usb);
 	if (r < 0) {
 		dev_err(&intf->dev, "usb_init_hw failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_switch_radio(chip, PLFXLC_RADIO_ON);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_switch_radio_on failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_set_rate(chip, 8);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_set_rate failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	msleep(PLF_MSLEEP_TIME);
@@ -664,7 +664,7 @@ static int probe(struct usb_interface *intf,
 			    hw_address, ETH_ALEN, USB_REQ_MAC_WR);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "MAC_WR failure (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}
 
 	plfxlc_chip_enable_rxtx(chip);
@@ -691,12 +691,12 @@ static int probe(struct usb_interface *intf,
 	plfxlc_mac_init_hw(hw);
 	usb->initialized = true;
 	return 0;
+
+error_unreg_hw:
+	ieee80211_unregister_hw(hw);
+error_free_hw:
+	plfxlc_mac_release_hw(hw);
 error:
-	if (hw) {
-		plfxlc_mac_release(plfxlc_hw_mac(hw));
-		ieee80211_unregister_hw(hw);
-		ieee80211_free_hw(hw);
-	}
 	dev_err(&intf->dev, "pureLifi:Device error");
 	return r;
 }
@@ -730,8 +730,7 @@ static void disconnect(struct usb_interface *intf)
 	 */
 	usb_reset_device(interface_to_usbdev(intf));
 
-	plfxlc_mac_release(mac);
-	ieee80211_free_hw(hw);
+	plfxlc_mac_release_hw(hw);
 }
 
 static void plfxlc_usb_resume(struct plfxlc_usb *usb)
-- 
2.39.5




