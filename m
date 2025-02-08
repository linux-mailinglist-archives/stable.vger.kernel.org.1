Return-Path: <stable+bounces-114388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB7A2D5F0
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 12:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB477A5340
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7942475F0;
	Sat,  8 Feb 2025 11:51:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09772451EA
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015498; cv=none; b=NN4b5XbZyjGgiRRC95z5XOc/prbZWhxiYt3KH23rUeGx/J0DqHQztIkGO5paCtXvLnmZ0t06h4cZ14EVZd/xCkxT9djYydJqu5Q0UdAO/kuoAxFia0JSbxYteM/e5Mff8PyuJMK2w77CpeRoYiHYuJhadE2CFfACcW6d3DkCedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015498; c=relaxed/simple;
	bh=3PZwsIstICG+p7ia3lentaJHQ07+f3BLecaZ9llzKX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or05FRVJIZlHnI23TPfxgAT3KnE/WQNopoeuuIX7/3nfTTaMIdyU90zxujsF/u2+D6c8zDdfQiI7wa9gzq7wWX5Xt1t7A2w0Ctar2TFYP4IzD+e5sj3jsnHFHEgIDBQnTdhAkQGJHig62db8wo28v2FMpPu2g/d/R8WVvyrI5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjN0-0006sE-WD
	for stable@vger.kernel.org; Sat, 08 Feb 2025 12:51:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjN0-0048Nh-1s
	for stable@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 437353BCCF7
	for <stable@vger.kernel.org>; Sat, 08 Feb 2025 11:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6C5BC3BCCCD;
	Sat, 08 Feb 2025 11:51:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f9fcc3e4;
	Sat, 8 Feb 2025 11:51:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	yan kang <kangyan91@outlook.com>,
	yue sun <samsun1006219@gmail.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/6] can: etas_es58x: fix potential NULL pointer dereference on udev->serial
Date: Sat,  8 Feb 2025 12:45:18 +0100
Message-ID: <20250208115120.237274-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208115120.237274-1-mkl@pengutronix.de>
References: <20250208115120.237274-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The driver assumed that es58x_dev->udev->serial could never be NULL.
While this is true on commercially available devices, an attacker
could spoof the device identity providing a NULL USB serial number.
That would trigger a NULL pointer dereference.

Add a check on es58x_dev->udev->serial before accessing it.

Reported-by: yan kang <kangyan91@outlook.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/linux-can/SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through devlink_ops::info_get()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250204154859.9797-2-mailhol.vincent@wanadoo.fr
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_devlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index eee20839d96f..0d155eb1b9e9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -248,7 +248,11 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	return devlink_info_serial_number_put(req, es58x_dev->udev->serial);
+	if (es58x_dev->udev->serial)
+		ret = devlink_info_serial_number_put(req,
+						     es58x_dev->udev->serial);
+
+	return ret;
 }
 
 const struct devlink_ops es58x_dl_ops = {
-- 
2.47.2



