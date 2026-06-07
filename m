Return-Path: <stable+bounces-261850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vOvqNAJSJWq5GwIAu9opvQ
	(envelope-from <stable+bounces-261850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD465059C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:12:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=t7lQ6Jf7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261850-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261850-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A1930AB15B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FE31A7E4;
	Sun,  7 Jun 2026 11:01:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C405212564;
	Sun,  7 Jun 2026 11:01:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830092; cv=none; b=SULKwnkLZt4VJK4RyvE+cDKPA5hWN4zQ0qThSDOCHGvrPeMdqkHKq0HMPkYDesvt5uyLH9tCH08ZJGkJb6XXABHNByUkCWcdFVLgKrnZ0bmN/2Bk1TXmRK61fuP7/H4Ffo45iZsOii8I0y2qtJ2qqE6v2IkdaCpCkMALq08OXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830092; c=relaxed/simple;
	bh=kG74z7EafmyBs5Dbla2gIQ1oTnBod0cGFeswtpaZ+8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qawBCy5seY2bSRFePVPAQ1KMjZWmc13WTZqAJu8p7NfEMKQmabg0YvIXCOjnBXdPbBLiNyR+F01F34QJpPBKegJBeNZTPlhH0pSSwDhGs8u/JtO1eRl46SAFUJj0YmVI1To1ZjKHJMIG6UgGU/YtnETqaIxwLAypBPvlqt+z02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7lQ6Jf7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6181F00893;
	Sun,  7 Jun 2026 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830091;
	bh=eJQPCrRPeHhWTrh8sj5eufWuwhjTCWh4gWaHQd7v/Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t7lQ6Jf7F576SvI84v9nvxHpipCMNViKVq6CMqH9c7LewySXIy1b2ZKSp19BV4iMB
	 lfPKs9DZE+JlyFyBlwnmXlm70AVhFW2TaXMgnQBedk7IEaxKzhdYf3uDw3rA0aUJia
	 189YITGBFBCKZ0NQke8xrZckQoLUELPbD1WaV9h8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 308/315] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Sun,  7 Jun 2026 12:01:35 +0200
Message-ID: <20260607095738.923940720@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261850-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:abdurrahman@nexthop.ai,m:linux@roeck-us.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,nexthop.ai:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22DD465059C

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -328,6 +328,7 @@ static int adm1266_state_read(struct seq
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;



