Return-Path: <stable+bounces-218492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ2MFjBSnmm6UgQAu9opvQ
	(envelope-from <stable+bounces-218492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C776B18F260
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8AF305DED1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AF23D7CF;
	Wed, 25 Feb 2026 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0nfmLvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4C18B0A;
	Wed, 25 Feb 2026 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983322; cv=none; b=Hb8mFrVhkgSXc/S6FuWNsxiiQVnCSMffLiih+wwg0p6sUnZhrviVFz0xdwtImxQNVPKF25OY9RjkNPAYL3k3T7wnzZmDssDtcnikril9K+WWfgL1g1nP0yEq6xkQQdCHDmC1zUhpgyHJWT/+6yyhXPtooFIrlORssDo+4/A+aNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983322; c=relaxed/simple;
	bh=n1/Zdp1wqCwSCuamMd7oszI0TwK/J9IWbx0X2LkXcuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDDztF8pp1YWyep3FXWGdTiG/5oBKdVmXYNMUJamoVwtPD3UcgiWp7iGqDXtReu6zyxOcZEvfTHzpN10vtIaq5/XPoXmPymrnkK96N+ZmBGLQO1SSLLK4djavjCtOp0ir3PkEELtej0S/Mo/Ti+alCj7EW9BxzCHQ2CysbCicA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0nfmLvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EE1C116D0;
	Wed, 25 Feb 2026 01:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983322;
	bh=n1/Zdp1wqCwSCuamMd7oszI0TwK/J9IWbx0X2LkXcuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0nfmLvGIC5Vecv0QCZm46l5D8CX8ODvUVKe4I7tALcrb3OUxOCvn7KCzo/Px5Tow
	 YPD845FA0wWMVqsmAUY4GuZHFdyfYR9Y0ONh8ag/kRPCs3tGIR3SZMnE16jLaUtlSt
	 CVJ3DLJpaUM7HggPQF8EI02+ycxBmND1K/O2XkzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waqar Hameed <waqar.hameed@axis.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 455/781] power: supply: pm8916_lbc: Fix use-after-free in power_supply_changed()
Date: Tue, 24 Feb 2026 17:19:24 -0800
Message-ID: <20260225012410.877081192@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218492-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: C776B18F260
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waqar Hameed <waqar.hameed@axis.com>

[ Upstream commit b7508129978ae1e2ed9b0410396abc05def9c4eb ]

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

Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Reviewed-by: Nikita Travkin <nikita@trvn.ru>
Link: https://patch.msgid.link/64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/pm8916_lbc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index c74b75b1b2676..3ca717d84aade 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -274,15 +274,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL,
 				     "Wrong amount of reg values: %d (4 expected)\n", len);
 
-	irq = platform_get_irq_byname(pdev, "usb_vbus");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
-					IRQF_ONESHOT, "pm8916_lbc", chg);
-	if (ret)
-		return ret;
-
 	ret = device_property_read_u32_array(dev, "reg", chg->reg, len);
 	if (ret)
 		return ret;
@@ -332,6 +323,15 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to get battery info\n");
 
+	irq = platform_get_irq_byname(pdev, "usb_vbus");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
+					IRQF_ONESHOT, "pm8916_lbc", chg);
+	if (ret)
+		return ret;
+
 	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
 	if (IS_ERR(chg->edev))
 		return PTR_ERR(chg->edev);
-- 
2.51.0




