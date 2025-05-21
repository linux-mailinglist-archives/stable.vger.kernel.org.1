Return-Path: <stable+bounces-145823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28750ABF432
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08BA3AA059
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D538264617;
	Wed, 21 May 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPFy22eg"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07B263F3C
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829797; cv=none; b=pEul10BnA5dMfKYci94p+1F73pCYEn9eUEb5B98Y3U43h2KO4px8B6zOhgst1+suc1rtmLxYhV2VhMGh11qOp98yd7GRAEVIl8JIBYYzGq4x3uFb5xSili0/0WaGyxNIaiF6ZHkSuGZyQNkr+spk3h5ia/XgtpgdzUkmL13+JtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829797; c=relaxed/simple;
	bh=5YAQwootf32k9eywPVN35I4zbS/eK1uH6YHeq6kCQ38=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=NYTnfFv/00gtGsAU33RTF50tTHf6T6HnG9i264sPqNCXI0du+RhOzbtFqflwqPs4TCr6nHJfJ+UgKEHfzeU6SOlWf1t/EuL5tz3Hg/SWdrijgeiGgPJnev2y/sJu7UxbV8/QctkS/+5mi8Aw6AoKlvaQDtActM19ltQczs6+0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPFy22eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87266C4CEE4;
	Wed, 21 May 2025 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829796;
	bh=5YAQwootf32k9eywPVN35I4zbS/eK1uH6YHeq6kCQ38=;
	h=Subject:To:From:Date:From;
	b=rPFy22egP2JC4L8S0Txjk+KJkfp6WMA0nZVLYK2Cex6uN7aIrE9/fRNP1NMyf9Ir0
	 yvQkQKinKbXbIrsSUmYqVjWnhczv8TNZXeJiNT9XZi1DeodBqdEDB0fZ6UAPA0bsrF
	 YSABN7jiv+IPLdQh4cagvldYSnoynDuZimqaxT1s=
Subject: patch "iio: adc: ad7173: fix compiling without gpiolib" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,lkp@intel.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:16:09 +0200
Message-ID: <2025052109-mushroom-grandpa-be9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix compiling without gpiolib

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c553aa1b03719400a30d9387477190d4743fc1de Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 15:12:27 -0500
Subject: iio: adc: ad7173: fix compiling without gpiolib

Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
selecting GPIOLIB to be always enabled and remove the #if.

Commit 031bdc8aee01 ("iio: adc: ad7173: add calibration support") placed
unrelated code in the middle of the #if IS_ENABLED(CONFIG_GPIOLIB) block
which caused the reported compile error.

However, later commit 7530ed2aaa3f ("iio: adc: ad7173: add openwire
detection support for single conversions") makes use of the gpio regmap
even when we aren't providing gpio controller support. So it makes more
sense to always enable GPIOLIB rather than trying to make it optional.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504220824.HVrTVov1-lkp@intel.com/
Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig  |  5 +++--
 drivers/iio/adc/ad7173.c | 15 +--------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6529df1a498c..ba746754a816 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -129,8 +129,9 @@ config AD7173
 	tristate "Analog Devices AD7173 driver"
 	depends on SPI_MASTER
 	select AD_SIGMA_DELTA
-	select GPIO_REGMAP if GPIOLIB
-	select REGMAP_SPI if GPIOLIB
+	select GPIOLIB
+	select GPIO_REGMAP
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD7173 and similar ADC
 	  Currently supported models:
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 69de5886474c..b3e6bd2a55d7 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -230,10 +230,8 @@ struct ad7173_state {
 	unsigned long long *config_cnts;
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
-#if IS_ENABLED(CONFIG_GPIOLIB)
 	struct regmap *reg_gpiocon_regmap;
 	struct gpio_regmap *gpio_regmap;
-#endif
 };
 
 static unsigned int ad4115_sinc5_data_rates[] = {
@@ -288,8 +286,6 @@ static const char *const ad7173_clk_sel[] = {
 	"ext-clk", "xtal"
 };
 
-#if IS_ENABLED(CONFIG_GPIOLIB)
-
 static const struct regmap_range ad7173_range_gpio[] = {
 	regmap_reg_range(AD7173_REG_GPIO, AD7173_REG_GPIO),
 };
@@ -543,12 +539,6 @@ static int ad7173_gpio_init(struct ad7173_state *st)
 
 	return 0;
 }
-#else
-static int ad7173_gpio_init(struct ad7173_state *st)
-{
-	return 0;
-}
-#endif /* CONFIG_GPIOLIB */
 
 static struct ad7173_state *ad_sigma_delta_to_ad7173(struct ad_sigma_delta *sd)
 {
@@ -1797,10 +1787,7 @@ static int ad7173_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_GPIOLIB))
-		return ad7173_gpio_init(st);
-
-	return 0;
+	return ad7173_gpio_init(st);
 }
 
 static const struct of_device_id ad7173_of_match[] = {
-- 
2.49.0



