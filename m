Return-Path: <stable+bounces-258664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDs7BcYrG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:26:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1A611B98
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190AC303467C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BF284690;
	Sat, 30 May 2026 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fP9ZvKY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D0233D9E;
	Sat, 30 May 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165115; cv=none; b=U5Ye2mFJOnEk5M3bQHrY0YftCzuH9JajDouo+1x6151rg5ZTIiEk8fXXlSfIOjR+NP0TgY9NS6YX/L7D794gJVg4xtbn/3wt8BcllU121hwpI8swUNesxYlZLieD2ulEVfXEyZMkiZEHAl9l0sIjidE7ziNHVkNWzyw/ExvuCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165115; c=relaxed/simple;
	bh=vrcbqwFZHa+Ge5n0/dfnEaWaynaDqsnogdIy6pTZ0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpP+nmwupByh6NkRa0qAMFWmHoFBVvlNDcq9VdSh7Tszh73+rJvsKyLD6PX3DQDBt1J41E/ip64yHx2+pfPySKBIlXFXCCrAQt0qeQFKkfJmwc1VgtOh0+he2I8uyQZAQzJdK85RHhvMUZn3OYHgjMMjFrQsIq6XmjL2MV+j7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fP9ZvKY1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA51F00893;
	Sat, 30 May 2026 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165114;
	bh=he9D7rd2wkazJY6hCgIJSESymGT+1Y3bVh/zy+60jw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fP9ZvKY1Td7CgNlmt/dbDC9kPGIWyZAuwxDo8Ly3dGG0H/GQTp21VavBUI6zEN1Tb
	 hYcL8gLFi7R2cQ5Wg6+mtuANvt64DffTu15qfwSnAm6cq6V9OMS3hOlPT+Evf2HeJf
	 20cjNFCrFM1BWWl9eU+NoY7L27AbanRP0sC43xQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.15 724/776] hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors
Date: Sat, 30 May 2026 18:07:18 +0200
Message-ID: <20260530160258.532840262@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258664-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nexthop.ai:email,roeck-us.net:email]
X-Rspamd-Queue-Id: 72E1A611B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

commit a7232f68c43ca62f545049b7f5fbfc75137b843b upstream.

adm1266_gpio_get() and adm1266_gpio_get_multiple() both compose the
pin-status word as

	pins_status = read_buf[0] + (read_buf[1] << 8);

right after i2c_smbus_read_block_data(), guarding only against an
error return.  A well-behaved device returns 2 bytes for
GPIO_STATUS/PDIO_STATUS, but the helper happily reports a 0- or
1-byte response too.  If the device returns 0 bytes, both read_buf
slots are uninitialized stack memory; if it returns 1 byte, read_buf[1]
is.

The composed value then flows through set_bit() into the caller's
*bits in adm1266_gpio_get_multiple(), or into the return value of
adm1266_gpio_get(), and ends up in userspace via gpiolib (sysfs and
the char-dev ioctls).  That leaks a few bits of kernel stack per
request on any device whose firmware glitch, bus error, or hostile
slave produces a short block-read response.

Add the missing length check to both call sites and surface a short
response as -EIO.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-3-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -176,6 +176,8 @@ static int adm1266_gpio_get(struct gpio_
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	pins_status = read_buf[0] + (read_buf[1] << 8);
 	if (offset < ADM1266_GPIO_NR)
@@ -196,6 +198,8 @@ static int adm1266_gpio_get_multiple(str
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -208,6 +212,8 @@ static int adm1266_gpio_get_multiple(str
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 



