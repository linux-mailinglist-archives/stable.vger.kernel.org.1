Return-Path: <stable+bounces-174035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BDB36095
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BBA7B6F51
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA8FBF0;
	Tue, 26 Aug 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pDQGVgI0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C691494D9;
	Tue, 26 Aug 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213320; cv=none; b=tkShqQAoh3IfVPLc6w0QCQj0PISrzpel2TPzZV5OWrtsRRUwbxupmmdIet8d+g2GYvHiIr9ZoRYOYQPFG5qtLFoQTTj4Ju5yHJBGSfwpU4bgvZa3d2XPcVzB3tStHttDtDvhtQpi/NuBdT/H8pYlRYrjOkLS+iAv/c9JTlc4gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213320; c=relaxed/simple;
	bh=26yOdiCt3DKlZpTTT3Sev5x0rEyeMFHSJp1DAIo0WDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q95dLwE0r43uYyXx8uleciVjkGu1WvzS5J5z9VSWOuDa7b6KqfMc6RqXhqUoMD0onOqU6bKTWM6xKM+HJpTLfjA8OrgNuqR3IYlO05kXE45lzTF5EbtyE/vHBECFxgW1OM64e9UKtRPKcd/4+AXdFQUfTkIv05FUbTk6Iamk2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pDQGVgI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A809CC4CEF4;
	Tue, 26 Aug 2025 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213320;
	bh=26yOdiCt3DKlZpTTT3Sev5x0rEyeMFHSJp1DAIo0WDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDQGVgI0gr8kAJbPfZqLIBP9b+YPDwEhUcVSjEHCM/AAEYKLdA0Eh3OKA5+WhGRLP
	 B1PPJtOK/9iZIKQKgW0S6Civ/7nvti4J6ADRU8Mzx/GgNCnWd3Oqwy4ykv01tSVLJ1
	 OmHewCRNon5N9f6Lhhn3OurLdqy5SpR4sV/sRYvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricky Wu <ricky_wu@realtek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 304/587] misc: rtsx: usb: Ensure mmc child device is active when card is present
Date: Tue, 26 Aug 2025 13:07:33 +0200
Message-ID: <20250826111000.655504679@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricky Wu <ricky_wu@realtek.com>

commit 966c5cd72be8989c8a559ddef8e8ff07a37c5eb0 upstream.

When a card is present in the reader, the driver currently defers
autosuspend by returning -EAGAIN during the suspend callback to
trigger USB remote wakeup signaling. However, this does not guarantee
that the mmc child device has been resumed, which may cause issues if
it remains suspended while the card is accessible.
This patch ensures that all child devices, including the mmc host
controller, are explicitly resumed before returning -EAGAIN. This
fixes a corner case introduced by earlier remote wakeup handling,
improving reliability of runtime PM when a card is inserted.

Fixes: 883a87ddf2f1 ("misc: rtsx_usb: Use USB remote wakeup signaling for card insertion detection")
Cc: stable@vger.kernel.org
Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20250711140143.2105224-1-ricky_wu@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cardreader/rtsx_usb.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct u
 }
 
 #ifdef CONFIG_PM
+static int rtsx_usb_resume_child(struct device *dev, void *data)
+{
+	pm_request_resume(dev);
+	return 0;
+}
+
 static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct rtsx_ucr *ucr =
@@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_i
 			mutex_unlock(&ucr->dev_mutex);
 
 			/* Defer the autosuspend if card exists */
-			if (val & (SD_CD | MS_CD))
+			if (val & (SD_CD | MS_CD)) {
+				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
+			}
 		} else {
 			/* There is an ongoing operation*/
 			return -EAGAIN;
@@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_i
 	return 0;
 }
 
-static int rtsx_usb_resume_child(struct device *dev, void *data)
-{
-	pm_request_resume(dev);
-	return 0;
-}
-
 static int rtsx_usb_resume(struct usb_interface *intf)
 {
 	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);



