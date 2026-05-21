Return-Path: <stable+bounces-253459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIdyAV+iDmpxAwYAu9opvQ
	(envelope-from <stable+bounces-253459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:12:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7024259F51F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E4C3044830
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2AA385D78;
	Thu, 21 May 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nG7yS2Ih"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB0367B82;
	Thu, 21 May 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343934; cv=none; b=kkjlbLqDY/ZKQm4qvatMOxn+jKerBALGzLAlE40li6cxoGrSZxKozev1LuYXFW+65XWvjs1iVBT6cJUEv/WIyIUpgIdoSYF+kKoFf8Mdegt1Kgkv1ph6FWJnYMiMNgZNuDitm4ZtkCok1q/7j5TxqqoyKkxydlDVG7kozfGQXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343934; c=relaxed/simple;
	bh=no8/ksF6iocgkvhCbfu2koPeZ6w4U5V6/KsTBkWB+Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xvcmn0jUieFhtUvM7ux6Ad6wx1NjST8ROgCP5l8+uiZeWXCRRkLagX4jpE9qtR8Bpc+nFZrYCijQ0DVBQQ6SwE60oFI3NBDGGbLarhiPmXswd+9XbUlBdTgruvEqK+CpeQ1fzoVQKlJQTmOgcxA8fQJWY7G/aU9tRmIWj8xIlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nG7yS2Ih; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mz
	HLUAcW99NN4f3Mos8xquCTzlyXA8yMa7BFIECulg0=; b=nG7yS2IhSL4OVKAJPF
	QJQupulxK3hgAMojjCpIbum84RMgGSgjDqnzzSkFk5ShEbLXxVXzxEy/mhogFTpQ
	00uVax8R/xG5v/qGFqxnwu7KReZ2Ry0EFcOwh2MWf0ol9nqRLh3OibER+SMJADyE
	rdcTrUewxBeQfrPADtjBNfNZ4=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXlHcFog5qqHUACg--.53269S2;
	Thu, 21 May 2026 14:11:19 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Fabian Godehardt <fg@emlix.com>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] spi: spidev: fix lock inversion between spi_lock and buf_lock
Date: Thu, 21 May 2026 14:10:51 +0800
Message-ID: <20260521061051.31928-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXlHcFog5qqHUACg--.53269S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF48Ar47tF45Xr4ftr1kKrg_yoWxAF4rpF
	W3KayxArsYyr4kXrn7Cw43uw15Xw18KFWUX347AFyfCF15urnIqFyUJFy8ZFWrJFyxurs8
	AF1vqry5Ar4Yvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWE_ZUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7AnIkWoOoglM8QAA3O
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253459-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,emlix.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,emlix.com:email]
X-Rspamd-Queue-Id: 7024259F51F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
[ Minor context conflict resolved. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
Testing:
  - Verified on Intel Alder Lake-N (x86_64) target running 6.6.137-yocto-standard
  - Kernel built with CONFIG_PROVE_LOCKING=y
  - Before patch: lockdep reports circular locking dependency (*** DEADLOCK ***)
  - After patch: reproducer runs cleanly with no lockdep warnings

---
 drivers/spi/spidev.c | 63 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 16bb4fc3a4ba..2024532dfc44 100644
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
@@ -376,14 +371,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ESHUTDOWN;
 	}
 
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
@@ -516,7 +503,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -547,9 +533,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 		return -ESHUTDOWN;
 	}
 
-	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
-	mutex_lock(&spidev->buf_lock);
-
 	/* Check message and copy into scratch area */
 	ioc = spidev_get_ioc_message(cmd, u_ioc, &n_ioc);
 	if (IS_ERR(ioc)) {
@@ -570,7 +553,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	kfree(ioc);
 
 done:
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -795,7 +777,6 @@ static int spidev_probe(struct spi_device *spi)
 	/* Initialize the driver data */
 	spidev->spi = spi;
 	mutex_init(&spidev->spi_lock);
-	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
 
-- 
2.43.0


