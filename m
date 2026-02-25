Return-Path: <stable+bounces-219258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD0hA5SenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:02:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E60D192CEB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7023125B23
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D32D1F44;
	Wed, 25 Feb 2026 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GpjdhbyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189AB2C17A0;
	Wed, 25 Feb 2026 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002598; cv=none; b=fjFku1J9PT+dShxcfA9yMU1foZRwsWxcD23TDr0Gu8hLtC5CTXKyjwLcnw79g+XNkEL/O5Zpc3RztPIk6dBpaqgNkCeVmJHPyHtv05YPyITKawQj8o+aDlmOXK5qzozCaSHlP4gxrAj7QimC3KBNaiTUR0n4bhtPTwOJiFb07zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002598; c=relaxed/simple;
	bh=i5RUP3XCJyOKtR9mfQJipUAhxmHZrP6QN3gIZnLOpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8q4+ekTFKNnlJwjUdiLmMpWek65K0ZoYLNBPB/EP81SrWJpBEDDyEz5KtXmvA8DydZBOUm4HNOYPu/r00CXXyhaDB2TROkYt7xH4sKFfuteIjV4caujZu9R679wqvCSP3H3EkDSe8jeWm79ZJlRem+ljFog8WuCCbTmQWJ2oXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GpjdhbyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A7DC2BC86;
	Wed, 25 Feb 2026 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002598;
	bh=i5RUP3XCJyOKtR9mfQJipUAhxmHZrP6QN3gIZnLOpqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpjdhbyDbX1xxlwvGNquRp3VKtf6nm6hR06caxQ7JhrJu9UjCuRzkhxkB7CXVmZlK
	 HSlSOOd3Ne6ieiyRRrIqWMXCos/oQ31h7pDq/LFGmgLpDQxm1CdX7GA0fv5Q0zhEDr
	 tF1IXPyKCwOYdAeyTIWQ12OADZrM8vBvJa3/yK4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waqar Hameed <waqar.hameed@axis.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 344/641] power: supply: ab8500: Fix use-after-free in power_supply_changed()
Date: Tue, 24 Feb 2026 17:21:10 -0800
Message-ID: <20260225012356.995366916@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219258-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E60D192CEB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waqar Hameed <waqar.hameed@axis.com>

[ Upstream commit c4af8a98bb52825a5331ae1d0604c0ea6956ba4b ]

Using the `devm_` variant for requesting IRQ _before_ the `devm_`
variant for allocating/registering the `power_supply` handle, means that
the `power_supply` handle will be deallocated/unregistered _before_ the
interrupt handler (since `devm_` naturally deallocates in reverse
allocation order). This means that during removal, there is a race
condition where an interrupt can fire just _after_ the `power_supply`
handle has been freed, *but* just _before_ the corresponding
unregistration of the IRQ handler has run.

This will lead to the IRQ handler calling `power_supply_changed()` with
a freed `power_supply` handle. Which usually crashes the system or
otherwise silently corrupts the memory...

Note that there is a similar situation which can also happen during
`probe()`; the possibility of an interrupt firing _before_ registering
the `power_supply` handle. This would then lead to the nasty situation
of using the `power_supply` handle *uninitialized* in
`power_supply_changed()`.

Commit 1c1f13a006ed ("power: supply: ab8500: Move to componentized
binding") introduced this issue during a refactorization. Fix this racy
use-after-free by making sure the IRQ is requested _after_ the
registration of the `power_supply` handle.

Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized binding")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/ccf83a09942cb8dda3dff70b2682f2c2e9cb97f2.1766268280.git.waqar.hameed@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 40 +++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 5f4537766e5b9..1813fbdfa1c1f 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3466,26 +3466,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Request interrupts */
-	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
-		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
-		if (irq < 0)
-			return irq;
-
-		ret = devm_request_threaded_irq(dev,
-			irq, NULL, ab8500_charger_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			ab8500_charger_irq[i].name, di);
-
-		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n"
-				, ab8500_charger_irq[i].name, irq, ret);
-			return ret;
-		}
-		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
-			ab8500_charger_irq[i].name, irq, ret);
-	}
-
 	/* initialize lock */
 	spin_lock_init(&di->usb_state.usb_lock);
 	mutex_init(&di->usb_ipt_crnt_lock);
@@ -3614,6 +3594,26 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(di->usb_chg.psy);
 	}
 
+	/* Request interrupts */
+	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
+		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_threaded_irq(dev,
+			irq, NULL, ab8500_charger_irq[i].isr,
+			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+			ab8500_charger_irq[i].name, di);
+
+		if (ret != 0) {
+			dev_err(dev, "failed to request %s IRQ %d: %d\n"
+				, ab8500_charger_irq[i].name, irq, ret);
+			return ret;
+		}
+		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
+			ab8500_charger_irq[i].name, irq, ret);
+	}
+
 	/*
 	 * Check what battery we have, since we always have the USB
 	 * psy, use that as a handle.
-- 
2.51.0




