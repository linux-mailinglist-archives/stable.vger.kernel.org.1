Return-Path: <stable+bounces-262049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iw2qMivlJmpXmgIAu9opvQ
	(envelope-from <stable+bounces-262049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 17:52:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 639866585C9
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 17:52:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kTWHijLq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262049-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262049-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 552C9310E0BC
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B1406839;
	Mon,  8 Jun 2026 14:58:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA14C040D;
	Mon,  8 Jun 2026 14:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930728; cv=none; b=Z+/CF/K+UmJllCFYIGTmtBMfHWF+lNFu33RY12YJJU1iIYDPR+GlS+jYp4apyZIa2k/l9yZGC0mAfFScPa9osph1fs1WWkeiCfbCEpxIo5BMlJX69BxVgCF6Sjz0Mr3kznTMnYLZSOHuNLw404oKExTMrXajd0NxiqR/+xx2Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930728; c=relaxed/simple;
	bh=/FNmG4Db7/smwKmWct4+UV0rLkG/XBrifokthL+BGIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLso2Az5IZTUzr+6lxoQtqt2S0cFh/gszaRHjICBnOT4FXhj5IIMJNteg6tRANdnyTIw3l2pblV0fYdQrq14IrCScOPlrus/02nOX3zX7ShOhWAKYnZcc4+F2Ck39H2cyI2xNvyaTaowYJHKNDVsL3rwGZC2BlCWOvXIXfA5py0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTWHijLq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C9B1F00893;
	Mon,  8 Jun 2026 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780930719;
	bh=GVWjofmVySRixplnTaf7ZAf1EmqIzm6F4hlI93gCH1g=;
	h=From:To:Cc:Subject:Date;
	b=kTWHijLqTvw5Dr9xEj1sYWFhs5yINW2iahb07jv/EYDtxRQ9dpCq/asjyuP2FDvxd
	 KA1M/yXawQ99pb7YqNxhQ+kcEFr1nvnvjfZTuN5iyH1CKTgcu/+/5Fm7wyHdbXuitL
	 t/ihGBo/+E9UtxPWONOn+79ux/gMkHrMXC22KwqSdbQIEvsBKFZLwOcyQliHZ45z4g
	 yRg0zdQFigFePAoMfCBTFmbHy2wY88EaUbt925TIG/8nOZou9hbI2oPyv9xqz1ueF4
	 b2PE1q+aMAni+e8zre90TnDU0STO+0ddOh/3tmPPuel1sZItAThiITjShf3+QdQrMz
	 aSX2uacp2dm8Q==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWbQz-00000000I3V-1jK6;
	Mon, 08 Jun 2026 16:58:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: ulpi: fix memory leak on registration failure
Date: Mon,  8 Jun 2026 16:58:03 +0200
Message-ID: <20260608145803.69360-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heikki.krogerus@linux.intel.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639866585C9

The allocated device name is never freed on early ULPI device
registration failures.

Fix this by initialising the device structure earlier and releasing the
initial reference whenever registration fails.

Fixes: 289fcff4bcdb ("usb: add bus type for USB ULPI")
Cc: stable@vger.kernel.org	# 4.2
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/common/ulpi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 9b69148128e5..7e43429e996e 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -281,28 +281,24 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
 	ulpi->dev.type = &ulpi_dev_type;
+
+	device_initialize(&ulpi->dev);
+
 	dev_set_name(&ulpi->dev, "%s.ulpi", dev_name(dev));
 
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
 	ret = ulpi_of_register(ulpi);
-	if (ret) {
-		kfree(ulpi);
+	if (ret)
 		return ret;
-	}
 
 	ret = ulpi_read_id(ulpi);
-	if (ret) {
-		of_node_put(ulpi->dev.of_node);
-		kfree(ulpi);
+	if (ret)
 		return ret;
-	}
 
-	ret = device_register(&ulpi->dev);
-	if (ret) {
-		put_device(&ulpi->dev);
+	ret = device_add(&ulpi->dev);
+	if (ret)
 		return ret;
-	}
 
 	root = debugfs_create_dir(dev_name(&ulpi->dev), ulpi_root);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
@@ -334,9 +330,10 @@ struct ulpi *ulpi_register_interface(struct device *dev,
 	ulpi->ops = ops;
 
 	ret = ulpi_register(dev, ulpi);
-	if (ret)
+	if (ret) {
+		put_device(&ulpi->dev);
 		return ERR_PTR(ret);
-
+	}
 
 	return ulpi;
 }
-- 
2.53.0


