Return-Path: <stable+bounces-235637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBNvDGId2WmLmQgAu9opvQ
	(envelope-from <stable+bounces-235637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24303D9DD1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 665D930812EB
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0683DA7CF;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es0GasYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3623D903C;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836162; cv=none; b=Ukg/bLxKijszepc3KwM5Ym3v1vSTxce3j9m8zAl0AcA3nUkD7gD0VVp6wk/Ltypt4i7e/1rtFgAiTb+7q0wkZA8e5baFl2hyoBDLslWcQSDU4s6KZzLVUGFhw3KS17XvDY6KjtHy4sEEM1jEv+jLtbKWQ9CKcXXbx6ls3sh2I4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836162; c=relaxed/simple;
	bh=rVtKk+vhYWkR9k1Oiu7/We4EJMuGL7w+xUU08ZTg9yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsAl2jawGTgpCshpgtapduv4e6r0T4p6swqWgBsHermUcAq2cG9tE/gEWg7TkSRG0wUQ5ZE7l9MMswT2djgRF70WsNi+GFOJG+TUWL4fUZX67qOSM1qY0rG4P44Qf+5j4U2Skt7tZa6USHMbBzXTjLrlRqW4IPCMmZK0HSaUQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es0GasYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7DAC2BCB0;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836162;
	bh=rVtKk+vhYWkR9k1Oiu7/We4EJMuGL7w+xUU08ZTg9yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es0GasYkRKi4Pw+QektFE5ffTn7USDJCiY1sr6y/9KwjodVBieP8i4o3sD0rPDeVC
	 OddhCKW6UDEQAJTm364q0IOadegn0BeoluiPwQaznPeBpLN3g3VagmzqqfLOLkXP1P
	 kf700RW/7o04z3pvuOK7vGlnsx9h11bRUh2W1X0Mig+WxWmJUuNNmYR3jx6NTkZS9C
	 v7syC/EcnJxz+nJKEZhbWr0pvYgw6BeHjvoRlGC3RxG0zWTpCCVKnkxykloG3NZQar
	 kVAPtnO3vqy7IpQXR2fZEcGaGxEMuiCYaO4CNXnVld4uCrTQN45VGaqDzdJaMx7n5n
	 3STuDGmySrPkg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wBE6i-00000000Xd4-08ua;
	Fri, 10 Apr 2026 17:49:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] spi: fix resource leaks on device setup failure
Date: Fri, 10 Apr 2026 17:49:06 +0200
Message-ID: <20260410154907.129248-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410154907.129248-1-johan@kernel.org>
References: <20260410154907.129248-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235637-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E24303D9DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to call controller cleanup() if spi_setup() fails while
registering a device to avoid leaking any resources allocated by
setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 61 ++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 272b45d6b5aa..c14f29457c29 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,6 +43,8 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
+static int __spi_setup(struct spi_device *spi, bool initial_setup);
+
 static DEFINE_IDR(spi_controller_idr);
 
 static void spidev_release(struct device *dev)
@@ -726,7 +728,7 @@ static int __spi_add_device(struct spi_device *spi)
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi_setup(spi);
+	status = __spi_setup(spi, true);
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
@@ -3992,27 +3994,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
 	return status;
 }
 
-/**
- * spi_setup - setup SPI mode and clock rate
- * @spi: the device whose settings are being modified
- * Context: can sleep, and no requests are queued to the device
- *
- * SPI protocol drivers may need to update the transfer mode if the
- * device doesn't work with its default.  They may likewise need
- * to update clock rates or word sizes from initial values.  This function
- * changes those settings, and must be called from a context that can sleep.
- * Except for SPI_CS_HIGH, which takes effect immediately, the changes take
- * effect the next time the device is selected and data is transferred to
- * or from it.  When this function returns, the SPI device is deselected.
- *
- * Note that this call will fail if the protocol driver specifies an option
- * that the underlying controller or its driver does not support.  For
- * example, not all hardware supports wire transfers using nine bit words,
- * LSB-first wire encoding, or active-high chipselects.
- *
- * Return: zero on success, else a negative error code.
- */
-int spi_setup(struct spi_device *spi)
+static int __spi_setup(struct spi_device *spi, bool initial_setup)
 {
 	unsigned	bad_bits, ugly_bits;
 	int		status;
@@ -4097,7 +4079,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -4106,7 +4088,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -4142,6 +4124,37 @@ int spi_setup(struct spi_device *spi)
 			status);
 
 	return status;
+
+err_cleanup:
+	if (initial_setup)
+		spi_cleanup(spi);
+
+	return status;
+}
+
+/**
+ * spi_setup - setup SPI mode and clock rate
+ * @spi: the device whose settings are being modified
+ * Context: can sleep, and no requests are queued to the device
+ *
+ * SPI protocol drivers may need to update the transfer mode if the
+ * device doesn't work with its default.  They may likewise need
+ * to update clock rates or word sizes from initial values.  This function
+ * changes those settings, and must be called from a context that can sleep.
+ * Except for SPI_CS_HIGH, which takes effect immediately, the changes take
+ * effect the next time the device is selected and data is transferred to
+ * or from it.  When this function returns, the SPI device is deselected.
+ *
+ * Note that this call will fail if the protocol driver specifies an option
+ * that the underlying controller or its driver does not support.  For
+ * example, not all hardware supports wire transfers using nine bit words,
+ * LSB-first wire encoding, or active-high chipselects.
+ *
+ * Return: zero on success, else a negative error code.
+ */
+int spi_setup(struct spi_device *spi)
+{
+	return __spi_setup(spi, false);
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-- 
2.52.0


