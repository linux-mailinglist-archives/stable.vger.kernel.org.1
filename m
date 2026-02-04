Return-Path: <stable+bounces-213321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQ/I42MgmnXWAMAu9opvQ
	(envelope-from <stable+bounces-213321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:02:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF00DFE20
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088B830BC541
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138110E3;
	Wed,  4 Feb 2026 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZDzjCDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149083BB5A
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163336; cv=none; b=kGFwT/jhHS5SiZUvZhDCvBFWUYJXAOGPUQF9zzXJIz8U3iF/FW5JNHgihU96skUjaWWsJaQOj1uUXVltTszxrdJYseBSNlZlfOYC0A9C38oJL5rprHa85TlV7hY767jeOhSofHJ9zblo3uJEvcipU8AEKaa8vuYq0ol68xVNpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163336; c=relaxed/simple;
	bh=PacOmve/U3UV7XfSFVtjNZ/BGDpAbedYUhYAENPaoP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrOoTyUs4yjyz+OesOzdfbEHAXxsxIJ7xbu5/k2EWS6f1Lp3g/PmRMk3iJ3iO62hy+AEB7FlJoNSRhB1h0smJw3750A37BZHGIPVKQDfDpGUZNpwGtiu4foH85DydJ1q41RTsUMn9LXDubVo4C98gDMlRFohKzBfFawWmJPWzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZDzjCDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B2C19422;
	Wed,  4 Feb 2026 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770163335;
	bh=PacOmve/U3UV7XfSFVtjNZ/BGDpAbedYUhYAENPaoP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZDzjCDr6Ph/6W8I8v6AwVCOpF6U8VG0EmvpoqfthQSWq0lfTCZnJv40YQzesdFRJ
	 GgdI8nGmdpqyvQXpuRPEl8QOcwFW8ckhOjiilTMNRoNW+EDjyVU6eJ9HsN9iSq49Ut
	 ztQop93NF/2COekSc7IjghpXATUTfW6PQztHLSZm02D0uXC3gvte52EQH/sYs90IGS
	 cLLyGaFYFCV/+pHvMp/9LsUv7B61mNQ+WbKc4eSV1IVDs3jlMcOVUDxSdpTEgCIly/
	 Il484vfR5Vu9OdJyPhz0p3pxqam4Yx3vpmjtz/14exF5SX2WP9yEFFFT3B3njREUMD
	 EhCmjhEvjTLrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver
Date: Tue,  3 Feb 2026 19:02:13 -0500
Message-ID: <20260204000213.1456166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020347-unwoven-unfounded-f900@gregkh>
References: <2026020347-unwoven-unfounded-f900@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213321-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CF00DFE20
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
index bd15009a2bcf8..586c5b70cba13 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -484,6 +484,22 @@ static const struct pinconf_ops lpi_gpio_pinconf_ops = {
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
@@ -582,6 +598,7 @@ static void lpi_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #endif
 
 static const struct gpio_chip lpi_gpio_template = {
+	.get_direction		= lpi_gpio_get_direction,
 	.direction_input	= lpi_gpio_direction_input,
 	.direction_output	= lpi_gpio_direction_output,
 	.get			= lpi_gpio_get,
-- 
2.51.0


