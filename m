Return-Path: <stable+bounces-268561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tr6zEeY1PWpuzAgAu9opvQ
	(envelope-from <stable+bounces-268561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C496C65FB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VmDkNehs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268561-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268561-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4BBC3013732
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B130C15C;
	Thu, 25 Jun 2026 14:06:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB382EEE65
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396363; cv=none; b=DSrlodOPW050Psgt5zrkvGeTvHgX+InSM/n+/+TtJqfJ5xQLy+U/0RoVyMMuZZrBNvuxuAU07NEe5xno2fz/0u/KunRv+22P/ICSq9iElrTBHOxGTivUy3psLX7uGvJCMOhk8iC6zwsfeDuK3dsue8Fog3Xc0G0jcGNFoRtTmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396363; c=relaxed/simple;
	bh=I1G1C8/wYBb3WmiSqlTLAgAytcyBvzKRDXGeZOuuq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIdssJvmDo9g/6cJZaU45G1+zUL2pRYGtrHu0QPCwaPPbvgYU+N04s9OAfkZNpKIR3OSdGLSxzVRnAfW34pWBAnIgtYVsWZm2DX1PNHbVLQYTX5XHPoPvl7aNWTYuowic+oAynnxYiOJQbV09SNKG6rKbmqPinlafa7onkybXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmDkNehs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108901F000E9;
	Thu, 25 Jun 2026 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396362;
	bh=VP88iuklqAdf7hC9O/72PM3nS3WsG53c9EmEgxnbPYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmDkNehswsk2XLp+dg4asuZcbIloqjPE6GcMH8ZSF8ynY4QObCKVmKIN//8JgNsFO
	 PMsZ5OaYp0yAM3c2r18MpKEXBNAdvXWLfU2tLH34eqJZBJvkeFooKIg8GSsb3iJeGL
	 HX0OfAXb60q9rwZ+eCvevHFJJcVeQ8qxXxlAc56l3FEaRm6Tudn18R+kexig4GIoWe
	 jKJkvyF6iDkRuqELTiJK4LX2kxKomxqAZkBfA2d+J4OC12dirU21dfCKOldYgUW53e
	 b36R6/iyrndfu9EaL2QjJR+rJ6Ef+qVwx+YTSe8Ulie9mA0hZVvdaTdWjh1WtLC+4x
	 D2XGlSh0+RAxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 25 Jun 2026 10:06:00 -0400
Message-ID: <20260625140600.2429183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062538-delicious-errant-833e@gregkh>
References: <2026062538-delicious-errant-833e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268561-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sozdayvek@gmail.com,m:andriy.shevchenko@linux.intel.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2C496C65FB

From: Stepan Ionichev <sozdayvek@gmail.com>

[ Upstream commit 10fc708b4de7f86002d2d735a2dbf3b5b7f65692 ]

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260514143746.23671-2-sozdayvek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ee589ad5266995..7d4841b72df0d4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -673,8 +673,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
-- 
2.53.0


