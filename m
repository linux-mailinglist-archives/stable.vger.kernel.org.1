Return-Path: <stable+bounces-220512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKtsAbY5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF191C65F2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D524830FC121
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2F481A96;
	Sat, 28 Feb 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQm+Zbwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEED3CA79B;
	Sat, 28 Feb 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300396; cv=none; b=FnWEoEQU2OXVNYW3GddgnWzuzGmw1dOMGdSRKLp7aDVrPMhBROX4KQ2cohUSEpSnPD6fGfeEjxGTQE+Ho5uk3/rWqtTyvHPE6lauMlj+7uBO+p9G1OT94dTVpZYTHRbsFlUsU3LCfAmL52eAuR8XGK3MzX4v8eM4yqKMS6I0xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300396; c=relaxed/simple;
	bh=M2hlIiwEZWSkqOgs9cGI/Zl461ZEg2wPTS4lRx17/Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faBqJAPxlWx/DXIY3Zg9E6CoHyPVmAcIr3VceYphg/VILtYgCOuOcQa2kTh6AHYpIP/90yeMwRp7fJmjdcF9cxp/zIe72wzlzBgvU4KcfLMW33z0yDd8zGVZzyyJTG9WyUGY+nsnDTmqaxbT/66+QpbcPzpzwZBYiNsCj1Nrwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQm+Zbwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD304C19425;
	Sat, 28 Feb 2026 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300396;
	bh=M2hlIiwEZWSkqOgs9cGI/Zl461ZEg2wPTS4lRx17/Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQm+ZbwaNjrcJhCLaguoxRVFVM0dRLFDfE42Ihc33SUw89Bx/6pb5K6nt942bPkTX
	 miR9Sy154/dQBpE2NoLMncnEnIyBLNuJ7XDsISrFqzYxv2HpBhy7FICTgzUdw0NYp/
	 QWHTtxrDEMSZjJULxDpEprLqLi1Piv+VZWwPBxlmZ3/vUE0GVgG+Gfx8kYA5+59cTf
	 OvzHKu5ygE80BRlmFOEgY2wN77hs+l5FSP0khHNEewfRoiRx4cz1F7LzVmzmIk2gN0
	 SdBB+QWvhjc2dS3JZwliMgv5rMrsby8f+1rt66W+Aiwd6GvDmy6kDcre/HtdOaOgzb
	 ZGk5Sd5LObMMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabian Godehardt <fg@emlix.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 433/844] spi: spidev: fix lock inversion between spi_lock and buf_lock
Date: Sat, 28 Feb 2026 12:25:46 -0500
Message-ID: <20260228173244.1509663-434-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220512-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BCF191C65F2
X-Rspamd-Action: no action

From: Fabian Godehardt <fg@emlix.com>

[ Upstream commit 40534d19ed2afb880ecf202dab26a8e7a5808d16 ]

The spidev driver previously used two mutexes, spi_lock and buf_lock,
but acquired them in different orders depending on the code path:

  write()/read(): buf_lock -> spi_lock
  ioctl():       spi_lock -> buf_lock

This AB-BA locking pattern triggers lockdep warnings and can
cause real deadlocks:

  WARNING: possible circular locking dependency detected
  spidev_ioctl() -> mutex_lock(&spidev->buf_lock)
  spidev_sync_write() -> mutex_lock(&spidev->spi_lock)
  *** DEADLOCK ***

The issue is reproducible with a simple userspace program that
performs write() and SPI_IOC_WR_MAX_SPEED_HZ ioctl() calls from
separate threads on the same spidev file descriptor.

Fix this by simplifying the locking model and removing the lock
inversion entirely. spidev_sync() no longer performs any locking,
and all callers serialize access using spi_lock.

buf_lock is removed since its functionality is fully covered by
spi_lock, eliminating the possibility of lock ordering issues.

This removes the lock inversion and prevents deadlocks without
changing userspace ABI or behaviour.

Signed-off-by: Fabian Godehardt <fg@emlix.com>
Link: https://patch.msgid.link/20260211072616.489522-1-fg@emlix.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 63 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a0160f6dc3dc..f28528ed1c24e 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -74,7 +74,6 @@ struct spidev_data {
 	struct list_head	device_entry;
 
 	/* TX/RX buffers are NULL unless this device is open (users > 0) */
-	struct mutex		buf_lock;
 	unsigned		users;
 	u8			*tx_buffer;
 	u8			*rx_buffer;
@@ -102,24 +101,6 @@ spidev_sync_unlocked(struct spi_device *spi, struct spi_message *message)
 	return status;
 }
 
-static ssize_t
-spidev_sync(struct spidev_data *spidev, struct spi_message *message)
-{
-	ssize_t status;
-	struct spi_device *spi;
-
-	mutex_lock(&spidev->spi_lock);
-	spi = spidev->spi;
-
-	if (spi == NULL)
-		status = -ESHUTDOWN;
-	else
-		status = spidev_sync_unlocked(spi, message);
-
-	mutex_unlock(&spidev->spi_lock);
-	return status;
-}
-
 static inline ssize_t
 spidev_sync_write(struct spidev_data *spidev, size_t len)
 {
@@ -132,7 +113,8 @@ spidev_sync_write(struct spidev_data *spidev, size_t len)
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+
+	return spidev_sync_unlocked(spidev->spi, &m);
 }
 
 static inline ssize_t
@@ -147,7 +129,8 @@ spidev_sync_read(struct spidev_data *spidev, size_t len)
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+
+	return spidev_sync_unlocked(spidev->spi, &m);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -157,7 +140,7 @@ static ssize_t
 spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status;
+	ssize_t			status = -ESHUTDOWN;
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
@@ -165,7 +148,11 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 
 	spidev = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spidev->spi_lock);
+
+	if (spidev->spi == NULL)
+		goto err_spi_removed;
+
 	status = spidev_sync_read(spidev, count);
 	if (status > 0) {
 		unsigned long	missing;
@@ -176,7 +163,9 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 		else
 			status = status - missing;
 	}
-	mutex_unlock(&spidev->buf_lock);
+
+err_spi_removed:
+	mutex_unlock(&spidev->spi_lock);
 
 	return status;
 }
@@ -187,7 +176,7 @@ spidev_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status;
+	ssize_t			status = -ESHUTDOWN;
 	unsigned long		missing;
 
 	/* chipselect only toggles at start or end of operation */
@@ -196,13 +185,19 @@ spidev_write(struct file *filp, const char __user *buf,
 
 	spidev = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spidev->spi_lock);
+
+	if (spidev->spi == NULL)
+		goto err_spi_removed;
+
 	missing = copy_from_user(spidev->tx_buffer, buf, count);
 	if (missing == 0)
 		status = spidev_sync_write(spidev, count);
 	else
 		status = -EFAULT;
-	mutex_unlock(&spidev->buf_lock);
+
+err_spi_removed:
+	mutex_unlock(&spidev->spi_lock);
 
 	return status;
 }
@@ -379,14 +374,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	ctlr = spi->controller;
 
-	/* use the buffer lock here for triple duty:
-	 *  - prevent I/O (from us) so calling spi_setup() is safe;
-	 *  - prevent concurrent SPI_IOC_WR_* from morphing
-	 *    data fields while SPI_IOC_RD_* reads them;
-	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
-	 */
-	mutex_lock(&spidev->buf_lock);
-
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
@@ -510,7 +497,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -541,9 +527,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 		return -ESHUTDOWN;
 	}
 
-	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
-	mutex_lock(&spidev->buf_lock);
-
 	/* Check message and copy into scratch area */
 	ioc = spidev_get_ioc_message(cmd, u_ioc, &n_ioc);
 	if (IS_ERR(ioc)) {
@@ -564,7 +547,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	kfree(ioc);
 
 done:
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -802,7 +784,6 @@ static int spidev_probe(struct spi_device *spi)
 	/* Initialize the driver data */
 	spidev->spi = spi;
 	mutex_init(&spidev->spi_lock);
-	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
 
-- 
2.51.0


