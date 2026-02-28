Return-Path: <stable+bounces-221030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBHNNlhNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8B1C826E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575AF332C8F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC64BCAD1;
	Sat, 28 Feb 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNuuztnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C92175A60;
	Sat, 28 Feb 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301372; cv=none; b=IdxQMiadi0rHOx+SO3oLQBBtwAA+rZQ3TR75Hx+ae0yYBJTfgTW8EY5l+ymBdE1e0wVh8t6Uw2bvbGEjr6Pxrg5N1ukSwWgdx1bFC0fkFYx7f14bA/R/sdBXdSMeTu71+1awcZICLRN5lb/0Ffz7aXIdr7yha7nYnyqi5ByxJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301372; c=relaxed/simple;
	bh=0Mqm9g8b0uJL2WhV7ayN85PIyCavrW4mYuHt/F+FbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKtfEPMe8RHO8rfbtUoL7EzglOXtemOSU/rOcqP3NAy0X6fhI9xtm1LylyIzfZrBIGwctE1z5I6IfNTaJZDToO4waOe0r7GhG3+pkBIEJ0D+DkCSvnN03t85uHvGg9W/OBECNiy5y5GNQRsf8dQQKhYzamyNk9JQjbcC7lwXAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNuuztnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB2C19423;
	Sat, 28 Feb 2026 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301372;
	bh=0Mqm9g8b0uJL2WhV7ayN85PIyCavrW4mYuHt/F+FbWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNuuztncOuEwsmyiTqf02p3fdwpr/sH24O4UbM/7bvjXzfysnnOTlnBS86YZPD85Y
	 b3L4+zJ+WKMVwCtsVrzHdPiTye4RuU5EMBUUx91VLLjxLihI8KRGZ0Q9vh9qJ0pmrC
	 M8C5kxPtLCyNMDIVUSlmm9tQMsW/uVB6v0o71zcjRq46nPQtqcx14Z/2IQ55UBn4Ij
	 wUlxFxB4vqMA0sbhaGSiglY7yvImhuINtzo0baQ/OTNCXZW3Rnug+mWCfbXDjoy//v
	 qMuyNLI1H1NUp4xNoM4nk+x8HssOtXrBoU+f7jut0AbpfIQA7T3RGrKGxNF4cZoqhh
	 sGFiRVpR9rAJw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	stable@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 561/752] rtc: pcf8563: use correct of_node for output clock
Date: Sat, 28 Feb 2026 12:44:32 -0500
Message-ID: <20260228174750.1542406-561-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221030-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,inmusicbrands.com:email]
X-Rspamd-Queue-Id: 83E8B1C826E
X-Rspamd-Action: no action

From: John Keeping <jkeeping@inmusicbrands.com>

[ Upstream commit a380a02ea3ddc69c1c1ccca3882748dee33ec3d3 ]

When switching to regmap, the i2c_client pointer was removed from struct
pcf8563 so this function switched to using the RTC device instead.  But
the RTC device is a child of the original I2C device and does not have
an associated of_node.

Reference the correct device's of_node to ensure that the output clock
can be found when referenced by other devices and so that the override
clock name is read correctly.

Cc: stable@vger.kernel.org
Fixes: 00f1bb9b8486b ("rtc: pcf8563: Switch to regmap")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Link: https://patch.msgid.link/20260108184749.3413348-1-jkeeping@inmusicbrands.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 4e61011fb7a96..b281e9489df1d 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -424,7 +424,7 @@ static const struct clk_ops pcf8563_clkout_ops = {
 
 static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
 {
-	struct device_node *node = pcf8563->rtc->dev.of_node;
+	struct device_node *node = pcf8563->rtc->dev.parent->of_node;
 	struct clk_init_data init;
 	struct clk *clk;
 	int ret;
-- 
2.51.0


