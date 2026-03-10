Return-Path: <stable+bounces-223915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MECeNz38r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:10:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0A24A080
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A93453007538
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51460381AF8;
	Tue, 10 Mar 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX/DkgHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F72D24B7;
	Tue, 10 Mar 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141052; cv=none; b=eQGYi4Y73WrbeWTtkYffZiMLXlST8GEObt1/Oq1iQ95BIYXm4uWJP2YpMqFm5MS5B4DIIrusBO6hoJzhTCpBMS0ROFbjdhTsa0TI0XKtmed3pz6j6n0d+f57JZPUGVS+SkDfxV1ubfHYLGjX5KI7GvzJksnTOllQ9WJoUHZjnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141052; c=relaxed/simple;
	bh=M6SqP4FUp4gybotx7Q+CV5B6GShepxd1sKEkcuKbKoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGcdbDlkYFm2RDAH2H8KqJHwj+tZUZJagT58FurCBiy0SGV/6KRQMRF1tkcy7+HLUtrwkaJ5+vpTyh7C7dVAy7Rm22kp9Aus2gdwqfnW6DThW6PKFyEH7iB3zQ9spav9GrIkyaNbspSC6SkNmclpAYlsfByDYn/eLp0bhQ73nuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX/DkgHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D86C19423;
	Tue, 10 Mar 2026 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141051;
	bh=M6SqP4FUp4gybotx7Q+CV5B6GShepxd1sKEkcuKbKoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hX/DkgHZtMkOXU3rtPpGMi8O26VrfpW4LJWCPHTuIcHO2lsrkgRnPhMODQu1XWWLE
	 sxBVO4lhJxwNc6APB4iAe7twFIUlADVL/iY7jHSk7w7iP3153LIbvJpEEWzUg4ogh1
	 IKug9Arr3D+t5iCIeZhH6P0ZFSvHWM8Kchlzax/0TJdOWHPb6Rmr4iERiyEJ7r4BXN
	 kCYklyuSc+N6qFGy1JRWYIqexIHcMbuqPIpdzrtHiquzuCmmWnDto8zV+e5y5MqkLR
	 IofOnxOy+expCVAGuABtDXfriSZxPJu6H+5Ojchj07v1n8fRrQ1XiRT5n6XhpfQQku
	 xOmYn/tEnxNgw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 050/311] regulator: fp9931: Fix PM runtime reference leak in fp9931_hwmon_read()
Date: Tue, 10 Mar 2026 07:01:37 -0400
Message-ID: <14664adb2b5032d89d4d3d25432ad8bd331626eb.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78B0A24A080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kemnade.info,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223915-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 0902010c8d163f7b62e655efda1a843529152c7c ]

In fp9931_hwmon_read(), if regmap_read() failed, the function returned
the error code without calling pm_runtime_put_autosuspend(), causing
a PM reference leak.

Fixes: 12d821bd13d4 ("regulator: Add FP9931/JD9930 driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20260224-fp9931-v1-1-1cf05cabef4a@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/fp9931.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/fp9931.c b/drivers/regulator/fp9931.c
index 7fbcc6327cc63..abea3b69d8a08 100644
--- a/drivers/regulator/fp9931.c
+++ b/drivers/regulator/fp9931.c
@@ -144,13 +144,12 @@ static int fp9931_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 		return ret;
 
 	ret = regmap_read(data->regmap, FP9931_REG_TMST_VALUE, &val);
-	if (ret)
-		return ret;
+	if (!ret)
+		*temp = (s8)val * 1000;
 
 	pm_runtime_put_autosuspend(data->dev);
-	*temp = (s8)val * 1000;
 
-	return 0;
+	return ret;
 }
 
 static umode_t fp9931_hwmon_is_visible(const void *data,
-- 
2.51.0


