Return-Path: <stable+bounces-228921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA/HMNVWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347702F5C4B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ADA430C72A4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8E3AF650;
	Mon, 23 Mar 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UlPOmzGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BE3AEF50;
	Mon, 23 Mar 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277493; cv=none; b=l0JiyWlrROd6yInmG5x0+bvnFOV1NAu6W+xa6OTRhapkAlcZdeDrhAX0aVwLrrsJcwxdRGq3Ga2oQz27wGrQ7dytA7yaa+3dwfl2OE/8G5LRmxYaJTFJXcFCHlDdgSArqTcG95OUeCKfUfsQ9Vkg6AfQwUECsRuZ9IvrmBkszb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277493; c=relaxed/simple;
	bh=4vxM1+lhVEZUefXpN7jBiUSVVn9mahxGnWOJeDlF0qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZhfEgu7RjcC9VXeIoCHN0vyX0+ng0LqbNHCewrAF/bjfI5RS/L6K07rC9ZLgdONp0lWtceGOSEy+89c2vI3bBDqP3yHe2NT/w+fppD/Cn9GL86A++JZpme0vxpTCW+Qf5RLZWeO9proQXh57DpC1d2de5V4FFwNUfZmsZsYOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UlPOmzGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38BEC4CEF7;
	Mon, 23 Mar 2026 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277493;
	bh=4vxM1+lhVEZUefXpN7jBiUSVVn9mahxGnWOJeDlF0qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlPOmzGMO97zbwkMI84FruFpqjbjl2QZTzd86GRAtP8D8Wd/QA9RkDA6DNy/nJyYB
	 2OPIjc8ktBXXjFh89Cp4xRnAGGXDnhmSUQq6iPNCayE6sjCLQ1zZuTrPbZDBMVNYwl
	 BpH5m9M9NcjjfM80akHPD5M+gmF9veJJJjXZYAAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 459/460] hwmon: (max6639) Fix pulses-per-revolution implementation
Date: Mon, 23 Mar 2026 14:47:35 +0100
Message-ID: <20260323134537.856835750@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228921-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 347702F5C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 0b0a9f4c2307f..154250099adf1 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -234,7 +234,7 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
 static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
 {
 	/* Decrement the PPR value and shift left by 6 to match the register format */
-	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), --ppr << 6);
 }
 
 static int max6639_write_fan(struct device *dev, u32 attr, int channel,
@@ -536,8 +536,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
 {
 	struct device *dev = &client->dev;
-	u32 i;
-	int err, val;
+	u32 i, val;
+	int err;
 
 	err = of_property_read_u32(child, "reg", &i);
 	if (err) {
@@ -552,8 +552,8 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 
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




