Return-Path: <stable+bounces-261439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oUDvOK9JJWrDGAIAu9opvQ
	(envelope-from <stable+bounces-261439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:36:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD0A64FD82
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:36:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dDc3jyNe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261439-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261439-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA1B230094F8
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCC328610;
	Sun,  7 Jun 2026 10:36:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D23254A9;
	Sun,  7 Jun 2026 10:36:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828562; cv=none; b=s/GML3dm3yuMuWxMMEVjHTJNIoYslSpNwQYzYLiMyifPY+SK4DaT5panoQqojnuG6gfCJAwjCNw8esEDQ6SDIczU6twuBWfQjqddgNjdZmQejK/VJsf0nt7BKcwz1zAYbl5iVzu/61yhSQNFvT5xMHC6L35i3kuQTD0N+9iD5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828562; c=relaxed/simple;
	bh=LzPaYzC1OcdGh1C6+QtCJ/B87ZC5diAcE3bS2ufOxjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jodm9XfReVsDG1Ovx4z58TDGyHNv8JVBmv+uiu0Qlm1zEY2G9LiHhZFuHlyGKtRc6dy4LVZPEq7a7sNG0fGCLsYsCwB7RCpStYFbLVpqiz5F1kLi+A9G1a4Ayb7Ro8A78JNBTTcrcWzNoJVm8+KDuX+iOzH9VBEBC6L3sZhL8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDc3jyNe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FB91F00893;
	Sun,  7 Jun 2026 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828561;
	bh=8fX8dfvgFCns5Z/F5RZuLDGB+91Ke6sEt1Rp/Dz4ZZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDc3jyNeFf4KydSbwnVGusZtfnZ+4dVFbrfhp4ERkx2HQgBHVtZysDChzE1ePYIXV
	 N2OOcEUwiaqOrtnisVrkb05USvPpcoOWKMAO23ySgcsvO3Sw8Hhvesd+HuAM1aNqJ8
	 AB4wpP4oK5bKnCi0UWVpR9Ee/ovLtTszdzGT2lrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7.0 193/332] iio: light: veml6070: Fix resource leak in probe error path
Date: Sun,  7 Jun 2026 11:59:22 +0200
Message-ID: <20260607095735.153462210@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-261439-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andriy.shevchenko@intel.com,m:ustc.gu@gmail.com,m:Stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,m:ustcgu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DD0A64FD82

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit b66f922f6a4fa92840f662fbcfeb4f8a0f774bcc upstream.

The driver calls i2c_new_dummy_device() to create a dummy device,
then calls i2c_smbus_write_byte(). If i2c_smbus_write_byte() fails and
returns, the cleanup via devm_add_action_or_reset() was never registered,
so the dummy device leaks.

Switch to devm_i2c_new_dummy_device() which registers cleanup atomically
with device creation, eliminating the error-path window.

Fixes: 7501bff87c3e ("iio: light: veml6070: add action for i2c_unregister_device")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/veml6070.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -245,13 +245,6 @@ static const struct iio_info veml6070_in
 	.write_raw = veml6070_write_raw,
 };
 
-static void veml6070_i2c_unreg(void *p)
-{
-	struct veml6070_data *data = p;
-
-	i2c_unregister_device(data->client2);
-}
-
 static int veml6070_probe(struct i2c_client *client)
 {
 	struct veml6070_data *data;
@@ -281,7 +274,8 @@ static int veml6070_probe(struct i2c_cli
 	if (ret < 0)
 		return ret;
 
-	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
+	data->client2 = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						  VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2))
 		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
 				     "i2c device for second chip address failed\n");
@@ -292,10 +286,6 @@ static int veml6070_probe(struct i2c_cli
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, veml6070_i2c_unreg, data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 



