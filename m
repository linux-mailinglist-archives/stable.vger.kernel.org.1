Return-Path: <stable+bounces-220638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDSkFgE9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D504A1C6A10
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DDDB30B4D3F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614663EC6AA;
	Sat, 28 Feb 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5a4AqD+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7293EC6A1;
	Sat, 28 Feb 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300521; cv=none; b=tf7oA5F/d6Mr8ini5X5A98f4gBSGwYTKT9garKLzWHgjQThIRHjS+rdiG1AfshglyjwSXLqIAH9291USDNO4tQAA83HUMj7aJLrIWQymVJvwcvqFW8DKLdEEEuitFHu9lbT7CDuSiCasbvgJiFfZ0hp1cAfe2LsD87Z1BSFzq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300521; c=relaxed/simple;
	bh=utHPXQc9RqqcaVu8J4sNgSzfIU0UZzlEg2GttMHPoY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KByfVgoL32GYnBtFikOazVF+5RkiMWp+L2xjq4/MREdxLizC3flcBeusZTdHz9bQrTBShfCIsr0do+wQbwRim9XSVccZIajuza5sWgKjSlbidvs5kxv+VRFTLtN7ElGFQLhWK2ykf2V1KEPDumXEKjxHi59s4SvnKcTT4RcdVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5a4AqD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBE9C2BC9E;
	Sat, 28 Feb 2026 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300521;
	bh=utHPXQc9RqqcaVu8J4sNgSzfIU0UZzlEg2GttMHPoY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5a4AqD+ZrOvc8o9cipDV+js+qDcbS4y0ljpbRy36bF08M8XoAvGziKnQFU2IpvTt
	 Eis08QFI3IoR878yJxlIfQ8HzLaz377nco7Q6vkbzlBVyO380Jxfd4/cOEsFbBxPPa
	 J+Smi+xPzgdWv3Sz6XGyRJ0iL1jwUUTMkZgl6dEcTnFsKCXmGZsBQb2DcT3aK8MLOy
	 XulkJ8SmwlmNnl1KDrtns0BujbxQwyeueW24My/mXEjOHPGQ+WvK+hOb/RG351LtN1
	 hy9deCJEMOQ8EDvejy/uSbCzOAaowsLvFckTeokCqqpxNlrRyFGEZISRLxhdRWSX+u
	 GU1MupbpiCZ9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 559/844] pinctrl: meson: amlogic-a4: mark the GPIO controller as sleeping
Date: Sat, 28 Feb 2026 12:27:52 -0500
Message-ID: <20260228173244.1509663-560-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,googlemail.com,linaro.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220638-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: D504A1C6A10
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit d6df4abe95a409e812c5d9af9657fe63ac299e3a ]

The GPIO controller is configured as non-sleeping but it uses generic
pinctrl helpers which use a mutex for synchronization. This will cause
lockdep splats when used together with shared GPIOs going through the
GPIO shared proxy driver.

Fixes: 6e9be3abb78c ("pinctrl: Add driver support for Amlogic SoCs")
Cc: stable@vger.kernel.org
Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Closes: https://lore.kernel.org/all/CAFBinCAc7CO8gfNQakCu3LfkYXuyTd2iRpMRm8EKXSL0mwOnJw@mail.gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
index f05d8261624a4..40542edd557e0 100644
--- a/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
+++ b/drivers/pinctrl/meson/pinctrl-amlogic-a4.c
@@ -895,7 +895,7 @@ static const struct gpio_chip aml_gpio_template = {
 	.direction_input	= aml_gpio_direction_input,
 	.direction_output	= aml_gpio_direction_output,
 	.get_direction		= aml_gpio_get_direction,
-	.can_sleep		= false,
+	.can_sleep		= true,
 };
 
 static void init_bank_register_bit(struct aml_pinctrl *info,
-- 
2.51.0


