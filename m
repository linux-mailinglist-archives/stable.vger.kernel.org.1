Return-Path: <stable+bounces-137550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43479AA13CF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377B916DBDE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB7923C8D6;
	Tue, 29 Apr 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xro++UsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AF211A0B;
	Tue, 29 Apr 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946403; cv=none; b=fpLu6wTY0fHX4NAmrqoiTCVyrP6xNcf+OrVSAjK9SYVM9mK8AuvFCWL3xTddH1Ug+ipA3/cMUpy/Ju8scAVcwtTFi2bTnHdB/eQqLUelr3y1xp8QHOD4IcQJ/+WksGvCMHEsxIjiL41PzuzSy4OS/F3AP4362lEKVriJG/r2f+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946403; c=relaxed/simple;
	bh=6pTgEBWSv07B/w52ryHWKQRKN8TKUW8iOocALmohR0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euCPr944QImlURcfTKo4av/M7dUzikP3yfQusFCTm1BR30eGyINFXdAxL9Qo0tVJAk23DZQIOI0bN/ezgW0aG954WD9VY9DUmD/zbFtjn5+1NM+K1Y9GZ5ar57xexTUgcwBwJQOszBMqyYfbXzFtA2KQBhx4ffZ8d4hxR3lWB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xro++UsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E62DC4CEE3;
	Tue, 29 Apr 2025 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946403;
	bh=6pTgEBWSv07B/w52ryHWKQRKN8TKUW8iOocALmohR0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xro++UsMfa2EDEcqWKoXtKgRvtoNfEG9Beh59kCMppo3Hk5YnyWDYhoTfLhIt/f+l
	 uAWOLSYvdeJwijd1GcnSVkoRIAJKvd/1AXtiec2gkgsAxUWNdJmT+lFhhLl+XI4Bae
	 FfObubn+5VHaxi8qcnyY5uqHuiNsNK1xzJuhoQxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 256/311] gpiolib: of: Move Atmel HSMCI quirk up out of the regulator comment
Date: Tue, 29 Apr 2025 18:41:33 +0200
Message-ID: <20250429161131.508515512@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b8c7a1ac884cc267d1031f8de07f1a689a69fbab ]

The regulator comment in of_gpio_set_polarity_by_property()
made on top of a couple of the cases, while Atmel HSMCI quirk
is not related to that. Make it clear by moving Atmel HSMCI
quirk up out of the scope of the regulator comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250402122058.1517393-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 176e9142fd8f8..56f13e4fa3614 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -259,6 +259,9 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 		{ "fsl,imx8qm-fec",  "phy-reset-gpios", "phy-reset-active-high" },
 		{ "fsl,s32v234-fec", "phy-reset-gpios", "phy-reset-active-high" },
 #endif
+#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
+		{ "atmel,hsmci",       "cd-gpios",     "cd-inverted" },
+#endif
 #if IS_ENABLED(CONFIG_PCI_IMX6)
 		{ "fsl,imx6q-pcie",  "reset-gpio", "reset-gpio-active-high" },
 		{ "fsl,imx6sx-pcie", "reset-gpio", "reset-gpio-active-high" },
@@ -284,9 +287,6 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 #if IS_ENABLED(CONFIG_REGULATOR_GPIO)
 		{ "regulator-gpio",    "enable-gpio",  "enable-active-high" },
 		{ "regulator-gpio",    "enable-gpios", "enable-active-high" },
-#endif
-#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
-		{ "atmel,hsmci",       "cd-gpios",     "cd-inverted" },
 #endif
 	};
 	unsigned int i;
-- 
2.39.5




