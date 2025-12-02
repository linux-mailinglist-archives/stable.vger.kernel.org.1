Return-Path: <stable+bounces-198022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F80C99A9F
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1134E1830
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFCB1684B0;
	Tue,  2 Dec 2025 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK3zumrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D722097
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636058; cv=none; b=rmz9uUJhg2LUjJXRd0InG5YtQJ2LHTjxmhLJbE8wG5T6p5zYX0qJryyQsxiYlpzIA7hNJJZYDp1mEuZw7ysS7QlIVCEakwqJuzKCHUb031kkjNml38ny3xWRWpjHQYGsDChK1Xwmcj4YdIoN9+rVvHID+wmg7nrtKVnXkHRx8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636058; c=relaxed/simple;
	bh=D/fKfqbwqRqpK6lhmxxjWxxAUmwh3kW0PcYLM5EDxlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4gx1mCJyU2NqqKl/elErBPKSMXzjU0S6nLCT86vhXaxwXIdDA/ITJ8WxVxp7dJlUfQe4TJK44RL0cIoo/kjosYxwgtHRcDf+/LF7wADIWvyhXiVQ0iZti0dj6ZwcyaYXHQybECNzwbxuqP5Bolk9whgLs9/CTHBQMjdBiZ2fME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK3zumrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6522C4CEF1;
	Tue,  2 Dec 2025 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764636057;
	bh=D/fKfqbwqRqpK6lhmxxjWxxAUmwh3kW0PcYLM5EDxlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK3zumrIStWeNRmepgZSCAdUtTuyghfdVt+VcmGnubCrc6cNDG63rfdc9DPtCUhlQ
	 AYqhjo6oRMzalrDhGJqA6VAPg/2+F4CdKoK46hDHCdbbwMxEsQAbqzd6iaezTqbHhT
	 0F+SORjJC2zZvA3BkN1WH1SabAq/ziYHLmveqnjwFZ2AjWfuCbTdmj4OIAg++WiL5b
	 6QW97Oam5CNrxXB0cWu2A/7IWHBa/ye1U4DJ/a473l83/jTPyhHsaKBIaudd1LX/L6
	 hTNPEtxnoz2fnh7BlOkqOARaRgHBMcc+yuiEq9ffMtluM2MAAYMH8svX9uLDKQK8PA
	 TT/C4y3PkOQow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: renesas_usbhs: Convert to platform remove callback returning void
Date: Mon,  1 Dec 2025 19:40:53 -0500
Message-ID: <20251202004054.1515959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120128-dawn-glowworm-efba@gregkh>
References: <2025120128-dawn-glowworm-efba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 456a91ce7de4b9157fd5013c1e4dd8dd3c6daccb ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20230517230239.187727-89-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eb9ac779830b ("usb: renesas_usbhs: Fix synchronous external abort on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 23d160ef4cd22..0ad38b63bb924 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -794,7 +794,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int usbhs_remove(struct platform_device *pdev)
+static void usbhs_remove(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
@@ -814,8 +814,6 @@ static int usbhs_remove(struct platform_device *pdev)
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
-
-	return 0;
 }
 
 static __maybe_unused int usbhsc_suspend(struct device *dev)
@@ -860,7 +858,7 @@ static struct platform_driver renesas_usbhs_driver = {
 		.of_match_table = of_match_ptr(usbhs_of_match),
 	},
 	.probe		= usbhs_probe,
-	.remove		= usbhs_remove,
+	.remove_new	= usbhs_remove,
 };
 
 module_platform_driver(renesas_usbhs_driver);
-- 
2.51.0


