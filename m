Return-Path: <stable+bounces-273742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1psB43qVGp7hAAAu9opvQ
	(envelope-from <stable+bounces-273742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:39:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D09674BB81
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:39:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WIuvzVeF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273742-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273742-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84B753050F6F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4634307A5;
	Mon, 13 Jul 2026 13:22:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED14307A7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:22:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948972; cv=none; b=b9CQ4BODLpSSSC70mruGt8hx9aPpmS8uUGIEVB6i13LiFtgByrLJe82OybLUvU3Yz6pQiGgDWM3cRL4ccwMwBS94FXEeTFkiEtlkNZpOOW2ZOLqjUDp4bzrF8updTD0K9HJ9HQ0W49CFey+A5AzQ5gHUsvD72JKTzOC5eSbKtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948972; c=relaxed/simple;
	bh=RsXXGCLQOmEf/jA+yU0Au1CHGXwCJgnN09pGOxPMP08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IGtHJL1Dodm3s56DyLhAH48ln2F/dqSXlc4VIZqlaVIkJ2S5L+5xtaMptIy6OhnDxguJNvU2/P2dSFuJbPWVDAR4DxnSIFpeC4yN5dhaG/hPe130CWCwCHxhlpsxnnysL/lwJ0LU7paSTjpjABoVxtEb5XEfJFrQufQy5SqzDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIuvzVeF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6574E1F000E9;
	Mon, 13 Jul 2026 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948970;
	bh=dExkeORcUv+KPA3oPTzPFs/J17J1Pkug6mceVFiz/pM=;
	h=Subject:To:Cc:From:Date;
	b=WIuvzVeFSlZ57BjGhMaNJMNYS9MhjvZxXbpp81VpH7YGpnTkc6WMFV4/QTI4Y72VV
	 H+VjwhzXkpJSI4vBILjOf3BqzdDnXneZYIExfaWtHGqpagMmP2BGXhlWss9kcKzpTj
	 IspljHks6uow6mBD/IuW2Hj/6hl4dE55E3Xc9050=
Subject: FAILED: patch "[PATCH] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres" failed to apply to 6.1-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:14:34 +0200
Message-ID: <2026071334-divinely-dingbat-9c54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:ae878000@gmail.com,m:gregkh@linuxfoundation.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-273742-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D09674BB81


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e8da46d99d3710106e7c44db14566bf9b57386b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071334-divinely-dingbat-9c54@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8da46d99d3710106e7c44db14566bf9b57386b5 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 6 Jul 2026 23:53:12 +0900
Subject: [PATCH] usb: typec: tcpci_rt1711h: unregister TCPCI port with devres

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

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index a8726da6fc71..20037ef130ca 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -295,6 +295,8 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 	return 0;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
@@ -340,6 +342,10 @@ static int rt1711h_probe(struct i2c_client *client)
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -357,11 +363,9 @@ static int rt1711h_probe(struct i2c_client *client)
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
 
 static const struct rt1711h_chip_info rt1711h = {
@@ -394,7 +398,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = rt1711h_of_match,
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);


