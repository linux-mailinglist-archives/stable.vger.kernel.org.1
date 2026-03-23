Return-Path: <stable+bounces-228422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONHHJEVPwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA012F4BC8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 665F430D61D6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DD3AF65A;
	Mon, 23 Mar 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bj1KCn7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846F3AE6EE;
	Mon, 23 Mar 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275080; cv=none; b=CnnsamA5g3Njl4JG7zXXmzl1sg4Z9wBKbDjEbCzYptUxUb/3LcxysVdDFrFyLAlaPC2tev8R9LWXyd/peLTGz4frT+LYjaUBh9vAQ6iSuLgp4rE6f8ddrzFV2CvJ9CoMd4m1D0rCGEonb/5n0gegA3Hzpf0r4X/oRJQKbNh/ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275080; c=relaxed/simple;
	bh=Mzo3XbRlY6G0WkcPMck1qKkwYIaASWDb1BLMJjeQDDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg50+KNuj6mwmwvY0O+2FMozIiNlYIVW3Pro4eu58cQEkCeFUycq1WpGnlTk8+hZ0i7f0MCLRGhWRp1Hn3LoL/xbWmfxRBZvJ1IuJE7i4BPhmK//qHfNlFTPaTQ9gynz+/Jr5fF6TiRbb8tVsdwezIWvEYWODM4MlsBOjRmNYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bj1KCn7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC7C4CEF7;
	Mon, 23 Mar 2026 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275079;
	bh=Mzo3XbRlY6G0WkcPMck1qKkwYIaASWDb1BLMJjeQDDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bj1KCn7WWvPMn/iSkl77AGe1B4oBIQEtNKZJ5KfgkrYbzfCAypoXvRp7X1WkGgkW7
	 EzBo0RSfl/fR0CmSjEEEY5cPLxv3XZprY6aCN+v+2TX0u/I3EDjF/y7tkwviQ/wVcn
	 K6Hbfvl/RLIUO7exVp3sH6dXQ7000T9SsGZVk8w4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 212/212] hwmon: (max6639) Fix pulses-per-revolution implementation
Date: Mon, 23 Mar 2026 14:47:13 +0100
Message-ID: <20260323134510.491650850@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228422-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0CA012F4BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit e7bae9a7a5e1251ab414291f4e9304d702bb9221 ]

The valid range for the pulses-per-revolution devicetree property is
1..4. The current code checks for a range of 1..5. Fix it.

Declare the variable used to retrieve pulses per revolution from
devicetree as u32 (unsigned) to match the of_property_read_u32() API.

The current code uses a postfix decrement when writing the pulses per
resolution into the chip. This has no effect since the value is evaluated
before it is decremented. Fix it by decrementing before evaluating the
value.

Fixes: 7506ebcd662b ("hwmon: (max6639) : Configure based on DT property")
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/max6639.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 1fc12e1463b58..447e8cdbc74c6 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -235,7 +235,7 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
 static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
 {
 	/* Decrement the PPR value and shift left by 6 to match the register format */
-	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), --ppr << 6);
 }
 
 static int max6639_write_fan(struct device *dev, u32 attr, int channel,
@@ -537,8 +537,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
 {
 	struct device *dev = &client->dev;
-	u32 i;
-	int err, val;
+	u32 i, val;
+	int err;
 
 	err = of_property_read_u32(child, "reg", &i);
 	if (err) {
@@ -553,8 +553,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
 	err = of_property_read_u32(child, "pulses-per-revolution", &val);
 	if (!err) {
-		if (val < 1 || val > 5) {
-			dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
+		if (val < 1 || val > 4) {
+			dev_err(dev, "invalid pulses-per-revolution %u of %pOFn\n", val, child);
 			return -EINVAL;
 		}
 		data->ppr[i] = val;
-- 
2.51.0




