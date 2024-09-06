Return-Path: <stable+bounces-73699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7057596E976
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 07:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3043F286408
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46A13211A;
	Fri,  6 Sep 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b="IoFqo9ri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [91.239.200.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FD2941B;
	Fri,  6 Sep 2024 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.200.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601870; cv=none; b=JlctCd6rSto/b/TzCpq2qN8lb5kUOr92KHNqKIAQgN79+Id3GSYEEWCKY1YBprg9xDgLo2NBrGM6vR3rtFfTWnu2KSrNeCRJz7yHK30jb+Rk6iZ8OkClhas1jxuU+RCEkfYtgRZVRfoaBpBl9t2jxN8W7daLEaod+51aHtK1MiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601870; c=relaxed/simple;
	bh=TuxLsa7W/bRtzhMsHtb8h6BVR2XMO8eC6nDKdJJm/l4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KovOZzAvr/K8E2zREvEZ1vJ5bXrXiA2VidD6/hvQDQVL1q6Biqp/rtrIuMUpFyqLUjth57FO6JHdRpTsZMNRgpnpDWwIle4kgaM7KQqFNjcqc8bARlN2IILl9rxPSctScH51YLJ6m5y0UNyPrzx5+CUAqVGEwDWNZh1WfU8lbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz; spf=pass smtp.mailfrom=elrest.cz; dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b=IoFqo9ri; arc=none smtp.client-ip=91.239.200.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elrest.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
	s=rampa2-202408; t=1725601855;
	bh=TuxLsa7W/bRtzhMsHtb8h6BVR2XMO8eC6nDKdJJm/l4=;
	h=From:To:Cc:Subject:Date:From;
	b=IoFqo9riDdRbOqHh2cGB7HBrD/P+AU1gZ6hyK8okAfBC+NYZF+x13N4KXrLzc7ynw
	 l5ECyo53iLk3wZaDn9D0/5SdoxLGWafPR5MUAX7khcjfizBbJ2t6Qa5IL8WhxRxXb3
	 5iLvZuI58cA1YIj7Yn4bOpI5Vk9zUXFDsFNkOZ45hj/Z7rBieJSxYUwrs5Iqb/wQEv
	 aHhNWghbyZP8uOykPHZuIkls4eUDVibUkAMRnxmmN4RRlLakQScsIyWg5yPU9XLvv+
	 RzXR9+6MsSkAS/phRtq0rPO/o3Yd4glchcT4g4GTRkGevqjjliJUSZaX7YqwwtSNyX
	 LJYN+uE+dJkWg==
X-Virus-Scanned: Debian amavis at smtp.cesky-hosting.cz
Received: from localhost.localdomain (unknown [185.63.98.16])
	(Authenticated sender: tomas.marek@elrest.cz)
	by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 4X0QM25t5hzRR;
	Fri,  6 Sep 2024 07:50:53 +0200 (CEST)
From: Tomas Marek <tomas.marek@elrest.cz>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org
Cc: Arthur.Petrosyan@synopsys.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oleg.karfich@wago.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: drd: fix clock gating on USB role switch
Date: Fri,  6 Sep 2024 07:50:25 +0200
Message-Id: <20240906055025.25057-1-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwc2_handle_usb_suspend_intr() function disables gadget clocks in USB
peripheral mode when no other power-down mode is available (introduced by
commit 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")).
However, the dwc2_drd_role_sw_set() USB role update handler attempts to
read DWC2 registers if the USB role has changed while the USB is in suspend
mode (when the clocks are gated). This causes the system to hang.

Release the gadget clocks before handling the USB role update.

Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")
Cc: stable@vger.kernel.org
Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
---
Changes in v2:
 - CC stable@vger.kernel.org
 - merge ifdef and nested if statements into one if statement
---
 drivers/usb/dwc2/drd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index a8605b02115b..1ad8fa3f862a 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -127,6 +127,15 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 			role = USB_ROLE_DEVICE;
 	}
 
+	if ((IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) ||
+	     IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)) &&
+	     dwc2_is_device_mode(hsotg) &&
+	     hsotg->lx_state == DWC2_L2 &&
+	     hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	     hsotg->bus_suspended &&
+	     !hsotg->params.no_clock_gating)
+		dwc2_gadget_exit_clock_gating(hsotg, 0);
+
 	if (role == USB_ROLE_HOST) {
 		already = dwc2_ovr_avalid(hsotg, true);
 	} else if (role == USB_ROLE_DEVICE) {
-- 
2.25.1


