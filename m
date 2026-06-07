Return-Path: <stable+bounces-261875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /EQmOltSJWrfGwIAu9opvQ
	(envelope-from <stable+bounces-261875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:13:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 938D36505ED
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YXUAzGi9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261875-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261875-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B203076095
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11C3382C8;
	Sun,  7 Jun 2026 11:03:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5601E98E3;
	Sun,  7 Jun 2026 11:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830199; cv=none; b=MM9D7mt1f2jFoLuBXweIQ43gllPMRM64b6nM9innQTwXD6OAx0J4WXZ2XK0twdb5vJFGtbn7Ume/wenBRbnOj7dANH0Rx2vGJo4qWYQIQusXaknHJ7D8MJRDLv0y/H8ag1jKjPMTKm/cQd9AMjuop/Lh0/f6iNj2Jlx87CJhIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830199; c=relaxed/simple;
	bh=sZDCYpOzb3Fso8CPptHVesoSrREO85FkxG4kO+kVdkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZZs7IAFE5rApJ7WtgHQiGkFOjgW3LJB6PonG8zId2w+n9MV/7yZqnaoRXpqk8lp3T2yv99/8PMa9GIlAj3JXtbtmxhBHJLk8U/mL589ztWaJ/D0I8FwTvuV+Iczxby5NSLRnALVzprlZ3xR+gU7F46FXcLSp22BBaHoljVKgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXUAzGi9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB50B1F00893;
	Sun,  7 Jun 2026 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830198;
	bh=S/gAfvmgDS+UYwavELdDM4xTlo/UGczBQnM/1SzKU08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXUAzGi986K0oo2KeU/kdUdHOoFusBoPnwu1AeXnMkelSGXg+DFxfd9ef2jqOla+o
	 VIj6qYYCIpLXmcntZWLCVlVqU2WAZlXv6KzQMzt/zbeVBmKXNisDIuTkadP4gttXoo
	 P+ZlhJGK97icVuFDIk9v8NZPBn7Nyvi+0T/pYajs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 303/307] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Sun,  7 Jun 2026 12:01:40 +0200
Message-ID: <20260607095738.883013242@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261875-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:abdurrahman@nexthop.ai,m:linux@roeck-us.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 938D36505ED

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit 9f1dd8f9491eb840cbea7ffdf4cad031e25f8ae0 ]

adm1266_nvmem_read() is the reg_read callback the NVMEM core invokes
when userspace reads /sys/bus/nvmem/devices/.../nvmem on this chip.
On the first byte of every read it does a memset of data->dev_mem,
walks the device blackbox through adm1266_nvmem_read_blackbox()
(which issues a chain of PMBus block transactions), and then memcpys
the refreshed buffer out to userspace.  None of that runs under
pmbus_lock today.

Two consequences:

  - The PMBus traffic the refresh issues is not serialised against
    pmbus_core's own multi-step PAGE+register sequences.  A paged
    hwmon attribute read from another thread can land between a
    PAGE write and the paged read in either direction and corrupt
    one side's view of the device state machine.

  - The NVMEM core does not serialise concurrent reg_read calls, so
    two userspace readers racing at offset 0 can interleave the
    memset of data->dev_mem with another reader's
    adm1266_nvmem_read_blackbox() refill or memcpy out, returning
    torn data to userspace.

Take pmbus_lock at the top of adm1266_nvmem_read() via the
scope-based guard().  Patch 5 of this series moves
adm1266_config_nvmem() past pmbus_do_probe() so the lock is
guaranteed to be live before the callback is reachable from
userspace.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-7-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ changed `guard(pmbus_lock)(data->client)` to explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -398,18 +398,25 @@ static int adm1266_nvmem_read(void *priv
 	if (offset + bytes > data->nvmem_config.size)
 		return -EINVAL;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	if (offset == 0) {
 		memset(data->dev_mem, 0, data->nvmem_config.size);
 
 		ret = adm1266_nvmem_read_blackbox(data, data->dev_mem);
 		if (ret) {
 			dev_err(&data->client->dev, "Could not read blackbox!");
+			pmbus_unlock(data->client);
 			return ret;
 		}
 	}
 
 	memcpy(val, data->dev_mem + offset, bytes);
 
+	pmbus_unlock(data->client);
+
 	return 0;
 }
 



