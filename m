Return-Path: <stable+bounces-185559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA08BD6DC6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356F04063E2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227242C324F;
	Tue, 14 Oct 2025 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoKTJB2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D3218821
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401202; cv=none; b=ptO8IML/tcmG0FtzWcodmjfdj4u/92s6hwAsuBIyrMEe48JuL0QE4D3w+FLdRjcWJ/EvxgV630XCDlJLBx3Y5Dcrt0tGV6a3Odn7swKVf+4kdo8WoXBmUfBoJpBY2FzHzxOybRhEMm3trHymYe1WeGUESP7dOKZzbNd3Lem9Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401202; c=relaxed/simple;
	bh=kkeO3cevuyV78fmnY3yyIk9+JKidFaXixgFoZjzu60s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Na1h5WOzsgrPPcsylwRpDeEzUSOwHkJMMd3g8XqdgfxD2TGVX8kzlfa++OZL3uJg0LLwvzZCxvxqtspMH5A1P6yqoNaSKkSt5dKLmUpZ7BALHpKoJwfspb6qXSVYqWhBK+bU4LxmsdHjCIbAtkxb+dLJ1r43r54BHohDJ5ELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoKTJB2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA43C4CEE7;
	Tue, 14 Oct 2025 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401202;
	bh=kkeO3cevuyV78fmnY3yyIk9+JKidFaXixgFoZjzu60s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoKTJB2zqXJfcxXK/xtWLr/PalFba6qhJvkCljei5izcg8Y/9UYKYC4i+bWQNBmEK
	 zeJwuQfLknf2tvAh1f8+lQ0plqY8rGLwlIaCszisOqYy8dmixAYjymrAhiEoybsFCg
	 OdXPWnf5idEaWCVo8+lMbHIhvH3W/K8+BBwP/KY75ZlzHnxJBJO4sQuo/FNmGBoCL2
	 ndQQHAtO+6lkGJ46hOGBrdvndbmoz4zfWxxFGWCK0Rnfp0epRIB/Jj8G/UD4/Rv6lg
	 JhTaogU03AQxyJxN5hK3VJDlLweCrlhuAr/gejvDCsBrGRBAvhRZB5lzDtfXoInlDr
	 7rncD2YoqltOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
Date: Mon, 13 Oct 2025 20:20:00 -0400
Message-ID: <20251014002000.3750354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101336-abrasion-hatchling-01bc@gregkh>
References: <2025101336-abrasion-hatchling-01bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 1efbee6852f1ff698a9981bd731308dd027189fb ]

Commit 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
removed the return value check from the call to gpiochip_add_data() (or
rather gpiochip_add() back then and later converted to devres) with no
explanation. This function however can still fail, so check the return
value and bail-out if it does.

Cc: stable@vger.kernel.org
Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
[ Use non-devm variants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/vexpress-sysreg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index c68ff56dbdb12..1463cf43687df 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -160,6 +160,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	struct gpio_chip *mmc_gpio_chip;
 	int master;
 	u32 dt_hbi;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
@@ -195,7 +196,10 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	gpiochip_add_data(mmc_gpio_chip, NULL);
+
+	ret = gpiochip_add_data(mmc_gpio_chip, NULL);
+	if (ret)
+		return ret;
 
 	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,
-- 
2.51.0


