Return-Path: <stable+bounces-200690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C4CB2689
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0845E30A9C87
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7B3016F5;
	Wed, 10 Dec 2025 08:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44262FD7A7
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355339; cv=none; b=bUEFIbsEAfP5JB+2mFrzjGFySMsuTcIOu/A4Yk896ziBh/4YedSmCkp+fL2TIbgjRHBqBUnWmUlAQxbsiJIVXEAoyy5MBqOI9RtExn24oTtC0nZJy0CmaNkvRpjHAW29xcGgChbl9BddXe1STG1BEejzezIN6ILJZr32TSzxjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355339; c=relaxed/simple;
	bh=eWqF8RcyPEJutaAHmXfmsn26O9eizCMA4xqgxPwN+Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WgLwSF0a8sZj2yzG8kZOYzVnBZ08VZvY86kEFYMElui1GTfY88/XbAzDEDrFi5Xe3ThZwJPsFpDVikHn2qwpUacT5CnnuTSMvCLs9qF9MW1HaPnmq3avKiEqIOpoGceqma6ws6d2Lz2g7quHCxe6nIyEhscokGp2ZntV+SKfqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFZ2-000717-QB; Wed, 10 Dec 2025 09:28:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFZ2-004vHp-1r;
	Wed, 10 Dec 2025 09:28:48 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4FB5E4B3B0D;
	Wed, 10 Dec 2025 08:28:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 10 Dec 2025 09:28:36 +0100
Subject: [PATCH can] can: gs_usb: gs_can_open(): fix error handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-gs_usb-fix-error-handling-v1-1-d6a5a03f10bb@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADMvOWkC/yWMUQrCQAwFr1LybWA3rGC9ioi023SNyFYSK4XSu
 zfq5zzmzQrGKmxwblZQ/ojJVB3ioYF872phlMEZKNAxUgxY7DZbj6MsyKqTolvDU2rBNLanQG1
 KlDL4/6Xs1q99gdxVuP5Hm/sH5/e3Ctu2A6g46juCAAAA
X-Change-ID: 20251210-gs_usb-fix-error-handling-4f980294424c
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=eWqF8RcyPEJutaAHmXfmsn26O9eizCMA4xqgxPwN+Zk=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpOS89pyNAlPR3VoIm2neU5ZT/8kDAMk46El+8T
 b8aZYlHe6KJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaTkvPQAKCRAMdGXf+ZCR
 nLdbB/0Sn5xX1a0OZJ4Fm4W90hY8v+wF9/acKPGLDaYlxIcJktRPr++nXx0+hVk0l8QmOJcdjOA
 08tyGnfwgCcPknXG2vgg9LMbSf8ZROyz88qavJn8JNYkHS5z2g4eziy9P4T2WioLzK4kZA4cJHw
 KLrQBiWLilybwFihLq7yTjJqARNq9GMNaXjF+jgTg39OcGYinkDVzmjd7YUjWDbYSDnjHExgdKr
 33aSHDDzcJiRbzxj5N4IKkAZR/kim+i8nfafTzMiYOVHmaISR2LBCIFkuM/hXe8rS1gs4GXXVNa
 wZ39zs6oVmfxvGrWyaVEpOmoWmZgh5N4NKiUM7LxBpJKuJkk
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Commit 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
added missing error handling to the gs_can_open() function.

The driver uses 2 USB anchors to track the allocated URBs: the TX URBs in
struct gs_can::tx_submitted for each netdev and the RX URBs in struct
gs_usb::rx_submitted for the USB device. gs_can_open() allocates the RX
URBs, while TX URBs are allocated during gs_can_start_xmit().

The cleanup in gs_can_open() kills all anchored dev->tx_submitted
URBs (which is not necessary since the netdev is not yet registered), but
misses the parent->rx_submitted URBs.

Fix the problem by killing the rx_submitted instead of the tx_submitted.

Fixes: 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e29e85b67fd4..a0233e550a5a 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1074,7 +1074,7 @@ static int gs_can_open(struct net_device *netdev)
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
 	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&dev->tx_submitted);
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(parent);

---
base-commit: 186468c67fc687650b7fb713d8c627d5c8566886
change-id: 20251210-gs_usb-fix-error-handling-4f980294424c

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


