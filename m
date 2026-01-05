Return-Path: <stable+bounces-204817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185BCF448C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8D73167590
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93D1A3160;
	Mon,  5 Jan 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbcGidXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C317B50F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624697; cv=none; b=uHZJeQhxC/1h1S0lneCEDTrxnOJwtR3U/9sbad2cs41E91AqxBEwiuaVpXqobgeIKM1D0A6vRDI4adDg8CsweTAmeybNQS/VBjV4OG+389YNH5R7PhkI57dE/L+XMOPg9L7leEb+c6VWbwJpsZOPuy15mi3bng6gp+UIETAEIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624697; c=relaxed/simple;
	bh=YvkIuhpGtmoUQGjVt4jnC4lYxZmQUgYziVmsQWHF2Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyrEnrz53TbwIDTphzvVCYFrurZJj8G9ur2bTgIHZaMK3DPExLFSAEG7+XQIl3seNkY88SLTqjLVaBnzmfnb1b0D4emKbjr7con439KaUtniOkPniVSQsKnrsgRHdceP6DZylsuj6xSO99pb5Q3pptdjhtv1JgtLRuRH3LNodug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbcGidXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8888C116D0;
	Mon,  5 Jan 2026 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624697;
	bh=YvkIuhpGtmoUQGjVt4jnC4lYxZmQUgYziVmsQWHF2Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbcGidXpEgdW9J8RulT1L4VHqO57S/9osT2ln+c2gwVRAaWXO1HbHL+SPzZbv1RCO
	 Kw2lXpv+f4YeWsdd8JSyltew5ZSFuFmgWdyYQ0oNMUucPyUoYXK3aNn5ZI/CztMX5p
	 V38CUw/VRdrEHrCu2Sfbh8G2HsBKxcfh2R+PV+ZLOdYREHNncxM/YhkLDoIsnAaUHq
	 giBlzpppiT8YLcsziQQc8LfT5Uca4edddAXbQZs0I2OO7YigAkmKg8apK1+06vdnVP
	 iuwILwR8qojfBDyJjbIyDa9LEtnnCgB4OdDaCKADSUeEbJ8SpX3f66/2XMc1SeO3SZ
	 hvvpW/AqZyg2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Takashi Iwai <tiwai@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] ASoC: stm: stm32_sai_sub: Convert to platform remove callback returning void
Date: Mon,  5 Jan 2026 09:51:31 -0500
Message-ID: <20260105145135.2613585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010551-divinity-dislodge-aca5@gregkh>
References: <2026010551-divinity-dislodge-aca5@gregkh>
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
index 0629aa5f2fe4..935e0dc05689 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1559,7 +1559,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stm32_sai_sub_remove(struct platform_device *pdev)
+static void stm32_sai_sub_remove(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(&pdev->dev);
 
@@ -1567,8 +1567,6 @@ static int stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1618,7 +1616,7 @@ static struct platform_driver stm32_sai_sub_driver = {
 		.pm = &stm32_sai_sub_pm_ops,
 	},
 	.probe = stm32_sai_sub_probe,
-	.remove = stm32_sai_sub_remove,
+	.remove_new = stm32_sai_sub_remove,
 };
 
 module_platform_driver(stm32_sai_sub_driver);
-- 
2.51.0


