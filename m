Return-Path: <stable+bounces-204830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B737FCF4576
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10440315E075
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85AE17BCA;
	Mon,  5 Jan 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbP0Kc4K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A053093D8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625837; cv=none; b=pYSp9//T99PkWjrv0QuK4GmpLKbaPM2un5gJFfBazI1gNSIQKj0Py+EmMBlIZbirCWR25n9KsBgCymMxxwGyc9vLzNDYcZWUYPvs5znA5VPsJolk4811Pilsghy9fNwVapR3ESU0oBr+9ck/cjhr5f0yvmU8yn/n079ud6gVx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625837; c=relaxed/simple;
	bh=vd6QhEsGWmoWVC6gUHpxnoaYITOXh5jEoqxRUa0CBL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/QhVqHFPG3quRVS6J1X4RJmKD6P3YHNt4yoAlbi4lBWsEK78XDNCzqv90f3ojNNCVNxTjFb5aUbGJmCvcBmqE0+xLQ1YrAroyYMsrDMTvE5yQwy1Ox+nQE23mF8hdOe7VXDHYpyxk9iqdKyDk0gfb3zsgFcRPtQZQOq/QZ97q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbP0Kc4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631B3C19422;
	Mon,  5 Jan 2026 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625837;
	bh=vd6QhEsGWmoWVC6gUHpxnoaYITOXh5jEoqxRUa0CBL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbP0Kc4K/hxjbDzB1b9O8JY5OTyJH+vhggKGXHsFea1mTLEPagk0kHlwm5B3YRR1y
	 bEa+IbO7+9CtwqkW5lAiq+Dknw2es9H/kCGV8KEFOKKmmu2DB3YTyk3uABLgPWi04N
	 M2RxqpFISV6jyL0NQtT1KNeH+ocpwJZszuOH14Tsu9OvdEnCYmpsvwUlAeHN2ueyBn
	 fVVnnr20scBT3ehYY+e64hX1AZrUEL6Uv1B0eIM5HHgH1peiqVML3cup20Y/UuaF+N
	 ZKf5F6hzg9sn77PVuJ2cN+epeehH76kg3omwPgKBtqHDX5Tb1f4BMvxuxN1rjhaCiE
	 /nmGdM8+nRxJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Takashi Iwai <tiwai@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] ASoC: stm: stm32_sai_sub: Convert to platform remove callback returning void
Date: Mon,  5 Jan 2026 10:10:29 -0500
Message-ID: <20260105151034.2625317-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105151034.2625317-1-sashal@kernel.org>
References: <2026010551-backpedal-chatroom-a9c7@gregkh>
 <20260105151034.2625317-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a3bd37e2e2bce4fb1757a940fa985d556662ba80 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20230315150745.67084-139-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 23261f0de094 ("ASoC: stm32: sai: fix OF node leak on probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 0db307cdb825..d179400b9b09 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1560,7 +1560,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stm32_sai_sub_remove(struct platform_device *pdev)
+static void stm32_sai_sub_remove(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(&pdev->dev);
 
@@ -1568,8 +1568,6 @@ static int stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1619,7 +1617,7 @@ static struct platform_driver stm32_sai_sub_driver = {
 		.pm = &stm32_sai_sub_pm_ops,
 	},
 	.probe = stm32_sai_sub_probe,
-	.remove = stm32_sai_sub_remove,
+	.remove_new = stm32_sai_sub_remove,
 };
 
 module_platform_driver(stm32_sai_sub_driver);
-- 
2.51.0


