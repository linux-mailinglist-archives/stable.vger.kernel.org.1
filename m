Return-Path: <stable+bounces-106486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAD9FE885
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41C43A2614
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9B1537C8;
	Mon, 30 Dec 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/muex+i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09215E8B;
	Mon, 30 Dec 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574147; cv=none; b=HtifiT7rbuIxldSkPiYINnBDCX27DJ49ooQZpIx2BfIee6oqmgrAIea9MiD19g0+XKUv1SpTm72SOyODJazlHPlW+F5/BaBt8X7kWgcVLoYCoyMZBw4HLCOFhdtjUWKtNfWtsuIbuOEpLlSdyqKW+8TiKc0e0Y+fa5UxIs2DUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574147; c=relaxed/simple;
	bh=uttXg/h1RudH6gKhkUk1e9as2r/55OzHTg84CvTO/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwaUSf+w4Mzv1hKK+XJkVsVOsxiwVTArDizeZQh5ce2c8wk7JlcyPUQS0/ooS8BKR60wLnw5hiKLXKG8y+8+zulL3xRPn3wXjUgcwA5CFvkbSkXzfQbUPyp+cDPREN7ukzZOGYv1wI2wr0mwpOJ4rqHWky2jrdgh08u7DyQvXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/muex+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EABC4CED0;
	Mon, 30 Dec 2024 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735574147;
	bh=uttXg/h1RudH6gKhkUk1e9as2r/55OzHTg84CvTO/9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/muex+iYknxKHJKJysNSv0VqvYUmC3u+P3qj0wNhMB9TUCGlxPC8nS2mQP0RI5Oy
	 5H3ihVNOCyVlqkt8gXHJ15PcJOetX278xZtMLSAdzXmW9mYlcDXIoMW6mQFrcRnBPe
	 XZmzL05iurAai3V+lgqsE35jS7ULhc3QDXbb+a/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 049/114] watchdog: mediatek: Add support for MT6735 TOPRGU/WDT
Date: Mon, 30 Dec 2024 16:42:46 +0100
Message-ID: <20241230154219.945542197@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
References: <20241230154218.044787220@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yassine Oudjana <y.oudjana@protonmail.com>

[ Upstream commit 15ddf704f56f8c95ff74dfd1157ed8646b322fa1 ]

Add support for the Top Reset Generation Unit/Watchdog Timer found on
MT6735.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241106104738.195968-3-y.oudjana@protonmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index e2d7a57d6ea2..91d110646e16 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/reset/mt2712-resets.h>
+#include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
@@ -87,6 +88,10 @@ static const struct mtk_wdt_data mt2712_data = {
 	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt6735_data = {
+	.toprgu_sw_rst_num = MT6735_TOPRGU_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt6795_data = {
 	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
 };
@@ -489,6 +494,7 @@ static int mtk_wdt_resume(struct device *dev)
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
 	{ .compatible = "mediatek,mt6589-wdt" },
+	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
-- 
2.39.5




