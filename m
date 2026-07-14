Return-Path: <stable+bounces-274469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K8CSEqVqVmq25AAAu9opvQ
	(envelope-from <stable+bounces-274469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D35757295
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:58:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAQVGguH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274469-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274469-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B49F304E33D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E94DC55C;
	Tue, 14 Jul 2026 16:56:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AC4DC54D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048177; cv=none; b=ezjlXDO2qyp9jpcmy6pF9STMPOgkDmXgwoLANJccy7yTsQr7rfYMjmRXb2eNxv6gCJLR4DxPddHwb4je7uMdyCBk8rtRFGTwhUvA4kOX/ZYXlVZctEeKBeTz+dbiZrmHDHM/45eO8uUAKWZZ6ECJA2zws3BmRsYESLEiHZuotDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048177; c=relaxed/simple;
	bh=8V0ovaPI1TMiGGhd+uQebZJ5hKTOcRr1ZwdTdPKGU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deO0gix4sy1X6wmTffZFWuGnNb7ji8A2PbweUE4bA0SFJieb+We552EyCo57UXnqfLNLGNrwr7Y6kcdoq18eGgkvZF4s2g78jwx7FaGd0ikC7CxMb7bP7EsIGWvDd7eJrKfVWxAf3cO3oUlM4xiW2OyMYokR4eUbX2X4eUzcVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAQVGguH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0951F00A3A;
	Tue, 14 Jul 2026 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048176;
	bh=OoR72XBK8p1tJPQ7MzcHg8fYkglRCiBxZf3oZ1odfUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAQVGguHL7OOHr+9b3F8v0gREtRlVCCqaPuUgtL0wRQl97SJ1gQkiQqR5Q0SzOyu6
	 vuL6H78KZMXjgU/mu+Y7GUqWNKrfIBabPdIiZ93663nLUFLsZHKyoIDJhJSWMB9sdw
	 3FickEX1m57kA/bRaBfo7oM4693HhqPzmcXSmsQVWvZh0yO8x32RCEBpZNSQhUk3Et
	 Zr4tNRAGnHm+FSSptjBvN2+N/DGhxHK16u3J/MhAFw89qKI4oY5qnk2308W/HWRbs/
	 WH38GbW+SoMpi6SN7eYM2zqlQBYkKEoyXkQ7uq45qtEQcVeXrEyQ3md7bzz85NO2jR
	 yOpGrVyYc3wEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
Date: Tue, 14 Jul 2026 12:56:14 -0400
Message-ID: <20260714165614.2886221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071334-divinely-dingbat-9c54@gregkh>
References: <2026071334-divinely-dingbat-9c54@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274469-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91D35757295

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
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index d608fefd4f30e7..8fdffec401e08d 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -327,6 +327,8 @@ static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *c
 	return ret;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client,
 			 const struct i2c_device_id *i2c_id)
 {
@@ -379,6 +381,10 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -396,11 +402,9 @@ static int rt1711h_probe(struct i2c_client *client,
 	return 0;
 }
 
-static void rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct i2c_device_id rt1711h_id[] = {
@@ -425,7 +429,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = of_match_ptr(rt1711h_of_match),
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);
-- 
2.53.0


