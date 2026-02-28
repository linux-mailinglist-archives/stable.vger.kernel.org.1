Return-Path: <stable+bounces-220295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNdvC0Ewo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F61C58D4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9884932C1C34
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8C388EB7;
	Sat, 28 Feb 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj73Vq80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002FA388EAF;
	Sat, 28 Feb 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300199; cv=none; b=sr+fVsz0NnYi2FIZu44XMd5SFqYPrBmnFMql+USBsPJzrquuu+XS+pge0KAzDfQVaZYPRSYMx4t64B7InY3ktzppBPH3xvJY+8+OscNZiEhL6D3f7wM4u0EjF6mEtTTfgm1CPYIqgcbLw0W0lt/oHhE1ohMDpRCS4QwKCD/gGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300199; c=relaxed/simple;
	bh=PydTwEqeCbZg9HU66Qfhd+8E0cz2J+FcRHJw4mffmPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9Vs8c4/h7L7+ihvUuj/BUyBCogJASpAs38m3uQBz7uHKT33I+NrDxa2OmIS3hwkCXj+O6eZcpXK/ZdYDsVusck1LPXNTdTNVSw3fj4kfHGsPfUcoepV1/3ftP6FiJh5QyhYzsJcG8aaBwdJ56ODiIJ8y3t0oXwBY3BRFpyYclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj73Vq80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37132C19424;
	Sat, 28 Feb 2026 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300198;
	bh=PydTwEqeCbZg9HU66Qfhd+8E0cz2J+FcRHJw4mffmPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uj73Vq80Ln9lV6CbxcCvT3ss8eMFzEv27pUlM373mUfSQiNIx4iE9uANSlkplZPPk
	 VM/sVlrnVJk1B6qGcLcE579Z7jVi8X7JBlZe/uiqj8iWBCTXZrBoEhCm5cJO84p1o7
	 8dYqNI71SdTQKxiOoKxM5DD196JvL8AxjQ9toHdyTNWZybtEhDcdvXh/btNIPSALoa
	 J8gOStHavylnpF6n3nqdE+XnY6OB9ti/mSN2Uk0Lqtn42VdgFddeVq2D/0JFxsKqwP
	 mzM/7ZtWW5i6TpBKeaTlHxZEnuRFpVoS9/SIxgG1eW3E6mBsaatRPGUO19ADw2sb6t
	 EcPrZJNn8qxmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 217/844] gpio: aspeed-sgpio: Change the macro to support deferred probe
Date: Sat, 28 Feb 2026 12:22:10 -0500
Message-ID: <20260228173244.1509663-218-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220295-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A6F61C58D4
X-Rspamd-Action: no action

From: Billy Tsai <billy_tsai@aspeedtech.com>

[ Upstream commit e18533b023ec7a33488bcf33140ce69bbba2894f ]

Use module_platform_driver() to replace module_platform_driver_probe().
The former utilizes platform_driver_register(), which allows the driver to
defer probing when it doesn't acquire the necessary resources due to probe
order. In contrast, the latter uses __platform_driver_probe(), which
includes the comment "Note that this is incompatible with deferred
probing." Since our SGPIO driver requires access to the clock resource, the
former is more suitable.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Link: https://lore.kernel.org/r/20260123-upstream_sgpio-v2-1-69cfd1631400@aspeedtech.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 7622f9e9f54af..318cd0e397416 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -516,7 +516,7 @@ static const struct of_device_id aspeed_sgpio_of_table[] = {
 
 MODULE_DEVICE_TABLE(of, aspeed_sgpio_of_table);
 
-static int __init aspeed_sgpio_probe(struct platform_device *pdev)
+static int aspeed_sgpio_probe(struct platform_device *pdev)
 {
 	u32 nr_gpios, sgpio_freq, sgpio_clk_div, gpio_cnt_regval, pin_mask;
 	const struct aspeed_sgpio_pdata *pdata;
@@ -611,11 +611,12 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver aspeed_sgpio_driver = {
+	.probe = aspeed_sgpio_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = aspeed_sgpio_of_table,
 	},
 };
 
-module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
+module_platform_driver(aspeed_sgpio_driver);
 MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");
-- 
2.51.0


