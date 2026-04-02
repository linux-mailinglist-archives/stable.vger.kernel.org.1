Return-Path: <stable+bounces-232954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBBRMNI3zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69680386F9C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60109301BDF0
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1A39A054;
	Thu,  2 Apr 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv9Zhps6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4A3921DF;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122053; cv=none; b=RdquU8O9QSEM1tAr0WKGABEwXJ0lE0XDPp1FQUwFnJahxwvhKkOUVs3ZLkNrvJcTwnz02+2o4c22yrC8fdvQ4dq2IzhAZT8bc8VD0vhr+CmFSq1p2ems2TVCUFgz1gsCeUYQ8ZA2LSBmNzS4MuekZ/z0y5tc9QImvG2x7ELVrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122053; c=relaxed/simple;
	bh=hZXVRO7WK1sAdCW6Mwg67FMXjt+GSDlkVsjEmn3eu4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFNrzZVYPEUqQo39JN+FKPSuQUggaZZcim4ZNVI+zYwdsQb7zgWlNWJ4LMiFA0k039qzS0RGMKK560WAA2/y/0yX3CQUiltRhHl8S670EtcJaJtiw71DatAiIUAdojhSKosQE3znW4p3lPWjxrft8SX5NHrH63FV4QIVdM8tHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv9Zhps6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F667C2BC9E;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775122052;
	bh=hZXVRO7WK1sAdCW6Mwg67FMXjt+GSDlkVsjEmn3eu4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sv9Zhps61b7Z+3qpaxmqBbuk14oMt6DuqHqcClBLwpuDsP3QpoECW9o5mHU29mOET
	 ZNSug1JNKBjZMGV7qrFTGfiaDFuovCs2ZHl/r8THznOdLYwHfCow4JVjcCwyB/BSSt
	 KT/iT7wNW4QI3l7rFVWuYZVBzVcxcNYE7TGWploDaxQDHzw+4uJjqbsT3q8141haSM
	 RSWDcC/e9d4qaY9kL+QurrfuRHl0eiWoL12ATEuP2zu/KyPD+uiWYNNZKpJH/UiAOd
	 hVe4MA7Q1J0jvJoXdwZ8T1M2Js6sWk70gTAJFiRAUBA2junjv1oPSb3ZfaFO22GUQ8
	 rUV1ZAHG/nKbQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8EKo-00000009qUn-0FIA;
	Thu, 02 Apr 2026 11:27:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 1/3] Bluetooth: btusb: fix wakeup source leak on probe failure
Date: Thu,  2 Apr 2026 11:27:02 +0200
Message-ID: <20260402092704.2346710-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402092704.2346710-1-johan@kernel.org>
References: <20260402092704.2346710-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232954-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 69680386F9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21e85c212506..9e4390ba82ba 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4146,7 +4146,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
 #endif
 	if (id->driver_info & BTUSB_CW6622)
@@ -4183,7 +4183,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
@@ -4346,7 +4346,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_disable_wakeup;
 		}
 	}
 
@@ -4354,7 +4354,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4372,7 +4372,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto err_disable_wakeup;
 
 	usb_set_intfdata(intf, data);
 
@@ -4381,6 +4381,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 
+err_disable_wakeup:
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.52.0


