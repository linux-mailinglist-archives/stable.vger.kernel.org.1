Return-Path: <stable+bounces-262110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BPmFLGIcJ2oysAIAu9opvQ
	(envelope-from <stable+bounces-262110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:47:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 118DA65A24B
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Bhqcydht;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262110-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262110-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40F1302F72B
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EC3E6DD4;
	Mon,  8 Jun 2026 19:44:41 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2C387363
	for <Stable@vger.kernel.org>; Mon,  8 Jun 2026 19:44:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947881; cv=none; b=Yf8ibD9WZ8DMmTPDXE45/Xt+DyHK6YeEIQ/XrE6r1qpuhqt5mj/uqJb0Znk6pWAP0UPAEmeD+r8AcVrPc5XXxTefVIKLPC1r+/5GIErhbmMbMh9P2i9NwINd3b4gUBIMPZ9XdLtnbg7DNsaxtmwrPgrzKsIDBiGXO/DaiMZLsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947881; c=relaxed/simple;
	bh=e2m3DlP5qcloOEOwU1950SddAEQ8h3eh4x0BYx6svPQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hlW1p3EDJe3msvlMdEmDFQdgbo11+R1LzzgH1RuaSpggOUj9lJxsklcvVfpIthEaG+QK8kyui29rEpJ779gLbpey2iW6QG7kkCllDsCah2iaVnOkGuPPeggh9Uvn/RVCbPJL6jkrXMIfS6zy26btxk7ZPT8ODuWUEpFgcoFIMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bhqcydht; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C721F00893;
	Mon,  8 Jun 2026 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780947879;
	bh=bSO8dMS6dq2mHNIZyWQntofkLkGvzPyzno5m90Sr07w=;
	h=Subject:To:From:Date;
	b=BhqcydhtRztt6VFgcsw05Ok0KBrBYXyBOMUHrISEjFf8dY2r59GWyn0c/HvXWsa8g
	 iOyfiMhC4gkliZOUZ+d5mQ1CDc/hlRmXYmT2dDO7e2DMbd2pGwXxSweID6h+2uAUs/
	 7X2ceh9fEuzCadDMFLwhFYCU6+/AJLVFkwwHZ1uA=
Subject: patch "iio: magnetometer: ak8975: ensure device is awake for buffered" added to char-misc-testing
To: joshua.crofts1@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:30:45 +0200
Message-ID: <2026060845-stubbed-pushiness-f1eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262110-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashiko-bot@kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 118DA65A24B


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: ak8975: ensure device is awake for buffered

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From eaead586b3d95890832449f2887283b067426ecc Mon Sep 17 00:00:00 2001
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 16:35:52 +0200
Subject: iio: magnetometer: ak8975: ensure device is awake for buffered
 capture

Currently, the ak8975_start_read_axis() can be called while the device
is autosuspended, causing two issues:

1. I2C transfers in the aforementioned function will fail or timeout
because ak8975_runtime_suspend() disables the device regulators.
2. Since ak8975_fill_buffer() does not hold runtime references,
ak8975_runtime_suspend() can run concurrently, and since PM callbacks
do not use a locking mechanism, it may cause a race accessing the
control register via the I2C bus.

Fix this issue by adding struct iio_buffer_setup_ops that contains
preenable and postdisable functions to ensure correct that device is
powered on when running a buffered capture.

Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6%40gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/magnetometer/ak8975.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dbab4d0bba34..0fb2fd03d11c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -899,6 +899,28 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ak8975_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int ak8975_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
+	.preenable = ak8975_buffer_preenable,
+	.postdisable = ak8975_buffer_postdisable,
+};
 static int ak8975_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -992,7 +1014,7 @@ static int ak8975_probe(struct i2c_client *client)
 	indio_dev->name = name;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
-					 NULL);
+					 &ak8975_buffer_setup_ops);
 	if (ret) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
 		goto power_off;
-- 
2.54.0



