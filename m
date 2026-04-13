Return-Path: <stable+bounces-236988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAWyNLge3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-236988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:50:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C13EFEC8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D8F1306F7A2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707EC280CFB;
	Mon, 13 Apr 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVNG6egW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9730C359;
	Mon, 13 Apr 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098303; cv=none; b=GCWfnhT4bvRMAH7XrjCd3/pqIv+E5hkcrpBZ/5z4hQ8XtluLH9YFQC9KDcFmpP8pvsIkbCeKr+B+iMZMHYMt1uZ0CBVCSkfQPSgA5AWl7iM46XA6shMkiPfO8ghClY0Omh99dT4VrP/zF4oSuSFGo3mZkeywH3M8XuVRt7bchZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098303; c=relaxed/simple;
	bh=SVCAQDi8Qc+3wYu333QbWnb51/ztUnc64rBHNBzwCHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R459t0sgqaPZhRQZsSu/jM06LeMkVAoZAXMxjCBnVnWy+5qccO9HNsUWHY0M8yGIFnedSFu/Ya1BEwb9qd1pQCoJMELHHM+lWK+r/KPkBTlzWrhb9s8BRfUKpMBQk6maEbslqO6jFUEJ9naUTvwb5KuRkg8hRCYDui1quBeBlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVNG6egW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD670C2BCAF;
	Mon, 13 Apr 2026 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098303;
	bh=SVCAQDi8Qc+3wYu333QbWnb51/ztUnc64rBHNBzwCHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVNG6egWk0n9ziyVxWjlgWBKqRc7zD4RJQZjBUw5rotxnPtAu0Cw8pmpwvhELXE15
	 U82DLMgiAL8lFaiMXv/10/AlyOe5Fm2zbNu88UrKZCBBvfWCwn1ku3J6KvqgMK+L7U
	 OmJMpaESXc65WDJh6cFa4+4F9F103B5UBIeZ/tOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 440/570] hwmon: (tps53679) Fix device ID comparison and printing in tps53676_identify()
Date: Mon, 13 Apr 2026 17:59:31 +0200
Message-ID: <20260413155846.956451408@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236988-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: D43C13EFEC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit ca34ee6d0307a0b4e52c870dfc1bb8a3c3eb956e ]

tps53676_identify() uses strncmp() to compare the device ID buffer
against a byte sequence containing embedded non-printable bytes
(\x53\x67\x60). strncmp() is semantically wrong for binary data
comparison; use memcmp() instead.

Additionally, the buffer from i2c_smbus_read_block_data() is not
NUL-terminated, so printing it with "%s" in the error path is
undefined behavior and may read past the buffer. Use "%*ph" to
hex-dump the actual bytes returned.

Per the datasheet, the expected device ID is the 6-byte sequence
54 49 53 67 60 00 ("TI\x53\x67\x60\x00"), so compare all 6 bytes
including the trailing NUL.

Fixes: cb3d37b59012 ("hwmon: (pmbus/tps53679) Add support for TI TPS53676")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260330155618.77403-1-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/tps53679.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index 81b9d813655ad..de91996886dbb 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -156,8 +156,8 @@ static int tps53676_identify(struct i2c_client *client,
 	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
 	if (ret < 0)
 		return ret;
-	if (strncmp("TI\x53\x67\x60", buf, 5)) {
-		dev_err(&client->dev, "Unexpected device ID: %s\n", buf);
+	if (ret != 6 || memcmp(buf, "TI\x53\x67\x60\x00", 6)) {
+		dev_err(&client->dev, "Unexpected device ID: %*ph\n", ret, buf);
 		return -ENODEV;
 	}
 
-- 
2.53.0




