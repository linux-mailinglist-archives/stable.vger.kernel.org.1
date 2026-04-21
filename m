Return-Path: <stable+bounces-240019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJDoA7TW5mkz1QEAu9opvQ
	(envelope-from <stable+bounces-240019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:45:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F2435518
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EB2930103B8
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236123F40D;
	Tue, 21 Apr 2026 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Xl3RJmo1";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ZDPO9lQQ"
X-Original-To: stable@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2971A9FA4;
	Tue, 21 Apr 2026 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735897; cv=none; b=sOO0++YMRXBPMK9uJINZ4WfJL4SyfbL/JKa9upiPiHOoE7Dh208xGvY+aT6pdHDdelFtvrXvPauV3LWbKuf3CaJXynro2jOoBrt6mJN1BY3+RQGH1C16LSG4UBRZUHmr/1qEa90bzEGdZDr0yoHylPgvQH0LxwuBTW+gNH2Yfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735897; c=relaxed/simple;
	bh=c6q9oQkbovfdRANQ03O3aL99Sm5ehXOdqaDo9UPMz/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dw3BxcAJiZoER9SsL1izG8tsSSjSivKNlqsDApyp0dIHW+9QRcJaqPxjokNTWvI6KTkppnTWL2YUe1U9g73hgg7maSHpwSWZTT7YiH7GEL6qwhzWOMZAjf9Y92biNfOTyJAGwjF5cWQfxKto7udaW9SE120GoRSDphJs8n5pj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Xl3RJmo1; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ZDPO9lQQ; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776735893;
	bh=hgJYTfLM6ixBP8ZTg+ugrd/LAtv9wxJUHiWP3SanoKU=; l=1778;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Xl3RJmo1Y0iJSL6gdECV2ueh+jKsMOUZ6Cb07/1F/lX6tr7OPtLwpkX7Xxb5xO27d
	 ervkAC1+Hk9L4PUQlsfvcZkfu7sj/WYhXW+T7S8aLrhp7Nfr3N+UCwMDV0Sr30iIaE
	 bbtDsmdDB72xJTAC8JSAiEyxlZchAZ1a8Wj3m0yzQJ2ggp7npjbec/ZKIyfLTt2o+9
	 bZu9QUN0s4s/jzhV0oe45CSbMvaYoRXz2cGsEpWVrwhpuXV9dxskKL4A6rnY6bwHmr
	 OMEoX08wYOi4uBuoguhxfgdCrSFbnEABeYZqMxegqEPuGwMxtflKj2wPfTLZVfBIDi
	 NegXnZtdO/Mkg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128077:0:AUTH_RELAY)
	(envelope-from <prvs=1569D0B0C6=cy_huang@richtek.com>); Tue, 21 Apr 2026 09:44:51 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776735891;
	bh=hgJYTfLM6ixBP8ZTg+ugrd/LAtv9wxJUHiWP3SanoKU=; l=1778;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZDPO9lQQ7UJdpWNELTYa/bCyyzJVnx6RuvAZmqdtmLXDXRjQAtYCCFxosuj3rliQo
	 gkEOmvOhtMWxvKlt6LYFfBAAgJmDPF/uoXP3w92lMFYh5xn1SeupC0j3YJEU5bI/ol
	 TFZSR+a2hJgaRRTgPeZbn6fCLeeNa5Uc4E6FePNYfmI9Lz56oqoYf2BCWVC5Dc5XSj
	 LC4Qe2prVM72M7OZLFbM1MwBYsUF6nbvPAnpmG3L6Nfb4I410Nl44uH5MgktDbjCFc
	 kaBVGwz6/JhBmnnE9PbewGdygV+D6nPiqPRMz3AmsILQlhoJRiNYCUSSZxYy/OdE6H
	 jEZobgTRxlIUA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1227023:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 21 Apr 2026 09:41:22 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 21 Apr
 2026 09:41:21 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 21 Apr 2026 09:41:21 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tung
	<kevin.tung.openbmc@gmail.com>, ChiYuan Huang <cy_huang@richtek.com>, "Lucas
 Tsai" <lucas_tsai@richtek.com>, <kevin.tung@quantatw.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] iio: adc: rtq6056: Fix the manual device instantiation via sysfs
Date: Tue, 21 Apr 2026 09:41:17 +0800
Message-ID: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[richtek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[richtek.com:s=richtek];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,gmail.com,richtek.com,quantatw.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240019-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[richtek.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,richtek.com:email,richtek.com:dkim,richtek.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cy_huang@richtek.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 394F2435518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Tung <kevin.tung.openbmc@gmail.com>

Add i2c_device_id to support sysfs manual device instantiation.

Fixes: 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Cc: <stable@vger.kernel.org>
---
Hi, Jonathan:

For some BSP limit, still some user instantiate rtq6056 deivce via sysfs.
Therefore, add old style i2c id to make it compatible for this kind of usage.

BR,
ChiYuan.
---
 drivers/iio/adc/rtq6056.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 2bf3a09ac6b0..e7036dc7d7b9 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -728,7 +728,7 @@ static int rtq6056_probe(struct i2c_client *i2c)
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	devdata = device_get_match_data(dev);
+	devdata = i2c_get_match_data(i2c);
 	if (!devdata)
 		return dev_err_probe(dev, -EINVAL, "Invalid dev data\n");
 
@@ -878,6 +878,13 @@ static const struct of_device_id rtq6056_device_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rtq6056_device_match);
 
+static const struct i2c_device_id rtq6056_id[] = {
+	{ "rtq6056", (kernel_ulong_t)&rtq6056_devdata },
+	{ "rtq6059", (kernel_ulong_t)&rtq6059_devdata },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rtq6056_id);
+
 static struct i2c_driver rtq6056_driver = {
 	.driver = {
 		.name = "rtq6056",
@@ -885,6 +892,7 @@ static struct i2c_driver rtq6056_driver = {
 		.pm = pm_ptr(&rtq6056_pm_ops),
 	},
 	.probe = rtq6056_probe,
+	.id_table = rtq6056_id,
 };
 module_i2c_driver(rtq6056_driver);
 
-- 
2.34.1


