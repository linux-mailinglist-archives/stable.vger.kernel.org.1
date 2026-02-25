Return-Path: <stable+bounces-218491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJVWFi1Snmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70518F24B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83CA2308863D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48D248F54;
	Wed, 25 Feb 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k3BWbEjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5E1EB5E1;
	Wed, 25 Feb 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983321; cv=none; b=XY+ByL+o4uGm7OpY1ee0v1l9Y7zeNJP7mzy9hEHLikTVsusxxgoNU1BPpFDZWTs0drWMQ8sUpp9r+HYMyX/qZ4+mQnPW7BlQvmp63yoHna+ukKku6g/cua8wMDhVLl+AgqgaBVWlHwKxGrAiB8EAPqQTctlQaqJ2gn6gXslL1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983321; c=relaxed/simple;
	bh=j2Obg1/gHS/t20qUiG7kyDp2jIYU59d62OLjKFjPFKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkiosm8bVJZJKDtviKjqkfG64VA5KozUl1H5KKHGtSYEJtKEEcD7AfD2IYZ9uJZM6x++NcwhCM7d+r7V3qzEdm7ibpZYSmUqwI6SivLL4gMwUDyxQl4RjBTxN8m3//+yrVhoTdG3DPkCVO9akh889bbmrUnjdnlWV3HHSzncxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k3BWbEjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC713C116D0;
	Wed, 25 Feb 2026 01:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983321;
	bh=j2Obg1/gHS/t20qUiG7kyDp2jIYU59d62OLjKFjPFKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3BWbEjYsa/r8OENxZcVqPiMD5MNEJ3rMkXelkDDzIC1KY5yzmuY3wJ5hz2z0ejD2
	 eExMFu08MCzUjBuxxiYPJTOGbVmxeHOKP+r9oSavWMDXbFJVQZIBWElG8nQTjMQtAd
	 2aqX8VNBmPkpeXIQAqdma/T5+Rq5lBwQJlPQ2x7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waqar Hameed <waqar.hameed@axis.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 454/781] power: supply: pm8916_bms_vm: Fix use-after-free in power_supply_changed()
Date: Tue, 24 Feb 2026 17:19:23 -0800
Message-ID: <20260225012410.851300102@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218491-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email]
X-Rspamd-Queue-Id: BD70518F24B
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waqar Hameed <waqar.hameed@axis.com>

[ Upstream commit 62914959b35e9a1e29cc0f64cb8cfc5075a5366f ]

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

Fix this racy use-after-free by making sure the IRQ is requested _after_
the registration of the `power_supply` handle.

Fixes: 098bce1838e0 ("power: supply: Add pm8916 VM-BMS support")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Reviewed-by: Nikita Travkin <nikita@trvn.ru>
Link: https://patch.msgid.link/2749c09ff81fcac87ae48147e216135450d8c067.1766268280.git.waqar.hameed@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/pm8916_bms_vm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
index 5120be086e6ff..de5d571c03e21 100644
--- a/drivers/power/supply/pm8916_bms_vm.c
+++ b/drivers/power/supply/pm8916_bms_vm.c
@@ -167,15 +167,6 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return -EINVAL;
 
-	irq = platform_get_irq_byname(pdev, "fifo");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
-					IRQF_ONESHOT, "pm8916_vm_bms", bat);
-	if (ret)
-		return ret;
-
 	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tmp, 2);
 	if (ret)
 		goto comm_error;
@@ -220,6 +211,15 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to get battery info\n");
 
+	irq = platform_get_irq_byname(pdev, "fifo");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
+					IRQF_ONESHOT, "pm8916_vm_bms", bat);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, bat);
 
 	return 0;
-- 
2.51.0




