Return-Path: <stable+bounces-15098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293378383DE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ECA295E36
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2525D657AE;
	Tue, 23 Jan 2024 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJcJO/F/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9805651AD;
	Tue, 23 Jan 2024 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975084; cv=none; b=jRlTDabQ66i90/N0RrcBfhJMBBDvJ0R1x0iaPG2MzSJuzZv0QxQCxJ9030yTK1N+XyNi/R5zFxbaKddD0QNggfKsg8Zag1kwOK1cwqX170+LkbzCP7VIzE0vEEpivoaVBpFxQElRobcWLojhjEwqoWQ8rih0UwyGuQ/5g/Llffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975084; c=relaxed/simple;
	bh=LkxSEO6jE4rvsb7RnFL0a8rcJnxk9nAttYoV0lgTIqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu9dD3ida+xto4bF9LFprPBv2ylgjVa4cpq0uEG2UXUgeoT3Fr7FUfCaMWki1BqcknZTuHg93740jQ61RgyCeZ5JGzE8BkKx94lZ5jnryHwuXTvzJQPNjFmOgBPYK2oqj2BDe06W3deCfWCr7s2pocXkCIiO36RHMvS/jD7rQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJcJO/F/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F435C433A6;
	Tue, 23 Jan 2024 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975084;
	bh=LkxSEO6jE4rvsb7RnFL0a8rcJnxk9nAttYoV0lgTIqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJcJO/F/CIzR+FO9tcfS5diH5AKRqOHwPDsE31tC9TkmOxrMR2QoOOxKdNq14XIYH
	 saeHKRkeLcSkOsm/jF2whf9aK4ZfOShTYR6woGyjegzEiT7/3rNb+eB/j6UbI13wOF
	 +3JHaMIRXCZCMlWBMtwWdzdjd0henUQ1ACLzca6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 231/583] drm/bridge: tpd12s015: Drop buggy __exit annotation for remove function
Date: Mon, 22 Jan 2024 15:54:42 -0800
Message-ID: <20240122235819.058492930@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit ce3e112e7ae854249d8755906acc5f27e1542114 ]

With tpd12s015_remove() marked with __exit this function is discarded
when the driver is compiled as a built-in. The result is that when the
driver unbinds there is no cleanup done which results in resource
leakage or worse.

Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231102165640.3307820-19-u.kleine-koenig@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-tpd12s015.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index e0e015243a60..b588fea12502 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -179,7 +179,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit tpd12s015_remove(struct platform_device *pdev)
+static int tpd12s015_remove(struct platform_device *pdev)
 {
 	struct tpd12s015_device *tpd = platform_get_drvdata(pdev);
 
@@ -197,7 +197,7 @@ MODULE_DEVICE_TABLE(of, tpd12s015_of_match);
 
 static struct platform_driver tpd12s015_driver = {
 	.probe	= tpd12s015_probe,
-	.remove	= __exit_p(tpd12s015_remove),
+	.remove = tpd12s015_remove,
 	.driver	= {
 		.name	= "tpd12s015",
 		.of_match_table = tpd12s015_of_match,
-- 
2.43.0




