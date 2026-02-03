Return-Path: <stable+bounces-213314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IY3AIBmgmlOTgMAu9opvQ
	(envelope-from <stable+bounces-213314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 22:20:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93449DECB3
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 22:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F85E30A65BA
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37DD2DF6F6;
	Tue,  3 Feb 2026 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX+BoD+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC327A123
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153510; cv=none; b=AiNY2+Whb+K0IMTbfDu3LBxvlVc6oNa74RHobKzJ019kVpIqbI0IAbR42o+/EcpH6JlGVCrViv2O/CENzezwLlLakoRkRdYxu1MCy891Q29gJcTh+X5h9jXs+MrPrBi9aPKUbBUn5lPGODLXzcWG2JkxuORrEjGdKZSh0xsAD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153510; c=relaxed/simple;
	bh=MEeQSn2jPwz6D8Xmb6toTPXIKj+BfWpKk7FnN7z97sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV3vQHckjRLG1yIOS9swY+kvfbA2rD88Zcgv+6vQiXIOPl6VW0LVcMURJDEUK9I2+G5VibacCB9VL0RbRtLQhq80FAZAPnvWCJjs+UnDSgGKxLa8UrjI0dBqbUo+wtx444T4ghMrUO/O52umls0s0PT9rvvGX2sS7JIJFfzov9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX+BoD+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E73C116D0;
	Tue,  3 Feb 2026 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770153510;
	bh=MEeQSn2jPwz6D8Xmb6toTPXIKj+BfWpKk7FnN7z97sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MX+BoD+Z1e50YmftVp/8HhsS0F+WoJOOiQ4GgMwMYo6K+ueyjiSNbuTFdLsDsp+Ws
	 kYfnLod6cYkL+bGXD5B+NxyM5L+4XJmvu/2DUPRna0rCTGjlJXevWfAGivIcQY2eFA
	 YEYhwU2NoovhuYpZCkvzirjT6Wj4IESBUgf8qfNRV5DxV0gMmIFXI828sJYJJXN2Jd
	 laDBGHsZ8yqb9r5ivZKYUEct9MOkL/3VyhgLYXayFKi51HOHd0yDEDcUPPngnvz6J0
	 1DBxZDWLYjtHJXCpdgUN0n3q7OE2kB/IoF9WvwyKGZT2eLM6szeF0JaolI5dxWMtxk
	 zHpTtMdBLjzrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver
Date: Tue,  3 Feb 2026 16:18:27 -0500
Message-ID: <20260203211827.1414472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020310-bulk-spool-db7b@gregkh>
References: <2026020310-bulk-spool-db7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 93449DECB3
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 4f0d22ec60cee420125f4055af76caa0f373a3fe ]

GPIO controller driver should typically implement the .get_direction()
callback as GPIOLIB internals may try to use it to determine the state
of a pin. Add it for the LPASS LPI driver.

Reported-by: Abel Vesa <abelvesa@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X1E CRD
Tested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
[ PIN_CONFIG_LEVEL => PIN_CONFIG_OUTPUT ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 4a9dfa267df51..4c805ad57b1cb 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -298,6 +298,22 @@ static const struct pinconf_ops lpi_gpio_pinconf_ops = {
 	.pin_config_group_set		= lpi_config_set,
 };
 
+static int lpi_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	unsigned long config = pinconf_to_config_packed(PIN_CONFIG_OUTPUT, 0);
+	struct lpi_pinctrl *state = gpiochip_get_data(chip);
+	unsigned long arg;
+	int ret;
+
+	ret = lpi_config_get(state->ctrl, pin, &config);
+	if (ret)
+		return ret;
+
+	arg = pinconf_to_config_argument(config);
+
+	return arg ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int lpi_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 {
 	struct lpi_pinctrl *state = gpiochip_get_data(chip);
@@ -395,6 +411,7 @@ static void lpi_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #endif
 
 static const struct gpio_chip lpi_gpio_template = {
+	.get_direction		= lpi_gpio_get_direction,
 	.direction_input	= lpi_gpio_direction_input,
 	.direction_output	= lpi_gpio_direction_output,
 	.get			= lpi_gpio_get,
-- 
2.51.0


