Return-Path: <stable+bounces-230626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGZ5F89ixmm+JAUAu9opvQ
	(envelope-from <stable+bounces-230626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:58:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B1342FB7
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B76A3013C4F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4733DD523;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deG4wqq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1FA3382C5;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608197; cv=none; b=dSCdPqUMb62iVRo+1KoVuzpiAnC1A2S5nQPRsTRsLa4gOoFsN/iPmRXu7D/mPfnhItWgVWxYG/4nTHDbq647Ho03gdua05sDi8bVYG9S9vZ/hkD+7XthZ5cDpomnR7y4U6SEqUxdamknQkI4dCKN6KR5XokvytOzOemS9g7f34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608197; c=relaxed/simple;
	bh=06nKPiYAs+uiYFgsj7ZNA0z7q+/cAsl7BATEDCAZzvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J86svgUuUwpYiGQKKBmvWdsOXHgQrFShmozsi8NDddj400YyQzXsAgAuMxeivTNxEzfPSH2n6+NJmajmR9Pv5AdNiQZHei5uCA8SqmUdY9jSoCjzIPmhTrUL0zsQ9hSimUDQ/DZdnnBMR9Q4HHRgMy1lpeb3XUqEbdfK1eRIkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deG4wqq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01322C19423;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608197;
	bh=06nKPiYAs+uiYFgsj7ZNA0z7q+/cAsl7BATEDCAZzvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deG4wqq8fs9UVE1J4IYK3uajLV0nVUkWcOA2wkeHngrrzZ8oghi+inqmRqmXSTCxL
	 IIb9iTLkKhkmkloIWJykfpfxTMqqUgwSVuv5fxRDbXHv8CCbcWyHbKOcw78CVqFvWE
	 gEnx4k6jg6r9bZQ70DwR8oK2A+pjsw3uYt6ENWN0Ll7FBJyKZCO6HVZvpq8LJ01W9B
	 FeYHa8eEebRkRgJXQXT9txQcYXfQKCWll7W4tPSgbUKIayFUUxQrwEjSvZ+teEj2Jk
	 vXsqY8d75gdpjx1CTypiwef74FgtVrlhXqi6YuoxCW5qRKMBXyJjtjqdcv+h51xUtt
	 fpcguyLLcQXUg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64eo-00000005Um6-3c5X;
	Fri, 27 Mar 2026 11:43:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] spi: ch341: fix memory leaks on probe failures
Date: Fri, 27 Mar 2026 11:43:04 +0100
Message-ID: <20260327104305.1309915-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327104305.1309915-1-johan@kernel.org>
References: <20260327104305.1309915-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230626-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 609B1342FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller, disable pins, and kill and free
the RX URB on probe failures to mirror disconnect and avoid memory
leaks and use-after-free.

Also add an explicit URB kill on disconnect for symmetry (even if that
is not strictly required as USB core would have stopped it in the
current setup).

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Cc: stable@vger.kernel.org	# 6.11
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ch341.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 2fdb1c020339..ea92ba986201 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -173,17 +173,17 @@ static int ch341_probe(struct usb_interface *intf,
 
 	ch341->tx_buf =
 		devm_kzalloc(&udev->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
-	if (!ch341->tx_buf)
-		return -ENOMEM;
+	if (!ch341->tx_buf) {
+		ret = -ENOMEM;
+		goto err_free_urb;
+	}
 
 	usb_fill_bulk_urb(ch341->rx_urb, udev, ch341->read_pipe, ch341->rx_buf,
 			  ch341->rx_len, ch341_recv, ch341);
 
 	ret = usb_submit_urb(ch341->rx_urb, GFP_KERNEL);
-	if (ret) {
-		usb_free_urb(ch341->rx_urb);
-		return -ENOMEM;
-	}
+	if (ret)
+		goto err_free_urb;
 
 	ctrl->bus_num = -1;
 	ctrl->mode_bits = SPI_CPHA;
@@ -195,21 +195,34 @@ static int ch341_probe(struct usb_interface *intf,
 
 	ret = ch341_config_stream(ch341);
 	if (ret)
-		return ret;
+		goto err_kill_urb;
 
 	ret = ch341_enable_pins(ch341, true);
 	if (ret)
-		return ret;
+		goto err_kill_urb;
 
 	ret = spi_register_controller(ctrl);
 	if (ret)
-		return ret;
+		goto err_disable_pins;
 
 	ch341->spidev = spi_new_device(ctrl, &chip);
-	if (!ch341->spidev)
-		return -ENOMEM;
+	if (!ch341->spidev) {
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
 
 	return 0;
+
+err_unregister:
+	spi_unregister_controller(ctrl);
+err_disable_pins:
+	ch341_enable_pins(ch341, false);
+err_kill_urb:
+	usb_kill_urb(ch341->rx_urb);
+err_free_urb:
+	usb_free_urb(ch341->rx_urb);
+
+	return ret;
 }
 
 static void ch341_disconnect(struct usb_interface *intf)
@@ -219,6 +232,7 @@ static void ch341_disconnect(struct usb_interface *intf)
 	spi_unregister_device(ch341->spidev);
 	spi_unregister_controller(ch341->ctrl);
 	ch341_enable_pins(ch341, false);
+	usb_kill_urb(ch341->rx_urb);
 	usb_free_urb(ch341->rx_urb);
 }
 
-- 
2.52.0


