Return-Path: <stable+bounces-249739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BA4KJkqDWo2uAUAu9opvQ
	(envelope-from <stable+bounces-249739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:29:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DB5873AF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A213050F54
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50663502B8;
	Wed, 20 May 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ayDQS8Ud"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03E3264EF;
	Wed, 20 May 2026 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247503; cv=none; b=AWPimjaXcxS+9wB3FsOTiLSV37Qdazm7yhv6axhEA5S2dJksalV3Gl7jxs95immEKFUXGRpIOWhvD8pxvbEDUE0q2k4pD2YTtxSoe7XPI1I3ny2xSdm7hwcZxKr57dkukM9knjgLGu3Lt1nNG8z6Wm5h3ctbcV6hiBTD08xl6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247503; c=relaxed/simple;
	bh=yIlGbEWgTQQCHcLeUsvi6UTnrr3qjqitrxenDUtS60w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2J5QLu6ID4mJCGcq0/5xRyQWSJVYHVBJrWzJeT3P63x96QWjEM0SOWUn1FspSuBdvuE+Qywc2+ku9fLiEhSdGqndZkC/q3PB48SfC4eQ8TTUVr3TkYH0QDBSwnul02BrqOupoJr3FNSpjG5ySCDrIdSFDBZm9sqLSmt3aeALQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ayDQS8Ud; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fb
	nt9BLA6TnBGRQs0Uul0F8gUmr2OghryrkcVMdfDZ8=; b=ayDQS8UdIiEkWOWOih
	X6f8aksawT9FoInVp8afmueASudyzv8ce2r2i4tlPEnUpTM22rdWV+wLn1B1ioOU
	bn1KKT7JOdWTaxiwQVEXGLqwKToT1hk8xh44qtrIwKLMiNS8y/yZppUsjgq9AZ1T
	9fy8aTjtwOzwPOe7vKnaSPWi0=
Received: from DESKTOP-EQVOVNC.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3_7aAKQ1qxS2MFw--.40165S2;
	Wed, 20 May 2026 11:24:48 +0800 (CST)
From: Li Xinyu <xinyuili@126.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: gyro: mpu3050: use devm_iio_trigger_register
Date: Wed, 20 May 2026 11:24:47 +0800
Message-Id: <20260520032447.1683688-1-xinyuili@126.com>
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
X-CM-TRANSID:PikvCgD3_7aAKQ1qxS2MFw--.40165S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18tw4fWryfJry7ZF45trb_yoW8XryDp3
	ySgF98AFWkXr47AF4kZ3WkKFy7Ga45JrWF9rWUCryYq3y3Cr1xKr1YqFW2vr18ZFWUWF4U
	JrWrWrZ0kFZ7ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6RR_UUUUU=
X-CM-SenderInfo: 50lq53xlolqiyswou0bp/xtbBrwBIkGoNKYBeoQAA3G
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249739-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xinyuili@126.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 476DB5873AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpu3050_trigger_probe() allocates the DRDY trigger with
devm_iio_trigger_alloc() but registers it with plain
iio_trigger_register(). The remove callback calls free_irq()
on the trigger but never calls iio_trigger_unregister(), so on
module unload the trigger remains in the global trigger list
while its memory is freed by devm, leaving a dangling entry.

Switch to devm_iio_trigger_register() so the registration is
undone automatically in the same devm scope as the allocation.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xinyu <xinyuili@126.com>
---
Changes in v2:
- Corrected the name format in Signed-off-by from "lixinyu" to proper
  "Li Xinyu". Sorry for the mistake in v1. Thank you Maxime.
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..bcfa83a46737 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1127,7 +1127,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	mpu3050->trig->ops = &mpu3050_trigger_ops;
 	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
 
-	ret = iio_trigger_register(mpu3050->trig);
+	ret = devm_iio_trigger_register(mpu3050->dev, mpu3050->trig);
 	if (ret)
 		goto err_iio_trigger;
 
-- 
2.34.1


