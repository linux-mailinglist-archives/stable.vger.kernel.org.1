Return-Path: <stable+bounces-219264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM14OLaenmlVWgQAu9opvQ
	(envelope-from <stable+bounces-219264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC2192D36
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B73F3064D97
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300842D238F;
	Wed, 25 Feb 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FfN7JuL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680B2C17A0;
	Wed, 25 Feb 2026 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002602; cv=none; b=r0UvFkQv8NMX3X+CWDy2tAA5Gg4yV42pVms8XpWyAz75vUG5bhpazMegmTWnkA4AlLqULN+16cVRf/eksFPlu/qW2OheQ56nXg8uxBUdG3RDD9l3QHO7wgzfkb+kQFfv6vy4iN3ZT886czyvtzz47PI+PNCJ2fsCR3oLzJl09vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002602; c=relaxed/simple;
	bh=WkpxZ+z8ofXC4/VGdnzEipJZP6KzSzeQaWHEjLkSppA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laKEUhIVV5EmjrI4r41QbgtxHBJNbo3rRLWzOjoX56ggQMbHAigc+icG/GvlNdKGdMc5anbrICMPJFrPckdp5sVrzOqb31gY49m1Xr1cntI7qmfqE75jS9xthZ4tqn0bP7oE7Fn9inoiQGyv/qRcdrh1Wj/uzi9QB07WrvpE1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FfN7JuL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAECC116D0;
	Wed, 25 Feb 2026 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002601;
	bh=WkpxZ+z8ofXC4/VGdnzEipJZP6KzSzeQaWHEjLkSppA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfN7JuL5T9N/E/IfEpiCAru6a7jSPz3XVf5heBDEUgMqiielB6fgs6sBOfvKAjbl7
	 RvieDtqAemc+JyjO2UaiZaZhjQk59QIzsDCO2vlafJSyvD5k5sicY2GIz1vs5ACLCK
	 VV4q+Xv511i73QG2nP5TzlFDj1AoaG5WyUxBFUnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 349/641] power: supply: goldfish: Fix use-after-free in power_supply_changed()
Date: Tue, 24 Feb 2026 17:21:15 -0800
Message-ID: <20260225012357.105041621@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219264-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,axis.com:email,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73BC2192D36
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waqar Hameed <waqar.hameed@axis.com>

[ Upstream commit b2ce982e2e0c888dc55c888ad0e20ea04daf2e6b ]

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

Fixes: 84d7b7687489 ("power: Add battery driver for goldfish emulator")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Link: https://patch.msgid.link/500a606bb6fb6f2bb8d797e19a00cea9dd7b03c1.1766268280.git.waqar.hameed@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/goldfish_battery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index 479195e35d734..5aa24e4dc4455 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -224,12 +224,6 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return -ENODEV;
 
-	ret = devm_request_irq(&pdev->dev, data->irq,
-			       goldfish_battery_interrupt,
-			       IRQF_SHARED, pdev->name, data);
-	if (ret)
-		return ret;
-
 	psy_cfg.drv_data = data;
 
 	data->ac = devm_power_supply_register(&pdev->dev,
@@ -244,6 +238,12 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (IS_ERR(data->battery))
 		return PTR_ERR(data->battery);
 
+	ret = devm_request_irq(&pdev->dev, data->irq,
+			       goldfish_battery_interrupt,
+			       IRQF_SHARED, pdev->name, data);
+	if (ret)
+		return ret;
+
 	GOLDFISH_BATTERY_WRITE(data, BATTERY_INT_ENABLE, BATTERY_INT_MASK);
 	return 0;
 }
-- 
2.51.0




