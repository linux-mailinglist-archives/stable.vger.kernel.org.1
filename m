Return-Path: <stable+bounces-15354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498428384DE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D91C2A2C3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1567765F;
	Tue, 23 Jan 2024 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cntJEcIg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3D768F6;
	Tue, 23 Jan 2024 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975521; cv=none; b=UYeCOy8g34dLVt+rxbhauvHFQAaTcSRqawrmZfAeUhZOpQ8GrO2Wp/nvciy/HnR06MK/cQjNZ9/sbkNDPGxAZJgWkmrvKJJtd2jZrvEzoq25KGpo67vaux8QPwsfH54C+17uZ6YCmLe9ETA8Ti67nYdAjMsDK/IqHv2i57DAu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975521; c=relaxed/simple;
	bh=gtHjBfq3jTpoowGZLSW/SUi7DM5Eakb5W3dRND937YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnbkIym7cFF7Xnt86JmhA0VFFJqKk8vmL15ZpbR4TZXebszTDnF8d/eSNYlq6NqqL8WDwO6cESzrGQ99AD2PDNDeKyev/dJlzmu0Stl8WbSFb/L5Rz37bgehvW/VijPvEW4Aelxfam4lsm0mfrCEzeH6akZuw6c8UMbdMKKfGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cntJEcIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63386C433F1;
	Tue, 23 Jan 2024 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975521;
	bh=gtHjBfq3jTpoowGZLSW/SUi7DM5Eakb5W3dRND937YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cntJEcIgw1Zf/nfCFGrTz1C9zwopSFhJMtiZzxKP/e8NCjpxwbr6tOvgErFZCGNdu
	 MmKtTRksUxYONWIBSRHpKYtDO+YNPyhVF3UtUARY45EPITTvjCpA/6vMKUXygCEw/D
	 pcj6zNEy58tv5CxQ6m0QJ1+5c7+GiQtOW4pzavLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 465/583] r8152: Choose our USB config with choose_configuration() rather than probe()
Date: Mon, 22 Jan 2024 15:58:36 -0800
Message-ID: <20240122235826.215051259@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit aa4f2b3e418e8673e55145de8b8016a7a9920306 ]

If you deauthorize the r8152 device (by writing 0 to the "authorized"
field in sysfs) and then reauthorize it (by writing a 1) then it no
longer works. This is because when you do the above we lose the
special configuration that we set in rtl8152_cfgselector_probe().
Deauthorizing causes the config to be set to -1 and then reauthorizing
runs the default logic for choosing the best config.

I made an attempt to fix it so that the config is kept across
deauthorizing / reauthorizing [1] but it was a bit ugly.

Let's instead use the new USB core feature to override
choose_configuration().

This patch relies upon the patches ("usb: core: Don't force USB
generic_subclass drivers to define probe()") and ("usb: core: Allow
subclassed USB drivers to override usb_choose_configuration()")

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Link: https://lore.kernel.org/r/20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 127b34dcc5b3..cca5b81c8b18 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10036,7 +10036,7 @@ static struct usb_driver rtl8152_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-static int rtl8152_cfgselector_probe(struct usb_device *udev)
+static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
 {
 	struct usb_host_config *c;
 	int i, num_configs;
@@ -10063,19 +10063,13 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
 	if (i == num_configs)
 		return -ENODEV;
 
-	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
-		dev_err(&udev->dev, "Failed to set configuration %d\n",
-			c->desc.bConfigurationValue);
-		return -ENODEV;
-	}
-
-	return 0;
+	return c->desc.bConfigurationValue;
 }
 
 static struct usb_device_driver rtl8152_cfgselector_driver = {
-	.name =		MODULENAME "-cfgselector",
-	.probe =	rtl8152_cfgselector_probe,
-	.id_table =	rtl8152_table,
+	.name =	MODULENAME "-cfgselector",
+	.choose_configuration = rtl8152_cfgselector_choose_configuration,
+	.id_table = rtl8152_table,
 	.generic_subclass = 1,
 	.supports_autosuspend = 1,
 };
-- 
2.43.0




