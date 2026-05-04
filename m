Return-Path: <stable+bounces-243472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oILoJkiq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806284BEF61
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80D39302AB5F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8023DDDD6;
	Mon,  4 May 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AEf32kHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F7377575;
	Mon,  4 May 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903972; cv=none; b=L/yjf0o/QkWmuurJF7HgNWHHE4Xou/tNia5JYaLD0VpEWLYAPp+b0aYzTnz81QbeHTZwaJDDiU+qpjpQ43HcoSTi3WwRlqhjfTk2FjqIYj47zLvj8kwJoc6OHVPWL2CFhIWTo6WhuQdyxOVHkMi/bN13EwTG4Xv5EGGaYdY410k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903972; c=relaxed/simple;
	bh=D8pkiSwNKBd73gPOjVdafhwkeI86bqYLzVwQeG0sJ/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoS+KKyM8IcRDGl6xLRJBMnx6ZQk9YaeCZu8Wiqgnkk/nfA5/qpjjpgFrgPBawsQVCHwZh5MALeYHntw61F5PRc8MKGMmVuP4+5uuLzbQwlM0uSFykygtxLSjdKX8tbDO48daApEfHQfVyrHGTLTb2hiynbe/QAlymICkst1su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEf32kHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA4C2BCB8;
	Mon,  4 May 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903971;
	bh=D8pkiSwNKBd73gPOjVdafhwkeI86bqYLzVwQeG0sJ/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEf32kHfQmsoBHD5EJD6z0QIJWELbItaM5dKYMt/vhQb9uScdsY4kPoIVh0/W/7SN
	 pA8GyNrFU0RU1lOqqLLaFSFGmhk0EcehreU5mh4yMRo71f2cMbLTo16xRq65zKxAKq
	 eMJnX00OAPpXgHRAGRTeGCK8jPh1yuuq1r2RMKGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saravana Kannan <saravanak@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 134/275] spi: fix resource leaks on device setup failure
Date: Mon,  4 May 2026 15:51:14 +0200
Message-ID: <20260504135147.884756062@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 806284BEF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243472-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit db357034f7e0cf23f233f414a8508312dfe8fbbe upstream.

Make sure to call controller cleanup() if spi_setup() fails while
registering a device to avoid leaking any resources allocated by
setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410154907.129248-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi.c |   61 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,6 +43,8 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_st
 
 #include "internals.h"
 
+static int __spi_setup(struct spi_device *spi, bool initial_setup);
+
 static DEFINE_IDR(spi_controller_idr);
 
 static void spidev_release(struct device *dev)
@@ -729,7 +731,7 @@ static int __spi_add_device(struct spi_d
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi_setup(spi);
+	status = __spi_setup(spi, true);
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
@@ -3854,27 +3856,7 @@ static int spi_set_cs_timing(struct spi_
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
@@ -3959,7 +3941,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -3968,7 +3950,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -4004,6 +3986,37 @@ int spi_setup(struct spi_device *spi)
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
 



