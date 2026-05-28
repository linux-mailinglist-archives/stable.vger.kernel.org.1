Return-Path: <stable+bounces-255271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGAoMtyfGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A45F7C6D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AFE63173351
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50893409630;
	Thu, 28 May 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnq+/+HY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EC3BD649;
	Thu, 28 May 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998441; cv=none; b=qjsQn8W+baqDAZ77pDdlNlFuChPh/Xy/PfNxDpxb5eb2fXp2p2611tqUfShQjf6WlhLXQELf+HrsuW70fOXqc0hHP+z/iRR8xNntLjSn+WilIGGpst5FEpHCq6eolup6o7niSl8i6Y51frjywkm3JqsrdkgRbpZr4ozs66Mppzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998441; c=relaxed/simple;
	bh=/SajcqbNve5NDe4Cs9o5MoQSh2HLAJdDD2wxJRoo7lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSw/GtmJtCXxZ/ETDBQBY1E0KH8W9GvwD0+RxkwOgbhJExzBtAmbjuk0kG8UQ+Kb8Ey1BggdIG2q7V60eWhjE32lW3kPSpxk/57q0a1Ek3n40kOye2eEtsBtuFinjPE6Onl7CwxDvA7CAJk1Q3Xy9sZ9IK1DeEgaKsxe/vENW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnq+/+HY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832F01F000E9;
	Thu, 28 May 2026 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998440;
	bh=kqV0QQ3rKHmdh0KZwnWELpei+q5sOxcz1eW5obyZsDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wnq+/+HYqDSoM+HyRNqF09FgJImDJFn9GRaTjtMj+shCuZFVzoOOJHVEGb2qslW+L
	 oqFojxOgdRc0hPxB5grx9Jaxhx1DYr92j2giSw2ET5YYnzpIGz48oHMJr18lzbqA4Z
	 QU51hyKw5+KLqS17qonPa4Mz28MRlGKVgWjdRdkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 174/461] pinctrl: mediatek: moore: implement gpio_chip::get_direction()
Date: Thu, 28 May 2026 21:45:03 +0200
Message-ID: <20260528194652.107376713@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,public-files.de,oss.qualcomm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255271-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,public-files.de:email]
X-Rspamd-Queue-Id: 2D2A45F7C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit b560d414239232c6ed7205d3795d3f588034d69b ]

If the gpio_chip::get_direction() callback is not implemented by the GPIO
controller driver, GPIOLIB emits a warning.

Implement get_direction() for the GPIO part of pinctrl-moore.

Fixes: 471e998c0e31 ("gpiolib: remove redundant callback check")
Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Closes: https://lore.kernel.org/all/20260409132724.126258-1-linux@fw-web.de/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-By: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 70f608347a5f6..071ba849e5322 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -520,6 +520,23 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
+static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	const struct mtk_pin_desc *desc;
+	int ret, dir;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
+	if (!desc->name)
+		return -ENOTSUPP;
+
+	ret = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &dir);
+	if (ret)
+		return ret;
+
+	return dir ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
@@ -566,6 +583,7 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 	chip->parent		= hw->dev;
 	chip->request		= gpiochip_generic_request;
 	chip->free		= gpiochip_generic_free;
+	chip->get_direction	= mtk_gpio_get_direction;
 	chip->direction_input	= pinctrl_gpio_direction_input;
 	chip->direction_output	= mtk_gpio_direction_output;
 	chip->get		= mtk_gpio_get;
-- 
2.53.0




