Return-Path: <stable+bounces-122112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EAA59E09
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C76F3A9256
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E4233714;
	Mon, 10 Mar 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnK5Wy5y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CC2309B6;
	Mon, 10 Mar 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627561; cv=none; b=JFB1Yl/vgiRLr8+109or1FURKlIjmBe11TUjnqoF63qDlx8CO5B6eVCYH/2CQIQTWS8z6jDAXNuqHgnkFN9ZB7EdMfLWohuuBalK71jvZsZ+rp+jyydH0TREZC0CYmG3FU0dzQbGyhnc9Xvw8veeJcuuBx8Si+xDwRJ6wlyJdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627561; c=relaxed/simple;
	bh=MhnRrX0G/7AfNiTEF7CZOMLdJId535laZwx0xBN71Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrLq2EZUr/xoVZJktQ0uxSgae70BNBEy5hVJqUzA64wX0I5tHpM51Q1z2LbOtQWt6lrkYHy7l3L2GGN1isA7ImcZHkNphJDwApawLO2JqqhSQngFqMt393V5EgyFNL1b4vPQ36a2G8oEZKKLvKGcnABQvp34TCimnsCUf4GXglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnK5Wy5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FAC4CEE5;
	Mon, 10 Mar 2025 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627560;
	bh=MhnRrX0G/7AfNiTEF7CZOMLdJId535laZwx0xBN71Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnK5Wy5yBvnq4i8CMKOUKw1nv1s477JvdN0H7fqWOlwDn4mweQZXutU5FgCknj/gD
	 noYwFRhl7ZKiGKXUeSBwiJf4OAgJt7wJU3mYRtogB5pkabJO8JhcXfCyQQAZon15ys
	 w7X2TU5K1ovX5tLFJIgL8F/iKt9YMx4vn+45gX4Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maud Spierings <maudspierings@gocontroll.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 171/269] hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table
Date: Mon, 10 Mar 2025 18:05:24 +0100
Message-ID: <20250310170504.532727867@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

From: Maud Spierings <maudspierings@gocontroll.com>

[ Upstream commit 1c7932d5ae0f5c22fa52ac811b4c427bbca5aff5 ]

I could not find a single table that has the values currently present in
the table, change it to the actual values that can be found in [1]/[2]
and [3] (page 15 column 2)

[1]: https://www.murata.com/products/productdetail?partno=NCP15XH103F03RC
[2]: https://www.murata.com/products/productdata/8796836626462/NTHCG83.txt?1437969843000
[3]: https://nl.mouser.com/datasheet/2/281/r44e-522712.pdf

Fixes: 54ce3a0d8011 ("hwmon: (ntc_thermistor) Add support for ncpXXxh103")
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
Link: https://lore.kernel.org/r/20250227-ntc_thermistor_fixes-v1-3-70fa73200b52@gocontroll.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ntc_thermistor.c | 66 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index b5352900463fb..0d29c8f97ba7c 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -181,40 +181,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*
-- 
2.39.5




