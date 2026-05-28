Return-Path: <stable+bounces-255478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLA/M/2iGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:18:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BA5F8555
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E1D730F6677
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8F33CE8A;
	Thu, 28 May 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eh9477ML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130632ABC0;
	Thu, 28 May 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999025; cv=none; b=jOzRqFAE53actuQzaMAeLNGXF0rjm/8ALW5TYF4G4s9WAt3SRpWPmgA9rfS3K5cdbTnVJQjsUR8fcEs5m4aHgUU/IvjEmmd75mC6TwZFc1Vt7Uph9vHML1Evxc1NEJ+yLHUGAEB7LkK+J8c3Ov9ug7fm9IDRl15oSyRlpkhtrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999025; c=relaxed/simple;
	bh=IpZrceCTw9y57qzTJE4LgllGUvctVsUX1B2tN8qWKeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUNn8+42q51XgchNhuS/MHAcueUE0mBx/7Ky0nc/OXOqwI+KIfVRmUX+eaczn1DFEGXJSYyxEOGOi6wJyhF10e2s3EhgEa7fFvlOBAtDlji37S5r2p9IfB+N4AVNqoD8IBKXNSC6Tm6kVsLzoVX654Xp2y+1i/yEggJuHXemkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eh9477ML; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215711F000E9;
	Thu, 28 May 2026 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999023;
	bh=r0+KWc8y1R07xZDSZYC1qSY9H4qP+Y0eNi5X8WA3uVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eh9477MLZFlRriPRIvh6g9abHVNMIrZWhjAgKXYVzy0uyf89Bpt8Li8cenH8UKLwm
	 ozz+7nCofefsbidW7vf3CjhQJ7THp4EJVrXlXMj1oAx571r9wn/puoQOHR0kGM9GvD
	 D4ocD7NVKloxPNGSUifLP6zoAyTkocMXPWzgkpt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 354/461] hwmon: (lm90) Add lock protection to lm90_alert
Date: Thu, 28 May 2026 21:48:03 +0200
Message-ID: <20260528194657.662999560@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255478-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,roeck-us.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D6BA5F8555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 873e919e3101063a7a75989510ccfc125a4391cf ]

Sashiko reports:

lm90_alert() executes in the smbus alert context and calls
lm90_update_confreg() to disable the hardware alert line, without
acquiring hwmon_lock.

Concurrently, sysfs write operations (such as lm90_write_convrate) hold
the hwmon_lock, temporarily modify data->config, and then restore it.

If an alert interrupt occurs concurrently with a sysfs write, the sysfs
path will overwrite the alert handler's modifications to data->config
and the hardware register.

This unintentionally re-enables the hardware alert line while the alarm is
still active, causing an interrupt storm.

Add the missing lock to lm90_alert() to solve the problem.

Fixes: 7a1d220ccb0cc ("hwmon: (lm90) Introduce function to update configuration register")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm90.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c4a9dafff81d6..1eeb608e59039 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2946,6 +2946,7 @@ static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 		 */
 		struct lm90_data *data = i2c_get_clientdata(client);
 
+		hwmon_lock(data->hwmon_dev);
 		if (!data->shutdown && (data->flags & LM90_HAVE_BROKEN_ALERT) &&
 		    (data->current_alarms & data->alert_alarms)) {
 			if (!(data->config & 0x80)) {
@@ -2955,6 +2956,7 @@ static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 			schedule_delayed_work(&data->alert_work,
 				max_t(int, HZ, msecs_to_jiffies(data->update_interval)));
 		}
+		hwmon_unlock(data->hwmon_dev);
 	} else {
 		dev_dbg(&client->dev, "Everything OK\n");
 	}
-- 
2.53.0




