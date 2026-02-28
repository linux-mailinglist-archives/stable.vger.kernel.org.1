Return-Path: <stable+bounces-220706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPY3GXJAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20E1C6E5C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4B3D309D974
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336243FB076;
	Sat, 28 Feb 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak9iRzvS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2C3FB06C;
	Sat, 28 Feb 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300586; cv=none; b=bsOHiBAdDeu8YfoTC9ZXAM+kRaNJcHI5QC9hVROyGJhzvBf/zooAQTM3eMsR09aLL4dwC3HDf5rw5AkE9yo1yoEjnFhZbWJlpoJ9MK+YW67pU5mHbgW7rHHFgM5VbYU1OXxt2T6dMx2b2sDM3ACI8tMPNenbwgtkqCgbGjRSb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300586; c=relaxed/simple;
	bh=0Mqm9g8b0uJL2WhV7ayN85PIyCavrW4mYuHt/F+FbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aahV52EvZBtU1VRNVS5WenKqPSPusxD0BeY/NEZBwiA++VRamGLHv5So7hRpaNPvqVXHBxoeDFuUU+W1KxK+Q9nH51xY7/iCUcT4Co78S7gWMCsDIP7VPzxMm00vKPlk1fMSL40nWxHq+4xcb2bTimREYyrzT+udthYdJtMrgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak9iRzvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4042DC19423;
	Sat, 28 Feb 2026 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300585;
	bh=0Mqm9g8b0uJL2WhV7ayN85PIyCavrW4mYuHt/F+FbWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ak9iRzvSvOUX6+liXxyjehOk0YEKouyguIiab4R6upEuPbjJht+bHT2qxWx2dxmHk
	 e82NsHEkSiXFkWdExm2c3UNGX+Ns9ozlUneCZlwzeLevAQy0/zvaWGLto9nGnbCoTw
	 ozhFsxmVBF+5h78csB95s9GjVxivtBzgPCjjaMJOXwG65DYc18Q99QQEwOQQVeDwE1
	 d9oqMgzitDkrTqJHWZo82b0AFk1b2ij2j4vGR3GbLQ5+ZFO1rNN06RdbfxW6ch5qpa
	 lAEruF1ItUsdJLX4tkRdtmFHRrg/gide7WdegzPgXjCvWhfDOPcXthJB0+MmcZiZHA
	 DxO8es6aQ8l9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 627/844] rtc: pcf8563: use correct of_node for output clock
Date: Sat, 28 Feb 2026 12:29:00 -0500
Message-ID: <20260228173244.1509663-628-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220706-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: 1B20E1C6E5C
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


