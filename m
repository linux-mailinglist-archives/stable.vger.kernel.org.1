Return-Path: <stable+bounces-259252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI10FaczG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:59:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE641612EB3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F5830CC369
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC52367DF;
	Sat, 30 May 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pqraBdQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABD4315F;
	Sat, 30 May 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167118; cv=none; b=tQ0hY9OSMAgNxgg2sjzqs7DpQxpSse/QxduetdFr3ZKQEMsExkbduecO59wlrPrIOAu26nBrHVSSb7d2NYGAsc/Q4SOe+53MoIdL/ygT3cr3vffWTe4fyQthEhA85O1KYh1IOgNUxOpLT1QKy3ZNUCbOrhOdECY+XkYCDvBKnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167118; c=relaxed/simple;
	bh=R5++bsFZ8Hp7vEBT97KRNsrvWc7HAUvlRGPKQ6Fi4l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnKrMZFEsbnfNiUI66Mz2Z5HOFiX9K2LoI5LGYw1ogkbamza3lSjAGbn7JGd6aVINyOGHfIIYR77LClNeNO2M6cRUjfcfs5KUPhd5I2BAGqGtjB9lY8jo6bULxECyuE5is0pCMX3ME6DBbw3Y9WZbsBdcq/cv4Q3HInIfE9bb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pqraBdQF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6511F00893;
	Sat, 30 May 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167117;
	bh=xWH82dJ/tVvWa/9lfoZpnqDJzo8Ac+fL2i8jxm+bleg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pqraBdQFDwkzWf1qxuBZ2ETVAvtV/xQqRNLVBXZf5hc4dByG1O2wZ7Vm7G8XcHOp/
	 VK26MaidCvd59SrmHwQGLs9Yl0156VlzoVzmdrSXWm22hsadfV4GzWH+O1yIXOouL2
	 F5K2R2p5eY/f1mg1/XysSUdvdGKhZ0xTp9xk77Tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.10 567/589] hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
Date: Sat, 30 May 2026 18:07:28 +0200
Message-ID: <20260530160239.533957710@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259252-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE641612EB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

commit 6af713af91d5c34ec049eb3cc2c5b3f5eba953b8 upstream.

adm1266_probe() calls adm1266_config_nvmem() -- which goes on to
devm_nvmem_register() and exposes adm1266_nvmem_read() to userspace --
before pmbus_do_probe() has initialised the per-client PMBus state.

Same latent hazard as the gpio_chip one fixed in the previous patch:
once the nvmem device is registered, gpiolib's nvmem char-dev / sysfs
interface is reachable, and any concurrent read triggers
adm1266_nvmem_read() -> adm1266_nvmem_read_blackbox(), which issues
PMBus traffic that races pmbus_do_probe()'s own device accesses with
no serialisation.

Move adm1266_config_nvmem() down past pmbus_do_probe() so the nvmem
device isn't reachable from userspace until the PMBus state the
nvmem accessors depend on is fully initialised.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-5-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -472,14 +472,14 @@ static int adm1266_probe(struct i2c_clie
 	if (ret < 0)
 		return ret;
 
-	ret = adm1266_config_nvmem(data);
-	if (ret < 0)
-		return ret;
-
 	ret = pmbus_do_probe(client, &data->info);
 	if (ret)
 		return ret;
 
+	ret = adm1266_config_nvmem(data);
+	if (ret < 0)
+		return ret;
+
 	ret = adm1266_config_gpio(data);
 	if (ret < 0)
 		return ret;



