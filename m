Return-Path: <stable+bounces-274493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GlSyOsJ2Vmq46AAAu9opvQ
	(envelope-from <stable+bounces-274493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CA7579C8
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wipwbu16;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274493-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274493-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 102603036296
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114C3806D0;
	Tue, 14 Jul 2026 17:49:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8D4156E2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:49:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051386; cv=none; b=Dj7LZgGph/fV7CZp4v3i0waL1ULTlMceD+jroDbGVIiadHafTWUNmn4GM+zaG3ERxUw7c3dx32NG3abzbSNjvXVB6sY25ytZt2Mo9Pe0yoAXSSSrDAT+gmnFDOx7ep6Jce8XrteYbi+bUrDP4pqUWkmSNib0Gp4mAyvJC239dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051386; c=relaxed/simple;
	bh=9AMjLe43MOrynghOdSieS9bEzotZ/oA3QJ27ctcEnAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNV27d7zvMANwT/M7CymgDZZwD2LLuooZnql2JATfsz/lr9aT6DkATqAwcUhmd4v+8v+z4nhyZsOGvHpdGElt6TiqfgjWwtulJfBSjHFs/1F2ROzLwB/vHqpOabDxR9UWxph4MKbxAwfKa4kUWYRN0mSuSMSwnJPfnCCrjcPb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wipwbu16; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5DA1F000E9;
	Tue, 14 Jul 2026 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051369;
	bh=2axj1WO8xfNj4DrrHpv8gfYA/ibGGMPoazCPogGlMdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wipwbu16QjvpdIw/qmIxr03eV4S+bfvClGrPqQvHx29xtBdGwmSrwaGBXnJ3mqlK3
	 +edzNLhqLh2F4QZEzHu3zYrxN7l2mIbhO+EcwMIeGJ1HcnbaBXq/GGHV88vkJhWFfq
	 8sKD5ddKi6PCG0vYWCyG07nh1Cxjg7z+KD86ei2UyV/BwAL91bU/TUeOvcKfQ1Quy/
	 /Ej43J3JrnTH/UPdNa2MC1pYpbyyP0frWaiY/gOz0kfxct280iskLs1fpbDNR6mhAW
	 BhSUid+bBPRnyouooWHvxjZWG5TYZbU3EoBv+gisDLvQSPTq1BiCbt+5MXSSzqcUqm
	 Fl/BEQQTmvINg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
Date: Tue, 14 Jul 2026 13:49:27 -0400
Message-ID: <20260714174927.3041910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071347-undermine-legible-9f57@gregkh>
References: <2026071347-undermine-legible-9f57@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274493-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mhun512@gmail.com,m:stable@kernel.org,m:ae878000@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A26CA7579C8

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit e8da46d99d3710106e7c44db14566bf9b57386b5 ]

rt1711h_probe() registers the TCPCI port before requesting the interrupt
and enabling alert interrupts. If either of those later steps fails, the
probe function returns without unregistering the TCPCI port. The explicit
unregister currently only happens from the remove callback.

Register a devres action immediately after tcpci_register_port() succeeds,
so tcpci_unregister_port() runs on later probe failures and on driver
detach. Drop the remove callback to avoid unregistering the same port
twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 302c570bf36e ("usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260706145312.37260-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 9df13ce036c6d8..fd3832202c39e1 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -212,6 +212,8 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
 	return 0;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client,
 			 const struct i2c_device_id *i2c_id)
 {
@@ -257,6 +259,10 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -274,12 +280,9 @@ static int rt1711h_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
-	return 0;
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct i2c_device_id rt1711h_id[] = {
@@ -302,7 +305,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1711h_of_match),
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);
-- 
2.53.0


