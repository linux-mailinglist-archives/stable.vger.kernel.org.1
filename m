Return-Path: <stable+bounces-219262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI7EDKyenmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE7192D24
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE5D312F728
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CD2D1F40;
	Wed, 25 Feb 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wy0xnLEh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F532C17A0;
	Wed, 25 Feb 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002600; cv=none; b=NLl1qhvsmgCZQ2LnpVqNtpOGpBFAXkemXgfjhYnX2MyvJGrknyGaqHAm/w//y3iYaPVbrjZl3JzHhAesu7XqHZwfcNOFXBFjMAaBIiJ5utqknp6+1hZLIcSCMdlK9TxPEg7xbW8cLGfVDqDORGNvYRpmR0XeKD5md2933b4SYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002600; c=relaxed/simple;
	bh=/Kwzz5XCPX6OpMxP02av20uWd4Kd5C8eoC0dvuovOKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPcVeKtslvqJfRLbWwb4JpUTjrXr0mn9SXGfborzY2L3iVuOPyWveVeADS/+K8hpb/PbwtcZL1K2gSpA9K5hLHKTHgFFC3BZa/aRsh6FE3CSbELta076gvr1Qat1NiOymmv1RKM9frOm4c5lqAarOx+YaJ5vEgw9stetf3kqG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wy0xnLEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C461C116D0;
	Wed, 25 Feb 2026 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002600;
	bh=/Kwzz5XCPX6OpMxP02av20uWd4Kd5C8eoC0dvuovOKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wy0xnLEhKgWrHw7j3OQhRjMKHqIJQk5l7XkMpI8U/I+Re0bO8rN1LrKGabvh6qhyD
	 uBoKHHUjcP3VzbcyVi2HtkXJ9cVpQj5Gp7WwZggf2A3KH97h1qEotZBSalGcCOEl+W
	 77tQlT8MugVoyTQQAWZZFq6c4MjUUleqZyThpQKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 347/641] power: supply: bq25980: Fix use-after-free in power_supply_changed()
Date: Tue, 24 Feb 2026 17:21:13 -0800
Message-ID: <20260225012357.062385399@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219262-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 7BEE7192D24
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waqar Hameed <waqar.hameed@axis.com>

[ Upstream commit 5f0b1cb41906e86b64bf69f5ededb83b0d757c27 ]

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

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Link: https://patch.msgid.link/8763035cadb959e14787b3837f2d3db61f6e1c34.1766268280.git.waqar.hameed@axis.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq25980_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 723858d62d141..73f06f09f134c 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1241,6 +1241,12 @@ static int bq25980_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = bq25980_power_supply_init(bq, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						bq25980_irq_handler_thread,
@@ -1251,12 +1257,6 @@ static int bq25980_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = bq25980_power_supply_init(bq, dev);
-	if (ret) {
-		dev_err(dev, "Failed to register power supply\n");
-		return ret;
-	}
-
 	ret = bq25980_hw_init(bq);
 	if (ret) {
 		dev_err(dev, "Cannot initialize the chip.\n");
-- 
2.51.0




