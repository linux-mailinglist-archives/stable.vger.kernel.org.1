Return-Path: <stable+bounces-224457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMkSFpYFsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:50:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19C24BA49
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30B5B308DCAE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799038A73B;
	Tue, 10 Mar 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2xHU/GY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8C387587;
	Tue, 10 Mar 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142189; cv=none; b=BVimuJxMFV3qAIUrulBRWx4feBWMZ6T9U2mcdveNG1tNRVRQMsjwgq+i9VfDBf7c6/WR5DSrSH5rvvCIgA/p5MFkUXxgWSPNzRLhhLFWypfEGWQ5GJeotdgQeiSVwtYidHIIqQxPoRNQbOSQgiAGiAt1NY4uvaEd7fBCw49xExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142189; c=relaxed/simple;
	bh=vBsTLKWA9BKsGE5i2sAZKfN0NxLugNrDR2lDsckRbnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6oxPvqwxlUuQukkbUTmyqdB9XLxIwrbinuWCWH9zcEz6SLrdaBFWa+768JULcjwCIV1ex50r77WjZGvjzH7aZfQkfO76+rjIiuzFKv2XVgpt125VgocUsk2RLimNeGY4S4yujogDqL/I/hZtPCAGWJxlGIBtXNYRxc36+MVQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2xHU/GY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5006C2BC9E;
	Tue, 10 Mar 2026 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142189;
	bh=vBsTLKWA9BKsGE5i2sAZKfN0NxLugNrDR2lDsckRbnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2xHU/GYMHhUJEhbDKSTDxHf8D6i3njibX3hkX6wJ8jQQirnGc7VVNfN9CV+ZpxJz
	 dSN+ZP63OBpQ6vVjD00OiAyd2LL/PsK9hzezWJxsY2dYClIVZeAdGOMooU2CFp/vNJ
	 zxXYxFhIBYmSlB3DTQuvRcP6l5K/wGM+G6U9qf/aQBpxg7HYxNDsgXu+O0d77Uuc1g
	 6gcFz1sEu6GBPZWcDrZ2cP+fWv4o1xkZ6bh2Q8DmrcfP56h/JifKyCsx2BJ5yhplm1
	 TTgrUf1z2ilEdzcyksPKmSavBoRXg6YpXTfrxNy0NIQIKPR2c1hm4T/TB0+EC7fKJK
	 Nw8hOgCGrlEGg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 278/314] hwmon: (max6639) fix inverted polarity
Date: Tue, 10 Mar 2026 07:18:57 -0400
Message-ID: <59fed0c7cc760bc1134bdea1dde5a5e57f36ad7b.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D19C24BA49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224457-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sobrie.be:email,roeck-us.net:email]
X-Rspamd-Action: no action

From: Olivier Sobrie <olivier@sobrie.be>

[ Upstream commit 170a4b21f49b3dcff3115b4c90758f0a0d77375a ]

According to MAX6639 documentation:

  D1: PWM Output Polarity. PWM output is low at
  100% duty cycle when this bit is set to zero. PWM
  output is high at 100% duty cycle when this bit is set
  to 1.

Up to commit 0f33272b60ed ("hwmon: (max6639) : Update hwmon init using
info structure"), the polarity was set to high (0x2) when no platform
data was set. After the patch, the polarity register wasn't set anymore
if no platform data was specified. Nowadays, since commit 7506ebcd662b
("hwmon: (max6639) : Configure based on DT property"), it is always set
to low which doesn't match with the comment above and change the
behavior compared to versions prior 0f33272b60ed.

Fixes: 0f33272b60ed ("hwmon: (max6639) : Update hwmon init using info structure")
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Link: https://lore.kernel.org/r/20260304212039.570274-1-olivier@sobrie.be
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/max6639.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index a06346496e1d9..1fc12e1463b58 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -623,7 +623,7 @@ static int max6639_init_client(struct i2c_client *client,
 			return err;
 
 		/* Fans PWM polarity high by default */
-		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
 		if (err)
 			return err;
 
-- 
2.51.0


