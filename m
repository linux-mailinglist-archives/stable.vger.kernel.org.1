Return-Path: <stable+bounces-243851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BJZNWm2+Gn1zAIAu9opvQ
	(envelope-from <stable+bounces-243851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:08:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F664C06DC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB5B306B35D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5CF3D6CA4;
	Mon,  4 May 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJk1HMCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7C3DE44E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906934; cv=none; b=iqLWvBz1HgaRj+5C98FuNIJwvgRFeq1mMuevSuSESGhX8s+Ao8ilQKkE7gguvHGXYWVMjkWfuCik3yEHcZQKQSmENSUkABIRpc6eGWIQqJBbmUmHNiFHF2wcvXu1uOZ7xgK6K0V+adXBix6Glplch2c00w9avF+kylorf6LeirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906934; c=relaxed/simple;
	bh=YsbALKglDdJLYRiHQwE70lHTaH4vRigUoLfbFhlBg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBm/8GDvkRsDSYv71CcYXxY0TCIN1MB6IUt3xqq5LyU1wMRbRd+q6GfdyfybIbq6DUcUOgNf6TsEbgaCIo4hn86U+rSC3eBAhsPqC1OUFECNSt0GFgEAOiYsJ6I5Q4P5Y9LTS86vD48LECg6UUOT/yLyPhsJjX7lJywLGJwSMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJk1HMCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EE3C2BCB8;
	Mon,  4 May 2026 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777906934;
	bh=YsbALKglDdJLYRiHQwE70lHTaH4vRigUoLfbFhlBg7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJk1HMCbquoDuKirbuwYXArQdU5wCT2MwN6mQOCKu1NbN3L88UI+yO9V45Bvki+us
	 cpbP2KlMj2kN5T+Jb04apki7ICrM6GSvqad1NR7opvmhjzv5HrAWHvrDNPVhAAGJFj
	 z6luo4SrAgjWsP+MeCJ4e/GQtlXWxNorSWLjFFThtXVLzhMJSOtdjNl09ZfWR8VOBf
	 SgHlcb2zlPRVhMSjRK7NUv5STFSjmDS0aLuNe1lWt9N70u7jiBetQjRNkueL/cKx0C
	 voNar4CrRcS06FIfytpwNlu9cPQUr3+VLkWGR9coqq16++VgmOZ2a+gXWqfZOomc0d
	 lFNmbDgSLBIyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] spi: fix resource leaks on device setup failure
Date: Mon,  4 May 2026 11:02:09 -0400
Message-ID: <20260504150209.2395361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050103-agenda-elm-a25e@gregkh>
References: <2026050103-agenda-elm-a25e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33F664C06DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243851-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]

From: Johan Hovold <johan@kernel.org>

[ Upstream commit db357034f7e0cf23f233f414a8508312dfe8fbbe ]

Make sure to call controller cleanup() if spi_setup() fails while
registering a device to avoid leaking any resources allocated by
setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410154907.129248-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 61 ++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 98f720652e079..3f58f9aa11790 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -42,6 +42,8 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
+static int __spi_setup(struct spi_device *spi, bool initial_setup);
+
 static DEFINE_IDR(spi_master_idr);
 
 static void spidev_release(struct device *dev)
@@ -666,7 +668,7 @@ static int __spi_add_device(struct spi_device *spi)
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi_setup(spi);
+	status = __spi_setup(spi, true);
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
@@ -3688,27 +3690,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
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
- * or from it.  When this function returns, the spi device is deselected.
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
 	int		status = 0;
@@ -3787,7 +3769,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -3796,7 +3778,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -3833,6 +3815,37 @@ int spi_setup(struct spi_device *spi)
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
2.53.0


