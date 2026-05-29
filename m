Return-Path: <stable+bounces-256744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKKjKvnpGWqFzwgAu9opvQ
	(envelope-from <stable+bounces-256744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F2607E8C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7119830242A3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5853769ED;
	Fri, 29 May 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOboKJnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C603342146
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083187; cv=none; b=WgFKskK0ULbjKO/NW44/kdhfciWViYqd3xaSUFtEdzAO0sWbmaTOnxB+J3+OKstBIhWnljIxzWCjvnz7Qm1Ta3BL6Sqvgx/bisa6s71HN3w2YyPGbaEdP+3Dg7HkMtQVsONtHRxsiHETpgwbF9wjqWN16Qa3TfUysJ2kuSzmycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083187; c=relaxed/simple;
	bh=TBYA2FLhb+sGQwx+gG5rChY/3Yua2ZGlzTbIDUtQ33o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ol7rDCPX83/qaRPtkGj1Wgi/1MpuiRK4W6KAIL/2EmtQQtLGIAlkexLMtu1xa43HZTF+g4Gb553+GUVvIh3vRmoE5c0PVvxiH5Zj1bTu9cT23P2WxS8/swH016+uZpbejm1Lj1BZqHsUuECCpJ8GKMyL3fz1AvN1klWbJHglzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOboKJnn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C861F00898;
	Fri, 29 May 2026 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780083186;
	bh=WUadCp/XomiZbw0ohsJXAyrmj6rOOZIB9uybhCZP1hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOboKJnnt4OTPSsMMDiK2oUPxEK/9WoPbOjX1yMrBIZ8HvQQzgbiWAVZDcZCo9cXN
	 3ktm6FaYVTDZf55pAbXK1tPMYMGZx0ySgsEweRRmeRRN3+080ZgyRBbGdYkFWD2Epv
	 OSBiMRyouIgL95wCZYwgahlW5tgV7VclicuwSV3q5/SPDLjEemUztRI2Pea35QAaKr
	 rexhIgVTHD/oo+RfTOMc4khB4EO0+JVaG+gATKySdA2DwNhk/iK91xmwgEXZgRtaHA
	 mbxwQF0cUzR645dAM9IYMevuBSyDALrdkIA33vyboUVHhWfvO17Z9XAsc6hkbsbOSo
	 WaUTIBO4iDV0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] serdev: Provide a bustype shutdown function
Date: Fri, 29 May 2026 15:33:01 -0400
Message-ID: <20260529193303.1704693-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529193303.1704693-1-sashal@kernel.org>
References: <2026052800-unloving-guileless-afb9@gregkh>
 <20260529193303.1704693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256744-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,linuxfoundation.org:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A84F2607E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 6d71c62b13c33ea858ab298fe20beaec5736edc7 ]

To prepare serdev driver to migrate away from struct device_driver::shutdown
(and then eventually remove that callback) create a serdev driver shutdown
callback and migration code to keep the existing behaviour. Note this
introduces a warning for each driver at register time that isn't converted
yet to that callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/ab518883e3ed0976a19cb5b5b5faf42bd3a655b7.1765526117.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 375ba7484132 ("Bluetooth: hci_qca: Convert timeout from jiffies to ms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serdev/core.c | 21 +++++++++++++++++++++
 include/linux/serdev.h    |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 75c42fa1b5de7..b09a873b5db71 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -441,11 +441,21 @@ static void serdev_drv_remove(struct device *dev)
 	dev_pm_domain_detach(dev, true);
 }
 
+static void serdev_drv_shutdown(struct device *dev)
+{
+	const struct serdev_device_driver *sdrv =
+		to_serdev_device_driver(dev->driver);
+
+	if (dev->driver && sdrv->shutdown)
+		sdrv->shutdown(to_serdev_device(dev));
+}
+
 static const struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,
 	.remove		= serdev_drv_remove,
+	.shutdown	= serdev_drv_shutdown,
 };
 
 /**
@@ -839,6 +849,14 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
+static void serdev_legacy_shutdown(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct device_driver *driver = dev->driver;
+
+	driver->shutdown(dev);
+}
+
 /**
  * __serdev_device_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
@@ -855,6 +873,9 @@ int __serdev_device_driver_register(struct serdev_device_driver *sdrv, struct mo
 	/* force drivers to async probe so I/O is possible in probe */
         sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
 
+	if (!sdrv->shutdown && sdrv->driver.shutdown)
+		sdrv->shutdown = serdev_legacy_shutdown;
+
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index f5f97fa25e8ad..29538c5bf5449 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -65,6 +65,7 @@ struct serdev_device_driver {
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
+	void	(*shutdown)(struct serdev_device *);
 };
 
 static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-- 
2.53.0


