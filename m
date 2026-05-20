Return-Path: <stable+bounces-250016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KqfDhnbDWrE4AUAu9opvQ
	(envelope-from <stable+bounces-250016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:02:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145C591655
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C200B329DB76
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06853ED5C8;
	Wed, 20 May 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="agsvUjDt"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3A35200B;
	Wed, 20 May 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290588; cv=none; b=q4fT2unOhVXYLwYppOhvrCdgTe6KZ4LO3SdecAWx1OysOevtYVDCmmzCUN7Sjge9daYocHbPHouqZ4V489AdJ3jv5lLklheFUOh+/i8CnBAF4WVjViCDERIVqsaXU+jxSKyW+vv5xejsZ3VyQxSWDgsFpyp5hIl6EzNWkuv4HG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290588; c=relaxed/simple;
	bh=a17H+gRFUg3pQ2HqauP8NTee7OpsO1sruoyOJWfShag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjWH4LTKzcKJ6ha/Vq1MB5bsvPau/33RmdcBwl1n0ENbkmQSxBK+4HP96KKymA75MjWCyFGaZ/izmtdqjipHru7kYWU113dE47sVoxsnLtqAETNLt+pKHUru+u+hNBy8vyd49veou3RzYXx72ZNgjGnTuPM7/pfMTJYH77ZIxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=agsvUjDt; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZY
	RmUyaAiGT4IkJxlhlOOH2kilgKViBK3UgMW2hETPs=; b=agsvUjDtHVJ+I8iZpd
	GVVF8phkW3CNmFN+SRMKXcDk0IlTNOyFEZwOwAXDArEC09/xaTOBGN0Y5bbqbdV2
	Hj0u6Ao3Ow36mCWtIhEOCKG7rHbnUVXP6Z2KY+EACH1xlp1smOsaYtrwAVwxHSqg
	bat0QNMBc85Yqrk0kX7FEOG2E=
Received: from DESKTOP-EQVOVNC.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3l3+80Q1qquHuBw--.49396S2;
	Wed, 20 May 2026 23:22:37 +0800 (CST)
From: Li Xinyu <xinyuili@126.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: gyro: mpu3050: fix missing iio_trigger_unregister and irq cleanup
Date: Wed, 20 May 2026 23:22:36 +0800
Message-Id: <20260520152236.2308686-1-xinyuili@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520024153.1647951-1-xinyuili@126.com>
References: <20260520024153.1647951-1-xinyuili@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l3+80Q1qquHuBw--.49396S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry8WrWUXFy7GrWUJr17Awb_yoW5ur4rpw
	4fWF98CFZ5Xrn7Xr4kZ3WvgFy3JFWfArW8WrW8Wry2gay3CryrKr17tFy2qF10qry8Wr4U
	JrWrGrsYkF4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiFxUUUUUU=
X-CM-SenderInfo: 50lq53xlolqiyswou0bp/xtbBrh2ByWoN0b18kwAA3f
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250016-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xinyuili@126.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9145C591655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpu3050_trigger_probe() registers the DRDY trigger with
iio_trigger_register() but neither mpu3050_common_remove() nor
the error path in mpu3050_common_probe() calls
iio_trigger_unregister(). On module unload or probe failure the
trigger remains in the global trigger list while its memory is
freed by devm, leaving a dangling entry.

Also fix a use-after-free risk: when iio_trigger_register() fails,
mpu3050->irq remained set to a non-zero value, which would cause
mpu3050_common_remove() to attempt a double-free of the IRQ and
an unregister of a never-registered trigger. Clear mpu3050->irq
in the error path to prevent this.

Revert the v2 devm approach as requested by Jonathan: the driver
mixes devm and non-devm resource management, so the minimal fix
is to add the missing unregister calls and keep the existing
manual resource management style.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xinyu <xinyuili@126.com>
---
Changes in v3:
- Thanks Jonathan for the feedback on v2. Instead of mixing devm
  with non-devm resource management in probe, revert to plain
  iio_trigger_register() and add the missing iio_trigger_unregister()
  calls in the error path and remove callback.
- Also noticed that mpu3050->irq was set but not cleared when
  iio_trigger_register() fails in trigger_probe, which would
  cause a double-free on module unload. Set mpu3050->irq = 0
  in the error path to prevent this.

Changes in v2:
- Fixed the name format in Signed-off-by. Thanks Maxime for
  catching this.
---
 drivers/iio/gyro/mpu3050-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index bcfa83a46737..459d02aa3d18 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1127,7 +1127,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	mpu3050->trig->ops = &mpu3050_trigger_ops;
 	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
 
-	ret = devm_iio_trigger_register(mpu3050->dev, mpu3050->trig);
+	ret = iio_trigger_register(mpu3050->trig);
 	if (ret)
 		goto err_iio_trigger;
 
@@ -1137,6 +1137,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 
 err_iio_trigger:
 	free_irq(mpu3050->irq, mpu3050->trig);
+	mpu3050->irq = 0;
 
 	return ret;
 }
@@ -1260,8 +1261,10 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (irq)
+	if (mpu3050->irq) {
+		iio_trigger_unregister(mpu3050->trig);
 		free_irq(mpu3050->irq, mpu3050->trig);
+	}
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
 	mpu3050_power_down(mpu3050);
@@ -1278,8 +1281,10 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (mpu3050->irq)
+	if (mpu3050->irq) {
+		iio_trigger_unregister(mpu3050->trig);
 		free_irq(mpu3050->irq, mpu3050->trig);
+	}
 	iio_triggered_buffer_cleanup(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
-- 
2.34.1


