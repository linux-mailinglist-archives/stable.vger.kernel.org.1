Return-Path: <stable+bounces-204854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A097CF4D27
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D033076817
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB43313283;
	Mon,  5 Jan 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKbJVRq4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED013090E0
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631693; cv=none; b=jYbjW4Whj2maDkfx6TjhA4zK1wNbdKtXDFtu4xHXveYBu9lp7ZjuVDHtO7WMTGV546hwXg99LFDXVp3yrnzN8lEfFdaANh7ZpsET/IEgamkYpvdz5gVRcAE/jmsAFsl8NdqNZ1+gGE0FJltU2AZQNwzMowO9pd8w91MF3fJ6cME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631693; c=relaxed/simple;
	bh=ZFCdq8SinXq1kAxrR+HK0IifCRib20Ri22/VkUu/guo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xzr+leqls5qyNGA/TepILQriiio/OK9FnwyQlDtTOED+aKGYDedi5Ui0RhJDaDAq2sFSrwnfSvZMkMSrNplMxRKsroG177dxv4IoZxVXE9RJPh+IhTuHrZ8gN/6qrGNWWW/FGisbum4oxs43jU97qj4VwCWI6GvR3jHRFJ5z/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKbJVRq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE2AC19424;
	Mon,  5 Jan 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631692;
	bh=ZFCdq8SinXq1kAxrR+HK0IifCRib20Ri22/VkUu/guo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKbJVRq4Rqi9Em44XsO+G9/Q+3UO8CguPhD2PwNq4/vcCqhL9PiknFDhfg7Vf+AS1
	 eOhCrTdlnHhfjHvY8q1rixz9jr1to/oyjtQTBEuzB9qhwkotnu1Ge6oeyeObY6R7LW
	 SUPzPN6miKaf6doA/271ZZYp/QoB1g9yRtJJXWxT2vgZXm4VW5wUxMC/tVfEKxKx/K
	 jfnsRa6SSSmsQYjq5sN7E8/AobpXYbpEhtjaR9EmY9ob8Q+JO5B48PVyjv9Dz4UFEu
	 SkpF+Si2W3yd5SmlncS69ohGwXYfOl1jRTMjL88kN6AQEhoTN7a41FnqsfuCgne7Us
	 Ow9iFhvXlTSwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] leds: lp50xx: Remove duplicated error reporting in .remove()
Date: Mon,  5 Jan 2026 11:48:07 -0500
Message-ID: <20260105164808.2675734-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105164808.2675734-1-sashal@kernel.org>
References: <2026010519-botanical-suds-31fa@gregkh>
 <20260105164808.2675734-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 73bce575ed90c752eaa4b2b9a70860481d58d240 ]

Returning an error value from an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference. The device goes away anyhow and the devm cleanups are
called.

As stk3310_set_state() already emits an error message on failure and the
additional error message by the i2c core doesn't add any useful
information, don't pass the error value up the stack. Instead continue
to clean up and return 0.

This patch is a preparation for making i2c remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: 434959618c47 ("leds: leds-lp50xx: Enable chip before any communication")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp50xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 35ab4e259897..479f24d3bb9d 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -584,10 +584,8 @@ static int lp50xx_remove(struct i2c_client *client)
 	int ret;
 
 	ret = lp50xx_enable_disable(led, 0);
-	if (ret) {
+	if (ret)
 		dev_err(led->dev, "Failed to disable chip\n");
-		return ret;
-	}
 
 	if (led->regulator) {
 		ret = regulator_disable(led->regulator);
-- 
2.51.0


