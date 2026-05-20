Return-Path: <stable+bounces-249727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNHSMocfDWoutgUAu9opvQ
	(envelope-from <stable+bounces-249727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:42:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFD586E96
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEF6A303811D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA430C35C;
	Wed, 20 May 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ldkHXl6O"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340126A0A7;
	Wed, 20 May 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244932; cv=none; b=k/gmZWlcqE419kU1xfP7k36XgthJHiFX1+RrayGasdirC7awbn/zOeIggS6Z1nBGNvUJx9TXuV+LbI8/gdKpEtl9sJEdvZ9TFnbOy/8ucs7Va8VhFr28T8AXgX5fYFQtmOPd+mEgYbvQvcKfoAK1fRp9tOdNj+8ISoZ2CSBhgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244932; c=relaxed/simple;
	bh=tWmype1Tgs54oM0Wg9FCC5Mksc3DDc/gNlq7XYu61Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTWBU2N83916APQSmvSutIzOM8ylibQY/Ua2DbbW1+fcM5WlLSDJVQS3JcOQwGw9SV9H9wQ9Oawr73C7vRYieUrHr5GnXEc//cekayQuIpCHH2RDmY0CeT83SdOTrMcgC9ttSyZyrpiqI8gs9qu7a9MAaWO5REn1nyKEYdYGCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ldkHXl6O; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kR
	afqq1UhqjZ5Mx3B2zl1lqgY7QxCW3Z1AD14mfIzKE=; b=ldkHXl6OUKhYdV0SLx
	WeLVPwqlu+YWNlF4mBtDt3UPu2i0wh3sY+Oc90PtMSE/CCHaDWaifKz6CErfkQ+v
	NaooVAyaazGfuGAeCSGNe5K1JkUhfTS1Iq78T7ZpeHzx4txymOZNhic05wbqmrm5
	NvbkaVxlDVaHfS4Z64g0gvffc=
Received: from DESKTOP-EQVOVNC.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7pyHw1qdnQjBw--.22792S2;
	Wed, 20 May 2026 10:41:54 +0800 (CST)
From: lixinyu <xinyuili@126.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] iio: gyro: mpu3050: use devm_iio_trigger_register
Date: Wed, 20 May 2026 10:41:53 +0800
Message-Id: <20260520024153.1647951-1-xinyuili@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7pyHw1qdnQjBw--.22792S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18tw4fWryfJry7ZF45trb_yoW8Gr13p3
	yfuF98AFZ5Xr47AF4ku3WkKFy7Jay5ArWF9rW8CryYqay3Cr1xKr1YqFW2vr18ZFWUWF4U
	JrWrW390kFZrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6RR_UUUUU=
X-CM-SenderInfo: 50lq53xlolqiyswou0bp/xtbBrxLBCmoNH3KcpAAA3E
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249727-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DDFD586E96
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
Signed-off-by: lixinyu <xinyuili@126.com>
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


