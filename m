Return-Path: <stable+bounces-260233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OzJzM+HZIGro8QAAu9opvQ
	(envelope-from <stable+bounces-260233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 03:50:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F7A63C471
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 03:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=XCvmztvG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260233-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260233-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 396D63061087
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D9283C9D;
	Thu,  4 Jun 2026 01:48:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A82773EC;
	Thu,  4 Jun 2026 01:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537713; cv=none; b=kme1Pk0ha8wUah7LIUBe5wJQu38pbr/3V5tfGUC5BvAkEu3z4Rg5pEg7XVsumae/hzJAh6rHsnaDJnUdBR0oMIG+nAGEILoNNgItCrW2SfGS2nCrW8eH+Bz8eQBEmYMZcCqbcdLnh/dDEAyHL9U2ZK0ThIm7m02LPDAT2164QPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537713; c=relaxed/simple;
	bh=CyX5E1duRZfAstyyD7ZTy8QUcWc9jGPvOtvLCer8Ypk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpPscrqgeL+ETZr8tnBdsTqu35IAg0qvx/2de+Tg131l5jsEO9tggBlGU9FMuIC1oi8+e0K2uyP2+36HO/zJXMplFWh/9LwzZLMMVWoyLdxZjepIoqxbksBFgPMXn/HBGHN6Lu5rD3R5Mc1mU006y+A51uchpIg4WFZE4lB7Nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=XCvmztvG; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40fe0c733;
	Thu, 4 Jun 2026 09:43:18 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
Date: Thu,  4 Jun 2026 09:42:46 +0800
Message-Id: <20260604014247.124724-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
References: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e904c94bc03a1kunme7d1e7a121c7f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkxMVkxDSkIfTUwYSR4dSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=XCvmztvGz/UIUFo+Kv42dPk3eSYPc7Fy8fEULeDjz0SO8o822pCUspCbDKbJ+XB/f6JxI/PDeR8CgcFGfjyoM6ydMSp/0YLn8V61ym3itJZpj2vMv433yMv7iexIJR2tBT2RqFg1bbuw7SQS51BZQwsmHPFUA0mGKWwtGm4dnnk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=pnZlTPto78irzPHpv6bYc2d42BXnVgDqcW0I4n2JKGA=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260233-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jic23@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andy@kernel.org,m:dlechner@baylibre.com,m:lars@metafoo.de,m:Michael.Hennerich@analog.com,m:nuno.sa@analog.com,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:mid,seu.edu.cn:dkim,seu.edu.cn:from_mime,seu.edu.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77F7A63C471

devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
through devm_request_irq() on the non-FIFO path, but it does not add
IRQF_NO_THREAD to the IRQ flags.

When the kernel is booted with forced IRQ threading, the parent IRQ can
otherwise be threaded by the IRQ core and the subsequent IIO trigger
child IRQ is then dispatched from irq/... thread context instead of
hardirq context. Because iio_trigger_generic_data_rdy_poll()
immediately drives iio_trigger_poll(), this violates the hardirq-only
IIO trigger helper contract and can push downstream trigger consumers
through the wrong execution context.

Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
non-FIFO request_irq() path, while preserving the current trigger
polarity and IRQF_NO_AUTOEN behavior.

Fixes: fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- move build/runtime validation notes to the cover letter

 drivers/iio/imu/adis_trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index d76e13cbac68..ae1506ca85fd 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -94,7 +94,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	else
 		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 				       &iio_trigger_generic_data_rdy_poll,
-				       adis->irq_flag,
+				       adis->irq_flag | IRQF_NO_THREAD,
 				       indio_dev->name,
 				       adis->trig);
 	if (ret)
@@ -103,4 +103,4 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	return devm_iio_trigger_register(&adis->spi->dev, adis->trig);
 }
 EXPORT_SYMBOL_NS_GPL(devm_adis_probe_trigger, "IIO_ADISLIB");
-- 
2.34.1

