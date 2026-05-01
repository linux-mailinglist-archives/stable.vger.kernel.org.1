Return-Path: <stable+bounces-242398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOvJDlWZ9GlKCwIAu9opvQ
	(envelope-from <stable+bounces-242398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:15:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC14AC471
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 208133000FDB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0836215A;
	Fri,  1 May 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFPtDCaL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA72D9EF0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637713; cv=none; b=qjjpdR4+ysLSRxYcaRM9f7CuOHRPS5OJNGR/8a9+5kJz+I7XiMCgNg2vkkOCYbp6vqzJrgGgeeJIPfFUAivB5IZaqfLKFgBraeU+zd6/nfnQUhGMUHOAReEgGqJJE67r7/jaLyO+nkd8OlhEBkuiJTE6talAhuwqXH8yixH2UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637713; c=relaxed/simple;
	bh=OlBGiBI2om1A5sdT3aEz/yNnKYZUML7kAEb6lUr6erM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TFYYjVg5gCyXAWge9RxZ+YHW3JBHifzeVIpA5RVXZbdGN/U5XSTj92NGGFG3FtFVOnngH22T1Gn+9qr2Y1JJ1IHVI8hozHOzYvxZ/aUMVr78EJZZ6OXJ8Kb55U0LTiGAqWDQystsyTDHg9E1evo/AtvKtDuYP2YtaXklqt2lyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFPtDCaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AE8C2BCB4;
	Fri,  1 May 2026 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637713;
	bh=OlBGiBI2om1A5sdT3aEz/yNnKYZUML7kAEb6lUr6erM=;
	h=Subject:To:Cc:From:Date:From;
	b=PFPtDCaLiboOhdWIfRXc5rHcxyBdPN2RQa8lblDUVv/lCRd0vIwnV5a7229JDIfpY
	 ooNah4ubtvhM/Vxf9DLgFxsHly/amsfBOfKKYvw5P3Ahk71A+BldzeE6xdhWDnU2j/
	 Dt/Y4Scn4E8QuFgBjNssfL/Nx8r0lRLxr3KFDW3o=
Subject: FAILED: patch "[PATCH] spi: fix resource leaks on device setup failure" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,saravanak@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:15:02 +0200
Message-ID: <2026050102-whimsical-willpower-501f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCFC14AC471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x db357034f7e0cf23f233f414a8508312dfe8fbbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050102-whimsical-willpower-501f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db357034f7e0cf23f233f414a8508312dfe8fbbe Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 17:49:06 +0200
Subject: [PATCH] spi: fix resource leaks on device setup failure

Make sure to call controller cleanup() if spi_setup() fails while
registering a device to avoid leaking any resources allocated by
setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410154907.129248-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a0b2bd3b8186..3e434a9885bc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,6 +43,8 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
+static int __spi_setup(struct spi_device *spi, bool initial_setup);
+
 static DEFINE_IDR(spi_controller_idr);
 
 static void spidev_release(struct device *dev)
@@ -743,7 +745,7 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi_setup(spi);
+	status = __spi_setup(spi, true);
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
@@ -4049,27 +4051,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
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
@@ -4154,7 +4136,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -4163,7 +4145,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -4199,6 +4181,37 @@ int spi_setup(struct spi_device *spi)
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
 


