Return-Path: <stable+bounces-220537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF1wHGRNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC91C827F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F20F3157C73
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5723CFD0A;
	Sat, 28 Feb 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T34sPbUb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112E3D061B;
	Sat, 28 Feb 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300420; cv=none; b=PRaNvJKq6usEyxxR4k6E+G3oi3H+0oD4+c3c8oycWSpfQ1yhDA5bOG8zKGXfNoZmdDIj3Z5ZhvfUUkEL/UOGYqCCWF9VNIMcObbZcNf9hUnW+UJxIJB+CzEx+3KMV3SunTG6+8Z2cviRXa7A+aBY705yDrUBSP5nXSvLachoCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300420; c=relaxed/simple;
	bh=weKkzB8KZ5DLReewVFSur3h8mJwcAvL7MIgP5XVfu5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQhi7LUrig3ZvHaLu1hHZK7R17JOgYeCW33OntBEaUhJ97CPGCMwmpSXS5tiwOAULAIT2unEH69JuCm/i9RObw7MNcqysoQEEg2xyumHg0PMOE2LDCicXtQo0W2PjcRUdWAFGjbagb+1Fmykm63hqprZBsIeofxhhkZ3BaxtYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T34sPbUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E90CC19425;
	Sat, 28 Feb 2026 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300420;
	bh=weKkzB8KZ5DLReewVFSur3h8mJwcAvL7MIgP5XVfu5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T34sPbUbuCvjhVa/1boB4tQMx1D0WIoXAsRglkyXfMv4iy9r9zJAkLZlE5eK+pKu2
	 qs6KAhkUemumL8ipCpAQewhnkppse1akfdg7FgO7gfpV0cPhxkzhpYTv9Z+kU8c6sI
	 PM548MIat9/Erm17cRF2SugbkUjBMCOgHpXoA6R4E3K4zrHeubt5rFzu3FIl7yqqNU
	 NWDxNb2oSO+hfiYgqFWBjlj11HBHHSOtE8SC/bKL6moxe1qIT9XX1xa1OynN9jPH2n
	 lkzOULBqZoI+hGG+8wWz4xrHXKCsDYaZCcjbrRvHjGZlD2Ja/I4VaWSzhTe0N3LwWa
	 1LJy3J1WeZm/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 458/844] net: phy: qcom: qca807x: normalize return value of gpio_get
Date: Sat, 28 Feb 2026 12:26:11 -0500
Message-ID: <20260228173244.1509663-459-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220537-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 9CAC91C827F
X-Rspamd-Action: no action

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 2bb995e6155cb4f254574598cbd6fe1dcc99766a ]

The GPIO get callback is expected to return 0 or 1 (or a negative error
code). Ensure that the value returned by qca807x_gpio_get() is
normalized to the [0, 1] range.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/aZZeyr2ysqqk2GqA@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/qcom/qca807x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 1be8295a95cb5..511cde345e089 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -375,7 +375,7 @@ static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
 	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
 
-	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
+	return !!FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
 }
 
 static int qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
-- 
2.51.0


