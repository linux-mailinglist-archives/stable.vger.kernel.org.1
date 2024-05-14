Return-Path: <stable+bounces-43868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E48C4FF8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C721C2127C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFD7548EF;
	Tue, 14 May 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gbg44f2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69E53368;
	Tue, 14 May 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682775; cv=none; b=UAK5QP/7xTafgjxHEFUvtvg+RP+hr+C/QRPPw1ln+433n6uyWSvNq/P2i9G0WlSXWjiiZK2dJaPq0nL4uWX7YpNW2h/9fhEW82Jh0DbedkguZF0Nrxp/UPLCbAnLQ8S7kirRJZ+7llY19z4L9O1h/LDk4QFysurqxsCeK8I24R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682775; c=relaxed/simple;
	bh=0rmpYa4QCn9F61mvWwLqDEDswzo2poh5yW1PL9x8iN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkXcAsRQzQOdxxlqm+6d2D6WUm58r/TuuTtkJprmG5HN6ciZpgCcMF6Frn7um9MM9p7Vj6eNQXYYmaJtLKA0j3L1kNryE926Lka4rmqIo41OvCYY5CEA/iLvOU3nx1J8pb647hqZuAd+yWPW+oCoVK3FmrrUVBBSB9mwljEqpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gbg44f2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6970FC2BD10;
	Tue, 14 May 2024 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682774;
	bh=0rmpYa4QCn9F61mvWwLqDEDswzo2poh5yW1PL9x8iN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gbg44f2BqFSfXxvfUIpU5sxLJArKGssw/c/JB6Pt62Ue+fLUeAl/Wpzd27zj18Ybg
	 KRrrCwJSZwKTotVpd8o3AZZH8X5RpkTCIJrgLLjju7VaHp726mrv1zFHtg80ia0+Q5
	 AgvM+1YAe2Klad3CrN9xRKyAzcaHwGVCLyJac5vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 081/336] drm/panel: ili9341: Respect deferred probe
Date: Tue, 14 May 2024 12:14:45 +0200
Message-ID: <20240514101041.663904325@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 740fc1e0509be3f7e2207e89125b06119ed62943 ]

GPIO controller might not be available when driver is being probed.
There are plenty of reasons why, one of which is deferred probe.

Since GPIOs are optional, return any error code we got to the upper
layer, including deferred probe. With that in mind, use dev_err_probe()
in order to avoid spamming the logs.

Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Link: https://lore.kernel.org/r/20240425142706.2440113-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240425142706.2440113-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 7584ddb0e4416..24c74c56e5648 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -715,11 +715,11 @@ static int ili9341_probe(struct spi_device *spi)
 
 	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset))
-		dev_err(dev, "Failed to get gpio 'reset'\n");
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get gpio 'reset'\n");
 
 	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
 	if (IS_ERR(dc))
-		dev_err(dev, "Failed to get gpio 'dc'\n");
+		return dev_err_probe(dev, PTR_ERR(dc), "Failed to get gpio 'dc'\n");
 
 	if (!strcmp(id->name, "sf-tc240t-9370-t"))
 		return ili9341_dpi_probe(spi, dc, reset);
-- 
2.43.0




