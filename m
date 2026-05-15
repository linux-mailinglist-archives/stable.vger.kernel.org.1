Return-Path: <stable+bounces-248587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BQWBD9RB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF24554521
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74F33386F07
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE773B9D84;
	Fri, 15 May 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4/QqkNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059D2609EE;
	Fri, 15 May 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862113; cv=none; b=FBBetv2H19cln9aJV0H1kRDRi1QzFQyH7DnOOysLL3L19hOGgzx6rWgUJdDdRvyq1mUfdU7ep8VYLxkquQRV3fkr1080wui2I8ocVEvryXyr0S0QOeoFKqfWCmbS8Cun4ywEfh8J9SmnfTA3Joru75/5GNe8VGC1j6N4YNf5ydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862113; c=relaxed/simple;
	bh=/qlQHnZvXl6pAH/+df4xrEp0Xgvw341h49THOQza+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9ze8wTzI2+xP2Gi14vmM+g9CvR+6k49PLfZrzmvY62c4J3uGn+UBETIAcrmjIP5OzK5Cyu39ccafYrFNf5ySaaJS3FO4C6s6oHji696eEVMdn9peGZBTWymvgB6aIQA2JEC59RBAe9yKTVyXwVJaCW0Ni2P5gWlbAb8xhVRG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4/QqkNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DE4C2BCC7;
	Fri, 15 May 2026 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862113;
	bh=/qlQHnZvXl6pAH/+df4xrEp0Xgvw341h49THOQza+DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4/QqkNUwxG8GUGwIcvHQNwgnkTiP2cGFSruDriUVjnyrapLLdRp5DV3+ZaujYKCN
	 xIye6h3PDNgJPLQzC4rHiV5kQ5HoseS0elUkRwKsKaUvT/BIEsiFCCvLGDLHM/MACT
	 NkQYtILDb1ggiAB8z16SSuhAZV/V94bIid4cVnEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <jth@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 072/188] spi: ch341: fix devres lifetime
Date: Fri, 15 May 2026 17:48:09 +0200
Message-ID: <20260515154658.880472921@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AF24554521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248587-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit abe572f630bc1f0e77041012ab075869036ede4f upstream.

USB drivers bind to USB interfaces and any device managed resources
should have their lifetime tied to the interface rather than parent USB
device. This avoids issues like memory leaks when drivers are unbound
without their devices being physically disconnected (e.g. on probe
deferral or configuration changes).

Fix the controller and driver data lifetime so that they are released
on driver unbind.

Note that this also makes sure that the SPI controller is placed
correctly under the USB interface in the device tree.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Cc: stable@vger.kernel.org	# 6.11
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260327104305.1309915-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ch341.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -152,7 +152,7 @@ static int ch341_probe(struct usb_interf
 	if (ret)
 		return ret;
 
-	ctrl = devm_spi_alloc_host(&udev->dev, sizeof(struct ch341_spi_dev));
+	ctrl = devm_spi_alloc_host(&intf->dev, sizeof(struct ch341_spi_dev));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -163,7 +163,7 @@ static int ch341_probe(struct usb_interf
 	ch341->read_pipe = usb_rcvbulkpipe(udev, usb_endpoint_num(in));
 
 	ch341->rx_len = usb_endpoint_maxp(in);
-	ch341->rx_buf = devm_kzalloc(&udev->dev, ch341->rx_len, GFP_KERNEL);
+	ch341->rx_buf = devm_kzalloc(&intf->dev, ch341->rx_len, GFP_KERNEL);
 	if (!ch341->rx_buf)
 		return -ENOMEM;
 
@@ -171,8 +171,7 @@ static int ch341_probe(struct usb_interf
 	if (!ch341->rx_urb)
 		return -ENOMEM;
 
-	ch341->tx_buf =
-		devm_kzalloc(&udev->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
+	ch341->tx_buf = devm_kzalloc(&intf->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
 	if (!ch341->tx_buf) {
 		ret = -ENOMEM;
 		goto err_free_urb;



