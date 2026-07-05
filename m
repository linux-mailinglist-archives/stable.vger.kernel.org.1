Return-Path: <stable+bounces-272004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ic4YIITLSWrK7AAAu9opvQ
	(envelope-from <stable+bounces-272004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:12:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F3708D6D
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 05:12:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZEYE9ATS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272004-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272004-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BEE13014425
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C542C9D;
	Sun,  5 Jul 2026 03:12:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DC2253EE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:12:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221122; cv=none; b=YaaV8Sr0dNDUg8IgglJ77AqOh5BcgqMs0o4C4j4ioKW5zuiyg/C+Wvme5HzxBU4Uq+Zi1y7fqCsVj7kA/CML28XYo41v3KLjltosIKy9NUULgQ2L8tq48qoRTWYzst3gxVYpFmCvBji2Vao/+U/45JdRsReqsCLZ+t8rsznA+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221122; c=relaxed/simple;
	bh=Nh5wRA7DFcXdIEq54CLL89Mmc1CWkvTkE9mcGwBWgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8m3yXXLux6C8SQOHvVEMpgd4PODhTxPIJLKQoGZJxdpqnqUeZnZzW1vA0pVUsFFr1Yb7KhMttoVOk91heiygORDBq2FMgN0LsyFbVMa8KuwO23GP/evrCRg0HDqn6kQF1MDLLdgSgYF2YWunSbUe0cCa0bQtVEAKBXwhigZsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEYE9ATS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21411F00A3A;
	Sun,  5 Jul 2026 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221121;
	bh=pYjk8qQJeVYV4nNxxrBZYF9qkeLSdQeVH8o0tfmJN9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEYE9ATSeftJWYYvcOXitC39q94mX+qhtuWVhepy8RdmYU5yZi9wGMtbgAYz04Ox9
	 uf4Usei8aj4eswJugfmYld5r1FToYdkeNuoKu7GaY/0K+sH0nBGyK9hSZPQAqsNFWI
	 jTaqti7MIshdD1jBsPOhrjfMjJvxpV9nQ2H4b6nqFe6DEU8Saw+0VNf00fEbiZxzZh
	 faqmsebaYrRej+OjCd7jyju+o5E/N8gMu7Mnee9FCKM9R1wYkdw9WY227AjbY2X56N
	 W7qIsuZujLsbvmo3JYZpiaCiZPjMrQ95nKLdjv9c/Hvp0kb/5BB89fOHq8N+3gA6Km
	 YfrJWqEc9pffw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] i2c: core: fix adapter debugfs creation
Date: Sat,  4 Jul 2026 23:11:55 -0400
Message-ID: <20260705031156.1601242-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031156.1601242-1-sashal@kernel.org>
References: <2026070232-straddle-keenness-fbbc@gregkh>
 <20260705031156.1601242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:wsa+renesas@sang-engineering.com,m:sashal@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272004-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A8F3708D6D

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 07d5fb537928aad4369aaff0cbae73ba38a719af ]

Clients can be registered from bus notifier callbacks so the debugfs
directory needs to be created before registering the adapter as clients
use that directory as their debugfs parent.

Move debugfs creation before adapter registration to avoid having
clients create their debugfs directories in the debugfs root (which is
also more likely to fail due to name collisions).

Note that failure to allocate the adapter name must now be handled
explicitly as debugfs_create_dir() cannot handle a NULL name (unlike
device_add() which returns an error).

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org	# 6.8
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index afa51e3e6b5b08..f5338a8441a66a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1546,17 +1546,22 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_remove_irq_domain;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
-	res = device_register(&adap->dev);
+	device_initialize(&adap->dev);
+
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
+	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_put_adap;
+		goto err_remove_debugfs;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
@@ -1597,13 +1602,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
-	debugfs_remove_recursive(adap->debugfs);
 	device_del(&adap->dev);
-err_put_adap:
+err_remove_debugfs:
+	debugfs_remove_recursive(adap->debugfs);
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-
+err_remove_irq_domain:
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0


