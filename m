Return-Path: <stable+bounces-259685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJi6AXI7HmpriAkAu9opvQ
	(envelope-from <stable+bounces-259685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:09:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99808627164
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB723302FB77
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C99331A63;
	Tue,  2 Jun 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcR0bYFI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4D29BD9A
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365929; cv=none; b=evI+1SjSHN5rCDeJGiDGU/fJaKpGajqx/zwaq8PmnRqIjai2iKhzLhpoXMIQVo+EJwhir/+kOIsWaLSeCGMWlV/ynjzd8hs1cOcRR2Pde5FWwcNEEWo0ilJoF8AhuQol2ssXgvGWVxf57kGMBCQW4sJyaonkuKtjPZ8SqRZDSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365929; c=relaxed/simple;
	bh=uANqIiROyK8Y9+c4KmhS7e/umjDNKKvL6zcY+5pm5gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6iVR+LXpN9Uue1LzuG+lY2YTLhQzQdiv0+wXOMwV0yHLipJ4Dk+D2J94vzMfpERl69TYqUuZF9K0ZG9Mzs/xPxXTiy4WUYX3ZA5jzUbMXaRmtmHR8d/Er8iMzSocnNUw3q9tWxbzs5mWksa4dgMpmo+Alp3ByWfwLwk2Nv+cwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcR0bYFI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856301F00893;
	Tue,  2 Jun 2026 02:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365928;
	bh=g3Sgf/bZHlp8vNhNkJ7jXf22IgiBdTcar75fJpRMt0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcR0bYFIUprUiMQjMJTWQqUApoHxu+iHnnohnkJNMcev9sNpKSGCMG1DvNGkIKRbc
	 j76k7BCjwlrwDRxNjYXwAZ2gO0OoHZsALkhu4KxlmiQxUI3emsOxC1LBcqI4PcCMj2
	 N2HmdNesD5VCq0Zj1ptWFFZ7KIuPDlXXhhrB5j33/he7ssVN7HujF9NDtbtKf3YgSb
	 E7T3NDprSCHk6rqGdH10hOLBulNYKeBDDuQ0UqkTEsz5GcCT5YerwUAtOiDSyAz3zz
	 2Kh9g4ONLvCgl7s0k3nEoIe604fUSdB+WJk5E7trnZNAoLRfpL2DoYHgdgbS/8reK1
	 ED1W+B1kC6vmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Mon,  1 Jun 2026 22:05:25 -0400
Message-ID: <20260602020525.603691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052855-crummy-unequal-904f@gregkh>
References: <2026052855-crummy-unequal-904f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259685-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99808627164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit 4e4af55aaca7f6d7673d5f9889ad0529db86a048 ]

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ changed `guard(pmbus_lock)(client)` to manual `pmbus_lock_interruptible()`/`pmbus_unlock()` calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a616439cecbf51..53375b55cdb8fb 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -328,7 +328,14 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	ret = pmbus_lock_interruptible(client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
+
+	pmbus_unlock(client);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0


