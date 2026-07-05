Return-Path: <stable+bounces-272089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vc50NjarSmo1FwEAu9opvQ
	(envelope-from <stable+bounces-272089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 21:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691C70AD87
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 21:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n4Eixekz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272089-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272089-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8280300E706
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF03546CA;
	Sun,  5 Jul 2026 19:06:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2672FE074
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278377; cv=none; b=idqWsa0Yxnrkv2x3t/dc1I0is5WRdn/lN3G/TUIZoJNZt5zfh3lBZnbz4rrlOBfS7KCuPmL1FOXsdwT20cfWBS80Nu0lHNxgXHd3y7WVgWmkCvjjYULd7lIzmt7pABnfqt9IDOMS9auC8xUe+ZXBkRABW0V2D6hQj3D7iuafPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278377; c=relaxed/simple;
	bh=1bmP06qdlOPYNQtpo2Ay8x1+V5UFSSdpHUwsch5fW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0fpgfUuVEh2EFbwmLL3eSnwnkwKgxZTWE8M5RsPSOjkxXzFk2uw2m7+CpuTXtyFuQIrfaxNn9Z/v88Y9egWpdERETpA9fn0K9zgplrBgTbQtkc9QA6mZmGk5HhorvIdi7Jx+hv6obzQOQJypyRd32lCkisqRBO1q18PSgTWNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Eixekz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F791F00A3A;
	Sun,  5 Jul 2026 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278376;
	bh=ri2ksZwSfkppbA2N9S8tVQDmt6rPqmrCwuSHtYplI2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4Eixekz48m+kN6pma9uZd+qNjvLnsgUnm4TkBRH58ZHqBWUfWh11I2c4tbKqBakq
	 CXuLkYQC2F9J7iD9jVhIxvwocyPsVpqhaZ0wBvvNNTHEwVr9JsCW1/nxWOLg4T/RCt
	 00GJGhjsUhpKQNo+7iJVj6aSa/+xZGUtvbK9MMVyWhNr9jED22qs8XZbn+p7iBDuEz
	 RrnMyLZ9PthUj7R3YwvzipqYu/Y8NgO9eAHb5OZhjmUTXPKbt02GBjaucs+Fx1v1Sr
	 gi5nawm403lxDhIW5mAMhy39HRiEPltCCE7ABfGAUK9zmzuV3jvckQxiw46Ont4MS1
	 zpQM9UhTbBQDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] i2c: core: fix NULL-deref on adapter registration failure
Date: Sun,  5 Jul 2026 15:06:10 -0400
Message-ID: <20260705190612.1987801-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705190612.1987801-1-sashal@kernel.org>
References: <2026070233-lushly-episode-a47f@gregkh>
 <20260705190612.1987801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272089-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:wsa+renesas@sang-engineering.com,m:sashal@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-tokyo.ac.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2691C70AD87

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 2295d2bb101faa663fbc45fadbb3fec45f107441 ]

If adapter registration ever fails the release callback would trigger a
NULL-pointer dereference as the completion struct has not been
initialised.

Note that before the offending commit this would instead have resulted
in a minor memory leak of the adapter name.

Fixes: 3f8c4f5e9a57 ("i2c: core: fix reference leak in i2c_register_adapter()")
Cc: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8abd576d357b67..59b34d11f8bdae 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1462,7 +1462,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_irq_domain;
+		goto err_put_adap;
 	}
 
 	res = of_i2c_setup_smbus_alert(adap);
@@ -1504,10 +1504,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
+	device_del(&adap->dev);
+err_put_adap:
 	init_completion(&adap->dev_released);
-	device_unregister(&adap->dev);
+	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-err_remove_irq_domain:
+
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0


