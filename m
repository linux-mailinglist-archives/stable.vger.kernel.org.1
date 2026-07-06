Return-Path: <stable+bounces-272283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntwmJ5nxS2rVdQEAu9opvQ
	(envelope-from <stable+bounces-272283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 20:19:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F0714697
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 20:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=yntJKzUw;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272283-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272283-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B58E30382BF
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CD431489;
	Mon,  6 Jul 2026 16:17:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A773F8EBE
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:17:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354653; cv=none; b=Gim+bmNW4a/F57NlQUrmrSYvk2cqoTRdG1J5092CDuAB4MEKKLNCKeQ82CLM5IVgmuIQJYAgjZrUmC7V1tHGEmMnPsOyOtcaNLZiutaGj7jGow4c+VrNJs8YYLP8ijlo2gTLF6S2sQDicC3EU47siltTZEcM1IA2/Ec1CiGtHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354653; c=relaxed/simple;
	bh=i4448/Ht9/Ao2aByTcvyFrrM3TgYmrLiV2IEHZfIfoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuKopdbQZ618Au+zBr4e5AgF2eN0XzQDunJZj6yJtcIGTs809FTZATlRdxXz9+e/smSo66/sBipILRgQ7aKzRM40ElgawY6ZlLIHYspTDN8F5VuNgSl+iW4Z2yXbyRNJc2hzrl7Nkn21FRHqnA5ZLIwm0TFU0lxlIV/kZaEy4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yntJKzUw; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=60HILYPxioIrCrtDNI329uRd98Y75sDRSfyxS4x3NT8=; b=yntJKzUwZL74TGwa8RA+I/oqeH
	d82H3VmWwyeFxkO+osQCSfCNgmjrCMCFkEoQ/Or/uc0jiIWy0uvvxZa4XXBMlgbeHkuGevfIQSbsq
	/GCY/ZrxE0BX35zZYfstXsGWtp4jLHTQGBE/tTo0VaYybEPN51lM8gvQlVQ/T8aw3NlX8yJnsS3ZT
	vKLCiaMCu1l00ZmGLN0sAIUKKgAPRLGJV9XArhZL55jSHj3kUMUQgj66f0QklEgxslot9U7bAv9gJ
	YtU+AiZjrg1boZpFsJYsqJv95nJYYWJ5QYlcvSGFwoac4gbhn3qFz6u7ReyYsRv/mrbnYS6O7ZA1W
	tki9FLYg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Ye Zhang <ye.zhang@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 1/3] gpio: rockchip: change the GPIO version judgment logic
Date: Mon,  6 Jul 2026 18:17:11 +0200
Message-ID: <20260706161713.2676365-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706161713.2676365-1-heiko@sntech.de>
References: <20260706161713.2676365-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272283-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:heiko@sntech.de,m:quentin.schulz@cherry.de,m:ye.zhang@rock-chips.com,m:sebastian.reichel@collabora.com,m:andriy.shevchenko@linux.intel.com,m:bartosz.golaszewski@linaro.org,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,collabora.com:email,linaro.org:email,cherry.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 940F0714697

From: Ye Zhang <ye.zhang@rock-chips.com>

[ Upstream commit 41209307cad7f14c387c68375a93b50e54261a53 ]

Have a list of valid IDs and default to -ENODEV.

Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241112015408.3139996-3-ye.zhang@rock-chips.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpio/gpio-rockchip.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 052713bd8d07..16c1ec3a5d0e 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -653,8 +653,9 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 
 	id = readl(bank->reg_base + gpio_regs_v2.version_id);
 
-	/* If not gpio v2, that is default to v1. */
-	if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
+	switch (id) {
+	case GPIO_TYPE_V2:
+	case GPIO_TYPE_V2_1:
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
 		bank->db_clk = of_clk_get(bank->of_node, 1);
@@ -662,9 +663,14 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 			dev_err(bank->dev, "cannot find debounce clk\n");
 			return -EINVAL;
 		}
-	} else {
+		break;
+	case GPIO_TYPE_V1:
 		bank->gpio_regs = &gpio_regs_v1;
 		bank->gpio_type = GPIO_TYPE_V1;
+		break;
+	default:
+		dev_err(bank->dev, "unsupported version ID: 0x%08x\n", id);
+		return -ENODEV;
 	}
 
 	return 0;
-- 
2.53.0


