Return-Path: <stable+bounces-265373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WiQ/D6+HMWoglwUAu9opvQ
	(envelope-from <stable+bounces-265373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:28:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FA693294
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zHLWSyeJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265373-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265373-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 836A6303E846
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A94047AF65;
	Tue, 16 Jun 2026 17:27:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD46478E53;
	Tue, 16 Jun 2026 17:27:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630867; cv=none; b=mnYOzKp6irag2uZ0dTbQDY22fCTxeMUscYgFI2wt4NU8Kilnmoj4lTtF3pU6Q8/k1AIivKK2gWtmrha/JblI5tgM02f172vT7mGX99nN98B2FkvxZyRbLBdvkJHt6o6V33QL++a/EzizhuEa35U004/E1Eatu50Hx0uHGHaH5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630867; c=relaxed/simple;
	bh=QF37R6HY+yvUoVzLyFyp0iTLGyNxEKuHRobGQeqcL0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpVC4hZfs0o3ZlTdHQ78JGPvC488wb7CdPkk1jWCILZW10SQTabeYChqqnUZE5WxwNEbBiWHsX2u2yzIx11//Y8iZUr1h/mU1vHCT8EWTpdKObuE8/26U6auYk0CgE5YZDxYVsPxs03AxDUFehOSk5NnZwXkce9T7mCA8dovy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHLWSyeJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7161F000E9;
	Tue, 16 Jun 2026 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630864;
	bh=Tr8RXVdgfULstKpo4fjU3XgGqNBRMq/9DPFOCnfVfLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zHLWSyeJ77iqO7jHk89QhGKVQFEitTE+8DLLNQv7u7iM0QYfdhBts1ce4/7TSJKLp
	 45bkbGwaBjJ9LK4AMDbSwEKWYaM55eXmcdQl8Fxo7jO1NwGJ9dCKSucgQueMrkWDyc
	 zPp8tDt3HIVSdoTu2X8xIWTPhvJjldNIdZuKbijk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aldo Conte <aldocontelk@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.1 112/522] iio: light: cm3323: fix reg_conf not being initialized correctly
Date: Tue, 16 Jun 2026 20:24:19 +0530
Message-ID: <20260616145131.189152446@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265373-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:aldocontelk@gmail.com,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 045FA693294

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aldo Conte <aldocontelk@gmail.com>

commit 1f4f0bcc5255dec5c4c3a1551bf49d8c33b69b20 upstream.

The code stores the return value of i2c_smbus_write_word_data()
in data->reg_conf; however, this value represents the result
of the write operation and not the value actually written to
the configuration register. This meant that the contents of
data->reg_conf did not truly reflect the contents
of the hardware register.

Instead, save the value of the register before the write
and use this value in the I2C write.

The bug was found by code inspection: i2c_smbus_write_word_data()
returns 0 on success, not the value written to the register.

Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
kernel. Before loading the driver, the configuration register 0x00
CM3323_CMD_CONF was populated with 0x0030 using
`i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
in bits[6:4].

Due to incorrect initialization of data->reg_conf in
cm3323_init(), the print of integration_time returns 0.040000
instead of the expected 0.320000. This happens because the read of the
integration_time depends on cm3323_get_it_bits() that is based on the
value of data->reg_conf, which is erroneously set to 0.

With this fix applied, data->reg_conf correctly saves 0x0030 after init
and the successive integration_time reports 0.320000 as expected.

Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/cm3323.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *i
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 



