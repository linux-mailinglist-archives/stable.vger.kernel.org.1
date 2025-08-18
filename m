Return-Path: <stable+bounces-171671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E0B2B452
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164913AF57B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49A258EE9;
	Mon, 18 Aug 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCLcN5wy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3253451B0
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558522; cv=none; b=kYkc8Ub+NJMnXshRVc3DlEw3Jv+ewYDBJV9dxkE2xbhkaGKiXy01/PWI8BYnQ3pA+sWqTPWlk7yew5czjjJkztrDdswIRZ7f/HenzfQ1ptq/xDzoBx2043sd/TU59Xyt/58gSzRX2K+TYdxPAg9gHaCg7aXMS1WiZY2OPAmSXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558522; c=relaxed/simple;
	bh=dl4NbybtQgY9YOiTOB9ep9QuTQaj0ChOVyxBBLZXTbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwAXE2zbuUKHpou4qK4zLlHK4eanmwVBS/w6BXogWAaYMTgwTHrvHZLlpB4qzyoKzufh8rQ1Y13C4oDnj9ZjufbEbfsPHGQXzHIU2l3R182s3Vt/hj5kDDEWXl4H942JB4nyrGrKj2iIb08Y4ktPwwQHgTcblj2gxC2gIAX1P6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCLcN5wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5445C4CEF1;
	Mon, 18 Aug 2025 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558522;
	bh=dl4NbybtQgY9YOiTOB9ep9QuTQaj0ChOVyxBBLZXTbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCLcN5wyitzQhNl5pDIaL+w/GKzTG/G4yq1DmdHpvOzATufHMkE0MAccO/Gc3lqcR
	 pKzCrGMww0Cv2L2lnoEl+Svm38rCxUPwxPc//1fIXW97gu7yPaHhIypbfOH1GOl2x5
	 NSEBPTdyrBfPugWGa7Hiocss+9OzUDDlkQdAtQMDgIKdZundTrBiU8xYZm2bzQvHSt
	 uDIDjyDow/V0JBiMITdboTNrVgq7YN+kmMUbAfJ3LH0lCgGMXbbD2FVf7Qp6KYGwog
	 B0I0xQj/BekW+/NIuu0RAXboYdQh5giooQL0YNcuWpg0hvneBJpbM63zHK7jpoBduc
	 LRQGI5k45WlBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] cdc-acm: fix race between initial clearing halt and open
Date: Mon, 18 Aug 2025 19:08:39 -0400
Message-ID: <20250818230839.135733-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818230839.135733-1-sashal@kernel.org>
References: <2025081847-resident-transform-fcca@gregkh>
 <20250818230839.135733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 64690a90cd7c6db16d3af8616be1f4bf8d492850 ]

On the devices that need their endpoints to get an
initial clear_halt, this needs to be done before
the devices can be opened. That means it needs to be
before the devices are registered.

Fixes: 15bf722e6f6c0 ("cdc-acm: Add support of ATOL FPrint fiscal printers")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250717141259.2345605-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 50d439201302..07543731bfa5 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1517,6 +1517,12 @@ static int acm_probe(struct usb_interface *intf,
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
 	usb_set_intfdata(data_interface, acm);
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1524,11 +1530,6 @@ static int acm_probe(struct usb_interface *intf,
 		goto alloc_fail6;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
-
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;
-- 
2.50.1


