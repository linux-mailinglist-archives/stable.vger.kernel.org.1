Return-Path: <stable+bounces-220478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJzsGbQ4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18C1C64BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FC5D314ADBD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4AE3C4C38;
	Sat, 28 Feb 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz49rJpY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC143C4C2F;
	Sat, 28 Feb 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300364; cv=none; b=LKlbzNfsw6ZA7vjlmIS7HuYbB3OEm+kVy3BKWvZFn7pBp4yqEPUdpter4xHERH4WtoJA9NQy6r8GrGtGfR3iZOzN4MF6rQXDV0fbvLATF30q9zqfVOICStaUnHs33J5O4jx4aVnxPsO7ZpNm8SP7QuYaGunVdDSrTax2EyRb/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300364; c=relaxed/simple;
	bh=f1c3761UCRyf4cWsV3oJHwqJWcKxzIdOUIZpC3Sf0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHq0qQvTXN46Cn/THKAr8m1+8Qhf4QPiPHAIkexk4VDpvyhNKCpgJcEnCwPpVb20jW6xRquj8vogYiFuG0AMZfi86nC8rSLmwcANs2PpDnxBCRG4dJAcJFE9M+UmOOON46D8+it7MdsVX84DBK0GzeNBzCdfyqErWx26sBxQAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz49rJpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE3C19425;
	Sat, 28 Feb 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300364;
	bh=f1c3761UCRyf4cWsV3oJHwqJWcKxzIdOUIZpC3Sf0GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wz49rJpYgJMWxeoR7ZIRnFLfkYBBzAvj7WUWQwbj2B0x1YJ27urqDwUw/eQkl9fHJ
	 b3oFUFVf8RqmpwV61U+QPmmyGCUBpIJLojwug82VJgCZVrlgwbNtKKMboGfF9MpwDD
	 EbIiL+IqkhWu0ABJq16y3I8K8S1FT5juh/qK7LKu3dByRSN0BVZtdpMNEf1YM8wxVk
	 IXgmYHYa/5xLASW4bfPsqFfZWGit0hyz+pQjFWBszA3FEWoiP0QvVZPQSScYbWgC2X
	 mKoHqp/AxnpddAJ5YF2vBByHZjl3Ui/kXkPArn+UDf0WHk/P4TlQquzrcjC9RAVYc7
	 5Imw7q2D02qyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 399/844] iio: Use IRQF_NO_THREAD
Date: Sat, 28 Feb 2026 12:25:12 -0500
Message-ID: <20260228173244.1509663-400-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[huawei.com:server fail,intel.com:server fail,tor.lore.kernel.org:server fail,linutronix.de:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220478-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EF18C1C64BC
X-Rspamd-Action: no action

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 04d390af97f2c28166f7ddfe1a6bda622e3a4766 ]

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
other interrupt handler and this supposed to happen from within the
hardirq.

Use IRQF_NO_THREAD to forbid forced-threading.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/bma180.c        | 5 +++--
 drivers/iio/adc/ad7766.c          | 2 +-
 drivers/iio/gyro/itg3200_buffer.c | 8 +++-----
 drivers/iio/light/si1145.c        | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 8925f5279e627..7bc6761f51354 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -986,8 +986,9 @@ static int bma180_probe(struct i2c_client *client)
 		}
 
 		ret = devm_request_irq(dev, client->irq,
-			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
-			"bma180_event", data->trig);
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       "bma180_event", data->trig);
 		if (ret) {
 			dev_err(dev, "unable to request IRQ\n");
 			goto err_trigger_free;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 4d570383ef025..1e6bfe8765ab3 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -261,7 +261,7 @@ static int ad7766_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
 		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);
 		if (ret < 0)
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index a624400a239cb..cf97adfa97274 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -118,11 +118,9 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = request_irq(st->i2c->irq,
-			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
-			  "itg3200_data_rdy",
-			  st->trig);
+	ret = request_irq(st->i2c->irq, &iio_trigger_generic_data_rdy_poll,
+			  IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			  "itg3200_data_rdy", st->trig);
 	if (ret)
 		goto error_free_trig;
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index f8eb251eca8dc..ef0abc4499b74 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1248,7 +1248,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = devm_request_irq(&client->dev, client->irq,
 			  iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
 	if (ret < 0) {
-- 
2.51.0


